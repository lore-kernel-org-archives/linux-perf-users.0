Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1623A84D12;
	Sat, 12 Oct 2024 05:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728711008; cv=none; b=PU1nE4xeTi1PzCUKeOLkwxbIK4VHmsJRDB8zKIjorv7HXXxYopG+0NUuX48DFOjYFepYni6o5iGPydAENdlwdDBlrMkwlylA0a/X6ik0mULsUaaWvzKqfv9+0JxQxK1cEORJplYDnx3ET6shnSIF0q3mNO6TJ8YkmwPIcM2g1kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728711008; c=relaxed/simple;
	bh=lwMtfMetb3BPs5V7gdpNnfStcauoM2ooH5DPFTWdtnM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QjnJJPJwFUh31IVukldR62BHjD51++/AbyJ7JZcgj7PBTj3F9Qs7U8Y3h+npKTfcATdb+vk80YgV9bFwVlNTAAwgdWOHMA+Eu/UgSdvxE4t/Y4hHlD6ZFSF6NH06cS7JWqkgJaaXUhTHUCCsq+hA8ar85YjxyQiipbGMmFOIRIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIIaU9ak; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIIaU9ak"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFCAC4CEC6;
	Sat, 12 Oct 2024 05:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728711007;
	bh=lwMtfMetb3BPs5V7gdpNnfStcauoM2ooH5DPFTWdtnM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dIIaU9ak5tAN3tmoYL0OA6WtUYZYF+svt/IUA7l42Pi6Gp8iKfZG0s+ih4RjpSy0c
	 geNmRHA1WK12uDKq7B2i4oWtZWHbJw5sAYrAeu8dGwzQKTm3GGMSI5jIoHCac4ZKNn
	 TiNZ5hFRC6HvSVeHWbxYp34Q+OxEQEVw0OIFDgIVAtOGQLMNQdImXhwT79uwfl2rHu
	 gBgTXgWsQiejWA7ef2Ehg+0apJMtDCQpGbdHJjkteHY2v540x8BeDgnv1HSY8NxSCU
	 /itLKLj3ZrmJ7K3GPOyadkkpTwhGiiqgmweI1ZxlgHjLtTKnXx1YbbT7T9q6eJeOfr
	 BkApdf/+DmTqg==
Date: Sat, 12 Oct 2024 14:30:03 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, Dima
 Kogan <dima@secretsauce.net>, james.clark@linaro.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] perf probe: Generate hash event for long symbol
Message-Id: <20241012143003.eeb8d3eb43e45494193bbfd4@kernel.org>
In-Reply-To: <a7d63300-27a2-4121-9327-40426a66afe3@arm.com>
References: <20241007141116.882450-1-leo.yan@arm.com>
	<20241007141116.882450-4-leo.yan@arm.com>
	<20241011003408.f9bacf4e5899e88a94c3d7cd@kernel.org>
	<fab219bc-fabd-42b7-b42f-d92851b1d2f3@arm.com>
	<20241011120733.5660c80f8f93e9659fa5a254@kernel.org>
	<a7d63300-27a2-4121-9327-40426a66afe3@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Oct 2024 09:41:39 +0100
Leo Yan <leo.yan@arm.com> wrote:

> On 10/11/2024 4:07 AM, Masami Hiramatsu (Google) wrote:
> 
> [...]
> 
> >>> OK, personally, I recommend you to specify event name instead of generating
> >>> long event name in this case. But I understand sometimes this kind of feature
> >>> is good for someone.
> >>
> >> Sometimes, users try to add probe for long symbol and returns error, but there
> >>   have no clue for proceeding.
> > 
> > OK, no warning messsage is not good.
> > It should warn them to recommend adding it with their own event name too.
> 
> Okay, will do this in next spin.
> 
> >> Either we automatically generate a hashed name, or a guidance in the failure
> >> log for setting event name would be helpful. If you have concern for hashed
> >> name, maybe we can refine the log to give info for setting event name?
> > 
> > Yeah, I think this long event name is not useful for user to type.
> 
> Agreed.
> 
> >>> BTW, I would like to confirm. Can't we demangle the symbol name and parse it?
> >>
> >> I did test for C++ demangle symbols with the command:
> >>
> >>    perf probe -x /mnt/test_cpp_mangle -F --demangle
> >>
> >> The command doesn't work as I cannot see it output correctly for demangled
> >> symbols. But I don't look into details why this does not work at my side.
> > 
> > Oops, that is another issue to be solved.
> 
> After install libiberty, then I can see the tool can show demangled symbols.
> However, I found another issue for probing demangle symbol, please see details
> in below patch and let me know if makes sense.

Yeah, I think that will fixes a mangled symbol problem.
But I have one comment below.

> 
> ---8<---
> 
> From 3b09a6f89c7e383c6b1d2b7e6bd80c6bfa658d5b Mon Sep 17 00:00:00 2001
> From: Leo Yan <leo.yan@arm.com>
> Date: Fri, 11 Oct 2024 07:58:08 +0000
> Subject: [PATCH] perf probe: Correct demangled symbols in C++ program
> 
> An issue can be observed when probe C++ demangled symbol with steps:
> 
>   # nm test_cpp_mangle | grep print_data
>     0000000000000c94 t _GLOBAL__sub_I__Z10print_datai
>     0000000000000afc T _Z10print_datai
>     0000000000000b38 T _Z10print_dataR5Point
> 
>   # ./perf probe -x /home/niayan01/test_cpp_mangle -F --demangle
>     ...
>     print_data(Point&)
>     print_data(int)
>     ...
> 
>   # ./perf --debug verbose=3 probe -x test_cpp_mangle --add "test=print_data(int)"
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
> When tried to probe symbol "print_data(int)", the log show:
> 
>     Symbol print_data(int) address found : afc
> 
> The found address is 0xafc - which is right if we connect with the
> output result from nm. Afterwards when write event, the command uses
> offset 0xb38 in the last log, which is a wrong address.
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

Can you add the result after applying this patch here?

Thank you,

> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/perf/util/probe-finder.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> index 630e16c54ed5..28a14005fc1f 100644
> --- a/tools/perf/util/probe-finder.c
> +++ b/tools/perf/util/probe-finder.c
> @@ -1583,8 +1583,21 @@ int debuginfo__find_probe_point(struct debuginfo *dbg, u64 addr,
> 
>         /* Find a corresponding function (name, baseline and baseaddr) */
>         if (die_find_realfunc(&cudie, (Dwarf_Addr)addr, &spdie)) {
> -               /* Get function entry information */
> -               func = basefunc = dwarf_diename(&spdie);
> +               /*
> +                * Get function entry information.
> +                *
> +                * As described in the document DWARF Debugging Information
> +                * Format Version 5, section 2.22 Linkage Names, "mangled names,
> +                * are used in various ways, ... to distinguish multiple
> +                * entities that have the same name".
> +                *
> +                * Firstly try to get distinct linkage name, if fail then
> +                * rollback to get associated name in DIE.
> +                */
> +               func = basefunc = die_get_linkage_name(&spdie);
> +               if (!func)
> +                        func = basefunc = dwarf_diename(&spdie);
> +
>                 if (!func ||
>                     die_entrypc(&spdie, &baseaddr) != 0 ||
>                     dwarf_decl_line(&spdie, &baseline) != 0) {
> --
> 2.25.1
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
