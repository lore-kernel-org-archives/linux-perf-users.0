Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD1B10F4;
	Mon, 14 Oct 2024 00:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728866713; cv=none; b=bmDeIHPoOKQ6AzBgIeAFYZc8nwl06Fdkaxl5BNIE3hdsw0A+PnU3B4wozGox31C94rCxl17wIJiqxB1pgt5xKazZIiJ3kb/TumQwkg4ZvMjnKyswG6ivulAJB+HX5BemaWITYoVYMoKwAbtv5WcdkGsW73xzayS2oC7bSgKeTNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728866713; c=relaxed/simple;
	bh=Jt4/LiOHK7LUR5Kk7kN7DAgmtkmPOrUx+mgoMDRs+vw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=C8JwBJEG6bamgcBJcobPZDIYRclH/bTtxE8cN/KilYWsHiDyj5/ONPHxD75QOOlFjq7vF4hcD2W9j1xkqLvD30z7bTTq6ZUW26dLl36rRKitBWlln/Yrde11kECoRL/opQekNZkPYlncutmADJnWyuEbpwWENhoKMxroDpnRbe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuWHskg3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuWHskg3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78449C4CEC5;
	Mon, 14 Oct 2024 00:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728866712;
	bh=Jt4/LiOHK7LUR5Kk7kN7DAgmtkmPOrUx+mgoMDRs+vw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CuWHskg3GjrEYLPoh1pKGsTsaawi/mEJOAU2EEfYeWP1ZdcLi4dA/kW5PT/fEdqs7
	 TpcAOsj3I/kQI5SmXfM0M70ay/dcpKC/FiOTa37abFzzmEriMUqK4wsoWatBIMehQD
	 FvfLEhxFqTZ6fmeQbkvDM+POJpQdgoj+8ceJHeylJXP3Vy0B3gBlcMRTt9ciAAC9OH
	 j53tGpk1flq8d9jyd88FEHLvcslM38Xhm269sNYcNckRhS0Rm6Dsg/GA6T/z0r5Sxi
	 hGEzXmiZT6GO3LJbM3A7aFLmWOuAu5IfVwygum0Qgd81d1WUXOWCE56CYgkMa/M5NV
	 Ctb4eWP2u8S6g==
Date: Mon, 14 Oct 2024 09:45:08 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf probe: Correct demangled symbols in C++ program
Message-Id: <20241014094508.ccd8e17c79b5a833707df339@kernel.org>
In-Reply-To: <20241012141432.877894-1-leo.yan@arm.com>
References: <20241012141432.877894-1-leo.yan@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Oct 2024 15:14:32 +0100
Leo Yan <leo.yan@arm.com> wrote:

