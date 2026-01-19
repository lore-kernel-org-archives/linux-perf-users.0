Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D5E38FF18;
	Mon, 19 Jan 2026 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768834422; cv=none; b=kHDbWGNc46GvsPaRe8d8/0mY6OnbgWvzC61+RA95jnD/FSgoo1q2EE9VWmftzUjq5sDcIMInUM0EH/4l3zORN4zEvEfAFQVnXMU7vyD0fZZPx9aW7cVlOMBH5Iq+wmteivMVPFm7JMFVOzlwVpv0Ifqla5OCzwhCZ8+blmI6WnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768834422; c=relaxed/simple;
	bh=WpXjA6CjS5Jb8kjUV+WVKazhQE6A46LlCflZ+UR39fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOeZCswq0FwDA5KQwUHXqsyYdwC3LYY5tAgU/lHXAV7vmz6XSWhT9Lu+TUW/gBkbkbNW+ulOzXGihTqK2Sw33/+8DbAezi1ge5yF5CuhmPE8OzHgMTTsuMFSWCsR4RvX/d2bLI2zgdtaV8VUxq5U2o2tCUrQd3ot+khDnCIwMBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D2B0497;
	Mon, 19 Jan 2026 06:53:34 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 396D13F694;
	Mon, 19 Jan 2026 06:53:40 -0800 (PST)
Date: Mon, 19 Jan 2026 14:53:37 +0000
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
Message-ID: <20260119145337.GB2732125@e132581.arm.com>
References: <20260119-james-perf-coresight-cpu-map-segfault-v2-0-56b956a629ee@linaro.org>
 <20260119-james-perf-coresight-cpu-map-segfault-v2-1-56b956a629ee@linaro.org>
 <20260119111509.GD1286628@e132581.arm.com>
 <3b06ea25-2516-406c-8b78-c359d3fb2aa6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b06ea25-2516-406c-8b78-c359d3fb2aa6@linaro.org>

On Mon, Jan 19, 2026 at 11:55:53AM +0000, James Clark wrote:

[...]

> > >    0 0 0x200 [0x90]: PERF_RECORD_ID_INDEX nr: 4
> > >    ... id: 771  idx: 0  cpu: 2  tid: -1
> > >    ... id: 772  idx: 1  cpu: 3  tid: -1
> > >    ... id: 773  idx: 0  cpu: 2  tid: -1
> > >    ... id: 774  idx: 1  cpu: 3  tid: -1
> > 
> > Seems to me that this patch works around the issue by using the CPU ID
> > instead, but event->auxtrace.idx is broken.
>
> I don't think it's a workaround, I think it should have been written this
> way in the first place.

Agree.  Sorry for confusion in my rely.

[...]

> > > @@ -3086,7 +3086,7 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
> > >   	if (aux_offset >= auxtrace_event->offset &&
> > >   	    aux_offset + aux_size <= auxtrace_event->offset + auxtrace_event->size) {
> > > -		struct cs_etm_queue *etmq = etm->queues.queue_array[auxtrace_event->idx].priv;
> > > +		struct cs_etm_queue *etmq = cs_etm__get_queue(etm, auxtrace_event->cpu);

During decoding, cs_etm allocates its own AUX queues and needs to
convert the AUX records into a cs_etm-specific format.

For example:

  event_id=405 idx=0 cpu=0 tid=6673
  event_id=406 idx=1 cpu=1 tid=6673
  event_id=407 idx=2 cpu=3 tid=6673
  event_id=408 idx=3 cpu=4 tid=6673
  event_id=409 idx=4 cpu=5 tid=6673
  `            `      `> CPU ID
   `> Event ID  `> Generic buffer IDs

In this case, I deliberately hotplugged off CPU2.  As a result, the
buffer IDs are consecutive from 0 to 4, while the CPU ID for CPU2 is
missing.  When adding AUX records to the cs_etm queues, we need to
convert from the generic buffer index to the corresponding CPU ID.

So the above change makes sense to me.

> > >   		/*
> > >   		 * If this AUX event was inside this buffer somewhere, create a new auxtrace event
> > > @@ -3095,6 +3095,7 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
> > >   		auxtrace_fragment.auxtrace = *auxtrace_event;
> > >   		auxtrace_fragment.auxtrace.size = aux_size;
> > >   		auxtrace_fragment.auxtrace.offset = aux_offset;
> > > +		auxtrace_fragment.auxtrace.idx = etmq->queue_nr;

I am still confused about this.  Because above auxtrace will be queued
on cs_etm queues, should we convert from the generic buffer index to the
cs_etm specific one?  E.g.,

  auxtrace_fragment.auxtrace.idx = auxtrace_event->cpu;

BTW, if my understanding above is valid, it is good to go through the
cs_etm.c file for the "idx <-> CPU ID" conversion.

Thanks,
Leo

> > >   		file_offset += aux_offset - auxtrace_event->offset + auxtrace_event->header.size;
> > >   		pr_debug3("CS ETM: Queue buffer size: %#"PRI_lx64" offset: %#"PRI_lx64
> > > 
> > > -- 
> > > 2.34.1
> > > 
> > > _______________________________________________
> > > CoreSight mailing list -- coresight@lists.linaro.org
> > > To unsubscribe send an email to coresight-leave@lists.linaro.org
> 
