Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3549A37F001
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 10:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775644718; cv=none; b=epaHuJmJ7hTzsO1cFEZWlZAsYiVNu8KZ4AphiZnOIOvCBdPtHq9EN1zvb02z6s9cjAfxMMLlzL39rxTJuJduCOQilm191bVBlKEBphvMAGt22paNuPZVeWjpznPZZzpuv9oDbHDFGiTe949YV3ASVsRCFL0MTD0R2XpmM1L8LXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775644718; c=relaxed/simple;
	bh=ZNRfdfcvmTbE8i+BxtuSLEg/QV3fSYHJmUwx2O+Qlqg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qFgt2Lf+WyEIPLS+zPeeAk2RQrymQxQEP9VLXYnkJPM7E+ZTOwNX5r1oiQefkRj6yP6chfkwXEebyUG9oPKpxlkyBAY17YoPSnoBHLtNhmsSuZBLPZOnnKebRQfNpkCBNBg8k2o223tFE8kG6M8QoI5fiBeuVnfXk0VI0rRTB5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhMZvuMk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhMZvuMk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89D3C19421;
	Wed,  8 Apr 2026 10:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775644717;
	bh=ZNRfdfcvmTbE8i+BxtuSLEg/QV3fSYHJmUwx2O+Qlqg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=fhMZvuMkjP5a6tgwCqPkT+bkQPwGzUjVnE0lRaixCxk6yGaNQaPI84428t03K3jZc
	 D4fV7+npnOD7/EzfXQDWsx8bFRoEh3SwKJwWPb/1fF6Mrq0Zov8OvwoK7jA00RFPWO
	 ESdpd+8m3l0aN3zzo7svQIrZfUyL9ivcFmUp+32ciYRI/28jyD7PFc9zAEPlq557Oc
	 qBhu0BvXrVERbCKYqworl2s5sxyLxt5viG5nhZ9Q/yla8sHZPlNLv40c8k5vK+MULn
	 jqjtO0Ph3GAWQjhUv8aIIQfBFov8spr7RM3BB3C0Z/Lh5YtntJyURu8Flui+Z5PSq7
	 yofFxssX2NaYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] uprobes: clear extra_consumers before pooling return
 instances
Reply-To: sashiko@lists.linux.dev
To: "Keenan Dong" <keenanat2000@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260408100247.2065245-1-keenanat2000@gmail.com>
References: <20260408100247.2065245-1-keenanat2000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Apr 2026 10:38:37 +0000
Message-Id: <20260408103837.B89D3C19421@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Critical] Missing full memory barrier in `ri_timer` allows Store-Load re=
ordering, causing a race condition with `free_ret_instance` that can lead t=
o Use-After-Free or uprobe corruption.
--

commit 892d89a5acfb2bb4da3888666af1d58594ed9e7d
Author: Keenan Dong <keenanat2000@gmail.com>

uprobes: clear extra_consumers before pooling return instances

This commit clears the extra_consumers array and frees its memory before
pushing a return_instance back to the per-task pool. This prevents a
potential double free if a recycled object retains a stale pointer from
its previous lifetime.

> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 4084e926e2844..4695cb812fe26 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
[ ... ]
> @@ -1945,6 +1945,8 @@ unsigned long uprobe_get_trap_addr(struct pt_regs *=
regs)
> =20
>  static void ri_pool_push(struct uprobe_task *utask, struct return_instan=
ce *ri)
>  {
> +	kfree(ri->extra_consumers);
> +	ri->extra_consumers =3D NULL;
>  	ri->cons_cnt =3D 0;
>  	ri->next =3D utask->ri_pool;
>  	utask->ri_pool =3D ri;

While looking at how return instances are recycled into the pool here, I
noticed a potential race condition in the pre-existing code involving
ri_timer() and free_ret_instance().

In uprobes.c, ri_seqcount is used in a two-way synchronization pattern
between free_ret_instance() and ri_timer().

In free_ret_instance(), the task unlinks ri, executes hprobe_consume()
(which contains a full memory barrier via xchg()), and then reads
ri_seqcount via raw_seqcount_try_begin().

In ri_timer(), the timer asserts its presence by incrementing the seqcount
via raw_write_seqcount_begin(), and then iterates over
utask->return_instances.

For this mutual exclusion to work, both sides require a full memory barrier.
However, raw_write_seqcount_begin() only provides a write barrier
(smp_wmb()), which does not prevent Store-Load reordering.

Could this allow the timer CPU to execute the load of
utask->return_instances before the store to ri_seqcount.sequence becomes
globally visible?

If this reordering occurs, the following sequence seems possible:

1. ri_timer() reads a pointer to ri and stalls.
2. The task unlinks ri, executes its full barrier, reads the even seqcount,
   and pushes ri to ri_pool.
3. The task then quickly reuses ri for a new uretprobe, setting
   hprobe->state =3D HPROBE_LEASED.
4. ri_timer() resumes and executes try_cmpxchg() on hprobe->state.

Because the state is HPROBE_LEASED again, the cmpxchg succeeds. It
transitions the new uprobe's state to STABLE, dropping the SRCU lock.
When the task later consumes the new uprobe, it will call put_uprobe()
without a matching get_uprobe().

Can this sequence lead to a premature refcount drop and use-after-free
of the new uprobe?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260408100247.2065=
245-1-keenanat2000@gmail.com?part=3D1
