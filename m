Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7598713D52C;
	Fri, 12 Jul 2024 11:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720782132; cv=none; b=MGdT4Fh+SMovEW3zCIR3yNpC8CHviHk+CMoDHL4ZnvapeO3Gdv4ClTIhfEyuBCzn+26JnTULkwML5sKYljx6xm/tkG6DFG+d3UuwMm6QmZheDAy4v0zcJm+7WwizFgj6tP8C3dHm37LEJFMkfuy3iw3zYCMEGNEDTJDZh4X2jsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720782132; c=relaxed/simple;
	bh=DmUEk6EM7gl56GdYXFypUxyuamk0ZO+1DP5TRyf29gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VzGhKs3Mho1mRiUf+FsXEr0MliHJ+CLQf1QJZd9DqnqjMXmLgp0A6dhuL6XfhxT/m6um095ItjGM6a4i4HlT7DU3nPwbMgwgFvmsz76txh66AOgjV0Ap7fWAohwhZ01vRi0/tCB4zNiVE13cEMI9EmPmmxln/re86CH1gbmchgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD7931007;
	Fri, 12 Jul 2024 04:02:34 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E73293F762;
	Fri, 12 Jul 2024 04:02:06 -0700 (PDT)
Message-ID: <3b16778b-f825-42a2-b53d-17c9b8c22a52@arm.com>
Date: Fri, 12 Jul 2024 12:02:05 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] perf docs: Remove the Android cross building
 document
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Adrian Hunter
 <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>,
 Nick Terrell <terrelln@fb.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Thomas Richter <tmricht@linux.ibm.com>, Changbin Du
 <changbin.du@huawei.com>, James Clark <james.clark@linaro.org>,
 amadio@gentoo.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20240706182912.222780-1-leo.yan@arm.com>
 <20240706182912.222780-8-leo.yan@arm.com> <ZpC3-p0kG7dGkp_5@google.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <ZpC3-p0kG7dGkp_5@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Namhyung,

On 7/12/24 05:58, Namhyung Kim wrote:
> On Sat, Jul 06, 2024 at 07:29:12PM +0100, Leo Yan wrote:

[...]

>> The Android NDK (as time being the latest LTS version is r26d) changes
>> toolchain to LLVM / Clang, so GCC compilers is not included in the NDK
>> anymore. Therefore, the Android document contains obsolete info for
>> building perf binary with NDK.
> 
> Do you know if the version prior to the change is still used?

Based on the Android NDK wiki claims [1], since NDK r15 (backed to 26th
July, 2017) "GCC is no longer supported. It will not be removed from the NDK
just yet, but is no longer receiving backports".

>> Furthermore, the Clang included in the Android NDK is problematic for
>> cross compilation Aarch64 target. The building reports multiple errors
>> with the compiler aarch64-linux-android34-clang.
>>
>> Thus, delete Documentation/android.txt to avoid confusion.
> 
> If so, maybe we can keep the document little more and add a note that
> this works only for some old versions.
> 
> I'm also curious if it's still broken after your fixes.

When I tried Android NDK for cross building perf, it is still broken after
applied this series.

 From my testing, now using LLVM for native building works well:

   make LLVM=-15 VF=1 DEBUG=1 -C tools/perf

But it failed for cross compilation. Since Android NDK system root does not
contain some dependency libs, we must use extra options to disable some
features (e.g. NO_LIBELF=1 NO_LIBTRACEEVENT=1). The commands I tried for
cross building but failed:

   make ARCH=arm64 CC=$NDK_TOOLCHAIN/aarch64-linux-android-clang \
     LD=$NDK_TOOLCHAIN/ld.lld AR=$NDK_TOOLCHAIN/llvm-ar \
     NM=$NDK_TOOLCHAIN/llvm-nm STRIP=$NDK_TOOLCHAIN/llvm-strip \
     OBJCOPY=$NDK_TOOLCHAIN/llvm-objcopy \
     OBJDUMP=$NDK_TOOLCHAIN/llvm-objdump \
     READELF=$NDK_TOOLCHAIN/llvm-readelf \
     HOSTCC=$NDK_TOOLCHAIN/clang \
     HOSTCXX=$NDK_TOOLCHAIN/clang++ HOSTAR=$NDK_TOOLCHAIN/llvm-ar \
     HOSTLD=$NDK_TOOLCHAIN/ld.lld VF=1 DEBUG=1 NO_LIBELF=1 \
     NO_LIBTRACEEVENT=1 EXTRA_CFLAGS=-fgnuc-version=0 \
     -C tools/perf

Given the test result, my conclusion is the doc for Android cross building
is not useful for a long while. If we really want to support it, I would
like to suggest to take a separate task for fixing LLVM / Clang cross
compilation.

Thanks,
Leo

[1] https://github.com/android/ndk/wiki/Changelog-r15
