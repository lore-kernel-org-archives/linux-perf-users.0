Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457BD30BF4E;
	Wed, 13 May 2026 16:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690870; cv=none; b=kkS61+jGXT5swEgZYbb/HAs1f7zTsd7rzCS40jfSLIlkllOmCLsPrxdKeBlo2OSqDkPVUEKNzjp6LsPY8tVYyf1A0f5BnrSq9Nfeowdn2Hzdz0UFHLqaYJ8k+dgZjcxWvEZaj8IS+qTgb4jzcgx8Xkqp4zwVZR/n8q0AozotPmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690870; c=relaxed/simple;
	bh=J28Rn9W9qYy8gc8RaoS/PziKhq51PSOKsH2UmhHXMNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PhplMzjrihYX14agzQVCvnzbyc3IUIGFxmd5OXR3gfQvJjENnoRZOt6cnLFPPxK2R4GrfEvfuWHBLCgZfBAau3OFYpa8O/DUUuRYrPzOa6427ENmoUkItyum/WAEVvZ/1vsbrKAzNiU22WVPCjCVXTRzzqAw3FLBSyOGpU7gb7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cKhvB1PY; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cKhvB1PY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778690868; x=1810226868;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=J28Rn9W9qYy8gc8RaoS/PziKhq51PSOKsH2UmhHXMNA=;
  b=cKhvB1PYB0AUkg7oV/OsanbLUvHB6dkWo822Eu3q1bgUU3crGVOclhvz
   ebxc6e3dqal0WEvEILKzV3P8ZID+VjO8epb+JkXRKpPbhB45IAscS1Gw0
   5JPKcbly5HxjwWt7v+/SjnvXG+ebF14C7wLw6MBknTkP5RwsrbINWRqkX
   tJa7CYJbnU+hGzoSz7SUCxs+KeyrLyx46L6E6k0tqEQ96OjlmUt663GBQ
   aPZva1/S+v2+gCHjD5rBCfVNicJkZ+tbR2wAva3hN6SKu6N7RiJ4Pygo0
   Vq/58JAp7kemc1xI3iihx3aWYbRVYwouSEmYgi07ezG4dF1ChNInv2Nk8
   A==;
X-CSE-ConnectionGUID: UOXtgqgFSMinlP7enGbeCw==
X-CSE-MsgGUID: h3wwr1xwR8+xSeVi7JfWxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="79739427"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="79739427"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 09:47:48 -0700
X-CSE-ConnectionGUID: N3vImn1GQ/W5b77qVOPUbA==
X-CSE-MsgGUID: m+HSpuI+QBiYIQiiYUS1xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="235466293"
Received: from unknown (HELO [10.241.241.90]) ([10.241.241.90])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 09:47:47 -0700
Message-ID: <ad31475e-e04f-4bef-91df-34215d5133a7@intel.com>
Date: Wed, 13 May 2026 09:47:46 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] perf/x86/intel/uncore: Implement lazy setup for
 MSR/MMIO PMU
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260512233048.9577-1-zide.chen@intel.com>
 <20260512233048.9577-8-zide.chen@intel.com>
 <607f0708-e437-4835-bc3d-169fe45e8320@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <607f0708-e437-4835-bc3d-169fe45e8320@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/13/2026 2:03 AM, Mi, Dapeng wrote:
> 
> On 5/13/2026 7:30 AM, Zide Chen wrote:
>> MSR and MMIO uncore PMUs are currently registered at module init time
>> and appear in sysfs even when no PMU boxes are functional.
>>
>> Apply the same lazy registration model used by PCI uncore PMUs: the
>> PMU is registered when the first box is successfully initialized, and
>> unregistered when the last box exits.  If a box fails to initialize on
>> a subsequent die, the PMU is marked broken but remains registered to
>> avoid disrupting any in-flight perf events.
>>
>> Box allocation and free remain at module init/exit time to avoid
>> repeated kfree/alloc cycles across CPU offline/online events.
>>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>>  arch/x86/events/intel/uncore.c | 72 ++++++----------------------------
>>  1 file changed, 12 insertions(+), 60 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
>> index 399f434e1a7d..2aaac0b49bb6 100644
>> --- a/arch/x86/events/intel/uncore.c
>> +++ b/arch/x86/events/intel/uncore.c
>> @@ -1564,8 +1564,11 @@ static void uncore_box_unref(struct intel_uncore_type **types, int die)
>>  		for (i = 0; i < type->num_boxes; i++, pmu++) {
>>  			box = pmu->boxes[die];
>>  			if (box && box->cpu >= 0 &&
>> -			    atomic_dec_return(&box->cpu_refcnt) == 0)
>> +			    atomic_dec_return(&box->cpu_refcnt) == 0) {
>> +				if (atomic_dec_return(&pmu->die_refcnt) == 0)
>> +					uncore_pmu_unregister(pmu);
>>  				uncore_box_exit(box);
>> +			}
>>  		}
>>  	}
>>  }
>> @@ -1659,7 +1662,7 @@ static int uncore_box_ref(struct intel_uncore_type **types,
>>  			box = pmu->boxes[die];
>>  			if (box && box->cpu >= 0 &&
>>  			    atomic_inc_return(&box->cpu_refcnt) == 1)
>> -				uncore_box_init(box);
>> +				uncore_box_setup(pmu, box);
>>  		}
>>  	}
>>  	return 0;
>> @@ -1690,67 +1693,16 @@ static int uncore_event_cpu_online(unsigned int cpu)
>>  	return 0;
>>  }
>>  
>> -static int __init type_pmu_register(struct intel_uncore_type *type)
>> +static int __init uncore_cpu_mmio_init(struct intel_uncore_type **types)
> 
> The name seems a little bit weird, could we name it to a more generic name?
> maybe uncore_pmu_types_init() or something similar? Thanks.

Sure, I may pick uncore_pmu_types_init().
