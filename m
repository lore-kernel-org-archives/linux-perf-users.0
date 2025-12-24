Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B1F338F36
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Dec 2025 13:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766583651; cv=none; b=gCrWkRNqo3YI0YO18KN81zcZBnBIb9Jj5+pArg73uTsR20tgyxj+Is2cc+L4Tv5kP8DEoWost+jdutHuzA5H+9UzZZoiFl1niXxsJq5dv26eJCOVGvDteOkpnf3CuimYTAND/KJgxoja02ZtbwUqiCKRydhRSW7aP922/h/5yxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766583651; c=relaxed/simple;
	bh=+W0yac6vzyHfyRuMC4pEqsrUJA4goWOajd+Y+BovlIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SNbGoeTyuB0iMIdE0yq8JUqO0T1eNkEssyDb/o159r1OAEPUDVfuK5BKmCSC/RlmUnsi9SSseaqyroEq8N0mzK/foStbOSW7ZhDplSCWp5ypIJHZ5U7/WraXOvfea1H5NM3ll9eLFfOr6nLSuosZhtP9PxEvSabchJ1iT/EGKIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=scoKFRoo; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="scoKFRoo"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-477563e28a3so37547985e9.1
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Dec 2025 05:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766583646; x=1767188446; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4bOu15FXdawoXLU6RXH7GKUZX7zUNavG7vPjXViBxOI=;
        b=scoKFRoo3N3chECY1dOYRqs6nPnakuw1RBRq5s9PM5EIQ8fSWeUkBbNpJTN0URMoO1
         1o9SiRhKWMYsaOOkcpcaWxrYEvSjbve6W+NLO6zrDp5CUn9+gNOoF2mjTinWw8YDlRwq
         8CFgzuo7X2OSnqZVQ4+jcKZQ1e3Zpd73803mWLupqMfwTNgoKsKs3NLtwUPCR30zlzqD
         5OPCrTYoegSEvb2UJUPpYkqy+wxj/V4VJL41e8DssjdyWWfSFs/0j5MC93oI9IDm80h0
         HKwEodRuo2yhP+aASsAHITGFN1nJieSTS54i/UZuRGz4d4tkv8jVHcwEai9jZ1KHidJo
         GIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766583646; x=1767188446;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4bOu15FXdawoXLU6RXH7GKUZX7zUNavG7vPjXViBxOI=;
        b=ulYh419D2itLRbJoJ9fhuCDURgsushKML/MA8trdUOmpCzUR3dfpJRTKawaOMVoBZm
         kE41OXILWErrsPkhmQo2ZLfMSV7xahHX9XDRoGlBmF9tphgrifLbVD9kRA+uNES2yHoD
         bav0FFK2W7dgKZ269sI5sKhSl4XIDiahjAvpejuXQI4g20VTDVxhUv+mhzA2K1SCP/JP
         fRlmhLEMpdG9JlylfQYbjLaXwp+gu3DA24btZ54s7TntfAlAzBhA0byN/zk6KQR+W5N8
         e2gjC/ol69moQq6x6/T28Ggn8m6xEMhODL9PrI6O3DhGpiVTsJpRcBnctfMjGo/921qV
         k1YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZexbUDJkh1kB39j6xfbFUT/Wuz5Kkkd9kYctPrCZhQkJgsNhatd2DKJlVR0FnDXTMe2aLPeHuoyjw0nATlvw6@vger.kernel.org
X-Gm-Message-State: AOJu0YzczeQxyTI30cBZszTn9lYrHxm0hJA+6DT8LHmOBMfy0gpfivVF
	M3LnE0ugeU3BmXRinYh+9QD/7Ek7cPy6XXl/J1UioGooUMoB84GFSAiuiD7UfSDIipE=
