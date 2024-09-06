Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EA2156880;
	Fri,  6 Sep 2024 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725638937; cv=none; b=YKU22hrZ20XTnohic4IUz7LJtnn0zO+50rZModesX/etF/ctQkl4CgPGEvzDlfoDeAKOvLlRAxzLSJVU0aTNFoBKO7C0RXmos2ty3xqB+8UChuP/eDztMUsmrYWiydl2hj/JgcC5FEjcAnvUpNQ+USjagiaFS1YT3RUo3zVw6bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725638937; c=relaxed/simple;
	bh=286ynxw7qLGGt+/rQEscdp4MmXGyQtW2MXCYC+fdvSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OMWwJ5Xt4PLDvKKRlqTxbW8cYamgwa2nZ7gqZQQc98/J7EqPEy953ZtdLH3s7/RcopALU6OtpAjOsR3CI9glClBIc54tDWqgNFubN2EJrhjaObRmqhf6RulDY0Tci/ZetYK1+ye2cP1vXpcA7bN+OFzM88EViY8rS/gGl0EmOuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eymNuUCV; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eymNuUCV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725638935; x=1757174935;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=286ynxw7qLGGt+/rQEscdp4MmXGyQtW2MXCYC+fdvSQ=;
  b=eymNuUCVA3OyuzjuVoy7iViOmJR82v278+lVkxJHSD2kW3+sMIvhKizW
   x+9B3i/wfuhQ+dvykJDgy8jtzkn8B8L4Q7SkCP8X7QQs6daXZrnnhg94H
   p7plPxZ34P+u8JUYpG1ACQ+MVZjOzjLqnA+aDaH/7OzuhyO6yVF+JEGrD
   Eb32VM3UdjTPjJjqlIE9OdOZsv9rHMKroMFGr/iNyeu2aXpTxUNOTze3V
   /dEBWiRF4M28s/Y7gKpuJk2a+/PzZtP+9iD1UMWRLHVxwK3YL5sZVMBZj
   vdXe2zjTHGfP1KXhaKV4crrEjMAkGHzF62ytp9I7LBNuMjoUVQr0ytG6X
   w==;
X-CSE-ConnectionGUID: gO2o9OyETjenZIvlnOOL0g==
X-CSE-MsgGUID: Q0wC9ANjRYCpanduppzdRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="24564787"
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="24564787"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 09:08:55 -0700
X-CSE-ConnectionGUID: kQpImKo5RMOdl0tDzz1OVA==
X-CSE-MsgGUID: z9/EDITXQQqpcdNS8lsy8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="70803033"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 09:08:54 -0700
Received: from [10.212.119.23] (kliang2-mobl1.ccr.corp.intel.com [10.212.119.23])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id CDBD120B5782;
	Fri,  6 Sep 2024 09:08:53 -0700 (PDT)
Message-ID: <8644996b-33d6-4eee-890c-f23a3c830b77@linux.intel.com>
Date: Fri, 6 Sep 2024 12:08:52 -0400
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
 <1a339858-74a3-414a-9fc1-bef47c513728@linux.intel.com> <ZtsO-v3pUVezKBgE@x1>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <ZtsO-v3pUVezKBgE@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-09-06 10:17 a.m., Arnaldo Carvalho de Melo wrote:
