Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21A13A3E92
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 10:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777459871; cv=none; b=q2KN9gz4j6Y2Wo4Y7TKSIYZzAvfQ2H88mCz0m6pTpQVuwaDpxzv4Ua902cDjwM685AgfO03nvs4ykuQkQG1oy1acZpedKJ8TebSROeZUxsob7KaTT4WfGGpSpIcC9w0VdRWdD2esgstlLHlQYB8kkp2L6C42haMMNrIjUqJh2lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777459871; c=relaxed/simple;
	bh=chWIUOMUiXNffLcBAnBQtF/h/1e4VLFoRdEdHjUbFkM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PxWlyLJuJNIbY9F5TvIFgatUe4j34gXAnHoQIBtYq2aD0OE8eQovKatusJ7VI8SGxNwfK/BE6Rz08n8nby0PN8UXFVfx+YPg2vrbzQctgyNCoL5Jqxq/1Io7GmRj++RGMgZ7pAWCT04MrMiOkjWcSXZw3qsajHqMPq0+W2RTMag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRaAbj8U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRaAbj8U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ECD6C19425;
	Wed, 29 Apr 2026 10:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777459870;
	bh=chWIUOMUiXNffLcBAnBQtF/h/1e4VLFoRdEdHjUbFkM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=jRaAbj8UNjaayQyZ17PlUwt6FwWrU1cDgy0C5cmHBI95EtpKizhlvAgZ4zDEn676a
	 mJTKTq1lv7QOj0hBycra2lbMgXyIrG5xfJeHaQZbdnu1zoQqt3TtSvizRubr2fy8VZ
	 2MD48E2ikPhiLftG/MuGMZJfBC51tRJ8/wmbH6z+xsexEaewXadrgMnDimBPOWinEh
	 CyoXFmToNcBonMDX23AeW9EHVnj21H43Tad7TR+uKME8/hIZUlojb5e0R10i45BMq/
	 GOTJugWQ2zGu6d6aj3zsDlKUf1HRR48XOJoGeUzz8hoogpNGIYJT8p5ygbbDWiOfWD
	 iVTpH7e0TN19A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] perf/core: Fix sampling period inconsistency across
 CPU migration
Reply-To: sashiko@lists.linux.dev
To: "Minwoo Ahn" <mwahn402@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260429095134.10049-1-mwahn402@gmail.com>
References: <20260429095134.10049-1-mwahn402@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 10:51:09 +0000
Message-Id: <20260429105110.6ECD6C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Flawed event matching heuristic falsely groups distinct sampling s=
essions, causing them to corrupt each other's sampling period.
- [Medium] TOCTOU race in `perf_get_task_ctxp` prevents context sharing for=
 concurrently created per-CPU events.
- [Medium] Plain lockless read of `iter->owner` risks data races with concu=
rrent task exits.
--

commit fcbb40982fea3f4e611342ab82ef8efe806efcc9
Author: Minwoo Ahn <mwahn402@gmail.com>

perf/core: Fix sampling period inconsistency across CPU migration

This commit introduces struct perf_task_context to preserve period_left
across CPU migrations for per-task software sampling events. A shared
context is used to prevent period resets when a task migrates across CPUs.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 6d1f8bad7e1c..eec0e822ef6e 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c

[ ... ]

> @@ -13259,6 +13291,45 @@ static void account_event(struct perf_event *eve=
nt)
>  	account_pmu_sb_event(event);
>  }
> =20
> +static struct perf_task_context *
> +perf_get_task_ctxp(struct perf_event *event, struct task_struct *task,
> +		   struct perf_event *parent_event)
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

The event owner field is cleared asynchronously when the owner task exits
or releases the event descriptor, such as via smp_store_release() in
perf_event_release_kernel().

Could this plain read of iter->owner race with a concurrent task exit?
Should this be accessed using READ_ONCE() to avoid data races?

> +			     (parent_event && !iter->owner &&
> +			      iter->parent &&
> +			      iter->parent->perf_task_ctxp =3D=3D
> +			      parent_event->perf_task_ctxp)) &&
> +			    perf_event_equal_task_ctx(&iter->attr,
> +						     &event->attr)) {

The perf_event_equal_task_ctx() macro only compares the config and
sample_period attributes. If a user opens multiple independent software eve=
nts
for the same task with identical configs and periods (for example,
perf record -e task-clock,task-clock), or if the events differ in unchecked
attributes like exclude_user or exclude_kernel, will they incorrectly share
the same perf_task_context?

If these independent events share the same context, when the task is schedu=
led
out, both events would sequentially write their hw.period_left to the shared
ctxp->period_left, clobbering the first write. Upon schedule in, both events
would restore from this clobbered value.

Could this entangle and corrupt their respective sampling periodicities?

> +				ctxp =3D iter->perf_task_ctxp;
> +				refcount_inc(&ctxp->refcount);
> +				break;
> +			}
> +		}
> +		raw_spin_unlock_irqrestore(&ctx->lock, flags);
> +		put_ctx(ctx);
> +	}
> +
> +	if (!ctxp) {
> +		ctxp =3D kzalloc_obj(struct perf_task_context);

If a userspace profiling application concurrently calls sys_perf_event_open=
()
from multiple threads to create per-CPU events for the same task, both thre=
ads
could perform the locked search above before either event reaches
perf_install_in_context().

Since neither event is in ctx->event_list yet, will both threads fail to fi=
nd
a match, independently allocate new perf_task_context structures here, and
fail to share the context?

Does this race condition leave the migration period inconsistency unfixed f=
or
concurrently created events?

> +		if (!ctxp)
> +			return NULL;
> +		refcount_set(&ctxp->refcount, 1);
> +	}
> +
> +	return ctxp;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260429095134.1004=
9-1-mwahn402@gmail.com?part=3D1
