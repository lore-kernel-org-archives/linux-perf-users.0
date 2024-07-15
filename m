Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F81813C8E2;
	Mon, 15 Jul 2024 20:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721075807; cv=none; b=Dy3ATgaPGqZmPQKrKAzaXN9ziY4Q74zcgWJfUnARasurYf2xLUtVLm+221gahNI17Nj3acxarjoi9QjW92W4TYYM+G2tavzCvWuFhFZgOTtqPxqxcw39RZL27Z1HdkCAqMXfGCR5WSUAzh5flngr84WwAe94hYQoWgX9XKv070I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721075807; c=relaxed/simple;
	bh=QQFltvoMJZSltEw4rJCM+AgHmWo2Lewu/argm0xDyKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kg+jPXd0I/L2FuI/AEQy/wJ0Y4g9hVcr6nAWpczvupwyUfIAwE9mF6uE/JIcXakpkNKCL516CfYscLHTvwWOuRD1j40oIjlfiFivKMgNGQ+3KJZ73Xu61nwWo/enz/ppA8cvCViCOMJArRAsT+2vFFFcquw1zzwn+kKL8HWj7ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3F9CFEC;
	Mon, 15 Jul 2024 13:37:08 -0700 (PDT)
Received: from [10.57.10.251] (unknown [10.57.10.251])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56B523F73F;
	Mon, 15 Jul 2024 13:36:41 -0700 (PDT)
Message-ID: <f316e3ce-e1e3-45f0-ac78-9af590b58706@arm.com>
Date: Mon, 15 Jul 2024 21:36:38 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf docs: Mark the Android document as obsolete
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240715143342.52236-1-leo.yan@arm.com>
 <CAP-5=fVd9pO7kKvZX7PZ6sJ+GHOV7aF=Ry98a=vknimuSTp9Lg@mail.gmail.com>
 <1487da55-24dc-40ef-a6e8-4bf4b153fdc3@arm.com>
 <CAP-5=fUGJmOr9XcsVWWCREjr1A7rUFaMk0VPkQAKDAEjTLKJVQ@mail.gmail.com>
 <CAP-5=fWY4AeMxfNGh_jB4gss_qtGSgfX4pvv-D-fpCWuqamVfA@mail.gmail.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <CAP-5=fWY4AeMxfNGh_jB4gss_qtGSgfX4pvv-D-fpCWuqamVfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/2024 9:06 PM, Ian Rogers wrote:

[...]

> So if I add (somewhat taken from tools/testing/selftests/lib.mk):
> ```
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 5271a4c1d2b3..9edf5f41d6e4 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -19,6 +19,35 @@ detected_var = $(shell echo "$(1)=$($(1))" >>
> $(OUTPUT).config-detected)
> CFLAGS := $(EXTRA_CFLAGS) $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
> HOSTCFLAGS := $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
> 
> +CLANG := clang
> +
> +CLANG_TARGET_FLAGS_arm          := arm-linux-gnueabi
> +CLANG_TARGET_FLAGS_arm64        := aarch64-linux-gnu
> +CLANG_TARGET_FLAGS_hexagon      := hexagon-linux-musl
> +CLANG_TARGET_FLAGS_i386         := i386-linux-gnu
> +CLANG_TARGET_FLAGS_m68k         := m68k-linux-gnu
> +CLANG_TARGET_FLAGS_mips         := mipsel-linux-gnu
> +CLANG_TARGET_FLAGS_powerpc      := powerpc64le-linux-gnu
> +CLANG_TARGET_FLAGS_riscv        := riscv64-linux-gnu
> +CLANG_TARGET_FLAGS_s390         := s390x-linux-gnu
> +CLANG_TARGET_FLAGS_x86          := x86_64-linux-gnu
> +CLANG_TARGET_FLAGS_x86_64       := x86_64-linux-gnu
> +
> +# Default to host architecture if ARCH is not explicitly given.
> +ifeq ($(ARCH),)
> +CLANG_TARGET_FLAGS := $(shell $(CLANG) -print-target-triple)
> +else
> +CLANG_TARGET_FLAGS := $(CLANG_TARGET_FLAGS_$(ARCH))
> +endif
> +
> +ifeq ($(CLANG_TARGET_FLAGS),)
> +$(error Specify CROSS_COMPILE or add '--target=' option to lib.mk)
> +else
> +CLANG_FLAGS     += --target=$(CLANG_TARGET_FLAGS)
> +endif # CLANG_TARGET_FLAGS
> +
> +CC := $(CLANG) $(CLANG_FLAGS) -fintegrated-as
> +
> # Enabled Wthread-safety analysis for clang builds.
> ifeq ($(CC_NO_CLANG), 0)
>   CFLAGS += -Wthread-safety
> ```
> I was able to build with:
> $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -C tools/perf
> O=/tmp/perf NO_LIBELF=1 NO_LIBTRACEEVENT=1 NO_LIBPYTHON=1 CC=clang
> CXX=clang++

This command doesn't work for me.

Built with 'CROSS_COMPILE=aarch64-linux-gnu-' option, the perf tool is still
built with GCC:

  $ strings perf | grep GCC
  GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0

After removing the option 'CROSS_COMPILE=aarch64-linux-gnu-', still failed
building.

Anyway, thanks a lot for sharing.

Leo

> Obviously not a complete fix as it is unconditionally forcing CC to
> clang, but I don't think we're too far from having a clang/llvm cross
> compile build that can work.
> 
> Thanks,
> Ian
