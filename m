Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794983324;
	b=DISrBIk4uPFUjDeGwuMg8p/PFG8PWJI/VzUBDowGHW/MMToX4JIpPHYDm+rDG2KLtTW6
	 7xtUgAzAkTwfRM1VZdp+HTyl4bGFN1ZkigNU+NkGoGQ7hG+Py0Jj1/dy/T5XMOUOQMLia
	 DW6m+LeJ6l73ZfcHF0sC/uUdJ3sLhPXdLW4660LcICb5CQYuocEMxN1Ywfd397NQ8TR3s
	 PZtVNRxOCxlDRO91WiBjVa6qHuL9yXWcI717eWXx9lNt7YY3RCwrcqbRycinr6sofZdWB
	 6+3iGfff5p2iCiyfS10vbSQxm00EoYpQlb49a/WbF5nHT6MIrpN44iRVHcKpgfX4C4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794983324;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=h4eSDXcesypgTvBv1Ru4BHDaBWBHqHbkwH6cBiVPIr0=;
	b=0yrb8aShgTxMLV7z3PqP5SIbY70oLVd7zGFrCjYPNhj9tCuzMCYJblVg5QDyM5UqY4Mx
	 qLuWkwnUniJ3l0eENg1uNsTAB2FmSasXuAFOtO9DfeTdoofG3nDnrijHFcAv0TE3xGd2v
	 1ZkTHTiBtR9qavMQRzyJ3kOp7hplpTOeLGVACbG9QSbc0WxGgUzfdZYOFz56dQMXnXioX
	 MH6Enza8rtbQYrVIq+vcFatWDBGN1AxMQ0wMJa95TzUvWAc1Kx9a/lw2sGAklqQsEfrB0
	 As900R6auDluQi9ATC5n465e9kgSnevbJEdcwSOEYqzU9W0taUc/Jnv/gpi0PXZ33IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WrYMo4TX;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E1E606A31C;
	Wed, 18 Nov 2026 06:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7E1E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WrYMo4TX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794983323; x=1826519323;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jWZJboTc/5i1V3mEny3o1ig0m8S+eBjQShbqXeCRKxE=;
  b=WrYMo4TXRWdF3ubCZthaiFnC75hArpAeYoTKs/0Ek8G+ldO8VZonrRLX
   kHMZb4yzFqB48jrXCXh6LnUaPT8GagdD8iLwHJe8wER8XbMxdWcJLyuLH
   34Z/4RxlSvFMBye7MoaRkUR6vwcDYnfrilcHzEmvUFqflXFe2+1z4eTtX
   mA9sn7XceyNes9H2JZTg6uLRh8nbWXbXpfwTu6xSHjBPFqCM4ZUFVAFzF
   kKHZT19vpVapfRkckLCNFY9s/DzBo4U/2klwJnEazkfa1Xe+VrSEocHJf
   aVj7fyngWdWkLbaVwQcWJL6wm/YJ1zBafOdeBGsrWO8OxC9Iz/CdJmIik
   w==;
X-CSE-ConnectionGUID: HZNEdOpyS/SK13MJUmqUTA==
X-CSE-MsgGUID: mwnOywugRj+NEZAaDDkBvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3673512"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3673512"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 22:28:42 -0800
X-CSE-ConnectionGUID: kzdW81zRRRGke6p/jmW2pA==
X-CSE-MsgGUID: qGrdfkJxR225Js+GXTi1Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="11855620"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 22:28:35 -0800
Message-ID: <51f9a700-bd38-4187-87b6-f0fa3534bdb5@linux.intel.com>
Date: Wed, 18 Nov 2026 14:28:32 +0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v7 14/24] perf/x86/intel: Account lbr_pebs_users for
 arch-PEBS events
To: bot+bpf-ci@kernel.org, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
 ak@linux.intel.com, eranian@google.com, andrii@kernel.org, song@kernel.org,
 ravi.bangoria@amd.com, ananth.narayan@amd.com
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 bpf@vger.kernel.org, dapeng1.mi@intel.com, zide.chen@intel.com,
 thomas.falcon@intel.com, xudong.hao@intel.com, sashiko-bot@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 eddyz87@gmail.com, yonghong.song@linux.dev, mason@kernel.org,
 ihor.solodrai@linux.dev
References: <20261118031453.1353625-15-dapeng1.mi@linux.intel.com>
 <913204cab6fa4a1068980a05e1f85a400d7cadc0d2f60a818cd61f227cdb2e15@mail.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <913204cab6fa4a1068980a05e1f85a400d7cadc0d2f60a818cd61f227cdb2e15@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 11/18/2026 12:10 PM, bot+bpf-ci@kernel.org wrote:
>> perf/x86/intel: Account lbr_pebs_users for arch-PEBS events
> TL;DR:
> - On arch-PEBS, a non-PEBS branch-counter sibling event may report a stale
>   branch stack with zero counters until a later patch fixes it; consider
>   reordering
> - Fixes tag may point to the wrong commit
>
>>     perf/x86/intel: Account lbr_pebs_users for arch-PEBS events
>>
>>     lbr_pebs_users tracks how many PEBS events are currently using LBR.
>>     It is updated for legacy PEBS events, but arch-PEBS events were missing
>>     from that accounting.
>>
>>     Add the missing lbr_pebs_users accounting for arch-PEBS as well.
>>
>>     Fixes: d243d0bb64af ("perf/x86/intel: Initialize architectural PEBS")
>>     [ ... ]
>>     Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> d243d0bb64af only parses the arch-PEBS CPUID leaves and adds the
> enable/disable callbacks, it does not make arch-PEBS use LBR.  The
> ARCH_PEBS_LBR handling and PERF_SAMPLE_BRANCH_STACK in large_pebs_flags
> came with 52448a0a7390, which predates this series.
>
> Should the tag point there instead:
>
>   Fixes: 52448a0a7390 ("perf/x86/intel: Setup PEBS data configuration and enable legacy groups")

Not exactly. The arch-PEBS feature including the arch-PEBS assisted LBR
snapshotting is supported by a bunch of patches instead of a single patch,
e.g., the commit d243d0bb64af enumerates if the arch-PEBS has the
capability to support LBR snapshot, it's a more appropriate and accurate
commit comparing with 52448a0a7390.


>
>> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
>> --- a/arch/x86/events/intel/lbr.c
>> +++ b/arch/x86/events/intel/lbr.c
> [ ... ]
>
>> @@ -616,7 +616,7 @@ void intel_pmu_lbr_add(struct perf_event *event)
>>  	 * be 'new'. Conversely, a new event can get installed through the
>>  	 * context switch path for the first time.
>>  	 */
>> -	if (x86_pmu.intel_cap.pebs_baseline && event->attr.precise_ip > 0)
>> +	if (intel_pmu_has_pebs_lbr(event->pmu) && event->attr.precise_ip > 0)
>>  		cpuc->lbr_pebs_users++;
>>  	perf_sched_cb_inc(event->pmu);
>>  	if (!cpuc->lbr_users++ && !event->total_time_running)
> Can this make a non-PEBS branch counter event report a stale branch stack
> on arch-PEBS platforms?
>
> With lbr_pebs_users now non-zero on arch-PEBS, the existing shortcut in
> intel_pmu_handle_irq() is taken:
>
>     if (cpuc->lbr_users != cpuc->lbr_pebs_users)
>         intel_pmu_lbr_read(cpu_lbr_stack(cpuc), cpuc->lbr_counters);
>
> That shortcut assumes every consumer of the LBR stack is counted in
> lbr_users.  An event whose branch_sample_type is only
> PERF_SAMPLE_BRANCH_COUNTERS plus PLM bits has
> PERF_X86_EVENT_NEEDS_BRANCH_STACK cleared in intel_pmu_hw_config(), so
> intel_pmu_add_event() never calls intel_pmu_lbr_add() for it and it is not
> counted in lbr_users.  It still has has_branch_stack() set and samples
> through the non-PEBS path in handle_pmi_common():
>
>     if (has_branch_stack(event))
>         intel_pmu_lbr_save_brstack(&data, cpuc, event);
>
> Consider a group on an arch-PEBS CPU with ARCH_PEBS_LBR and PMU_FL_BR_CNTR,
> with a precise leader using branch_type=any,counter and a non-precise
> sampling sibling using only branch_type=counter.  After this patch
> lbr_users == 1 and lbr_pebs_users == 1.  If only the sibling overflows,
> intel_pmu_lbr_read() is skipped, and intel_pmu_lbr_save_brstack() ->
> intel_pmu_lbr_counters_reorder() works on whatever cpu_lbr_stack(cpuc)
> last held.  That is either nr == 0 after intel_pmu_lbr_reset(), or the
> leader's last PEBS-record snapshot from intel_pmu_store_pebs_lbrs(),
> whose raw counters in entries[i].reserved were already zeroed when the
> leader's sample was saved.
>
> So the sibling would report a stale branch stack with all branch counters
> zero, where before this patch it got the live LBR state.  The same
> problem already exists for legacy adaptive PEBS (pebs_baseline), and this
> patch extends it to arch-PEBS.
>
> This looks to be addressed later in the series by 0479605ddd39
> ("perf/x86/intel: Account LBR user counts for pure branch counter
> events"), and 9edb70d448eb ("perf/x86/intel: Refresh LBR stack for
> non-PEBS LBR events when needed") replaces the lbr_users != lbr_pebs_users
> check at PMI entry with an on-demand re-read.  Would it make sense to
> order 0479605ddd39 before this patch so the intermediate state does not
> regress?

Hmm, I don't think the patch order matters. If we put the commit
9edb70d448eb ahead before this patch, the whole arch-PEBS assisted LBR
snapshot won't be counted without this patch regardless of it's a pure
branch counter event. It seems worse. 

Thanks.



>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44231525404
