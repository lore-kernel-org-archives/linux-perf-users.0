Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311E3219E4;
	Mon,  1 Jul 2024 10:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719830845; cv=none; b=X5OCetK/J4jGhUe/9cAuJ1lrdBgJO2QtjDbwAoW69H0E4jk+I/p9gEhdAn2eDHngck/Lya08sti4sB8mQm0LUw8N+Dp/brjlD73bMOLm9/dofxiVKBCjxnG5uoF1/IEmKo2dmCi6TCHxm6V88S8waTUqzP28j/Q05CabwiIsoWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719830845; c=relaxed/simple;
	bh=uLreaSzsfWWKqMGJYJV4gCqtwlpLEPOuQHljyyG/gWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlEZVn8FD4sZCr3a+vnnE7v059Z3RRRMoJgvZ5dlCW6Aep9BTCCA9zhDzqMy1x4ItiIvXZReOcZ1Mj8zwAZcqQNm/JM/WWrxAVincTANTbp/lRu/qpD8vynDv+XiCiSvbuUTRFaBcoBxM5BgxosCb7+Ilc6t/1JHe+C77aUUtFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MB1chLtH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MB1chLtH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=60Kumii6pmJtpzJ+hSjU333nWVuyFzmImepY1GewN4I=; b=MB1chLtHl35qWH3NyFhR54TBfj
	u6dNEVDvApmasLPc85NmkPL8B31J4jDxszPVqhtklBBRd/CFxZ9NWUq7JJAN4KnG9y/MJ8yBDeNV9
	o6BuhQ7P1RLvO737e6iW+qpFqZTcXH72h+JOGZ4I8edAv4qaGmRMym96fq8I/0FT0FNkoTSaw129w
	TosSWsjqunBMJlD+2Ac8syu2+o0HzT9nueD+eeFbyYMky8gBCiGKHvOYcSV6SNi2/y4RJXf5cAM+3
	/+VPlQtTXfQnbis5JbhmPHGJOA6zqANrdLYc3fggiEe1+4TJy4s1vusBrgc+V1QFCtb0vBEZMlASl
	atu637nA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOEYo-0000000HFKK-15U7;
	Mon, 01 Jul 2024 10:47:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 576BB300694; Mon,  1 Jul 2024 12:46:59 +0200 (CEST)
Date: Mon, 1 Jul 2024 12:46:59 +0200
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
Subject: Re: [PATCH V8 02/12] perf/x86/intel/pt: Add support for pause /
 resume
Message-ID: <20240701104659.GB20127@noisy.programming.kicks-ass.net>
References: <20240628065111.59718-1-adrian.hunter@intel.com>
 <20240628065111.59718-3-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628065111.59718-3-adrian.hunter@intel.com>

On Fri, Jun 28, 2024 at 09:51:01AM +0300, Adrian Hunter wrote:

> @@ -534,7 +537,20 @@ static void pt_config(struct perf_event *event)
>  	reg |= (event->attr.config & PT_CONFIG_MASK);
>  
>  	event->hw.config = reg;
> +
> +	/*
> +	 * Allow resume before starting so as not to overwrite a value set by a
> +	 * PMI.
> +	 */
> +	WRITE_ONCE(pt->resume_allowed, 1);
	barrier();
>  	pt_config_start(event);
	barrier();
> +	/*
> +	 * Allow pause after starting so its pt_config_stop() doesn't race with
> +	 * pt_config_start().
> +	 */
> +	WRITE_ONCE(pt->pause_allowed, 1);

IIRC you need those barrier()s, because if the compiler 'helpfully'
inlines the static pt_config_start(), you loose your sequence point and
things can get re-ordered. WRITE_ONCE() only ensures the store is whole
and ordered against other volatile ops, but not against much else.

