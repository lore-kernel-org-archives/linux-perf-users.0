Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F17818AF9;
	Fri, 12 Jul 2024 04:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720760320; cv=none; b=FufSELgIR1b/Xjn/XU8bayIVm/9sEuqqMSFgKq7Mc+LYsPPBILsxTvecTJykLaVFCQb64L63qWKNHICX5Bt3WJXyx+h1ucQ1n4HAeF8YetjhdgTyuOIxJqotyOiNK3q/2Cc9MIGOagRmVnWwfFnfwNxFDBfKiBItdTNAZ/FyJug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720760320; c=relaxed/simple;
	bh=5Ji3ZmOKlD4NChkJywfgIH2PGeXGJZeyK0GuUptOlFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKsP7/qWT+IhiHPzegVawjDrnviBPxJzgv3PA4gJcdgzFnR59z+BKVMOwYVCm4hcW3AOJMOh5f26KE2RJxH7d8y2p777utFbt/odVhZ3h1sagqp0KRepq47QdpMO/iJQFm45vcWLArdSTll3qEj0WecnlT9ryj7qbGOREp/WnhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMbL4/XG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMbL4/XG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989DBC3277B;
	Fri, 12 Jul 2024 04:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720760319;
	bh=5Ji3ZmOKlD4NChkJywfgIH2PGeXGJZeyK0GuUptOlFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pMbL4/XG/xXjekFwnVT6Vm02GxVhIIptg2vJ+OujJbO6jOqd7J5CwZYrtazymwCak
	 +Kf/qyKz/hj5xTnB4J5Eg7mvyoGjioyT9GdSkORRVbHvVlSJYyOo0cHZ+soNbJV4lR
	 HJSo02cgF51/0kgWILtAiWl3ZzZUw36Ffa4U7gQ0zUzdQFhEYhozxE/yk1TLD8jSSv
	 qsAz++sYfzHoxm8zPWgCZ61GOCaXM5Lx0uRYuOQ8ZaxZMEPHQNBBQMjRkSsE5S24Ok
	 ItyDfGPiAG/lh4KxXtrTRXFmwm2RUWcPtDtMZ8SnvNOQz5UtOXnZSKyIzDxAfjFwU1
	 LDwSwS/fEOC0A==
Date: Thu, 11 Jul 2024 21:58:34 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
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
	James Clark <james.clark@linaro.org>, amadio@gentoo.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 7/7] perf docs: Remove the Android cross building
 document
Message-ID: <ZpC3-p0kG7dGkp_5@google.com>
References: <20240706182912.222780-1-leo.yan@arm.com>
 <20240706182912.222780-8-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240706182912.222780-8-leo.yan@arm.com>

On Sat, Jul 06, 2024 at 07:29:12PM +0100, Leo Yan wrote:
> The Android NDK (as time being the latest LTS version is r26d) changes
> toolchain to LLVM / Clang, so GCC compilers is not included in the NDK
> anymore. Therefore, the Android document contains obsolete info for
> building perf binary with NDK.

Do you know if the version prior to the change is still used?

> 
> Furthermore, the Clang included in the Android NDK is problematic for
> cross compilation Aarch64 target. The building reports multiple errors
> with the compiler aarch64-linux-android34-clang.
> 
> Thus, delete Documentation/android.txt to avoid confusion.

If so, maybe we can keep the document little more and add a note that
this works only for some old versions.

I'm also curious if it's still broken after your fixes.

Thanks,
Namhyung

> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/perf/Documentation/android.txt | 78 ----------------------------
>  1 file changed, 78 deletions(-)
>  delete mode 100644 tools/perf/Documentation/android.txt
> 
> diff --git a/tools/perf/Documentation/android.txt b/tools/perf/Documentation/android.txt
> deleted file mode 100644
> index 24a59998fc91..000000000000
> --- a/tools/perf/Documentation/android.txt
> +++ /dev/null
> @@ -1,78 +0,0 @@
> -How to compile perf for Android
> -=========================================
> -
> -I. Set the Android NDK environment
> -------------------------------------------------
> -
> -(a). Use the Android NDK
> -------------------------------------------------
> -1. You need to download and install the Android Native Development Kit (NDK).
> -Set the NDK variable to point to the path where you installed the NDK:
> -  export NDK=/path/to/android-ndk
> -
> -2. Set cross-compiling environment variables for NDK toolchain and sysroot.
> -For arm:
> -  export NDK_TOOLCHAIN=${NDK}/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin/arm-linux-androideabi-
> -  export NDK_SYSROOT=${NDK}/platforms/android-24/arch-arm
> -For x86:
> -  export NDK_TOOLCHAIN=${NDK}/toolchains/x86-4.9/prebuilt/linux-x86_64/bin/i686-linux-android-
> -  export NDK_SYSROOT=${NDK}/platforms/android-24/arch-x86
> -
> -This method is only tested for Android NDK versions Revision 11b and later.
> -perf uses some bionic enhancements that are not included in prior NDK versions.
> -You can use method (b) described below instead.
> -
> -(b). Use the Android source tree
> ------------------------------------------------
> -1. Download the master branch of the Android source tree.
> -Set the environment for the target you want using:
> -  source build/envsetup.sh
> -  lunch
> -
> -2. Build your own NDK sysroot to contain latest bionic changes and set the
> -NDK sysroot environment variable.
> -  cd ${ANDROID_BUILD_TOP}/ndk
> -For arm:
> -  ./build/tools/build-ndk-sysroot.sh --abi=arm
> -  export NDK_SYSROOT=${ANDROID_BUILD_TOP}/ndk/build/platforms/android-3/arch-arm
> -For x86:
> -  ./build/tools/build-ndk-sysroot.sh --abi=x86
> -  export NDK_SYSROOT=${ANDROID_BUILD_TOP}/ndk/build/platforms/android-3/arch-x86
> -
> -3. Set the NDK toolchain environment variable.
> -For arm:
> -  export NDK_TOOLCHAIN=${ANDROID_TOOLCHAIN}/arm-linux-androideabi-
> -For x86:
> -  export NDK_TOOLCHAIN=${ANDROID_TOOLCHAIN}/i686-linux-android-
> -
> -II. Compile perf for Android
> -------------------------------------------------
> -You need to run make with the NDK toolchain and sysroot defined above:
> -For arm:
> -  make WERROR=0 ARCH=arm CROSS_COMPILE=${NDK_TOOLCHAIN} EXTRA_CFLAGS="-pie --sysroot=${NDK_SYSROOT}"
> -For x86:
> -  make WERROR=0 ARCH=x86 CROSS_COMPILE=${NDK_TOOLCHAIN} EXTRA_CFLAGS="-pie --sysroot=${NDK_SYSROOT}"
> -
> -III. Install perf
> ------------------------------------------------
> -You need to connect to your Android device/emulator using adb.
> -Install perf using:
> -  adb push perf /data/perf
> -
> -If you also want to use perf-archive you need busybox tools for Android.
> -For installing perf-archive, you first need to replace #!/bin/bash with #!/system/bin/sh:
> -  sed 's/#!\/bin\/bash/#!\/system\/bin\/sh/g' perf-archive >> /tmp/perf-archive
> -  chmod +x /tmp/perf-archive
> -  adb push /tmp/perf-archive /data/perf-archive
> -
> -IV. Environment settings for running perf
> -------------------------------------------------
> -Some perf features need environment variables to run properly.
> -You need to set these before running perf on the target:
> -  adb shell
> -  # PERF_PAGER=cat
> -
> -IV. Run perf
> -------------------------------------------------
> -Run perf on your device/emulator to which you previously connected using adb:
> -  # ./data/perf
> -- 
> 2.34.1
> 
