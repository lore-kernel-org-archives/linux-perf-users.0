Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D054309DCC;
	Tue, 30 Sep 2025 16:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759251338; cv=none; b=iFIXfWlPnEOHpQItg6ae83DbEp4ZJBRIPCzmilBJkjcDuKs5k2UVyT3gdxv3YI2Kn3QEIah55vxyNrfDHiFPUDoTrJHaImRIDEt09fMYvynem8FIy/n79qQMg8G+mt5Ut0vAim9TTWi5rOfbWaIPev8Ky4ZXWx6mDxP90bmdJMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759251338; c=relaxed/simple;
	bh=yLdtJoXXg2ZofvQ3tks4npYZRXDJBWfYweloxYQbePU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mlDx1FTcdcCuRdRoijxuL/ipe9qBk9fh4Jk0AzmvOPKjJF84Zaq4u5+mYrqO12Gq9iRZo80+O0T1vqKdTxFaOPDxHYPSFICEj0nSHaLfnx2gNjOhwA/qlQ7+GZoC48gPMdBIlJYGGtAKJdULCOrov/t8nfGKNodmRLjTAV5rV38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C47F2008;
	Tue, 30 Sep 2025 09:55:28 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AFB83F59E;
	Tue, 30 Sep 2025 09:55:33 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 30 Sep 2025 17:54:56 +0100
Subject: [PATCH v2 8/8] perf docs: Document building with Clang
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-perf_build_android_ndk-v2-8-2ea440b7ef01@arm.com>
References: <20250930-perf_build_android_ndk-v2-0-2ea440b7ef01@arm.com>
In-Reply-To: <20250930-perf_build_android_ndk-v2-0-2ea440b7ef01@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, James Clark <james.clark@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 llvm@lists.linux.dev, linux-riscv@lists.infradead.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759251311; l=5456;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=yLdtJoXXg2ZofvQ3tks4npYZRXDJBWfYweloxYQbePU=;
 b=FAHvogt9BofB+eIklO3kgKv4aDBql7NZWnSq1CV1Ut4b5S2ajzlknnf8ataA62OL5M2om3hlJ
 FpXCimKSy9fBOmaFofQlJyp/VQTvmsbG6UiFoeGj/r9e8o/n5eCKsET
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Add example commands for building perf with Clang.

Since recent Android NDK releases use Clang as the default compiler, a
separate Android specific document is no longer needed; point to the
general build documentation instead.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/Documentation/Build.txt   | 15 +++++++
 tools/perf/Documentation/android.txt | 80 +++---------------------------------
 2 files changed, 21 insertions(+), 74 deletions(-)

diff --git a/tools/perf/Documentation/Build.txt b/tools/perf/Documentation/Build.txt
index 83dc87c662b63ecc17553a15cc15a6b8d6f01d83..57b226e7fc2f8e849dfe58b3af31891f58dfd0af 100644
--- a/tools/perf/Documentation/Build.txt
+++ b/tools/perf/Documentation/Build.txt
@@ -99,3 +99,18 @@ configuration paths for cross building:
 In this case, the variable PKG_CONFIG_SYSROOT_DIR can be used alongside the
 variable PKG_CONFIG_LIBDIR or PKG_CONFIG_PATH to prepend the sysroot path to
 the library paths for cross compilation.
+
+5) Build with Clang
+===================
+By default, the makefile uses GCC as compiler. With specifying environment
+variables HOSTCC, CC and CXX, it allows to build perf with Clang.
+
+Using Clang for a native build:
+
+  $ HOSTCC=clang CC=clang CXX=clang++ make -C tools/perf
+
+Specifying ARCH and CROSS_COMPILE for cross compilation:
+
+  $ HOSTCC=clang CC=clang CXX=clang++ \
+    ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- \
+    make -C tools/perf
diff --git a/tools/perf/Documentation/android.txt b/tools/perf/Documentation/android.txt
index 24a59998fc91e814ad96f658d3481d88d798b60c..3f3cc7ac3d139c5517ec9458f13c06249c701429 100644
--- a/tools/perf/Documentation/android.txt
+++ b/tools/perf/Documentation/android.txt
@@ -1,78 +1,10 @@
 How to compile perf for Android
