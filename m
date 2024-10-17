Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C65259C
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 11:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729162894; cv=none; b=Lb2w1jtfSe56Mdk6ibrGv8qhDsDMM84IYHHTh5gKEHPMxQWK+K2xT2LsxMBO5QcPT0gwaYIcp/5wAUOSKltjqBRkZfnUJxWORVt22uMkZyrd4evgfUpKB3y30tC33RVKaEvHyxtsWuUGK0M/ukLhAugcDeRAxh0tZYjoQWQfSXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729162894; c=relaxed/simple;
	bh=l3PTZI9yelJbd/rirhcej/2QWu2+Mwvz0af3zX/s0x0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bjoCD4QloPYsiQExHmDTQrVAdEbULNNJIdAVOfWBS1muu2oe+a8zfzeLH9NeXA5d+CKmvPoPT98UUHsgQjEKseKR6J24TD5y5r+mlMJDJlE8TPETX0eY9E7WYTweFkHqFeor0wxeiOC1AD3HKZZWPehexpW8+llk5hDZcqBnwjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1344DFEC;
	Thu, 17 Oct 2024 04:02:01 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45BEF3F528;
	Thu, 17 Oct 2024 04:01:30 -0700 (PDT)
Message-ID: <d9cb2018-1f68-4aa8-b795-dfbad5e1be37@arm.com>
Date: Thu, 17 Oct 2024 12:01:28 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V9 2/2] Adjust objdump start/end range per map pgoff
 parameter
To: Steve Clevenger <scclevenger@os.amperecomputing.com>,
 james.clark@linaro.org, mike.leach@linaro.org
Cc: suzuki.poulose@arm.com, ilkka@os.amperecomputing.com,
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <cover.1728599785.git.scclevenger@os.amperecomputing.com>
 <6107521c4fb1d4ba2da57a6d81c17b54f259feac.1728599785.git.scclevenger@os.amperecomputing.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <6107521c4fb1d4ba2da57a6d81c17b54f259feac.1728599785.git.scclevenger@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/11/24 18:17, Steve Clevenger wrote:> 
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
>   tools/perf/scripts/python/arm-cs-trace-disasm.py | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> index 7aff02d84ffb..e29a4035723c 100755
> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> @@ -187,6 +187,10 @@ def process_event(param_dict):
>          dso_start = get_optional(param_dict, "dso_map_start")
>          dso_end = get_optional(param_dict, "dso_map_end")
>          symbol = get_optional(param_dict, "symbol")
> +       map_pgoff = get_optional(param_dict, "map_pgoff")
> +       # check for valid map offset
> +       if (str(map_pgoff) == '[unknown]'):
> +               map_pgoff = 0

I tried to apply this patch, it reports warning:

Applying: Adjust objdump start/end range per map pgoff parameter
.git/rebase-apply/patch:16: space before tab in indent.
                 map_pgoff = 0
warning: 1 line applied after fixing whitespace errors.

This means it has unexpected spaces in above line.


When applying patches, I found the prefix is missed in the subject:

   perf scripts python cs-etm: Adjust objdump start/end range per map pgoff parameter

With above fixing:

Reviewed-by: Leo Yan <leo.yan@arm.com>

  
>          cpu = sample["cpu"]
>          ip = sample["ip"]
> @@ -243,9 +247,10 @@ def process_event(param_dict):
>          # Record for previous sample packet
>          cpu_data[str(cpu) + 'addr'] = addr
> 
> -       # Handle CS_ETM_TRACE_ON packet if start_addr=0 and stop_addr=4
> -       if (start_addr == 0 and stop_addr == 4):
> -               print("CPU%d: CS_ETM_TRACE_ON packet is inserted" % cpu)
> +       # Filter out zero start_address. Optionally identify CS_ETM_TRACE_ON packet
> +       if (start_addr == 0):
> +               if ((stop_addr == 4) and (options.verbose == True)):
> +                       print("CPU%d: CS_ETM_TRACE_ON packet is inserted" % cpu)
>                  return
> 
>          if (start_addr < int(dso_start) or start_addr > int(dso_end)):
> @@ -262,13 +267,14 @@ def process_event(param_dict):
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
> +                       print("Failed to find dso %s for address range [ 0x%x .. 0x%x ]" % (dso, start_addr + map_pgoff, stop_addr + map_pgoff))
> 
>          print_srccode(comm, param_dict, sample, symbol, dso)
> --
> 2.44.0
> 
