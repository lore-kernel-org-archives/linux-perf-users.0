Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6FE343885
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 03:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784171338; cv=none; b=VN5i/6GV1l79tiX4aTl1WY+qqz0Dif1wZEm3U5Xp62NAF7baS4r0tygFqQtl4KiHpj9Ha/w4rQnO2IDhATds4a8nnq7kvJtoYciGFoEXeZmQDKlAZ7UvuirhYlB7+taCbg0e2Dgr3brFgfzONtHpSn1Zlp95JEsi8VltuaRelCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784171338; c=relaxed/simple;
	bh=gKDadkyMv2sanGdWmLnIXNvpP5rVjWhbawTwkPoWAgM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RlXSZBpccxMppKSPQ3oJ/SSi+m3EHY4qsorwPXcKGmNxRt+UZKgLMMykptuySdrdymY1tlKMP7YrwT4Miq8/FGAFH3R5mbmw/6WgnvDz2L4gZJI8wYsHqLod9ANwWrF+whwhFst1bnBsZ+Inv3fPBrqtSJOvAXz43gYHfSNoMNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZweuSyW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZweuSyW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E06A1F000E9;
	Thu, 16 Jul 2026 03:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784171337;
	bh=fJ5Be/nBvKIOV/iorvffqhwRFwZGFroF0YbpO0uDpGs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iZweuSyWnXutFQTk3Mhig5Y3fKNpa0gHnnvbn5+oyJIA+CPNRcFPU86cZr0H+L8SP
	 RBoQ1ETG9p/ot898rCueppcI+NvCDj82xZXl5jEvn6s8TLrXVbXxEYBl6jSjvoCdRS
	 j61zKX/otDMLJpzlSXduNNFFSs801JdETP4/cnJ/b3N/6dpRERL1DbuBkK3xx4gH03
	 rTM5gt6aXRXGQU+Ix8+zalqlBZ/wmB1d+CuXULj7eyhpuTfIZJW/FC7AjK0zaVYkC5
	 w9dg3hbvGgca/69vHXnD+Tso9bwyqUniKV+KpmDcazeNJqRpiC6VNsTFGu/kA0SQM6
	 vCQOjq1OZqFEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 7/9] HWBP: Add modify_wide_hw_breakpoint_local() API
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <178417041407.209165.16286991487015275181.stgit@devnote2>
References: <178417033089.209165.16717079876036408877.stgit@devnote2>
 <178417041407.209165.16286991487015275181.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 03:08:56 +0000
Message-Id: <20260716030857.2E06A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] State Corruption on Error Path
- [High] Race Condition / Unprotected State Modification with NMI
- [Medium] Locking Context / Lockdep Splat Due to Missing IRQ Disabling
--

--- Patch [7]: [PATCH v8 7/9] HWBP: Add modify_wide_hw_breakpoint_local() A=
PI ---
commit 12f28341e1b86eda783641bab63a14b074ec1ca3
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Subject: HWBP: Add modify_wide_hw_breakpoint_local() API

This patch adds an architecture-wide interface to allow hardware breakpoint
users to update watch addresses online. It supports modifying compatible
breakpoint types without releasing and reserving the hardware slot.

> diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> --- a/kernel/events/hw_breakpoint.c
> +++ b/kernel/events/hw_breakpoint.c
[ ... ]
> @@ -888,6 +888,49 @@ void unregister_wide_hw_breakpoint(struct perf_event=
 * __percpu *cpu_events)
[ ... ]
> +#ifdef CONFIG_HAVE_REINSTALL_HW_BREAKPOINT
> +int modify_wide_hw_breakpoint_local(struct perf_event *bp,
> +				    struct perf_event_attr *attr)
> +{
> +	struct arch_hw_breakpoint info;
> +	int ret;
> +
> +	if (find_slot_idx(bp->attr.bp_type) !=3D find_slot_idx(attr->bp_type))
> +		return -EINVAL;
> +
> +	ret =3D hw_breakpoint_arch_parse(bp, attr, &info);
> +	if (ret)
> +		return ret;
> +
> +	*counter_arch_bp(bp) =3D info;
> +	bp->attr.bp_addr =3D attr->bp_addr;
> +	bp->attr.bp_type =3D attr->bp_type;
> +	bp->attr.bp_len =3D attr->bp_len;

[Severity: High]
Is it safe to modify these software attributes non-atomically while the
hardware breakpoint is still fully enabled?

If a concurrent hardware debug exception fires and acts as a non-maskable
interrupt during this modification, could the exception handler read partia=
lly
updated or torn attributes and report incorrect trace data?

> +
> +	return arch_reinstall_hw_breakpoint(bp);

[Severity: High]
If arch_reinstall_hw_breakpoint() fails, this returns the error code direct=
ly,
but the internal state of the event has already been permanently modified.

Could this leave the breakpoint object in an inconsistent state where the
caller receives an error but the object was mutated?

Should we restore the original state if the architecture update fails?

[Severity: Medium]
Do callers of modify_wide_hw_breakpoint_local() need to have interrupts
disabled?

Calling arch_reinstall_hw_breakpoint() on x86 eventually reaches
arch_manage_bp(), which contains an unconditional
lockdep_assert_irqs_disabled():

modify_wide_hw_breakpoint_local()
  arch_reinstall_hw_breakpoint()
    arch_manage_bp()
      lockdep_assert_irqs_disabled()

Since this exported function doesn't disable interrupts itself or document
the requirement, will callers from standard contexts trigger a lockdep spla=
t?

> +}
> +#else
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178417033089.209165=
.16717079876036408877.stgit@devnote2?part=3D7
