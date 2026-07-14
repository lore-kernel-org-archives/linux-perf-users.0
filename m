Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA3341A904
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 18:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054666; cv=none; b=SYIPu185wgcpZ/rTdEtWKksFaHitf15qi1OXrIBJWxgon7UAmhZeL+8hZYR55cumLkESux0qQS5BrhnF11FC/oKiL6yUFTIv7SiSuY+hzcQVnDp+F15vsEio4DC878kw92k9xSpm8Fy9B9gQ4G3ijmCBGuctZ46gIyUKL8a4XH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054666; c=relaxed/simple;
	bh=sO3qfFPooormCexd/iodbHQwGwwIro/GtOzOMmD68o4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U+npi6f1ev2FgphSXyEJ3JOtNAUxREKRe/c6aLC5MzvC4iX4i8d9HuhKwKHElYG8oPKK+mUdwtKj+kh9fqXPMw/a0bfVl8fyAXUANQBelGAfl1vJfKgOTqerlrib/QirIEO0kTqndVOXLzV2TV2xz6VKYYAgWDj18I657wZcHRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mn93qyk7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mn93qyk7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5E31F000E9;
	Tue, 14 Jul 2026 18:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784054664;
	bh=saEriOt5g9EOI1zDThgemoHo5Dz2ZwPSUladKrIypfU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mn93qyk7u8HqK1HJguvYqBZiYweRxlyqEhKDTLQZF726rykGaGcBnRAR16YxgcI8O
	 9MsRwr1zXw5yNN0DTgC7/63rk+9FbuuzWyAxOijR1BHci5t4PqIo+DWRBbmSF5y6/N
	 hQsTrbC6r/DKgX+btufGd7s8J3Jdx7IKavOyyeYzwPBbk5YtxmvNRRrpOppFbsqvO0
	 Np8IQ1yFF25H7rCwHYr6tgIA4fu0IFKH12bU3INCeCo3/sSlRC4J/uCBJtgiomSF4C
	 EAtTEeUqgnmSwqFja4sSfGrJUfe4jL2K17xAAGvrGQkS3Iz8B1D5l79IOA8UJ5dGpO
	 tk9lVHWD0AiJA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 06/13] mm/kwatch: add lockless per-task context pool
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinchao Wang" <wangjinchao600@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260714183129.12542-1-wangjinchao600@gmail.com>
References: <20260714182243.10687-1-wangjinchao600@gmail.com>
 <20260714183129.12542-1-wangjinchao600@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 18:44:24 +0000
Message-Id: <20260714184424.8D5E31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] NMI/IRQ reentrancy during context allocation and release causes sh=
ared context corruption and Use-After-Free.
- [High] `kwatch_tsk_ctx_free` frees the context pool without RCU synchroni=
zation, causing a Use-After-Free.
- [High] `kwatch_tsk_ctx_prealloc` unconditionally updates global size boun=
ds without reallocating, causing Out-Of-Bounds accesses.
- [High] `kwatch_ctx_pool_size` truncates large inputs to 0, causing `ZERO_=
SIZE_PTR` dereferences and shift-by-64 Undefined Behavior.
- [High] The context pool stores un-refcounted task pointers, leading to st=
ate hijacking if a task exits abruptly (ABA problem).
--

--- Patch [6]: [RFC PATCH 06/13] mm/kwatch: add lockless per-task context p=
ool ---
commit 70e01018388f64f2db26eb6d33251317f890288b
Author: Jinchao Wang <wangjinchao600@gmail.com>

mm/kwatch: add lockless per-task context pool

This patch introduces a lockless per-task context pool for kwatch to=20
track task window states in NMI/kprobe contexts without allocating or=20
taking locks. It uses an open-addressing array hashed by task_struct=20
pointer, claiming slots with cmpxchg() and releasing with=20
smp_store_release().

