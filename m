Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617B346AEEA;
	Tue, 16 Jun 2026 16:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626519; cv=none; b=ikJaXXZnbZ4jGm3QN5sqG3lXU+fbH+NtmQvaJKu4j/2ip5GKBEGSHiCbYuTtf0SP7T6qpzcpgJnO7iA787IUZc3t4ug+Kh8ellTIZHh/AOQ2wa5qluZCyBbqJr+Q0hz5YzaQfEt2uo8tBaUrsJYGiE/O5WycmlNUF03BknBBhJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626519; c=relaxed/simple;
	bh=Ryft4E79lVL9p9uyczbtoC8iSDad1AmkMhA2wFXHGkk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tqq5HPVaDn1B2jGIvj9k60rq51W44/Kw8o5ILUphybIo7nvnBEvEgEiXsmApoc6BJ1EqeuSyQ1mkVTNnZq+CzwV2PmMjL58Bilu+eX2osH2c+XUYWJexObPElVPS6Wx2LqMBJauy4vvJAT9u54tgsyzC2FGav21xKObDdYlk6Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gizrvZJw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gizrvZJw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088E71F00A3A;
	Tue, 16 Jun 2026 16:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781626518;
	bh=JnTmuHgA1IzTdszzp7MTZaASfk8Tba/kJPZurx07dIg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gizrvZJwEhC6rOXFUOvqP9yzdEZNxqd7ojD1IQj+8i5yNCiE08t3VZQFQclF/PZes
	 ZFlPQdJJRLwOupg1bQQqJN4TqOULp99eQgc3qySksu/mBZgm32Kum7iYhPbzT1MJ/E
	 OY7fZPYN5zRZnbLQPAOlfJss3obInxw1XV87uqkIOkTSEth745ifDRsINsBvjqXCdq
	 h7b5xjECQ5AH0cyoeHHm6KwoRV/czb3NFoTsfO+1owtoQoOwgE1vQtESTM6veCZuD6
	 ahLfyGCFy/DmzS3LbbZZi1+D1UxrdF8wGnhxnUWt/cGM7hTbtVoYqEwHz0NNhRN7P0
	 KiZaoRAnPbrGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/4] perf/arm64: Add BRBE support for
 bpf_get_branch_snapshot()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260616155716.2631508-4-puranjay@kernel.org>
References: <20260616155716.2631508-4-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 16:15:17 +0000
Message-Id: <20260616161518.088E71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] `arm_brbe_snapshot_branch_stack` contains a TOCTOU vulnerability w=
here caching `SYS_BRBCR_EL1` before disabling interrupts allows a stale val=
ue to be restored, unintentionally re-enabling BRBE if an interrupt disable=
s the PMU event in the intervening window.
--

commit dbaa008d5027ec5e859cbcac51237295c1187ed6
Author: Puranjay Mohan <puranjay@kernel.org>

perf/arm64: Add BRBE support for bpf_get_branch_snapshot()

Enable bpf_get_branch_snapshot() on ARM64 by implementing the
perf_snapshot_branch_stack static call for BRBE. This pauses BRBE,
masks exceptions to prevent PMU overflow pseudo-NMI interference,
and reads the branch records.

> diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
> index effbdeacfcbb3..a141ad7abcf25 100644
> --- a/drivers/perf/arm_brbe.c
> +++ b/drivers/perf/arm_brbe.c
[ ... ]
> @@ -774,32 +795,97 @@ void brbe_read_filtered_entries(struct perf_branch_=
stack *branch_stack,
[ ... ]
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
> +		isb();
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
> +
> +	/* Restore BRBCR before unpausing via BRBFCR, matching brbe_enable(). */
> +	write_sysreg_s(brbcr, SYS_BRBCR_EL1);

[Severity: High]
Is it possible for a race condition here to accidentally re-enable BRBE?

SYS_BRBCR_EL1 is read and cached in brbcr before local_daif_save() disables
interrupts.

If an interrupt arrives in this window and disables the PMU (for example,
an IPI calling perf_remove_from_context() that invokes brbe_disable()),
it would set the BRBFCR_EL1_PAUSED bit.

When execution resumes, the bailout condition evaluates to false because
the PAUSED bit is now set:

    if (!(read_sysreg_s(SYS_BRBFCR_EL1) & BRBFCR_EL1_PAUSED)) {
        local_daif_restore(flags);
        return 0;
    }

The function then continues, and blindly writes the cached brbcr back to
the hardware here.

Since the cached brbcr had BRBE enabled, could this unintentionally
re-enable BRBE globally despite the kernel having just explicitly disabled =
it?

> +	isb();
> +	write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
> +	/* Ensure BRBE is unpaused before returning to the caller. */
> +	isb();
> +	local_daif_restore(flags);
> +
> +	return nr_copied;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616155716.2631=
508-1-puranjay@kernel.org?part=3D3
