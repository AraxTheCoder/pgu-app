package de.araxthecoder.pgu;

import androidx.core.view.WindowCompat;

import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends FlutterActivity {
    @Override
    public void onResume(){
        super.onResume();

        WindowCompat.setDecorFitsSystemWindows(getWindow(), false);
    }
}