> diff --git a/mm/kwatch/task_ctx.c b/mm/kwatch/task_ctx.c
> new file mode 100644
> index 0000000000000..f8e582f0dcfe9
> --- /dev/null
> +++ b/mm/kwatch/task_ctx.c
> @@ -0,0 +1,105 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/slab.h>
> +#include <linux/hash.h>
> +#include <linux/sched.h>
> +#include <linux/log2.h>
> +#include "kwatch.h"
> +
> +static u16 kwatch_ctx_pool_size;
> +static u16 kwatch_ctx_pool_mask;
> +
> +static struct kwatch_tsk_ctx *kwatch_ctx_pool;
> +
> +int kwatch_tsk_ctx_prealloc(u16 max_concurrency)
> +{
> +	if (!max_concurrency)
> +		max_concurrency =3D 256;
> +
> +	kwatch_ctx_pool_size =3D roundup_pow_of_two(max_concurrency);
> +	kwatch_ctx_pool_mask =3D kwatch_ctx_pool_size - 1;

[Severity: High]
Does this code silently truncate the pool size and cause undefined behavior?

If max_concurrency > 32768, roundup_pow_of_two() will return 65536, which g=
ets=20
truncated to 0 when assigned to the u16 kwatch_ctx_pool_size.=20

If this happens, kcalloc(0, ...) bypasses the allocation check by returning=
=20
ZERO_SIZE_PTR (0x10). Later, calling ilog2(0) in kwatch_tsk_ctx_get() evalu=
ates=20
to -1, which results in a shift by 65 in hash_ptr().=20

Also, if max_concurrency is 1, ilog2(1) evaluates to 0, which would result =
in=20
a shift by 64 in hash_ptr(). Both cases trigger undefined behavior.

> +
> +	if (unlikely(!kwatch_ctx_pool)) {

[Severity: High]
Can calling this function multiple times lead to out-of-bounds accesses?

If kwatch_tsk_ctx_prealloc() is called again with a larger max_concurrency,=
=20
kwatch_ctx_pool_size and kwatch_ctx_pool_mask will be updated to the larger=
=20
values. However, since kwatch_ctx_pool is already non-NULL, the array won't=
 be=20
reallocated. Subsequent lookups will use the new, larger mask to calculate=
=20
indices, potentially accessing unallocated memory past the end of the origi=
nal=20
array.

> +		kwatch_ctx_pool =3D kcalloc(kwatch_ctx_pool_size,
> +					  sizeof(struct kwatch_tsk_ctx),
> +					  GFP_KERNEL);
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
> +		t =3D READ_ONCE(kwatch_ctx_pool[idx].task);
> +		if (t =3D=3D current)

[Severity: High]
Could this raw address comparison match a completely different task?

Since the task pointers aren't refcounted, if a task is killed (e.g., via=20
SIGKILL) while inside a watched function, it exits without calling=20
kwatch_tsk_ctx_put(). Its task_struct is eventually freed, but the raw memo=
ry=20
address is left dangling in kwatch_ctx_pool[idx].task.

If a new task is spawned and its task_struct is allocated at the exact same=
=20
memory address, kwatch_tsk_ctx_get() will find a false match here. The new=
=20
task will unintentionally inherit the dead task's depth and epoch state.

> +			return &kwatch_ctx_pool[idx];
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

[Severity: High]
Can an NMI interrupting this path corrupt the context slot?

If an NMI interrupts the current task immediately after this cmpxchg() succ=
eeds,=20
the NMI handler might call kwatch_tsk_ctx_get(), find the same slot (since=
=20
t =3D=3D current), use it, and call kwatch_tsk_ctx_put().

kwatch_tsk_ctx_put() will then unconditionally set ctx->task to NULL:

    smp_store_release(&ctx->task, NULL);

When the NMI returns, the interrupted task resumes thinking it owns the slo=
t,=20
but the slot is now marked free and can be claimed by another task on anoth=
er=20
CPU, leading to concurrent modification of the same context.

> +				return &kwatch_ctx_pool[idx];
> +		}
> +	}
> +
> +	return NULL;
> +}

[ ... ]

> +void kwatch_tsk_ctx_free(void)
> +{
> +	kfree(kwatch_ctx_pool);

[Severity: High]
Does this code trigger a use-after-free if tasks are actively being watched?

If kwatch_tsk_ctx_free() is called on one CPU while another task (or NMI)=20
is inside kwatch_tsk_ctx_get() reading kwatch_ctx_pool on another CPU,=20
kfree() frees the memory immediately without waiting for an RCU grace perio=
d.=20
The lockless reader will then dereference the freed memory.

> +	kwatch_ctx_pool =3D NULL;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714182243.1068=
7-1-wangjinchao600@gmail.com?part=3D6
