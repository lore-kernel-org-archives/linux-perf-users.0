Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C853277CA4;
	Tue, 11 Nov 2025 05:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762839674; cv=none; b=JWWqi8K0kx1NnWYytPU73HN683mo1azGBOrmHmODMAzng1kzEkzNXGMtbBgESfuAcZIXreG8I5WACI3smjOTkJACYk87dr5EwLChwBDSNq+oBFLZaSdPUAjy2J3K04DAfwBzkvABIm9KGWaIbonIcnmCs5JsOZPO/ORlEbRx4WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762839674; c=relaxed/simple;
	bh=UKl5cfWkfDgqLxhiY9LC9q152AImaFSKN5Q/dzKwFqk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jOjy+kbMJXN9JS7ClKhK7koDPwTxwo+O7gDVw+ZvxdRLptmD9okKFzmFon9jvEj8THV6uWYWPXIVVB2juFKGY66DNKRlQ+wQx7NODE2EYdMBiU2WCLqyjiPZqn4esjhzENfOxR3Tec7rLGR2Q4be5LU8QzOJOy+3g2cftB53s+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F2ryLoyj; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F2ryLoyj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762839672; x=1794375672;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=UKl5cfWkfDgqLxhiY9LC9q152AImaFSKN5Q/dzKwFqk=;
  b=F2ryLoyjUKDCKTNO/zB0J6hNWPIzl6UvKvSnR+lWUzvdFLSpXL0AXoiF
   CfRYwmauq2skE/iymk6AgBbnupGv95HiuZBRxf+r3raOtnDy7UdBWAiFl
   CmFSNmqZujLddVDGiYfEP5m57vkPnaV2cFxOJwhrUq8ElbSgKeYbyYruP
   eOU4j5kl6l963fuLGTIWWIHTV7KuSZ4Oab5AmthJOHoJis1pDOwEU0Jvg
   nyt1tYZwBhe+FcEqIucr0NaoQNGFw60T+xQSc27okUuxVHHJfwgcu/ixK
   V8wNiKnkXhMY/NCqToBpFfu0Tsy3WG0a5PAMOyXNxuxeph5jNoyYe1Nfc
   g==;
X-CSE-ConnectionGUID: slp9QvKESH+jj56V3GMduw==
X-CSE-MsgGUID: VmfqLawvSLuIRR3MoYCq8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="75510432"
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="75510432"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 21:41:11 -0800
X-CSE-ConnectionGUID: OQsyqQzYQW6c4U4u+n0Xlg==
X-CSE-MsgGUID: c+qFuzkIRRuGvb8EGikU7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="189613671"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 21:41:08 -0800
Message-ID: <380fd742-a7ed-4d6f-9944-b963869a5cb3@linux.intel.com>
Date: Tue, 11 Nov 2025 13:41:05 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v9 10/12] perf/x86/intel: Update dyn_constranit base on
 PEBS event precise level
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20251029102136.61364-1-dapeng1.mi@linux.intel.com>
 <20251029102136.61364-11-dapeng1.mi@linux.intel.com>
 <20251106145217.GA4067720@noisy.programming.kicks-ass.net>
 <09210c12-cc61-4af5-bd13-830fd9650f9b@linux.intel.com>
 <20251107130552.GB4067720@noisy.programming.kicks-ass.net>
 <a0416429-23d4-4f4f-af73-bcd87b4e773c@linux.intel.com>
 <20251110090311.GW3245006@noisy.programming.kicks-ass.net>
 <97eb5ae9-6c99-497e-a1b9-80bf365bf2d5@linux.intel.com>
