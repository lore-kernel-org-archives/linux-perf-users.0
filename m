Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E14148F03C;
	Mon, 19 Oct 2026 07:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792395333; cv=none; b=juCw2l5vwv++hTQBNIUpTZK5g9C5oNxUXLiwVIAJ5Lfa6cmnOKMGlv69F0hg7XH7zIhEvpbrXssIXjzniaSwXzrBlc8/+hcBuWMFvw/KPrIWh/YPZivrDKrhU4TqT+nJwQkIzK4wmJErJZN8yJ2FRy4kzva9xfCWXN3b0hiUPCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792395333; c=relaxed/simple;
	bh=ZA7pU5ompcYtd3VGd+DLN6a6SyE7SjbqoTdoFw9JR0c=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=FYhXX1H2ms0j/pxIC6oNkzpMgqWpP7WwchTG/XgEUZD6Oqp4/jBj5V+joovlWyLQXJtoyzqg4cWK9VwL1xvjxmWoo5cV57DRhu7/yoz1pmAIC0WE6+GRJSAfdPPB5h4oL1xRM34k0tJTZ75c+Wu6Rju2EJuaU2WfDdmw7HF7chQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpQO1wOM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpQO1wOM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F6F1F000C4;
	Mon, 19 Oct 2026 07:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792395331;
	bh=ub6xNDj0gTx7rvONhT+iRVTk+88VnE0Xs8Cn8IZs+b4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EpQO1wOMFyEDqwrG8NZIVQ1Go+KCnpPfAxyCUAfXXBZ/6PqMWQKRY1okOj3UOG9vs
	 JXjqkFSF0uYWoWIBVLdtHVyUhmr8dkcmN7R5jeDHkd/jhDSL7teYI22I+Jc4e/l5eI
	 27nbM4p+KXJ7TjgZhUJr1PuUcCuRw8JHOxnhNCuxwJsqZABoHD/jMCWptO+zqoxKBJ
	 b5Y4g3AC1y6dVngmFp/3vjNhYbAD4sXByLK3urzYuptDAN7+IGC6B9+VfWAQwTfoiX
	 nTNglmnO9CKDBZ+/gjFubEnt/j4DmeJBMSrw0GXrz9SJ8XjRWBpsaKiWsqSzMV8xWj
	 LFW3m9tYPzbpA==
Message-ID: <sashiko-outbox-176751@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v3 4/4] perf/x86/intel/lbr: Limit branch snapshots to
 valid entries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261019070836.2972403-5-dapeng1.mi@linux.intel.com>
References: <20261019070836.2972403-1-dapeng1.mi@linux.intel.com>
 <20261019070836.2972403-5-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 07:35:30 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] perf/x86/intel/lbr: stale LBR data or -ENOENT in intel_pmu_lbr_rea=
d() for PEBS
- [Medium] perf/x86/intel/lbr: unreset lbr_stack.nr in intel_pmu_arch_lbr_r=
ead_xsave()
- [Medium] perf/x86: late lbr_nr clamping in init_hw_perf_events() after ar=
ch LBR init
--

commit da27a6ac96e6d944e33e171c276d0b044be96def
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86/intel/lbr: Limit branch snapshots to valid entries

