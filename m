Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9862318030
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 08:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724834787; cv=none; b=JnisbdIc5t8QU2pnWzwW1Hov65+who3ScDm0C+fLv2yXVx0b8YGfCu9f6lksSNkDCA/GJawUn9OH7kcPuJOo8BgNpfuao27zjcbvjvYxygzglyAoW/YQX4+fht7j0pYfz9LVik2RHDZfiCV0B9fcDd4aTuikVNTDSQ4IzH744lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724834787; c=relaxed/simple;
	bh=RlHXHqJdmo94ZL4XxMSaqnNZDaOBct25y9V8/pUkTZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WEREZL9XxizPn5nCg0q2rnORQZGTYvx3f449BRuwgC+h85CCSQKRAfPSSJRet+d6TboZZKzAqoNkzVo6Bu8/OsPB4Jpfhcr7k3SdAWJvYNSG8UiChXl3775VmdV9qOgM5zYyHOo/ODfOctPUwdSnlhGhLrEPtk5bOz6yKHMj7Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22F05DA7;
	Wed, 28 Aug 2024 01:46:51 -0700 (PDT)
Received: from [10.1.33.31] (PF4Q20KV.arm.com [10.1.33.31])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E60EB3F762;
	Wed, 28 Aug 2024 01:46:23 -0700 (PDT)
Message-ID: <f1dc2f89-a68b-44fc-84ab-1405977642be@arm.com>
Date: Wed, 28 Aug 2024 09:46:18 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 4/4] Adjust objdump start/end range per map pgoff
 parameter
To: Steve Clevenger <scclevenger@os.amperecomputing.com>,
 james.clark@linaro.org, mike.leach@linaro.org
Cc: suzuki.poulose@arm.com, ilkka@os.amperecomputing.com,
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <cover.1724820993.git.scclevenger@os.amperecomputing.com>
 <4db11c591f56f4746b17fbd3468007cc89048881.1724820993.git.scclevenger@os.amperecomputing.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <4db11c591f56f4746b17fbd3468007cc89048881.1724820993.git.scclevenger@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/28/2024 6:09 AM, Steve Clevenger wrote:
> 
> Extract map_pgoff parameter from the dictionary, and adjust start/end
> range passed to objdump based on the value.
> 
> The start_addr/stop_addr address checks are changed to print a warning
> only if verbose == True. This script repeatedly sees a zero value passed
> in for
>       start_addr = cpu_data[str(cpu) + 'addr']
> 
> These zero values are not a new problem. The start_addr/stop_addr warning
> clutters the instruction trace output, hence this change.
> 
> Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>

Reviewed-by: Leo Yan <leo.yan@arm.com>

> ---
>  tools/perf/scripts/python/arm-cs-trace-disasm.py | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> index 7aff02d84ffb..e8cf5d80d850 100755
> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> @@ -187,6 +187,7 @@ def process_event(param_dict):
>         dso_start = get_optional(param_dict, "dso_map_start")
>         dso_end = get_optional(param_dict, "dso_map_end")
>         symbol = get_optional(param_dict, "symbol")
> +       map_pgoff = get_optional(param_dict, "map_pgoff")
> 
>         cpu = sample["cpu"]
>         ip = sample["ip"]
> @@ -249,11 +250,13 @@ def process_event(param_dict):
>                 return
> 
>         if (start_addr < int(dso_start) or start_addr > int(dso_end)):
> -               print("Start address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (start_addr, int(dso_start), int(dso_end), dso))
> +               if (options.verbose == True):
> +                       print("Start address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (start_addr, int(dso_start), int(dso_end), dso))
>                 return
> 
>         if (stop_addr < int(dso_start) or stop_addr > int(dso_end)):
> -               print("Stop address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))
> +               if (options.verbose == True):
> +                       print("Stop address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))
>                 return
> 
>         if (options.objdump_name != None):
> @@ -267,7 +270,7 @@ def process_event(param_dict):
> 
>                 dso_fname = get_dso_file_path(dso, dso_bid)
>                 if path.exists(dso_fname):
> -                       print_disam(dso_fname, dso_vm_start, start_addr, stop_addr)
> +                       print_disam(dso_fname, dso_vm_start, start_addr + map_pgoff, stop_addr + map_pgoff)
>                 else:
>                         print("Failed to find dso %s for address range [ 0x%x .. 0x%x ]" % (dso, start_addr, stop_addr))
> 
> --
> 2.25.1
> 
