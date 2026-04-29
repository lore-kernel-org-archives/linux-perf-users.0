Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3981DF25C
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 09:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454016; cv=none; b=Nq/9w290I0gPbIaweBOeDGthPwCPJiqO8yxSly/lKYfyKFmfjpQ1NJkdjIxEr+ImvEcdrBa+fdrtd00umV3trv/KMyVyXPLwu58ViaGod1/1W05ae0HDAkQt5viawg5wIE9YTqs071vtTyDmGd2YlAppZLfzIf8Ci/cHR1oRp6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454016; c=relaxed/simple;
	bh=ZGpcBkOHi2zuYg7RC3G3iZTUhT+0Q6XhcFHkZS94Vv8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Nokl7l6UT5gUffS0wPlXpyE7Qup89kL+4COGKgsOKCGWLXlShqE9fg/PsHfNqq0s3QfFqeH09BUxccV7N4BFZD2Wn/etNB4y3T7MS63mqxrY8Vq9VUY2RjWX+FvjMao5fh/4fSQdQ+maB3p29yubEYD3Pl7ptobq75kWhw81pME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XR52OdG+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XR52OdG+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87487C2BCC6;
	Wed, 29 Apr 2026 09:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777454015;
	bh=ZGpcBkOHi2zuYg7RC3G3iZTUhT+0Q6XhcFHkZS94Vv8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=XR52OdG+2JDyu2rdu7x3NVoVP/A6oiHSGhQLyPlmMVTLZkXSGjb71I8YhdFlZ/QnN
	 F8AdQbUtylJMSqVa8HVEiuDzpVUuTOF5+n/dKH/6aprTBGjVrWnCuQBc5k6TPXk8P7
	 zD/F/5t88fBXuOex3i/GO6plymDTW8rh/vjubI1bMqTQctGBKG6mt6MwSv84LCwPA7
	 JEEvYJ/s7qQXXGoY3slUonszEZJbbRp8c3FPkxYuL1TDk8l4Ob6OEUUgzJtpwcJ4Pf
	 fRgJ8SPv+WphtvW9YAopFkwXmL/1VdJXS/I/sVRNxJfXm9l7/H5FA2/vcvzMjdAN/b
	 xRKTmI5MVehxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf/core: Fix sampling period inconsistency across
 CPU migration
Reply-To: sashiko@lists.linux.dev
To: "Minwoo Ahn" <mwahn402@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260429055924.10594-1-mwahn402@gmail.com>
References: <20260429055924.10594-1-mwahn402@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 09:13:34 +0000
Message-Id: <20260429091335.87487C2BCC6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Memory leak of struct perf_event_context in perf_get_task_ctxp()
- [High] Cross-session interference due to flawed inheritance matching in p=
erf_get_task_ctxp()
--

commit 1659d24a7199e1068822505af2a6e5f2de5e9e1a
Author: Minwoo Ahn <mwahn402@gmail.com>

perf/core: Fix sampling period inconsistency across CPU migration

This commit introduces struct perf_task_context to preserve the sampling
state of per-task software events when task migration occurs. It allocates
a shared context across per-CPU perf_event instances to transport the
period_left value between CPUs.

[ ... ]

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

Could this cause independent tracing sessions to interfere with each other?

If two separate sessions monitor the same process with identical
configurations, their inherited child events will both have an owner of NUL=
L.

Since perf_event_equal_task_ctx() only compares the config and sample_perio=
d,
the second session's child event might incorrectly match the first session's
event.

Would this lead to independent sessions sharing the same perf_task_ctxp and
clobbering each other's period_left state during task migrations?

> +			    perf_event_equal_task_ctx(&iter->attr,
> +						     &event->attr)) {
> +				ctxp =3D iter->perf_task_ctxp;
> +				refcount_inc(&ctxp->refcount);
> +				break;
> +			}
> +		}
> +		raw_spin_unlock_irqrestore(&ctx->lock, flags);

Does this leak the perf_event_context?

perf_lock_task_context() returns the context with its reference count
incremented, so the caller is typically responsible for dropping the refere=
nce
by calling put_ctx() after unlocking it.

Because put_ctx() is missing here, it seems this could leak the context and
the task_struct it pins each time a per-task software sampling event is
successfully created.

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

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260429055924.1059=
4-1-mwahn402@gmail.com?part=3D1