> On Thu, Sep 05, 2024 at 03:47:03PM -0400, Liang, Kan wrote:
>> On 2024-09-05 3:33 p.m., Arnaldo Carvalho de Melo wrote:
>>> On Thu, Sep 05, 2024 at 10:07:36AM -0700, kan.liang@linux.intel.com wrote:
>>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>>
>>>> The p-core mem events are missed when launching perf mem record on ADL
>>>> and RPL.
>>>>
>>>> root@number:~# perf mem record sleep 1
>>>> Memory events are enabled on a subset of CPUs: 16-27
>>>> [ perf record: Woken up 1 times to write data ]
>>>> [ perf record: Captured and wrote 0.032 MB perf.data ]
>>>> root@number:~# perf evlist
>>>> cpu_atom/mem-loads,ldlat=30/P
>>>> cpu_atom/mem-stores/P
>>>> dummy:u
>>>>
>>>> A variable 'record' in the struct perf_mem_event is to indicate whether
>>>> a mem event in a mem_events[] should be recorded. The current code only
>>>> configure the variable for the first eligible PMU. It's good enough for
>>>> a non-hybrid machine or a hybrid machine which has the same
>>>> mem_events[]. However, if a different mem_events[] is used for different
>>>> PMUs on a hybrid machine, e.g., ADL or RPL, the 'record' for the second
>>>> PMU never get a chance to be set. The mem_events[] of the second PMU
>>>> are always ignored.
>>>>
>>>> Perf mem doesn't support the per-PMU configuration now. A
>>>> per-PMU mem_events[] 'record' variable doesn't make sense. Make it
>>>> global. That could also avoid searching for the per-PMU mem_events[]
>>>> via perf_pmu__mem_events_ptr every time.
>>>>
>>>> Fixes: abbdd79b786e ("perf mem: Clean up perf_mem_events__name()")
>>>> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
>>>> Closes: https://lore.kernel.org/lkml/Zthu81fA3kLC2CS2@x1/
>>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>>>
>>> Looks better:
>>>
>>> root@number:~# perf report --header-only | grep 'cmdline\|event'
>>> # cmdline : /home/acme/bin/perf mem record ls 
>>> # event : name = cpu_atom/mem-loads,ldlat=30/P, , id = { 500, 501, 502, 503, 504, 505, 506, 507, 508, 509, 510, 511 }, type = 10 (cpu_atom), size = 136, config = 0x5d0 (mem-loads), { sample_period, sample_freq } = 4000, sample_type = IP|TID|TIME|ADDR|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format = ID|LOST, disabled = 1, inherit = 1, freq = 1, enable_on_exec = 1, precise_ip = 3, sample_id_all = 1, { bp_addr, config1 } = 0x1f
>>> # event : name = cpu_atom/mem-stores/P, , id = { 512, 513, 514, 515, 516, 517, 518, 519, 520, 521, 522, 523 }, type = 10 (cpu_atom), size = 136, config = 0x6d0 (mem-stores), { sample_period, sample_freq } = 4000, sample_type = IP|TID|TIME|ADDR|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format = ID|LOST, disabled = 1, inherit = 1, freq = 1, enable_on_exec = 1, precise_ip = 3, sample_id_all = 1
>>> # event : name = cpu_core/mem-loads-aux/, , id = { 524, 525, 526, 527, 528, 529, 530, 531, 532, 533, 534, 535, 536, 537, 538, 539 }, type = 4 (cpu_core), size = 136, config = 0x8203 (mem-loads-aux), { sample_period, sample_freq } = 4000, sample_type = IP|TID|TIME|ADDR|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format = ID|LOST, disabled = 1, inherit = 1, freq = 1, enable_on_exec = 1, precise_ip = 3, sample_id_all = 1, exclude_guest = 1
>>> # event : name = cpu_core/mem-loads,ldlat=30/, , id = { 541, 542, 543, 544, 545, 546, 547, 548, 549, 550, 551, 552, 553, 554, 555, 556 }, type = 4 (cpu_core), size = 136, config = 0x1cd (mem-loads), { sample_period, sample_freq } = 4000, sample_type = IP|TID|TIME|ADDR|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format = ID|LOST, inherit = 1, freq = 1, precise_ip = 2, sample_id_all = 1, exclude_guest = 1, { bp_addr, config1 } = 0x1f
>>> # event : name = cpu_core/mem-stores/P, , id = { 557, 558, 559, 560, 561, 562, 563, 564, 565, 566, 567, 568, 569, 570, 571, 572 }, type = 4 (cpu_core), size = 136, config = 0x2cd (mem-stores), { sample_period, sample_freq } = 4000, sample_type = IP|TID|TIME|ADDR|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format = ID|LOST, disabled = 1, inherit = 1, freq = 1, enable_on_exec = 1, precise_ip = 3, sample_id_all = 1
>>> # event : name = dummy:u, , id = { 573, 574, 575, 576, 577, 578, 579, 580, 581, 582, 583, 584, 585, 586, 587, 588, 589, 590, 591, 592, 593, 594, 595, 596, 597, 598, 599, 600 }, type = 1 (software), size = 136, config = 0x9 (PERF_COUNT_SW_DUMMY), { sample_period, sample_freq } = 1, sample_type = IP|TID|TIME|ADDR|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format = ID|LOST, inherit = 1, exclude_kernel = 1, exclude_hv = 1, mmap = 1, comm = 1, task = 1, mmap_data = 1, sample_id_all = 1, exclude_guest = 1, mmap2 = 1, comm_exec = 1, ksymbol = 1, bpf_event = 1
>>> # intel_pt pmu capabilities: topa_multiple_entries=1, psb_cyc=1, single_range_output=1, mtc_periods=249, ip_filtering=1, output_subsys=0, cr3_filtering=1, psb_periods=3f, event_trace=0, cycle_thresholds=3f, power_event_trace=0, mtc=1, payloads_lip=0, ptwrite=1, num_address_ranges=2, max_subleaf=1, topa_output=1, tnt_disable=0
>>> root@number:~# perf evlist
>>> cpu_atom/mem-loads,ldlat=30/P
>>> cpu_atom/mem-stores/P
>>> cpu_core/mem-loads-aux/
>>> cpu_core/mem-loads,ldlat=30/
>>> cpu_core/mem-stores/P
>>> dummy:u
>>> root@number:~#
>>>
>>> But can we reconstruct the events relationship (group, :S, etc) from
>>> what we have in the perf.data header?
>>>
>>
>> Do you mean show the group relation in the perf evlist?
>>
>> $perf mem record sleep 1
>> [ perf record: Woken up 1 times to write data ]
>> [ perf record: Captured and wrote 0.027 MB perf.data (10 samples) ]
>>
>> $perf evlist -g
>> cpu_atom/mem-loads,ldlat=30/P
>> cpu_atom/mem-stores/P
>> {cpu_core/mem-loads-aux/,cpu_core/mem-loads,ldlat=30/}
>> cpu_core/mem-stores/P
>> dummy:u
>>
>> The -g option already did it, although the group modifier looks lost.
> 
> Right, I can reproduce that, but I wonder if we shouldn't make this '-g'
> option the default?

I think the evlist means a list of events. Only outputting the events
makes sense to me.
With -g, the extra relationship information is provided.

> 
> -----
> 
> Committer testing:
> 
>   root@number:~# perf evlist -g
>   cpu_atom/mem-loads,ldlat=30/P
>   cpu_atom/mem-stores/P
>   {cpu_core/mem-loads-aux/,cpu_core/mem-loads,ldlat=30/}
>   cpu_core/mem-stores/P
>   dummy:u
>   root@number:~#
> 
> The :S for '{cpu_core/mem-loads-aux/,cpu_core/mem-loads,ldlat=30/}' is
> not being added by 'perf evlist -g', to be checked.
> 
> -----

It should be a generic issue, not just for perf evlist -g.

The same issue can be observed for perf report.
$perf report --header-only | grep 'cmdline\|group'
# cmdline : /home/kan/tmp/perf-tools-next/tools/perf/perf record -e
{cycles,instructions}:u sleep 1
# group: {cycles,instructions}

I think it's because the per-group modifiers is converted to per-event
modifiers and stored in the evsel when parsing the group. It's hard to
reconstruct the accurate group strings only relying on the evsel, unless
we record the group string somewhere, e.g., leader evsel, when parsing it.

Thanks,
Kan
