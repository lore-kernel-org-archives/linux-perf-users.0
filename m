Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB6C1E00B3
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 18:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729189688; cv=none; b=Veo+YO/HG7ljIqE1P5+2rSZ1b4uSG6FQexO8yW525flg43FxvOQvA/EC0xe677FPxTUJTaBKEaY7o1VR2myR8uwEnY+fUuYv/bqpkxEvJsffINdVnrNHjTXj/DqMvmcVYghEb4V9dMazXJa8WuiUwrtSDrWeUR5Be/e8CUq6VPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729189688; c=relaxed/simple;
	bh=AoIed/N7k1ZZM3rEVarj8fVcw6zr40hczB+jk7boO+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyKsWqk3U7OqNbH3bSYMmp9O1xhIYdeWpLUV+gkzhf8gAqpxik8rzf9HfM19yQ1NIczOjnDrKGnLQ0bLaK90nfOuNvnsWbswKW7buxdqf2yqwLuQ0fQ+a4k0RP9p8BXnhFIZBb9529Z6SU+krjo8niM2/WG/7PsWyKsFoyuNbc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPHcD/Cf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPHcD/Cf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E70C4CEC3;
	Thu, 17 Oct 2024 18:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729189688;
	bh=AoIed/N7k1ZZM3rEVarj8fVcw6zr40hczB+jk7boO+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OPHcD/CfXX4CRpL87wS+2WR0nF17jQ/wTDtZ+gdJvzxzN7V+dDnfninD0ei4PLq82
	 J9lNYEaknLYSz2sOTdmgw41BSh+FHOXJieFrrqcWei62sY0B2bK6wRN1vOs33sNCV4
	 7xpCtnlhLSaZmJD9VKSSbNF/rWBvBIHWguMk9ngfgsxPnjGHOnGOhuZu2h78H5cPuq
	 WXnBCJHcLJ9HIcqeSBEUuQ4vYw/8+HROF9ILPIiOkHIN8JzZ+LFXHoyUgpNpQeDj5w
	 dgrM4/wWzESjiuFcxfb3MvV82rx2WGtzOi3fXiTSXOA2vMU4ijcs1AkEcg/GVHomTF
	 IVjiH+Df00pxg==
Date: Thu, 17 Oct 2024 11:28:06 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Leo Yan <leo.yan@arm.com>,
	Steve Clevenger <scclevenger@os.amperecomputing.com>
Cc: james.clark@linaro.org, mike.leach@linaro.org, suzuki.poulose@arm.com,
	ilkka@os.amperecomputing.com, coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V9 2/2] Adjust objdump start/end range per map pgoff
 parameter
Message-ID: <ZxFXNkaoGqnax_yV@google.com>
References: <cover.1728599785.git.scclevenger@os.amperecomputing.com>
 <6107521c4fb1d4ba2da57a6d81c17b54f259feac.1728599785.git.scclevenger@os.amperecomputing.com>
 <d9cb2018-1f68-4aa8-b795-dfbad5e1be37@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9cb2018-1f68-4aa8-b795-dfbad5e1be37@arm.com>

Hi Leo,

On Thu, Oct 17, 2024 at 12:01:28PM +0100, Leo Yan wrote:
> On 10/11/24 18:17, Steve Clevenger wrote:>
> > Extract map_pgoff parameter from the dictionary, and adjust start/end
> > range passed to objdump based on the value.
> > 
> > A zero start_addr is filtered to prevent output of dso address range
> > check failures. This script repeatedly sees a zero value passed
> > in for
> >       start_addr = cpu_data[str(cpu) + 'addr']
> > 
> > These zero values are not a new problem. The start_addr/stop_addr warning
> > clutters the instruction trace output, hence this change.
> > 
> > Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
> > ---
> >   tools/perf/scripts/python/arm-cs-trace-disasm.py | 16 +++++++++++-----
> >   1 file changed, 11 insertions(+), 5 deletions(-)
> > 
> > diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> > index 7aff02d84ffb..e29a4035723c 100755
> > --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
> > +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> > @@ -187,6 +187,10 @@ def process_event(param_dict):
> >          dso_start = get_optional(param_dict, "dso_map_start")
> >          dso_end = get_optional(param_dict, "dso_map_end")
> >          symbol = get_optional(param_dict, "symbol")
> > +       map_pgoff = get_optional(param_dict, "map_pgoff")
> > +       # check for valid map offset
> > +       if (str(map_pgoff) == '[unknown]'):
> > +               map_pgoff = 0
> 
> I tried to apply this patch, it reports warning:
> 
> Applying: Adjust objdump start/end range per map pgoff parameter
> .git/rebase-apply/patch:16: space before tab in indent.
>                 map_pgoff = 0
> warning: 1 line applied after fixing whitespace errors.
> 
> This means it has unexpected spaces in above line.
> 
> 
> When applying patches, I found the prefix is missed in the subject:
> 
>   perf scripts python cs-etm: Adjust objdump start/end range per map pgoff parameter

It could simply be "perf script cs-etm:" but it's up to you. :)

> 
> With above fixing:
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>

Thanks for your review!

Steve, can you please send v10 with the fixes?

Thanks,
Namhyung

> 
> >          cpu = sample["cpu"]
> >          ip = sample["ip"]
> > @@ -243,9 +247,10 @@ def process_event(param_dict):
> >          # Record for previous sample packet
> >          cpu_data[str(cpu) + 'addr'] = addr
> > 
> > -       # Handle CS_ETM_TRACE_ON packet if start_addr=0 and stop_addr=4
> > -       if (start_addr == 0 and stop_addr == 4):
> > -               print("CPU%d: CS_ETM_TRACE_ON packet is inserted" % cpu)
> > +       # Filter out zero start_address. Optionally identify CS_ETM_TRACE_ON packet
> > +       if (start_addr == 0):
> > +               if ((stop_addr == 4) and (options.verbose == True)):
> > +                       print("CPU%d: CS_ETM_TRACE_ON packet is inserted" % cpu)
> >                  return
> > 
> >          if (start_addr < int(dso_start) or start_addr > int(dso_end)):
> > @@ -262,13 +267,14 @@ def process_event(param_dict):
> >                  # vm_start to zero.
> >                  if (dso == "[kernel.kallsyms]" or dso_start == 0x400000):
> >                          dso_vm_start = 0
> > +                       map_pgoff = 0
> >                  else:
> >                          dso_vm_start = int(dso_start)
> > 
> >                  dso_fname = get_dso_file_path(dso, dso_bid)
> >                  if path.exists(dso_fname):
> > -                       print_disam(dso_fname, dso_vm_start, start_addr, stop_addr)
> > +                       print_disam(dso_fname, dso_vm_start, start_addr + map_pgoff, stop_addr + map_pgoff)
> >                  else:
> > -                       print("Failed to find dso %s for address range [ 0x%x .. 0x%x ]" % (dso, start_addr, stop_addr))
> > +                       print("Failed to find dso %s for address range [ 0x%x .. 0x%x ]" % (dso, start_addr + map_pgoff, stop_addr + map_pgoff))
> > 
> >          print_srccode(comm, param_dict, sample, symbol, dso)
> > --
> > 2.44.0
> > 
