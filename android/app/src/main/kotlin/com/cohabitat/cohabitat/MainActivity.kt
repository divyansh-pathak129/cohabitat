package com.cohabitat.cohabitat

import android.content.Intent
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity

// Enhanced FlutterActivity implementation for better handling of Auth0 redirects
class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        // Handle intent during initial launch
        handleIntent(intent)
    }
    
    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        
        // Update the activity's intent
        setIntent(intent)
        
        // Handle the new intent (e.g., from Auth0 redirect)
        handleIntent(intent)
    }
    
    private fun handleIntent(intent: Intent) {
        // You can add custom logic here if needed
        // For Auth0, the default handling is usually sufficient
    }
}
