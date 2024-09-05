Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A7C168DC;
	Thu,  5 Sep 2024 19:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725565629; cv=none; b=mGzTJjkZoqqd3e3gfo1LHhmDayuCSXRv2BGtSJQ2nUCG+g3CJG1grnh5dpt6TAKmsF7hlS45B6SEFdMCZihFdANEc+mvU4lOvNOKK2c0CSCXhS6AHQ3/cARmwT1zMmzwEmaS+qCkibgkTqjMf18pM4Ls998igbJZchi8GDSRAEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725565629; c=relaxed/simple;
	bh=7PaorVyI9z9vGDIV3LGafZMUw8ytPx+Vm2CmLQB5q7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VOC7Brt8kyEFpiD5I437JvOOilKQh0U2FUATyyNYMYzisE2mZIcLkNFQGj3LhiIeIbdDJu8D57ieeUG7F6e8TTpsHSNNZBFObqnPZF3W3R+FfwKHpcsjdkK73si/gTo7nC4fw0ffYAZxue5cQ3I1d00icjPc1+D1ZiN2rrboSpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HzTUukA+; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HzTUukA+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725565627; x=1757101627;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7PaorVyI9z9vGDIV3LGafZMUw8ytPx+Vm2CmLQB5q7k=;
  b=HzTUukA+5jTyXXhJgzAA8SWKoP1UkEOlDUOxgzXSvxacvgig7AUwi0iL
   a8UvFEAuLlXT/zXeScGdfbXfQXMjrgfuzEhW5gyjCvibjXZQLKj3pODk4
   agrZWUS+UD9qCawp80P5rh+R1QdPkJ96GhHDF+ZPQKw3F6F1IHB1F2uX3
   VvDYOF+9EBF3qVQ2MELOYZQ4KiOslBLfItexN4ug/u0BkgI5688C8o804
   UvSW/3M76od0LPEngt06/eyjM6OJAB6XX1rj8m6aRRopGcYMms0qqy9qx
   /OcLaf2xxni+o0A+NsdNzXdZcObzkib0v/p6hzJ6Fusiytodu/adzT4jp
   w==;
