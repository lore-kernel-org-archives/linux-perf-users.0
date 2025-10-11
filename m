Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4061A0BF3;
	Sat, 11 Oct 2025 03:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760154092; cv=none; b=ThdjwXVbdWQyoTpOTTaHP0NoCY6Kb5VrKYbTXyPqZt1uUY5DGwJN3JBG/4llIC74GXbmPkcBm7Vwpnmx0UlMpbNy2smNdC0XqjRmszE62IJqU65NsJYIe4C2HlpUOU/Fgh53b+wOrxcS6JM2Bngp3l5c3jL8xpjed6pauxg79iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760154092; c=relaxed/simple;
	bh=ber6fiQTrdqgt8W8VtTzVq1nCOhWhNwPiCVVPRg5OhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j2aw9YHeWspvoe88bg8TDulanJyzwyxxSFnn3ZoBO1p2UIbKHHcPyqIPOToCZLC2iNQuT08uqVaQ9I9ticAtaNnRJ+4YE9td/fQ+ut5LwAD1kUA/mqz8HnDMEvy5LSJUUW97eoMMPLY9uApjeNOSp7NeTTqqxGtCtvbQ6jzISpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W3K/hw7Y; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W3K/hw7Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760154091; x=1791690091;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ber6fiQTrdqgt8W8VtTzVq1nCOhWhNwPiCVVPRg5OhA=;
  b=W3K/hw7YCf4sTsPDwNT8tueQMaIyjAFQJ2exeAPowrLHQSy0HYXGv12A
   v5doXFr4PsKs0EW7yAK8sfb8xiWCSSBWw2K26hHjH+ELoI/RlBUksAj8z
   fek0zzsu4Hcy+uqTqLrrhud2k6Ywb99RHMOW1Ev/ERhJYdOXNv4udG4AW
   uv4DveMCw7o0/sjDJnbFrlqVS8Ffe+YhaKTguepF+0IS1xwnAGZPyk2TS
   J8yxFF6PPXdfTjuLYgo+Bu6ncYEYMB4ayutaHAO+5NqAqH98zE/d2Jr6n
   rZjrmDBZYKkQXsw1OHnoKSsokR2cV85sG/xMPg189iqTmOXKiJZnnjU85
   Q==;
X-CSE-ConnectionGUID: hlVyb01uQFygcWeSnTN8DQ==
X-CSE-MsgGUID: UqSHODbiSX6LUtKzZvvaSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="62412956"
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="62412956"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 20:41:30 -0700
X-CSE-ConnectionGUID: X3ap3ACpQYGaEF1ewEIjDg==
X-CSE-MsgGUID: Oj42qTq1Qee92Plxx+rlKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="181550746"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.209]) ([10.124.232.209])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 20:41:26 -0700
Message-ID: <d6b3e9e4-5a53-44d8-a740-c1826d8da24b@linux.intel.com>
Date: Sat, 11 Oct 2025 11:41:24 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tools headers: Remove unused kvm_perf.h copies
To: James Clark <james.clark@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Leo Yan <leo.yan@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20250910-james-tools-header-cleanup-v1-0-7ae4bedc99e0@linaro.org>
 <20250910-james-tools-header-cleanup-v1-1-7ae4bedc99e0@linaro.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250910-james-tools-header-cleanup-v1-1-7ae4bedc99e0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 9/10/2025 9:30 PM, James Clark wrote:
> These have been unused since commit 162607ea20fa ("perf kvm/{x86,s390}:
> Remove dependency on uapi/kvm_perf.h") in favour of dynamic discovery.
> Remove the unused headers to reduce consistency checking overhead and
> noise.
>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/arch/s390/include/uapi/asm/kvm_perf.h | 22 ----------------------
>  tools/arch/x86/include/uapi/asm/kvm_perf.h  | 17 -----------------
>  tools/perf/check-headers.sh                 |  2 --
>  3 files changed, 41 deletions(-)
>
> diff --git a/tools/arch/s390/include/uapi/asm/kvm_perf.h b/tools/arch/s390/include/uapi/asm/kvm_perf.h
> deleted file mode 100644
> index 84606b8cc49e4..0000000000000
> --- a/tools/arch/s390/include/uapi/asm/kvm_perf.h
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> -/*
> - * Definitions for perf-kvm on s390
> - *
> - * Copyright 2014 IBM Corp.
> - * Author(s): Alexander Yarygin <yarygin@linux.vnet.ibm.com>
> - */
> -
> -#ifndef __LINUX_KVM_PERF_S390_H
> -#define __LINUX_KVM_PERF_S390_H
> -
> -#include <asm/sie.h>
> -
> -#define DECODE_STR_LEN 40
> -
> -#define VCPU_ID "id"
> -
> -#define KVM_ENTRY_TRACE "kvm:kvm_s390_sie_enter"
> -#define KVM_EXIT_TRACE "kvm:kvm_s390_sie_exit"
> -#define KVM_EXIT_REASON "icptcode"
> -
> -#endif
> diff --git a/tools/arch/x86/include/uapi/asm/kvm_perf.h b/tools/arch/x86/include/uapi/asm/kvm_perf.h
> deleted file mode 100644
> index 125cf5cdf6c5f..0000000000000
> --- a/tools/arch/x86/include/uapi/asm/kvm_perf.h
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> -#ifndef _ASM_X86_KVM_PERF_H
> -#define _ASM_X86_KVM_PERF_H
> -
> -#include <asm/svm.h>
> -#include <asm/vmx.h>
> -#include <asm/kvm.h>
> -
> -#define DECODE_STR_LEN 20
> -
> -#define VCPU_ID "vcpu_id"
> -
> -#define KVM_ENTRY_TRACE "kvm:kvm_entry"
> -#define KVM_EXIT_TRACE "kvm:kvm_exit"
> -#define KVM_EXIT_REASON "exit_reason"
> -
> -#endif /* _ASM_X86_KVM_PERF_H */
> diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> index be519c433ce47..6eacc02fbb1b3 100755
> --- a/tools/perf/check-headers.sh
> +++ b/tools/perf/check-headers.sh
> @@ -40,13 +40,11 @@ declare -a FILES=(
>    "arch/s390/include/uapi/asm/perf_regs.h"
>    "arch/x86/include/uapi/asm/perf_regs.h"
>    "arch/x86/include/uapi/asm/kvm.h"
> -  "arch/x86/include/uapi/asm/kvm_perf.h"
>    "arch/x86/include/uapi/asm/svm.h"
>    "arch/x86/include/uapi/asm/unistd.h"
>    "arch/x86/include/uapi/asm/vmx.h"
>    "arch/powerpc/include/uapi/asm/kvm.h"
>    "arch/s390/include/uapi/asm/kvm.h"
> -  "arch/s390/include/uapi/asm/kvm_perf.h"
>    "arch/s390/include/uapi/asm/sie.h"
>    "arch/arm/include/uapi/asm/kvm.h"
>    "arch/arm64/include/uapi/asm/kvm.h"

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


