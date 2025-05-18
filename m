Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F5121E082;
	Sun, 18 May 2025 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747588148; cv=none; b=n++YhrcGYcN7groPRQl8SRJBCbauxMZglONvRzbgI95N8Czs2LuHO0UjrMvzkrstH5ukbhDNWMF3MTdilA8+uCIlrY96RI5I3lnphmTYtFHOgu2HdFsOoJj2k4FknDUfy+1liDvr+kEn0FSSJ7hBd0WHMYDgBhwdeYD+JhOmeH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747588148; c=relaxed/simple;
	bh=vQcsrWRA08QY2KPE2gsn2wmLYQ7YYkezxTgni739aZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JI+qo05/wdYMTnTlyGfI54QnpezpzW+zJUOsWbcPP4hzfz5wp4Yx1jCkQs/mgONJ3CgXpAFKzQ2vI+wXs6OfeDu9IQr/gmAy15SI4s97x7aRhPE3awq5dKietCUKupaaY53cMMIXGuhDKzQMJ9LgjX3k9VWxrZNgXj5VX2kZUpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiN8GDJs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiN8GDJs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA13C4CEE9;
	Sun, 18 May 2025 17:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747588147;
	bh=vQcsrWRA08QY2KPE2gsn2wmLYQ7YYkezxTgni739aZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZiN8GDJsi8h4WfbR+lgrkqBIp6bF6bVpGg8MaKYmR60sZYRZql1GB/HNexWthekuk
	 13ReHAgh0ajC0nIHH91CmSoIRVQPbHwg2rJRnNZUIuPbZnu22RSSE+FPX6pxgyx52+
	 IDFrWNwCRHmf234AP8Ex6DyiL3WNC1bcXxy/En/IRQmCbiFUqeRb6+78KhOvfjpssb
	 qChlWM+evj8lFrnecres6eRmBxEN5xwsjvkv9liTnqgnOi8XgKH8ETuNe4IQXkFVLq
	 fAh7GaGNwJbg8vJhDI1F/Ed1JzyAndKkSrn+CDTAP60894aFcFm4AJ+Mh0/QFPjfSq
	 L7B7C6jFNSGvg==
Date: Sun, 18 May 2025 10:09:04 -0700
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
Message-ID: <aCoUMOVRjCr_t0ae@google.com>
References: <20250515181417.491401-1-irogers@google.com>
 <96c8fae8-b8f9-4094-b03a-9dba3ca234c2@linux.intel.com>
 <CAP-5=fVDF4-qYL1Lm7efgiHk7X=_nw_nEFMBZFMcsnOOJgX4Kg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVDF4-qYL1Lm7efgiHk7X=_nw_nEFMBZFMcsnOOJgX4Kg@mail.gmail.com>

Hello,