X-CSE-ConnectionGUID: Q+QnAE3YTOiSJqiSW1uQqQ==
X-CSE-MsgGUID: Ioc6KedcRzStZ0NWIfbvXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="24452678"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="24452678"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 12:47:06 -0700
X-CSE-ConnectionGUID: C+VKV89bQyirmUHTvyi1BA==
X-CSE-MsgGUID: IsZR9TTaQlKnMA2hcEXYJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="65550174"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 12:47:06 -0700
Received: from [10.212.68.73] (kliang2-mobl1.ccr.corp.intel.com [10.212.68.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 8997220B5782;
	Thu,  5 Sep 2024 12:47:04 -0700 (PDT)
Message-ID: <1a339858-74a3-414a-9fc1-bef47c513728@linux.intel.com>
Date: Thu, 5 Sep 2024 15:47:03 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] perf mem: Fix missed p-core mem events on ADL and RPL
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, irogers@google.com, jolsa@kernel.org,
 adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240905170737.4070743-1-kan.liang@linux.intel.com>
 <20240905170737.4070743-2-kan.liang@linux.intel.com> <ZtoHgMqNhnDdvAIi@x1>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <ZtoHgMqNhnDdvAIi@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-09-05 3:33 p.m., Arnaldo Carvalho de Melo wrote:
> On Thu, Sep 05, 2024 at 10:07:36AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The p-core mem events are missed when launching perf mem record on ADL
>> and RPL.
>>
>> root@number:~# perf mem record sleep 1
>> Memory events are enabled on a subset of CPUs: 16-27
>> [ perf record: Woken up 1 times to write data ]
>> [ perf record: Captured and wrote 0.032 MB perf.data ]
>> root@number:~# perf evlist
>> cpu_atom/mem-loads,ldlat=30/P
>> cpu_atom/mem-stores/P
>> dummy:u
>>
>> A variable 'record' in the struct perf_mem_event is to indicate whether
>> a mem event in a mem_events[] should be recorded. The current code only
>> configure the variable for the first eligible PMU. It's good enough for
>> a non-hybrid machine or a hybrid machine which has the same
>> mem_events[]. However, if a different mem_events[] is used for different
>> PMUs on a hybrid machine, e.g., ADL or RPL, the 'record' for the second
>> PMU never get a chance to be set. The mem_events[] of the second PMU
>> are always ignored.
>>
>> Perf mem doesn't support the per-PMU configuration now. A
>> per-PMU mem_events[] 'record' variable doesn't make sense. Make it
>> global. That could also avoid searching for the per-PMU mem_events[]
>> via perf_pmu__mem_events_ptr every time.
>>
>> Fixes: abbdd79b786e ("perf mem: Clean up perf_mem_events__name()")
>> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Closes: https://lore.kernel.org/lkml/Zthu81fA3kLC2CS2@x1/
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> 
> Looks better:
> 
> root@number:~# perf report --header-only | grep 'cmdline\|event'
> # cmdline : /home/acme/bin/perf mem record ls 
> # event : name = cpu_atom/mem-loads,ldlat=30/P, , id = { 500, 501, 502, 503, 504, 505, 506, 507, 508, 509, 510, 511 }, type = 10 (cpu_atom), size = 136, config = 0x5d0 (mem-loads), { sample_period, sample_freq } = 4000, sample_type = IP|TID|TIME|ADDR|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format = ID|LOST, disabled = 1, inherit = 1, freq = 1, enable_on_exec = 1, precise_ip = 3, sample_id_all = 1, { bp_addr, config1 } = 0x1f
> # event : name = cpu_atom/mem-stores/P, , id = { 512, 513, 514, 515, 516, 517, 518, 519, 520, 521, 522, 523 }, type = 10 (cpu_atom), size = 136, config = 0x6d0 (mem-stores), { sample_period, sample_freq } = 4000, sample_type = IP|TID|TIME|ADDR|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format = ID|LOST, disabled = 1, inherit = 1, freq = 1, enable_on_exec = 1, precise_ip = 3, sample_id_all = 1
> # event : name = cpu_core/mem-loads-aux/, , id = { 524, 525, 526, 527, 528, 529, 530, 531, 532, 533, 534, 535, 536, 537, 538, 539 }, type = 4 (cpu_core), size = 136, config = 0x8203 (mem-loads-aux), { sample_period, sample_freq } = 4000, sample_type = IP|TID|TIME|ADDR|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format = ID|LOST, disabled = 1, inherit = 1, freq = 1, enable_on_exec = 1, precise_ip = 3, sample_id_all = 1, exclude_guest = 1
> # event : name = cpu_core/mem-loads,ldlat=30/, , id = { 541, 542, 543, 544, 545, 546, 547, 548, 549, 550, 551, 552, 553, 554, 555, 556 }, type = 4 (cpu_core), size = 136, config = 0x1cd (mem-loads), { sample_period, sample_freq } = 4000, sample_type = IP|TID|TIME|ADDR|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format = ID|LOST, inherit = 1, freq = 1, precise_ip = 2, sample_id_all = 1, exclude_guest = 1, { bp_addr, config1 } = 0x1f
> # event : name = cpu_core/mem-stores/P, , id = { 557, 558, 559, 560, 561, 562, 563, 564, 565, 566, 567, 568, 569, 570, 571, 572 }, type = 4 (cpu_core), size = 136, config = 0x2cd (mem-stores), { sample_period, sample_freq } = 4000, sample_type = IP|TID|TIME|ADDR|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format = ID|LOST, disabled = 1, inherit = 1, freq = 1, enable_on_exec = 1, precise_ip = 3, sample_id_all = 1
> # event : name = dummy:u, , id = { 573, 574, 575, 576, 577, 578, 579, 580, 581, 582, 583, 584, 585, 586, 587, 588, 589, 590, 591, 592, 593, 594, 595, 596, 597, 598, 599, 600 }, type = 1 (software), size = 136, config = 0x9 (PERF_COUNT_SW_DUMMY), { sample_period, sample_freq } = 1, sample_type = IP|TID|TIME|ADDR|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format = ID|LOST, inherit = 1, exclude_kernel = 1, exclude_hv = 1, mmap = 1, comm = 1, task = 1, mmap_data = 1, sample_id_all = 1, exclude_guest = 1, mmap2 = 1, comm_exec = 1, ksymbol = 1, bpf_event = 1
> # intel_pt pmu capabilities: topa_multiple_entries=1, psb_cyc=1, single_range_output=1, mtc_periods=249, ip_filtering=1, output_subsys=0, cr3_filtering=1, psb_periods=3f, event_trace=0, cycle_thresholds=3f, power_event_trace=0, mtc=1, payloads_lip=0, ptwrite=1, num_address_ranges=2, max_subleaf=1, topa_output=1, tnt_disable=0
> root@number:~# perf evlist
> cpu_atom/mem-loads,ldlat=30/P
> cpu_atom/mem-stores/P
> cpu_core/mem-loads-aux/
> cpu_core/mem-loads,ldlat=30/
> cpu_core/mem-stores/P
> dummy:u
> root@number:~#
> 
> But can we reconstruct the events relationship (group, :S, etc) from
> what we have in the perf.data header?
> 

Do you mean show the group relation in the perf evlist?

$perf mem record sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.027 MB perf.data (10 samples) ]

$perf evlist -g
cpu_atom/mem-loads,ldlat=30/P
cpu_atom/mem-stores/P
{cpu_core/mem-loads-aux/,cpu_core/mem-loads,ldlat=30/}
cpu_core/mem-stores/P
dummy:u

The -g option already did it, although the group modifier looks lost.

Thanks,
Kan