> An issue can be observed when probe C++ demangled symbol with steps:
> 
>   # nm test_cpp_mangle | grep print_data
>     0000000000000c94 t _GLOBAL__sub_I__Z10print_datai
>     0000000000000afc T _Z10print_datai
>     0000000000000b38 T _Z10print_dataR5Point
> 
>   # perf probe -x /home/niayan01/test_cpp_mangle -F --demangle
>     ...
>     print_data(Point&)
>     print_data(int)
>     ...
> 
>   # perf --debug verbose=3 probe -x test_cpp_mangle --add "test=print_data(int)"
>     probe-definition(0): test=print_data(int)
>     symbol:print_data(int) file:(null) line:0 offset:0 return:0 lazy:(null)
>     0 arguments
>     Open Debuginfo file: /home/niayan01/test_cpp_mangle
>     Try to find probe point from debuginfo.
>     Symbol print_data(int) address found : afc
>     Matched function: print_data [2ccf]
>     Probe point found: print_data+0
>     Found 1 probe_trace_events.
>     Opening /sys/kernel/tracing//uprobe_events write=1
>     Opening /sys/kernel/tracing//README write=0
>     Writing event: p:probe_test_cpp_mangle/test /home/niayan01/test_cpp_mangle:0xb38
>     ...
> 
> When tried to probe symbol "print_data(int)", the log shows:
> 
>     Symbol print_data(int) address found : afc
> 
> The found address is 0xafc - which is right with verifying the output
> result from nm. Afterwards when write event, the command uses offset
> 0xb38 in the last log, which is a wrong address.
> 
> The dwarf_diename() gets a common function name, in above case, it
> returns string "print_data". As a result, the tool parses the offset
> based on the common name. This leads to probe at the wrong symbol
> "print_data(Point&)".
> 
> To fix the issue, use the die_get_linkage_name() function to retrieve
> the distinct linkage name - this is the mangled name for the C++ case.
> Based on this unique name, the tool can get a correct offset for
> probing. Based on DWARF doc, it is possible the linkage name is missed
> in the DIE, it rolls back to use dwarf_diename().
> 
> After:
> 
>   # perf --debug verbose=3 probe -x test_cpp_mangle --add "test=print_data(int)"
>     probe-definition(0): test=print_data(int)
>     symbol:print_data(int) file:(null) line:0 offset:0 return:0 lazy:(null)
>     0 arguments
>     Open Debuginfo file: /home/niayan01/test_cpp_mangle
>     Try to find probe point from debuginfo.
>     Symbol print_data(int) address found : afc
>     Matched function: print_data [2d06]
>     Probe point found: print_data+0
>     Found 1 probe_trace_events.
>     Opening /sys/kernel/tracing//uprobe_events write=1
>     Opening /sys/kernel/tracing//README write=0
>     Writing event: p:probe_test_cpp_mangle/test /home/niayan01/test_cpp_mangle:0xafc
>     Added new event:
>       probe_test_cpp_mangle:test (on print_data(int) in /home/niayan01/test_cpp_mangle)
> 
>     You can now use it in all perf tools, such as:
> 
>             perf record -e probe_test_cpp_mangle:test -aR sleep 1
> 
>   # perf --debug verbose=3 probe -x test_cpp_mangle --add "test2=print_data(Point&)"
>     probe-definition(0): test2=print_data(Point&)
>     symbol:print_data(Point&) file:(null) line:0 offset:0 return:0 lazy:(null)
>     0 arguments
>     Open Debuginfo file: /home/niayan01/test_cpp_mangle
>     Try to find probe point from debuginfo.
>     Symbol print_data(Point&) address found : b38
>     Matched function: print_data [2ccf]
>     Probe point found: print_data+0
>     Found 1 probe_trace_events.
>     Opening /sys/kernel/tracing//uprobe_events write=1
>     Parsing probe_events: p:probe_test_cpp_mangle/test /home/niayan01/test_cpp_mangle:0x0000000000000afc
>     Group:probe_test_cpp_mangle Event:test probe:p
>     Opening /sys/kernel/tracing//README write=0
>     Writing event: p:probe_test_cpp_mangle/test2 /home/niayan01/test_cpp_mangle:0xb38
>     Added new event:
>       probe_test_cpp_mangle:test2 (on print_data(Point&) in /home/niayan01/test_cpp_mangle)
> 
>     You can now use it in all perf tools, such as:
> 
>             perf record -e probe_test_cpp_mangle:test2 -aR sleep 1
> 

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> Fixes: fb1587d869a3 ("perf probe: List probes with line number and file name")
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/perf/util/probe-finder.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> index 630e16c54ed5..498ccfb0be6f 100644
> --- a/tools/perf/util/probe-finder.c
> +++ b/tools/perf/util/probe-finder.c
> @@ -1583,8 +1583,21 @@ int debuginfo__find_probe_point(struct debuginfo *dbg, u64 addr,
>  
>  	/* Find a corresponding function (name, baseline and baseaddr) */
>  	if (die_find_realfunc(&cudie, (Dwarf_Addr)addr, &spdie)) {
> -		/* Get function entry information */
> -		func = basefunc = dwarf_diename(&spdie);
> +		/*
> +		 * Get function entry information.
> +		 *
> +		 * As described in the document DWARF Debugging Information
> +		 * Format Version 5, section 2.22 Linkage Names, "mangled names,
> +		 * are used in various ways, ... to distinguish multiple
> +		 * entities that have the same name".
> +		 *
> +		 * Firstly try to get distinct linkage name, if fail then
> +		 * rollback to get associated name in DIE.
> +		 */
> +		func = basefunc = die_get_linkage_name(&spdie);
> +		if (!func)
> +			func = basefunc = dwarf_diename(&spdie);
> +
>  		if (!func ||
>  		    die_entrypc(&spdie, &baseaddr) != 0 ||
>  		    dwarf_decl_line(&spdie, &baseline) != 0) {
> -- 
> 2.25.1
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
