Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1DB1DF26E;
	Wed, 13 May 2026 00:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778632324; cv=none; b=Ipz1h+EL1A7Q945aCvWPDqO6GArBdtQCp5+TSl3b8+ju6GDZuxjR2PuHmQBmBwKdXI4Zh4TtsIfkG/D05LJuVVmKQJqqkmkmdnF4QTX1ck32eTYtwFJ4bgQJ9bg7ixQCf6FbqKaOvzh3uKsov/2RBbb1nNoiaBOiHGnWUa96hHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778632324; c=relaxed/simple;
	bh=t6YTowD2FgRkq/vrstt+TfIqPZvVngjl+19Lrd2Y7gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p16RlLLJas8eEUwndq3HpIymzcSiU2K9Nrf5d2OJn14qhv0djJhB7fbU1Ew/TVHMO/WexoehHUlOaTq2ixvF5ls9/5XpyD02BAMFnYlnzUsfXIaDRmxQ/UMndtor3gPE1R435PN6+bUybxVjt4uc7BQewHMgXaLtJRXlAtBcKAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c7+q8bBL; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c7+q8bBL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778632323; x=1810168323;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=t6YTowD2FgRkq/vrstt+TfIqPZvVngjl+19Lrd2Y7gg=;
  b=c7+q8bBLnijBTk19nEB+qwqgCt46OymBam0OsQIBkSmfuDyH0Kj96BzN
   Qsts4xoxaZE7IifFJzzy//Qd+43yrLryv15JMHsnHKLKSXF482E8O+nBB
   vCgorWsBQQwwlEZmPMI7GLXeC7rBebREZKMPrSjny7gSwPECUJ7sUVjxm
   zSyp5Y2AtqI2Yuq6psMaiXps9b8WgQm2wpL326gIC+jgHgI00v+d0ShPp
   I36g7LzowX6o8Ss0pajo5XbjBt0tJdsuw3y1XWkXZpxF4hGPk0T1YAGgy
   pXYQ/ci0CRvHK2J7UkPdBzmWPgiN0xP7FW/gxnfOAHAa66V/R330FDsCJ
   g==;
X-CSE-ConnectionGUID: Us/YU+ivRjaXiukibpA+JA==
X-CSE-MsgGUID: QXwTg4x1T3mWqVPA0DGPxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="96981704"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="96981704"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 17:32:02 -0700
X-CSE-ConnectionGUID: aDqO5vRwSvOgUy7wedFgUg==
X-CSE-MsgGUID: 5X4MUzyvTEWkdru0YV98Mw==
X-ExtLoop1: 1
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 17:31:59 -0700
Message-ID: <9c838555-3fbf-4ea9-ae17-cfab5471638a@linux.intel.com>
Date: Wed, 13 May 2026 08:31:56 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] perf/x86/intel/uncore: Fix PCI device refcount leak
 in UPI discovery
To: "Chen, Zide" <zide.chen@intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260511230527.26096-1-zide.chen@intel.com>
 <20260511230527.26096-3-zide.chen@intel.com>
 <7c3aed41-c68c-4cd4-862f-66039b87c7e8@linux.intel.com>
 <6fbf3912-5422-4b6f-b8c6-4db55559f73e@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <6fbf3912-5422-4b6f-b8c6-4db55559f73e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 5/13/2026 1:35 AM, Chen, Zide wrote:
>
> On 5/12/2026 2:27 AM, Mi, Dapeng wrote:
>> On 5/12/2026 7:05 AM, Zide Chen wrote:
>>> pci_get_domain_bus_and_slot() increments the reference count of the
>>> returned PCI device and therefore requires a matching pci_dev_put().
>>>
>>> In skx_upi_topology_cb() and discover_upi_topology(), the lookup is
>>> performed inside a loop, but pci_dev_put() is only called once after
>>> the loop. As a result, references from all previous iterations are
>>> leaked.
>>>
>>> Move pci_dev_put(dev) into the if (dev) block immediately after
>>> upi_fill_topology() returns.
>>>
>>> Opportunistically, fix uninitialized variable in skx_upi_topology_cb().
>>>
>>> Fixes: 4cfce57fa42d ("perf/x86/intel/uncore: Enable UPI topology discovery for Skylake Server")
>>> Fixes: f680b6e6062e ("perf/x86/intel/uncore: Enable UPI topology discovery for Icelake Server")
>>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>>> ---
>>>  arch/x86/events/intel/uncore_snbep.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
>>> index 215d33e260ed..c9ce206fcbb6 100644
>>> --- a/arch/x86/events/intel/uncore_snbep.c
>>> +++ b/arch/x86/events/intel/uncore_snbep.c
>>> @@ -4261,7 +4261,7 @@ static int upi_fill_topology(struct pci_dev *dev, struct intel_uncore_topology *
>>>  static int skx_upi_topology_cb(struct intel_uncore_type *type, int segment,
>>>  				int die, u64 cpu_bus_msr)
>>>  {
>>> -	int idx, ret;
>>> +	int idx, ret = 0;
>>>  	struct intel_uncore_topology *upi;
>>>  	unsigned int devfn;
>>>  	struct pci_dev *dev = NULL;
>>> @@ -4274,12 +4274,12 @@ static int skx_upi_topology_cb(struct intel_uncore_type *type, int segment,
>>>  		dev = pci_get_domain_bus_and_slot(segment, bus, devfn);
>>>  		if (dev) {
>>>  			ret = upi_fill_topology(dev, upi, idx);
>>> +			pci_dev_put(dev);
>>>  			if (ret)
>>>  				break;
>>>  		}
>>>  	}
>>>  
>>> -	pci_dev_put(dev);
>>>  	return ret;
>>>  }
>>>  
>>> @@ -5499,6 +5499,7 @@ static int discover_upi_topology(struct intel_uncore_type *type, int ubox_did, i
>>>  							  devfn);
>>>  			if (dev) {
>>>  				ret = upi_fill_topology(dev, upi, idx);
>>> +				pci_dev_put(dev);
>>>  				if (ret)
>>>  					goto err;
>>>  			}
>>> @@ -5506,7 +5507,6 @@ static int discover_upi_topology(struct intel_uncore_type *type, int ubox_did, i
>>>  	}
>>>  err:
>>>  	pci_dev_put(ubox);
>>> -	pci_dev_put(dev);
>> Should we move the "pci_dev_put(ubox)" into the while loop as well? In
>> theory, the ubox device could be found multiple times.
> As mentioned below, pci_dev_put(ubox) is needed for the two 'goto err"
> breaks. Moving it into the main loop would require two pci_dev_put()
> calls, which adds no benefit.
>  >
>> Besides, could you please search "pci_get_device()" in uncore code, it
>> seems some functions don't call pci_dev_put() or only calls it once, like
>> the funciton spr_update_device_location() ...
> pci_get_device() calls pci_dev_put() internally on the previous device
> before returning the next one, so if the "while (pci_get_device())" loop
> runs to completion without a break, no extra pci_dev_put() is needed:
>
> https://elixir.bootlin.com/linux/v7.1-rc3/source/drivers/pci/search.c#L283

I see. Thanks.


>
>
>> Thanks.
>>
>>
>>
>>>  	return ret;
>>>  }
>>>  
