Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62F94A01;
	Thu,  9 Oct 2025 08:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759998922; cv=none; b=TUFBZ70xihrJjig6hE2JYolGbyM4qWndMwQZdNSW2csfkaAgyN/gosmk7hi9h8K+bdK1mxUGz4y7nEex2LvddP/yUpF+25QFWWQPQwyuK6/+AmfMFzWGPW7TI/2u0OhZH5Zh2PHZ5gANy6vKNA9P7cRs0NsFNj/vZGJgppAkieE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759998922; c=relaxed/simple;
	bh=cxIbOqNUR76AnDJ8XYf468KSYN5jwnxzGtZjYBXTQM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZhwwtU6t/q7a8Tqp6hlWC8Df8FzyZJbXMTl10jOhbSPSu0EkW14BoqjNOTWMdJFEo5nCjbf/qpsDoGQqsLNt/qg3SWFIWxUuD+SLLgFORYd835jVM7p8qwgx8egVcXhLzMQDqMq7Fn6PyDb7ECLfBC8zPYXBG1G4D4uLvkETeX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vk0NKy7f; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vk0NKy7f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759998921; x=1791534921;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cxIbOqNUR76AnDJ8XYf468KSYN5jwnxzGtZjYBXTQM4=;
  b=Vk0NKy7fKxlQKFGRk4Ykugl9w/pxtiyz3qABXiS46sENW4MI4x7r/r+8
   5kWUC+4KxOaH93a1vkwyuEYIYHOv7859SCxagE/pgdj7JpgzIrcP4hpaW
   dwmD8JQe4ruoUTzocOMV14whAqoQLD6WQC/1dy8Kz9sIvdlLC7QV10IgK
   yU81+A327IXWXMEqOoGo7SYKSa0nXGDEjcMN0DPpaekfkE5NCVo9z2TI7
   mddulp9L6iSzsCZeoSFeeJ/f630QMt++jxasKs6zBGV8Tn9HYLaFvvOLw
   jwTS0CV0JGm9ROM0o3yd+UF9nMk9PHlt/+mzS8F4lKSxBUquTAC0UObMR
   A==;
X-CSE-ConnectionGUID: GJ1aI5XjQhSLWYWMj9dR6w==
X-CSE-MsgGUID: vzPerdInTnCCGtqwxnHK5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="72462630"
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="72462630"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 01:35:21 -0700
X-CSE-ConnectionGUID: cXIzzForQoaKN8tGXHcSPg==
X-CSE-MsgGUID: vQA6LQBqS1qo3f2NMRZ3hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="181065729"
Received: from unknown (HELO [10.238.2.75]) ([10.238.2.75])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 01:35:17 -0700
Message-ID: <cef60d5a-a975-4b4e-b553-9aaaaf6da558@linux.intel.com>
Date: Thu, 9 Oct 2025 16:35:15 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v7 00/12] arch-PEBS enabling for Intel platforms
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
 Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20250828013435.1528459-1-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250828013435.1528459-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/28/2025 9:34 AM, Dapeng Mi wrote:
> Changes:
> v6 -> v7:
>   * Rebase code to last tip perf/core tree.
>   * Opportunistically remove the redundant is_x86_event() prototype.
>     (Patch 01/12)
>   * Fix PEBS handler NULL event access and record loss issue.
>     (Patch 02/12)
>   * Reset MSR_IA32_PEBS_INDEX at the head of_drain_arch_pebs() instead
>     of end. It avoids the processed PEBS records are processed again in
>     some corner cases like event throttling. (Patch 08/12)

Hi Peter,

Do you have more comments on this arch-PEBS enabling patch-set? Thanks.

(The warning raised by kernel test robot about patch 02/12 would be fixed
in next version.)


