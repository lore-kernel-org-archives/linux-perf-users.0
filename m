Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0A6186A
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Aug 2024 20:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724790189; cv=none; b=I8OKGT2ddfPevYLor1iJVkHLaM4aq8+w9N3PkW6VhvEnfsjxfXsvm4gg5UfXjPOJhgaI0uiRCrysM17A6gAez8i8mWJafEDmDkc03yQnycWiplVyDnLv7i3RxiEidDFrIZvEsavOiUN8y3eI8FBr6Pe38dvyF62HGpv7FW5av7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724790189; c=relaxed/simple;
	bh=QVLgtXAaJFNDXp7w1NC+JndVmgL9ys/BNveX+wGv6Ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t9F+GtI5n5rH8hvCYI5Ln4s2ESV8/a6ffYPxRYDmx/otxx8skk9LO80s5yyFqsOQK3AiSRYJ3KHA7V8DnmOY4MhwVjgDUIMGh6roRh8J7XpEaWqILXw9341qd+hZYN2zro3vn2Pt3z/QsAVE9Lr8MqeFRk4WZQcregi0qHFpNi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42891DA7;
	Tue, 27 Aug 2024 13:23:32 -0700 (PDT)
Received: from [10.57.81.3] (unknown [10.57.81.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9A5B3F73B;
	Tue, 27 Aug 2024 13:23:04 -0700 (PDT)
Message-ID: <23c27981-76c0-4921-b8aa-04f46ac3d6f1@arm.com>
Date: Tue, 27 Aug 2024 21:23:00 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 5/5] Adjust objdump start/end range per map pgoff
 parameter
To: Steve Clevenger <scclevenger@os.amperecomputing.com>,
 james.clark@linaro.org, mike.leach@linaro.org
Cc: suzuki.poulose@arm.com, ilkka@os.amperecomputing.com,
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <cover.1724698250.git.scclevenger@os.amperecomputing.com>
 <7bbd5ca482b052d1c52efc52742f5c2713d5c26c.1724698250.git.scclevenger@os.amperecomputing.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <7bbd5ca482b052d1c52efc52742f5c2713d5c26c.1724698250.git.scclevenger@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/26/2024 10:35 PM, Steve Clevenger wrote:
> 
> Changes in V2:
>   - Updated mailing list distribution
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
> ---
>  .../perf/scripts/python/arm-cs-trace-disasm.py  | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> index d973c2baed1c..6bf806078f9a 100755
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
> @@ -250,13 +251,25 @@ def process_event(param_dict):
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
> +       if map_pgoff != None and map_pgoff != '[unknown]':
> +               if (dso == "[kernel.kallsyms]"):
> +                       dso_vm_start = 0
> +                       map_pgoff = '[unknown]'
> +               else:
> +                       dso_vm_start = int(dso_start)
> +                       start_addr += map_pgoff
> +                       stop_addr += map_pgoff
> +                       map_pgoff = '[unknown]'

Every sample has its own field `map_pgoff`. So I am confused why we need the
sentence: map_pgoff = '[unknown]'. And you can see with above change, we will
set dso_vm_start delicately with below code section.

How about a simple change like below?

@@ -267,7 +268,7 @@ def process_event(param_dict):

  dso_fname = get_dso_file_path(dso, dso_bid)
  if path.exists(dso_fname):
-     print_disam(dso_fname, dso_vm_start, start_addr, stop_addr)
+     print_disam(dso_fname, dso_vm_start, start_addr + map_pgoff, stop_addr +
map_pgoff)

If this change does not work, I am curious if anything we missed to handle in
the perf's C code (frontend).

Thanks,
Leo

>         if (options.objdump_name != None):
>                 # It doesn't need to decrease virtual memory offset for disassembly
>                 # for kernel dso and executable file dso, so in this case we set
> --
> 2.25.1
> 
