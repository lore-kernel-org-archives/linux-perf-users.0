Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EA1225403;
	Thu,  6 Feb 2025 07:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828447; cv=none; b=U7nhD0nPg5qus15EpJCU4NKwq1VKlkpzAz2n0YgGWRXFagSG/uRfTgjkyWoZrpV4vjo9SVoW1vnNL5GWwIJSSs2PioF2uGwIP7Hn1zG6I8fj/5OeCQZagPSWF+fnT73BpsCFgIgzzEuGvXbYBs5QtzLrunyaYo6MUjfkrddWjCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828447; c=relaxed/simple;
	bh=v/9j4H1SumVNswTEB2Bzev+qU+VGsBh3b/2fynpUEI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvlPaHJAbj+a6BW/W8frZMbzgBsF0aDwIimnW9XNSBNeODvYz8KCvJoJ3bg1QlsEbMbC7DB0DDBMzx0pqI9jd4qBY9WMpLvj4xKrFhcnttmbv/4gdZdirl4YYr+3d7W0q19Q/yfZOa+xfdolDo8E0s/nhTCUAF0KuxzN5fcVJI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DcqhBu4J; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DcqhBu4J"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=a9pYqLRoxBjhQQODtbQiPWkuyLKJRbcRMir3jVYiFx4=; b=DcqhBu4JKY5iso98bZeB9UaC/k
	SiJBbdAaSE6gY3TZwACzBjb3tQ+J7Ppnrq92twnFeped0uSKDQwHirPg+NmQ7kKEgW9NSihuE50D3
	UTSUYIUxDWffmEEMJJHRu3qXlNXi+CFnlmQDbc0ITATVEfQM5EvKH4ZQBMiyVXSkgpmBJfcLYby5N
	wc1zDSeZF4olcmQBEPh5cGL9HoRUyPUs9iNL+LPL4udcX2TqEXKd8l2jNR2jg6k7EfyjZFHraLB6T
	Q8J33oU6GRtfmzrE/dDXlbtT1OA7w2saG9rAN2+VBZeQg57eDcXJaXovyA8tywYdeHNsg7urE6aqG
	9M6k5QGA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tfwhy-00000005f1r-0vQ6;
	Thu, 06 Feb 2025 07:53:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D6DCC3003AF; Thu,  6 Feb 2025 08:53:56 +0100 (CET)
Date: Thu, 6 Feb 2025 08:53:56 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [PATCH 01/20] perf/x86/intel: Add PMU support for Clearwater
 Forest
Message-ID: <20250206075356.GF7145@noisy.programming.kicks-ass.net>
References: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
 <20250123140721.2496639-2-dapeng1.mi@linux.intel.com>
 <20250127162651.GL16742@noisy.programming.kicks-ass.net>
 <d31dcd21-7455-4108-96d7-e29ecde1c5de@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d31dcd21-7455-4108-96d7-e29ecde1c5de@linux.intel.com>

On Thu, Feb 06, 2025 at 09:31:46AM +0800, Mi, Dapeng wrote:
> 
> On 1/28/2025 12:26 AM, Peter Zijlstra wrote:
> > On Thu, Jan 23, 2025 at 02:07:02PM +0000, Dapeng Mi wrote:
> >> From PMU's perspective, Clearwater Forest is similar to the previous
> >> generation Sierra Forest.
> >>
> >> The key differences are the ARCH PEBS feature and the new added 3 fixed
> >> counters for topdown L1 metrics events.
> >>
> >> The ARCH PEBS is supported in the following patches. This patch provides
> >> support for basic perfmon features and 3 new added fixed counters.
> >>
> >> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> >> ---
> >>  arch/x86/events/intel/core.c | 24 ++++++++++++++++++++++++
> >>  1 file changed, 24 insertions(+)
> >>
> >> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> >> index b140c1473a9d..5e8521a54474 100644
> >> --- a/arch/x86/events/intel/core.c
> >> +++ b/arch/x86/events/intel/core.c
> >> @@ -2220,6 +2220,18 @@ static struct extra_reg intel_cmt_extra_regs[] __read_mostly = {
> >>  	EVENT_EXTRA_END
> >>  };
> >>  
> >> +EVENT_ATTR_STR(topdown-fe-bound,       td_fe_bound_skt,        "event=0x9c,umask=0x01");
> >> +EVENT_ATTR_STR(topdown-retiring,       td_retiring_skt,        "event=0xc2,umask=0x02");
> >> +EVENT_ATTR_STR(topdown-be-bound,       td_be_bound_skt,        "event=0xa4,umask=0x02");
> >> +
> >> +static struct attribute *skt_events_attrs[] = {
> >> +	EVENT_PTR(td_fe_bound_skt),
> >> +	EVENT_PTR(td_retiring_skt),
> >> +	EVENT_PTR(td_bad_spec_cmt),
> >> +	EVENT_PTR(td_be_bound_skt),
> >> +	NULL,
> >> +};
> > The skt here is skymont, which is what Sierra Forest was based on, and
> > you just said that these counters are new with Darkmont, and as such the
> > lot should be called: dmt or whatever the proper trigraph is.
> 
> Sorry for late response since the Chinese new year holiday.
> 
> Sierra Forest is based on Crestmont instead of Skymont. 

I hate all these names :-( But yeah, you're right.

> The 3 new fixed counters are introduced from Skymont and Darkmont
> inherits them. So these attributes are named with "skt" suffix.

Fair enough.

But how come this is new for darkmont and wasn't done for
arrowlake/lunarlake which have skymont based e-cores?

