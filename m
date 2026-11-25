Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795610238;
	b=NjPuE8oWATcdIfiwcy06hFbEgPRhWZDfSJV3diC7YT3+EWscNWW28ZA3PrDt9eQPme7I
	 bk1tuke3EzOLcYdj4lpQ/UcfAwacaCUthjpeDygtTo9yipEOZtTJRruNF1pK/BsYWq18t
	 aiBw88r8J4neaIVRKFZrXFv3l7pU4fdY6rre+aRDWhORMK25WJFoU+8VvFCw2IzhwwD1C
	 xdXYMaGFw0ONokNSLKhm2UegWW66hfbUGV9xeFPPZDlQ4suyFqyRQYkig/tYys3yTRHC4
	 f0rlmjNbCflTYJqHA4SjS2vjgKBZaa80jKY8w3FS8L7kTTVMUMYYZSGVEPT7sLXo1fA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795610238;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=aa+X//tm4/lFXErjeDCqNgnTOcB7OZELGjjPOVz8xhg=;
	b=gb5LzVckku/nMs+IpRBSTzjT6JwwKoEDSlCTMi4KfhIMCOS+i2yec7yMh0iLs3O83PD0
	 oz+luZ53tvIcScej7o3AAxBqVrjNZWuyBh1pYdJhIO0PrfME0RQF8QKfxGCabDRDPkSJU
	 aQeI8ePFLnh6hCRbDAPwanEs1TBLGiyUKICZq9jBhZsUQTjGFlXthjDHC914n8vvkdNDj
	 5kQ5jI+UqEdgiLHMXPxKwuLfVd76dqIBqncWl6um2984uYY7JiD+7W5AEG2UUi2VaH+Xn
	 e8zSzFDDM0mAKGs4bxsY1dnFR3iyDZTTfXCJ+bwVWAhJMVq+n0enQ1mjaFHjlidxDHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b="Zv+tL6/L";
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281A9606A31E;
	Wed, 25 Nov 2026 12:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 281A9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Zv+tL6/L
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aa+X//tm4/lFXErjeDCqNgnTOcB7OZELGjjPOVz8xhg=; b=Zv+tL6/Lr3eB9LcSUDaqrEqQgY
	FMi2PfDqqyyv/Ci71YE/1fMCxwQOBM6ADgTmFxAko3oUZhFOHBILM+v4ELhsYMn/lTTLzB3FfhIuH
	MRHqV0uqMgLtUj4BzZn4G4idXBfw0XCBvza7lz2F78qCX4eRYNK2QsJruxAnmvirwXk/d1UmHiapn
	Afl2ydAl3qwLr28yNsHFT/mW11AWXEHgjpHf/xpQMRiJLyY08q1Wi3yr2cxQud1WiZP1CYuA9JAd6
	lh//J8Afb7g7lBL1b02jNTkGfNkHErBPAekZkDtDKYjnxaNVmBNtmFDrnMkRZ8ZSoGEWcMlXC6/9x
	i8KopEbg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWCFN-0000000DcmD-0G9S;
	Wed, 25 Nov 2026 12:37:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1623B302431; Wed, 25 Nov 2026 13:37:12 +0100 (CET)
Date: Wed, 25 Nov 2026 13:37:12 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Andi Kleen <ak@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Stephane Eranian <eranian@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] perf/core: Add PERF_EVENT_STATE_ON to fix
 filtered event enabled time
Message-ID: <20261125123712.GP1813469@noisy.programming.kicks-ass.net>
References: <80d983c5713537f5743b69e9b35ced1177e4732e.1795589380.git.irogers@google.com>
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
In-Reply-To: <80d983c5713537f5743b69e9b35ced1177e4732e.1795589380.git.irogers@google.com>

