Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C463EB7FF
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 10:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544940; cv=none; b=S9qGHRf1eXjisJVGoRtZisDYgXFFMKRgJY9oBSyXxrTsjNovX6Q8o11WLvcEVkz6oWRiKVvuyCzyDK8CHAJ1JSssF2z7NkxpuZYvaeZ+6H7vbM14vEqZJCHWG4R8T/flRfiMGoBW6lNLnVAPsjMaANYQJyHz7rdY1F5Q0PKVJug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544940; c=relaxed/simple;
	bh=0eKAoKTDoUcyN4ts5YTSxN9UAQQm/8GlUGVwN9q4KOw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mLBvqT8INBOYbd2OwM3YtjmevUPWtAmdz5q/tJVArGF+LRtvyI0D+hZb//u4rDuO/gmcwdTjAH/tFFKXQs6iinwSonJ8KmiGk7gflpnz7iaT368/bUytJsQdYlPfKtb+NxBb286shJ0CCW9L/bwfYqtjeu0Duu6WZttMVqaoEYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQ9OpJ6V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQ9OpJ6V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23F31F00A3E;
	Mon, 20 Jul 2026 10:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784544939;
	bh=ItRrgtmWR6py2iqq1wf6GBkGKKYmHBqkKE3GIQ2+mjg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DQ9OpJ6Vni/hN7fOGe3Tai16ZVtJHrBpZUNwDQq30Ved55yUsw8uDvCfJdVHfPhG+
	 fB3w1+pJhEN05CXMJ1KK8ldjwFdYcjtDA6uLXsuObwxmXEIHXzDMEBNPsrixmrI7cJ
	 oLcVYBn2Gd20ksm58jcmDSNLetjdRzeNOVj8In+fxxFKkToHRnnl9kCmZP8h/f0UDP
	 oEa4x3wfeAjdDfMsViV2c0J0J92twy+uuBJ0xJsGDmg2NTJzMOokdwA9DdylyFMVoe
	 zfeSvxHDhRDBrZoTJHc/ERl0vnPn7YTJ7DxeD0XtV3MUjTl6dnbP4r9RThz217Fh0K
	 lKeuCNNiG4RrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 2/6] powerpc/perf: Reject duplicate HTM target
 reservations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260720104447.11843-3-atrajeev@linux.ibm.com>
References: <20260720104447.11843-1-atrajeev@linux.ibm.com>
 <20260720104447.11843-3-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 10:55:38 +0000
Message-Id: <20260720105538.F23F31F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Rejecting duplicate HTM target reservations with `-EBUSY` breaks `=
perf record -a`.
--

--- Patch [2]: [PATCH V2 2/6] powerpc/perf: Reject duplicate HTM target res=
ervations ---
commit ab5064c1a585bcfce6e8560bc79aa814badd08ff
Author: Athira Rajeev <atrajeev@linux.ibm.com>

powerpc/perf: Reject duplicate HTM target reservations

This commit tracks reserved HTM targets globally to prevent concurrent
event initialization races. It rejects duplicate reservations for the same
target in htm_event_init() by returning -EBUSY.

> diff --git a/arch/powerpc/perf/htm-perf.c b/arch/powerpc/perf/htm-perf.c
> index 5d3aa9c7fd8d1..a188a40287044 100644
> --- a/arch/powerpc/perf/htm-perf.c
> +++ b/arch/powerpc/perf/htm-perf.c
[ ... ]
> @@ -188,11 +203,30 @@ static int htm_event_init(struct perf_event *event)
>  	}
> =20
>  	/* Allocate per-event private state; freed via event->destroy */
> -	event->pmu_private =3D kzalloc(sizeof(struct htm_target_id), GFP_KERNEL=
);
> -	if (!event->pmu_private)
> +	target =3D kzalloc(sizeof(*target), GFP_KERNEL);
> +	if (!target)
>  		return -ENOMEM;
> =20
> -	((struct htm_target_id *)event->pmu_private)->cfg =3D cfg;
> +	target->cfg =3D cfg;
> +	target->tracing_active =3D HTM_TRACING_INACTIVE;
> +	INIT_LIST_HEAD(&target->list);
> +
> +	mutex_lock(&htm_targets_lock);
> +	list_for_each_entry(tmp, &htm_active_targets_list, list) {
> +		if (tmp->cfg.htmtype =3D=3D cfg.htmtype &&
> +			tmp->cfg.nodeindex =3D=3D cfg.nodeindex &&
> +			tmp->cfg.nodalchipindex =3D=3D cfg.nodalchipindex &&
> +			tmp->cfg.coreindexonchip =3D=3D cfg.coreindexonchip) {
> +			mutex_unlock(&htm_targets_lock);
> +			kfree(target);
> +			return -EBUSY;

[Severity: High]
Does returning -EBUSY here break "perf record -a" for this PMU?

Since the commit message notes that a cpumask was deliberately omitted,
the perf tool will attempt to open the event on every online CPU sequential=
ly
when running "perf record -a". The first open (e.g., for CPU 0) will succee=
d,
but the very next open (for CPU 1) will hit this path and return -EBUSY.

Because the perf tool treats -EBUSY as a fatal error, won't this abort the
entire profiling session instead of just skipping the duplicate target?

> +		}
> +	}
> +
> +	list_add_tail(&target->list, &htm_active_targets_list);
> +	mutex_unlock(&htm_targets_lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720104447.1184=
3-1-atrajeev@linux.ibm.com?part=3D2
