Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802256;
	b=ALs6TT6D3BSFEkLOCXD4lbZMQK1kaztbHrVt2E6nNQsM5FJbu5/fzBV7VIrBy2+yOSU1
	 g9/IvPneA5l+yzlvIPZS8EV8snAoxTaHho+FxVN0taifBDBdYeppYAvziCxNWmjzP3Kub
	 T/VQ0jE89Fx8qK7JfjuwItqITP7F5JOTJ6Xue9cT0VIAeYwWCcA7bxHCufX1sgiHe2FfS
	 B+ODNmmh9Cow+K2ZXbZvKwOB6kvtpOCgU2ad/KPlFu7cfX/f6YHOXFjeuKRmeqIZfd3Ce
	 TblhO/EShuvH+BtwnnZA0XPsdjebQCtAbOGH34Wp8PgSB4UeFy1r8OMvpxHuXjIgUfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802256;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=LT4QhNCuGhtvYaGuZ1YT+0MRJJqhUJ12cQ6XYhOTJgY=;
	b=mHABGTdJ0gsBtS5u3Sm4qPvSOP0Kv9ZkDc/L1pY4yF8Qow0tFhTmfIpa++qMIIMQTtT0
	 pde3abpV5pzbZocuBmHhyS6rDFXGUQ6GaErE8KYjx3VJL8zHF0AqykoRfUc711cggO/+h
	 iFYF627/kbZw4NeTjmtAz34iKBFFCMc6/BIagBfgHFvcy3yk+hPkW6ZshG8AW9wosQ5GK
	 DqY57Wx1NjdJMrsNW3RQjWWp5KUTycojQ0eU/g8tJbNBTUBO43DtTwHSENqwZqxmkEQcK
	 NegCnyVqodzEtCBt/0ts+nm8VhzoDXvNI6O1RTmL+vrxE9eNGInjQQLFnmm1n8NTq7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ejUyoupl;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141D4606A31B;
	Wed,  4 Nov 2026 14:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 141D4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ejUyoupl
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36AF81D34;
	Wed,  4 Nov 2026 06:24:12 -0800 (PST)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DAD8A3F673;
	Wed,  4 Nov 2026 06:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793802255; bh=p/DbzJh9fxRbnRCpJa3VaWBb0VSwvoJXFXtDwP7M4UM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ejUyouplR6xIahybJGnDj5M0O72FEHZUsM4v7yfuiYbScyq64hyzW8kFrpxd5j3vu
	 pdyVMZvfh3SZPkOBo7jMB7qqAXuV9Zf7Z0zhGTI2WMSDrSCL9ZIUSxfLYOCY7oMGPC
	 4QacAJ6NY8RdcO9bbXighOJU3kREXelzU/b11eI4=
Date: Wed, 4 Nov 2026 14:24:12 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Leo Yan <leo.yan@linux.dev>, Adrian Hunter <adrian.hunter@intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>,
	linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-doc@vger.kernel.org, John Garry <john.garry@linux.dev>
Subject: Re: [PATCH v3 04/18] perf cs-etm: Use per-CPU queues for per-thread
 mode
Message-ID: <20261104142412.GI9176@e132581.arm.com>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
 <20261102-james-cs-unformatted-per-thread-fix-v3-4-dbcb0c281b9b@linaro.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-4-dbcb0c281b9b@linaro.org>

On Mon, Nov 02, 2026 at 12:15:18PM +0000, James Clark wrote:

[...]

> @@ -2215,6 +2209,29 @@ static int cs_etm__get_data_block(struct cs_etm_queue *etmq)
>  	 */
>  	cs_etm__flush_all_stack(etmq);
>  
> +	/*
> +	 * Per-thread mode still uses a queue for each CPU, but that CPU can run
> +	 * different threads. When the TID from the AUX record on a CPU changes,
> +	 * re-initialize the thread using the AUX record/buffer fragment TID so
> +	 * we can start decoding even if the context ID packet was cropped or
> +	 * they're disabled.
> +	 */
> +	if (etm->per_thread_decoding) {
> +		struct cs_etm_traceid_queue *tidq = cs_etm__etmq_get_traceid_queue(etmq,
> +							CS_ETM_PER_THREAD_TRACEID);
> +
> +		if (thread__tid(tidq->decode_thread) != etmq->buffer->tid) {
> +			thread__zput(tidq->frontend_thread);
> +			thread__zput(tidq->decode_thread);
> +			tidq->frontend_thread = machine__findnew_thread(
> +				&etm->session->machines.host, -1,
> +				etmq->buffer->tid);
> +			tidq->decode_thread = machine__findnew_thread(
> +				&etm->session->machines.host, -1,
> +				etmq->buffer->tid);
> +		}
> +	}

Why not use PERF_RECORD_AUX events as an opportunity to update threads,
similar to how we handle PERF_RECORD_SWITCH_CPU_WIDE?

> +
>  	return 1;
>  }
>  
> @@ -3288,7 +3305,9 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
>  
>  	if (aux_offset >= auxtrace_event->offset &&
>  	    aux_offset + aux_size <= auxtrace_event->offset + auxtrace_event->size) {
> -		struct cs_etm_queue *etmq = cs_etm__get_queue(etm, auxtrace_event->cpu);
> +		/* Old per-thread files have no CPU (before v6.4) */
> +		int queue_idx = sample->cpu == (u32)-1 ? 0 : sample->cpu;
> +		struct cs_etm_queue *etmq = cs_etm__get_queue(etm, queue_idx);

For per-thread mode, auxtrace_event->cpu is -1. So this is why we
resort sample->cpu to retrieve CPU ID. This makes sense to me.
