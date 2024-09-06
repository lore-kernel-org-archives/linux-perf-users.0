Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFC11C9EAB
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Sep 2024 11:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725622074; cv=none; b=VCNxAt5SLx6hnV13Wb8RkA9cQBD9gxgsEut2o0c/tGxQo+FGprbgUK8eFWnCz4ZMCZk4+nC2gjv+1mdmIQbwUF1fsIYUzhuj0AsMEx1o228zcv9tnllliPDi5CYzPjRolepIIvB3yOkn8AyUvU4toN7N67/HADgzdQ9DEJAdDTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725622074; c=relaxed/simple;
	bh=H6sogblLvkOZCm9NCnqjp2i5FW2XOSQEy2wDEaSSDiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ql9CwnT+In4JACuAPk5+g6j1OQXBj3iUi0ha+DdbUZKWIF0sS08Vv6/oV3OpU69sbDJRtejLrNCc5YyAnhfh67X4J7HNNwqgJskczJ4oytbbKL4EbN0Rm+pELqygqcjA91eixZ629XQqHx8erRuGdrjAz+kSVqZG+RnyX0weYKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6BF0FEC;
	Fri,  6 Sep 2024 04:28:19 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 66F7E3F73B;
	Fri,  6 Sep 2024 04:27:51 -0700 (PDT)
Message-ID: <22f7ecdb-14e7-4bb1-a20a-bdb447bcb64f@arm.com>
Date: Fri, 6 Sep 2024 12:27:49 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 4/4] Adjust objdump start/end range per map pgoff
 parameter
To: Steve Clevenger <scclevenger@os.amperecomputing.com>,
 james.clark@linaro.org, mike.leach@linaro.org
Cc: suzuki.poulose@arm.com, ilkka@os.amperecomputing.com,
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <cover.1725573309.git.scclevenger@os.amperecomputing.com>
 <d730ad217936d952008edf703ba4c34393d89dad.1725573309.git.scclevenger@os.amperecomputing.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <d730ad217936d952008edf703ba4c34393d89dad.1725573309.git.scclevenger@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/5/24 23:28, Steve Clevenger wrote:
> 
> Extract map_pgoff parameter from the dictionary, and adjust start/end
> range passed to objdump based on the value.
> 
> A zero start_addr is filtered to prevent output of dso address range
> check failures. This script repeatedly sees a zero value passed
> in for
>       start_addr = cpu_data[str(cpu) + 'addr']
> 
> These zero values are not a new problem. The start_addr/stop_addr warning
> clutters the instruction trace output, hence this change.
> 
> Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
> ---
>   tools/perf/scripts/python/arm-cs-trace-disasm.py | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> index 7aff02d84ffb..a867e0db02b8 100755
> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> @@ -187,6 +187,7 @@ def process_event(param_dict):
>          dso_start = get_optional(param_dict, "dso_map_start")
>          dso_end = get_optional(param_dict, "dso_map_end")
>          symbol = get_optional(param_dict, "symbol")
> +       map_pgoff = get_optional(param_dict, "map_pgoff")


I am concerned the two sentences below are inconsistence: one uses
'start_addr + map_pgoff' and the other uses 'start_addr + int(map_pgoff)'.

Here about below code?

            map_pgoff_str = get_optional(param_dict, "map_pgoff")
	   if map_pgoff_str == "":
		map_pgoff = 0
            else:
		map_pgoff = int(map_pgoff_str)

With above change, 'map_pgoff' is an int type. As a result, the changes
below can simply add 'map_pgoff'.

With these changes, LGTM:

Reviewed-by: Leo Yan <leo.yan@arm.com>


>          cpu = sample["cpu"]
>          ip = sample["ip"]
> @@ -243,9 +244,11 @@ def process_event(param_dict):
>          # Record for previous sample packet
>          cpu_data[str(cpu) + 'addr'] = addr
> 
> -       # Handle CS_ETM_TRACE_ON packet if start_addr=0 and stop_addr=4
> -       if (start_addr == 0 and stop_addr == 4):
> -               print("CPU%d: CS_ETM_TRACE_ON packet is inserted" % cpu)
> +       # Filter out zero start_address. Optionally identify CS_ETM_TRACE_ON packet
> +       # if start_addr=0 and stop_addr=4.
> +       if (start_addr == 0):
> +               if ((stop_addr == 4) and (options.verbose == True)):
> +                       print("CPU%d: CS_ETM_TRACE_ON packet is inserted" % cpu)
>                  return
> 
>          if (start_addr < int(dso_start) or start_addr > int(dso_end)):
> @@ -262,13 +265,14 @@ def process_event(param_dict):
>                  # vm_start to zero.
>                  if (dso == "[kernel.kallsyms]" or dso_start == 0x400000):
>                          dso_vm_start = 0
> +                       map_pgoff = 0
>                  else:
>                          dso_vm_start = int(dso_start)
> 
>                  dso_fname = get_dso_file_path(dso, dso_bid)
>                  if path.exists(dso_fname):
> -                       print_disam(dso_fname, dso_vm_start, start_addr, stop_addr)
> +                       print_disam(dso_fname, dso_vm_start, start_addr + map_pgoff, stop_addr + map_pgoff)
>                  else:
> -                       print("Failed to find dso %s for address range [ 0x%x .. 0x%x ]" % (dso, start_addr, stop_addr))
> +                       print("Failed to find dso %s for address range [ 0x%x .. 0x%x ]" % (dso, start_addr + int(map_pgoff), stop_addr + int(map_pgoff)))

> 
>          print_srccode(comm, param_dict, sample, symbol, dso)
> --
> 2.44.0
> 
