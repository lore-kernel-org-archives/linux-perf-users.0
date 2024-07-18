Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0E31B86FB;
	Thu, 18 Jul 2024 11:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721303509; cv=none; b=QD+W3s1c3YZrnofq05gFXLj4PPWSpY86oBvQlblF97sR3CGUWOpkdU6+rMJtQECman7XxkGvaEscM6teDd8O8imZ0h6+K5cHWx0jvIQLUsZqFDBDhYFsAZC6Ey9TpQhNltBhUR0Mm0TcPxkENoeTJJYx/yyP8EpYjDIu5nRQHt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721303509; c=relaxed/simple;
	bh=iTKD9vLO0vuTlvZTMWOfzEYbAPyf4A5qsCQ1FQNjE48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q20WLZAvw+Fey08lVWAbFkLUsPPozM2HcmbMuroC22gSnpHejDtlj7ER7HsIxVXCI6gznq1BRmUiE/lzjTMzXLYkWUCBorC+1N3U05NK7xZgRnEX2GBXdqtRFzsubwCXoNzrmBKqSH3tnn3ce/t4v4A/Fol8neE7bWvTdAvxSZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BZ+vlkxB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BZ+vlkxB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+aThDcNvYH+xTn1UAd/vTyjcw0pFDf2+xHmJSo8H8Hs=; b=BZ+vlkxBfSmzU2MwFIPnfAUitm
	S417eFMyco97UvGgMwAuQ4qG0c8C42IboCcDQ4/BLFtTYEBszTz3myny6V8Vq6WlDk/h7N5GiHEo+
	viWHEDBFgw1k3u1euozXCu0J5A/DklTOKVcok1+KNsy0S4zGsoKLa8Qu9kYzSUuBvXbuJ3S2BwPlp
	MEw9RxBcKVzw+FFB86a6IVTxJqYUJR5IytWPgnlMIruKGXq7JvS+cpAtpPTX4HOzPYdcMQIXzWvGl
	c4hxv3fhO+QMF9ZB9xC/QkRvjq+EdF5AaHIcKPG6CRe4kYebxxB1S4KMNUeXZC65nqIv8Y0a7oqjM
	1Xr4ZMYA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUPfU-00000001xAi-1LRH;
	Thu, 18 Jul 2024 11:51:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DF68B3006B7; Thu, 18 Jul 2024 13:51:26 +0200 (CEST)
Date: Thu, 18 Jul 2024 13:51:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Will Deacon <will@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V9 02/13] perf/core: Add aux_pause, aux_resume,
 aux_start_paused
Message-ID: <20240718115126.GK26750@noisy.programming.kicks-ass.net>
References: <20240715160712.127117-1-adrian.hunter@intel.com>
 <20240715160712.127117-3-adrian.hunter@intel.com>
 <20240718093846.GJ26750@noisy.programming.kicks-ass.net>
 <14cd68b2-eeee-42e3-87a6-c12d3814bd51@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14cd68b2-eeee-42e3-87a6-c12d3814bd51@intel.com>

On Thu, Jul 18, 2024 at 02:19:03PM +0300, Adrian Hunter wrote:
> On 18/07/24 12:38, Peter Zijlstra wrote:
> > On Mon, Jul 15, 2024 at 07:07:01PM +0300, Adrian Hunter wrote:
> >> Hardware traces, such as instruction traces, can produce a vast amount of
> >> trace data, so being able to reduce tracing to more specific circumstances
> >> can be useful.
> >>
> >> The ability to pause or resume tracing when another event happens, can do
> >> that.
> >>
> >> Add ability for an event to "pause" or "resume" AUX area tracing.
> >>
> >> Add aux_pause bit to perf_event_attr to indicate that, if the event
> >> happens, the associated AUX area tracing should be paused. Ditto
> >> aux_resume. Do not allow aux_pause and aux_resume to be set together.
> >>
> >> Add aux_start_paused bit to perf_event_attr to indicate to an AUX area
> >> event that it should start in a "paused" state.
> >>
> >> Add aux_paused to struct hw_perf_event for AUX area events to keep track of
> >> the "paused" state. aux_paused is initialized to aux_start_paused.
> >>
> >> Add PERF_EF_PAUSE and PERF_EF_RESUME modes for ->stop() and ->start()
> >> callbacks. Call as needed, during __perf_event_output(). Add
> > 
> > Why in __perf_event_output() rather than in __perf_event_overflow().
> > Specifically, before bpf_overflow_handler().
> > 
> > That is, what do we want BPF to be able to do here? To me it seems
> > strange that BPF would be able to affect this functionality. You want
> > this pause/resume to happen irrespective of how the rest of the event is
> > processed, no?
> 
> The thought was to have the output match up with pause/resume, but it
> doesn't really make much difference.
> 
> Putting it before the BPF handler is reasonable.

OK, let me do that and make a few more edits and see if I can stare at
that next patch some.

