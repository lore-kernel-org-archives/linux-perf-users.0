Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BF421767D;
	Mon, 17 Aug 2026 01:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786929175; cv=none; b=QEtKNWwZVMp0NzWCSEw2q3jRV9tltZBx/lj6YZ6NGxw1LT75/ieyKA0zUw52E6qx4H17Z9ykXg3qM6k3r9UulgBDfmIE78Oci37Kxyv32Vg3eewqj0vHogF0bqOjwKMyBcStj18S19S7zRaPYsGL1Ze5apPjHibTp2pBrpbhSc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786929175; c=relaxed/simple;
	bh=DuNt2AbzEABo28oyTfZ+rnyCxKTCMEJeoNThc4gi+HI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oyygUktTbflSAPf0XpWtXj+YnVT1TnQYSWo3tebh2e4hHu665WJ6H4+XW86UJN5hDe3L+4FlktCOtA96WVd8rGEi9YidQhnvgox1caojX9k7BRQtpbNUPMyYinAtEEbH++wPHkwOghh1AUKDXnv6+JQKJGcyx0nvKc6bR+PuXZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cr0l/egw; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cr0l/egw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786929173; x=1818465173;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DuNt2AbzEABo28oyTfZ+rnyCxKTCMEJeoNThc4gi+HI=;
  b=Cr0l/egwFUcXPjI8AHx+h0lv8ALjyvAq3xu89aMu+EdITaL5UX358ixI
   1faIDd3KVZEr68YoisVm8K1CxDdq4014NdStKEl04+t4BLM1DcWFpS/O5
   1cpp3VxxyLMeORs0ZNYYZsDBPJ5kV3xfXV4dxj75YkLhqL3LL4qrLy3xh
   hndf4O2nq7eO+zN9s9OCPV5jclbexs/TxmnJL6GSWF7XIJ4Gqp1vJtQkA
   NkcB3jZmKZ/LrRAyrG4avdpP4dL4+dOUyv49XPwFWoBxRsh9jLJwttaBr
   GiQpCB/UkWs+EdQ2IS7dYe/PRd2fZ3svRSOcjNZZOg8ZqwKtm6jb50TsT
   g==;
X-CSE-ConnectionGUID: IypUsQUpSxWZqN7GTlQ8wg==
X-CSE-MsgGUID: G3BKtRlLSMqhX6B7cqYzcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="98555653"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="98555653"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 18:12:52 -0700
X-CSE-ConnectionGUID: Z8KYKCYLQuazq/fmZzimQQ==
X-CSE-MsgGUID: qIY06DMPRRWIbgG9n+KAfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="262135040"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 18:12:47 -0700
Message-ID: <10376263-f9e7-4419-9042-074b3a36cfab@linux.intel.com>
Date: Mon, 17 Aug 2026 09:12:44 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] perf/x86: Fix perf_event_print_debug() on
 non-Intel PMUs
To: Sandipan Das <sandipan.das@amd.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
 Petr Tesarik <ptesarik@suse.com>, Zide Chen <zide.chen@intel.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>,
 Ananth Narayan <ananth.narayan@amd.com>
References: <cover.1786728929.git.sandipan.das@amd.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <cover.1786728929.git.sandipan.das@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The whole patch series looks good to me. Thanks.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

On 8/15/2026 1:48 AM, Sandipan Das wrote:
> Petr Tesarik reported that reading MSR_ARCH_PERFMON_FIXED_CTR_CTRL
> raises a #GP on AMD processors that support PerfMonV2, and proposed
> skipping that register when no fixed counters are implemented [1].
>
> However, perf_event_print_debug() also dumps the global control and
> status registers whenever x86_pmu.version >= 2, and reads Intel
> Architectural PerfMon MSRs to do so. That condition used to be
> Intel-specific, but since commit 21d59e3e2c40 ("perf/x86/amd/core:
> Detect PerfMonV2 support"), x86_pmu.version is also set to 2 on AMD
> processors that support PerfMonV2, where none of those registers are
> available.
>
> The same reasoning therefore applies to the other registers read here,
> so rather than special-casing each one or reinstating a vendor check,
> this series makes the global register dump a vendor-specific operation.
>
> [1] https://lore.kernel.org/all/20260717150315.2868314-1-ptesarik@suse.com/
>
> Previous versions can be found at
> v1: https://lore.kernel.org/all/cover.1786010408.git.sandipan.das@amd.com/
>
> Changes in v2:
>   * Address build issue reported by Sashiko.
>   * Use a static_call as suggested by Dapeng.
>   * Pick up Tested-by from Petr.
>
> Sandipan Das (3):
>   perf/x86: Add x86_pmu::print_debug
>   perf/x86: Move MSR_CORE_PERF_GLOBAL_* dump to vendor code
>   perf/x86/amd: Implement x86_pmu::print_debug
>
>  arch/x86/events/amd/core.c     | 20 ++++++++++++
>  arch/x86/events/core.c         | 60 ++++++++++++++++------------------
>  arch/x86/events/intel/core.c   | 32 ++++++++++++++++++
>  arch/x86/events/perf_event.h   |  4 +++
>  arch/x86/events/zhaoxin/core.c | 18 ++++++++++
>  5 files changed, 102 insertions(+), 32 deletions(-)
>
