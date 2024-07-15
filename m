Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9771E528
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jul 2024 15:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721057388; cv=none; b=Tctqpde9LPuTbTEymkP3dWGBoMNsDFlZVRW3jr0G0GZE0vC0aV4R7IGgtyqYcNogg4sIHOlmCuYQ30bstI0Bxe4VJJsmQkYmYCvl0lvF+/WkI+6W/5ugyMgcJ6AR6nEZp/cMrmgetqCaJuyH1DKtNTesmp3gbsYJ0HlTxu5wf7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721057388; c=relaxed/simple;
	bh=7LCLu24vsh4F8ZMDRDe01iOkZFnhRhMBdnuepy5zrQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=YQsV/EK0uvOrcuqJfnCgSLBkBqhdr9P+jARMZMOB2MXZWm0b+MaK7Wyw7EidjvLC1+vpd1RCkkmMHBSMfQPj9tMXRPZK4ek/wOCXzX78aTy2uf5JlGGpzwplG6VDeWyXDyytw+FBKDJPpaxq5YmBvpwqbJxtGQDQHwN7RBIICyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qc+FyUQf; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qc+FyUQf"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52e9f788e7bso5247581e87.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jul 2024 08:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721057385; x=1721662185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hd+c9UetWmNL8CVLgdOQG2FnlUULON1f9TFGgZFyt9M=;
        b=qc+FyUQfqe1sXbW/HAoipjo9ZK0qEDD68xD+DPzQ0+lADWeHM0onpCc0YL/QOPjQlm
         8WEuklHmZyreVREsdSaKi6vf3EWMFCQ2U8Bt/RyefQb7FjkhMtiTj4BmD0TQiDSTlCuf
         xTpPk0gPs1pFtVgoo2mdt2UdzCtqI+P75yRsXc+bH0Ib3KGqi0zHngvXbcpFZXg53fUy
         Y+OyuXk4YU1IjQNKjHU7EevFbZcqEhvMzZxMdAew+v41c536r8baZQtlkYujtTxpbJnB
         qo61ElXFjJijLGWASpx6ffHGCJBJdSTj9u9HfcAECgWrTRwtHKNbBFEyGJxU/9Islew2
         ektQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721057385; x=1721662185;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hd+c9UetWmNL8CVLgdOQG2FnlUULON1f9TFGgZFyt9M=;
        b=UjUQF3f5qdrppVizRubjltCgHeOGmcyI82FQ21yqF3/IHHC4lyigMfuBBe00D2qMZW
         D4z2GrXK4NyMVk8xml1bAXOsF+FYjFjyG8weGoDaVklCokP0UBNoUrp7tLFMnBKp5KH0
         YChwQVXLXu1mEgrrHGufYlKzQ6eRBSSkgW3It+h6QyHmQc2f++uMa5yX4ceNRknHz7IQ
         NnsEzc3eVnGAG6Nhvpr2MOOpeVu2/xIiFebXEExV2iOM7Ynt/o8A7nfwfeUi6fKqf0or
         3gjnrl52yPeE2Rw70g/qfTpDk/80JFCIl6R+awI8eOJeXaGBMIlObGu1ceF65XLJXoiI
         MM7w==
X-Forwarded-Encrypted: i=1; AJvYcCVDMGMF5wnYJfKt2iYiMy6ClGPpm0uxYcahDAh8RYVsHye/EazvaMPkelA7tueZusjZkkXsqodlyZy3c+a5bu08bxLL5xx5aN459x0FA9jOig==
X-Gm-Message-State: AOJu0YxLM+kWWIKUTwbyw9QmV6w5SqXtbFha1xf5dgVe9HTWL0kTnfVX
	vfP/3gNqvM9qlLCfYfU+Y45hrmFjbFp4abMIFKkbXKYJrAQD2SAHn1d05PPuuik=
X-Google-Smtp-Source: AGHT+IEtjjKmRV8MWWvN8XkiOxl3UwZ+Z8YDJH6Vwt8MWUj2QumHlA5aEVNe/Ipt2PgQ8TtPIFf2+g==
X-Received: by 2002:a05:6512:690:b0:52c:8aa6:4e9c with SMTP id 2adb3069b0e04-52eb99d28bamr14001257e87.65.1721057384990;
        Mon, 15 Jul 2024 08:29:44 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f25babbsm123734165e9.20.2024.07.15.08.29.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 08:29:44 -0700 (PDT)
Message-ID: <02456237-98b3-443e-948f-69f3c7ff8420@linaro.org>
Date: Mon, 15 Jul 2024 16:29:43 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf docs: Mark the Android document as obsolete
To: Leo Yan <leo.yan@arm.com>
References: <20240715143342.52236-1-leo.yan@arm.com>
Content-Language: en-US
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20240715143342.52236-1-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/07/2024 3:33 pm, Leo Yan wrote:
> As of Android NDK r15, GCC is no longer supported. Since then, the GCC
> compiler has been phased out in the NDK, and LLVM/Clang became the
> official toolchain.
> 
> However, the document android.txt contains steps for cross building Perf
> with GCC with using an older NDK. On the other hand, It is problematic
> for Perf cross building with Clang - multiple compilation errors and
> missing dependency libraries are observed.
> 
> Thus, mark the Documentation/android.txt as obsolete. This file is kept
> for the historical reference.
> 

Reviewed-by: James Clark <james.clark@linaro.org>

> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/Documentation/android.txt | 79 +---------------------------
>   1 file changed, 1 insertion(+), 78 deletions(-)
> 
> diff --git a/tools/perf/Documentation/android.txt b/tools/perf/Documentation/android.txt
> index 24a59998fc91..2254d0483bf4 100644
> --- a/tools/perf/Documentation/android.txt
> +++ b/tools/perf/Documentation/android.txt
> @@ -1,78 +1 @@
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
> +Android NDK compilation is deprecated and no longer supported.
