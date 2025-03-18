Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6459F1E1E03;
	Tue, 18 Mar 2025 23:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742341670; cv=none; b=jEEqcYUTvLejt82aZ0YfMCFdOzoVAozxqke8Mw3VBbqs53jrbWmJTqAseLigFmqsqMDwaHVhm7kwgBU1egYynnQjYlWNe6dHqxtR6HoJJd9xxHsNdNuCmqVQhkGDn9Zwlng0BtQhYqMIFS+4aZEFYIczS0X2pMEpiaLGcWqtI8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742341670; c=relaxed/simple;
	bh=x3rp+Z/eTbo64Q6GyZW2o56/PCgzaRs5h98VZxSVlJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xtzp4sXcHyuXuT9hEvz6zS0HiYGDMudLTYLoNF4UJ/gpnmZ6La/N58gt8G0G0nlBuqYgmKtvNxCnRyl31Xc+FchnluwWkhZnHQQXhaEva7zyU0BnuRnudnB59LcJnDWmfezgoxye3QSp3lG9dfX7I/aRX0AAXR6hN4yL3NxMbfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wgzrg50d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wgzrg50d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368E4C4CEDD;
	Tue, 18 Mar 2025 23:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742341669;
	bh=x3rp+Z/eTbo64Q6GyZW2o56/PCgzaRs5h98VZxSVlJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wgzrg50dMr1PD/vmdO0fWGdTYr3eps/lN/8KBk4jcAG6i3IR1zWJPlo3+BlD1AEKa
	 dxPx6xOL5AkFwb4x+PuqySN/fIiK52Ds2gpJP3TM5LipX8Di0kjwFFoueEfJhjgalW
	 Rxub79Nvb6gkgSw8igZZKqY5N7I6PmU9dBMrYBdEdhHcmrJV+gsH6awqujAFNb9SGc
	 GYc2VmbnLC+qNeAgzErTEmEpp32nRICvlgyafOehTUC8IrINpghxJTLaLoq/4EvQFv
	 R9QTlDmLiraImceDcUSaLdFtA/ziCjUvWUFnOu6oFlSmC3w5PPvgQxcs/YPwuzzZ1U
	 1Nw2RtS7CF0OQ==
Date: Tue, 18 Mar 2025 16:47:47 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Howard Chu <howardchu95@gmail.com>, Andi Kleen <ak@linux.intel.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Anne Macedo <retpolanne@posteo.net>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf machine: Factor creating a "live" machine
 out of dwarf-unwind
Message-ID: <Z9oGI8G3cOoluIKf@google.com>
References: <20250313052952.871958-1-irogers@google.com>
 <Z9Rk-YdoK-fK_62d@x1>
 <Z9SK96s4PAp680k6@x1>
 <Z9SLL50yuiLOGGYI@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9SLL50yuiLOGGYI@x1>

On Fri, Mar 14, 2025 at 05:01:51PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Mar 14, 2025 at 05:00:58PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Fri, Mar 14, 2025 at 02:18:49PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Wed, Mar 12, 2025 at 10:29:51PM -0700, Ian Rogers wrote:
> > > > Factor out for use in places other than the dwarf unwinding tests for
> > > > libunwind.
> > > 
> > > Testing with another patchset being reviewed/tested, seems to work, if
> > > it showed the line number would be even better!
> > 
> > But it gets the lines, at least in this secoond attempt, after applying
> > Namhyungs fix for the previous problem (int16_t):
> 
> Nevermind, this time I built with DEBUG=1, so DWARF, probably.

Can I get your Tested-by?

Thanks,
Namhyung

>  
> > root@number:~# perf trace -e landlock_add_rule perf test -w landlock
> > perf: Segmentation fault
> >     #0 0x6698d0 in dump_stack debug.c:355
> >     #1 0x66994c in sighandler_dump_stack debug.c:367
> >     #2 0x7f784be95fd0 in __restore_rt libc.so.6[40fd0]
> >     #3 0x4d0e56 in trace__find_usable_bpf_prog_entry builtin-trace.c:3882
> >     #4 0x4cf3de in trace__init_syscalls_bpf_prog_array_maps builtin-trace.c:4040
> >     #5 0x4bf626 in trace__run builtin-trace.c:4477
> >     #6 0x4bb7a9 in cmd_trace builtin-trace.c:5741
> >     #7 0x4d873f in run_builtin perf.c:351
> >     #8 0x4d7df3 in handle_internal_command perf.c:404
> >     #9 0x4d860f in run_argv perf.c:451
> >     #10 0x4d7a4f in main perf.c:558
> >     #11 0x7f784be7f088 in __libc_start_call_main libc.so.6[2a088]
> >     #12 0x7f784be7f14b in __libc_start_main@@GLIBC_2.34 libc.so.6[2a14b]
> >     #13 0x410ff5 in _start perf[410ff5]
> > Segmentation fault (core dumped)
> > root@number:~# 
> >  
> > > I'll continue working on that other case with this applied just before
> > > that series and finally will give my Tested-by.
> > > 
> > > - Arnaldo
> > > 
> > > root@number:~# perf trace -e landlock_add_rule perf test -w landlock
> > > perf: Segmentation fault
> > >     #0 0x5be81d in dump_stack perf[5be81d]
> > >     #1 0x5be879 in sighandler_dump_stack perf[5be879]
> > >     #2 0x7f313d24efd0 in __restore_rt libc.so.6[40fd0]
> > >     #3 0x491bc1 in cmd_trace perf[491bc1]
> > >     #4 0x497090 in run_builtin perf.c:0
> > >     #5 0x4973ab in handle_internal_command perf.c:0
> > >     #6 0x413483 in main perf[413483]
> > >     #7 0x7f313d238088 in __libc_start_call_main libc.so.6[2a088]
> > >     #8 0x7f313d23814b in __libc_start_main@@GLIBC_2.34 libc.so.6[2a14b]
> > >     #9 0x413ad5 in _start perf[413ad5]
> > > Segmentation fault (core dumped)
> > > root@number:~#
