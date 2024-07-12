Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEE4FC12
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 05:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720762651; cv=none; b=n36+/PlCupG7Yr4P9KtvCOn5xDDPevc5364TVuj8qt1wOK8KaJrkjDi3pqacdIsKSzZ//f8wAG2ZE+hwNeq2a1mI8Q99ni6FLZiD3b/RnbxsGrIYI5JdsRByuiOELFPW7xRq+ntsQUGg/EsNNcqlGTdIK0IdDaDEgG+099uJq5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720762651; c=relaxed/simple;
	bh=ycW3MshNjKteaBVobCSDIboGwAMJeZ4dK2sEPd7PzzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mKsn3Kra0c7lR8/OP/liXFR/W0j0yTriZt/740ehGEw3SaIeUCm+JKI4jaoQ4hifQRL7k3n+A9f1d0srMOdjMuJ3fbfpULa1Qnea/c/8kKBEQLiWz037jckJIxG2fZRjvvpgMqflZWTVzL55zcQo6FvEQm7l0ia7QBl/5DUoWkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XQ4TJIY/; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XQ4TJIY/"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fb10519ae3so72435ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 22:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720762649; x=1721367449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dH3qZ/7Le7SMeUq7EqrX+ajUtlSjo++wTXKwFvqTS3I=;
        b=XQ4TJIY/QxcPryFluAfpBwbyegjoGifkQUMtqOz1/yccMoSQa3DpETUvIflvc42qJd
         5kPfMOAxZ9HAbrnKNNQuWFgHzF3M/8ANim3CedF067XoHTZgMbn/Oa+Is9e1t+6q1FfI
         O1ozNcVSKzh5lkv+3VXzHmF9S6HIUsjyTKy/+pYZJYYAYXmpJR8ZmpnoUW/WIBCePOOp
         SXdjv6Ua2swifB5vKlYMG/9QTauZ7s9tJ7XePUS8AVDARDGyT2+0WNOTDvt0Dc9g7L3a
         Vp06pF/g8TIKCSpE6IIw3maL0siYGHbe+cA8idQGV3km0VKzpp2L/Vr/6PvWNDGJc4/M
         Klow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720762649; x=1721367449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dH3qZ/7Le7SMeUq7EqrX+ajUtlSjo++wTXKwFvqTS3I=;
        b=JvDr1sIBdLE1DpsZuyw4wcfqXXbimhAvOYRHOqBWPs+JkZNXfu9YJLE3Ru18H5EuvA
         YM0ZZ49DFmKk89ykKFAwZ5rObpA4eKmnjcPanegWimLYU3/xVVdYkpflhpl/sViL81f2
         KGU7NCiI31wCvgFVSx3pexXnUqEa5qIEqTcXA8lF6l0m1LL9YUsFVQbyS7O5z9kLSXMm
         Upq5kSQnaUSOc3SqZtHE3rW8355qGxaSUk2iv6XE2Lw7cXfqYSUP7qM/HueOBA251dKT
         imeytWy10DZ98HMerXud4qu72DBu7mqXjOv7JteeFmxT6zLpBLu45ujfpHc1fhcsVI5s
         I/HA==
X-Forwarded-Encrypted: i=1; AJvYcCUlfH3XhZiw6bup+YX75S5QAOmwHvJ+9W9OSPbsE2I62G9x0mI+eipmjGysUQbzcZre8GkwIsvFgegIESJNuzs+6e0Bl18LbJNc+XUa5BWR+w==
X-Gm-Message-State: AOJu0Yy7qPR9nIfJ0UImNmYlw4kBIdSLrANesWs5LDvXXDuhSEbUW9BW
	/A48VG+Sv7reSYh8muLWx2CXR9N2QAcOFN8meE7RrViwu1qm3WqtLPkOoSJ2CiS/OMimLBaK+sI
	0EBysFSUCovyzFW5kR5o4hChm6ZhUmqhSN1SE
X-Google-Smtp-Source: AGHT+IElXIRXWUBJFFoKWg9ej8d296ASuBabnWfhRhCAdVw/f3nWgnCz9mk1c7X3KAIhxGPRWD4EL/SE8GxpGrquGCg=
X-Received: by 2002:a17:902:e850:b0:1fb:1a7:a64f with SMTP id
 d9443c01a7336-1fbf24bb3edmr1876795ad.20.1720762649164; Thu, 11 Jul 2024
 22:37:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706182912.222780-1-leo.yan@arm.com> <20240706182912.222780-8-leo.yan@arm.com>
 <ZpC3-p0kG7dGkp_5@google.com>
In-Reply-To: <ZpC3-p0kG7dGkp_5@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 11 Jul 2024 22:37:17 -0700
Message-ID: <CAP-5=fXsN2Z+0T-7kS-pub2i_X8RgRQeTPh4QcxAkWeSL+PuPw@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] perf docs: Remove the Android cross building document
To: Namhyung Kim <namhyung@kernel.org>
Cc: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Nick Terrell <terrelln@fb.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Changbin Du <changbin.du@huawei.com>, 
	James Clark <james.clark@linaro.org>, amadio@gentoo.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 9:58=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Sat, Jul 06, 2024 at 07:29:12PM +0100, Leo Yan wrote:
> > The Android NDK (as time being the latest LTS version is r26d) changes
> > toolchain to LLVM / Clang, so GCC compilers is not included in the NDK
> > anymore. Therefore, the Android document contains obsolete info for
> > building perf binary with NDK.
>
> Do you know if the version prior to the change is still used?

