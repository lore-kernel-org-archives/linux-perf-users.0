Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D42211A35;
	Wed, 28 May 2025 10:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748428090; cv=none; b=E7cp2gQznRCflOjs1KaqF1nswXOE9tERKkiK+CU38scbkP5kN9cKc0ozd+te2BRmZKRnqW/+K7Ts+IcTITv/xYcjEWXRSG260uhxuOjsT3q6YmhB/RkxZLOOVzPdNirjY80QJJ4HQdkgT25C1Y0RHuBB/qSPwso04rYl/Htvuzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748428090; c=relaxed/simple;
	bh=OiPr5S8H4taGYCOmTB82i6TUzOFqaMw1IUaBhFv59WM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rleGvaa4LTTtPvGvyCWdPkOGxGZeVCtLjS83FwJV+64d5tidMcHeKTYdCBwakpgzpUUSozA87eRvhiJiLedDn9sL4S7FDycmqaPVcRGIdIPjO/VjyF9YXkwHW6mO8M08/whg7bax6CGRggdB5tv8pKT8l5AL7VHvaKXIQomCg24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41ACC12FC;
	Wed, 28 May 2025 03:27:50 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 274B13F673;
	Wed, 28 May 2025 03:28:06 -0700 (PDT)
Date: Wed, 28 May 2025 11:28:01 +0100
From: Leo Yan <leo.yan@arm.com>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	irogers@google.com, mark.rutland@arm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	eranian@google.com, ctshao@google.com, tmricht@linux.ibm.com,
	Aishwarya.TCV@arm.com
Subject: Re: [PATCH V4 01/16] perf: Fix the throttle logic for a group
Message-ID: <20250528102801.GK2566836@e132581.arm.com>
References: <20250520181644.2673067-1-kan.liang@linux.intel.com>
 <20250520181644.2673067-2-kan.liang@linux.intel.com>
 <20250527161656.GJ2566836@e132581.arm.com>
 <44e1c864-a6e1-41a8-9f11-0ea25999131c@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44e1c864-a6e1-41a8-9f11-0ea25999131c@linux.intel.com>

On Tue, May 27, 2025 at 03:30:06PM -0400, Liang, Kan wrote:

[...]

> There may be two ways to fix it.
> - Add a check of MAX_INTERRUPTS in the event_stop. Return immediately if
> the stop is invoked by the throttle.
> - Introduce a PMU flag to track the case. Avoid the event_stop in
> perf_event_throttle() if the flag is detected.
> 
> The latter looks more generic. It may be used if there are other cases
> that want to avoid the stop. So the latter is implemented as below.

Yes.  I agreed the fix below is more general and confirmed it can fix
the observed issue.

> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 947ad12dfdbe..66f02f46595c 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -303,6 +303,7 @@ struct perf_event_pmu_context;
>  #define PERF_PMU_CAP_AUX_OUTPUT			0x0080
>  #define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0100
>  #define PERF_PMU_CAP_AUX_PAUSE			0x0200
> +#define PERF_PMU_CAP_NO_THROTTLE_STOP		0x0400
> 
>  /**
>   * pmu::scope
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 8327ab0ee641..596597886d96 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2655,7 +2655,8 @@ static void perf_event_unthrottle(struct
> perf_event *event, bool start)
> 
>  static void perf_event_throttle(struct perf_event *event)
>  {
> -	event->pmu->stop(event, 0);
> +	if (!(event->pmu->capabilities & PERF_PMU_CAP_NO_THROTTLE_STOP))
> +		event->pmu->stop(event, 0);

A background info is that even a PMU event is not stopped when
throttling, we still need to re-enable it.  This is why we don't do
particualy handling for PERF_PMU_CAP_NO_THROTTLE_STOP in
perf_event_unthrottle().

Maybe it is deserved add a comment for easier understanding.

Thanks,
Leo

>  	event->hw.interrupts = MAX_INTERRUPTS;
>  	perf_log_throttle(event, 0);
>  }
> @@ -11846,7 +11847,8 @@ static int cpu_clock_event_init(struct
> perf_event *event)
>  static struct pmu perf_cpu_clock = {
>  	.task_ctx_nr	= perf_sw_context,
> 
> -	.capabilities	= PERF_PMU_CAP_NO_NMI,
> +	.capabilities	= PERF_PMU_CAP_NO_NMI |
> +			  PERF_PMU_CAP_NO_THROTTLE_STOP,
>  	.dev		= PMU_NULL_DEV,
> 
>  	.event_init	= cpu_clock_event_init,
> @@ -11928,7 +11930,8 @@ static int task_clock_event_init(struct
> perf_event *event)
>  static struct pmu perf_task_clock = {
>  	.task_ctx_nr	= perf_sw_context,
> 
> -	.capabilities	= PERF_PMU_CAP_NO_NMI,
> +	.capabilities	= PERF_PMU_CAP_NO_NMI |
> +			  PERF_PMU_CAP_NO_THROTTLE_STOP,
>  	.dev		= PMU_NULL_DEV,
> 
>  	.event_init	= task_clock_event_init,
> 
> 
> Thanks,
> Kan
> 
> 
