# Your Android App Project

Ye ek ready Android Studio project hai jisme WebView pehle se aapki website ke URL par set hai.

## APK kaise banayen (sabse aasan tareeka)

1. Is folder ko ek naye GitHub repository mein push karen
2. Repo ke **Actions** tab mein jayen — 2-3 minute mein build khatam ho jayega
3. Completed run kholen, neeche **Artifacts** mein `app-debug-apk` milega — download karen, yehi aapki APK hai

## Ya Android Studio mein khud build karen

1. Android Studio kholen -> Open -> is folder ko select karen
2. Gradle sync khatam hone dein
3. **Build > Build Bundle(s) / APK(s) > Build APK(s)**

## Play Store ke liye signed APK (optional)

Play Store par publish karne ke liye ek signed release APK chahiye hoti hai (sirf debug APK
nahi chalegi). Ye already wired hai:

1. Terminal mein is folder ke andar:
   ```
   ./generate-keystore.sh
   ```
   Name, password, alias pooche ga. Ye `release.keystore` file banayega aur ek base64 text
   print karega.

2. GitHub repo -> **Settings -> Secrets and variables -> Actions -> New repository secret**
   mein ye 4 secrets add karen:
   - `RELEASE_KEYSTORE_BASE64` (script ke output se)
   - `RELEASE_KEYSTORE_PASSWORD`
   - `RELEASE_KEY_ALIAS`
   - `RELEASE_KEY_PASSWORD`

3. Repo par push karen -> Actions run complete hone par ab 2 artifacts milenge:
   - `app-debug-apk` (testing)
   - `app-release-signed-apk` (**Play Store par upload karne layak**)

**Zaroori:** `release.keystore` file aur ye 4 passwords kahin safe backup rakh lein. Ye kho
gaye to app ka agla update publish nahi ho payega — Play Store isay bilkul naya/alag app
samjhega, purane app ko update nahi kar payega.

Agar secrets add nahi karte, tool sirf debug APK deta rahega — koi error nahi aayega,
signing bilkul optional hai.