Content-Language: en-US
In-Reply-To: <97eb5ae9-6c99-497e-a1b9-80bf365bf2d5@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 11/10/2025 5:15 PM, Mi, Dapeng wrote:
> On 11/10/2025 5:03 PM, Peter Zijlstra wrote:
>> On Mon, Nov 10, 2025 at 08:23:55AM +0800, Mi, Dapeng wrote:
>>
>>>> @@ -5536,6 +5540,14 @@ static void intel_pmu_check_dyn_constr(s
>>>>  				continue;
>>>>  			mask = hybrid(pmu, acr_cause_mask64) & GENMASK_ULL(INTEL_PMC_MAX_GENERIC - 1, 0);
>>>>  			break;
>>>> +		case DYN_CONSTR_PEBS:
>>>> +			if (x86_pmu.arch_pebs)
>>>> +				mask = hybrid(pmu, arch_pebs_cap).counters;
>>>> +			break;
>>>> +		case DYN_CONSTR_PDIST:
>>>> +			if (x86_pmu.arch_pebs)
>>>> +				mask = hybrid(pmu, arch_pebs_cap).pdists;
>>>> +			break;
>>>>  		default:
>>>>  			pr_warn("Unsupported dynamic constraint type %d\n", i);
>>>>  		}
>>> Yes, exactly. Thanks.
>> Excellent. Could you please double check and try the bits I have in
>> queue/perf/core ? I don't think I've got v6 hardware at hand.
> Sure. I would post test results tomorrow.

Hi Peter,

I tested the queue/perf/core code with a slight code refine on SPR/CWF/PTL.
In summary, all things look good. The constraints validation passes on all
these 3 platforms, no overlapped constraints are reported. Besides, perf
counting/sampling (both legacy PEBS and arch-PEBS) works well, no issue is
found.

I did a slight change for the intel_pmu_check_dyn_constr() helper. It
should be good enough to only validate the GP counters for the PEBS counter
and PDIST constraint check. Beside the code style is refined
opportunistically. Thanks.

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index aad89c9d9514..81e6c8bcabde 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5506,7 +5506,7 @@ static void __intel_pmu_check_dyn_constr(struct
event_constraint *constr,
                        }

                        if (check_fail) {
-                               pr_info("The two events 0x%llx and 0x%llx
may not be "
+                               pr_warn("The two events 0x%llx and 0x%llx
may not be "
                                        "fully scheduled under some
circumstances as "
                                        "%s.\n",
                                        c1->code, c2->code,
dyn_constr_type_name[type]);
@@ -5519,6 +5519,7 @@ static void intel_pmu_check_dyn_constr(struct pmu *pmu,
                                       struct event_constraint *constr,
                                       u64 cntr_mask)
 {
+       u64 gp_mask = GENMASK_ULL(INTEL_PMC_MAX_GENERIC - 1, 0);
        enum dyn_constr_type i;
        u64 mask;

@@ -5533,20 +5534,25 @@ static void intel_pmu_check_dyn_constr(struct pmu *pmu,
                                mask = x86_pmu.lbr_counters;
                        break;
                case DYN_CONSTR_ACR_CNTR:
-                       mask = hybrid(pmu, acr_cntr_mask64) &
GENMASK_ULL(INTEL_PMC_MAX_GENERIC - 1, 0);
+                       mask = hybrid(pmu, acr_cntr_mask64) & gp_mask;
                        break;
                case DYN_CONSTR_ACR_CAUSE:
-                       if (hybrid(pmu, acr_cntr_mask64) == hybrid(pmu,
acr_cause_mask64))
+                       if (hybrid(pmu, acr_cntr_mask64) ==
+                                       hybrid(pmu, acr_cause_mask64))
                                continue;
-                       mask = hybrid(pmu, acr_cause_mask64) &
GENMASK_ULL(INTEL_PMC_MAX_GENERIC - 1, 0);
+                       mask = hybrid(pmu, acr_cause_mask64) & gp_mask;
                        break;
                case DYN_CONSTR_PEBS:
-                       if (x86_pmu.arch_pebs)
-                               mask = hybrid(pmu, arch_pebs_cap).counters;
+                       if (x86_pmu.arch_pebs) {
+                               mask = hybrid(pmu, arch_pebs_cap).counters &
+                                      gp_mask;
+                       }
                        break;
                case DYN_CONSTR_PDIST:
-                       if (x86_pmu.arch_pebs)
-                               mask = hybrid(pmu, arch_pebs_cap).pdists;
+                       if (x86_pmu.arch_pebs) {
+                               mask = hybrid(pmu, arch_pebs_cap).pdists &
+                                      gp_mask;
+                       }
                        break;
                default:
                        pr_warn("Unsupported dynamic constraint type %d\n", i);


>
>
>
