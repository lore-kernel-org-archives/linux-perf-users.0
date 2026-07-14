Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFCD31F99B
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 19:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784058798; cv=none; b=UZ2/IAemL06VIT8m6wqrAbny64NrgsDNq5Qx5d+ZG8JtuWHiMpmxfKvPNm7B71n+vNRoWmaQwOmp+b8hAsvMA5RRL55nfnppONWXQ3IgXS0njJps8RRgY/rdBHlxGy2Pzps5u2HkN7CYt3YunoijgzpKOnGIplnxLeFYu/EMquw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784058798; c=relaxed/simple;
	bh=174QUMM7gFmJAAu/+rpSIW8Lc3BgN6fQO/uMrGAyOfU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Oqg9oD+lOWDiSvv+CfyiYOpxsSHaCUkWzNcIQ8VyEt2KDBn+eUK5hJxlbJI9BSvAc6tHwM3zlaVwt5IBIfwEWR+760q6ukmlX1vLrnBUvjw4H+Rj45iv6a7nU23hX6wCmWeNBmnAk6czUNcRaZCElx9wYqOeh9edoOs3MXKRtxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvrU9GeZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvrU9GeZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883D21F000E9;
	Tue, 14 Jul 2026 19:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784058796;
	bh=majsAJGUvMVMOFPqM2mBb8SxebHRP/45M32Cjy/E7oo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AvrU9GeZ9v6DKbOG/i2F1Bw0j6YW86UZ8R+43UwhJBnWLO5+bOh/JFzpjHVGxSmQF
	 L232hejHQxzWVqrj7ZTB+BSoUA5fZmfawpnD/JCId5qk5VcT2u/v+rVVCFpFqtmSO0
	 JfXlyhA46JPa5UXssza3OGAjB8BfO5mzTFOAJxIKkQo9Fs5zzLtEDEg/D+LdtLZvzq
	 oycEbTEHmxl3fa5fTUNWAxkQ4mBaJ+eylqkw3s9Fv+/417RbVqRyLLKtXiGObR523d
	 4tAf9LlR5akzeL6/WejEtg4Iw894IdXoMO2V7eynA3Ru0wl3rRiHvXkSPB6JwlHOWz
	 1FSdDzjjPEk+A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 09/13] mm/kwatch: add probe lifecycle runtime
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinchao Wang" <wangjinchao600@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260714183226.12756-1-wangjinchao600@gmail.com>
References: <20260714182243.10687-1-wangjinchao600@gmail.com>
 <20260714183226.12756-1-wangjinchao600@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 19:53:16 +0000
Message-Id: <20260714195316.883D21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Concurrent hardware breakpoint hits during kwatch_probe_start() ca=
use a NULL pointer dereference in kwatch_probe_validate_hit().
- [High] Context pool slots are permanently leaked if a task hits a kwatch =
probe while `kwatch_probe_ctx.epoch =3D=3D 0`.
- [High] The logic to determine if the probe is using int3 falsely evaluate=
s to `false` for ftrace-enabled functions, rejecting normal executions.
- [High] Dangling `task_struct` pointers in `kwatch_ctx_pool` cause ABA ali=
asing and permanent hardware watchpoint leaks when a traced task terminates=
 abnormally.
- [Medium] The NMI context detection relies on an x86-specific assumption a=
bout kprobe traps, which fails to reject NMI contexts on architectures like=
 ARM64.
--

--- Patch [9]: [RFC PATCH 09/13] mm/kwatch: add probe lifecycle runtime ---
commit a56d8337b9a7da3aea3294307119403cdb9289c9
Author: Jinchao Wang <wangjinchao600@gmail.com>
Subject: mm/kwatch: add probe lifecycle runtime

This commit adds the core kwatch probe lifecycle runtime, tracking per-task
nesting depth through entry and exit kretprobes to open and close watch
windows. It includes an epoch versioning scheme to invalidate stale
per-task state and counts rejections for functions in NMI-like contexts.

> diff --git a/mm/kwatch/probe.c b/mm/kwatch/probe.c
> new file mode 100644
> index 0000000000000..af6e0af45c10c
> --- /dev/null
> +++ b/mm/kwatch/probe.c
> @@ -0,0 +1,263 @@

[ ... ]

> +/*
> + * True if the probed function itself runs in an NMI-like context.
> + * int3-based kprobe delivery adds one NMI-like layer of its own;
> + * delivery is pinned at registration so the subtraction stays exact.
> + */
> +static bool kwatch_probed_ctx_in_nmi(bool via_int3)
> +{
> +	return (preempt_count() & NMI_MASK) > (via_int3 ? NMI_OFFSET : 0);
> +}

[Severity: Medium]
Does this NMI context check rely on x86-specific kprobe trap behavior?

On architectures like ARM64, the brk trap does not add an NMI_OFFSET to the
preempt count. If the probe is hit inside a genuine NMI on these architectu=
res,
could this evaluate to false and fail to reject the NMI context?

[ ... ]