-=========================================
+===============================
 
-I. Set the Android NDK environment
-------------------------------------------------
+There are two ways to build perf and run it on Android:
 
-(a). Use the Android NDK
-------------------------------------------------
-1. You need to download and install the Android Native Development Kit (NDK).
-Set the NDK variable to point to the path where you installed the NDK:
-  export NDK=/path/to/android-ndk
+- Method 1: Build perf with static linking. See Build.txt, section
+  "4) Cross compilation" for how to build a static perf binary.
 
-2. Set cross-compiling environment variables for NDK toolchain and sysroot.
-For arm:
-  export NDK_TOOLCHAIN=${NDK}/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin/arm-linux-androideabi-
-  export NDK_SYSROOT=${NDK}/platforms/android-24/arch-arm
-For x86:
-  export NDK_TOOLCHAIN=${NDK}/toolchains/x86-4.9/prebuilt/linux-x86_64/bin/i686-linux-android-
-  export NDK_SYSROOT=${NDK}/platforms/android-24/arch-x86
-
-This method is only tested for Android NDK versions Revision 11b and later.
-perf uses some bionic enhancements that are not included in prior NDK versions.
-You can use method (b) described below instead.
-
-(b). Use the Android source tree
------------------------------------------------
-1. Download the master branch of the Android source tree.
-Set the environment for the target you want using:
-  source build/envsetup.sh
-  lunch
-
-2. Build your own NDK sysroot to contain latest bionic changes and set the
-NDK sysroot environment variable.
-  cd ${ANDROID_BUILD_TOP}/ndk
-For arm:
-  ./build/tools/build-ndk-sysroot.sh --abi=arm
-  export NDK_SYSROOT=${ANDROID_BUILD_TOP}/ndk/build/platforms/android-3/arch-arm
-For x86:
-  ./build/tools/build-ndk-sysroot.sh --abi=x86
-  export NDK_SYSROOT=${ANDROID_BUILD_TOP}/ndk/build/platforms/android-3/arch-x86
-
-3. Set the NDK toolchain environment variable.
-For arm:
-  export NDK_TOOLCHAIN=${ANDROID_TOOLCHAIN}/arm-linux-androideabi-
-For x86:
-  export NDK_TOOLCHAIN=${ANDROID_TOOLCHAIN}/i686-linux-android-
-
-II. Compile perf for Android
-------------------------------------------------
-You need to run make with the NDK toolchain and sysroot defined above:
-For arm:
-  make WERROR=0 ARCH=arm CROSS_COMPILE=${NDK_TOOLCHAIN} EXTRA_CFLAGS="-pie --sysroot=${NDK_SYSROOT}"
-For x86:
-  make WERROR=0 ARCH=x86 CROSS_COMPILE=${NDK_TOOLCHAIN} EXTRA_CFLAGS="-pie --sysroot=${NDK_SYSROOT}"
-
-III. Install perf
------------------------------------------------
-You need to connect to your Android device/emulator using adb.
-Install perf using:
-  adb push perf /data/perf
-
-If you also want to use perf-archive you need busybox tools for Android.
-For installing perf-archive, you first need to replace #!/bin/bash with #!/system/bin/sh:
-  sed 's/#!\/bin\/bash/#!\/system\/bin\/sh/g' perf-archive >> /tmp/perf-archive
-  chmod +x /tmp/perf-archive
-  adb push /tmp/perf-archive /data/perf-archive
-
-IV. Environment settings for running perf
-------------------------------------------------
-Some perf features need environment variables to run properly.
-You need to set these before running perf on the target:
-  adb shell
-  # PERF_PAGER=cat
-
-IV. Run perf
-------------------------------------------------
-Run perf on your device/emulator to which you previously connected using adb:
-  # ./data/perf
+- Method 2: Download the Android NDK and use the bundled Clang to
+  build perf. See Build.txt, section "5) Build with clang" for details.

-- 
2.34.1

