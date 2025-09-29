//
//  LLHtmlUIWebViewController.m
//
//  Copyright (c) 2018 LLDebugTool Software Foundation (https://github.com/HDB-Li/LLDebugTool)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "LLHtmlUIWebViewController.h"
#import <WebKit/WebKit.h>
#import "LLTool.h"

@interface LLHtmlUIWebViewController () <WKNavigationDelegate>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
@property (nonatomic, strong) WKWebView *webView;
#pragma clang diagnostic pop

@end

@implementation LLHtmlUIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.webView.frame = self.view.bounds;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [LLTool log:[NSString stringWithFormat:@"WKWebView start load %@", self.urlString]];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [LLTool log:[NSString stringWithFormat:@"WKWebView finish load %@", self.urlString]];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [LLTool log:[NSString stringWithFormat:@"WKWebView failed in %@, with error %@", self.urlString, error.debugDescription]];
}

#pragma clang diagnostic pop

#pragma mark - Primary
- (void)setUpUI {

    [self.view addSubview:self.webView];
    
    if (self.urlString.length > 0) {
          NSURL *url = [NSURL URLWithString:self.urlString];
          if (url) {
              NSURLRequest *request = [NSURLRequest requestWithURL:url];
              [self.webView loadRequest:request];
          }
      }
}

- (BOOL)webViewClassIsValid {
    if (!self.webViewClass || self.webViewClass.length == 0) {
        return NO;
    }
    Class cls = NSClassFromString(self.webViewClass);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    
#pragma clang diagnostic pop
        
    return YES;
}

#pragma mark - Getters and setters
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (WKWebView *)webView {
    if (!_webView) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
        _webView.navigationDelegate = self;
    }
    return _webView;
}
#pragma clang diagnostic pop

@end
