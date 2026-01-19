Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D5826FA57;
	Mon, 19 Jan 2026 11:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768821314; cv=none; b=oaS+e6aRZdb/wGVYGevjhFoynvZUDRdGQTXiTRFaCLyEYHzDNt4fIZGpt9X3v2o9W0NWJEI0Y+afYwhcKBdpI6KzI6U6Tyc0kVzctKj0XEJQkxZPaZ0VWMVFWPK0zsnegLxjkHI7eXrM9lCa+IPXKajiNxr9v3qN0WIMt/fS5fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768821314; c=relaxed/simple;
	bh=fDuvdnvPuHmKyUXuBWa9lTk6I3l6aEASPq+0vYopeeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgJDgtyFHLmOaSy05esQmnzmvxNnggebMVtNXfrlEDXu2nPsYPZwzruccDx3nN5nx9xjI4VhbYLTl8qdJbprj2sfLFecQwY58LYNqTo+KZAC/Fco9q6JWvIqON1Y/dkf/l1K/gfNN68M4bvG+YWNCUDWMNH4mvgqux/6SYPHFLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74FFB1517;
	Mon, 19 Jan 2026 03:15:05 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A11043F740;
	Mon, 19 Jan 2026 03:15:11 -0800 (PST)
Date: Mon, 19 Jan 2026 11:15:09 +0000
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
Message-ID: <20260119111509.GD1286628@e132581.arm.com>
References: <20260119-james-perf-coresight-cpu-map-segfault-v2-0-56b956a629ee@linaro.org>
 <20260119-james-perf-coresight-cpu-map-segfault-v2-1-56b956a629ee@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119-james-perf-coresight-cpu-map-segfault-v2-1-56b956a629ee@linaro.org>

On Mon, Jan 19, 2026 at 10:18:35AM +0000, Coresight ML wrote:
> The ETM decoder incorrectly assumed that auxtrace queue indices were
> equivalent to CPU number. This assumption is used for inserting records
> into the queue, and for fetching queues when given a CPU number. This
> assumption held when Perf always opened a dummy event on every CPU, even
> if the user provided a subset of CPUs on the commandline, resulting in
> the indices aligning.
> 
> For example:
> 
>   # event : name = cs_etm//u, , id = { 2451, 2452 }, type = 11 (cs_etm), size = 136, config = 0x4010, { sample_period, samp>
>   # event : name = dummy:u, , id = { 2453, 2454, 2455, 2456 }, type = 1 (PERF_TYPE_SOFTWARE), size = 136, config = 0x9 (PER>
> 
>   0 0 0x200 [0xd0]: PERF_RECORD_ID_INDEX nr: 6
>   ... id: 2451  idx: 2  cpu: 2  tid: -1
>   ... id: 2452  idx: 3  cpu: 3  tid: -1
>   ... id: 2453  idx: 0  cpu: 0  tid: -1
>   ... id: 2454  idx: 1  cpu: 1  tid: -1
>   ... id: 2455  idx: 2  cpu: 2  tid: -1
>   ... id: 2456  idx: 3  cpu: 3  tid: -1
> 
> Since commit 811082e4b668 ("perf parse-events: Support user CPUs mixed
> with threads/processes") the dummy event no longer behaves in this way,
> making the ETM event indices start from 0 on the first CPU recorded
> regardless of its ID:
> 
>   # event : name = cs_etm//u, , id = { 771, 772 }, type = 11 (cs_etm), size = 144, config = 0x4010, { sample_period, sample>
>   # event : name = dummy:u, , id = { 773, 774 }, type = 1 (PERF_TYPE_SOFTWARE), size = 144, config = 0x9 (PERF_COUNT_SW_DUM>
> 
>   0 0 0x200 [0x90]: PERF_RECORD_ID_INDEX nr: 4
>   ... id: 771  idx: 0  cpu: 2  tid: -1
>   ... id: 772  idx: 1  cpu: 3  tid: -1
>   ... id: 773  idx: 0  cpu: 2  tid: -1
>   ... id: 774  idx: 1  cpu: 3  tid: -1

Seems to me that this patch works around the issue by using the CPU ID
instead, but event->auxtrace.idx is broken.

Should we store the correct index in event->auxtrace.idx (e.g., in the
__perf_event__synthesize_id_index()) ?

Thanks,
Leo

> This causes the following segfault when decoding:
> 
>   $ perf record -e cs_etm//u -C 2,3 -- true
>   $ perf report
> 
>   perf: Segmentation fault
>   -------- backtrace --------
>   #0 0xaaaabf9fd020 in ui__signal_backtrace setup.c:110
>   #1 0xffffab5c7930 in __kernel_rt_sigreturn [vdso][930]
>   #2 0xaaaabfb68d30 in cs_etm_decoder__reset cs-etm-decoder.c:85
>   #3 0xaaaabfb65930 in cs_etm__get_data_block cs-etm.c:2032
>   #4 0xaaaabfb666fc in cs_etm__run_per_cpu_timeless_decoder cs-etm.c:2551
>   #5 0xaaaabfb6692c in (cs_etm__process_timeless_queues cs-etm.c:2612
>   #6 0xaaaabfb63390 in cs_etm__flush_events cs-etm.c:921
>   #7 0xaaaabfb324c0 in auxtrace__flush_events auxtrace.c:2915
>   #8 0xaaaabfaac378 in __perf_session__process_events session.c:2285
>   #9 0xaaaabfaacc9c in perf_session__process_events session.c:2442
>   #10 0xaaaabf8d3d90 in __cmd_report builtin-report.c:1085
>   #11 0xaaaabf8d6944 in cmd_report builtin-report.c:1866
>   #12 0xaaaabf95ebfc in run_builtin perf.c:351
>   #13 0xaaaabf95eeb0 in handle_internal_command perf.c:404
>   #14 0xaaaabf95f068 in run_argv perf.c:451
>   #15 0xaaaabf95f390 in main perf.c:558
>   #16 0xffffaab97400 in __libc_start_call_main libc_start_call_main.h:74
>   #17 0xffffaab974d8 in __libc_start_main@@GLIBC_2.34 libc-start.c:128
>   #18 0xaaaabf8aa8f0 in _start perf[7a8f0]
> 
> Fix it by inserting into the queues based on CPU number, rather than
> using the index.
> 
> Fixes: 811082e4b668 ("perf parse-events: Support user CPUs mixed with threads/processes")
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 25d56e0f1c07..12b55c2bc2ca 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -3086,7 +3086,7 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
>  
>  	if (aux_offset >= auxtrace_event->offset &&
>  	    aux_offset + aux_size <= auxtrace_event->offset + auxtrace_event->size) {
> -		struct cs_etm_queue *etmq = etm->queues.queue_array[auxtrace_event->idx].priv;
> +		struct cs_etm_queue *etmq = cs_etm__get_queue(etm, auxtrace_event->cpu);
>  
>  		/*
>  		 * If this AUX event was inside this buffer somewhere, create a new auxtrace event
> @@ -3095,6 +3095,7 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
>  		auxtrace_fragment.auxtrace = *auxtrace_event;
>  		auxtrace_fragment.auxtrace.size = aux_size;
>  		auxtrace_fragment.auxtrace.offset = aux_offset;
> +		auxtrace_fragment.auxtrace.idx = etmq->queue_nr;
>  		file_offset += aux_offset - auxtrace_event->offset + auxtrace_event->header.size;
>  
>  		pr_debug3("CS ETM: Queue buffer size: %#"PRI_lx64" offset: %#"PRI_lx64
> 
> -- 
> 2.34.1
> 
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org
> To unsubscribe send an email to coresight-leave@lists.linaro.org