>
> v5 -> v6:
>   * Rebase code to last tip perf/core tree + "x86 perf bug fixes and
>     optimization" patchset
>  
> v4 -> v5:
>   * Rebase code to 6.16-rc3
>   * Allocate/free arch-PEBS buffer in callbacks *prepare_cpu/*dead_cpu
>     (patch 07/10, Peter)
>   * Code and comments refine (patch 09/10, Peter)
>
>
> This patchset introduces architectural PEBS support for Intel platforms
> like Clearwater Forest (CWF) and Panther Lake (PTL). The detailed
> information about arch-PEBS can be found in chapter 11
> "architectural PEBS" of "Intel Architecture Instruction Set Extensions
> and Future Features".
>
> This patch set doesn't include the SSP and SIMD regs (OPMASK/YMM/ZMM)
> sampling support for arch-PEBS to avoid the dependency for the basic
> SIMD regs sampling support patch series[1]. Once the basic SIMD regs
> sampling is supported, the arch-PEBS based SSP and SIMD regs
> (OPMASK/YMM/ZMM) sampling would be supported in a later patch set.
>
> Tests:
>   Run below tests on Clearwater Forest and Pantherlake, no issue is
>   found.
>
>   1. Basic perf counting case.
>     perf stat -e '{branches,branches,branches,branches,branches,branches,branches,branches,cycles,instructions,ref-cycles}' sleep 1
>
>   2. Basic PMI based perf sampling case.
>     perf record -e '{branches,branches,branches,branches,branches,branches,branches,branches,cycles,instructions,ref-cycles}' sleep 1
>
>   3. Basic PEBS based perf sampling case.
>     perf record -e '{branches,branches,branches,branches,branches,branches,branches,branches,cycles,instructions,ref-cycles}:p' sleep 1
>
>   4. PEBS sampling case with basic, GPRs, vector-registers and LBR groups
>     perf record -e branches:p -Iax,bx,ip,xmm0 -b -c 10000 sleep 1
>
>   5. User space PEBS sampling case with basic, GPRs and LBR groups
>     perf record -e branches:p --user-regs=ax,bx,ip -b -c 10000 sleep 1
>
>   6. PEBS sampling case with auxiliary (memory info) group
>     perf mem record sleep 1
>
>   7. PEBS sampling case with counter group
>     perf record -e '{branches:p,branches,cycles}:S' -c 10000 sleep 1
>
>   8. Perf stat and record test
>     perf test 100; perf test 131
>
>
> History:
>   v6: https://lore.kernel.org/all/20250821035805.159494-1-dapeng1.mi@linux.intel.com/ 
>   v5: https://lore.kernel.org/all/20250623223546.112465-1-dapeng1.mi@linux.intel.com/
>   v4: https://lore.kernel.org/all/20250620103909.1586595-1-dapeng1.mi@linux.intel.com/
>   v3: https://lore.kernel.org/all/20250415114428.341182-1-dapeng1.mi@linux.intel.com/
>   v2: https://lore.kernel.org/all/20250218152818.158614-1-dapeng1.mi@linux.intel.com/
>   v1: https://lore.kernel.org/all/20250123140721.2496639-1-dapeng1.mi@linux.intel.com/
>
> Ref:
>   [1]: https://lore.kernel.org/all/20250815213435.1702022-1-kan.liang@linux.intel.com/
>
> Dapeng Mi (12):
>   perf/x86: Remove redundant is_x86_event() prototype
>   perf/x86/intel: Fix NULL event access and potential PEBS record loss
>   perf/x86/intel: Replace x86_pmu.drain_pebs calling with static call
>   perf/x86/intel: Correct large PEBS flag check
>   perf/x86/intel: Initialize architectural PEBS
>   perf/x86/intel/ds: Factor out PEBS record processing code to functions
>   perf/x86/intel/ds: Factor out PEBS group processing code to functions
>   perf/x86/intel: Process arch-PEBS records or record fragments
>   perf/x86/intel: Allocate arch-PEBS buffer and initialize PEBS_BASE MSR
>   perf/x86/intel: Update dyn_constranit base on PEBS event precise level
>   perf/x86/intel: Setup PEBS data configuration and enable legacy groups
>   perf/x86/intel: Add counter group support for arch-PEBS
>
>  arch/x86/events/core.c            |  21 +-
>  arch/x86/events/intel/core.c      | 268 ++++++++++++-
>  arch/x86/events/intel/ds.c        | 621 +++++++++++++++++++++++++-----
>  arch/x86/events/perf_event.h      |  41 +-
>  arch/x86/include/asm/intel_ds.h   |  10 +-
>  arch/x86/include/asm/msr-index.h  |  20 +
>  arch/x86/include/asm/perf_event.h | 116 +++++-
>  7 files changed, 955 insertions(+), 142 deletions(-)
>
>
> base-commit: f49e1be19542487921e82b29004908966cb99d7c
