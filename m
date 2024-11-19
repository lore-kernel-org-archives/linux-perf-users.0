Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7A740BE0;
	Tue, 19 Nov 2024 20:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732046746; cv=none; b=DRqmyVwqSq5iiUs1yyz/+/gwAdPvjtJEfNxTPiAvdxdGQ7yBxzkjdR2G0l6hscIbGTiCN6cLY6LfriXeRuPIR43fo5tH+JztyImqubEMk7xeu+FdrLvxz3An9lBsrXr19S863jsFANuZO+ZqYIrP/6cZNWiKKgalwCQBZQrDCpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732046746; c=relaxed/simple;
	bh=gCb5Ktq25qKLk24RZrSKUnkEOTAd/CqBAURtcEjeU8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D3BeZ3WREnpRydNJ1fIpR7K5xbeKPSrM8ZZs7fUcQsfcnPdoWk1TIZDlkMXfADk8hj0cMnDO/FvoeeyNdAybk9S0WhWWQmeygJpB8iknDhY7d8W5DXym+OYtwjJ3t0pE1ZYjwn0RT9dZjRw4ELAUFF6uQ7fweRdA98BaOrT4rXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YIyPP1Sd; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YIyPP1Sd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732046745; x=1763582745;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gCb5Ktq25qKLk24RZrSKUnkEOTAd/CqBAURtcEjeU8I=;
  b=YIyPP1SdA4R4z/RalI4SjWtQ0HIrPjKUIw5z5UIdg33shGMgVanxGtWd
   tzD6KhTFt/i/LaXtfivO8FuMNgjMC/vtFip3fm3Q5FDARuYccsxCQCUt2
   +v5ykStRrIgwnQ36dV1cWndrZFSXfkfV5UT4rwvu9Jr3GzW9PNG/jVl/P
   pmTOFXiahb28Ys1JxFmwJTbkIaDLO4uLqqEJ9V39nt4p5NdSEroC7926r
   0CfERcHF481Mj4GL/58jsXKaU7P6hxIwdTq627HTMlyMewE3pBtNy6dgw
   z/KftIyIjsxeva2rxXf6BfkBA2DAMIvyh39g2h77EFuR/08yIq15PszVt
   w==;
X-CSE-ConnectionGUID: 1l+yajDXT0+Em5IztWvwRw==
X-CSE-MsgGUID: V3dkXZWoQECiwru+v7CSgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="43141268"
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="43141268"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 12:05:44 -0800
X-CSE-ConnectionGUID: +ziajNObSkiAbcnpkNb63w==
X-CSE-MsgGUID: QJbyYYALTryu2KJEm3RBMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="89620498"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 12:05:44 -0800
Received: from [10.246.136.4] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 9301820B5703;
	Tue, 19 Nov 2024 12:05:42 -0800 (PST)
Message-ID: <9fe0616a-edfa-4e51-9649-f19fb1d44821@linux.intel.com>
Date: Tue, 19 Nov 2024 15:05:41 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf script python: Improve physical mem type
 resolution
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241119180130.19160-1-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20241119180130.19160-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-11-19 1:01 p.m., Ian Rogers wrote:
> Previously system RAM and persistent memory were hard code matched,
> change so that the label of the memory region is just read from
> /proc/iomem. This avoids frequent N/A samples.
> 
> Change the /proc/iomem reading, event processing and output so that
> nested entries appear and their counts count toward their parent. As
> labels may be repeated, include the memory ranges in the output to
> make it clear why, for example, "System RAM" appears twice.
> 
> Before:
> ```
> Event: mem_inst_retired.all_loads:P
> Memory type                                    count  percentage
> ----------------------------------------  ----------  ----------
> System RAM                                      9460        96.5%
> N/A                                              998         3.5%
> ```
> 
> After:
> ```
> Event: mem_inst_retired.all_loads:P
> Memory type                                    count  percentage
> ----------------------------------------  ----------  ----------
> 100000000-105f7fffff : System RAM              36741        96.5
>   841400000-8416599ff : Kernel data               89         0.2
>   840800000-8412a6fff : Kernel rodata             60         0.2
>   841ebe000-8423fffff : Kernel bss                34         0.1
> 0-fff : Reserved                                1345         3.5
> 100000-89dd9fff : System RAM                       2         0.0
> ```
> 
> Before:
> ```
> Event: mem_inst_retired.any:P
> Memory type                                    count  percentage
> ----------------------------------------  -----------  -----------
> System RAM                                      9460        90.5%
> N/A                                              998         9.5%
> ```
> 
> After:
> ```
> Event: mem_inst_retired.any:P
> Memory type                                    count  percentage
> ----------------------------------------  ----------  ----------
> 100000000-105f7fffff : System RAM               9460        90.5
>   841400000-8416599ff : Kernel data               45         0.4
>   840800000-8412a6fff : Kernel rodata             19         0.2
>   841ebe000-8423fffff : Kernel bss                12         0.1
> 0-fff : Reserved                                 998         9.5
> ```
> 
> The code has been updated to python 3 with type hints and resolving
> issues reported by mypy and pylint. Tabs are swapped to spaces as
> preferred in PEP8, because most lines of code were modified (of this
> small file) and this makes pylint significantly less noisy.
> 

