Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795553236;
	b=QkyD8fijSJOJh7wXfHb/aF7mC7gWp/SNXQb6zL6fJISQepDygnk5bIHgChOQH0Wc3yA3
	 o+T6Zr1Aog6BSqSLzMVACU5ZCFhE1E53R+6k7wBcJ1JSyBqL8LoxmehrRikRmntvRxSac
	 nMT5d9Sgda4F2tL/xIZXys7EqLs8wkKTH/s5BcuU5Jb14W07+bqnvoCmteqFrWhNxD9hy
	 BECYDq/rbEMMA57Txlnl55QdTCbIfIRxIDSrpBP2kbSpqSyT7wbpARKt3F19Yqmok6/iO
	 ZVrR330gaw/7ClKfy2uR8zPj8310sdIrQpaqUQ5UvVltPJJFl018Fq+J/B4GCKDnvpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795553236;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=yFGdnGMEIu/NB7E4HB0GZctBtJwytKx4mRTKCli0u+4=;
	b=tVQL6gginOF3LpmFgU33QRlV7lxpMKCkh7ZRLYomzNyhAmd027w1T7mMTDJkiVcB8vYV
	 +/LQQc72bmmuRDmdsAvJVJDHewpOVsioX7ePocUL/TIeZz6bWlXpU1ppR7pIk3g6nuxvv
	 jvjBQMiY9yACVROpSnuQIvUfK3llAh0TByZGEPqJzXt/7Df2vFiZXM71Pi+VHuz5KFqIs
	 EK2Wn3l5q/+KMnPjmOJu3VZZi+rS6aQfW1ACIsOG8rY5K8S6mdt6T3lYP4vYWWunfHm4J
	 dfDKKEyvPKK/EWeqnZp5LgL3JgEQFRwyVBRu/c4Q4vfqr4UIcesbHAoRCEfOwHsqvaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mitw+JKM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AB5606A68D;
	Tue, 24 Nov 2026 20:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mitw+JKM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD531F000ED;
	Tue, 24 Nov 2026 20:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795553235;
	bh=yFGdnGMEIu/NB7E4HB0GZctBtJwytKx4mRTKCli0u+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mitw+JKM4/wdQsEirvDsddczotlFpii/Vs8TjihT0iVp2lLZ3BeZ1XH2OL14BGaz6
	 /6MLCOd0k9GwZFyUuJJhrrBLnKeAjxvr+QmV4YjKf+jBo0yqmDItB6JRiKWtDkWNij
	 7dEOaM+mrXIkHEEjJMDiYWKZy3kpM109icCOFZZK8eqSXA2Qt9erwZ+D9bMRqJ8CD1
	 gY6lx5sPLWIDvPWXyn1ldy7HhNfT+1vleX5y5vkf2nOLUvxg7ZdhATZrJAhKOqxP8R
	 /kmtOmCEKXEanbyNgcNsYvS1HIiXMd4dGgBhpHfDZ3KJex7AkmexXnr0DAPMZbHnle
	 hq/Apcu+sDrag==
Date: Tue, 24 Nov 2026 20:47:14 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [RFC PATCH 10/26] perf: Track mediated PMU conflicts
Message-ID: <awX2aPIOVrqUZ53Y@google.com>
References: <20261124002303.1785363-1-yosry@kernel.org>
 <20261124002303.1785363-11-yosry@kernel.org>
 <sashiko-outbox-230318@kernel.org>
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
In-Reply-To: <sashiko-outbox-230318@kernel.org>

On Tue, Nov 24, 2026 at 12:52:00AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] perf: missed conflict accounting for grouped events in
>   account_mediated_pmu_conflicts()
> --
> 
> commit d02999449ac3f60478e5b2d635e9ec7e78dbd825
> Author: Yosry Ahmed <yosry@kernel.org>
> 
> perf: Track mediated PMU conflicts
> 
> This commit tracks perf events that conflict with a guest mediated PMU in
> perf_event_context and exposes perf_has_mediated_pmu_conflicts() for KVM,
> marking Intel PT and Intel BTS with PERF_PMU_CAP_USES_MEDIATED_PMI.
> 
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 99aa56ced8253..33422b92dc0db 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -1989,6 +1989,22 @@ static inline bool has_inherit_and_sample_read(struct perf_event_attr *attr)
> >  	return attr->inherit && (attr->sample_type & PERF_SAMPLE_READ);
> >  }
> >  
> > +#ifdef CONFIG_PERF_GUEST_MEDIATED_PMU
> > +static void account_mediated_pmu_conflicts(struct perf_event *event,
> > +					   struct perf_event_context *ctx,
> > +					   int nr)
> > +{
> > +	if (event->pmu_ctx->pmu->capabilities &
> > +	    (PERF_PMU_CAP_MEDIATED_VPMU | PERF_PMU_CAP_USES_MEDIATED_PMI))
> > +		WRITE_ONCE(ctx->nr_mediated_pmu_conflicts,
> > +			   ctx->nr_mediated_pmu_conflicts + nr);
> > +}
> 
> [Severity: Medium]
> Should account_mediated_pmu_conflicts() check event->pmu->capabilities
> rather than event->pmu_ctx->pmu->capabilities?

