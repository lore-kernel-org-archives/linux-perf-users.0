Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B39716D4DD;
	Tue,  6 Aug 2024 21:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722978899; cv=none; b=l87XHhoXMtkpwTu+H89zCbg25wfkBj50IMoy884lj3LfJ0XbgZpDasLp3gd/i511MS6j0Y+BuvajVMkfBxQyoteRShL2q6TzZgYiDom9pterDDKUQ++ajdl40voPa/OQuBWo2YgT84RWVS6EU/HzCwuqMJbNW1b2ktl1wvsOOdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722978899; c=relaxed/simple;
	bh=av28jhqRgEVBboylZgZMt5CbsMUmoJbFETR3uIhJNXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnEizxnm2R6kwOlEUcp6fYv/VhrVffat7F99kbCnryt3WaCG0TnBbgL9iPJBAzsET2R4WB/by5+eUoop6TsWpLNMY5XItZu7z+4yE480TQOoEJ6gTUT/AtATZSQyD+IrhtbLLqKZC2+1ypLTXhbBhaFz+8Rzh49mngFQasukPjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JVe5DEXt; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JVe5DEXt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zTN4JJ8RyBIwnN8QtZbKL34OISG6SJBGEivuQ36ISDw=; b=JVe5DEXt+B3CoB1BfQY2a9f0al
	H2XlLTU87UK6OTBYJGNb1KRjbGmHk3mrHNj4IeMkoyvZKtIsy8xGR6BiX8jnTXDUUgYiHij9usY1y
	/5V7ZPWhIb/Ll6pfHUoY0OCe0AixNvRModgP/WlTs9aTpQ2WlwqQQnJA3psZO8+PqHokvxqqDqfoa
	YdsnN2G/GLstZ6cCrNH8XA6O+TvwWyEGNCEigQU/J8w6lQHfrPtds8z87irWwUjXvXVgkLKVwC58h
	6E7I16G0EoZxWoUg30LsLyvALlYKdVNDrbTOgwb1fSx7p1nKX3+GdNWoV3P0TXwVLGLJT0tdGSrbh
	UIc4ZhWQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbRVw-00000006Wg5-3AC2;
	Tue, 06 Aug 2024 21:14:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F39AB30066A; Tue,  6 Aug 2024 23:14:39 +0200 (CEST)
Date: Tue, 6 Aug 2024 23:14:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] perf/core: Allow multiple AUX PMU events with the
 same module
Message-ID: <20240806211439.GB37996@noisy.programming.kicks-ass.net>
References: <20240806204813.722372-1-leo.yan@arm.com>
 <20240806204813.722372-2-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806204813.722372-2-leo.yan@arm.com>

On Tue, Aug 06, 2024 at 09:48:09PM +0100, Leo Yan wrote:
> This commit changes the condition from checking the same PMU instance to
> checking the same PMU driver module. This allows support for multiple
> PMU events with the same driver module.
> 
> As a result, more than one AUX event (e.g. arm_spe_0 and arm_spe_1) can
> record trace into the AUX ring buffer.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  kernel/events/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index aa3450bdc227..fdb8918e62a0 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -12344,9 +12344,10 @@ perf_event_set_output(struct perf_event *event, struct perf_event *output_event)
>  
>  	/*
>  	 * If both events generate aux data, they must be on the same PMU
> +	 * module but can be with different PMU instances.
>  	 */
>  	if (has_aux(event) && has_aux(output_event) &&
> -	    event->pmu != output_event->pmu)
> +	    event->pmu->module != output_event->pmu->module)

A very quick look at: arch/x86/events/intel/pt.c seems to suggest that
doesn't set pmu->module. Which seems to suggest the above won't work for
us.
