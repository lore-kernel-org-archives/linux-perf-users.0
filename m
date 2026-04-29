Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FDB1397
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 09:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777453566; cv=none; b=V3nXL5Qn2MiVKaYsBiWelAB9aTgt8TuIV+BxUulgI5VZaUVohy1VwH2o/Ca2fCX4kuuBySGPMq5oi/J3XsZMs07y5ugTccGYaVDpaxFC4GcyfmkL33lOzGOnQLINx78mKM1cv5onp8QL0pWIX4bcvgRVpxSkZd1l6h5q2zHEdFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777453566; c=relaxed/simple;
	bh=zqlHpOWJU4OiU8Lo2eWiu7R9w5ZkaHVS+w6GAuaAYSQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qVeg18v3tI2+kwVzPkn6RF2BbDC3RJhg3mPou0DvQAaFyY52mEY7JuzVbkBdRdizbVY3eNun9UbFF3Ocin6jk++ypIYrjwr0aBjVggwKJfC2BYOo+0JRgkqefSyHKCR5oMjfVSgUMxM3IWtjEcmtnDH3LdfvEpM1H7DlMweWgc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cdez5Bum; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cdez5Bum"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C51EC19425;
	Wed, 29 Apr 2026 09:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777453566;
	bh=zqlHpOWJU4OiU8Lo2eWiu7R9w5ZkaHVS+w6GAuaAYSQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Cdez5BumVogZLC3+5sAc95LgrbPTqODiv5f0tXBHH0Qe8x5Nrd3FNOZW8wLBft/d4
	 A8Kl63r9rOUXhu0QDXUO3rTVgNfvqF2P42Aq+iOgRW7XgzJ8tevzuVKj7IGPPJGpqv
	 hvbzZSVuTcE3fMga5UpwwdLVN3nV30ilgZ95mGDgFRsHAg50J0VTGjgzBsw0v42k3a
	 uInuJdYFC/taaKIwQ1ivl3B02kmdDtOamLbotR/ZCRA3y0aeWkkRiNqgRpOayIkZCB
	 FMsdBCxijbGTDFiUbZfZ2z/MepzJ2mbLmwuzh9dmK/3UlUfziNA34Xivaq6yosMsy6
	 /37BMXHYLxH4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] perf/core: Fix sampling period inconsistency across
 CPU migration
Reply-To: sashiko@lists.linux.dev
To: "Minwoo Ahn" <mwahn402@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260429074328.41991-1-mwahn402@gmail.com>
References: <20260429074328.41991-1-mwahn402@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 09:06:04 +0000
Message-Id: <20260429090606.1C51EC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing put_ctx() in perf_get_task_ctxp() causes a permanent refer=
ence leak of perf_event_context and task_struct.
- [High] Erroneous perf_task_ctxp sharing clobbers states of independent pr=
ofiling sessions.
--

commit 8823a0e265a5483fceb1f344697e122c9270c810
Author: Minwoo Ahn <mwahn402@gmail.com>

perf/core: Fix sampling period inconsistency across CPU migration

This commit introduces struct perf_task_context to preserve period_left acr=
oss
CPU migrations for per-task software sampling events. It adds allocation and
refcounting logic to share this context among related events on the same ta=
sk.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 6d1f8bad7e1c..f5cb1a273fbf 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
[ ... ]
> @@ -13259,6 +13291,41 @@ static void account_event(struct perf_event *eve=
nt)
>  	account_pmu_sb_event(event);
>  }
> =20
> +static struct perf_task_context *
> +perf_get_task_ctxp(struct perf_event *event, struct task_struct *task,
> +		   bool inherit)
> +{
> +	struct perf_task_context *ctxp =3D NULL;
> +	struct perf_event_context *ctx;
> +	struct perf_event *iter;
> +	unsigned long flags;
> +
> +	ctx =3D perf_lock_task_context(task, &flags);
> +	if (ctx) {
> +		list_for_each_entry(iter, &ctx->event_list, event_entry) {
> +			if (iter->perf_task_ctxp &&
> +			    (iter->owner =3D=3D current ||
> +			     (inherit && !iter->owner)) &&

For inherited child events, both iter->owner and event->owner will be NULL.
If a parent task is being profiled by two separate and independent perf
sessions, will this (inherit && !iter->owner) condition inadvertently merge
both child events into a single perf_task_context?

Would it be safer to verify parent lineage, for example by checking if
iter->parent->perf_task_ctxp equals event->parent->perf_task_ctxp, to
ensure the inherited events actually belong to the same profiling session?

> +			    perf_event_equal_task_ctx(&iter->attr,
> +						     &event->attr)) {

Could this logic mistakenly merge the sampling states of completely
independent perf events in the same task?

If a process opens multiple distinct sampling events for the same task with
identical configurations and sample periods, they appear to pass this
equality check. Since they share the same perf_task_context, won't they
corrupt each other's period_left states when the task schedules out?

> +				ctxp =3D iter->perf_task_ctxp;
> +				refcount_inc(&ctxp->refcount);
> +				break;
> +			}
> +		}
> +		raw_spin_unlock_irqrestore(&ctx->lock, flags);

The perf_lock_task_context() helper takes a reference on the returned ctx
using refcount_inc_not_zero().

Does this path leak the perf_event_context (and consequently the pinned
task_struct) by returning without calling put_ctx(ctx) to drop that
reference?

> +	}
> +
> +	if (!ctxp) {
> +		ctxp =3D kzalloc_obj(struct perf_task_context);
> +		if (!ctxp)
> +			return NULL;
> +		refcount_set(&ctxp->refcount, 1);
> +	}
> +
> +	return ctxp;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260429074328.4199=
1-1-mwahn402@gmail.com?part=3D1
