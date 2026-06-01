Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529D113D891;
	Mon,  1 Jun 2026 03:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780283067; cv=none; b=Pn7XNmiVavE4HqoX6Avdys92AE8Y2IdzUVTdOUX6Kx5DhFXD5Bt7Pa7+VP/PWIhf868ro/Bm4DejUjWrRx+dc99ixtRIpn95homw8AaVpan2NuCa4+NpXY0eRk2Q3PU2Z+nq+UA9EBJ72L3pNdqyEF9/bU7PxvgYQyoZj1Na8/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780283067; c=relaxed/simple;
	bh=qK2cRD+rk/+KqD7/dKqqx2U/xBiiXQj1Vjl/Fpsw8+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cavfCev0iB+Qqg9L+OpOUhtb2BujsMMkjQgrSqJgu1F285r+FrwYlHOM1grScSxks6JGsLmNYm/4E4Wop3kXcgPhAv+5Bpmb6i5lPjwGwtz/TrMatGGa4YMKFiPY2HJb/dluboidCNzQ3IclNnYb2rRaULNgVkFrbFFkGvqtWSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E9iqwEH8; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E9iqwEH8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780283066; x=1811819066;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qK2cRD+rk/+KqD7/dKqqx2U/xBiiXQj1Vjl/Fpsw8+k=;
  b=E9iqwEH8dv43HDrIQSgLK9/o604pXomNAXLBrwuFaCqbHQVtz8+kcxis
   Wj4DE3GckobcW8DoPOHxRjYtbldKW30RnIiGmQOEdxD/Tm/GsZJtK6/va
   W46CDsVJ2hTqD4/yBx/38xXnXIqS6ZrNUQf1onyQl2RcHgPMtwooLGyh3
   1vvcrAz2yVK8p+eneMkAtDhx0j9hMvwlkk9lfAIpQmh87I/Q8pRzJtFeu
   dRBVs8XQNs6PjJmRem80vLhcZ9s+IrrabdbxCbgB6YEpIS8lr41LNSmVT
   rxmf5Uu25kAu7lXU+/ceQ4kpTZHS0CI9anNZwoSRftBjzhuxeNXpMKITK
   g==;
X-CSE-ConnectionGUID: Mevm7M7RQGuGWqf/DM6/Eg==
X-CSE-MsgGUID: T8X6uY8nQwm0Wsyx+Yfk5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="84923082"
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="84923082"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 20:04:25 -0700
X-CSE-ConnectionGUID: ipj4Ba1NSV6hqe4IAbHvMw==
X-CSE-MsgGUID: q7l4tNhDRo+DWbeir6LKTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="248535990"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 20:04:19 -0700
Message-ID: <35d7ddaf-350d-46ef-8c9f-08ba88c55b13@linux.intel.com>
Date: Mon, 1 Jun 2026 11:04:17 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v8 10/23] perf/x86: Enable XMM Register Sampling for
 Non-PEBS Events
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Xudong Hao <xudong.hao@intel.com>, Kan Liang <kan.liang@linux.intel.com>
References: <20260529075645.580362-1-dapeng1.mi@linux.intel.com>
 <20260529075645.580362-11-dapeng1.mi@linux.intel.com>
 <20260529113824.GK3493090@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260529113824.GK3493090@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 5/29/2026 7:38 PM, Peter Zijlstra wrote:
> On Fri, May 29, 2026 at 03:56:32PM +0800, Dapeng Mi wrote:
>> Previously, XMM register sampling was only available for PEBS events
>> starting from Icelake. Currently the support is now extended to non-PEBS
>> events by utilizing the xsaves instruction, thereby completing the
>> feature set.
>>
>> To implement this, a 64-byte aligned buffer is required. A per-CPU
>> ext_regs_buf is introduced to store SIMD and other registers, with an
>> approximate size of 2K. The buffer is allocated using kzalloc_node(),
>> ensuring natural and 64-byte alignment for all kmalloc() allocations
>> with powers of 2.
>>
>> XMM sampling for non-PEBS events is supported in the REGS_INTR case.
>> Support for REGS_USER will be added in a subsequent patch. For PEBS
>> events, XMM register sampling data is directly retrieved from PEBS
>> records.
>>
>> Future support for additional vector registers (YMM/ZMM/OPMASK) is
>> planned. An `ext_regs_mask` is added to track the supported vector
>> register groups.
>>
>> Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> I suspect Sashiko's last point is valid and using XMM sampling on older
> PEBS will not do the right thing.
>
> Creating PEBS events with XMM reg sampling should fail if the hardware
> doesn't support it. That said, I could easily have missed a check for
> this, this code is a bit of a maze :/

Hmm, yeah. Currently the SIMD/eGPRs/SSP sampling is designed to support for
non-PEBS and PEBS events and they shared "intr-regs" and "user-regs"
options in perf tools, so the capability PERF_PMU_CAP_EXTENDED_REGS is set
as long as either non-PEBS or PEBS can support it. 

This indeed cause some inconsistency and mess. I would strengthen the check
and only set the flag when both PEBS and non-PEBS simultaneously support it.

Thanks.


>
