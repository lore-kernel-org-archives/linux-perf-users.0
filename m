Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAE7344D8B
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 20:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776112305; cv=none; b=s8zybYETT3yD1Sd+iZHW4rdZ80j5SeReQ/ufXtmd2Pb9hXQlfjnthsc8u/x1jgUL3ldrM/IfCID46LSnBWqDMAtzhFrTKbzZkxYxXg3GyMVuljrjDB5fmckMw6g5Nws/w9fekefvfiVg6pwU+hEIDcDkItxy3IBcOVWQvf3I4uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776112305; c=relaxed/simple;
	bh=iNXia/bwbm8FSNGaULAKsfmGDzI8GHRNz/neuYDEFcU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mIflhzZWkyGm8xpHx6jB1h/GrTwgWikVrLrNW7zlA89oL0gZbEI1gF7tJ+e4Ub9Y2mAsZ7mFwXdTsxc2GcTNWiKbCdFEdMgjbrLn5okxrp2yG2t+YAYqnA4i60/o20gM3STVp5L4hcUQSWMoEdW35VvuJ9P51j4psIqvA0MmlMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlXwJEVb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlXwJEVb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA85BC2BCAF;
	Mon, 13 Apr 2026 20:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776112305;
	bh=iNXia/bwbm8FSNGaULAKsfmGDzI8GHRNz/neuYDEFcU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=KlXwJEVbDZwl0y5ogimIC5vyChmXyJJ3jvqywgLuBXTVupgpd+c+t2HobCUObbel9
	 oSfBaA6BQptYb4GQSI4vOpGsU8uvLmSsxzlnLsH2FRj2bqoQDwuwrSVZrmsvu7WUPF
	 O33wSVtTycWieCkbXaoVEFzUnIUw8YYGfpss5QuGgrkIbbPhuCiqMF0aJWwcSSkGVX
	 xR0bFZTdcCQXpJWwamVTzK5sozfb2V4ev7roXVOMqrbLV48wWts1QblrJ4gue2hcjr
	 TPR+Rd0I33IFU+gwl6OQrAOhPlJrdGelj2Xkms3E1rXj80yBn/Pcf5FtsWI88BAl11
	 0Y26mH3xQZ2fA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] perf/arm64: Add BRBE support for
 bpf_get_branch_snapshot()
Reply-To: sashiko@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260413185740.3286146-4-puranjay@kernel.org>
References: <20260413185740.3286146-4-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Apr 2026 20:31:44 +0000
Message-Id: <20260413203144.EA85BC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [High] arm_brbe_snapshot_branch_stack executes BRBE system register reads=
 without validating CPU support, leading to an Undefined Instruction kernel=
 panic on asymmetric systems.
- [High] arm_brbe_snapshot_branch_stack destructively clears the hardware b=
ranch buffer, corrupting data for concurrent perf sessions.
- [High] A TOCTOU race can unintentionally re-enable BRBE after it was expl=
icitly disabled by a PMU interrupt, corrupting hardware state.
- [Medium] Missing isb() context synchronization after unpausing BRBE cause=
s missed branch records.
--

commit ce06705327b522bc73c923ff4219c198fe71f3b4
Author: Puranjay Mohan <puranjay@kernel.org>
Subject: perf/arm64: Add BRBE support for bpf_get_branch_snapshot()

This commit enables bpf_get_branch_snapshot() on ARM64 by implementing the
perf_snapshot_branch_stack static call for BRBE. It pauses BRBE, masks
exceptions, reads branch records, and then invalidates the buffer.

> diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
> index ba554e0c846c4..fd62019ddc839 100644
> --- a/drivers/perf/arm_brbe.c
> +++ b/drivers/perf/arm_brbe.c

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
> +	/*
> +	 * Pause BRBE first to avoid recording our own branches. The
> +	 * sysreg read/write and ISB are branchless, so pausing before
> +	 * checking BRBCR avoids polluting the buffer with our own
> +	 * conditional branches.
> +	 */
> +	brbfcr =3D read_sysreg_s(SYS_BRBFCR_EL1);

On asymmetric systems (like big.LITTLE) where only a subset of CPU cores
implement BRBE, the perf_snapshot_branch_stack static call is enabled
globally. If a BPF program invokes this snapshot on a CPU lacking BRBE,
will this unconditionally execute read_sysreg_s(SYS_BRBFCR_EL1) and
trigger an Undefined Instruction exception kernel panic?

Does this need a local CPU feature check before accessing these registers?

> +	brbcr =3D read_sysreg_s(SYS_BRBCR_EL1);
> +	write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
> +	isb();
> +
> +	/* Bail out if BRBE is not enabled (BRBCR_EL1 =3D=3D 0). */
> +	if (!brbcr) {
> +		write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
> +		return 0;
> +	}
> +
> +	/* Block local exception delivery while reading the buffer. */
> +	flags =3D local_daif_save();
> +
> +	/*
> +	 * A PMU overflow before local_daif_save() could have re-enabled
> +	 * BRBE, clearing the PAUSED bit. The overflow handler already
> +	 * restored BRBE to its correct state, so just bail out.
> +	 */
> +	if (!(read_sysreg_s(SYS_BRBFCR_EL1) & BRBFCR_EL1_PAUSED)) {

Can a TOCTOU race unintentionally re-enable BRBE if a PMU interrupt fires
before exceptions are masked?

If the PMU overflow interrupt decides to stop the event, it calls
brbe_disable(), which sets SYS_BRBCR_EL1 to 0 and sets the PAUSED bit in
SYS_BRBFCR_EL1.

Upon returning from the interrupt, the PAUSED bit would still be set, so
this check evaluates to false and proceeds. At the end of the function,
the cached brbcr (which was > 0) and brbfcr are written back, which would
unintentionally re-enable BRBE in hardware without an active perf event.

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

Does calling brbe_invalidate() here destructively clear the hardware branch
buffer?

Since BPF branch snapshots are intended to be non-destructive observations,
wiping out the hardware branch buffer could permanently destroy the branch
history for a concurrently active perf session.

> +
> +	/* Restore BRBCR before unpausing via BRBFCR, matching brbe_enable(). */
> +	write_sysreg_s(brbcr, SYS_BRBCR_EL1);
> +	isb();
> +	write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);

Is an explicit isb() missing after writing to SYS_BRBFCR_EL1?

Since MSR instructions to system registers are not context synchronizing,
the processor may delay unpausing BRBE. Could this result in missed
branch records until the next context synchronization event naturally occur=
s?

> +	local_daif_restore(flags);
> +
> +	return nr_copied;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260413185740.3286=
146-1-puranjay@kernel.org?part=3D3
