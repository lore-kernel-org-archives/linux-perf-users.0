Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795552864;
	b=ZDBwMI812yo9yZy77MF2hsTF7BwdKafBxGOMwe2wKenWiHO9AGTPFHmEdEbIM3ttJePu
	 PgRayPtq6QFODq4atrEPAJGvRoermRN8Q1mSh7t+Hv3O5ZqSwEMln+6cg+jZuuNsVTiFH
	 Yj/dy3MP4941ojhF8agHxYmJbwXI7/UzlUcOH5uOAWW4IR4JZod5AVLz7DS6FevRQzK2+
	 JVzYSqBQXDAvlAcGE2GdXat11M0P4QR+OWfhOZkZTPnYNNSXRd37nKOMq663H8seIVClW
	 y0QM+L6MK3FkuPLig0Xn/FYjY/kyLGz8rmEKWEllk+mAkuN2yx+3NgpGYHbqDaHKOZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795552864;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=uk/D/QjVmnfcsDpzFvl9QIjuM8lT16j6eXyUDrS+n9c=;
	b=S6i1JkUoekiN/x22GmdPFbAADwXt9gxrGTf4kiOfeT6NiwFg23rHSQQAZhnjAet8GPCm
	 Bag2xeMqmcmaVEIL49GloHd31nj+CMnX8/wiFgspwb5UCRp4YLeZQ9EpiQpVq5Gam4ALJ
	 PtciFeZDIKA3ge6sTAvPjcN5DqofAWmpUHmSmLGSyayXonw96HjF+zWEWhb2OiUl66v6H
	 eh0x+rNEvHelFAfuVvjjOdaPk4YiguwFOEMsrtRyiuxO+VV9DoZTy3R1L7hTeSX6cGdys
	 23G+CvWqTDoP75duUv6cCnAF4wuXBpJB4KNQN3vIuXCvIHgUp82pv7okNiezTk6Ee9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ahnl9s73;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB245606A330;
	Tue, 24 Nov 2026 20:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ahnl9s73
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E291F000C6;
	Tue, 24 Nov 2026 20:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795552863;
	bh=uk/D/QjVmnfcsDpzFvl9QIjuM8lT16j6eXyUDrS+n9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ahnl9s73C8uo6WO1zrLYeCpJM7qrtNcfczc77qS5kbgU/zHt2sFxOV4qrMTsQqX9E
	 S0M6DeZRygyDyraX+bLeA55TQrl3AMsyxNsVHZy5g73k5jK8lD3wMsaRx1G1pKiuXn
	 q8Bjgx4tw1cWODlPvsCBTmWOcyUWthorFkTSWumrvrUIXwVRCsGvUNvh5iNmC1SpCD
	 OyNDgSI8mkfXjqeHwQjaAoa6JDIbSOEdviepCOtR1vWsS8yJsHWitDL+zoVQ0vPcAc
	 kJ/anmPOOs2XaxMg8CahIwPNnXVv/xEB0zzCPnHKqvMRH2CrKQiuOQ+AwuzQb56Io1
	 cbpiMCvkZxa9w==
Date: Tue, 24 Nov 2026 20:41:01 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [RFC PATCH 02/26] perf/core: Don't subtract guest time for
 events that keep counting
Message-ID: <awXz6uAojKNYe2Sd@google.com>
References: <20261124002303.1785363-1-yosry@kernel.org>
 <20261124002303.1785363-3-yosry@kernel.org>
 <sashiko-outbox-230300@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-230300@kernel.org>

