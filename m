Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AB5331237
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 13:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784294402; cv=none; b=I5gsV+D4DgXLgQjaBvVGIRlP8MD+SbwD9fX9AzrmTWprdaJ5XSxBlS3Yoqgp9ouduyTpYPcrXLOF2CC3n0GlRt19oLG9OgB4l1R9McUMiqhH+hgrZHCd68/tkL18CpoQ9nrMi4tD5tB8sBGUNy9pNOTli7LMg6SEocW3FKhFIbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784294402; c=relaxed/simple;
	bh=gIXYCKjf2LRy1GtqaPUtPJChTHUgTimSHa0tqUH12vU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SagVHXbO/wpk4RMsx72KFRKqzE3GODfLoAMpF0G0VC2VEzMUDP5NRaVfQr4TVh5IOHSYOImDArauMBePriH0QBWfXFL+HrdxUvG2tuuZ810i98+6ZAgsuPr1svbJ9Eew0/3YklyVzypJ5kt1rfxulxQfvw+4ioG/cWbSLsPXN6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJQGIPJb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJQGIPJb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61631F000E9;
	Fri, 17 Jul 2026 13:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784294401;
	bh=DEFC0yPFG9Sv+0V4uB57+RawlzhclNz4QgTAafV0AfU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hJQGIPJbs92YHYbHbak7qBveGNqHiGw2MAvzbpjp8qnnScfiDJZpAZ7lKgyhreGYt
	 urOoJT5Xqpk1fJzmR++Lt1qqNXV4qXTrjdYGXiYWQ5XWz8naJtLQUbGfHac9hzwEts
	 hVcHl1ufx9tdv0j67BhPn6CFWS1ZepkTRa01trCHffyKsXO2XcmITK/t1bQkejyBLn
	 1zSkoldKulSFXDFsoqtAtrgwD904LuQvd4cgslGO8+ca6UdRX+K4ad/WRlZ8v0j1UF
	 cS7btCYT7XcqgqTkrZwigsfIMkNPItUru7uKYkFGduN723ghzM3qBRKNGdiHhSSiY4
	 M62wPSFmxd1mg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 09/13] mm/kwatch: add probe lifecycle runtime
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinchao Wang" <wangjinchao600@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260717130544.1903146-1-wangjinchao600@gmail.com>
References: <20260717125023.1895892-1-wangjinchao600@gmail.com>
 <20260717130544.1903146-1-wangjinchao600@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 13:20:00 +0000
Message-Id: <20260717132000.D61631F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] Use-After-Free and data race in `kwatch_probe_validate_hit()` =
during session teardown.
- [High] Mid-function offset kprobes incorrectly inherit NMI context reject=
ion, bypassing safety policies.
- [High] Tasks terminating abnormally leak hardware watchpoints and cause p=
ointer ABA vulnerabilities in the lockless context pool.
- [Medium] Race condition causing false NMI context rejections due to unini=
tialized delivery flag.
- [Low] Unused macro definition `TRAMPOLINE_CHECK_DEPTH`.
--

--- Patch [9]: [RFC PATCH v2 09/13] mm/kwatch: add probe lifecycle runtime =
---
commit 4c4a554ca5428e6d0dbf3c8593ac5647b9e7d585
Author: Jinchao Wang <wangjinchao600@gmail.com>
Subject: mm/kwatch: add probe lifecycle runtime

This commit introduces the probe lifecycle runtime for the watch window usi=
ng a
kretprobe. It handles function entry and exit, tracks nesting depth to mana=
ge
hardware watchpoints, and includes logic for NMI rejection and epoch versio=
ning.

> diff --git a/mm/kwatch/probe.c b/mm/kwatch/probe.c
> new file mode 100644
> index 0000000000000..249aa50c9f782
> --- /dev/null
> +++ b/mm/kwatch/probe.c
> @@ -0,0 +1,275 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/atomic.h>
> +#include <linux/kprobes.h>
> +#include <linux/kallsyms.h>
> +#include <linux/percpu.h>
> +#include <linux/preempt.h>
> +#include <linux/sched.h>
> +
> +#include "kwatch.h"
> +#define TRAMPOLINE_CHECK_DEPTH 16

[Severity: Low]
Is this macro used anywhere in the codebase?

[ ... ]

