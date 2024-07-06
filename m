Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03181459EB;
	Sat,  6 Jul 2024 18:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720290591; cv=none; b=swyQnpjEg2li63qKRFLH9idS6wbmd2bqzgTmwuHH3jTAcc0nVOoWAJZad4XT8kRfonglfxv/lHkupcKlBjD8jQ5NDFYt9Bij3G5FMPACngmqIIC78igdhOKYNLFBEnkdO4iTj+2qLk9xWzqrYcvqGJjfl6PE6+1whlFQG504Fls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720290591; c=relaxed/simple;
	bh=wiyH6nYX2joY6gj6HBTSJuinUcXqqdfnZbkXwEt8fCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cqiIDNlPAIZ9XsRiEQ9Z5FX1RoQi5nhCCVSn861oQdGY9pkUqGQQtj684PqcuswAjfPLxEDgrbBIop8cP5Zijus2vlJS+FszOYdJNizgfTwl7B8hosTn2bBHXJnnTHq1s1OaVecYQfsOtgytTlsK5W/oaYUEZjtW+Vnk29kvCTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B2781682;
	Sat,  6 Jul 2024 11:30:14 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BBC2E3F73B;
	Sat,  6 Jul 2024 11:29:46 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Nick Terrell <terrelln@fb.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Changbin Du <changbin.du@huawei.com>,
	James Clark <james.clark@linaro.org>,
	amadio@gentoo.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v3 7/7] perf docs: Remove the Android cross building document
Date: Sat,  6 Jul 2024 19:29:12 +0100
Message-Id: <20240706182912.222780-8-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240706182912.222780-1-leo.yan@arm.com>
References: <20240706182912.222780-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Android NDK (as time being the latest LTS version is r26d) changes
toolchain to LLVM / Clang, so GCC compilers is not included in the NDK
anymore. Therefore, the Android document contains obsolete info for
building perf binary with NDK.

Furthermore, the Clang included in the Android NDK is problematic for
cross compilation Aarch64 target. The building reports multiple errors
with the compiler aarch64-linux-android34-clang.

Thus, delete Documentation/android.txt to avoid confusion.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/Documentation/android.txt | 78 ----------------------------
 1 file changed, 78 deletions(-)
 delete mode 100644 tools/perf/Documentation/android.txt

diff --git a/tools/perf/Documentation/android.txt b/tools/perf/Documentation/android.txt
deleted file mode 100644
index 24a59998fc91..000000000000
--- a/tools/perf/Documentation/android.txt
+++ /dev/null
@@ -1,78 +0,0 @@
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
-- 
2.34.1

