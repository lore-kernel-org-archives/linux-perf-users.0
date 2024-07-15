Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D2C433B3;
	Mon, 15 Jul 2024 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721054042; cv=none; b=kTKKeqYAmmAUlm9f0eSgbOfGBD3bIszJqjDOdJ6aaG/Zcrc2dXQEzT1vhFm/00cDzhoiLTXn07D9a98/JiQmVs9eFBIumj2/1WYF6+Xq1QWzWdz5PKEx6PiQq7CS/xm9g8+DgPNpjv17eEpMpFW5krQGvlNusbGsHcuQqFoD8M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721054042; c=relaxed/simple;
	bh=EBpeVIf2H1PXWOGRjMyLKWBk7WnF/jRTmoexivcti4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m0SojIvn7+5ReH5PmVbVRRMJP5muBwbXdhh96k4CChyq4bYMnzw0UmbVog87voGYMMrTKcKerPSY5DYkjKM0c3EmXYKaUTjFB9GfreIKChJQGp86k4QFSHzmKnOuuETDr4Gb35ibPF6zJXsCPyctXrcqQ3+JtuJf1fXFo3xWoUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2245FEC;
	Mon, 15 Jul 2024 07:34:25 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 91D4E3F766;
	Mon, 15 Jul 2024 07:33:58 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2] perf docs: Mark the Android document as obsolete
Date: Mon, 15 Jul 2024 15:33:42 +0100
Message-Id: <20240715143342.52236-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As of Android NDK r15, GCC is no longer supported. Since then, the GCC
compiler has been phased out in the NDK, and LLVM/Clang became the
official toolchain.

However, the document android.txt contains steps for cross building Perf
with GCC with using an older NDK. On the other hand, It is problematic
for Perf cross building with Clang - multiple compilation errors and
missing dependency libraries are observed.

Thus, mark the Documentation/android.txt as obsolete. This file is kept
for the historical reference.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/Documentation/android.txt | 79 +---------------------------
 1 file changed, 1 insertion(+), 78 deletions(-)

diff --git a/tools/perf/Documentation/android.txt b/tools/perf/Documentation/android.txt
index 24a59998fc91..2254d0483bf4 100644
--- a/tools/perf/Documentation/android.txt
+++ b/tools/perf/Documentation/android.txt
@@ -1,78 +1 @@
-How to compile perf for Android
-=========================================
-
-I. Set the Android NDK environment
-------------------------------------------------
-
-(a). Use the Android NDK
-------------------------------------------------
-1. You need to download and install the Android Native Development Kit (NDK).
-Set the NDK variable to point to the path where you installed the NDK:
-  export NDK=/path/to/android-ndk
-
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
+Android NDK compilation is deprecated and no longer supported.
-- 
2.34.1

