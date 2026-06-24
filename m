Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE913D7D69;
	Wed, 24 Jun 2026 15:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782313855; cv=none; b=rOgbP6F49mjZM/4hJDh4IakEkQS9U+EO3yZt9lH1QlMgIEZAZDy6Zf+8xDcwXZNyMa0dJxSvSMz8Gq9j9O4Hn9QtIK2f/1WGlBBU67i/aFDHq8OdN9qWhOU2XYrCENnMJf5zYI/5UR4YaLh1aARbAVWmYxgLvnF7FEi+Ax/yLZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782313855; c=relaxed/simple;
	bh=W7QTmy1F8U/KAyAIKXQu2u2a1YZFer6aOohGKyQzEp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUEBF8w6TiHo9hcdQ0FSrIKkqCaNT1eXKitSICdJA3chp159P5Lq5pTtWsrWoTk6562fhafqijzftbcjYXTzPGca6Cmw4RAuQg0WnvgGcK4gFjiTrRHgkBMTOpN+is+b/QS/cb8DdpnjT7WnkdK2v14xMMMvYDhuxkHGoJNhmzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=mJ4nSg6I; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mJ4nSg6I"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 625412308;
	Wed, 24 Jun 2026 08:10:49 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C5313F905;
	Wed, 24 Jun 2026 08:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782313854; bh=W7QTmy1F8U/KAyAIKXQu2u2a1YZFer6aOohGKyQzEp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mJ4nSg6I2d+Qe8OQyOk1OYnBxvwsdTyI+QEdpdqI0kGoPQZVEhy39vKuR8bZUVGOd
	 k2PCxTxVLOFh//6Ezvhp1cq0ZhPwDxQqpCdkwkPWfYgZ6ejAixUGAwkRpvf8S1nNLD
	 gPsgU+QoobqEeHvmmj+dfMqGo7OPbGNMxrx1YpWs=
Date: Wed, 24 Jun 2026 16:10:51 +0100
From: Leo Yan <leo.yan@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
	mike.leach@arm.com
Subject: Re: [RFC][PATCH v2] perf: Fix perf_addr_filters_afjust()
Message-ID: <20260624151051.GB575984@e132581.arm.com>
References: <20260622123245.GS48970@noisy.programming.kicks-ass.net>
 <20260623091426.GF49529@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623091426.GF49529@noisy.programming.kicks-ass.net>

On Tue, Jun 23, 2026 at 11:14:26AM +0200, Peter Zijlstra wrote:
> 
>  - adjust lock order; since perf_event_addr_filters_apply() takes mmap_lock
>    inside child_mutex.
> 
>  - note that perf_event_mmap() is called by the thread doing the
>    mmap()/mprotect()/.. operation, but not the other threads in the address
>    space that might have inherited the same event.
> 
>  - have perf_addr_filters_adjust() iterate the child_list to find all other
>    events for tasks that have the same mm.
> 
>  - since this can now adjust addr_filter_ranges[] for remote events, make sure
>    to adjust things while holding ctx->lock; local_irq_disable() as implied by
>    the ifh->lock is no longer suffient to serialize against event scheduling.
> 
>  - per the previous locking order; perf_event_mmap(), which is called holding
>    mmap_lock, cannot take child_mutex, as such, make child_list RCU protected
>    and iterate under RCU.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Just verified this patch with Arm CoreSight:

  perf record -e cs_etm//u --filter 'filter traced_region @/root/test' -- /root/test

The workload forks a child process to inherited the event, also used
trace_printk() to confirm perf_event_addr_filters_adjust() has been hit.
No warning reported by LOCKDEP.

Tested-by: Leo Yan <leo.yan@arm.com>

If you want me to try any specific test, pleaset let me know and I am
glad to give a run.

Maybe it is good to fix typo in the subject: s/afjust()/adjust()/.
