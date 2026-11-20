Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176886;
	b=MA+GyVshtPFwQwStnoTscDUQacVBwACSW92qp6ipoAlOdEGcGbIAx3r9P6WTmLfRrpK+
	 CNH1cKFSZbBHoHFymHtRL7ZhrV6WNT9dq41Ab4LrQi3OmrY0lxKdlxUARU8Q590/HJNBg
	 0LCrO+6AODAnnvxGv84O8YPegS4EeVap7Prqxy+zzA7xa/aeR5y7XIRsHUWE3Ls2Qashy
	 ki/djZOKocxgJ+MljAYpJ3LmNcDx8IrY2oaCZxS0loMe4fZixtq8ZyX81hO9gw68ovYDs
	 xp9M+9MQYc0qDH/0nm33a0aSEgJM+l6p7RdkCva16CtIPS5GxvL8JH8QBX6jbg4tXCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176886;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=ks69R9NPZfJ4GC/YK4A/goNrzJgpxmPlFkxdUltPR50=;
	b=RdweMeRQx5kfrfRQTIvbGFLq8XEMFvZdFphLcBmWx9UzdmP9D0ZV7tOfeNxUoafbunPM
	 uQhHOPeehU70AhABnPu1PrgJ80X0Ru35R9nua8O6koTOOuWbRXPa/KIGHlgMFHlT86pul
	 K1u8F3cgLg8ky91h1r2T0+RSWK6KLDuyb1Nfp9SAeQ7FUQWTGWHhroDgr3GcJ2m1AfGqI
	 Qsm6XWVnoaWFt7O+8kLbZHxIjqEl76R7ZH6NB1Poo+wlD3fkyngQ56h5IcjRvpAyMm0aE
	 pJm1XTyrafro1t6nAFQevizRl3tq6wWvFA9M+DPZjleSyCKY2+KcRiZDTCbTqwnbPvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b="LG4/zxRq";
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F2A606A33E;
	Fri, 20 Nov 2026 12:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32F2A606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=LG4/zxRq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ks69R9NPZfJ4GC/YK4A/goNrzJgpxmPlFkxdUltPR50=; b=LG4/zxRql26TO0jcV2kfpawi3e
	qtsAW5G8w8A8JevFOo0siJFdOlmvQEO5sf/hlMkbve1bLeEFG2eR108UotgdW8zj60yvoYmt0iuCW
	XcfhYYaxAbwgEf6n6CspTRRn217eZEDw1T5wvCZM+rbwe4IdvRag9VP/kL6LNZbZ+JVVledlBF6d9
	dqtODRV46QoK/5PbQZCnxVv3w7Ki+yAECBr7BgoCV3rZkVoZSZPfyk0Wu7Q1DgZ1wg09m5CwYQS2g
	XXpIkr+fPpbO/WYBP0MT3+z1a5dRYdK+bfx5G/6maCEdncR1+0ty+hzCAoBi0ecxlxsAqf68o0EHW
	bqB10JCA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUNVl-00000000kCY-2zbE;
	Fri, 20 Nov 2026 12:14:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 91BE33008D6; Fri, 20 Nov 2026 13:14:36 +0100 (CET)
Date: Fri, 20 Nov 2026 13:14:36 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] perf/core: Prevent duplicate sigtrap task work
 enqueue
Message-ID: <20261120121436.GT2668564@noisy.programming.kicks-ass.net>
References: <cover.1795053619.git.wutengda@huaweicloud.com>
 <45bd71c976aea1a0e8bf5762dd6b6552e6009439.1795053619.git.wutengda@huaweicloud.com>
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
In-Reply-To: <45bd71c976aea1a0e8bf5762dd6b6552e6009439.1795053619.git.wutengda@huaweicloud.com>

On Thu, Nov 19, 2026 at 09:51:00AM +0000, Tengda Wu wrote:
> The sigtrap handling in __perf_event_overflow() checks
> event->pending_work before calling task_work_add(), but only sets
> pending_work after the task work has been queued.
> 
> This leaves a window where an NMI can interrupt task_work_add()
> and re-enter __perf_event_overflow() for the same event. Since
> pending_work is still zero, the nested invocation can enqueue
> the same pending_task again.
> 
> The re-entrant call path looks like this:
> 
>   __perf_event_overflow()
>     task_work_add()
>       kasan_record_aux_stack()
>         <NMI>
>           __perf_event_overflow()
>             task_work_add()
> 
> The nested invocation may enqueue pending_task before the
> outer invocation does. When the outer invocation resumes, it
> inserts the same task work entry again, potentially creating
> a cycle in the task work list.
> 
> As a result, perf_pending_task() may be executed repeatedly,
> leading to unbalanced event reference counting.
> 
> Fix this by atomically claiming pending_work with
> cmpxchg_acquire() before calling task_work_add(). This ensures
> that only one invocation can enqueue the task work, even when
> another overflow occurs re-entrantly from an NMI.
> 
> If task_work_add() fails, clear the claim with
> smp_store_release() to allow a subsequent overflow to retry.
> 
> In perf_pending_task(), defer clearing pending_work until
> after perf_sigtrap() has completed. Use smp_store_release()
> to ensure that a subsequent overflow cannot re-queue the task
> work before the previous invocation has finished handling it.
> 
> Also use smp_load_acquire() when checking pending_work in
> the exclude_kernel warning path to ensure the read is properly
> ordered.

I am confused by the use of smp_*() and cmpxchg() here. Where is the
multi-cpu scenario?

