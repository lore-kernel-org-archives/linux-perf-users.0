Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851E928D8DB;
	Wed, 28 May 2025 16:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748449050; cv=none; b=oVfZGBA8oNxIeN0Uay20T5SvhkVniFdt7qH24MJx2SBuTB5sCVGK6omkaOi08VvCB1x29dm8ud8NpbyTn1LOvcMaRk3Jnneu+SIwcdlAgSysaojCa7AQl/OQ9WW972r8XqcwGMDWOtgMWYLxEytLD5jUXr/Ny+YsINxijVMjeME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748449050; c=relaxed/simple;
	bh=UhXhHXqGnsFxg+kHq1kEOUu4fzlnoiBRxONX9YRLNjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PP2/WPIDvGmrDHa/Tymmd0KC8uyS4uMYfDueEApYwBXvc+ugIpBK/Nw0VDD5SbIhofoJa/UrC4zcxgI+WW8UFBUXj/PpIDKWVB3cWDBQvp0Uuh5uc0VdzzMa2fIrADeNzNts9mObmU19Ly2cT2Bp41V2qoGPl+fp7TVIO2JtCCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2732D1A2D;
	Wed, 28 May 2025 09:17:11 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C3353F673;
	Wed, 28 May 2025 09:17:27 -0700 (PDT)
Date: Wed, 28 May 2025 17:17:22 +0100
From: Leo Yan <leo.yan@arm.com>
To: kan.liang@linux.intel.com
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	irogers@google.com, mark.rutland@arm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	eranian@google.com, ctshao@google.com, tmricht@linux.ibm.com,
	Aishwarya TCV <aishwarya.tcv@arm.com>
Subject: Re: [PATCH] perf: Fix the throttle error of some clock events
Message-ID: <20250528161722.GL2566836@e132581.arm.com>
References: <20250528144823.2996185-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528144823.2996185-1-kan.liang@linux.intel.com>

On Wed, May 28, 2025 at 07:48:23AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The Arm CI reports RCU stall, which can be reproduced by the below perf
> command.
>   perf record -a -e cpu-clock -- sleep 2
> 
> The cpu-clock and task_clock are two special SW events, which rely on
> the hrtimer. Instead of invoking the stop(), the HRTIMER_NORESTART is
> returned to stop the timer. Because the hrtimer interrupt handler cannot
> cancel itself, which causes infinite loop.
> 
> There may be two ways to fix it.
> - Add a check of MAX_INTERRUPTS in the event_stop. Return immediately if
> the stop is invoked by the throttle.
> - Introduce a PMU flag to track the case. Avoid the event_stop in
> perf_event_throttle() if the flag is detected.
> 
> The latter looks more generic. It may be used if there are more other
> cases that want to avoid the stop later. The latter is implemented.
> 
> Reported-by: Leo Yan <leo.yan@arm.com>
> Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>

Thanks for adding me and my colleague's name!

> Closes: https://lore.kernel.org/lkml/20250527161656.GJ2566836@e132581.arm.com/
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  include/linux/perf_event.h |  1 +
>  kernel/events/core.c       | 23 ++++++++++++++++++++---
>  2 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 947ad12dfdbe..66f02f46595c 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -303,6 +303,7 @@ struct perf_event_pmu_context;
>  #define PERF_PMU_CAP_AUX_OUTPUT			0x0080
>  #define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0100
>  #define PERF_PMU_CAP_AUX_PAUSE			0x0200
> +#define PERF_PMU_CAP_NO_THROTTLE_STOP		0x0400

When applying the patch on the top of tip/sched/core, I found it is
conflict with a new added PERF_PMU_CAP_AUX_PREFER_LARGE.  So need to
change the PERF_PMU_CAP_NO_THROTTLE_STOP to 0x0800.

With the change, I tested on Arm64 board with two commands:

  perf record -a -e cpu-clock -- sleep 2
  perf test "perftool-testsuite_report"

Tested-by: Leo Yan <leo.yan@arm.com>

Thanks for quick fixing.

>  /**
>   * pmu::scope
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 8327ab0ee641..4df274705038 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2655,7 +2655,22 @@ static void perf_event_unthrottle(struct perf_event *event, bool start)
>  
>  static void perf_event_throttle(struct perf_event *event)
>  {
> -	event->pmu->stop(event, 0);
> +	/*
> +	 * Some PMUs, e.g., cpu-clock and task_clock, may rely on
> +	 * a special mechanism (hrtimer) to manipulate counters.
> +	 * The regular stop doesn't work, since the hrtimer interrupt
> +	 * handler cannot cancel itself.
> +	 *
> +	 * The stop should be avoided for such cases. Let the
> +	 * driver-specific code handle it.
> +	 *
> +	 * The counters will eventually be disabled in the driver-specific
> +	 * code. In unthrottle, they still need to be re-enabled.
> +	 * There is no handling for PERF_PMU_CAP_NO_THROTTLE_STOP in
> +	 * the perf_event_unthrottle().
> +	 */
> +	if (!(event->pmu->capabilities & PERF_PMU_CAP_NO_THROTTLE_STOP))
> +		event->pmu->stop(event, 0);
>  	event->hw.interrupts = MAX_INTERRUPTS;
>  	perf_log_throttle(event, 0);
>  }
> @@ -11846,7 +11861,8 @@ static int cpu_clock_event_init(struct perf_event *event)
>  static struct pmu perf_cpu_clock = {
>  	.task_ctx_nr	= perf_sw_context,
>  
> -	.capabilities	= PERF_PMU_CAP_NO_NMI,
> +	.capabilities	= PERF_PMU_CAP_NO_NMI |
> +			  PERF_PMU_CAP_NO_THROTTLE_STOP,
>  	.dev		= PMU_NULL_DEV,
>  
>  	.event_init	= cpu_clock_event_init,
> @@ -11928,7 +11944,8 @@ static int task_clock_event_init(struct perf_event *event)
>  static struct pmu perf_task_clock = {
>  	.task_ctx_nr	= perf_sw_context,
>  
> -	.capabilities	= PERF_PMU_CAP_NO_NMI,
> +	.capabilities	= PERF_PMU_CAP_NO_NMI |
> +			  PERF_PMU_CAP_NO_THROTTLE_STOP,
>  	.dev		= PMU_NULL_DEV,
>  
>  	.event_init	= task_clock_event_init,
> -- 
> 2.38.1
> 
