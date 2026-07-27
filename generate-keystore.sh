#!/bin/sh
# Generates a release keystore for signing your APK, and prints the
# base64 string you need to paste into the GitHub secret RELEASE_KEYSTORE_BASE64.
#
# Usage: ./generate-keystore.sh
# Needs Java's "keytool" (comes with any JDK / Android Studio installation).

set -e

echo "== Release Keystore Generator =="
echo ""
read -p "Your name / company (e.g. JSR Technos): " CN
read -p "Keystore password (remember this!): " STORE_PASS
read -p "Key alias (e.g. release-key): " ALIAS
read -p "Key password (can be same as keystore password): " KEY_PASS

OUT="release.keystore"

keytool -genkeypair -v \
  -keystore "$OUT" \
  -alias "$ALIAS" \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000 \
  -storepass "$STORE_PASS" \
  -keypass "$KEY_PASS" \
  -dname "CN=$CN, OU=Dev, O=$CN, L=City, S=State, C=IN"

echo ""
echo "Keystore created: $OUT"
echo ""
echo "Ab ye 4 GitHub repo secrets add karo (Settings > Secrets and variables > Actions):"
echo ""
echo "RELEASE_KEYSTORE_BASE64  ->  (neeche ka poora base64 text)"
echo "RELEASE_KEYSTORE_PASSWORD -> $STORE_PASS"
echo "RELEASE_KEY_ALIAS         -> $ALIAS"
echo "RELEASE_KEY_PASSWORD      -> $KEY_PASS"
echo ""
echo "---- RELEASE_KEYSTORE_BASE64 value (copy everything below) ----"
base64 -w 0 "$OUT"
echo ""
echo "-----------------------------------------------------------------"
echo ""
echo "IMPORTANT: release.keystore file aur ye passwords kahin safe backup rakho."
echo "Ye kho gaye to future app updates publish nahi kar paoge (Play Store naya"
echo "app treat karega, purana wala update nahi hoga)."
