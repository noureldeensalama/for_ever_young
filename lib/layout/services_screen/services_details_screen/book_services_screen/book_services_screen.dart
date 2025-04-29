import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:for_ever_young/layout/for_ever_young_layout.dart';
import 'package:for_ever_young/shared/colors_and_themes/color.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

import '../../../settings_screen/contactUs_screen/contactUs_screen.dart' show ContactUsScreen;

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  late final WebViewController controller;
  bool isLoading = true;
  bool _showWebView = false;
  int bookingProgress = 0;
  Timer? progressTimer;
  String currentUrl = '';
  DateTime? _selectedDate;
  bool _dateSelectionStarted = false;
  bool isFinalPage = false;

  // Calendar feature variables
  bool _showCalendarCard = false;
  bool _calendarEventAdded = false;
  String? _calendarError;
  DateTime? _selectedTime;

  // Auto-reload variables
  bool _hasError = false;
  int _reloadAttempts = 0;
  static const int _maxReloadAttempts = 3;
  Timer? _globalTimeoutTimer;

  @override
  void initState() {
    super.initState();
    _initializeWebViewController();
    _startProgressTracking();

    // To fix the wait at the start of the app
    Future.delayed(const Duration(seconds: 10), () {
      if (mounted) {
        setState(() {
          _showWebView = true;
        });
      }
    });
  }

  void _startTimeout() {
    _cancelTimeout();
    _globalTimeoutTimer = Timer(const Duration(seconds: 20), () {
      if (mounted && isLoading) {
        setState(() {
          isLoading = false;
          _hasError = true;
          _showWebView = false;
        });
      }
    });
  }

  void _cancelTimeout() {
    if (_globalTimeoutTimer?.isActive ?? false) {
      _globalTimeoutTimer?.cancel();
    }
  }

  Future<void> _initializeWebViewController() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      if (mounted) {
        setState(() {
          _hasError = true;
        });
      }
      return;
    }

    controller = WebViewController()
      ..enableZoom(false)
      ..setBackgroundColor(Colors.white)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel('NavigateToHome',
          onMessageReceived: (message) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => ForEverYoungLayout())
            );
            }
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            if (request.url.startsWith('http') &&
                !request.url.contains('web2.myaestheticspro.com')) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => ForEverYoungLayout())
              );
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onPageStarted: (url) {
            setState(() {
              isLoading = true;
              currentUrl = url;
              _dateSelectionStarted = false;
              _selectedDate = null;
              if (!url.contains('confirmation') && !url.contains('time') && !url.contains('service')) {
                bookingProgress = 0;
              }
            });
          },
          onPageFinished: (String url) async {
            await _cleanPage();
            Future.delayed(const Duration(seconds: 10), () {
              if (!mounted) return;
              setState(() {
                _showWebView = true;
                isLoading = false;
                _hasError = false;
                _reloadAttempts = 0;
                isFinalPage = url.contains('confirmation') ||
                    url.contains('thankyou') ||
                    url.contains('complete');

                if (isFinalPage && _selectedDate != null && _selectedTime != null) {
                  _showCalendarCard = true;
                }
              });
            });
          },
          onWebResourceError: (error) {
            _handleWebViewError(error);
          },
        ),
      )
      ..loadRequest(Uri.parse('https://web2.myaestheticspro.com/BN/index.cfm?05CAA878344543800DCCE4E5C183FD59'));
  }

  void _handleWebViewError(WebResourceError error) {
    if (!mounted) return;

    setState(() {
      isLoading = false;
      _hasError = true;
    });

    if (_reloadAttempts < _maxReloadAttempts) {
      _reloadAttempts++;
      Future.delayed(const Duration(seconds: 5), () {
        if (!mounted) return;
        setState(() {
          _showWebView = true;
        });

        Future.delayed(const Duration(seconds: 15), () {
          if (isLoading && mounted) {
            setState(() {
              _hasError = true;
            });
          }
        });
      });
    }
  }

  @override
  void dispose() {
    _cancelTimeout();
    progressTimer?.cancel();
    super.dispose();
  }

  Future<void> _addToCalendar() async {
    if (_selectedDate == null || _selectedTime == null) {
      setState(() => _calendarError = 'Appointment time not available');
      return;
    }

    try {
      final startDateTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );

      final endDateTime = startDateTime.add(const Duration(hours: 1));
      // Implement actual calendar integration here
      setState(() {
        _calendarEventAdded = true;
        _showCalendarCard = false;
      });
    } catch (e) {
      setState(() => _calendarError = 'Error: ${e.toString()}');
      if (kDebugMode) {
        print('Calendar Error: $e');
      }
    }
  }

  Future<void> _checkForDateSelection() async {
    if (!_dateSelectionStarted) return;

    try {
      final dateResult = await controller.runJavaScriptReturningResult('''
      (function() {
        try {
          const input = document.querySelector('input[name="ApptDate"]');
          return input?.value || '';
        } catch(e) {
          return '';
        }
      })();
    ''');

      final dateString = dateResult.toString();
      if (dateString.isNotEmpty) {
        final parts = dateString.split('/');
        if (parts.length == 3) {
          final newDate = DateTime(
            int.parse(parts[2]),
            int.parse(parts[0]),
            int.parse(parts[1]),
          );

          if (_selectedDate == null || !_selectedDate!.isAtSameMomentAs(newDate)) {
            setState(() {
              _selectedDate = newDate;
            });
            if (kDebugMode) {
              print('User selected date: $_selectedDate');
            }
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error checking date: $e');
      }
    }
  }

  Future<void> _checkForSelectedTime() async {
    try {
      final timeResult = await controller.runJavaScriptReturningResult('''
      (function() {
        try {
          const dropdown = document.getElementById('mApptTimeSelect');
          const hiddenField = document.getElementById('bn_ApptTime');
          if (hiddenField && hiddenField.value) {
            return hiddenField.value;
          }
          if (dropdown && dropdown.value) {
            return dropdown.value;
          }
          return '';
        } catch(e) {
          return '';
        }
      })();
    ''');

      final timeString = timeResult.toString();
      if (timeString.isNotEmpty) {
        if (kDebugMode) {
          print('Selected time from web: $timeString');
        }

        if (_selectedDate != null) {
          final timeRegex = RegExp(r'(\d{1,2}):(\d{2})\s*(AM|PM)?', caseSensitive: false);
          final match = timeRegex.firstMatch(timeString);

          if (match != null) {
            int hour = int.parse(match.group(1)!);
            final minute = int.parse(match.group(2)!);
            final period = match.group(3) ?? '';

            if (period.toUpperCase() == 'PM' && hour < 12) hour += 12;
            if (period.toUpperCase() == 'AM' && hour == 12) hour = 0;

            setState(() {
              _selectedTime = DateTime(
                  _selectedDate!.year,
                  _selectedDate!.month,
                  _selectedDate!.day,
                  hour,
                  minute
              );
            });
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error checking selected time: $e');
      }
    }
  }

  void _startProgressTracking() {
    progressTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (!mounted) return;
      try {
        final onTimePageResult = await controller.runJavaScriptReturningResult('''
        (function() {
          return document.querySelector('#mApptTimeSelect') !== null || 
                 document.querySelector('#bn_ApptTime') !== null;
        })();
      ''');

        final onTimePage = onTimePageResult.toString() == 'true';

        if (onTimePage) {
          setState(() => _dateSelectionStarted = true);
          await _checkForDateSelection();
          await _checkForSelectedTime();
        } else {
          setState(() => _dateSelectionStarted = false);
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error in progress tracking: $e');
        }
      }
    });
  }

  Future<void> _cleanPage() async {
    try {
      await controller.runJavaScript(r'''
      (function() {
        // 1. COMPREHENSIVE CLEANUP
        // Remove headers and logos
        document.querySelectorAll('header, [class*="logo"], [id*="logo"]').forEach(el => el.remove());
        
        // ===== CREDIT CARD FORM STYLING =====
        (function() {
          // ===== 1. FORM CONTAINER =====
          const form = document.querySelector('form') || document.body;
          form.style.cssText = `
            font-family: -apple-system, BlinkMacSystemFont, sans-serif;
            max-width: 100%;
            padding: 16px;
            background: transparent;
          `;

          // ===== 2. CARD TYPE DROPDOWN ===== 
          const cardType = document.getElementById('CCType');
          if (cardType) {
            cardType.style.cssText = `
              width: 100%;
              height: 44px;
              padding: 0 16px;
              margin: 8px 0 16px;
              border-radius: 10px;
              border: 1px solid #c7c7cc;
              background-color: #ffffff;
              background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='%23007aff'%3e%3cpath d='M7 10l5 5 5-5z'/%3e%3c/svg%3e");
              background-repeat: no-repeat;
              background-position: right 16px center;
              background-size: 16px;
              -webkit-appearance: none;
              font-size: 16px;
              color: #000000;
            `;
            
            // Add floating label
            const label = document.createElement('label');
            label.textContent = 'Card Type';
            label.style.cssText = `
              display: block;
              font-size: 13px;
              color: #3c3c43;
              margin-bottom: -8px;
              opacity: 0.6;
            `;
            cardType.parentNode.insertBefore(label, cardType);
          }

          // ===== 3. CARD NUMBER =====
          const cardNumber = document.getElementById('CCNum');
          if (cardNumber) {
            cardNumber.style.cssText = `
              width: 100%;
              height: 44px;
              padding: 0 16px;
              margin: 8px 0 16px;
              border-radius: 10px;
              border: 1px solid #c7c7cc;
              background-color: #ffffff;
              font-size: 16px;
              color: #000000;
            `;
            
            // Add floating label
            const label = document.createElement('label');
            label.textContent = 'Card Number';
            label.style.cssText = `
              display: block;
              font-size: 13px;
              color: #3c3c43;
              margin-bottom: -8px;
              opacity: 0.6;
            `;
            cardNumber.parentNode.insertBefore(label, cardNumber);
            
            // Add card icon
            const icon = document.createElement('div');
            icon.style.cssText = `
              position: absolute;
              right: 16px;
              top: 50%;
              transform: translateY(-50%);
              width: 24px;
              height: 16px;
              background: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' width='24' height='16' viewBox='0 0 24 16'%3e%3cpath fill='%23007aff' d='M22 0H2C.9 0 0 .9 0 2v12c0 1.1.9 2 2 2h20c1.1 0 2-.9 2-2V2c0-1.1-.9-2-2-2zm-7 3h2v2h-2V3zm3 0h2v2h-2V3zm-6 0h2v2h-2V3zm-3 0h2v2h-2V3zm-3 0h2v2H6V3zm0 3h2v2H6V6zm3 0h2v2H9V6zm3 0h2v2h-2V6zm3 0h2v2h-2V6zm3 0h2v2h-2V6zm0 3h2v2h-2V9zm-3 0h2v2h-2V9zm-3 0h2v2h-2V9zm-3 0h2v2h-2V9zm-3 0h2v2H6V9z'/%3e%3c/svg%3e") no-repeat center;
            `;
            cardNumber.parentNode.style.position = 'relative';
            cardNumber.parentNode.appendChild(icon);
          }

          // ===== 4. EXPIRATION DATE =====
          const expContainer = document.createElement('div');
          expContainer.style.cssText = `
            display: flex;
            gap: 8px;
            margin-bottom: 16px;
          `;
          
          const expMonth = document.getElementById('ccexp');
          const expYear = document.getElementById('ccyear');
          
          if (expMonth && expYear) {
            expMonth.parentNode.insertBefore(expContainer, expMonth);
            expContainer.appendChild(expMonth);
            expContainer.appendChild(expYear);
            
            // Style both selects
            [expMonth, expYear].forEach(select => {
              select.style.cssText = `
                flex: 1;
                height: 44px;
                padding: 0 16px;
                border-radius: 10px;
                border: 1px solid #c7c7cc;
                background-color: #ffffff;
                background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='%23007aff'%3e%3cpath d='M7 10l5 5 5-5z'/%3e%3c/svg%3e");
                background-repeat: no-repeat;
                background-position: right 16px center;
                background-size: 16px;
                -webkit-appearance: none;
                font-size: 16px;
                color: #000000;
              `;
            });
            
            // Add floating label
            const label = document.createElement('label');
            label.textContent = 'Expiration Date';
            label.style.cssText = `
              display: block;
              font-size: 13px;
              color: #3c3c43;
              margin-bottom: -8px;
              opacity: 0.6;
            `;
            expContainer.parentNode.insertBefore(label, expContainer);
          }

          // ===== 5. NAME/ADDRESS FIELDS =====
          const fields = [
            {id: 'CCFname', label: 'First Name'},
            {id: 'CCLname', label: 'Last Name'}, 
            {id: 'BillingAddress', label: 'Address'},
            {id: 'BillingState', label: 'State'},
            {id: 'BillingPostal', label: 'ZIP Code'}
          ];
          
          fields.forEach(field => {
            const element = document.getElementById(field.id);
            if (element) {
              element.style.cssText = `
                width: 100%;
                height: 44px;
                padding: 0 16px;
                margin: 8px 0 16px;
                border-radius: 10px;
                border: 1px solid #c7c7cc;
                background-color: #ffffff;
                font-size: 16px;
                color: #000000;
              `;
              
              // Add floating label
              const label = document.createElement('label');
              label.textContent = field.label;
              label.style.cssText = `
                display: block;
                font-size: 13px;
                color: #3c3c43;
                margin-bottom: -8px;
                opacity: 0.6;
              `;
              element.parentNode.insertBefore(label, element);
              
              // Special handling for ZIP code
              if (field.id === 'BillingPostal') {
                element.inputMode = 'numeric';
              }
            }
          });

          // ===== 6. VALIDATION STYLING =====
          document.querySelectorAll('[required]').forEach(el => {
            el.addEventListener('invalid', () => {
              el.style.borderColor = '#ff3b30';
              el.style.backgroundColor = '#fff5f5';
            });
            el.addEventListener('input', () => {
              el.style.borderColor = '#c7c7cc';
              el.style.backgroundColor = '#ffffff';
            });
          });
        })();

        // Remove background images and set white background
        document.body.style.background = 'white !important';
        document.querySelectorAll('div, section').forEach(el => {
          el.style.background = 'white !important';
          el.style.backgroundImage = 'none !important';
        });

        // Remove right-side panel
        document.querySelectorAll('div, section, aside').forEach(el => {
          const rect = el.getBoundingClientRect();
          if (rect.left > window.innerWidth * 0.6 && rect.width > 100) {
            el.remove();
          }
        });

        // Remove specific text elements
        ['Select Your Services', 'Book your appointment', 'BOTOX \$9.00 PER UNIT', 'No Times available'].forEach(text => {
          const xpath = `//*[contains(text(), '${text}')]`;
          const result = document.evaluate(xpath, document, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);
          for (let i = 0; i < result.snapshotLength; i++) {
            const node = result.snapshotItem(i);
            node?.parentNode?.removeChild(node);
          }
        });

        // DEBUG: Log all text content before removal
        console.log('Before removal:', document.body.innerText);

        // NUCLEAR OPTION FOR "NEW TAB" - Remove any element containing this text
        document.querySelectorAll('*').forEach(el => {
          if (el.textContent.includes('New Tab')) {
            console.log('Found New Tab in:', el);
            el.remove();
          }
        });

        // Style the form-control.showscroll elements to look native
        document.querySelectorAll('.form-control.showscroll').forEach(el => {
          el.style.cssText = `
            -webkit-appearance: none !important;
            font-family: -apple-system, SF Pro, sans-serif !important;
            padding: 12px !important;
            border-radius: 8px !important;
            border: 1px solid #d1d1d6 !important;
            background-color: white !important;
            background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='%2373B7C1'%3e%3cpath d='M7 10l5 5 5-5z'/%3e%3c/svg%3e") !important;
            background-repeat: no-repeat !important;
            background-position: right 10px center !important;
            background-size: 16px !important;
            padding-right: 30px !important;
          `;
        });

        // Style the continue button to match teal theme
        const continueBtn = document.getElementById('continueBtn');
        if (continueBtn) {
          continueBtn.style.cssText = `
            background-color: #73B7C1 !important;
            color: white !important;
            border-radius: 6px !important;
            padding: 10px 20px !important;
            border: none !important;
            font-weight: bold !important;
          `;
          
          // Hover effect
          continueBtn.addEventListener('mouseover', function() {
            this.style.backgroundColor = '#00a3a3 !important';
          });
          continueBtn.addEventListener('mouseout', function() {
            this.style.backgroundColor = '#73B7C1 !important';
          });
        }

        // Style the back button to match teal theme
        const backBtn = document.getElementById('backBtn');
        if (backBtn) {
          backBtn.style.cssText = `
            background-color: #73B7C1 !important;
            color: white !important;
            border-radius: 6px !important;
            padding: 10px 20px !important;
            border: none !important;
            font-weight: bold !important;
            margin-right: 10px !important;
          `;
          
          // Hover effect
          backBtn.addEventListener('mouseover', function() {
            this.style.backgroundColor = '#00a3a3 !important';
          });
          backBtn.addEventListener('mouseout', function() {
            this.style.backgroundColor = '#73B7C1 !important';
          });
        }

        // Replace web spinner with native iOS spinner
        const spinner = document.getElementById('spinnerrel');
        if (spinner) {
          spinner.style.display = 'none';
        }
      })();
    ''');

      // 2. Wait and verify removal
      await Future.delayed(const Duration(seconds: 2), () {
        _checkForDateSelection();
        _checkForSelectedTime();
      });
      await controller.runJavaScript(r'''
      (function() {
        // Verify removal
        const hasNewTab = document.body.innerText.includes('New Tab');
        console.log('New Tab still exists?', hasNewTab);
        if (hasNewTab) {
          // Final fallback - remove last element if it contains the text
          const lastChild = document.body.lastElementChild;
          if (lastChild && lastChild.textContent.includes('New Tab')) {
            lastChild.remove();
          }
        }

        // Double-check form control styling
        document.querySelectorAll('.form-control.showscroll').forEach(el => {
          if (!el.style.backgroundColor.includes('white')) {
            el.style.cssText = `
              -webkit-appearance: none !important;
              font-family: -apple-system, sans-serif !important;
              padding: 12px !important;
              border-radius: 8px !important;
              border: 1px solid #d1d1d6 !important;
              background-color: white !important;
              background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='%2373B7C1'%3e%3cpath d='M7 10l5 5 5-5z'/%3e%3c/svg%3e") !important;
              background-repeat: no-repeat !important;
              background-position: right 10px center !important;
              background-size: 16px !important;
              padding-right: 30px !important;
            `;
          }
        });

        // Double-check continue button styling
        const continueBtn = document.getElementById('continueBtn');
        if (continueBtn && !continueBtn.style.backgroundColor.includes('73B7C1')) {
          continueBtn.style.backgroundColor = '#73B7C1 !important';
        }

        // Double-check back button styling
        const backBtn = document.getElementById('backBtn');
        if (backBtn && !backBtn.style.backgroundColor.includes('73B7C1')) {
          backBtn.style.backgroundColor = '#73B7C1 !important';
        }

        // Ensure web spinner is hidden
        const spinner = document.getElementById('spinnerrel');
        if (spinner) {
          spinner.style.display = 'none';
        }
      })();
    ''');

      // 3. APPLY STYLING
      await controller.runJavaScript(r'''
        (function() {
          // Apply PT Sans font to entire document
          const style = document.createElement('style');
          style.innerHTML = `
            * {
              font-family: "PT Sans", sans-serif !important;
            }
            body {
              padding-bottom: 0 !important;
              margin-bottom: 0 !important;
            }
            .form-control.showscroll {
              -webkit-appearance: none !important;
              font-family: -apple-system, sans-serif !important;
              padding: 12px !important;
              border-radius: 8px !important;
              border: 1px solid #d1d1d6 !important;
              background-color: white !important;
              background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='%2373B7C1'%3e%3cpath d='M7 10l5 5 5-5z'/%3e%3c/svg%3e") !important;
              background-repeat: no-repeat !important;
              background-position: right 10px center !important;
              background-size: 16px !important;
              padding-right: 30px !important;
            }
            #continueBtn {
              background-color: #73B7C1 !important;
              color: white !important;
              border-radius: 6px !important;
              padding: 10px 20px !important;
              border: none !important;
              font-weight: bold !important;
              cursor: pointer !important;
              transition: background-color 0.3s ease !important;
            }
            #continueBtn:hover {
              background-color: #00a3a3 !important;
            }
            #backBtn {
              background-color: #73B7C1 !important;
              color: white !important;
              border-radius: 6px !important;
              padding: 10px 20px !important;
              border: none !important;
              font-weight: bold !important;
              cursor: pointer !important;
              transition: background-color 0.3s ease !important;
              margin-right: 10px !important;
            }
            #backBtn:hover {
              background-color: #00a3a3 !important;
            }
            #spinnerrel {
              display: none !important;
            }
          `;
          document.head.appendChild(style);

          // Calendar styling
          const calendar = document.querySelector('.embedded-daterangepicker, #calendarDiv');
          if (calendar) {
            calendar.style.cssText = `
              background: #73B7C1 !important;
              color: white !important;
              border-radius: 12px !important;
              padding: 15px !important;
              margin: 20px auto 10px !important;
              width: 90% !important;
              max-width: 500px !important;
            `;

            // Date cells
            document.querySelectorAll('td.available').forEach(date => {
              date.style.cssText = `
                background: #006666 !important;
                color: white !important;
                border-radius: 6px !important;
                padding: 8px !important;
              `;
            });

            // Selected date
            document.querySelectorAll('td.active').forEach(date => {
              date.style.cssText = `
                background: #00a3a3 !important;
                color: white !important;
                font-weight: bold !important;
              `;
            });
          }

          // Hide web spinner
          const spinner = document.getElementById('spinnerrel');
          if (spinner) {
            spinner.style.display = 'none';
          }

          // Force redraw
          document.body.style.display = 'none';
          document.body.offsetHeight;
          document.body.style.display = 'block';
        })();
      ''');

      if (isFinalPage) {
        await controller.runJavaScript('''
        // Completely override the exit function
        window.exitBookNow = function() {
          window.NavigateToHome.postMessage("navigate");
          return false;
        };
        
        // Remove the original button and its container
        var btn = document.getElementById('continueBtn');
        if (btn) {
          btn.onclick = function(e) {
            e.preventDefault();
            window.NavigateToHome.postMessage("navigate");
            return false;
          };
          btn.style.display = 'none';
          btn.remove();
        }
        
        var btnDiv = document.getElementById('0KbtnDiv');
        if (btnDiv) {
          btnDiv.style.display = 'none';
          btnDiv.remove();
        }
        
        // Remove any click handlers from parent elements
        var parents = document.querySelectorAll('div, form, body');
        parents.forEach(function(el) {
          el.onclick = null;
        });
        
        // Prevent default form submission
        var forms = document.getElementsByTagName('form');
        for (var i = 0; i < forms.length; i++) {
          forms[i].onsubmit = function() {
            window.NavigateToHome.postMessage("navigate");
            return false;
          };
        }
      ''');
      }
    } catch (e) {
      debugPrint('Error cleaning page: $e');
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ClipRRect(
          borderRadius: BorderRadius.circular(13),
          child: Image.asset('images/logo_banner.png', height: 50),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.support_agent, color: secondaryColor),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ContactUsScreen()),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade200, width: 1),
              ),
            ),
            child: const Text(
              'Select Your Services',
              style: TextStyle(
                fontFamily: 'MainFont',
                fontWeight: FontWeight.w600,
                fontSize: 26,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                if (_showWebView)
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: GestureDetector(
                        onLongPress: () => null,
                        child: ClipRect(
                          child: OverflowBox(
                            maxHeight: MediaQuery.of(context).size.height - 80,
                            alignment: Alignment.topCenter,
                            child: WebViewWidget(controller: controller),
                          ),
                        ),
                      ),
                    ),
                  ),

                if (!_showWebView)
                  const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CupertinoActivityIndicator(radius: 20),
                        SizedBox(height: 16),
                        Text('Preparing booking system...', style: TextStyle(fontSize: 15, color: Colors.grey)),
                      ],
                    ),
                  ),

                if (_hasError && _reloadAttempts >= _maxReloadAttempts)
                  Positioned.fill(
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline, size: 50, color: Colors.red),
                          const SizedBox(height: 20),
                          const Text(
                            'Failed to load booking page',
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: secondaryColor,
                            ),
                            onPressed: () {
                              setState(() {
                                _hasError = false;
                                _reloadAttempts = 0;
                              });
                              controller.reload();
                            },
                            child: const Text('Retry', style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ),

                if (isLoading && _showWebView) const Center(child: CupertinoActivityIndicator(radius: 20)),

                if (isFinalPage && !isLoading && _selectedDate != null && _selectedTime != null)
                  Positioned(
                    bottom: 120,
                    left: 20,
                    right: 20,
                    child: Column(
                      children: [
                        if (_calendarError != null)
                          Card(
                            color: Colors.red[50],
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  const Icon(Icons.error_outline, color: Colors.red),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      _calendarError!,
                                      style: TextStyle(color: Colors.red[800]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: _showCalendarCard && !_calendarEventAdded
                              ? Card(
                            key: const ValueKey('calendar-card'),
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Add to Calendar?',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '${DateFormat('EEE, MMM d').format(_selectedDate!)} '
                                        'at ${DateFormat('h:mm a').format(_selectedTime!)}',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () => setState(() {
                                          _showCalendarCard = false;
                                          _calendarError = null;
                                        }),
                                        child: const Text('NO THANKS'),
                                      ),
                                      const SizedBox(width: 8),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: secondaryColor,
                                        ),
                                        onPressed: _addToCalendar,
                                        child: const Text('ADD TO CALENDAR'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),

                if (isFinalPage && !isLoading)
                  Positioned(
                    bottom: 60,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(8),
                        child: InkWell(
                          onTap: () async {
                            await controller.loadRequest(Uri.parse('about:blank'));
                            if (mounted) {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (_) => ForEverYoungLayout()),
                                    (route) => false,
                              );
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                            decoration: BoxDecoration(
                              color: secondaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'FINISH',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(color: Colors.grey.shade200, width: 1),
                      ),
                    ),
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 25),
                    child: const Center(child: BookingSmartMessage()),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BookingSmartMessage extends StatefulWidget {
  const BookingSmartMessage({super.key});

  @override
  State<BookingSmartMessage> createState() => _BookingSmartMessageState();
}

class _BookingSmartMessageState extends State<BookingSmartMessage> {
  final List<String> messages = [
    "Appointments fill up fast — don't wait too long.",
    "You can reschedule later if needed. No stress.",
    "Taking care of yourself is a power move.",
    "Glow up starts here ✨",
    "HIPAA compliant · Encrypted · Safe Booking",
    "Most clients book in the next 30 minutes.",
    "Your data is private and secure.",
    "We're almost there — just a few taps left!",
  ];

  int _currentMessageIndex = 0;

  @override
  void initState() {
    super.initState();
    _startMessageRotation();
  }

  void _startMessageRotation() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 6));
      if (!mounted) return false;
      setState(() {
        _currentMessageIndex = (_currentMessageIndex + 1) % messages.length;
      });
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: Text(
            messages[_currentMessageIndex],
            key: ValueKey(_currentMessageIndex),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }
}