On Tue, Nov 24, 2026 at 12:45:18AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] perf/core: NULL pointer deref in
>   perf_event_exclude_guest_time()
> --
> 
> commit db83e3f1bd6bd93912ce35d2e1ee8eb8daf9be37
> Author: Yosry Ahmed <yosry@kernel.org>
> 
> perf/core: Don't subtract guest time for events that keep counting
> 
> This commit restricts guest time subtraction to host-only events in a
> mediated-capable PMU context so that events in non-mediated PMU contexts
> do not have guest time subtracted while they continue counting.
> 
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 6f076e5483cb7..5a3e40155ce70 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> 
> [ ... ]
> 
> > @@ -872,12 +873,22 @@ static_assert(offsetof(struct perf_event_context, timeguest) -
> >  #define T_TOTAL		0
> >  #define T_GUEST		1
> >  
> > +/*
> > + * Exclude guest time only for host-only events in a mediated PMU context, as
> > + * those are scheduled out while a guest with a mediated vPMU runs.
> > + */
> > +static inline bool perf_event_exclude_guest_time(struct perf_event *event)
> > +{
> > +	return event->attr.exclude_guest &&
> > +	       (event->pmu_ctx->pmu->capabilities & PERF_PMU_CAP_MEDIATED_VPMU);
> > +}
> 
> [Severity: High]
> Can event->pmu_ctx be NULL here when reading a revoked event?
> 
> When perf_pmu_unregister() detaches an event, __pmu_detach_event() puts
> and clears event->pmu_ctx while event->ctx remains valid until the last
> file reference is dropped.  If an event with exclude_guest=1 is held in a
> BPF_MAP_TYPE_PERF_EVENT_ARRAY map after its PMU is unregistered, calling
> bpf_perf_event_read_value() reaches perf_event_read_local() ->
> calc_timer_values() -> perf_event_time_now() ->
> perf_event_exclude_guest_time(), causing a NULL pointer dereference on
> event->pmu_ctx.

I had convinced myself event->pmu_ctx here cannot be NULL, but I was
wrong. I don't think a NULL check helps, probably accessing the PMU here
is not safe at all as we can race against it being freed or cleared.  We
are not holding any locks here, and the freeing path doesn't do an RCU
sync after detaching events.

We can either use RCU to synchronize lockless readers against the PMU
being freed/cleared, or record exclude_guest_time as a property of the
event when adding it and query that directly.

The RCU option might be invasive, so perhaps the second approach is
preferable? Something like this on top:

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 1308b99a0abb6..cd9ede863514f 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -828,6 +828,11 @@ struct perf_event {
        u16                             header_size;
        u16                             id_header_size;
        u16                             read_size;
+       /*
+        * Exclude guest time from time_enabled/time_running. Set in
+        * list_add_event() under ctx->lock.
+        */
+       bool                            exclude_guest_time;
        struct hw_perf_event            hw;

        struct perf_event_context       *ctx;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 33422b92dc0db..ec08be5c1fcbe 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -878,22 +878,12 @@ static_assert(offsetof(struct perf_event_context, timeguest) -
 #define T_TOTAL                0
 #define T_GUEST                1

-/*
- * Exclude guest time only for host-only events in a mediated PMU context, as
- * those are scheduled out while a guest with a mediated vPMU runs.
- */
-static inline bool perf_event_exclude_guest_time(struct perf_event *event)
-{
-       return event->attr.exclude_guest &&
-              (event->pmu_ctx->pmu->capabilities & PERF_PMU_CAP_MEDIATED_VPMU);
-}
-
 static inline u64 __perf_event_time_ctx(struct perf_event *event,
                                        struct perf_time_ctx *times)
 {
        u64 time = times[T_TOTAL].time;

-       if (perf_event_exclude_guest_time(event))
+       if (event->exclude_guest_time)
                time -= times[T_GUEST].time;

        return time;
@@ -906,7 +896,7 @@ static inline u64 __perf_event_time_ctx_now(struct perf_event *event,
        u64 time = now + READ_ONCE(times[T_TOTAL].offset);
        u64 guest_time;

-       if (perf_event_exclude_guest_time(event)) {
+       if (event->exclude_guest_time) {
                if (is_guest_mediated_pmu_loaded())
                        guest_time = now + READ_ONCE(times[T_GUEST].offset);
                else
@@ -2017,6 +2007,21 @@ list_add_event(struct perf_event *event, struct perf_event_context *ctx)
        WARN_ON_ONCE(event->attach_state & PERF_ATTACH_CONTEXT);
        event->attach_state |= PERF_ATTACH_CONTEXT;

+       /*
+        * Exclude guest time only for host-only events in a mediated PMU
+        * context, as those are scheduled out while a guest with a mediated
+        * vPMU runs.
+        *
+        * Latch this when the event is added, as the time functions can run
+        * locklessly (e.g. perf_event_read_local()) and event->pmu_ctx is
+        * cleared when the PMU is unregistered.  This must be done before
+        * computing tstamp below, as perf_event_time() depends on it, so that
+        * tstamp and later time updates consistently include or exclude guest
+        * time.
+        */
+       event->exclude_guest_time = event->attr.exclude_guest &&
+               (event->pmu_ctx->pmu->capabilities & PERF_PMU_CAP_MEDIATED_VPMU);
+
        event->tstamp = perf_event_time(event);

        /*

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261124002303.1785363-1-yosry@kernel.org?part=2
