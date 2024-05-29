Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C08168C1A;
	Wed, 29 May 2024 08:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716972350; cv=none; b=lXIfax1+J5dJWGFlLfaWKkHSTVBnZyWP6HK9X3E8eqTvkt/O2tPAUq+bkJFU6ni/Y4nIPWpDgN0nXDCBUzxXcWHyHuYIOuTrT6Q15KK5nx8N7KkA9MMLIE0Wotrrf2jZuJH9Z2DY36v7fmh5n+RkThXunFy4cQFMNgvkNW3iWE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716972350; c=relaxed/simple;
	bh=4k93cKDWyHTm7hIIZKu0U1D1pK2kVFiyj4VsKeMkNbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FHQcF4yJAHEqH2IK8ONlaADwphTSYoVDKNc7Jg30cDtMblu3yVOxkLtyN9xytKBrgZ/LyYz8nz6e/LKzB7kErNerC3lDd1CPvSr8DdBOQneILfET0/7QHHlsYnna7ewgc0n8X4bh2TxeNecrOwt8OWAugGPnwd4FaptWVA7iucI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hWwridfM; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hWwridfM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716972348; x=1748508348;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4k93cKDWyHTm7hIIZKu0U1D1pK2kVFiyj4VsKeMkNbc=;
  b=hWwridfMgI/zqVuFFJcAnZ+nBbRFv1eZl/iDQ4NBrCgWRTgDsuKEy/BT
   dKn+KZ3gV/LjwxMHDmq4mlDQckNYBpsCb8Vv1WEJiDTZznEuvqvGToGgO
   z6BLF3+q/kBpB5iy4nTElzrFxRR5TRCbVD6Zje12qMJ9wLs4olNoiKThF
   Bja/BwWXG0Y7pZqdHZVXCZUPchxbmIBHJvJ1PNJOCJzEM2kNZit1vXEz+
   tpiKBNN+lWBj316ljg/8gQ9mXdcZizV7QNa4AsuKANvxAg+Ukoqwk990M
   9zhkw4wep8bqfX/WnzK5EO9MnBAelAzufzNBZ1vK4EzmYCbxlDsLYEFkk
   g==;
X-CSE-ConnectionGUID: JLZG+Hb0Q9u2aBhqNzHYng==
X-CSE-MsgGUID: urtr5MSnSTiJ7/k/dCoSxg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="24494142"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="24494142"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 01:45:30 -0700
X-CSE-ConnectionGUID: y84rBaqMSrmaLSggfYGnyw==
X-CSE-MsgGUID: IPPBN0tNQU2HObCI2sA71w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="40360935"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.94.248.18])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 01:45:26 -0700
Message-ID: <286413cc-6257-49f0-8e8d-e65443494d16@intel.com>
Date: Wed, 29 May 2024 11:45:22 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] perf maps: Sort kcore maps
To: Leo Yan <leo.yan@arm.com>, James Clark <james.clark@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240520090647.949371-1-leo.yan@arm.com>
 <20240520090647.949371-2-leo.yan@arm.com>
 <2f4fce9f-6283-40ad-8adc-c370e98627da@intel.com>
 <02fbb30f-19cf-4822-9676-35d3e51d99b1@arm.com>
 <1f5f1eed-1feb-4a51-92b7-12c1fd195708@arm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <1f5f1eed-1feb-4a51-92b7-12c1fd195708@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/05/24 18:00, James Clark wrote:
