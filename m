Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B7617C7F;
	Tue, 28 May 2024 14:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716907640; cv=none; b=HbzlP4tHa9o0YJbFOpK5ti6Fz0LtCkc0QLOKkzmGrPcb/MXaiArf9Sq01hjqdCQuaHlhWgO+1zjAjNAx6t5iKx8AMAoCfeMBaNfj/ssQ328OFG+7zdmhIrPOU3W72VsTsGeNnZRJQfzpL4gTlrf64z/SOYmoNPg6KeOBVYcnKHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716907640; c=relaxed/simple;
	bh=QO+rILPMmUh4nu8/ho57QXHNcGepvNHxpBMpLTzTy5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWKGcaQ6Zr4fkInwDRTLwffHWLf/2Ha0ZXxkxanCYTypHNIKOFVQGOmjj+0nfufrTvyg/HiuHWWAULvlIviphjTxiAbglxoV4NWW4wXa57m65vHw/Ah1RKyP8ZkKjWMHCLng3EhPOADRUWhyGW0lvSBVlVFunaxLeMhOYJ0Ms/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wp/uaVtR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wp/uaVtR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0C9C3277B;
	Tue, 28 May 2024 14:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716907640;
	bh=QO+rILPMmUh4nu8/ho57QXHNcGepvNHxpBMpLTzTy5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wp/uaVtRPQN3JEQRoKAgOcLxTTcYrC3WQOyBB5P6gbtJor6dJSUAZFH3W1+Vvo+V/
	 PUSErp18ZBXRhbJeZAOyDyKgMIEWba7nBc+cR4yFeG5iGBrNc33vzzTCRdOdZLJmpX
	 psxXdIlzGT4tcKNv6Od3k/Y5JewG/lIHwt+Zy3j5p+O9ITGiGx+IQAWprK6chN8Mhf
	 gyNsg09aSI/Nw1LH9XHSlRa9BuDagvOEdkSvaQJv2xNA5qObAa27Ubh+dZs+/WGIay
	 hrKzeuOjUeuTi0KYsn5y8YQO9QQyFQMiOO0sKZxzU8htywBrPulCmNUN1aN29UPKil
	 gFQyCa1s3bEGw==
Date: Tue, 28 May 2024 11:47:16 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Artem Savkov <asavkov@redhat.com>
Cc: Guilherme Amadio <amadio@gentoo.org>, Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf record: add a shortcut for metrics
Message-ID: <ZlXudNOs9YLBnLXu@x1>
References: <20240527101519.356342-1-asavkov@redhat.com>
 <ZlS8pc39t2c1WFye@x1>
 <ZlS9M1vcxZ3Qsx_B@x1>
 <ZlTCvelaGVb6lCia@x1>
 <20240528114525.GA449511@alecto.usersys.redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528114525.GA449511@alecto.usersys.redhat.com>

On Tue, May 28, 2024 at 01:45:25PM +0200, Artem Savkov wrote:
> On Mon, May 27, 2024 at 02:28:29PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Mon, May 27, 2024 at 02:04:54PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Mon, May 27, 2024 at 02:02:33PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > On Mon, May 27, 2024 at 12:15:19PM +0200, Artem Savkov wrote:
> > > > > Add -M/--metrics option to perf-record providing a shortcut to record
> > > > > metrics and metricgroups. This option mirrors the one in perf-stat.
> >
> > > > > Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > > > Signed-off-by: Artem Savkov <asavkov@redhat.com>

<SNIP>

> > How did you test this?
> >
> > I'm trying:
> >
> > perf list metric
> >
> > pick a metric then:
> >
> > perf record -M tma_core_bound
> >
> > And it gets in a long loop doing perf_event_open() calls...
> 
> [snip]
> 
> > (gdb) bt
> > #0  0x00007ffff6f21804 in close () from /lib64/libc.so.6
> > #1  0x000000000061fbd2 in perf_evsel__close_fd_cpu (evsel=0xdab470, cpu_map_idx=6) at evsel.c:188
> > #2  0x000000000061fc22 in perf_evsel__close_fd (evsel=0xdab470) at evsel.c:197
> > #3  0x000000000061fc9b in perf_evsel__close (evsel=0xdab470) at evsel.c:211
> > #4  0x00000000004e0b5f in evlist.reset_weak_group ()
> > #5  0x0000000000423bb9 in __cmd_record.constprop.0 ()
> > #6  0x00000000004276c5 in cmd_record ()
> > #7  0x00000000004c4579 in run_builtin ()
> > #8  0x00000000004c4889 in handle_internal_command ()
> > #9  0x0000000000410e57 in main ()
> > (gdb) c
> > Continuing.
> > ^C
> > Program received signal SIGINT, Interrupt.
> > 0x00007ffff6f21804 in close () from /lib64/libc.so.6
> > (gdb)
> >
> > So you should investigate this further.
> 
> I tried a bunch of random metrics from perf list but didn't hit this.
> 
> It spins forever in evlist__for_each_entry() loop in record__open() with
> the same error:
> 
>         Weak group for TOPDOWN.SLOTS/5 failed
> 
> Looks like the culprit is one of those unsupported metrics, will
> investigate.

Right, when trying something new, in a different way than the
pre-existing codebase was envisioned to be used we may uncover latent
problems, that endless loop seems like something we want fixed :-)
 
> > The idea, from my notes, was to be able to have extra columns in 'perf
> > report' with things like IPC and other metrics, probably not all metrics
> > will apply. We need to find a way to find out which ones are OK for that
> > purpose, for instance:
> >
> > Opening: cpu_core/topdown-bad-spec/
> > ------------------------------------------------------------
> > perf_event_attr:
> >   type                             4 (cpu_core)
> >   size                             136
> >   config                           0x8100 (topdown-bad-spec)
> >   { sample_period, sample_freq }   4000
> >   sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
> >   read_format                      ID|LOST
> >   disabled                         1
> >   inherit                          1
> >   freq                             1
> >   sample_id_all                    1
> >   exclude_guest                    1
> > ------------------------------------------------------------
> > sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
> > sys_perf_event_open failed, error -22
> > switching off PERF_FORMAT_LOST support
> > Opening: cpu_core/topdown-bad-spec/
> 
> Is it just metrics containing unsupported events that need to be skipped
> or there are other cases that wouldn't make much sense? If the latter
> maybe it will be easier to just tag the ones that are supported (or not) in
> pmu-events?

Maybe we can use some criteria to look at the metric and filter out
things that are not working right now? As you go on studying the
codebase you will figure out the reasons, sometimes its a bug (the
forever loop above), sometimes it plain don't make sense and we just
skip it, leaving things like IPC, i.e. we have instructions, we have
cycles, that is what needed for IPC, ok, that makes sense and we should
have an IPC column when collecting both cycles and instructions, just
like is done in a ad hoc way for IPC in perf stat since forever.

People want to have those columns in 'perf report' and 'perf top'.

- Arnaldo