The git log last mentions NDK 12 from 2016 working. I suspect these
instructions haven't worked for a good long while.

Thanks,
Ian

> >
> > Furthermore, the Clang included in the Android NDK is problematic for
> > cross compilation Aarch64 target. The building reports multiple errors
> > with the compiler aarch64-linux-android34-clang.
> >
> > Thus, delete Documentation/android.txt to avoid confusion.
>
> If so, maybe we can keep the document little more and add a note that
> this works only for some old versions.
>
> I'm also curious if it's still broken after your fixes.
>
> Thanks,
> Namhyung
>
> >
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
> > ---
> >  tools/perf/Documentation/android.txt | 78 ----------------------------
> >  1 file changed, 78 deletions(-)
> >  delete mode 100644 tools/perf/Documentation/android.txt
> >
> > diff --git a/tools/perf/Documentation/android.txt b/tools/perf/Document=
ation/android.txt
> > deleted file mode 100644
> > index 24a59998fc91..000000000000
> > --- a/tools/perf/Documentation/android.txt
> > +++ /dev/null
> > @@ -1,78 +0,0 @@
> > -How to compile perf for Android
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > -
> > -I. Set the Android NDK environment
> > -------------------------------------------------
> > -
> > -(a). Use the Android NDK
> > -------------------------------------------------
> > -1. You need to download and install the Android Native Development Kit=
 (NDK).
> > -Set the NDK variable to point to the path where you installed the NDK:
> > -  export NDK=3D/path/to/android-ndk
> > -
> > -2. Set cross-compiling environment variables for NDK toolchain and sys=
root.
> > -For arm:
> > -  export NDK_TOOLCHAIN=3D${NDK}/toolchains/arm-linux-androideabi-4.9/p=
rebuilt/linux-x86_64/bin/arm-linux-androideabi-
> > -  export NDK_SYSROOT=3D${NDK}/platforms/android-24/arch-arm
> > -For x86:
> > -  export NDK_TOOLCHAIN=3D${NDK}/toolchains/x86-4.9/prebuilt/linux-x86_=
64/bin/i686-linux-android-
> > -  export NDK_SYSROOT=3D${NDK}/platforms/android-24/arch-x86
> > -
> > -This method is only tested for Android NDK versions Revision 11b and l=
ater.
> > -perf uses some bionic enhancements that are not included in prior NDK =
versions.
> > -You can use method (b) described below instead.
> > -
> > -(b). Use the Android source tree
> > ------------------------------------------------
> > -1. Download the master branch of the Android source tree.
> > -Set the environment for the target you want using:
> > -  source build/envsetup.sh
> > -  lunch
> > -
> > -2. Build your own NDK sysroot to contain latest bionic changes and set=
 the
> > -NDK sysroot environment variable.
> > -  cd ${ANDROID_BUILD_TOP}/ndk
> > -For arm:
> > -  ./build/tools/build-ndk-sysroot.sh --abi=3Darm
> > -  export NDK_SYSROOT=3D${ANDROID_BUILD_TOP}/ndk/build/platforms/androi=
d-3/arch-arm
> > -For x86:
> > -  ./build/tools/build-ndk-sysroot.sh --abi=3Dx86
> > -  export NDK_SYSROOT=3D${ANDROID_BUILD_TOP}/ndk/build/platforms/androi=
d-3/arch-x86
> > -
> > -3. Set the NDK toolchain environment variable.
> > -For arm:
> > -  export NDK_TOOLCHAIN=3D${ANDROID_TOOLCHAIN}/arm-linux-androideabi-
> > -For x86:
> > -  export NDK_TOOLCHAIN=3D${ANDROID_TOOLCHAIN}/i686-linux-android-
> > -
> > -II. Compile perf for Android
> > -------------------------------------------------
> > -You need to run make with the NDK toolchain and sysroot defined above:
> > -For arm:
> > -  make WERROR=3D0 ARCH=3Darm CROSS_COMPILE=3D${NDK_TOOLCHAIN} EXTRA_CF=
LAGS=3D"-pie --sysroot=3D${NDK_SYSROOT}"
> > -For x86:
> > -  make WERROR=3D0 ARCH=3Dx86 CROSS_COMPILE=3D${NDK_TOOLCHAIN} EXTRA_CF=
LAGS=3D"-pie --sysroot=3D${NDK_SYSROOT}"
> > -
> > -III. Install perf
> > ------------------------------------------------
> > -You need to connect to your Android device/emulator using adb.
> > -Install perf using:
> > -  adb push perf /data/perf
> > -
> > -If you also want to use perf-archive you need busybox tools for Androi=
d.
> > -For installing perf-archive, you first need to replace #!/bin/bash wit=
h #!/system/bin/sh:
> > -  sed 's/#!\/bin\/bash/#!\/system\/bin\/sh/g' perf-archive >> /tmp/per=
f-archive
> > -  chmod +x /tmp/perf-archive
> > -  adb push /tmp/perf-archive /data/perf-archive
> > -
> > -IV. Environment settings for running perf
> > -------------------------------------------------
> > -Some perf features need environment variables to run properly.
> > -You need to set these before running perf on the target:
> > -  adb shell
> > -  # PERF_PAGER=3Dcat
> > -
> > -IV. Run perf
> > -------------------------------------------------
> > -Run perf on your device/emulator to which you previously connected usi=
ng adb:
> > -  # ./data/perf
> > --
> > 2.34.1
> >