> 
> 
> On 25/05/2024 10:29, Leo Yan wrote:
>> Hi Adrian,
>>
>> On 5/22/2024 11:31 AM, Adrian Hunter wrote:
>>> On 20/05/24 12:06, Leo Yan wrote:
>>>> When merging kcore maps into the kernel maps, it has an implicit
>>>> requirement for the kcore maps ordering, otherwise, some sections
>>>> delivered by the kcore maps will be ignored.
>>>
>>> perf treats the kernel text map as a special case.  The problem
>>> is that the kcore loading logic did not cater for there being 2
>>> maps that covered the kernel mapping.
>>>
>>> The workaround was to choose the smaller mapping, but then that
>>> still only worked if that was the first.
>>
>> You could see below are Kcore maps dumped on Arm64:
>>
>> kore map start: ffff000000000000 end: ffff00001ac00000 name: [kernel.kallsyms]
>> refcnt: 1
>> kore map start: ffff00001ad88000 end: ffff000032000000 name: [kernel.kallsyms]
>> refcnt: 1
>> kore map start: ffff000032101000 end: ffff00003e000000 name: [kernel.kallsyms]
>> refcnt: 1
>> kore map start: ffff000040000000 end: ffff000089b80000 name: [kernel.kallsyms]
>> refcnt: 1
>> kore map start: ffff000089cc0000 end: ffff0000b9ab0000 name: [kernel.kallsyms]
>> refcnt: 1
>> kore map start: ffff0000b9ad0000 end: ffff0000b9bb0000 name: [kernel.kallsyms]
>> refcnt: 1
>> kore map start: ffff0000b9c50000 end: ffff0000b9d50000 name: [kernel.kallsyms]
>> refcnt: 1
>> kore map start: ffff0000ba114000 end: ffff0000bf130000 name: [kernel.kallsyms]
>> refcnt: 1
>> kore map start: ffff0000bf180000 end: ffff0000e0000000 name: [kernel.kallsyms]
>> refcnt: 1
>> kore map start: ffff000200000000 end: ffff000220000000 name: [kernel.kallsyms]
>> refcnt: 1
>> kore map start: ffff800000000000 end: ffff800080000000 name: [kernel.kallsyms]
>> refcnt: 1
>> kore map start: ffff800080000000 end: ffff8000822f0000 name: [kernel.kallsyms]
>> refcnt: 1
>> kore map start: ffff800080000000 end: fffffdffbf800000 name: [kernel.kallsyms]
>> refcnt: 1
>> kore map start: fffffdffc0000000 end: fffffdffc06b0000 name: [kernel.kallsyms]
>> refcnt: 1
>> kore map start: fffffdffc06b6000 end: fffffdffc0c80000 name: [kernel.kallsyms]
>> refcnt: 1
>> kore map start: fffffdffc0c84000 end: fffffdffc0f80000 name: [kernel.kallsyms]
>> refcnt: 1
>> kore map start: fffffdffc1000000 end: fffffdffc226e000 name: [kernel.kallsyms]
>> refcnt: 1
>> kore map start: fffffdffc2273000 end: fffffdffc2e6b000 name: [kernel.kallsyms]
>> refcnt: 1
>> kore map start: fffffdffc2e6b000 end: fffffdffc2e6f000 name: [kernel.kallsyms]
>> refcnt: 1
>> kore map start: fffffdffc2e71000 end: fffffdffc2e76000 name: [kernel.kallsyms]
>> refcnt: 1
>> kore map start: fffffdffc2e84000 end: fffffdffc2fc5000 name: [kernel.kallsyms]
>> refcnt: 1
>> kore map start: fffffdffc2fc6000 end: fffffdffc3800000 name: [kernel.kallsyms]
>> refcnt: 1
>> kore map start: fffffdffc8000000 end: fffffdffc8800000 name: [kernel.kallsyms]
>> refcnt: 1
>>
>> You could see it's much more complex rather than only for kernel text section
>> and vmalloc region. We cannot only handle the case for the overlapping between
>> the text section and vmalloc region, it is possible for other maps to be
>> overlapping with each other.

That should not matter because maps__merge_in() deals with overlaps. Just
need the replacement map to cover the kernel text.

There would be a problem if the mappings were inconsistent i.e. the overlapped
part pointed to a different part of the file.  Not sure how much sense there is
in general in overlapping program headers in an ELF file, but if they exist,
they *must* have:

	vaddr_1 - offset_1 == vaddr_2 - offset_2

We could add a check for that, but that would be fatal i.e. fail to load kcore
at all.

>>
>> And different arches have their own definition for the Kcore maps. This is why
>> I want to sort maps in this patch, it can allow us to find a reliable way to
>> append the kcore maps.
>>
>>> James essentially fixed that by ensuring the kernel "replacement"
>>> map is inserted first.
>>
>> Yeah, I agreed James' patch has fixed the kernel "replacement" map. But as I
>> elaborated above, there still have other maps might overlap with each other,
>> my understanding is we don't handle all cases.
>>> In other respects, the ordering of the maps does not matter, so
>>> I am not sure it is worth this extra processing.
>>
>> To sell my patch, I have another point for why we need sorting Kcore maps.
>>
>> Now Perf verifies the map in the function check_invariants(), this function
>> reports the broken issue, but we still have no clue how the broken issue happens.
>>
>> If we can sort the Kcore maps in kcore_mapfn(), then we have chance to detect
>> the overlapping within maps, and then it can reports the overlapping in the
>> first place and this would be helpful for debugging and locating the failures.
>>
> 
> +1 for this point. If check_invariants() insists on sorted maps, then
> keeping them sorted as early as possible is better.
> 
> Debugging future issues will be easier if the assert is closer to the
> source of the problem.

The issue there is with using maps__insert().  It should be
maps__fixup_overlap_and_insert() instead.  Probably most callers
of maps__insert() should be using maps__fixup_overlap_and_insert().
Probably they should be renamed:

  maps__insert			  -> maps__insert_unsafe
  maps__fixup_overlap_and_insert  -> maps__insert

