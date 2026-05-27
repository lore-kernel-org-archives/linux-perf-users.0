Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7029521D590;
	Wed, 27 May 2026 14:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890990; cv=none; b=jLO81F1w51gG+YdGb9DQtFJOGDOkxzcGIpO5x5KT/WHi+TMhz7tUxsu6RwwQXRTDArhsWFfl5erj0WRQxsFeysncJBbP0K3Y9wq90Zqc1H1HfDCPMLkLRHajz1vI48yR05di0WQ6/UoNeE1jmpwvCagXHg4YJX4vY5B9ZQwpA/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890990; c=relaxed/simple;
	bh=t3GCGLTtE1Q/9glAbzqgh8oazNh984uILkl3fXKHnwM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y55ylNlnYSuQQ6HFQjBgJ+dhx9pqE7ShAZZtzJq7MI5pkTKXUwomIhYmfJRJjkkPpZp8yijMgRqH8s2oUkzg36bUp4pXu3g3dSvaWLjPjgVOAYzOf/fuU8cKvZNZgoblnuGdr2ubvfFOgZQR0DsOHPKoPJUtbPyLuK8aXWT44i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZe08RKW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZe08RKW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D61C1F000E9;
	Wed, 27 May 2026 14:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779890989;
	bh=+kCQabNR70NwHBc3LPpyv3HzITw+mLzNMCmdJgCbjRI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hZe08RKWlGUsFV1tC+ZrXvAcWt6CgUV+4kzxoonRmLJlqiPpmqkChpnrEZjGa3rto
	 s1Bz23bXdbp3TEsSurtJK5Qd5JO6YuZ97J9rTGrG9jL2H3SqLGy239QwdDnoRojMjn
	 Iaqf3GVwtixybZ+v07nv7q8rsgTbTjAr5bSFyLXFuT89WrrS+BSyQoovAOe1qc9MN/
	 IkikaN3utqo6GGkAZ0grc8cCIL+s0yqOz4qnOqqJ6+0lZHWdkRw3RVhjelpecgfCed
	 ZA1ZXaTSCUxxb8FTgRjJ5zcfNTTCxTV0LQVvvlNjd9LZmiFJKrw9eTMhsB6fdFDwzX
	 11X1TqURBF62A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/4] perf/arm64: Add BRBE support for
 bpf_get_branch_snapshot()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260527121207.2312181-4-puranjay@kernel.org>
References: <20260527121207.2312181-4-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 14:09:47 +0000
Message-Id: <20260527140948.3D61C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] TOCTOU race in `arm_brbe_snapshot_branch_stack` leads to hardware =
state corruption.
- [High] Unconditional calls to `brbe_invalidate()` destructively clear har=
dware branch records, breaking concurrent perf events.
- [High] `bpf_get_branch_snapshot()` unconditionally fails when invoked fro=
m a PMU NMI handler.
--

commit 4683208c7439e46b2ca26814f22b69f16e4ad0c2
Author: Puranjay Mohan <puranjay@kernel.org>

perf/arm64: Add BRBE support for bpf_get_branch_snapshot()

This commit enables bpf_get_branch_snapshot() on ARM64 by implementing the
perf_snapshot_branch_stack static call for BRBE. It pauses BRBE, reads the
records into a buffer, invalidates the buffer, and unpauses BRBE.

> diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
> index ba554e0c846c4..aede95e277842 100644
> --- a/drivers/perf/arm_brbe.c
> +++ b/drivers/perf/arm_brbe.c
[ ... ]
> @@ -774,32 +795,96 @@ void brbe_read_filtered_entries(struct perf_branch_=
stack *branch_stack,
[ ... ]
> +/*
> + * Best-effort BRBE snapshot for BPF tracing. Pause BRBE to avoid
> + * self-recording and return 0 if the snapshot state appears disturbed.
> + */
> +int arm_brbe_snapshot_branch_stack(struct perf_branch_entry *entries, un=
signed int cnt)
> +{
> +	unsigned long flags;
> +	int nr_hw, nr_copied =3D 0;
> +	u64 brbfcr, brbcr;
> +
> +	if (!cnt)
> +		return 0;
> +
> +	/* Guard against running on a CPU without BRBE (e.g. big.LITTLE). */
> +	if (!cpu_has_brbe())
> +		return 0;
> +
> +	/*
> +	 * Pause BRBE first to avoid recording our own branches. The
> +	 * sysreg read/write and ISB are branchless, so pausing before
> +	 * checking BRBCR avoids polluting the buffer with our own
> +	 * conditional branches.
> +	 */
> +	brbfcr =3D read_sysreg_s(SYS_BRBFCR_EL1);
> +	brbcr =3D read_sysreg_s(SYS_BRBCR_EL1);
> +	write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
> +	isb();
> +
> +	/* Bail out if BRBE is not enabled (BRBCR_EL1 =3D=3D 0). */
> +	if (!brbcr) {
> +		write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
> +		return 0;
> +	}

[Severity: High]
Is this check incompatible with PMU NMI handlers?

If a BPF program attaches to a perf event overflow, armv8pmu_handle_irq()
calls armv8pmu_stop() before processing overflows, which calls brbe_disable=
()
and sets SYS_BRBCR_EL1 to 0.

Would this cause bpf_get_branch_snapshot() to unconditionally fail and retu=
rn
0 when triggered from these PMU events?

> +
> +	/* Block local exception delivery while reading the buffer. */
> +	flags =3D local_daif_save();

[Severity: High]
Is there a TOCTOU race window here that could corrupt hardware state?

The function reads and caches SYS_BRBFCR_EL1 and SYS_BRBCR_EL1 before
disabling local exceptions via local_daif_save().

If an interrupt or NMI arrives in this window (such as a perf_event_disable
IPI) and modifies the BRBE hardware configuration, the function later writes
back the stale cached brbcr and brbfcr values at the end of the function,
overwriting the PMU subsystem's intentional changes.

Does the mitigation check below catch this?

	if (!(read_sysreg_s(SYS_BRBFCR_EL1) & BRBFCR_EL1_PAUSED)) {

It looks like it might fail to catch this because brbe_disable() leaves the
PAUSED bit set, leading to the function silently re-enabling BRBE and
corrupting the hardware state when restoring the cached registers.

> +
> +	/*
> +	 * A PMU overflow before local_daif_save() could have re-enabled
> +	 * BRBE, clearing the PAUSED bit. The overflow handler already
> +	 * restored BRBE to its correct state, so just bail out.
> +	 */
> +	if (!(read_sysreg_s(SYS_BRBFCR_EL1) & BRBFCR_EL1_PAUSED)) {
> +		local_daif_restore(flags);
> +		return 0;
> +	}
> +
> +	nr_hw =3D FIELD_GET(BRBIDR0_EL1_NUMREC_MASK,
> +			  read_sysreg_s(SYS_BRBIDR0_EL1));
> +
> +	for_each_brbe_entry(i, nr_hw) {
> +		if (nr_copied >=3D cnt)
> +			break;
> +
> +		if (!perf_entry_from_brbe_regset(i, &entries[nr_copied], NULL))
> +			break;
> +
> +		nr_copied++;
> +	}
> +
> +	brbe_invalidate();

[Severity: High]
Does unconditionally clearing hardware branch records here break concurrent
perf events?

Since bpf_get_branch_snapshot() can be invoked asynchronously at any time
(e.g., from a BPF kprobe or tracepoint program), if another perf event is
actively profiling, would this snapshot silently wipe the hardware BRBE
buffer?

When the active perf event later overflows, it would read an empty or sever=
ely
truncated branch stack, potentially corrupting the profiling data. Should
snapshots be read-only?

> +
> +	/* Restore BRBCR before unpausing via BRBFCR, matching brbe_enable(). */
> +	write_sysreg_s(brbcr, SYS_BRBCR_EL1);
> +	isb();
> +	write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
> +	/* Ensure BRBE is unpaused before returning to the caller. */
> +	isb();
> +	local_daif_restore(flags);
> +
> +	return nr_copied;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527121207.2312=
181-1-puranjay@kernel.org?part=3D3
