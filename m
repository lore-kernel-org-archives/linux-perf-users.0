Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA513909A3
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 02:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784081157; cv=none; b=XnDjyObwHOBj4tfb7tt9sWsu2Y9LFlMVVKk+Xn1Wwiz4iqESeCoFNsxQWImpY1G0JgRMAcKy4/YVMz05z9mrPQb5VEdH7UYjfp7DU/anc2NrlB2dJ+fH2lBFZlF9MQMqpGdE/va2FMhkJiEbWAMJWO4UIn3ItorR3JYoI4Z8K6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784081157; c=relaxed/simple;
	bh=5aYUMjlnqiyiPw1k6U0pvLRuzEODqu4whcDF3Q/XOx0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WTBFr/Rxe8AZk97lCGl/TGGySQ8szKUAUJEaazbdwhcNh4sbTRyYIEsUK0Ws41T07KnRAOs/Hy0Wncqr6SCO7wuPom6wvndztbg1J4dKvIhExh3HFtl8O2ipWKYpgvQY5imCKH4tFDYNxpFTnQ7siJW1P2NpoRSoTEMUtga3Zs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHhp4NH6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHhp4NH6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8669A1F000E9;
	Wed, 15 Jul 2026 02:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784081155;
	bh=5aYUMjlnqiyiPw1k6U0pvLRuzEODqu4whcDF3Q/XOx0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dHhp4NH6mKwuQqzFyQUtGzvJDYzzsHtvGQuPREs21iq0Efau1JWn9kbcZRZLvD+Bq
	 7uJmqJ66PW0Cir0/H3bfqk9MRpKyaNZeY0jnC/Tt33L/JfbvyIlV9Ml+ase3YOrNun
	 rKOjHy0N3mdtT7CQkNgmuZNCtMijdBudhzoRlF6vUsdeQNoP4xr5lcVorZeLVvElVU
	 LD9GrDAY19FjXOmJn+NIkx6a7e8zpnt/ND9eebA/p6SnbGEDaDQuj66Yums3hQm2UY
	 HkaI3UmWKuX1G3Gdokiq+QtBh0vHAqDgnsxLO1VQeuI22zbPXNa1VdB+yuKF9ufqPi
	 bXxieqQ/8iGbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/10] tracing: wprobe: Add wprobe event trigger
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <178407994286.95826.437098855356129625.stgit@devnote2>
References: <178407983818.95826.12714571928538799781.stgit@devnote2>
 <178407994286.95826.437098855356129625.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 02:05:55 +0000
Message-Id: <20260715020555.8669A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [Critical] Deadlocks due to NMI-unsafe operations (schedule_work and raw_=
spin_lock_irqsave) in tracepoint context.
- [High] Missing cancel_work_sync() causes a Use-After-Free of wprobe_trigg=
er_data via the workqueue.
- [High] Synchronous free of wprobe_data violates RCU removal ordering, ris=
king concurrent use-after-free.
- [High] Missing trace_event_try_get_ref() and imbalanced trace_event_put_r=
ef() cause module refcount underflow.
- [High] on_each_cpu is called with wait=3Dfalse for an IPI that references=
 wprobe_data.
- [High] Immediate kfree() of RCU-protected trigger_data and wprobe_data on=
 the error path.
- [Medium] Permanent memory leak of wprobe trigger objects on successful re=
gistration.
- [Medium] tw->addr is read and written concurrently by different triggers =
without a shared lock.
--

--- Patch [9]: [PATCH v7 09/10] tracing: wprobe: Add wprobe event trigger -=
--
The format of this report is altered due to recitation restrictions.
I am providing a free-form summary of the findings rather than inline
quoting the patch.

Commit: 4087513c82b11b98d27cfc4452df9a1a8e41ddd5
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Subject: tracing: wprobe: Add wprobe event trigger

This patch adds a wprobe event trigger to set and clear watch events
dynamically, allowing watchpoints on local variables and slab objects.

[Severity: Critical]
Is it safe to call raw_spin_lock_irqsave() and schedule_work() directly
from wprobe_trigger()? Tracepoints can execute in arbitrary contexts,
including NMI or with scheduler locks held. Calling schedule_work() is
unsafe in these contexts. Additionally, acquiring wprobe_data->lock here
can cause a hard deadlock if the tracepoint interrupts wprobe_smp_update_fu=
nc()
while it is holding the exact same lock in IPI context.

[Severity: High]
Does free_wprobe_trigger_data() safely handle the embedded work struct?
When a trigger is unregistered, this function frees wprobe_data via kfree().
If wprobe_trigger() recently scheduled wprobe_data->work, the workqueue
could execute wprobe_work_func() on the freed memory since there is no
cancel_work_sync() before freeing.

[Severity: High]
Is an RCU grace period needed in wprobe_trigger_free()?
wprobe_unregister_trigger() unlinks the trigger and calls
wprobe_trigger_free(), which synchronously frees wprobe_data. Since
tracepoints execute under RCU, could a concurrent tracepoint execution
still be accessing wprobe_data when it gets freed?

[Severity: High]
Can the error path in wprobe_trigger_cmd_parse() cause a use-after-free?
If event_trigger_register() successfully exposes the trigger to RCU
readers but a subsequent step fails, returning an error causes the
__free(kfree) cleanup to immediately free trigger_data and wprobe_data.
This bypasses any RCU grace period for objects that were just briefly
exposed to concurrent tracepoint readers.

[Severity: High]
Is it intentional that on_each_cpu() is called with wait=3Dfalse in
wprobe_work_func()? Because it doesn't wait, the work function completes
immediately while IPIs are still pending on other CPUs. If the trigger
is unregistered and freed right after, wprobe_smp_update_func() will
access freed wprobe_data.

[Severity: High]
Does wprobe_trigger_cmd_parse() acquire the target event's module
reference? The code calls trace_event_enable_disable() directly without
first calling trace_event_try_get_ref(). However, wprobe_trigger_free()
unconditionally calls trace_event_put_ref(), which could lead to a module
refcount underflow.

[Severity: Medium]
Is there a memory leak on the success path of wprobe_trigger_cmd_parse()?
The function increments the refcount via event_trigger_init(), and then
event_trigger_register() increments it again. On success, trigger_data
is set to NULL to bypass the cleanup macro, but the initial refcount is
never dropped. When the trigger is later unregistered, the refcount only
drops to 1, permanently leaking the objects.

[Severity: Medium]
How is concurrent access to tw->addr synchronized between different
triggers? If a user attaches multiple triggers (e.g., set_wprobe and
clear_wprobe) targeting the same wprobe event, they allocate separate
wprobe_data instances with independent locks. When wprobe_trigger()
executes, they will read and write the shared tw->addr simultaneously
without a common lock, potentially corrupting the hardware breakpoint state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178407983818.95826.=
12714571928538799781.stgit@devnote2?part=3D9
