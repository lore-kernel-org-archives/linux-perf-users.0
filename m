Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15CD3EDE47;
	Tue, 12 May 2026 19:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778615308; cv=none; b=HTj04GPjWq7K8CX0aXsD8fgWMQPtsd9QCKP3xyeXBoPYgHMpWAK6BNSG3TLpcqD73EMgGF+IU2BPl3CSPyTRs+oBxJ+PzdvX6ZjeTo54WxmrvjWBLfX8Say6MJMY/15hRnxofsdiXVrn6TBOe6UjaGdfPnBNkoh3I5B3SLWQgsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778615308; c=relaxed/simple;
	bh=E11TyrzVW6l2YhurNvs+33OH++tyq2ULcTLn67nq5kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhKaLOCEUgVag690D375KCSTS3LpmpRcyeSxdDbtg3nVxGKGPIfFtqk5oLV9yJko+qD7p/IQpfSGnvhz77XXGYdGR+VWu911IUGhjh6JPaDYT+sxdb+0l60wcYLETMaRSI0JpG7DSp9iLtPgGkaTZDFDcisQZJf/RyAVHo7yybY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RL/BSP3A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RL/BSP3A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DD6C2BCB0;
	Tue, 12 May 2026 19:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778615308;
	bh=E11TyrzVW6l2YhurNvs+33OH++tyq2ULcTLn67nq5kw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RL/BSP3ARvXTSbwrNERPW374RPDnAIq1Sb2sCJoy+Jlsx/kVuDQPbsDXUXJQ8fbDD
	 FqNWL5hOWu63ZNK97KtgY+6FZv2jHhlGsG8V3z46i4NZ6Ql7B48nY5kVNAy10u5K0Y
	 acWzg6ujBzOcQt4Xy6R2ST2DlS/Fwe6HM+Wz8BxsrP2AB0+XOCPcNvDIh62waUmWQk
	 IBzaSZHm+/GUPS5kZxwft+/aSQ8sdCl0Oj09QuhEAJjhR9lJncn0K1jvFwKFSY9/2C
	 BHmxOonHF8M19d7Z0W+455Y1Izx5F3WacALgUJGlDpadSe0pNUstDso6IPp3LsaFvH
	 +rElP4c61EKIw==
Date: Tue, 12 May 2026 16:48:24 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>, sashiko-bot@kernel.org,
	"Claude Opus 4.6 (1M context)" <noreply@anthropic.com>
Subject: Re: [PATCH 26/28] perf timechart: Bounds check cpu_id and fix
 topology_map allocation
Message-ID: <agOECAaMwN_mQekU@x1>
References: <20260510033424.255812-1-acme@kernel.org>
 <20260510033424.255812-27-acme@kernel.org>
 <CAP-5=fU11BRywA+YaRV5X6iLw0zfm5ju2B9PuZ6yJn8aAtv4XQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU11BRywA+YaRV5X6iLw0zfm5ju2B9PuZ6yJn8aAtv4XQ@mail.gmail.com>

On Tue, May 12, 2026 at 11:32:48AM -0700, Ian Rogers wrote:
> On Sat, May 9, 2026 at 8:37 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > The cpu_idle, cpu_frequency, power_start, and power_frequency
> > tracepoint handlers extract cpu_id from the event payload via
> > evsel__intval() and use it directly as an array index into
> > cpus_cstate_start_times[] and cpus_pstate_start_times[], which
> > are allocated with MAX_CPUS (4096) entries.
> >
> > Unlike sample->cpu which is validated in perf_session__deliver_event(),
> > cpu_id comes from the tracepoint data and is never bounds checked.
> > A crafted perf.data with a malicious cpu_id in a tracepoint event
> > causes out-of-bounds array accesses.
> >
> > Validate cpu_id against tchart->numcpus (nr_cpus_avail from the
> > file header) and reject the event with an error if it is out of
> > range, as this indicates a corrupted or crafted file.
> >
> > The power_end handler uses sample->cpu (not a tracepoint cpu_id
> > field).  Add a bounds check there too since a crafted file could
> > omit PERF_SAMPLE_CPU, leaving sample->cpu as the (u32)-1 sentinel
> > which would cause out-of-bounds access in c_state_end().
> >
> > Also validate sample->cpu in sched_switch and sched_wakeup
> > handlers, which store it in cpu_sample structs later used as
> > array indices into topology_map[] during SVG generation.
> >
> > Fix svg_build_topology_map() to allocate topology_map using
> > nr_cpus_avail instead of nr_cpus_online.  When offline CPUs exist,
> > nr_cpus_online < nr_cpus_avail, and a valid cpu_id that passes
> > the numcpus check could still exceed the topology_map allocation,
> > causing a heap out-of-bounds read in cpu2y().  Reject negative CPU
> > values in str_to_bitmap() to prevent perf_cpu_map__new("") on an
> > empty topology string from passing -1 to __set_bit(), which would
> > write at offset ULONG_MAX/BITS_PER_LONG.
> >
> > Fix the pre-existing backtrace memory leak: change the
> > tracepoint_handler typedef to pass const char **backtrace
> > (pointer-to-pointer).  Handlers that consume the string
> > (sched_switch, sched_wakeup) set *backtrace = NULL to claim
> > ownership.  The caller always calls free() after the handler
> > returns — if ownership was taken the pointer is NULL and
> > free(NULL) is a no-op.  Skip cat_backtrace() entirely when
> > tchart->with_backtrace is not set.
> >
> > Cap tchart->numcpus at MAX_CPUS in the HEADER_NRCPUS callback
> > so the bounds check cannot exceed the array allocation size.
> 
> So there are some overlaps with the changes in:
> https://lore.kernel.org/lkml/20260413041143.1736055-18-irogers@google.com/
> I'll repost the series that Namhyung started merging. It would be good
> to rebase these changes on that.

Please rebase and resubmit, I can adjust before sending v2 for the perf
data validation series.

- Arnaldo
