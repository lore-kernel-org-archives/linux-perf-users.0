Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4BB44C649
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 19:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784058088; cv=none; b=KtnKLrvZeBURe0LiXwCek45vyszu8XASGPQxRrMzVNrDZs5v9QQj6/BorQatlud5EdypfuOvIsDsRd9zB2J7DxltfY9RXwcfaHehwPO7jJjg505crDqyvdHng37Y8aVlw3JDc1Z2osZJXClVz9AJdPvzcL35zOgjygEglVZyZuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784058088; c=relaxed/simple;
	bh=PWE4fhXoPZYSOF+/E0MFqgpoarCQxe1FM9R2LR4/4Pg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qgiYzn1hahww2ew7HuJhCMkcUtlGUwTJxgP9n1GkM8J8SN15/aGeDrFTFIKuMf5SdzSRkbWim5WtTaamXfbjrdv0A0uOmE3ADlpP2UwNFO4HoW/QEAyWK6BbnCOq6LcoViykszuV35kjxxH3ir3y63HE22N6+tDay2+4k2HnXjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jv9SXJ5u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jv9SXJ5u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2460E1F000E9;
	Tue, 14 Jul 2026 19:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784058087;
	bh=OqaijqPpybfFGuT7jSvlouqwA03Z3jZCydXjClhqjOg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jv9SXJ5uNpNpskCL0f3elFveMIWSXKTShdoraDQTjp/1RfhIpB2UObvu4ZVf8sN6U
	 dg7zPq9fBFQZUwU72mbRdQTPc3ElwIoOlFORPJ4BhjsoLhJLII1pBPcy56nQM3mXlg
	 Dq4znSGWsQcnHK0RQOJAZnE2WenrAVcP5o+XK1HZtr9tnqlWoApTwuR9utobNpeRZ9
	 BrRmC1DRKOrL98fefh4LknaK+gY5h4OJFjUxldQYpjEvT0wvzxKeuUvIS5Pa4MpdkJ
	 SJKLndiiypgHiNJW4k+0E2a7HJgCXK81dvurE5jPWmzLLzFzHg/xiVbSvDEPtq9+5w
	 X8Pep/SURbn7Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 04/13] HWBP: Add modify_wide_hw_breakpoint_local()
 API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinchao Wang" <wangjinchao600@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260714183049.12383-1-wangjinchao600@gmail.com>
References: <20260714182243.10687-1-wangjinchao600@gmail.com>
 <20260714183049.12383-1-wangjinchao600@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 19:41:26 +0000
Message-Id: <20260714194127.2460E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] In-place mutation of active hardware breakpoint state (`bp->hw.inf=
o`) without disabling the event causes NMI data races and error-path corrup=
tion.
- [High] The DRn debug address register is updated while the hardware break=
point is still enabled in DR7, risking spurious debug exceptions.
- [Medium] `modify_wide_hw_breakpoint_local` fails to update `bp->attr` on =
successful modification, causing state desynchronization.
--

--- Patch [4]: [RFC PATCH 04/13] HWBP: Add modify_wide_hw_breakpoint_local(=
) API ---
commit 861178eefb9a8774dffa3900f118da48cde078a9
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

    HWBP: Add modify_wide_hw_breakpoint_local() API
   =20
    Add modify_wide_hw_breakpoint_local() arch-wide interface which allows
    hwbp users to update watch address on-line. This is available if the
    arch supports CONFIG_HAVE_REINSTALL_HW_BREAKPOINT.

[ ... ]

> diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> index 789add0c185a0..20ca64f305083 100644
> --- a/kernel/events/hw_breakpoint.c
> +++ b/kernel/events/hw_breakpoint.c
> @@ -888,6 +888,43 @@ void unregister_wide_hw_breakpoint(struct perf_event=
 * __percpu *cpu_events)

[ ... ]

> +int modify_wide_hw_breakpoint_local(struct perf_event *bp,
> +				    struct perf_event_attr *attr)
> +{
> +	int ret;
> +
> +	if (find_slot_idx(bp->attr.bp_type) !=3D find_slot_idx(attr->bp_type))
> +		return -EINVAL;
> +
> +	ret =3D hw_breakpoint_arch_parse(bp, attr, counter_arch_bp(bp));

[Severity: High]
Does this code call hw_breakpoint_arch_parse() on the active event's hardwa=
re
info without temporarily disabling the event?

Architecture implementations like x86's arch_build_bp_info() mutate the str=
uct
incrementally:

arch/x86/kernel/hw_breakpoint.c:arch_build_bp_info() {
	hw->address =3D attr->bp_addr;
	hw->mask =3D 0;

	/* Type */
	switch (attr->bp_type) {
...
}

If validation fails midway, does bp->hw.info remain partially overwritten a=
nd
corrupted?

Additionally, could an NMI hitting the active breakpoint during this window
read torn state?

> +	if (ret)
> +		return ret;
> +
> +	return arch_reinstall_hw_breakpoint(bp);

[Severity: High]
Does arch_reinstall_hw_breakpoint() risk spurious debug exceptions here?

Because modify_wide_hw_breakpoint_local() does not temporarily disable the
breakpoint first, the slot is already enabled in the physical DR7.

Modifying DRn before the control register DR7 is cleared or updated can
violate architectural rules:

arch/x86/kernel/hw_breakpoint.c:setup_hwbp() {
	set_debugreg(info->address, slot);
	__this_cpu_write(cpu_debugreg[slot], info->address);

	dr7 =3D this_cpu_read(cpu_dr7);
	/*
	 * Clear the slot's stale len/type and enable bits first
...
}

Could this trigger spurious #DB debug exceptions if the CPU accesses the new
address during the window before DR7 is updated?

[Severity: Medium]
When this modification is successful, should bp->attr be updated with the n=
ew
user-provided attributes?

It looks like the newly parsed attr is never copied back to bp->attr.

Any subsequent read of the breakpoint properties or perf sample
initializations might silently use the old, stale address and length:

kernel/events/core.c:perf_bp_event() {
	perf_sample_data_init(&sample, bp->attr.bp_addr, 0);
...
}

Will this cause state desynchronization and silently corrupt trace data?

> +}
> +#else
> +int modify_wide_hw_breakpoint_local(struct perf_event *bp,
> +				    struct perf_event_attr *attr)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714182243.1068=
7-1-wangjinchao600@gmail.com?part=3D4
