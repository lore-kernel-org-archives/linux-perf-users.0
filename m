Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF4D5437D4;
	Tue, 22 Sep 2026 12:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080522; cv=none; b=ga6dDiMBhGCPNLD1ogjbfQiRR4iIQF7ygu/F7bgB0ptF18k1QgHprGpoPjgbib2MQaS+NMTxDsqGZkho3Qk7LGnqiqMi/Jd7bhoHMwj4ll6LLpESJbrh3clzn8KxsTkXDKvH+yvOPfRVkTzH562MWaJRHQLGIEh7WRtJii5kt/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080522; c=relaxed/simple;
	bh=Ao6s2CkR1TE3SQ0MxHTgkKaLTjQnlV8MjuPDy3XMsrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n04qYi/eGlvsw8EQr6GeXvA3o1qpx0uGkkn505i5rzJtu7vZyEDnY95SN4ysnJYb7F3IA5WiW2tO3pAyDZy+e8fY8RA52rYMqYrY0oQhVeeuAR1HP2MU3Gc4t+nLP+33I3Azw48YSxTce/TUXVpuezxjga2XaC9lhHIfUqPgqvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdfKOusM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdfKOusM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F231F000FF;
	Tue, 22 Sep 2026 12:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790080521;
	bh=K6wXMk5iO4CMgQ1MTeOGYNdTXzMpi/FA7ua0zXMYVVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CdfKOusMEG/bWa3Dj/z7luEGbUWWZoJmPjXDYZXTDiZrL3UUaPGwXGqVtq91snfER
	 MEykg1JiiSR8tcyYL0mbOEE4ivmVYEfKfMOmc+5Ipj6bJjoZvtuDDauzU5WCVW78Dr
	 /NRqVMcZebzHT9/C8l3D2RCitEIj8Bx0OZZ05WSsEvqus+WdMdiXVPUm5GLPwPixTf
	 o5WGCdm3qLinRxPIr0x6hbebQoMPaaH4tr8J/RmysKcSa9iljiiA4PfRUdGmkk/Osz
	 hi7gT6kQqMc3m37Zz/4VWfL4kjxhl6HVx7Y3gY/bHqxInoIdp4WTt6+8QtFQKZkTZG
	 tBgV2U8xLNa7w==
Date: Tue, 22 Sep 2026 14:35:12 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Hui Su <sh_def@163.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf evsel: Restrict incremental open error unwind
Message-ID: <arJ2AHXSkPcwnq7e@x2>
References: <20260912031112.1814574-1-sh_def@163.com>
 <aqdLFApaxDgj1mtZ@google.com>
 <CAP-5=fUWC6F+_HCqW7eFuaw5StZpdcpb+pXPdHbXE+auNdMdTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUWC6F+_HCqW7eFuaw5StZpdcpb+pXPdHbXE+auNdMdTw@mail.gmail.com>

On Mon, Sep 21, 2026 at 09:00:43AM -0700, Ian Rogers wrote:
> On Sun, Sep 13, 2026 at 6:17 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Sat, Sep 12, 2026 at 12:11:10PM +0900, Hui Su wrote:
> > > evsel__open_cpu(), evsel__tool_pmu_open() and
> > > evsel__hwmon_pmu_open() support opening a subrange of a CPU map, bounded
> > > by [start_cpu_map_idx, end_cpu_map_idx).
> > >
> > > Their error paths, however, unwind using "while (--idx >= 0)" all the way
> > > back to CPU index 0 regardless of start_cpu_map_idx. If lower CPU indices
> > > were opened by an earlier invocation, a later incremental open failure
> > > therefore closes those existing file descriptors and overwrites their
> > > slots with -1.
> > >
> > > Before this fix, running the new incremental open test demonstrates this
> > > corruption:
> > >
> > >   $ perf test -v "Tool PMU"
> > >    12: Tool PMU:
> > >    12.1: Tool PMU                                                      : Ok
> > >    12.2: Tool PMU leader                                               : Ok
> > >    12.3: Incremental open error unwind boundary:
> > >      FAILED: CPU 0 FD overwritten: FD(evsel, 0, 0)=-1, expected 4
> > >   FAILED!
> > >
> > > Stop the unwind at start_cpu_map_idx so that only file descriptors
> > > opened by the current invocation are rolled back.
> > >
> > > After this fix:
> > >
> > >   $ perf test -v "Tool PMU"
> > >    12: Tool PMU:
> > >    12.1: Tool PMU                                                      : Ok
> > >    12.2: Tool PMU leader                                               : Ok
> > >    12.3: Incremental open error unwind boundary                        : Ok
> > >
> > > Fixes: 4804e0111662 ("perf stat: Use affinity for opening events")
> > > Fixes: 240505b2d0ad ("perf tool_pmu: Factor tool events into their own PMU")
> > > Fixes: 53cc0b351ec9 ("perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysfs")
> >
> > Maybe we just need to last one?
> >
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
