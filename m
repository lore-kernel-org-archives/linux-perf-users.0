Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653164A35
	for <linux-perf-users@vger.kernel.org>; Sat,  3 Oct 2026 20:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791059442; cv=none; b=jjDuMZXOuv4VeM55oStRzeXMBRXDfDjD8Fc+tN7AQi0V0oouC2wbrYZHy/BQtPUmaQTeXbZoNIKwOkk9jDQ19KdGZSczrVwZn0eFlj/DnXIqub7+KBCEv2hJsHjlqPcTqaag/TozTWgDt+aw/s9uCdXT/Oz7B/WLZvO/KiEvrDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791059442; c=relaxed/simple;
	bh=PXJYH1iNABcvig8O3qfEIf6r7mEDfITJcdcFefK+cFM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NN7tzJl2yBurSA5EzzDOj6o/4+ZteGlmuxu72UYOAQS11BXPF5jyuURUcoBu26ksUCstyvhInu3c197OgmE47kJVg+ZscOkdwMgVmvNL1swioO7YlPwqah/jq8lzb3gEF0kDhRTf7dOjEYH5FoZzdxZwL7wnxBEqhpQBFn2Ho+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1uvkbRl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1uvkbRl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6631F0089B;
	Sat,  3 Oct 2026 20:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791059441;
	bh=u56WJA9C3k4MJefXi/SAWL5aUZ7wv7FfQyabFZjkpb4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O1uvkbRlVd1CCqMZBmbYbpmv1ZjGLB0nU181Jld558FDKJD99sTdpwjBFAd07Jzub
	 fxkCs2oTQA2Ss/Za4Ye74RJpe8PnQpSQoOYdPbxNl7v67vTf2e6XcZ2cqmhMkrm7op
	 Hh4/dQKNag+e6n9Pj1ibrLTcCLV1Zm+90pgd+2/otxJt05i9nADbF6WKm3J/C5PT6q
	 C+6mJVgU/4wPUMcwFN+H5SueodHRJ13WMLngAGK2/LScQTb2ySjBGxJMSTAYEiaGYh
	 hAyTOHhDlOCcAkM9CTZcNklnOi3tz/AExdzJeVsJs3SfRTChi+m8A1rvD30cx7Prtq
	 skqmplqpgGqhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/core: Fix double put of the system-wide
 perf_ctx_data reference
Reply-To: sashiko-reviews@lists.linux.dev
To: vineash <vineash30640@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <179105852659.1844849.16381123619267169417@gmail.com>
References: <179105852659.1844849.16381123619267169417@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 20:30:40 +0000
Message-Id: <20261003203040.EE6631F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] perf/core: memory leak of perf_ctx_data due to TOCTOU race in atta=
ch_global_ctx_data()
- [Medium] perf/core: data race on cd->global leading to undefined behavior
--

commit 6c40093668f0aa28205d435b7cecaca312682e03
Author: vineash <vineash30640@gmail.com>

perf/core: Fix double put of the system-wide perf_ctx_data reference

The reference on a task's perf_ctx_data that belongs to the system-wide
events (cd->global) can be put twice. __detach_global_ctx_data() puts it
when the last system-wide event goes away, and perf_event_exit_task()
puts it again when the task exits.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index a34ff4cb410da..63122c3b872ef 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -5498,8 +5498,9 @@ attach_global_ctx_data(struct kmem_cache *ctx_cache)
>  				continue;
>  			cd =3D rcu_dereference(p->perf_ctx_data);
>  			if (cd && !cd->global) {
> -				cd->global =3D 1;
> -				if (!refcount_inc_not_zero(&cd->refcount))
> +				if (refcount_inc_not_zero(&cd->refcount))
> +					cd->global =3D 1;

[Severity: High]
Does this introduce a TOCTOU race condition that can leak the perf_ctx_data
reference?

Earlier in attach_global_ctx_data(), the code checks if the task is exiting
without holding locks that exclude do_exit():

    if (p->flags & PF_EXITING)
        continue;

Could a task concurrently set PF_EXITING and call perf_event_exit_task(),
which then calls detach_task_global_ctx_data()?

If so, the exiting task would observe cd->global =3D=3D 0 via xchg(), miss =
the
cleanup, and return. Then this code continues, increments cd->refcount, and
sets cd->global =3D 1. Because the exiting task has already bypassed the
cleanup phase, it will never drop this reference. Once the task is unhashed,
__detach_global_ctx_data() will not find it, resulting in a permanent
memory leak of the perf_ctx_data structure.

A local user with perf_event_paranoid=3D2 might trigger this by racing
CPU-wide perf event creation with task exits.

[Severity: Medium]
Does this plain store to cd->global race with the atomic xchg() operation in
detach_task_global_ctx_data() from an exiting task?

Because perf_event_exit_task() executes without holding global_ctx_data_rws=
em,
these accesses appear unsynchronized, which violates the Linux Kernel Memory
Model and can lead to undefined behavior.

> +				else
>  					cd =3D NULL;
>  			}
>  			if (!cd) {

[ ... ]

> @@ -5569,19 +5570,33 @@ detach_task_ctx_data(struct task_struct *p)
>  		perf_free_ctx_data_rcu(cd);
>  }
> =20
> +/*
> + * Drop the reference owned by the system-wide events, if @p still holds=
 one.
> + *
> + * Both __detach_global_ctx_data() and perf_event_exit_task() may try to=
 drop
> + * it concurrently; claiming ->global with xchg() makes sure only one of=
 them
> + * does, otherwise the refcount is decremented twice.
> + */
> +static void detach_task_global_ctx_data(struct task_struct *p)
> +{
> +	struct perf_ctx_data *cd;
> +
> +	scoped_guard (rcu) {
> +		cd =3D rcu_dereference(p->perf_ctx_data);
> +		if (!cd || !xchg(&cd->global, 0))
> +			return;
> +	}
> +
> +	detach_task_ctx_data(p);
> +}

[ ... ]

> @@ -9459,8 +9474,8 @@ perf_event_alloc_task_data(struct task_struct *chil=
d,
>  		}
> =20
>  		if (!cd->global) {
> -			cd->global =3D 1;
>  			refcount_inc(&cd->refcount);
> +			cd->global =3D 1;

[Severity: Medium]
Similar to the concern in attach_global_ctx_data(), does this plain store
to cd->global race with the atomic xchg() operation from an exiting task in
detach_task_global_ctx_data()?

>  		}
>  	}
> =20

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179105852659.184484=
9.16381123619267169417@gmail.com?part=3D1
