Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980BC1FF5F4;
	Wed, 11 Dec 2024 17:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939710; cv=none; b=dQ/x3yVh0npCYHuPhLcuL3QXgAmRlbL6rNe1wHu378l4Z1oXqAAOq4TKj1HINCob9licpdQg73BzGD0cQmFexenjtu0jjAyvMmFDRwrIH2mltkbLi0tw4tsAHT9pUiQXpXzJ7pcOBqNxjB9pTSILtVaOh5Ep/o0PmeL6Sas2LoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939710; c=relaxed/simple;
	bh=T2Hz8JXQvIU1IbL1FUM+v0fC6id+P9umjk3kRpUxGgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E+GUMgyKQihtD5nkHjuOxeEfgIKcKCeEa+fygH828ED8KZfMA3Gl400kA0jt16QiN1qSx2N6GK6KTlydLRpC6BPXusXbhuF+RcJYbiDtVl3eacCXqqGl8zxe7A/y/jTER7ka1EqqLijIW1SO9R+3GsNMLdJYxrk4LWSB+PBu20g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T2gSyjZT; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T2gSyjZT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733939709; x=1765475709;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=T2Hz8JXQvIU1IbL1FUM+v0fC6id+P9umjk3kRpUxGgI=;
  b=T2gSyjZTxHygv9l+HHAEIWjp5THKsDFXHKOUnjelNqpmns5C0xIi5fVq
   PVEJL7iOCNYJuULhOu7sHs5HW6m2DcLqf6K7a10prObfg+HicdnMwOu4L
   ZRXqppAGGI2YFlYUIPA0nxCCXBs/TDv2b33LpWUV2Bw2V2LEjHR4ENyY3
   PU5Chq78T0TmvPTF7EYwnZMwrDSGA4wJcRBRqnXBcvY57SKXGiPgUmgJo
   nf7i0UijiMPINwVLmg4C9TVQGLDudLQXAQCYpT9gkLVomUURbvgioKbhX
   +NDUcoLPt70UNacEw2ez/7ZWNS3acRTw4Ij5IcXYWKuFMcOP1p4ndDuwi
   Q==;
X-CSE-ConnectionGUID: M0iAEfKQTD24WLa6tmPKOA==
X-CSE-MsgGUID: CRLyQIhaSP+1Ct4Ins3sjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34462484"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="34462484"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 09:55:08 -0800
X-CSE-ConnectionGUID: yy+LLd+eQ+6wGmEeb2LsEA==
X-CSE-MsgGUID: 38yPHa3qSZGERYkDYwF/Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="133280363"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 09:55:08 -0800
Received: from [10.246.136.4] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 95C3E20B5703;
	Wed, 11 Dec 2024 09:55:05 -0800 (PST)
Message-ID: <63eac289-07cb-4c3b-b34d-ea5bd009441a@linux.intel.com>
Date: Wed, 11 Dec 2024 12:55:03 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] 'perf mem record' on a Intel hybrid system broken
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: James Clark <james.clark@linaro.org>,
 Ravi Bangoria <ravi.bangoria@amd.com>, Atish Patra <atishp@atishpatra.org>,
 Mingwei Zhang <mizhang@google.com>, Kajol Jain <kjain@linux.ibm.com>,
 Thomas Richter <tmricht@linux.ibm.com>, Palmer Dabbelt
 <palmer@rivosinc.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-perf-users@vger.kernel.org