Yes and no.

> 
> Both Intel PT and Intel BTS set task_ctx_nr = perf_sw_context, so
> __do_sys_perf_event_open() gives their events PERF_EV_CAP_SOFTWARE.  When
> an Intel PT or Intel BTS event is grouped with a non-software event on a
> PMU without PERF_PMU_CAP_MEDIATED_VPMU or PERF_PMU_CAP_USES_MEDIATED_PMI
> (for example via aux_output or move_group), event->pmu still points to
> pt_pmu or bts_pmu, but event->pmu_ctx->pmu points to the other PMU:
> 
> kernel/events/core.c:__do_sys_perf_event_open() {
>     ...
> 		if (is_software_event(event) &&
> 		    !in_software_context(group_leader)) {
> 			pmu = group_leader->pmu_ctx->pmu;
> 		} else if (!is_software_event(event)) {
> 			if (is_software_event(group_leader) &&
> 			    (group_leader->group_caps & PERF_EV_CAP_SOFTWARE)) {
> 				move_group = 1;
> 			}
>     ...
> }
> 
> In that case ctx->nr_mediated_pmu_conflicts is left at 0 while the PT or
> BTS event is installed, so perf_has_mediated_pmu_conflicts() returns false
> and KVM leaves the guest mediated PMU context loaded during slowpath
> VM-exit handling.

I originally wrote this as a helper for perf_skip_pmu_ctx(), so it
always operated on pmu_ctx, and that was a slightly different
implementation.

I was going to say we need to check event->pmu instead of
event->pmu_ctx->pmu, but I think it's more nuanced. I think conflicting
events are either:

- Events that are scheduled out while the guest context is loaded ->
  These are basically any events whose PMU context is mediated-capable,
  so checking event->pmu_ctx->pmu is correct.

- Events that use the same PMI mechanism as the mediated PMU -> These
  are Intel PT/BTS events, and the context they are in doesn't matter.
  As long as one of these events is active the guest context needs to be
  put to avoid a misrouted PMI, so checking event->pmu is correct.

So probably the right thing to do here is this:

diff --git a/kernel/events/core.c b/kernel/events/core.c
index ec08be5c1fcbe..d3e1b33c97716 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1980,14 +1980,22 @@ static inline bool has_inherit_and_sample_read(struct perf_event_attr *attr)
 }

 #ifdef CONFIG_PERF_GUEST_MEDIATED_PMU
+/*
+ * Events in a mediated-capable PMU context are scheduled out while a guest
+ * context is loaded, including software events grouped with a mediated leader.
+ * Events on PMUs sharing the guest PMI mechanism (Intel PT/BTS) raise PMIs from
+ * whichever context they are in, and are software events for grouping
+ * purposes, so they can be in another PMU's context: check their own PMU.
+ */
 static void account_mediated_pmu_conflicts(struct perf_event *event,
                                           struct perf_event_context *ctx,
                                           int nr)
 {
-       if (event->pmu_ctx->pmu->capabilities &
-           (PERF_PMU_CAP_MEDIATED_VPMU | PERF_PMU_CAP_USES_MEDIATED_PMI))
-               WRITE_ONCE(ctx->nr_mediated_pmu_conflicts,
-                          ctx->nr_mediated_pmu_conflicts + nr);
+       if (!(event->pmu_ctx->pmu->capabilities & PERF_PMU_CAP_MEDIATED_VPMU) &&
+           !(event->pmu->capabilities & PERF_PMU_CAP_USES_MEDIATED_PMI))
+               return;
+
+       WRITE_ONCE(ctx->nr_mediated_pmu_conflicts, ctx->nr_mediated_pmu_conflicts + nr);
 }
 #else
 static inline void account_mediated_pmu_conflicts(struct perf_event *event,
