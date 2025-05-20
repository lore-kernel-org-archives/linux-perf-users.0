Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8991ADC97;
	Tue, 20 May 2025 02:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747706407; cv=none; b=bvkEObDcT+1lZnFwc4JZefIK0iUogjycIi7D0BswTTNuRa00+Qpgcxm8omj1QvqMl5Bg3mrNOUC38+xHo3L9U0lUNz5w5WDaqNSJkQ0tqj+OhQEqkOkj+p2McrxwWeZlFolQkIfzTRK4FOf/UUjr+ZxQOnLsACZrKQ3bCylM6d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747706407; c=relaxed/simple;
	bh=52euy4QIRy5S1PGduCTG74ILWWuUGNpvW5W9e++vdKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mu2+EoCGMjA5G6nQKdPhBCLx29JZSWPQp79c7WgMV2tzjpp3WWAiStIXDv4BTlr/WGY0oUwQZfgKpiqX4aaaB0a47j+qa/TEPxZoMc3aTe2Rw4wY/7cYI9BFksyDaJXuyCqtFqpSHVPrSmUJ8iv2uDDMLNr0Slx9TPsenQyKFhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWXOsEhK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWXOsEhK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADABC4CEE4;
	Tue, 20 May 2025 02:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747706406;
	bh=52euy4QIRy5S1PGduCTG74ILWWuUGNpvW5W9e++vdKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jWXOsEhKK41XUrZiULw+qd8Ccxr1syXDIj0Q4n2B1srvtLKQfOxqx5WciuukmtngI
	 57Aw/93p9jKs0nZY8ZNyT4iZd8/lm3b+8tMQl8397uHKPUL7cuK2axFpKi1dFm6RUx
	 llxDPQu5TrhNP+M70kRKeBT4gV+V4M69trRxWL6T6x4lqIMd2LKTAT29til+o31wgb
	 v5wBfuxftKYnmoqW289Wg8A1xr7PkynTljJQmX32xg0Udth0nrVVNkE8lJU5Ngy4wt
	 fJrQ17ZWe8/6D/kWXr/vo0NEnznwhVkZUSKox4xtE69+sF6bg/11mlR4V3KfpZoOic
	 q4Tse2wKZJaJA==
Date: Mon, 19 May 2025 19:00:04 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf pmu intel: Adjust cpumaks for sub-NUMA clusters
 on graniterapids
Message-ID: <aCviJJpEYKt8wYEk@google.com>
References: <20250515181417.491401-1-irogers@google.com>
 <96c8fae8-b8f9-4094-b03a-9dba3ca234c2@linux.intel.com>
 <CAP-5=fVDF4-qYL1Lm7efgiHk7X=_nw_nEFMBZFMcsnOOJgX4Kg@mail.gmail.com>
 <aCoUMOVRjCr_t0ae@google.com>
 <CAP-5=fXnvRLiGmV7rr2H8A2Hj7HDE9m+B6Qn0areRXBhz-tK+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXnvRLiGmV7rr2H8A2Hj7HDE9m+B6Qn0areRXBhz-tK+Q@mail.gmail.com>

