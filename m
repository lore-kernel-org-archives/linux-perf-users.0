Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A7D3AD53D
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 13:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784294346; cv=none; b=TukcrANQPhtLlAHAomUNqUtHEyJTBn7qh3Sy4zApB7gTS8qXpkxWCyCrtDjGHeWJAVi+SUtbszPVhbgh+6l38IGpWvmH15CH4aTWWWtD02CdgkIU89eEX0erjAIWGVhDGJFLDYg0KTuxHxs4LKoRjBlrGztSfQgtz44T2HW0FIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784294346; c=relaxed/simple;
	bh=+sVczpF0mXJOtMM0VZBHTZyj1dG5TwJpMti+IcVJSIM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eRES6URplhfxiOlnKZn6QtfGuezsmD45Fq25eEb2Mh8A4i+diz2W45vVPaM7isyfTaaTMUMQZ2MEY5Et1z6DrNuYA3/OnsloVRFIGHSqLMmEf9VYFRY2O8WR+yCJX7qa3SpHdpTddVHZci6K8y7PQ0TVxmCNv23HtX8leGtJ+/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlmdaUhv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlmdaUhv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864991F000E9;
	Fri, 17 Jul 2026 13:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784294344;
	bh=fFK8HpCSo6lFAiHK9bNyH+Ld0d0yKGx2h4wxQ/YkRrY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NlmdaUhvX2zY6VqONuudVCaMh5TulfBZDCL4lJlt2OV9vXwU0Wf5nAXvmIrwnzsaB
	 BhkRmDBOAxWuXRGg8tDHQBdX/uTExnFS2c9I7IjO5fkHD5ak5WsQocdQ53Z21t/rXE
	 iIWM7YmrNLtL3P2Sr8WAz0+2vAnrzjHktcDpVlZPF5BSoogau8UCE55N3e/LPLuBW9
	 vUGG1mZmRKe5sostK7lY7ssgXqU8HDk3NQ4KELMz6ueFisf0U/+Yj5cnA6amyLanA4
	 lSILagC9PMXaAcP9mZwm6oXe/ETj1t7XOmKpUhUPu77vpdvOqxSm56nAcs7vVXGfyc
	 Xzg0BbhRJ2Few==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 06/13] mm/kwatch: add lockless per-task context
 pool
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinchao Wang" <wangjinchao600@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260717130430.1902527-1-wangjinchao600@gmail.com>
References: <20260717125023.1895892-1-wangjinchao600@gmail.com>
 <20260717130430.1902527-1-wangjinchao600@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 13:19:04 +0000
Message-Id: <20260717131904.864991F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] Concurrent lockless accesses to the global `kwatch_ctx_pool` l=
ack RCU or READ_ONCE protection, leading to Use-After-Free or NULL pointer =
dereferences.
- [High] NMI reentrancy between slot claim and release causes premature rel=
ease, double free, and cross-task data corruption.
- [High] Hash table lookup degenerates to an unconditional O(N) full array =
scan on negative lookups, causing massive NMI latency.
- [High] Context slots permanently leak if a task exits abruptly, causing s=
tate corruption and ABA problems when the task_struct is reallocated.
- [High] Missing release/acquire memory barriers when dynamically publishin=
g `kwatch_ctx_pool` expose lockless readers to uninitialized state and UB.
- [Medium] Large contiguous memory allocation with kcalloc() risks frequent=
 failure on fragmented systems.
--

--- Patch [6]: [RFC PATCH v2 06/13] mm/kwatch: add lockless per-task contex=
t pool ---
commit 48d8ef7e220842e6317681d38fcc2886436cae7d
Author: Jinchao Wang <wangjinchao600@gmail.com>

mm/kwatch: add lockless per-task context pool

A task that enters the watched function needs somewhere to keep its
window state (nesting depth, owned watchpoint, config epoch). The
lookup runs in kprobe and NMI-like contexts, so it must not allocate
or take locks.

> diff --git a/mm/kwatch/task_ctx.c b/mm/kwatch/task_ctx.c
> new file mode 100644
> index 0000000000000..64383a4429e7c
> --- /dev/null
> +++ b/mm/kwatch/task_ctx.c

[ ... ]