On Thu, May 15, 2025 at 03:35:41PM -0700, Ian Rogers wrote:
> On Thu, May 15, 2025 at 2:01 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
> >
> > On 2025-05-15 2:14 p.m., Ian Rogers wrote:
> > > On graniterapids the cache home agent (CHA) and memory controller
> > > (IMC) PMUs all have their cpumask set to per-socket information. In
> > > order for per NUMA node aggregation to work correctly the PMUs cpumask
> > > needs to be set to CPUs for the relevant sub-NUMA grouping.
> > >
> > > For example, on a 2 socket graniterapids machine with sub NUMA
> > > clustering of 3, for uncore_cha and uncore_imc PMUs the cpumask is
> > > "0,120" leading to aggregation only on NUMA nodes 0 and 3:
> > > ```
> > > $ perf stat --per-node -e 'UNC_CHA_CLOCKTICKS,UNC_M_CLOCKTICKS' -a sleep 1
> > >
> > >  Performance counter stats for 'system wide':
> > >
> > > N0        1    277,835,681,344      UNC_CHA_CLOCKTICKS
> > > N0        1     19,242,894,228      UNC_M_CLOCKTICKS
> > > N3        1    277,803,448,124      UNC_CHA_CLOCKTICKS
> > > N3        1     19,240,741,498      UNC_M_CLOCKTICKS
> > >
> > >        1.002113847 seconds time elapsed
> > > ```
> > >
> > > By updating the PMUs cpumasks to "0,120", "40,160" and "80,200" then
> > > the correctly 6 NUMA node aggregations are achieved:
> > > ```
> > > $ perf stat --per-node -e 'UNC_CHA_CLOCKTICKS,UNC_M_CLOCKTICKS' -a sleep 1
> > >
> > >  Performance counter stats for 'system wide':
> > >
> > > N0        1     92,748,667,796      UNC_CHA_CLOCKTICKS
> > > N0        0      6,424,021,142      UNC_M_CLOCKTICKS
> > > N1        0     92,753,504,424      UNC_CHA_CLOCKTICKS
> > > N1        1      6,424,308,338      UNC_M_CLOCKTICKS
> > > N2        0     92,751,170,084      UNC_CHA_CLOCKTICKS
> > > N2        0      6,424,227,402      UNC_M_CLOCKTICKS
> > > N3        1     92,745,944,144      UNC_CHA_CLOCKTICKS
> > > N3        0      6,423,752,086      UNC_M_CLOCKTICKS
> > > N4        0     92,725,793,788      UNC_CHA_CLOCKTICKS
> > > N4        1      6,422,393,266      UNC_M_CLOCKTICKS
> > > N5        0     92,717,504,388      UNC_CHA_CLOCKTICKS
> > > N5        0      6,421,842,618      UNC_M_CLOCKTICKS
> >
> > Is the second coloum  the number of units?
> > If so, it's wrong.
> >
> > On my GNR with SNC-2, I observed the similar issue.
> >
> > $ sudo ./perf stat -e 'UNC_M_CLOCKTICKS' --per-node -a sleep 1
> >  Performance counter stats for 'system wide':
> >
> > N0        0      6,405,811,284      UNC_M_CLOCKTICKS
> > N1        1      6,405,895,988      UNC_M_CLOCKTICKS
> > N2        0      6,152,906,692      UNC_M_CLOCKTICKS
> > N3        1      6,063,415,630      UNC_M_CLOCKTICKS
> >
> > It's supposed to be 4?
> 
> Agreed it is weird, but it is what has historically been displayed.
> The number is the aggregation number:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/stat-display.c?h=perf-tools-next#n307
> which comes from:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/stat-display.c?h=perf-tools-next#n135
> which comes from:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/stat.c?h=perf-tools-next#n435
> However, I think it is missing updates from:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/stat.c?h=perf-tools-next#n526
> but there is a comment there saying "don't increase aggr.nr for
> aliases" and all the uncore events are aliases. I don't understand
> what the aggregation number is supposed to be, it is commented as
> "number of entries (CPUs) aggregated":
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/stat.h?h=perf-tools-next#n26
> it would seem to make sense in the CHA case with SNC3 and 42 evsels
> per NUMA node that the value should be 42. Maybe Namhyung (who did the
> evsel__merge_aggr_counters clean up) knows why it is this way but in
> my eyes it just seems like something that has been broken for a long
> time.

I think it's the number of aggregated entries (FDs?).

For core events, it's the number of CPUs for the given aggregation as it
collects from all CPUs.  But it'd be confusing with uncore events which
have cpumask to collect data from a few CPUs.

On my laptop, --per-socket gives different numbers depending on the
events/PMUs.

For core events, it's 4.

  $ sudo ./perf stat -a --per-socket -e cycles sleep 1
  
   Performance counter stats for 'system wide':
  
  S0        4        225,297,257      cycles                                                                
  
         1.002581995 seconds time elapsed

While uncore events give 1.

  $ sudo ./perf stat -a --per-socket -e unc_mc0_rdcas_count_freerun sleep 1
  
   Performance counter stats for 'system wide':
  
  S0        1         23,665,510      unc_mc0_rdcas_count_freerun                                           
  
         1.002148012 seconds time elapsed

Thanks,
Namhyung