On Sun, May 18, 2025 at 10:45:52AM -0700, Ian Rogers wrote:
> On Sun, May 18, 2025 at 10:09 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello,
> >
> > On Thu, May 15, 2025 at 03:35:41PM -0700, Ian Rogers wrote:
> > > On Thu, May 15, 2025 at 2:01 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
> > > >
> > > > On 2025-05-15 2:14 p.m., Ian Rogers wrote:
> > > > > On graniterapids the cache home agent (CHA) and memory controller
> > > > > (IMC) PMUs all have their cpumask set to per-socket information. In
> > > > > order for per NUMA node aggregation to work correctly the PMUs cpumask
> > > > > needs to be set to CPUs for the relevant sub-NUMA grouping.
> > > > >
> > > > > For example, on a 2 socket graniterapids machine with sub NUMA
> > > > > clustering of 3, for uncore_cha and uncore_imc PMUs the cpumask is
> > > > > "0,120" leading to aggregation only on NUMA nodes 0 and 3:
> > > > > ```
> > > > > $ perf stat --per-node -e 'UNC_CHA_CLOCKTICKS,UNC_M_CLOCKTICKS' -a sleep 1
> > > > >
> > > > >  Performance counter stats for 'system wide':
> > > > >
> > > > > N0        1    277,835,681,344      UNC_CHA_CLOCKTICKS
> > > > > N0        1     19,242,894,228      UNC_M_CLOCKTICKS
> > > > > N3        1    277,803,448,124      UNC_CHA_CLOCKTICKS
> > > > > N3        1     19,240,741,498      UNC_M_CLOCKTICKS
> > > > >
> > > > >        1.002113847 seconds time elapsed
> > > > > ```
> > > > >
> > > > > By updating the PMUs cpumasks to "0,120", "40,160" and "80,200" then
> > > > > the correctly 6 NUMA node aggregations are achieved:
> > > > > ```
> > > > > $ perf stat --per-node -e 'UNC_CHA_CLOCKTICKS,UNC_M_CLOCKTICKS' -a sleep 1
> > > > >
> > > > >  Performance counter stats for 'system wide':
> > > > >
> > > > > N0        1     92,748,667,796      UNC_CHA_CLOCKTICKS
> > > > > N0        0      6,424,021,142      UNC_M_CLOCKTICKS
> > > > > N1        0     92,753,504,424      UNC_CHA_CLOCKTICKS
> > > > > N1        1      6,424,308,338      UNC_M_CLOCKTICKS
> > > > > N2        0     92,751,170,084      UNC_CHA_CLOCKTICKS
> > > > > N2        0      6,424,227,402      UNC_M_CLOCKTICKS
> > > > > N3        1     92,745,944,144      UNC_CHA_CLOCKTICKS
> > > > > N3        0      6,423,752,086      UNC_M_CLOCKTICKS
> > > > > N4        0     92,725,793,788      UNC_CHA_CLOCKTICKS
> > > > > N4        1      6,422,393,266      UNC_M_CLOCKTICKS
> > > > > N5        0     92,717,504,388      UNC_CHA_CLOCKTICKS
> > > > > N5        0      6,421,842,618      UNC_M_CLOCKTICKS
> > > >
> > > > Is the second coloum  the number of units?
> > > > If so, it's wrong.
> > > >
> > > > On my GNR with SNC-2, I observed the similar issue.
> > > >
> > > > $ sudo ./perf stat -e 'UNC_M_CLOCKTICKS' --per-node -a sleep 1
> > > >  Performance counter stats for 'system wide':
> > > >
> > > > N0        0      6,405,811,284      UNC_M_CLOCKTICKS
> > > > N1        1      6,405,895,988      UNC_M_CLOCKTICKS
> > > > N2        0      6,152,906,692      UNC_M_CLOCKTICKS
> > > > N3        1      6,063,415,630      UNC_M_CLOCKTICKS
> > > >
> > > > It's supposed to be 4?
> > >
> > > Agreed it is weird, but it is what has historically been displayed.
> > > The number is the aggregation number:
> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/stat-display.c?h=perf-tools-next#n307
> > > which comes from:
> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/stat-display.c?h=perf-tools-next#n135
> > > which comes from:
> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/stat.c?h=perf-tools-next#n435
> > > However, I think it is missing updates from:
> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/stat.c?h=perf-tools-next#n526
> > > but there is a comment there saying "don't increase aggr.nr for
> > > aliases" and all the uncore events are aliases. I don't understand
> > > what the aggregation number is supposed to be, it is commented as
> > > "number of entries (CPUs) aggregated":
> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/stat.h?h=perf-tools-next#n26
> > > it would seem to make sense in the CHA case with SNC3 and 42 evsels
> > > per NUMA node that the value should be 42. Maybe Namhyung (who did the
> > > evsel__merge_aggr_counters clean up) knows why it is this way but in
> > > my eyes it just seems like something that has been broken for a long
> > > time.
> >
> > I think it's the number of aggregated entries (FDs?).
> >
> > For core events, it's the number of CPUs for the given aggregation as it
> > collects from all CPUs.  But it'd be confusing with uncore events which
> > have cpumask to collect data from a few CPUs.
> >
> > On my laptop, --per-socket gives different numbers depending on the
> > events/PMUs.
> >
> > For core events, it's 4.
> >
> >   $ sudo ./perf stat -a --per-socket -e cycles sleep 1
> >
> >    Performance counter stats for 'system wide':
> >
> >   S0        4        225,297,257      cycles
> >
> >          1.002581995 seconds time elapsed
> >
> > While uncore events give 1.
> >
> >   $ sudo ./perf stat -a --per-socket -e unc_mc0_rdcas_count_freerun sleep 1
> >
> >    Performance counter stats for 'system wide':
> >
> >   S0        1         23,665,510      unc_mc0_rdcas_count_freerun
> >
> >          1.002148012 seconds time elapsed
> 
> I think we're agreeing. I wonder that the intent of the aggregation
> number is to make it so that you can work out an average from the
> aggregated count. So for core PMUs you divide the count by the
> aggregation number and get the average count per core (CPU?). If we're
> getting an aggregated count of say uncore memory controller events
> then it would make sense to me that we show the aggregated total and
> the aggregation count is the number of memory controller PMUs, so we
> can have an average per memory controller. This should line up with
> using the number of file descriptors.

Sounds right.

> 
> I think this isn't the current behavior, on perf v6.12:
> ```
> $ sudo perf stat --per-socket -e data_read -a sleep 1
> 
>  Performance counter stats for 'system wide':
> 
> S0        1           2,484.96 MiB  data_read
> 
>        1.001365319 seconds time elapsed
> 
> $ sudo perf stat -A -e data_read -a sleep 1
> 
>  Performance counter stats for 'system wide':
> 
> CPU0             1,336.48 MiB  data_read [uncore_imc_free_running_0]
> CPU0             1,337.06 MiB  data_read [uncore_imc_free_running_1]
> 
>        1.001049096 seconds time elapsed
> ```
> so the aggregation number shows 1 but 2 events were aggregated together.

Ugh.. right.  Merging uncore PMU instances can add more confusion. :(

> 
> I think computing the aggregation number in the stat code is probably
> wrong. The value should be constant for an evsel and aggr_cpu_id, it's
> just computing it for an aggr_cpu_id is a pain due to needing topology
> and/or PMU information. The code is ripe for refactoring. I'd prefer
> not to do it as part of this change though which is altering a
> particular Intel Granite Rapids issue.

That's ok.  Just one more TODO items..

Thanks,
Namhyung