> @@ -0,0 +1,125 @@
> +int kwatch_tsk_ctx_prealloc(u16 max_concurrency)
> +{
> +	if (max_concurrency < KWATCH_CTX_POOL_MIN)
> +		max_concurrency =3D KWATCH_CTX_POOL_MIN;
> +	else if (max_concurrency > KWATCH_CTX_POOL_MAX)
> +		max_concurrency =3D KWATCH_CTX_POOL_MAX;
> +
> +	/*
> +	 * Set the size/mask only when actually allocating, so they can never
> +	 * drift out of sync with the live pool if prealloc is ever called
> +	 * again without a matching free.
> +	 */
> +	if (unlikely(!kwatch_ctx_pool)) {
> +		kwatch_ctx_pool_size =3D roundup_pow_of_two(max_concurrency);
> +		kwatch_ctx_pool_mask =3D kwatch_ctx_pool_size - 1;
> +
> +		kwatch_ctx_pool =3D kcalloc(kwatch_ctx_pool_size,
> +					  sizeof(struct kwatch_tsk_ctx),
> +					  GFP_KERNEL);

[Severity: Medium]
Does this allocation risk frequent failure on fragmented systems?

In kwatch_tsk_ctx_prealloc(), this uses kcalloc with GFP_KERNEL to allocate=
 up
to 32768 elements of struct kwatch_tsk_ctx. Such large physically contiguous
allocations are highly prone to failure when memory is fragmented.

Would using kvcalloc be more appropriate here to allow fallback to
non-contiguous virtual memory mappings?

[Severity: High]
Are there missing memory barriers here when publishing kwatch_ctx_pool?

In kwatch_tsk_ctx_prealloc(), kwatch_ctx_pool_size is initialized before
dynamically assigning kwatch_ctx_pool. Without smp_store_release, the CPU
could reorder these stores.

If a concurrent reader in kwatch_tsk_ctx_get() evaluates !kwatch_ctx_pool
without smp_load_acquire, could it observe kwatch_ctx_pool !=3D NULL but re=
ad a
stale value of 0 for kwatch_ctx_pool_size? This would result in ilog2(0),
which returns -1, and cause a bitshift overflow when passed to hash_ptr().

> +		if (!kwatch_ctx_pool)
> +			return -ENOMEM;
> +	}
> +	return 0;
> +}
> +
> +struct kwatch_tsk_ctx *kwatch_tsk_ctx_get(bool can_alloc)
> +{
> +	int start_idx, i, idx;
> +	struct task_struct *t;
> +
> +	if (unlikely(!kwatch_ctx_pool))
> +		return NULL;
> +
> +	start_idx =3D hash_ptr(current, ilog2(kwatch_ctx_pool_size));
> +
> +	for (i =3D 0; i < kwatch_ctx_pool_size; i++) {
> +		idx =3D (start_idx + i) & kwatch_ctx_pool_mask;

[Severity: High]
Does this loop cause significant NMI latency?

In kwatch_tsk_ctx_get(), because the open-addressing hash table nullifies t=
he
task pointer instead of using tombstones for deletions, it cannot stop prob=
ing
when encountering an empty slot.

On every cache miss, such as when a task first triggers a watchpoint, this
loop unconditionally iterates kwatch_ctx_pool_size times to ensure the task
is not already present. Is it safe to perform an O(N) scan in NMI context?

> +		t =3D READ_ONCE(kwatch_ctx_pool[idx].task);
> +		if (t =3D=3D current)
> +			return &kwatch_ctx_pool[idx];

[Severity: High]
Could this falsely match a new task to a dead task's leaked slot?

In kwatch_tsk_ctx_get(), if a task exits abruptly due to a fatal signal and
bypasses the return probe, it will fail to call kwatch_tsk_ctx_put(), leavi=
ng
the slot assigned to the dead task_struct pointer.

When the slab allocator reuses the freed memory for a new task, the new tas=
k's
current pointer would match this leaked slot. Will the new task erroneously
inherit stale state and potentially trigger a use-after-free on the dangling
watchpoint?

> +	}
> +
> +	if (!can_alloc)
> +		return NULL;
> +
> +	for (i =3D 0; i < kwatch_ctx_pool_size; i++) {
> +		idx =3D (start_idx + i) & kwatch_ctx_pool_mask;
> +		t =3D READ_ONCE(kwatch_ctx_pool[idx].task);
> +		if (!t) {
> +			if (!cmpxchg(&kwatch_ctx_pool[idx].task, NULL, current))
> +				return &kwatch_ctx_pool[idx];

[Severity: High]
Can an NMI interrupting this path cause a premature release or double free?

In kwatch_tsk_ctx_get(), this lockless claim publishes ownership before the
caller can establish safe nesting state. If an NMI interrupts the task
immediately after this claim, enters a watch window, and reclaims the same
slot because t =3D=3D current, it will unconditionally call kwatch_tsk_ctx_=
put()
when exiting the watch window.

This releases the slot by writing NULL to ctx->task. When the interrupted t=
ask
resumes, it will incorrectly assume ownership of a now-freed slot that might
be claimed by another CPU. Is there a way to prevent this reentrancy issue?

> +		}
> +	}
> +
> +	return NULL;
> +}

[ ... ]

> +void kwatch_tsk_ctx_free(void)
> +{
> +	kfree(kwatch_ctx_pool);
> +	kwatch_ctx_pool =3D NULL;

[Severity: High]
Does this create a use-after-free regression?

In kwatch_tsk_ctx_free(), kfree is called directly on kwatch_ctx_pool follo=
wed
by assigning it to NULL, without any RCU synchronization.

If an NMI or task concurrently executes kwatch_tsk_ctx_get(), won't it
dereference the freed memory? Additionally, since kwatch_tsk_ctx_get()
evaluates kwatch_ctx_pool in loops without READ_ONCE, could the compiler
reload the global pointer after it is set to NULL, causing a NULL pointer
dereference?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717125023.1895=
892-1-wangjinchao600@gmail.com?part=3D6