References: <Z1CVTJ5jzIyNiB1R@x1> <Z1CsX3n5U_q5ehRp@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <Z1CsX3n5U_q5ehRp@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-12-04 2:24 p.m., Namhyung Kim wrote:
> Hi Arnaldo,
> 
> On Wed, Dec 04, 2024 at 02:45:48PM -0300, Arnaldo Carvalho de Melo wrote:
>> Hi Namhyung,
>>
>> root@number:/tmp# perf mem record -a sleep 1s
>> Error:
>> The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (cpu_core/mem-loads,ldlat=30/).
>> "dmesg | grep -i perf" may provide additional information.
>>
>> root@number:/tmp# dmesg | tail
>> [18865.729882] ixgbe 0000:05:00.0 enp5s0: NIC Link is Up 10 Gbps, Flow Control: RX/TX
>> [18865.848172] mlx5_core 0000:01:00.0 enp1s0f0np0: Link down
>> [18866.057990] mlx5_core 0000:01:00.1 enp1s0f1np1: Link down
>> [19066.396215] input: JBL RACE TWS (AVRCP) as /devices/virtual/input/input27
>> [19078.378477] usb 2-3: current rate 16000 is different from the runtime rate 48000
>> [21158.375680] usb 2-3: current rate 16000 is different from the runtime rate 48000
>> [31386.186675] input: JBL RACE TWS (AVRCP) as /devices/virtual/input/input28
>> [31409.098352] usb 2-3: current rate 16000 is different from the runtime rate 48000
>> [36409.737615] sysrq: Emergency Sync
>> [36409.742619] Emergency Sync complete
>> root@number:/tmp#
>>
>> 	That I bisected down to:
>>
>> ⬢ [acme@toolbox perf-tools-next]$ git bisect good 
>> af954f76eea56453713ae657f6812d4063f9bc57 is the first bad commit
>> commit af954f76eea56453713ae657f6812d4063f9bc57
>> Author: Namhyung Kim <namhyung@kernel.org>
>> Date:   Tue Oct 15 23:23:57 2024 -0700
>>
>>     perf tools: Check fallback error and order
>>     
>>     The perf_event_open might fail due to various reasons, so blindly
>>     reducing precise_ip level might not be the best way to deal with it.
>>     
>>     It seems the kernel return -EOPNOTSUPP when PMU doesn't support the
>>     given precise level.  Let's try again with the correct error code.
>>     
>>     This caused a problem on AMD, as it stops on precise_ip of 2 for IBS but
>>     user events with exclude_kernel=1 cannot make progress.  Let's add the
>>     evsel__handle_error_quirks() to this case specially.  I plan to work on
>>     the kernel side to improve this situation but it'd still need some
>>     special handling for IBS.
>>     
>>     Reviewed-by: James Clark <james.clark@linaro.org>
>>     Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
>>     Acked-by: Kan Liang <kan.liang@linux.intel.com>
>>     Cc: James Clark <james.clark@arm.com>
>>     Cc: Atish Patra <atishp@atishpatra.org>
>>     Cc: Mingwei Zhang <mizhang@google.com>
>>     Cc: Kajol Jain <kjain@linux.ibm.com>
>>     Cc: Thomas Richter <tmricht@linux.ibm.com>
>>     Cc: Palmer Dabbelt <palmer@rivosinc.com>
>>     Link: https://lore.kernel.org/r/20241016062359.264929-8-namhyung@kernel.org
>>     Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>>
>> If I revert that patch:
>>
>> ⬢ [acme@toolbox perf-tools-next]$ git log --oneline -5
>> 9a9f2d6da1ea5ef5 (HEAD -> perf-tools-next) Revert "perf tools: Check fallback error and order"
>> d12d4cfc5033cd8c perf script python: Improve physical mem type resolution
>> 3f79d822e331022f perf disasm: Return a proper error when not determining the file type
>> 1a5b914261f0ebee tools features: Don't check for libunwind devel files by default
>> 40384c840ea1944d (tag: v6.13-rc1, perf-tools/perf-tools) Linux 6.13-rc1
>> ⬢ [acme@toolbox perf-tools-next]$
>>
>> And rebuild, it works again:
>>
>> root@number:/tmp# perf mem record -a sleep 1s
>> [ perf record: Woken up 1 times to write data ]
>> [ perf record: Captured and wrote 13.014 MB perf.data (10316 samples) ]
>> root@number:/tmp# perf evlist
>> cpu_atom/mem-loads,ldlat=30/P
>> cpu_atom/mem-stores/P
>> cpu_core/mem-loads-aux/
>> cpu_core/mem-loads,ldlat=30/
>> cpu_core/mem-stores/P
>> dummy:u
>> # Tip: use 'perf evlist -g' to show group information
>> root@number:/tmp# perf evlist -v
>> cpu_atom/mem-loads,ldlat=30/P: type: 10 (cpu_atom), size: 136, config: 0x5d0 (mem-loads), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|CPU|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, disabled: 1, freq: 1, precise_ip: 3, sample_id_all: 1, { bp_addr, config1 }: 0x1f
>> cpu_atom/mem-stores/P: type: 10 (cpu_atom), size: 136, config: 0x6d0 (mem-stores), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|CPU|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, disabled: 1, freq: 1, precise_ip: 3, sample_id_all: 1
>> cpu_core/mem-loads-aux/: type: 4 (cpu_core), size: 136, config: 0x8203 (mem-loads-aux), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|CPU|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, disabled: 1, freq: 1, precise_ip: 3, sample_id_all: 1
>> cpu_core/mem-loads,ldlat=30/: type: 4 (cpu_core), size: 136, config: 0x1cd (mem-loads), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|CPU|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, freq: 1, precise_ip: 2, sample_id_all: 1, { bp_addr, config1 }: 0x1f
>> cpu_core/mem-stores/P: type: 4 (cpu_core), size: 136, config: 0x2cd (mem-stores), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|CPU|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, disabled: 1, freq: 1, precise_ip: 3, sample_id_all: 1
>> dummy:u: type: 1 (software), size: 136, config: 0x9 (PERF_COUNT_SW_DUMMY), { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|ADDR|CPU|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, task: 1, mmap_data: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1
>> # Tip: use 'perf evlist -g' to show group information
>> root@number:/tmp# perf evlist -g
>> cpu_atom/mem-loads,ldlat=30/P
>> cpu_atom/mem-stores/P
>> {cpu_core/mem-loads-aux/,cpu_core/mem-loads,ldlat=30/}
>> cpu_core/mem-stores/P
>> dummy:u
>> root@number:/tmp#
>>
>> Now trying to investigate this,
> 
> I think I got a related report from the kernel test robot but it was a
> Sapphire Rapids machine.  I don't have a Intel hybrid machine in hand.
> I'll try to take a look at it on Sapphire Rapids.

The default precise_ip level for perf mem is always 3.

For the latest intel platforms, it implies PDist, which is only
available on GP 0.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/events/intel/core.c#n4412

However, the mem-load PEBS event is available on all GP counters but GP
0. :(
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/events/intel/ds.c#n1176

So the precise_ip-- is required.

The failure of scheduling returns -EINVAL.

But Namhyung's patch assumes that the kernel return -EOPNOTSUPP when PMU
doesn't support the given precise level.
(Sorry, I didn't notice the case early.)

Is it possible to reduce the precise_ip for the -EINVAL as well?

Thanks,
Kan