>  }
>  
>  static void pt_config_stop(struct perf_event *event)
> @@ -1511,6 +1527,7 @@ void intel_pt_interrupt(void)
>  		buf = perf_aux_output_begin(&pt->handle, event);
>  		if (!buf) {
>  			event->hw.state = PERF_HES_STOPPED;
> +			pt->resume_allowed = 0;
>  			return;
>  		}
>  
> @@ -1519,6 +1536,7 @@ void intel_pt_interrupt(void)
>  		ret = pt_buffer_reset_markers(buf, &pt->handle);
>  		if (ret) {
>  			perf_aux_output_end(&pt->handle, 0);
> +			pt->resume_allowed = 0;
>  			return;
>  		}
>  

Above you WRITE_ONCE() on ->resume_allowed, here you do not. Some *SAN
thing or other is bound to get upset about things like that.

> @@ -1573,6 +1591,26 @@ static void pt_event_start(struct perf_event *event, int mode)
>  	struct pt *pt = this_cpu_ptr(&pt_ctx);
>  	struct pt_buffer *buf;
>  
> +	if (mode & PERF_EF_RESUME) {
> +		if (READ_ONCE(pt->resume_allowed)) {

At this point I seem to have lost the plot, how do ->resume_allowed and
->aux_paused interact?

> +			u64 status;
> +
> +			/*
> +			 * Only if the trace is not active and the error and
> +			 * stopped bits are clear, is it safe to start, but a
> +			 * PMI might have just cleared these, so resume_allowed
> +			 * must be checked again also.
> +			 */
> +			rdmsrl(MSR_IA32_RTIT_STATUS, status);
> +			if (!(status & (RTIT_STATUS_TRIGGEREN |
> +					RTIT_STATUS_ERROR |
> +					RTIT_STATUS_STOPPED)) &&
> +			   READ_ONCE(pt->resume_allowed))
> +				pt_config_start(event);
> +		}
> +		return;
> +	}
> +
>  	buf = perf_aux_output_begin(&pt->handle, event);
>  	if (!buf)
>  		goto fail_stop;
> @@ -1601,6 +1639,16 @@ static void pt_event_stop(struct perf_event *event, int mode)
>  {
>  	struct pt *pt = this_cpu_ptr(&pt_ctx);
>  
> +	if (mode & PERF_EF_PAUSE) {
> +		if (READ_ONCE(pt->pause_allowed))
> +			pt_config_stop(event);
> +		return;
> +	}
> +
> +	/* Protect against racing */

No F1 cars allowed? Sure the comment can elucidate the reader as to what
actual race one is concerned about, no?

> +	WRITE_ONCE(pt->pause_allowed, 0);
> +	WRITE_ONCE(pt->resume_allowed, 0);
> +
>  	/*
>  	 * Protect against the PMI racing with disabling wrmsr,
>  	 * see comment in intel_pt_interrupt().
> @@ -1659,8 +1707,12 @@ static long pt_event_snapshot_aux(struct perf_event *event,
>  	/*
>  	 * Here, handle_nmi tells us if the tracing is on
>  	 */
> -	if (READ_ONCE(pt->handle_nmi))
> +	if (READ_ONCE(pt->handle_nmi)) {
> +		/* Protect against racing */
> +		WRITE_ONCE(pt->pause_allowed, 0);
> +		WRITE_ONCE(pt->resume_allowed, 0);

barrier()?

>  		pt_config_stop(event);
> +	}
>  
>  	pt_read_offset(buf);
>  	pt_update_head(pt);
> @@ -1677,8 +1729,11 @@ static long pt_event_snapshot_aux(struct perf_event *event,
>  	 * Compiler barrier not needed as we couldn't have been
>  	 * preempted by anything that touches pt->handle_nmi.
>  	 */
> -	if (pt->handle_nmi)
> +	if (pt->handle_nmi) {
> +		WRITE_ONCE(pt->resume_allowed, 1);
>  		pt_config_start(event);
> +		WRITE_ONCE(pt->pause_allowed, 1);

barrier() went missing again?

> +	}
>  
>  	return ret;
>  }