On Tue, Nov 24, 2026 at 10:52:28PM -0800, Ian Rogers wrote:
>  include/linux/perf_event.h | 60 ++++++++++++++++----------
>  kernel/events/core.c       | 86 +++++++++++++++++++++++++++-----------
>  2 files changed, 101 insertions(+), 45 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index e1e11500df09..715f564a3f96 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -639,28 +639,44 @@ struct perf_addr_filter_range {
>  /*
>   * The normal states are:
>   *

> + *                         OFF <----disable()-------.
> + *                          |         ^             |
> + *    .-----------------> enable()    |             |
> + *    |                     |  .------'             |
> + *    |                     v /                     |
> + *  ERROR      .---------> ON <-----------.         |
> + *    ^        |            |             |         |
> + *    |      filter <-- sched_in()  sched_out()     |
> + *    |                     |             |         |
> + *    +-(lack of counters)--+             |         |
> + *    v                     v             |         |
> + *  INACTIVE              ACTIVE          |         |
> + *    |                     |             |         |
> + *    '---------------------+-------------+---------'
>   *
>   * That is:
>   *
> + * sched_in:       ON                   -> {ON,ERROR,INACTIVE,ACTIVE}
> + * sched_out:      {INACTIVE,ACTIVE}    -> ON
> + * disable:        {ON,INACTIVE,ACTIVE} -> OFF
> + * enable:         {OFF,ERROR}          -> ON
>   *
> + * Where {ON,INACTIVE,ACTIVE} are enabled states and {OFF,ERROR} are disabled
> + * states.
> + *
> + * ON differs from INACTIVE as enabled time only increases for INACTIVE and
> + * ACTIVE events, running time only increases for ACTIVE events. A filter, such
> + * as the task, cgroup, CPU, or PMU an event should be scheduled on, can cause
> + * an event during sched_in to remain in the ON state, while lack of counters
> + * or exclusivity constraints move pinned events to ERROR and flexible events
> + * to INACTIVE.
> + *
> + * Additional special-case transitions not shown above:
> + *  - enable() on a sibling of an INACTIVE group leader moves directly from ON
> + *    to INACTIVE when the context is active and filters match;
> + *  - sched_out() with pending_disable moves {INACTIVE,ACTIVE} directly to OFF;
> + *  - detaching a group sibling that requires a group leader (such as
> + *    aux_output or PERF_EV_CAP_SIBLING) disables it into ERROR.
>   *
>   * Then we have the {EXIT,REVOKED,DEAD} states which are various shades of
>   * defunct events:

Compressed that diagram a litte, and removed spurious arrows from it.
Eg. ERROR->enable() is not correct since enable() is not a state, it is
the label.

I also removed the ON->ON transition, as that seemed superfluous.

--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -639,24 +639,25 @@ struct perf_addr_filter_range {
 /*
  * The normal states are:
  *
- *                         OFF <----disable()-------.
- *                          |         ^             |
- *    .-----------------> enable()    |             |
- *    |                     |  .------'             |
- *    |                     v /                     |
- *  ERROR      .---------> ON <-----------.         |
- *    ^        |            |             |         |
- *    |      filter <-- sched_in()  sched_out()     |
- *    |                     |             |         |
- *    +-(lack of counters)--+             |         |
- *    v                     v             |         |
- *  INACTIVE              ACTIVE          |         |
- *    |                     |             |         |
- *    '---------------------+-------------+---------'
+ *                 OFF <----disable()---.
+ *                  |         |         |
+ *    .----------enable()     |         |
+ *    |             |  .------'         |
+ *    |             v /                 |
+ *  ERROR           ON <----------.     |
+ *    ^             |             |     |
+ *    |         sched_in()  sched_out() |
+ *    |             |             |     |
+ *    +-(no space)--+             |     |
+ *    |             |             |     |
+ *    v             v             |     |
+ *  INACTIVE      ACTIVE          |     |
+ *    |             |             |     |
+ *    '-------------+-------------+-----'
  *
  * That is:
  *
- * sched_in:       ON                   -> {ON,ERROR,INACTIVE,ACTIVE}
+ * sched_in:       ON                   -> {ERROR,INACTIVE,ACTIVE}
  * sched_out:      {INACTIVE,ACTIVE}    -> ON
  * disable:        {ON,INACTIVE,ACTIVE} -> OFF
  * enable:         {OFF,ERROR}          -> ON
@@ -665,16 +666,19 @@ struct perf_addr_filter_range {
  * states.
  *
  * ON differs from INACTIVE as enabled time only increases for INACTIVE and
- * ACTIVE events, running time only increases for ACTIVE events. A filter, such
- * as the task, cgroup, CPU, or PMU an event should be scheduled on, can cause
- * an event during sched_in to remain in the ON state, while lack of counters
- * or exclusivity constraints move pinned events to ERROR and flexible events
- * to INACTIVE.
+ * ACTIVE events, running time only increases for ACTIVE events. A filter,
+ * such as the task, cgroup, CPU, or PMU an event should be scheduled on, can
+ * cause an event during sched_in to remain in the ON state, while lack of
+ * counters or exclusivity constraints move pinned events to ERROR and
+ * flexible events to INACTIVE.
  *
  * Additional special-case transitions not shown above:
+ *
  *  - enable() on a sibling of an INACTIVE group leader moves directly from ON
  *    to INACTIVE when the context is active and filters match;
+ *
  *  - sched_out() with pending_disable moves {INACTIVE,ACTIVE} directly to OFF;
+ *
  *  - detaching a group sibling that requires a group leader (such as
  *    aux_output or PERF_EV_CAP_SIBLING) disables it into ERROR.
  *


> @@ -2490,6 +2492,17 @@ event_sched_out(struct perf_event *event, struct perf_event_context *ctx)
>  	 */
>  	list_del_init(&event->active_list);
>  
> +	if (event->state == PERF_EVENT_STATE_INACTIVE) {
> +		if (event->pending_disable) {
> +			event->pending_disable = 0;
> +			perf_cgroup_event_disable(event, ctx);
> +			state = PERF_EVENT_STATE_OFF;
> +		}
> +		perf_event_set_state(event, state);
> +		perf_event_update_userpage(event);
> +		return;
> +	}
> +
>  	perf_pmu_disable(event->pmu);
>  
>  	event->pmu->del(event, 0);

This duplicates a bit of logic, which is sad, but I don't immediately
see a sane way around it either. That is, you're wanting to avoid that
perf_pmu_{dis,en}able() here.


> @@ -2859,7 +2872,7 @@ event_sched_in(struct perf_event *event, struct perf_event_context *ctx)
>  	perf_log_itrace_start(event);
>  
>  	if (event->pmu->add(event, PERF_EF_START)) {
> -		perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
> +		perf_event_set_state(event, PERF_EVENT_STATE_ON);
>  		event->oncpu = -1;
>  		ret = -EAGAIN;
>  		goto out;

> @@ -4134,6 +4154,21 @@ struct merge_sched_data {
>  	enum event_type_t event_type;
>  };
>  
> +static void group_set_inactive(struct perf_event *group_event)
> +{
> +	struct perf_event *sibling;
> +
> +	perf_event_set_state(group_event, PERF_EVENT_STATE_INACTIVE);
> +
> +	for_each_sibling_event(sibling, group_event) {
> +		if (sibling->state == PERF_EVENT_STATE_ON)
> +			perf_event_set_state(sibling, PERF_EVENT_STATE_INACTIVE);
> +	}
> +
> +	list_add_tail(&group_event->active_list,
> +		      &group_event->pmu_ctx->flexible_inactive);
> +}
> +
>  static int merge_sched_in(struct perf_event *event, void *data)
>  {
>  	struct perf_event_context *ctx = event->ctx;
> @@ -4159,7 +4194,7 @@ static int merge_sched_in(struct perf_event *event, void *data)
>  			list_add_tail(&event->active_list, get_event_list(event));
>  	}
>  
> -	if (event->state == PERF_EVENT_STATE_INACTIVE) {
> +	if (event->state == PERF_EVENT_STATE_ON) {
>  		msd->can_add_hw = 0;
>  		if (event->attr.pinned) {
>  			perf_cgroup_event_disable(event, ctx);
> @@ -4173,6 +4208,7 @@ static int merge_sched_in(struct perf_event *event, void *data)
>  		} else {
>  			struct perf_cpu_pmu_context *cpc = this_cpc(event->pmu_ctx->pmu);
>  
> +			group_set_inactive(event);
>  			event->pmu_ctx->rotate_necessary = 1;
>  			perf_mux_hrtimer_restart(cpc);
>  			group_update_userpage(event);

This is all very confusing. The state diagram says that you go to either
INACTIVE or ERROR on no moar counters, but then the event_sched_in()
failure goes to ON only to then later be 'corrected' to INACTIVE.

That makes no sense.