X-Gm-Gg: AY/fxX4rhJuZS6gkz2YgmNuxNuG6zL8F6iMcwPaGc9MFipVUyxL4wDorWj7K7Gqp+oo
	6eK/AXlAbXDBFthIy+QSJc60GX1NwlEHnl0g3mc2txYatbzBCmzZl+xei9ixELf+2ew/SUrZQxR
	TvDopUjkVmmXBCJs+GlLueIwccpNdDN/0EhlRJWdwxUMsIgqRmeGDG9Gd8KlcLuZaAIyXDAKize
	GD+A2JbdN64DEDmmnM5i/uk92JJh0GH0E47vPMBX1C+cY+oTQwoWoI5gekHIMiJ/HP5JQjuBFow
	bCCkY3j9I3TjFy1y34Mgiv05rAevj55dp6aeDRPvGxq5jEC0vvCYvJKYpfsYU/0si3X1zmNijMS
	RfYVwuXtynKAITjhf3uRDNWI129M6P0khZJu5kr/Zp6by8dxKhpCBkkDZXZXI+q0pE9Qwolp72r
	3fOQziwBnrpyoZiNjxlDZqwlodyyU=
X-Google-Smtp-Source: AGHT+IE8mTfoPQdEFqjfoLhz+ly5EIeJ+Tot9qbv5NCIzLJlMGkF44TFB89BCLTRXL8dljzxOMuMcQ==
X-Received: by 2002:a05:600c:19ca:b0:477:a289:d854 with SMTP id 5b1f17b1804b1-47d18b98f87mr179558255e9.5.1766583646316;
        Wed, 24 Dec 2025 05:40:46 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3a204e9sm133872835e9.2.2025.12.24.05.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Dec 2025 05:40:45 -0800 (PST)
Message-ID: <c25d5032-5a41-4e95-ae76-3466875241a0@linaro.org>
Date: Wed, 24 Dec 2025 13:40:44 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf unwind-libdw: fix a cross-arch unwinding bug
To: shimin.guo@skydio.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-riscv@lists.infradead.org, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
 Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Guo Ren <guoren@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
References: <20251223-cross-arch-unwind-v1-1-4d71ee7db512@skydio.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251223-cross-arch-unwind-v1-1-4d71ee7db512@skydio.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24/12/2025 2:19 am, Shimin Guo via B4 Relay wrote:
> From: Shimin Guo <shimin.guo@skydio.com>
> 
> The set_initial_registers field of Dwfl_Thread_Callbacks needs to be set
> according to the arch of the stack samples being analyzed, not the arch
> that perf itself is built for. Currently perf fails to unwind stack samples
> collected from archs different from that of the host perf is running on.
> This patch moves the arch-specific implementations of set_initial_registers
> from tools/perf/arch to tools/perf/utli/unwind-libdw-arch, similar to the
> way the perf-regs-arch folder contains arch-specific functions related to
> registers, and chooses the implementation based on the arch of the data
> being processed.
> 
> Signed-off-by: Shimin Guo <shimin.guo@skydio.com>
> ---
> checkpatch flagged three issues:
>> tools/perf/util/unwind-libdw-arch/Build:232: WARNING: added, moved
> or deleted file(s), does MAINTAINERS need updating?
> 
> Not sure what to do about that.
> 

You don't need to do anything here because there's a blanket rule for 
the Perf dir.

>> checkpatch.pl: tools/perf/util/unwind-libdw.c:228: WARNING:
> Non-declarative macros with multiple statements should be enclosed in
> a do - while loop

I think you can ignore this one.

>> checkpatch.pl: tools/perf/util/unwind-libdw.c:228: WARNING: macros
> should not use a trailing semicolon
> 
> Are these two false positives? I'm defining static global variables
> with the macro.

But I don't see a reason not to follow this one, just remove the semicolon.

