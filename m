Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91752378D75;
	Mon, 19 Jan 2026 15:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768837403; cv=none; b=YDRw2PoBb/aaTDTMnjDTg0rAZHTvMLidhDLNoeXJQRHCySm2Tm1Ikym/1LOh4V/ZzNmYZ6ComSr/rwXF0U0lKwJsODLP5cfFz8OD5pHqg0D8DTzxqce+6Ydd8nPKhzobUsBtmK/KZ+ankU7bDigrx4ZnhXoiKUYfbKX8JMieDys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768837403; c=relaxed/simple;
	bh=nhPskLs+534ibUXhfPh4Y4kgev19OIsaGtqanHfXroA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOyIXRBRcFiKnq10p/oz8GexVbEGpv5VZJcMUoqJnmB+VHUZSq5yhmlGqQO7ra2DMy90ahzBXJkLScQrD+1UjX5OARLglu54YIVSUtcz9Q+C+xji+yJcZvFgcsGes1cI0x98BmKthMYEGFE1V+dTV/7MPLJkCenME01q87+I4YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5919D497;
	Mon, 19 Jan 2026 07:43:14 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8527B3F694;
	Mon, 19 Jan 2026 07:43:20 -0800 (PST)
Date: Mon, 19 Jan 2026 15:43:18 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf cs-etm: Fix decoding for sparse CPU maps
Message-ID: <20260119153846.GD2732125@e132581.arm.com>
References: <20260119-james-perf-coresight-cpu-map-segfault-v2-0-56b956a629ee@linaro.org>
 <20260119-james-perf-coresight-cpu-map-segfault-v2-1-56b956a629ee@linaro.org>
 <20260119111509.GD1286628@e132581.arm.com>
 <3b06ea25-2516-406c-8b78-c359d3fb2aa6@linaro.org>
 <20260119145337.GB2732125@e132581.arm.com>
 <dd9a3cde-ea9f-4c53-b537-f15767bf4d99@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd9a3cde-ea9f-4c53-b537-f15767bf4d99@linaro.org>

On Mon, Jan 19, 2026 at 03:16:01PM +0000, James Clark wrote:

[...]

> > > > >    		/*
> > > > >    		 * If this AUX event was inside this buffer somewhere, create a new auxtrace event
> > > > > @@ -3095,6 +3095,7 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
> > > > >    		auxtrace_fragment.auxtrace = *auxtrace_event;
> > > > >    		auxtrace_fragment.auxtrace.size = aux_size;
> > > > >    		auxtrace_fragment.auxtrace.offset = aux_offset;
> > > > > +		auxtrace_fragment.auxtrace.idx = etmq->queue_nr;
> > 
> > I am still confused about this.  Because above auxtrace will be queued
> > on cs_etm queues, should we convert from the generic buffer index to the
> > cs_etm specific one?  E.g.,
> > 
> >    auxtrace_fragment.auxtrace.idx = auxtrace_event->cpu;
> > 
> 
> This is basically what the change is already doing. etmq->queue_nr == CPU
> because cs_etm__setup_queue() is called for every CPU up to max_cpu, not
> only for ones that were recorded so it has a 1:1 mapping. Using
> etmq->queue_nr also works in per-thread mode where queue 0 is used, which
> your suggestion doesn't handle. Otherwise they would be equivalent.

Indeed, per-thread mode needs to be handled separately.

On the Juno board (6 CPUs), I see "etmq->queue_nr=6".  It seems a bit
odd that this value is used as the index.  Even in per-thread mode, the
index is still set to 6.  For correctness, should we instead set the
index to the CPU ID, and use 0 for per-thread mode?

> To be honest the whole decoder has become hacks on top of hacks. I think we
> might want to do a full from scratch re-write when we come to do the proper
> timestamp to MMAP event correlation or the change to not keep resetting the
> decoder for TRBE wrap mode.
> 
> > BTW, if my understanding above is valid, it is good to go through the
> > cs_etm.c file for the "idx <-> CPU ID" conversion.
> 
> Do you mean there are other mistakes?

Yes.

> I did check the rest and did some testing and didn't see any issues.

Thanks a lot for the checking.

Leo
