Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA873288509;
	Tue, 27 May 2025 19:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748374211; cv=none; b=i1ULprJ4NGvTdogMWfGQGZoOmjl6eTJDeF1Dm/QbgDzAPLwcX62UaoTVQfS36hvtgp8is7BqKKNHLbWdKHbgmkwETofQqbxfx+D5L4fSTtQ7lUwEuMB46soNr2AtzSKT+bszLrd+4Zc9qFlwdJ+rkolHA6prm+YJ1ZS6Et1Dr54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748374211; c=relaxed/simple;
	bh=Vdfstct6hVRyw6WWOWyiBNMF1lwa3qrocEjN3fPYDhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JL/rlMg68RvxfWliwveIrGMVPiTJidOEUxTBfRNIHn+YhljTYBdpP6ZVduqzcW9HPPaPcCctSEqawTngnR/PMhs7BX+7I5QNXwQw4Z9OwKCtc5z8Cgw4gE/4PLhkxNk+gx0ddqLqPvusgZcUOoAyzMEThhP4OdV4LaLQx+r7o0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EdZ5T188; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EdZ5T188"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748374210; x=1779910210;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Vdfstct6hVRyw6WWOWyiBNMF1lwa3qrocEjN3fPYDhc=;
  b=EdZ5T188TwDVDCMvBTz93/Xcn1V5nZr363yEhG1FScEItHQvi5dvCxft
   rXxTD55OEYy7nYE2WBfWTjjAtaBZ5yPRrFRJ2LFTICe7igAOQ/38xxMuM
   0pE1WI5U344806l7Ii9IkpJ6vKPbhaz5ocS7VjrLksI5k/jL+JdLQPZQY
   /QCJKXS8XUVmV7t4g2TuxOglHPLz+fttHdp03IeD9UzWNppmGYCJvywB8
   bFRKwjxbyduwcmvxVcL9aYgWwsHaZyg0CvbEsNOoY15TAqqRp2GFHVZ5l
   nQ+rlcuAK5SsDBgGkev/4mnJVmjacQ07yCve1Sk374H9I6aFoTghUcgfr
   Q==;
X-CSE-ConnectionGUID: CrY570NPThi82nVTacn5RA==
X-CSE-MsgGUID: PNFSCfnJTdq+QELgHI1xng==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="49492388"
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600"; 
   d="scan'208";a="49492388"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 12:30:09 -0700
X-CSE-ConnectionGUID: xPvRFW1MQxCT7gpiGyeZdA==
X-CSE-MsgGUID: 3nJhJjrYRTmUv1PmE2EYpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600"; 
   d="scan'208";a="147709756"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 12:30:09 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 8797220B5736;
	Tue, 27 May 2025 12:30:07 -0700 (PDT)
Message-ID: <44e1c864-a6e1-41a8-9f11-0ea25999131c@linux.intel.com>
Date: Tue, 27 May 2025 15:30:06 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 01/16] perf: Fix the throttle logic for a group
To: Leo Yan <leo.yan@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
 irogers@google.com, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, eranian@google.com, ctshao@google.com,
 tmricht@linux.ibm.com, Aishwarya.TCV@arm.com
References: <20250520181644.2673067-1-kan.liang@linux.intel.com>
 <20250520181644.2673067-2-kan.liang@linux.intel.com>
 <20250527161656.GJ2566836@e132581.arm.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250527161656.GJ2566836@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-05-27 12:16 p.m., Leo Yan wrote:
> Hi Kan,
> 
> [ + Aishwarya ]
> 
> On Tue, May 20, 2025 at 11:16:29AM -0700, kan.liang@linux.intel.com wrote:
> 
> [...]
> 
>> @@ -10331,8 +10358,7 @@ __perf_event_account_interrupt(struct perf_event *event, int throttle)
>>  	if (unlikely(throttle && hwc->interrupts >= max_samples_per_tick)) {
>>  		__this_cpu_inc(perf_throttled_count);
>>  		tick_dep_set_cpu(smp_processor_id(), TICK_DEP_BIT_PERF_EVENTS);
>> -		hwc->interrupts = MAX_INTERRUPTS;
>> -		perf_log_throttle(event, 0);
>> +		perf_event_throttle_group(event);
>>  		ret = 1;
>>  	}
> 
> Our (Arm) CI reports RCU stall that caused by this patch.  I can use a
> simple command to trigger system stuck with cpu-clock:
> 
>   perf record -a -e cpu-clock -- sleep 2
> 
> I confirmed that if removing throttling code for cpu-clock event, then
> the issue can be dimissed.  Based on reading code, the flow below:
> 
>   hrtimer interrupt:
>    `> __perf_event_account_interrupt()
>        `> perf_event_throttle_group()
>            `> perf_event_throttle()
>                `> cpu_clock_event_stop()
>                    `> perf_swevent_cancel_hrtimer()
>                        `> hrtimer_cancel()  -> Inifite loop.
> 
> In the hrtimer interrupt handler, it tries to cancel itself and causes
> inifite loop.  Please consider to fix the issue.
> 

The cpu-clock and task_clock are two special SW events, which rely on
the hrtimer. I missed them when checking the SW events. :(

For the two events, instead of invoking the stop(), the
HRTIMER_NORESTART is returned to stop the timer. Invoking the stop()
cause the issue.

There may be two ways to fix it.
- Add a check of MAX_INTERRUPTS in the event_stop. Return immediately if
the stop is invoked by the throttle.
- Introduce a PMU flag to track the case. Avoid the event_stop in
perf_event_throttle() if the flag is detected.

The latter looks more generic. It may be used if there are other cases
that want to avoid the stop. So the latter is implemented as below.

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 947ad12dfdbe..66f02f46595c 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -303,6 +303,7 @@ struct perf_event_pmu_context;
 #define PERF_PMU_CAP_AUX_OUTPUT			0x0080
 #define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0100
 #define PERF_PMU_CAP_AUX_PAUSE			0x0200
+#define PERF_PMU_CAP_NO_THROTTLE_STOP		0x0400

 /**
  * pmu::scope
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8327ab0ee641..596597886d96 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2655,7 +2655,8 @@ static void perf_event_unthrottle(struct
perf_event *event, bool start)

 static void perf_event_throttle(struct perf_event *event)
 {
-	event->pmu->stop(event, 0);
+	if (!(event->pmu->capabilities & PERF_PMU_CAP_NO_THROTTLE_STOP))
+		event->pmu->stop(event, 0);
 	event->hw.interrupts = MAX_INTERRUPTS;
 	perf_log_throttle(event, 0);
 }
@@ -11846,7 +11847,8 @@ static int cpu_clock_event_init(struct
perf_event *event)
 static struct pmu perf_cpu_clock = {
 	.task_ctx_nr	= perf_sw_context,

-	.capabilities	= PERF_PMU_CAP_NO_NMI,
+	.capabilities	= PERF_PMU_CAP_NO_NMI |
+			  PERF_PMU_CAP_NO_THROTTLE_STOP,
 	.dev		= PMU_NULL_DEV,

 	.event_init	= cpu_clock_event_init,
@@ -11928,7 +11930,8 @@ static int task_clock_event_init(struct
perf_event *event)
 static struct pmu perf_task_clock = {
 	.task_ctx_nr	= perf_sw_context,

-	.capabilities	= PERF_PMU_CAP_NO_NMI,
+	.capabilities	= PERF_PMU_CAP_NO_NMI |
+			  PERF_PMU_CAP_NO_THROTTLE_STOP,
 	.dev		= PMU_NULL_DEV,

 	.event_init	= task_clock_event_init,


Thanks,
Kan