> +static void kwatch_pin_post_handler(struct kprobe *p, struct pt_regs *re=
gs,
> +				    unsigned long flags)
> +{
> +	/* a post_handler pins the probepoint: no jump optimization */
> +}
> +
> +bool kwatch_probe_validate_hit(struct pt_regs *regs,
> +			       struct task_struct *arm_tsk)
> +{
> +	struct kwatch_tsk_ctx *ctx =3D kwatch_tsk_ctx_get(false);
> +	const struct kwatch_config *cfg =3D kwatch_probe_ctx.cfg;

[Severity: Critical]
If a session is stopped, kwatch_probe_stop() resets the epoch but does not
synchronously disarm hardware watchpoints for tasks still executing inside =
the
probed function.

Could a leftover watchpoint firing later cause this handler path to lockles=
sly
dereference a freed cfg pointer?

Additionally, if a new session starts concurrently, kwatch_probe_start()
clears the context via memset:

kwatch_probe_start() {
    ...
    memset(&kwatch_probe_ctx, 0, sizeof(kwatch_probe_ctx));
    ...
}

Might this result in a torn or null pointer dereference here if a hardware
watchpoint fires during the memset?

[ ... ]

> +static int kwatch_activate_handler(struct kprobe *p, struct pt_regs *reg=
s)
> +{
> +	struct kwatch_tsk_ctx *ctx =3D kwatch_tsk_ctx_get(false);
> +	unsigned long watch_addr;
> +	u16 watch_len;
> +
> +	if (unlikely(!ctx))
> +		return 0;
> +
> +	if (unlikely(kwatch_probe_is_muted()))
> +		return 0;
> +
> +	if (unlikely(!kwatch_tsk_ctx_check(KWATCH_PROBE_POSITION_ACTIVE)))
> +		return 0;
> +
> +	if (ctx->depth !=3D kwatch_probe_ctx.cfg->depth + 1 || ctx->wp)
> +		return 0;

[Severity: High]
Could an NMI interrupt the probed function after the outer invocation has
already incremented ctx->depth, and then recursively call the same probed
function?

Since kwatch_lifecycle_entry() deliberately skips the ctx->depth increment
for rejected NMIs, would this mid-function offset kprobe falsely pass the
check by reading the outer context's depth and incorrectly arm the hardware
watchpoint using NMI register state?

[ ... ]

> +static int kwatch_lifecycle_entry(struct kretprobe_instance *ri,
> +				  struct pt_regs *regs)
> +{
> +	/*
> +	 * Single policy point: the target function's context is judged once
> +	 * here. A rejected invocation never increments depth, so the offset
> +	 * kprobe path inherits the verdict through the depth check.
> +	 */
> +	if (unlikely(kwatch_probed_ctx_in_nmi(kwatch_probe_ctx.rp_via_int3))) {
> +		atomic_long_inc(&kwatch_nmi_rejected);
> +		return 1; /* NMI context is unsupported: no window, no return hook */
> +	}

[Severity: Medium]
Is there a race window here where rp_via_int3 is read before being
initialized?

kwatch_probe_start() registers the kretprobe, which enables this function to
intercept calls across all CPUs, but it initializes rp_via_int3 slightly
after:

kwatch_probe_start() {
    ...
    ret =3D register_kretprobe(&kwatch_probe_ctx.rp);
    if (ret < 0) {
        ...
    }
    kwatch_probe_ctx.rp_via_int3 =3D !kprobe_ftrace(&kwatch_probe_ctx.rp.kp=
);
    ...
}

If another CPU hits this probe before rp_via_int3 is set, might it evaluate
as false and misclassify a normal trap context as an NMI if the architecture
uses int3 for delivery?

[ ... ]

> +static int kwatch_lifecycle_exit(struct kretprobe_instance *ri,
> +				 struct pt_regs *regs)
> +{
> +	struct kwatch_tsk_ctx *ctx =3D kwatch_tsk_ctx_get(false);

[Severity: High]
If a task is killed by a fatal signal (like SIGKILL) or calls do_exit()
directly while inside the probed function, it bypasses this kretprobe exit
handler.

Does this permanently leak the hardware watchpoint assigned to ctx->wp?

Furthermore, kwatch_tsk_ctx_get() matches raw pointers for the active task:

mm/kwatch/task_ctx.c:kwatch_tsk_ctx_get() {
    ...
    t =3D READ_ONCE(kwatch_ctx_pool[idx].task);
    if (t =3D=3D current)
        return &kwatch_ctx_pool[idx];
    ...
}

If the slab allocator reuses the dead task's task_struct memory address for=
 a
new task, will the new task erroneously inherit the corrupted state and lea=
ked
watchpoint from the pool?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717125023.1895=
892-1-wangjinchao600@gmail.com?part=3D9