This patch limits __intel_pmu_snapshot_branch_stack() to copy up to
cpuc->lbr_stack.nr entries rather than x86_pmu.lbr_nr, and resets
cpuc->lbr_stack.nr to 0 in intel_pmu_lbr_read() when there are no active
LBR users or LBR is excluded on the host.

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 0a34d674df590..5dfb9e9156e88 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2822,7 +2822,7 @@ __intel_pmu_snapshot_branch_stack(struct perf_branc=
h_entry *entries,
>  	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
> =20
>  	intel_pmu_lbr_read();
> -	cnt =3D min_t(unsigned int, cnt, x86_pmu.lbr_nr);
> +	cnt =3D min_t(unsigned int, cnt, cpuc->lbr_stack.nr);
> =20
>  	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * c=
nt);
>  	intel_pmu_enable_all(0);
> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index 249db12e927ed..cc0300aba7de0 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -1022,14 +1022,19 @@ void intel_pmu_lbr_read(void)
>  {
>  	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
> =20
> +	if (!cpuc->lbr_users || vlbr_exclude_host()) {
> +		/* Reset lbr_stack.nr to prevent stale data leakage. */
> +		cpuc->lbr_stack.nr =3D 0;
> +		return;
> +	}
> +
>  	/*
>  	 * Don't read when all LBRs users are using adaptive PEBS.
>  	 *
>  	 * This could be smarter and actually check the event,
>  	 * but this simple approach seems to work for now.
>  	 */
> -	if (!cpuc->lbr_users || vlbr_exclude_host() ||
> -	    cpuc->lbr_users =3D=3D cpuc->lbr_pebs_users)
> +	if (cpuc->lbr_users =3D=3D cpuc->lbr_pebs_users)
>  		return;

[Severity: High]
Does skipping x86_pmu.lbr_read(cpuc) here when cpuc->lbr_users =3D=3D
cpuc->lbr_pebs_users cause __intel_pmu_snapshot_branch_stack() to return
0 entries or copy stale cpuc->lbr_entries[] to BPF programs?

The commit message notes that when all active LBR users are PEBS events,
the LBR stack is already updated from the PEBS records. However, PEBS LBR
records are only written into cpuc->lbr_entries[] and cpuc->lbr_stack.nr
during counter overflow PMI draining:

  handle_pmi_common()
    -> x86_pmu_drain_pebs()
      -> setup_pebs_adaptive_sample_data() / setup_arch_pebs_sample_data()
        -> intel_pmu_store_pebs_lbrs()

In contrast, bpf_get_branch_snapshot() invokes
intel_pmu_snapshot_branch_stack() or intel_pmu_snapshot_arch_branch_stack()
synchronously from a software or tracing event outside of any PEBS drain.
Those functions freeze the hardware LBRs and call
__intel_pmu_snapshot_branch_stack() -> intel_pmu_lbr_read() to read the
current hardware LBR registers.

When all active LBR events on the CPU are adaptive PEBS events, returning
early in intel_pmu_lbr_read() without reading the hardware LBRs or
updating cpuc->lbr_stack.nr leads to several issues:

1. If no PEBS PMI has occurred since the last intel_pmu_lbr_reset(),
   cpuc->lbr_stack.nr is still 0, so __intel_pmu_snapshot_branch_stack()
   copies 0 entries and bpf_get_branch_snapshot() fails with -ENOENT even
   though the LBR hardware has been actively recording branches.

2. If an earlier PEBS PMI occurred, cpuc->lbr_entries[] and
   cpuc->lbr_stack.nr hold the historical branch stack from that old PEBS
   overflow sample rather than the live branches frozen at the snapshot
   point.

3. Stale or cross-task entries can also remain in cpuc->lbr_entries[] with
   cpuc->lbr_stack.nr > 0 across transitions that do not call
   intel_pmu_lbr_reset():

   arch/x86/events/intel/lbr.c:intel_pmu_lbr_add() {
       if (x86_pmu.intel_cap.pebs_baseline && event->attr.precise_ip > 0)
           cpuc->lbr_pebs_users++;
       perf_sched_cb_inc(event->pmu);
       if (!cpuc->lbr_users++ && !event->total_time_running)
           intel_pmu_lbr_reset();
   }

   Scheduling in a previously active PEBS LBR event where
   event->total_time_running > 0 (or removing a non-PEBS LBR event via
   intel_pmu_lbr_del() while a PEBS LBR event remains active) does not
   reset cpuc->lbr_stack.nr. Similarly, on a context switch with
   PERF_SAMPLE_BRANCH_CALL_STACK:

   arch/x86/events/intel/lbr.c:__intel_pmu_lbr_restore() {
       ...
       x86_pmu.lbr_restore(ctx);

       task_context_opt(ctx)->lbr_stack_state =3D LBR_NONE;
   }

   __intel_pmu_lbr_restore() updates the hardware LBR MSRs for the
   incoming task without resetting cpuc->lbr_stack.nr, leaving the
   previous task's cached cpuc->lbr_entries[] to be copied by
   __intel_pmu_snapshot_branch_stack().

> =20
>  	x86_pmu.lbr_read(cpuc);

[Severity: Medium]
Can x86_pmu.lbr_read(cpuc) leave a stale non-zero cpuc->lbr_stack.nr when
intel_pmu_arch_lbr_read_xsave() sees the hardware Arch LBR state in its
XSAVE INIT configuration?

In the preceding patch ("perf/x86/intel/lbr: Reset the cached LBR stack in
intel_pmu_lbr_reset()"), intel_pmu_arch_lbr_read_xsave() was updated to:

arch/x86/events/intel/lbr.c:intel_pmu_arch_lbr_read_xsave() {
	...
	xsaves(&xsave->xsave, XFEATURE_MASK_LBR);

	if (xsave->header.xfeatures & XFEATURE_MASK_LBR)
		intel_pmu_store_lbr(cpuc, xsave->lbr.entries);
}

When 0 branches have been recorded in hardware, the Arch LBR state is in
its XSAVE INIT configuration, so xsaves() clears XFEATURE_MASK_LBR in
xsave->header.xfeatures. Unlike the MSR fallback path
intel_pmu_store_lbr(cpuc, NULL) which reads 0 from MSR_ARCH_LBR_FROM_0 and
sets cpuc->lbr_stack.nr =3D 0, skipping intel_pmu_store_lbr() here without
an else branch leaves cpuc->lbr_stack.nr at its previous value.

If cpuc->lbr_stack.nr was non-zero from an earlier read and the hardware
Arch LBR state subsequently returns to the INIT state without
intel_pmu_lbr_reset() being called (for example, when
__intel_pmu_lbr_restore() restores a task's call-stack LBR context via
intel_pmu_arch_lbr_xrstors() whose saved xfeatures has XFEATURE_MASK_LBR
clear, when RET instructions pop all prior CALL entries in call-stack
mode, when a CPU wakes from a deep C-state that resets Arch LBR registers,
or when an LBR event with event->total_time_running > 0 is scheduled back
in), __intel_pmu_snapshot_branch_stack() will see the old
cpuc->lbr_stack.nr and copy stale cpuc->lbr_entries[] into entries.

Should intel_pmu_arch_lbr_read_xsave() set cpuc->lbr_stack.nr =3D 0 when
!(xsave->header.xfeatures & XFEATURE_MASK_LBR)?


[Severity: Medium]
Also in the earlier patch in this series ("perf/x86: Clamp x86_pmu.lbr_nr
to MAX_LBR_ENTRIES"), init_hw_perf_events() clamps x86_pmu.lbr_nr after
vendor PMU initialization has already run:

arch/x86/events/core.c:init_hw_perf_events() {
	...
	err =3D x86_pmu.init();
	...
	x86_pmu.lbr_nr =3D min(x86_pmu.lbr_nr, MAX_LBR_ENTRIES);
}

During x86_pmu.init() -> intel_pmu_init() -> intel_pmu_arch_lbr_init(),
the Arch LBR depth is selected from the highest bit in
eax.split.lbr_depth_mask (up to 64), tested against MSR_ARCH_LBR_DEPTH,
and validated against xfeature_size(XFEATURE_LBR):

arch/x86/events/intel/lbr.c:intel_pmu_arch_lbr_init() {
	...
	lbr_nr =3D fls(eax.split.lbr_depth_mask) * 8;
	if (!lbr_nr)
		goto clear_arch_lbr;

	/* Apply the max depth of Arch LBR */
	if (wrmsrq_safe(MSR_ARCH_LBR_DEPTH, lbr_nr))
		goto clear_arch_lbr;

	x86_pmu.lbr_nr =3D lbr_nr;

	if (has_arch_lbr_xsave() &&
	    xfeature_size(XFEATURE_LBR) !=3D get_lbr_state_size()) {
		WARN_ON(1);
		goto clear_arch_lbr;
	}
}

If hardware enumerates a maximum depth greater than MAX_LBR_ENTRIES (32)
in eax.split.lbr_depth_mask, clamping x86_pmu.lbr_nr to 32 afterwards in
init_hw_perf_events() means intel_pmu_arch_lbr_reset() will later execute
an unchecked wrmsrq(MSR_ARCH_LBR_DEPTH, x86_pmu.lbr_nr) with depth 32:

arch/x86/events/intel/lbr.c:intel_pmu_arch_lbr_reset() {
	/* Write to ARCH_LBR_DEPTH MSR, all LBR entries are reset to 0 */
	wrmsrq(MSR_ARCH_LBR_DEPTH, x86_pmu.lbr_nr);
}

If depth 32 (bit 3 in eax.split.lbr_depth_mask) is not supported by the
processor or VM, won't that wrmsrq(MSR_ARCH_LBR_DEPTH, 32) trigger an
unhandled #GP fault during CPU startup or LBR reset, in addition to
get_lbr_state_size() and the boot logs having used the unclamped
x86_pmu.lbr_nr?

Should intel_pmu_arch_lbr_init() mask or bound the selected depth to
MAX_LBR_ENTRIES before validating MSR_ARCH_LBR_DEPTH and
get_lbr_state_size()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019070836.2972=
403-1-dapeng1.mi@linux.intel.com?part=3D4