> ---
>   tools/perf/arch/arm/util/Build                     |  1 -
>   tools/perf/arch/arm64/util/Build                   |  1 -
>   tools/perf/arch/csky/util/Build                    |  2 -
>   tools/perf/arch/powerpc/util/Build                 |  1 -
>   tools/perf/arch/riscv/util/Build                   |  1 -
>   tools/perf/arch/s390/util/Build                    |  2 -
>   tools/perf/arch/x86/util/Build                     |  1 -
>   tools/perf/util/Build                              |  1 +
>   tools/perf/util/unwind-libdw-arch/Build            |  8 ++++
>   .../unwind-libdw-arch/unwind-libdw-arm.c}          |  4 +-
>   .../unwind-libdw-arch/unwind-libdw-arm64.c}        |  4 +-
>   .../unwind-libdw-arch/unwind-libdw-csky.c}         |  6 +--
>   .../unwind-libdw-arch/unwind-libdw-loongarch.c}    |  4 +-
>   .../unwind-libdw-arch/unwind-libdw-powerpc.c}      |  4 +-
>   .../unwind-libdw-arch/unwind-libdw-riscv.c}        |  4 +-
>   .../unwind-libdw-arch/unwind-libdw-s390.c}         |  6 +--
>   .../unwind-libdw-arch/unwind-libdw-x86.c}          |  2 +-
>   tools/perf/util/unwind-libdw.c                     | 49 +++++++++++++++++++---
>   tools/perf/util/unwind-libdw.h                     | 10 ++++-
>   19 files changed, 79 insertions(+), 32 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/util/Build b/tools/perf/arch/arm/util/Build
> index fd695e1fdaee2ccc300a206131b8b38a763b00ce..3291f893b943df0722dff583523fff4ae79919bc 100644
> --- a/tools/perf/arch/arm/util/Build
> +++ b/tools/perf/arch/arm/util/Build
> @@ -1,6 +1,5 @@
>   perf-util-y += perf_regs.o
>   
>   perf-util-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind.o
> -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
>   
>   perf-util-y += pmu.o auxtrace.o cs-etm.o
> diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
> index d63881081d2eb1e9a83eabf82104d75308f7fc79..0177af19cc00038d6a6005592ddc530bf7eb1557 100644
> --- a/tools/perf/arch/arm64/util/Build
> +++ b/tools/perf/arch/arm64/util/Build
> @@ -1,4 +1,3 @@
> -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
>   perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
>   perf-util-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
>   perf-util-y += ../../arm/util/auxtrace.o
> diff --git a/tools/perf/arch/csky/util/Build b/tools/perf/arch/csky/util/Build
> index 5e6ea82c42021d3d5651ca4c4a3a6e5138574e4e..6b2d0e021b11464e46d6b53974260d32ea969732 100644
> --- a/tools/perf/arch/csky/util/Build
> +++ b/tools/perf/arch/csky/util/Build
> @@ -1,3 +1 @@
>   perf-util-y += perf_regs.o
> -
> -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
> diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
> index 3d0d5427aef7f26a8c05c883cc7ad763f08cbb30..5fd28ec713a4db74ecd1d26866a65ddb20e94bd3 100644
> --- a/tools/perf/arch/powerpc/util/Build
> +++ b/tools/perf/arch/powerpc/util/Build
> @@ -9,5 +9,4 @@ perf-util-y += evsel.o
>   perf-util-$(CONFIG_LIBDW) += skip-callchain-idx.o
>   
>   perf-util-$(CONFIG_LIBUNWIND) += unwind-libunwind.o
> -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
>   perf-util-y += auxtrace.o
> diff --git a/tools/perf/arch/riscv/util/Build b/tools/perf/arch/riscv/util/Build
> index 58a672246024dd0f72e767d11e9958bd9913ec3c..628b9ebd418bde8cdf1ab1332bf79f7c9d50760e 100644
> --- a/tools/perf/arch/riscv/util/Build
> +++ b/tools/perf/arch/riscv/util/Build
> @@ -2,4 +2,3 @@ perf-util-y += perf_regs.o
>   perf-util-y += header.o
>   
>   perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
> -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
> diff --git a/tools/perf/arch/s390/util/Build b/tools/perf/arch/s390/util/Build
> index c64eb18dbdae93adafabf8542e4c9a763ecfe057..5391d26fedd46b7d30a1bef0bff2ec2d58ec30ed 100644
> --- a/tools/perf/arch/s390/util/Build
> +++ b/tools/perf/arch/s390/util/Build
> @@ -2,8 +2,6 @@ perf-util-y += header.o
>   perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
>   perf-util-y += perf_regs.o
>   
> -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
> -
>   perf-util-y += machine.o
>   perf-util-y += pmu.o
>   
> diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
> index c0dc5965f3624a6f02525a04d287dff755356d20..fad256252bb95a8f8350b6bb1a54e8074eaebbec 100644
> --- a/tools/perf/arch/x86/util/Build
> +++ b/tools/perf/arch/x86/util/Build
> @@ -12,7 +12,6 @@ perf-util-y += evsel.o
>   perf-util-y += iostat.o
>   
>   perf-util-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind.o
> -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
>   
>   perf-util-y += auxtrace.o
>   perf-util-y += archinsn.o
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 1c2a43e1dc68e7f751ec6082352b10de9ffeea62..15f8a4f4b24a46b6300e824f672dd9c0d5b7865f 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -226,6 +226,7 @@ perf-util-$(CONFIG_LIBDW) += debuginfo.o
>   perf-util-$(CONFIG_LIBDW) += annotate-data.o
>   
>   perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
> +perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw-arch/
>   perf-util-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind-local.o
>   perf-util-$(CONFIG_LIBUNWIND)          += unwind-libunwind.o
>   perf-util-$(CONFIG_LIBUNWIND_X86)      += libunwind/x86_32.o
> diff --git a/tools/perf/util/unwind-libdw-arch/Build b/tools/perf/util/unwind-libdw-arch/Build
> new file mode 100644
> index 0000000000000000000000000000000000000000..e016d54ae2a40ecba47156c8f09cb72156105727
> --- /dev/null
> +++ b/tools/perf/util/unwind-libdw-arch/Build
> @@ -0,0 +1,8 @@
> +perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw-x86.o
> +perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw-arm.o
> +perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw-arm64.o
> +perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw-csky.o
> +perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw-loongarch.o
> +perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw-powerpc.o
> +perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw-riscv.o
> +perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw-s390.o
> \ No newline at end of file
> diff --git a/tools/perf/arch/arm/util/unwind-libdw.c b/tools/perf/util/unwind-libdw-arch/unwind-libdw-arm.c
> similarity index 88%
> rename from tools/perf/arch/arm/util/unwind-libdw.c
> rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-arm.c
> index fbb643f224ec4b27ce9d67051fe0bc4ad555b05e..c2718d6b6cff131cd67883e24bb0d3d963c8095a 100644
> --- a/tools/perf/arch/arm/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-arm.c
> @@ -1,11 +1,11 @@
>   // SPDX-License-Identifier: GPL-2.0
>   #include <elfutils/libdwfl.h>
> -#include "perf_regs.h"
> +#include "../../../arch/arm/include/uapi/asm/perf_regs.h"
>   #include "../../../util/unwind-libdw.h"
>   #include "../../../util/perf_regs.h"
>   #include "../../../util/sample.h"
>   
> -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> +bool libdw_set_initial_registers_arm(Dwfl_Thread *thread, void *arg)
>   {
>   	struct unwind_info *ui = arg;
>   	struct regs_dump *user_regs = perf_sample__user_regs(ui->sample);
> diff --git a/tools/perf/arch/arm64/util/unwind-libdw.c b/tools/perf/util/unwind-libdw-arch/unwind-libdw-arm64.c
> similarity index 92%
> rename from tools/perf/arch/arm64/util/unwind-libdw.c
> rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-arm64.c
> index b89b0a7e5ad919fed23643d219fbdc3d84deff1e..87602503e057badc6efd37169cc60c96cf3949ab 100644
> --- a/tools/perf/arch/arm64/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-arm64.c
> @@ -1,11 +1,11 @@
>   // SPDX-License-Identifier: GPL-2.0
>   #include <elfutils/libdwfl.h>
> -#include "perf_regs.h"
> +#include "../../../arch/arm64/include/uapi/asm/perf_regs.h"
>   #include "../../../util/unwind-libdw.h"
>   #include "../../../util/perf_regs.h"
>   #include "../../../util/sample.h"
>   
> -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> +bool libdw_set_initial_registers_arm64(Dwfl_Thread *thread, void *arg)
>   {
>   	struct unwind_info *ui = arg;
>   	struct regs_dump *user_regs = perf_sample__user_regs(ui->sample);
> diff --git a/tools/perf/arch/csky/util/unwind-libdw.c b/tools/perf/util/unwind-libdw-arch/unwind-libdw-csky.c
> similarity index 92%
> rename from tools/perf/arch/csky/util/unwind-libdw.c
> rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-csky.c
> index b20b1569783d7e982e91b1b40120d29ccf2f01d1..889d3b788931f3af55b03ef8b91d5def364972e5 100644
> --- a/tools/perf/arch/csky/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-csky.c
> @@ -2,12 +2,12 @@
>   // Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd.
>   
>   #include <elfutils/libdwfl.h>
> -#include "perf_regs.h"
> +#include "../../../arch/csky/include/uapi/asm/perf_regs.h"
>   #include "../../util/unwind-libdw.h"
>   #include "../../util/perf_regs.h"
> -#include "../../util/event.h"
> +#include "../../util/sample.h"
>   
> -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> +bool libdw_set_initial_registers_csky(Dwfl_Thread *thread, void *arg)
>   {
>   	struct unwind_info *ui = arg;
>   	struct regs_dump *user_regs = perf_sample__user_regs(ui->sample);
> diff --git a/tools/perf/arch/loongarch/util/unwind-libdw.c b/tools/perf/util/unwind-libdw-arch/unwind-libdw-loongarch.c
> similarity index 91%
> rename from tools/perf/arch/loongarch/util/unwind-libdw.c
> rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-loongarch.c
> index 60b1144bedd5f325e1512eeab05c29a1e8de2b03..1c5753ace6f63be771aa92365d3174ad8ed3a6fd 100644
> --- a/tools/perf/arch/loongarch/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-loongarch.c
> @@ -2,12 +2,12 @@
>   /* Copyright (C) 2020-2023 Loongson Technology Corporation Limited */
>   
>   #include <elfutils/libdwfl.h>
> -#include "perf_regs.h"
> +#include "../../../arch/loongarch/include/uapi/asm/perf_regs.h"
>   #include "../../util/unwind-libdw.h"
>   #include "../../util/perf_regs.h"
>   #include "../../util/sample.h"
>   
> -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> +bool libdw_set_initial_registers_loongarch(Dwfl_Thread *thread, void *arg)
>   {
>   	struct unwind_info *ui = arg;
>   	struct regs_dump *user_regs = perf_sample__user_regs(ui->sample);
> diff --git a/tools/perf/arch/powerpc/util/unwind-libdw.c b/tools/perf/util/unwind-libdw-arch/unwind-libdw-powerpc.c
> similarity index 93%
> rename from tools/perf/arch/powerpc/util/unwind-libdw.c
> rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-powerpc.c
> index 82d0c28ae3459ecdb0039cac1f534420d142739b..28635af3c4aa420faa4de7e53428d82917f78021 100644
> --- a/tools/perf/arch/powerpc/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-powerpc.c
> @@ -1,7 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0
>   #include <elfutils/libdwfl.h>
>   #include <linux/kernel.h>
> -#include "perf_regs.h"
> +#include "../../../arch/powerpc/include/uapi/asm/perf_regs.h"
>   #include "../../../util/unwind-libdw.h"
>   #include "../../../util/perf_regs.h"
>   #include "../../../util/sample.h"
> @@ -13,7 +13,7 @@ static const int special_regs[3][2] = {
>   	{ 109, PERF_REG_POWERPC_CTR },
>   };
>   
> -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> +bool libdw_set_initial_registers_powerpc(Dwfl_Thread *thread, void *arg)
>   {
>   	struct unwind_info *ui = arg;
>   	struct regs_dump *user_regs = perf_sample__user_regs(ui->sample);
> diff --git a/tools/perf/arch/riscv/util/unwind-libdw.c b/tools/perf/util/unwind-libdw-arch/unwind-libdw-riscv.c
> similarity index 92%
> rename from tools/perf/arch/riscv/util/unwind-libdw.c
> rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-riscv.c
> index dc1476e16321736de897ad53a00fbc813bd706db..2a5442b3b5bdc27252378de0073deb8a620f8779 100644
> --- a/tools/perf/arch/riscv/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-riscv.c
> @@ -2,12 +2,12 @@
>   /* Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd. */
>   
>   #include <elfutils/libdwfl.h>
> -#include "perf_regs.h"
> +#include "../../../arch/riscv/include/uapi/asm/perf_regs.h"
>   #include "../../util/unwind-libdw.h"
>   #include "../../util/perf_regs.h"
>   #include "../../util/sample.h"
>   
> -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> +bool libdw_set_initial_registers_riscv(Dwfl_Thread *thread, void *arg)
>   {
>   	struct unwind_info *ui = arg;
>   	struct regs_dump *user_regs = perf_sample__user_regs(ui->sample);
> diff --git a/tools/perf/arch/s390/util/unwind-libdw.c b/tools/perf/util/unwind-libdw-arch/unwind-libdw-s390.c
> similarity index 89%
> rename from tools/perf/arch/s390/util/unwind-libdw.c
> rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-s390.c
> index c27c7a0d1076c890c35ba19543932c4ed5ac9c2a..18d44074a55bc1c7fa2d7150afc1f1a93d4eadf8 100644
> --- a/tools/perf/arch/s390/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-s390.c
> @@ -4,11 +4,11 @@
>   #include "../../util/perf_regs.h"
>   #include "../../util/event.h"
>   #include "../../util/sample.h"
> -#include "dwarf-regs-table.h"
> -#include "perf_regs.h"
> +#include "../../arch/s390/include/dwarf-regs-table.h"
> +#include "../../../arch/s390/include/uapi/asm/perf_regs.h"
>   
>   
> -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> +bool libdw_set_initial_registers_s390(Dwfl_Thread *thread, void *arg)
>   {
>   	struct unwind_info *ui = arg;
>   	struct regs_dump *user_regs = perf_sample__user_regs(ui->sample);
> diff --git a/tools/perf/arch/x86/util/unwind-libdw.c b/tools/perf/util/unwind-libdw-arch/unwind-libdw-x86.c
> similarity index 94%
> rename from tools/perf/arch/x86/util/unwind-libdw.c
> rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-x86.c
> index 798493e887d7308cb293e29e4ba11054d0fda722..822e799fe1543d82dab27a8efeada3f5cde08a44 100644
> --- a/tools/perf/arch/x86/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-x86.c

You missed converting the unwind-libdw-x86.c perf_regs.h paths to a 
static arch so now Perf can only be built on x86. If you try to build 
for another arch then you get the local header and then missing x86 
definitions.

Unfortunately you also have to convert the one in 
tools/perf/arch/x86/include/perf_regs.h which is a bit weird, but the 
build seems to work.

Other than that, looks good.

> @@ -5,7 +5,7 @@
>   #include "../../../util/perf_regs.h"
>   #include "util/sample.h"
>   
> -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> +bool libdw_set_initial_registers_x86(Dwfl_Thread *thread, void *arg)
>   {
>   	struct unwind_info *ui = arg;
>   	struct regs_dump *user_regs = perf_sample__user_regs(ui->sample);
> diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
> index ae70fb56a05729b9f06a411d162eabebbf29ac52..4a0f13bc5af99de446d440c551c718ef0187e195 100644
> --- a/tools/perf/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw.c
> @@ -225,12 +225,46 @@ static bool memory_read(Dwfl *dwfl __maybe_unused, Dwarf_Addr addr, Dwarf_Word *
>   	return true;
>   }
>   
> -static const Dwfl_Thread_Callbacks callbacks = {
> -	.next_thread		= next_thread,
> -	.memory_read		= memory_read,
> -	.set_initial_registers	= libdw__arch_set_initial_registers,
> +#define DEFINE_DWFL_THREAD_CALLBACKS(arch)                           \
> +static const Dwfl_Thread_Callbacks callbacks_##arch = {              \
> +	.next_thread           = next_thread,                        \
> +	.memory_read           = memory_read,                        \
> +	.set_initial_registers = libdw_set_initial_registers_##arch, \
>   };
>   
> +DEFINE_DWFL_THREAD_CALLBACKS(x86)
> +DEFINE_DWFL_THREAD_CALLBACKS(arm)
> +DEFINE_DWFL_THREAD_CALLBACKS(arm64)
> +DEFINE_DWFL_THREAD_CALLBACKS(csky)
> +DEFINE_DWFL_THREAD_CALLBACKS(loongarch)
> +DEFINE_DWFL_THREAD_CALLBACKS(powerpc)
> +DEFINE_DWFL_THREAD_CALLBACKS(riscv)
> +DEFINE_DWFL_THREAD_CALLBACKS(s390)
> +
> +static const Dwfl_Thread_Callbacks *get_thread_callbacks(const char *arch)
> +{
> +	if (!strcmp(arch, "arm"))
> +		return &callbacks_arm;
> +	else if (!strcmp(arch, "arm64"))
> +		return &callbacks_arm64;
> +	else if (!strcmp(arch, "csky"))
> +		return &callbacks_csky;
> +	else if (!strcmp(arch, "loongarch"))
> +		return &callbacks_loongarch;
> +	else if (!strcmp(arch, "powerpc"))
> +		return &callbacks_powerpc;
> +	else if (!strcmp(arch, "riscv"))
> +		return &callbacks_riscv;
> +	else if (!strcmp(arch, "s390"))
> +		return &callbacks_s390;
> +	else if (!strcmp(arch, "x86"))
> +		return &callbacks_x86;
> +
> +	pr_err("Fail to get thread callbacks for arch %s, returns NULL\n",
> +	       arch);
> +	return NULL;
> +}
> +
>   static int
>   frame_callback(Dwfl_Frame *state, void *arg)
>   {
> @@ -278,6 +312,7 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
>   	const char *arch = perf_env__arch(ui_buf.machine->env);
>   	Dwarf_Word ip;
>   	int err = -EINVAL, i;
> +	const Dwfl_Thread_Callbacks *callbacks;
>   
>   	if (!data->user_regs || !data->user_regs->regs)
>   		return -EINVAL;
> @@ -300,7 +335,11 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
>   	if (err)
>   		goto out;
>   
> -	err = !dwfl_attach_state(ui->dwfl, EM_NONE, thread__tid(thread), &callbacks, ui);
> +	callbacks = get_thread_callbacks(arch);
> +	if (!callbacks)
> +		goto out;
> +
> +	err = !dwfl_attach_state(ui->dwfl, EM_NONE, thread__tid(thread), callbacks, ui);
>   	if (err)
>   		goto out;
>   
> diff --git a/tools/perf/util/unwind-libdw.h b/tools/perf/util/unwind-libdw.h
> index 8c88bc4f2304b59561ffd482469ca63ce0f531f0..574b29848cce31e6bfd93021f752b518cebf73b7 100644
> --- a/tools/perf/util/unwind-libdw.h
> +++ b/tools/perf/util/unwind-libdw.h
> @@ -9,7 +9,15 @@ struct machine;
>   struct perf_sample;
>   struct thread;
>   
> -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg);
> +bool libdw_set_initial_registers_x86(Dwfl_Thread *thread, void *arg);
> +bool libdw_set_initial_registers_arm(Dwfl_Thread *thread, void *arg);
> +bool libdw_set_initial_registers_arm64(Dwfl_Thread *thread, void *arg);
> +bool libdw_set_initial_registers_csky(Dwfl_Thread *thread, void *arg);
> +bool libdw_set_initial_registers_loongarch(Dwfl_Thread *thread, void *arg);
> +bool libdw_set_initial_registers_mips(Dwfl_Thread *thread, void *arg);
> +bool libdw_set_initial_registers_powerpc(Dwfl_Thread *thread, void *arg);
> +bool libdw_set_initial_registers_riscv(Dwfl_Thread *thread, void *arg);
> +bool libdw_set_initial_registers_s390(Dwfl_Thread *thread, void *arg);
>   
>   struct unwind_info {
>   	Dwfl			*dwfl;
> 
> ---
> base-commit: cbd41c6d4c26c161a2b0e70ad411d3885ff13507
> change-id: 20251223-cross-arch-unwind-d890d6a5ff0a
> 
> Best regards,

