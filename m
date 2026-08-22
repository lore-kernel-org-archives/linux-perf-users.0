Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640591EEA3C;
	Sat, 22 Aug 2026 06:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787378416; cv=none; b=qEAkBeZC87skSR+6sxJcFiFXntnEiQxxC/A4vFj3wUNMnyC8uj/k+NsHujCU2Epf/7hz/KCXjW+zLNPXxN00gBAQxfmzCxovJBQyixRqjuHAuJ32jfKylwsBqMKl8fu8OS2CAWdTzcIfJXjtB7+y41vmQUAlUeGFWmh1iNgKVmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787378416; c=relaxed/simple;
	bh=u1RXvJjlkVzgCa8b04YpPNoqLTjYJWFUpo9T11nvSRg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jEKseXUzF8+leOZ7ND/tghEt8ZtVQWE72vSkV2OlalSrBOHhVO0G5TKiZ2N6d4a+H8qdJ6AOGrwhmpzKzuQ6hUY4n7n8vStNCHLZ6JBf0t/Xmr3hs4+55fDibtLIo/SBS72/aUfBLhadG2ReBUfT5dgDYW3qSqNQo7yHgPDf6sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJJ74vuB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJJ74vuB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2681F000E9;
	Sat, 22 Aug 2026 06:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787378414;
	bh=nuQRz7XSdo+LOgLhCTDCCVvAB8de6h4+p2G9QhdPqpI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PJJ74vuB2atV9SrjoJj9QhpbobcmGen1KYYgey7xqL8ka9/pbY6Ucvpbz3iN52HY6
	 KeL4WjAX06LVh24gyiV45ip+k0jH5MlEGb8CzvQXi191gK+VsRLNwiWvK74lolR1be
	 Ms/9Q8/SBACjOxGBbm+kGNrABrNi373MUJ+UlWR6QoEqDUh676Ce3gEptAJm57lYWZ
	 zn+W3W0qDQmshecqm3JdfgSfpu0AoYp/tEP97PK86Ec9NhxfDrNu1m1E4piFq3Mt3x
	 Yr0j3zoqLw/78o4FOxYR/g1Nj1uaDXtXhxFU5CACiZYEzotIoSeMk+TKKrTnhKLYM1
	 7vNpmB4ZvMhSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] uprobes: Free utask on dup_return_instance() failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Keke Ming" <ming.jvle@gmail.com>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260822054620.452262-1-ming.jvle@gmail.com>
References: <20260822054620.452262-1-ming.jvle@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 06:00:14 +0000
Message-Id: <20260822060014.AD2681F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Double free of `extra_consumers` during `fork()` due to missin=
g pointer nullification in `dup_return_instance()` / `ri_pool_push()`.
--

--- Patch [1]: [PATCH] uprobes: Free utask on dup_return_instance() failure=
 ---
commit 52bd4caeb5b9686b25fe707609034e9397c6100a
Author: Keke Ming <ming.jvle@gmail.com>

uprobes: Free utask on dup_return_instance() failure

dup_utask() installs the new uprobe_task in t->utask before copying
return_instances. If dup_return_instance() fails, the partially copied
utask is left attached to the child task. This patch frees the partially
copied utask before returning -ENOMEM.

> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 7709ea8824778..7547929ab294d 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -2140,8 +2140,10 @@ static int dup_utask(struct task_struct *t, struct=
 uprobe_task *o_utask)
>  	p =3D &n_utask->return_instances;
>  	for (o =3D o_utask->return_instances; o; o =3D o->next) {
>  		n =3D dup_return_instance(o);
> -		if (!n)
> +		if (!n) {
> +			uprobe_free_utask(t);

[Severity: Critical]
This is a pre-existing issue, but can dup_return_instance() leave a dangling
pointer that results in a double free of extra_consumers when
uprobe_free_utask() is called here?

If a multi-consumer uretprobe is hit, extra_consumers is allocated. When th=
is
returns, it is pushed to the reuse pool:

kernel/events/uprobes.c:ri_pool_push() {
    ri->cons_cnt =3D 0;
    ri->next =3D utask->ri_pool;
    utask->ri_pool =3D ri;
}

This resets cons_cnt to 0 but retains the extra_consumers heap pointer.

If the thread then hits a single-consumer uretprobe, alloc_return_instance()
reuses the pooled object. push_consumer() increments cons_cnt to 1 and uses
the inline consumer, leaving the old extra_consumers pointer untouched.

When the task calls fork(), dup_return_instance() does a shallow copy:

kernel/events/uprobes.c:dup_return_instance() {
    ri =3D kmemdup(old, sizeof(*ri), GFP_KERNEL);
    if (!ri)
        return NULL;

    if (unlikely(old->cons_cnt > 1)) {
        ri->extra_consumers =3D kmemdup(old->extra_consumers, ...
    ...
}

Since old->cons_cnt =3D=3D 1, it skips deep-copying or clearing extra_consu=
mers.
Both the parent and child tasks now share the exact same heap pointer.=20

When the tasks exit, or if dup_return_instance() fails and triggers the new
cleanup path in this patch, ri_free() will execute kfree(ri->extra_consumer=
s)
in both contexts, freeing the same memory twice.

>  			return -ENOMEM;
> +		}
> =20
>  		/* if uprobe is non-NULL, we'll have an extra refcount for uprobe */
>  		uprobe =3D hprobe_expire(&o->hprobe, true);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822054620.4522=
62-1-ming.jvle@gmail.com?part=3D1