Thanks Ian. A very nice improvement!

Acked-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/scripts/python/mem-phys-addr.py | 177 ++++++++++++---------
>  1 file changed, 102 insertions(+), 75 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/mem-phys-addr.py b/tools/perf/scripts/python/mem-phys-addr.py
> index 1f332e72b9b0..5e237a5a5f1b 100644
> --- a/tools/perf/scripts/python/mem-phys-addr.py
> +++ b/tools/perf/scripts/python/mem-phys-addr.py
> @@ -3,98 +3,125 @@
>  #
>  # Copyright (c) 2018, Intel Corporation.
>  
> -from __future__ import division
> -from __future__ import print_function
> -
>  import os
>  import sys
> -import struct
>  import re
>  import bisect
>  import collections
> +from dataclasses import dataclass
> +from typing import (Dict, Optional)
>  
>  sys.path.append(os.environ['PERF_EXEC_PATH'] + \
> -	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
> +    '/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
> +
> +@dataclass(frozen=True)
> +class IomemEntry:
> +    """Read from a line in /proc/iomem"""
> +    begin: int
> +    end: int
> +    indent: int
> +    label: str
>  
> -#physical address ranges for System RAM
> -system_ram = []
> -#physical address ranges for Persistent Memory
> -pmem = []
> -#file object for proc iomem
> -f = None
> -#Count for each type of memory
> -load_mem_type_cnt = collections.Counter()
> -#perf event name
> -event_name = None
> +# Physical memory layout from /proc/iomem. Key is the indent and then
> +# a list of ranges.
> +iomem: Dict[int, list[IomemEntry]] = collections.defaultdict(list)
> +# Child nodes from the iomem parent.
> +children: Dict[IomemEntry, set[IomemEntry]] = collections.defaultdict(set)
> +# Maximum indent seen before an entry in the iomem file.
> +max_indent: int = 0
> +# Count for each range of memory.
> +load_mem_type_cnt: Dict[IomemEntry, int] = collections.Counter()
> +# Perf event name set from the first sample in the data.
> +event_name: Optional[str] = None
>  
>  def parse_iomem():
> -	global f
> -	f = open('/proc/iomem', 'r')
> -	for i, j in enumerate(f):
> -		m = re.split('-|:',j,2)
> -		if m[2].strip() == 'System RAM':
> -			system_ram.append(int(m[0], 16))
> -			system_ram.append(int(m[1], 16))
> -		if m[2].strip() == 'Persistent Memory':
> -			pmem.append(int(m[0], 16))
> -			pmem.append(int(m[1], 16))
> +    """Populate iomem from /proc/iomem file"""
> +    global iomem
> +    global max_indent
> +    global children
> +    with open('/proc/iomem', 'r', encoding='ascii') as f:
> +        for line in f:
> +            indent = 0
> +            while line[indent] == ' ':
> +                indent += 1
> +            if indent > max_indent:
> +                max_indent = indent
> +            m = re.split('-|:', line, 2)
> +            begin = int(m[0], 16)
> +            end = int(m[1], 16)
> +            label = m[2].strip()
> +            entry = IomemEntry(begin, end, indent, label)
> +            # Before adding entry, search for a parent node using its begin.
> +            if indent > 0:
> +                parent = find_memory_type(begin)
> +                assert parent, f"Given indent expected a parent for {label}"
> +                children[parent].add(entry)
> +            iomem[indent].append(entry)
>  
> -def print_memory_type():
> -	print("Event: %s" % (event_name))
> -	print("%-40s  %10s  %10s\n" % ("Memory type", "count", "percentage"), end='')
> -	print("%-40s  %10s  %10s\n" % ("----------------------------------------",
> -					"-----------", "-----------"),
> -					end='');
> -	total = sum(load_mem_type_cnt.values())
> -	for mem_type, count in sorted(load_mem_type_cnt.most_common(), \
> -					key = lambda kv: (kv[1], kv[0]), reverse = True):
> -		print("%-40s  %10d  %10.1f%%\n" %
> -			(mem_type, count, 100 * count / total),
> -			end='')
> +def find_memory_type(phys_addr) -> Optional[IomemEntry]:
> +    """Search iomem for the range containing phys_addr with the maximum indent"""
> +    for i in range(max_indent, -1, -1):
> +        if i not in iomem:
> +            continue
> +        position = bisect.bisect_right(iomem[i], phys_addr,
> +                                       key=lambda entry: entry.begin)
> +        if position is None:
> +            continue
> +        iomem_entry = iomem[i][position-1]
> +        if  iomem_entry.begin <= phys_addr <= iomem_entry.end:
> +            return iomem_entry
> +    print(f"Didn't find {phys_addr}")
> +    return None
>  
> -def trace_begin():
> -	parse_iomem()
> +def print_memory_type():
> +    print(f"Event: {event_name}")
> +    print(f"{'Memory type':<40}  {'count':>10}  {'percentage':>10}")
> +    print(f"{'-' * 40:<40}  {'-' * 10:>10}  {'-' * 10:>10}")
> +    total = sum(load_mem_type_cnt.values())
> +    # Add count from children into the parent.
> +    for i in range(max_indent, -1, -1):
> +        if i not in iomem:
> +            continue
> +        for entry in iomem[i]:
> +            global children
> +            for child in children[entry]:
> +                if load_mem_type_cnt[child] > 0:
> +                    load_mem_type_cnt[entry] += load_mem_type_cnt[child]
>  
> -def trace_end():
> -	print_memory_type()
> -	f.close()
> +    def print_entries(entries):
> +        """Print counts from parents down to their children"""
> +        global children
> +        for entry in sorted(entries,
> +                            key = lambda entry: load_mem_type_cnt[entry],
> +                            reverse = True):
> +            count = load_mem_type_cnt[entry]
> +            if count > 0:
> +                mem_type = ' ' * entry.indent + f"{entry.begin:x}-{entry.end:x} : {entry.label}"
> +                percent = 100 * count / total
> +                print(f"{mem_type:<40}  {count:>10}  {percent:>10.1f}")
> +                print_entries(children[entry])
>  
> -def is_system_ram(phys_addr):
> -	#/proc/iomem is sorted
> -	position = bisect.bisect(system_ram, phys_addr)
> -	if position % 2 == 0:
> -		return False
> -	return True
> +    print_entries(iomem[0])
>  
> -def is_persistent_mem(phys_addr):
> -	position = bisect.bisect(pmem, phys_addr)
> -	if position % 2 == 0:
> -		return False
> -	return True
> +def trace_begin():
> +    parse_iomem()
>  
> -def find_memory_type(phys_addr):
> -	if phys_addr == 0:
> -		return "N/A"
> -	if is_system_ram(phys_addr):
> -		return "System RAM"
> +def trace_end():
> +    print_memory_type()
>  
> -	if is_persistent_mem(phys_addr):
> -		return "Persistent Memory"
> +def process_event(param_dict):
> +    if "sample" not in param_dict:
> +        return
>  
> -	#slow path, search all
> -	f.seek(0, 0)
> -	for j in f:
> -		m = re.split('-|:',j,2)
> -		if int(m[0], 16) <= phys_addr <= int(m[1], 16):
> -			return m[2]
> -	return "N/A"
> +    sample = param_dict["sample"]
> +    if "phys_addr" not in sample:
> +        return
>  
> -def process_event(param_dict):
> -	name       = param_dict["ev_name"]
> -	sample     = param_dict["sample"]
> -	phys_addr  = sample["phys_addr"]
> +    phys_addr  = sample["phys_addr"]
> +    entry = find_memory_type(phys_addr)
> +    if entry:
> +        load_mem_type_cnt[entry] += 1
>  
> -	global event_name
> -	if event_name == None:
> -		event_name = name
> -	load_mem_type_cnt[find_memory_type(phys_addr)] += 1
> +    global event_name
> +    if event_name is None:
> +        event_name  = param_dict["ev_name"]

