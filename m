Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B01F406279;
	Wed, 27 May 2026 13:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779886862; cv=none; b=jLMz7HSuGKa5wleniXsSRWxJhCDnLgNv6Mik6imOgnBLk77DpQhdVYJ2Cwbo51W1bhLjgAKM94o+WtUEkIUs/kQg5gECpvsmASx6NrwccjlKsrYQgB8iv7yD/yWQ1uoApTION/wZzKrUBKSWgVzNb1LbcweLHAryQpUlLRE0lls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779886862; c=relaxed/simple;
	bh=wteeOWqFtArRQCr5tPFdFfQRi6IavlrVpdHlVoTyP4o=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=A7PCOZtRjA0OGdDBZochpFD612XVrYmwK+WZ7fuZ+YTAx5ZRG+vpoUpj8jgKPBN7rNhgbtDemHukwGIQS+zgJN5ZV9P1G/VWkI+GT/CEtGwy9J7DzB5GKM5PitmFZhSHES0ezdhqgbUL5l9+wDZHYhrYCKGpZEnoFeD2efchwUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2259crJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2259crJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843B21F000E9;
	Wed, 27 May 2026 13:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779886861;
	bh=ewCZvotD2nMM/jjWYtZrGs+J8TAeFzVbz9UBT46h7c8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=P2259crJ4T61qpz0XGUiJIV20jSRagZ6SL9jLMALgA7jNIhj1VMXA0CAG+YnMjFcp
	 XiFwZXKGei55tEc7YwvkSYH0M74pt/BEG0dsEu2Q6PAQ1lJUpraElHGB9659Az7HUZ
	 CGVuUCHkHfccVY5PZI2KhwSib5ObtiCTvYVfWJ+mFS+30s4KAs3c71aiU8DDXmDE4s
	 ikdzKNbabZ4iD3dof0j8fc1/HPRQd6l5ByK2d1wq2RwCvQbC74o+OXTgxrzC3dOF68
	 A7HrkvUH6me6YoyoqGpa2gcopCLboMCgMfiWr9bcLJQVyg/ga9GJtnvBVS4rJQLSpz
	 y9jjvoUdPOc0Q==
Content-Type: multipart/mixed; boundary="===============6680819981936320450=="
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d020aa03b31a01086809801d91e1dd620b2fa26c375d7e7796bf59dee8af3cc0@mail.kernel.org>
In-Reply-To: <20260527121207.2312181-4-puranjay@kernel.org>
References: <20260527121207.2312181-4-puranjay@kernel.org>
Subject: Re: [PATCH v4 3/4] perf/arm64: Add BRBE support for bpf_get_branch_snapshot()
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,puranjay12@gmail.com,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,will@kernel.org,mark.rutland@arm.com,catalin.marinas@arm.com,leo.yan@arm.com,robh@kernel.org,peterz@infradead.org,mingo@redhat.com,acme@kernel.org,namhyung@kernel.org,james.clark@linaro.org,irogers@google.com,adrian.hunter@intel.com,shuah@kernel.org,leitao@debian.org,ravi.bangoria@amd.com,eranian@google.com,memxor@gmail.com,usama.arif@linux.dev,linux-arm-kernel@lists.infradead.org,linux-perf-users@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 27 May 2026 13:01:00 +0000 (UTC)

--===============6680819981936320450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
> index ba554e0c846c..aede95e27784 100644
> --- a/drivers/perf/arm_brbe.c
> +++ b/drivers/perf/arm_brbe.c

[ ... ]

> @@ -774,32 +795,96 @@ void brbe_read_filtered_entries(struct perf_branch_stack *branch_stack,

[ ... ]

> +/*
> + * Best-effort BRBE snapshot for BPF tracing. Pause BRBE to avoid
> + * self-recording and return 0 if the snapshot state appears disturbed.
> + */
> +int arm_brbe_snapshot_branch_stack(struct perf_branch_entry *entries, unsigned int cnt)
> +{
> +	unsigned long flags;
> +	int nr_hw, nr_copied = 0;
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
> +	brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
> +	brbcr = read_sysreg_s(SYS_BRBCR_EL1);
> +	write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
> +	isb();
> +
> +	/* Bail out if BRBE is not enabled (BRBCR_EL1 == 0). */
> +	if (!brbcr) {
> +		write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
> +		return 0;
> +	}

A subsystem pattern flags this as potentially concerning: when
BRBCR_EL1 is not enabled, the function restores BRBFCR_EL1 and returns
immediately. Should the write_sysreg_s that restores BRBFCR_EL1 be
followed by an isb() before the return?

Looking at other code paths in this function, both the success path and
the PMU-overflow-detection path restore BRBFCR_EL1 followed by isb()
before returning. The early-exit path here omits the barrier, meaning
there is a function return (RET branch) right after the control register
write without an intervening isb().

ARM64 guidelines typically require an isb() after writes to control
system registers to ensure the change takes effect before subsequent
operations. While BRBE is disabled in this path, and eventual exception
entry/exit will provide synchronization, the inconsistency with the
other exit paths is worth checking.

> +
> +	/* Block local exception delivery while reading the buffer. */
> +	flags = local_daif_save();
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

[ ... ]

> +	brbe_invalidate();
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

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26510917353
--===============6680819981936320450==--
