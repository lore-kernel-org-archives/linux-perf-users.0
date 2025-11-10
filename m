Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916DD2FF67F;
	Mon, 10 Nov 2025 09:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766148; cv=none; b=SpCOGb6nv8MA9HpFTeI0qPRHyaKnLq55HgsgbcedAz9vaEoXPM/Q0OYX4fMNPWCuM/zeZRkfU+yf0bRZaVWoFSKsdWdq9U7yDJL5tArPxpA+Guyz5OGkB56Gs+mZVLSBaWH/98q2ZBeQ1+k30lXws8umOrh0oB2NlWUK1n/qFF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766148; c=relaxed/simple;
	bh=IukqDhOGvnw1Tqz1mG0wAw9NUo+Um5BcYOuqetCh9ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GQAqjmbAmDfj5Y2IA3GuHmbz2K8EdAGHX4IpAtz4uP7pWWP0iw3bZpp07aoS45DGKP6b6OL8/tvKN3T1zW6qm7rm7YmJFxiCPxWyBLT93lp4d/Z91CGK2LlKJFmKvzMqE1/8qTx+E4vfaXyAVNs9TS1FXRAeidYTRGvWkk1WY2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zxqq0Edo; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zxqq0Edo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762766147; x=1794302147;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IukqDhOGvnw1Tqz1mG0wAw9NUo+Um5BcYOuqetCh9ls=;
  b=Zxqq0Edo8GzKI8gPzN98CdJEqvAmTkjJOLSG9winPZZsHk268DAneQ2O
   sOX9Q26JCV5IvQ0xgmLAdGAX57kqPSBNdchvH2rfkVjVIH1MDGcvHUaYn
   0MX9CPziFx0KyAFbwb56i9YA9nj5qzp8v9qGEhB5zmPWiy0EN1xwF5EwZ
   dyS5/JfkcDjwAOGUJf4Vy4sf21EtudQwKkrh+dk5zlo+FPlQAGERDSmTN
   C7bVKlNtwmP6GKRBFMum3omvbbYLEcVAtseqwKySqJP60Scy66NPjh+jH
   EqOgjfL4CNlC3DxjsnfhFzmc4JIiVGbu3SQBev/qeSkmebFCXht0dSRTo
   Q==;
X-CSE-ConnectionGUID: d8+6F621TlqZzkOnUjgg4w==
X-CSE-MsgGUID: G4qX3XiRReyVbRQiaKsXog==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="64722853"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="64722853"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 01:15:46 -0800
X-CSE-ConnectionGUID: jcdyeMmbTXWbgfKJdZq2Mg==
X-CSE-MsgGUID: vWfUZBPlQ4GI+VukwDNtcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="187932247"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 01:15:42 -0800
Message-ID: <97eb5ae9-6c99-497e-a1b9-80bf365bf2d5@linux.intel.com>
Date: Mon, 10 Nov 2025 17:15:39 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v9 10/12] perf/x86/intel: Update dyn_constranit base on
 PEBS event precise level
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
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251110090311.GW3245006@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/10/2025 5:03 PM, Peter Zijlstra wrote:
> On Mon, Nov 10, 2025 at 08:23:55AM +0800, Mi, Dapeng wrote:
>
>>> @@ -5536,6 +5540,14 @@ static void intel_pmu_check_dyn_constr(s
>>>  				continue;
>>>  			mask = hybrid(pmu, acr_cause_mask64) & GENMASK_ULL(INTEL_PMC_MAX_GENERIC - 1, 0);
>>>  			break;
>>> +		case DYN_CONSTR_PEBS:
>>> +			if (x86_pmu.arch_pebs)
>>> +				mask = hybrid(pmu, arch_pebs_cap).counters;
>>> +			break;
>>> +		case DYN_CONSTR_PDIST:
>>> +			if (x86_pmu.arch_pebs)
>>> +				mask = hybrid(pmu, arch_pebs_cap).pdists;
>>> +			break;
>>>  		default:
>>>  			pr_warn("Unsupported dynamic constraint type %d\n", i);
>>>  		}
>> Yes, exactly. Thanks.
> Excellent. Could you please double check and try the bits I have in
> queue/perf/core ? I don't think I've got v6 hardware at hand.

Sure. I would post test results tomorrow.


