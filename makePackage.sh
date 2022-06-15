#!/bin/bash

PACKAGE_DIR="${BUILT_PRODUCTS_DIR}/../package"

mkdir -pv "${PACKAGE_DIR}"

PRODUCT_PACKAGE="${PACKAGE_DIR}/SendKeyStrokePeriodically.pkg"

pkgbuild --root "${BUILT_PRODUCTS_DIR}" \
	--identifier "com.danilkorotenko.SendKeyStrokePeriodically" \
	--version "1" \
	--ownership recommended \
	--install-location "/Library/SendKeyStrokeToVerizonClient/" \
	--scripts ./PackageScripts \
	"${PACKAGE_DIR}/package.pkg"


# A trick to make sure that package would be signed. The password is being taked from the jenkins user at the Jenkins build server.
#security -v unlock-keychain -p "passsword" /Users/user/Library/Keychains/login.keychain

#productbuild --distribution distribution.xml --package-path "${PACKAGE_DIR}" --sign "certificate" "${PRODUCT_PACKAGE}"
productbuild --distribution distribution.xml --package-path "${PACKAGE_DIR}" "${PRODUCT_PACKAGE}"

exit 0;