> +bool kwatch_probe_validate_hit(struct pt_regs *regs,
> +			       struct task_struct *arm_tsk)
> +{
> +	struct kwatch_tsk_ctx *ctx =3D kwatch_tsk_ctx_get(false);
> +
> +	if (unlikely(!ctx))
> +		return true;
> +
> +	if (arm_tsk !=3D current ||
> +	    ctx->depth !=3D kwatch_probe_ctx.cfg->depth + 1)

[Severity: High]
Can this cause a NULL pointer dereference if a hardware watchpoint is hit
concurrently during kwatch reconfiguration?

In kwatch_probe_start(), kwatch_probe_ctx is cleared:

    memset(&kwatch_probe_ctx, 0, sizeof(kwatch_probe_ctx));

This temporarily sets cfg to NULL. Since stopping a kwatch session
unregisters kprobes but might not synchronously disarm active hardware
watchpoints, could a thread hit an active watchpoint, invoke
kwatch_probe_validate_hit(), and attempt to read kwatch_probe_ctx.cfg->depth
while cfg is NULL?

> +		return true;
> +
> +	return false;
> +}

[ ... ]

> +static bool kwatch_tsk_ctx_check(enum kwatch_probe_position pos)
> +{
> +	struct kwatch_tsk_ctx *ctx =3D kwatch_tsk_ctx_get(true);
> +	u32 epoch;
> +
> +	if (unlikely(!ctx))
> +		return false;
> +
> +	/* Pairs with smp_store_release() in kwatch_probe_start/stop() */
> +	epoch =3D smp_load_acquire(&kwatch_probe_ctx.epoch);
> +
> +	if (unlikely(ctx->epoch !=3D epoch))
> +		kwatch_tsk_ctx_reset(ctx, epoch);
> +
> +	if (unlikely(!epoch))
> +		return false;

[Severity: High]
Does this early return cause a permanent context pool slot leak?

If a task enters or exits the kprobe while the global epoch is temporarily 0
during kwatch_probe_start() or kwatch_probe_stop(), this check bypasses the
KWATCH_PROBE_POSITION_EXIT state machine.

Because kwatch_tsk_ctx_put() is completely skipped when epoch is 0, does the
context slot remain permanently allocated to the thread, potentially leading
to a denial of service if the pool is exhausted?

> +
> +	switch (pos) {

[ ... ]

> +static int kwatch_lifecycle_exit(struct kretprobe_instance *ri,
> +				 struct pt_regs *regs)
> +{
> +	struct kwatch_tsk_ctx *ctx =3D kwatch_tsk_ctx_get(false);
> +
> +	if (unlikely(!ctx))
> +		return 0;
> +
> +	if (!kwatch_tsk_ctx_check(KWATCH_PROBE_POSITION_EXIT))
> +		return 0;
> +
> +	if (ctx->depth =3D=3D kwatch_probe_ctx.cfg->depth) {
> +		struct kwatch_watchpoint *wp =3D xchg(&ctx->wp, NULL);
> +
> +		if (wp)
> +			kwatch_hwbp_put(wp);
> +	}
> +
> +	return 0;
> +}

[Severity: High]
Are context slots and active watchpoints permanently leaked if the probed
task terminates abnormally?

If a task receives a fatal signal while inside the probed function, do_exit=
()
flushes the kretprobe without calling kwatch_lifecycle_exit(), meaning this
exclusive cleanup path is bypassed.

Since kwatch_tsk_ctx_get() uses the raw task_struct pointer as a lookup key,
could a new task that happens to reuse the freed task_struct memory address
erroneously inherit the corrupted context state and active watchpoint?

[ ... ]

> +int kwatch_probe_start(struct kwatch_config *cfg)
> +{
> +	static u32 next_epoch;
> +	u32 current_epoch;
> +	int ret;

[ ... ]

> +	kwatch_probe_ctx.rp.entry_handler =3D kwatch_lifecycle_entry;
> +	kwatch_probe_ctx.rp.handler =3D kwatch_lifecycle_exit;
> +	kwatch_probe_ctx.rp.kp.symbol_name =3D cfg->func_name;
> +
> +	ret =3D register_kretprobe(&kwatch_probe_ctx.rp);
> +	if (ret < 0) {
> +		unregister_kprobe(&kwatch_probe_ctx.pin_kp);
> +		return ret;
> +	}
> +	kwatch_probe_ctx.rp_via_int3 =3D !kprobe_ftrace(&kwatch_probe_ctx.rp.kp=
);

[Severity: High]
Does this logic incorrectly evaluate to false for ftrace-enabled functions?

The child kprobe (rp.kp) retains KPROBE_FLAG_FTRACE even when the aggregate
probe is forced to use INT3 due to the companion probe's post_handler.=20

Because rp_via_int3 becomes false, does the trap's artificial NMI increment
make kwatch_probed_ctx_in_nmi() always evaluate to true, falsely identifying
normal contexts as NMIs and rejecting all valid executions?

> +
> +	if (cfg->func_offset) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714182243.1068=
7-1-wangjinchao600@gmail.com?part=3D9
