Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792562718;
	b=ZTnmcwmi6F8kT4l3n0zzxJI8XUDHszG3L8RSwn+ieyFNbxNbfGtZP+g8yvG5MnyuFPOo
	 vPSg6v65VDDTwjxXRJUB2nAKFjS1itXlzjSvvy8MlMKyRM6f/XNZTfaFlX0ckvK7OKwni
	 PMmaPcnNSZCPkswzOrxkO5pTQVV8mNtgFt4rGXSYnOVUcLLECWtdhJOT0rUNYglcyXdaX
	 HT0hiH+JAJmF/fAGoE8k1ETJeTq4hmRZrha2/5tcLqmhOF8jayMIol/UCFAszSWt4Eg6F
	 4g3h+1xkDLMOAhUvcoFpzR1xd2o678yuQUu5z5MUbYcZpemOoZmv5G7BGDafmzjlADQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792562718;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8sRNmxmhmHvu5Vv7B62dYVqh3Oec8c+eb18XRGKxW8o=;
	b=Kq3t5SWBAMrtLA6pz4YThJgl/g86EIKsjGyciZu6RTzzsEo/F//yRLH0fTHNpVBLg12p
	 tNBMU+1ED0gRNjj/Ika85qokAANqo3ySIEWhYS/eQ3E7hFtH5L60Ie8PGTRaNua5B6uzY
	 EiWz0jijKpN778fW/zUmCzRzBJawb7WEk3C5oAGlt62qOIUQ3+HlZCtiD4pEArrGTTx5K
	 MOoEGPZXmPPIlwf3H7TXeOQUr7/9U3Q9V4n/y7dmXvy2LluW85NUojTWr50tOhvjF0ust
	 EJgy8TTlAOkaz40KckrorXThbQ+dMhHU07uRTQ2BhMbti/lpU1xpOzMO1I0TB5zG0iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MfrObbjr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33481606A321;
	Wed, 21 Oct 2026 06:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MfrObbjr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6001F000C9;
	Wed, 21 Oct 2026 06:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792562717;
	bh=8sRNmxmhmHvu5Vv7B62dYVqh3Oec8c+eb18XRGKxW8o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MfrObbjrNX+vI43ogQO3fDeqChlkBhOT7XUB5s2u3qv6JK2UIUfr10l9hHextg2EN
	 RSfO/1d24ImhjNvAAOcF6xt9N5xto+A3hIxYzagFbKsOCs6x1MZBZ1sbnOc3jrxgVK
	 p9W4NNIFPCpp5C9Pjz/b/pakTLPvvrDxBX8U1IalMZGccjPprxyZLVf1FGomlfFlxf
	 ARMqOI2EAArUC0Cx61o7eaGJ66U+YsRrKnHOlQimpSz/8+o/s4+G2lg7IoXT9n5f9+
	 Jbda9KxRS+Il6o7z6FRlcqjW7QdM306uGq39fPRNkSLrvJxtOOL6tLKI/+1+IP/u7P
	 dwzmOq/BKvBIw==
Message-ID: <sashiko-outbox-179823@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v4 5/5] pef/x86/intel: Always snapshot live hardware LBR
 state for BPF path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261021050711.4043703-6-dapeng1.mi@linux.intel.com>
References: <20261021050711.4043703-1-dapeng1.mi@linux.intel.com>
 <20261021050711.4043703-6-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 06:05:17 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] perf/x86/intel: LBR state corruption in __intel_pmu_snapshot_b=
ranch_stack()
- [High] perf/x86/intel: __intel_pmu_snapshot_branch_stack() enables PMU in=
 PMI
- [Medium] perf/x86/intel: unfrozen LBRs and PMU re-enable in PMI branch sn=
apshot
- [Medium] perf/x86: NMI race on lbr_snapshot in __intel_pmu_snapshot_branc=
h_stack()
- [Medium] perf/x86/intel: unfiltered LBR branch counter bits in perf_branc=
h_entry.reserved
--

commit 4d2b360d61a8a8f6825b3cd919182ee99dbe2d76
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

pef/x86/intel: Always snapshot live hardware LBR state for BPF path

This commit updates __intel_pmu_snapshot_branch_stack() to always read live
hardware LBR registers for the BPF snapshot path even when PEBS LBR users
are active. To avoid clobbering cached PEBS LBR data during a PMI, it saves
and restores cpuc->lbr_stack, cpuc->lbr_entries, and cpuc->lbr_counters
around intel_pmu_lbr_read() using a per-CPU buffer, and moves the
cpuc->lbr_users =3D=3D cpuc->lbr_pebs_users check into intel_pmu_handle_irq=
().

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 5dfb9e9156e88..07d1a8a7845b2 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2815,16 +2815,50 @@ static void intel_pmu_enable_all(int added)
>  	__intel_pmu_enable_all(added, false);
>  }
> =20
> +struct lbr_snapshot {
> +	struct perf_branch_stack stack;
> +	struct perf_branch_entry entries[MAX_LBR_ENTRIES];
> +	u64 counters[MAX_LBR_ENTRIES];
> +};
> +static DEFINE_PER_CPU(struct lbr_snapshot, lbr_snapshot);

[Severity: Medium]
Can an NMI race on the per-CPU lbr_snapshot buffer when
__intel_pmu_snapshot_branch_stack() is called in non-NMI context?

In arch/x86/events/intel/core.c, intel_pmu_snapshot_branch_stack() and
intel_pmu_snapshot_arch_branch_stack() call local_irq_save(flags) and
__intel_pmu_disable_all(false) before invoking
__intel_pmu_snapshot_branch_stack(). However, local_irq_save() only masks
normal interrupts, and an in-flight PMI or another NMI can still arrive
after __intel_pmu_disable_all() due to NMI delivery latency.

When cpuc->lbr_pebs_users > 0 and a non-NMI BPF program (such as an
fentry/fexit trampoline via __bpf_prog_enter_recur() or a raw_tracepoint,
where bpf_prog_active is not incremented) calls:

  bpf_get_branch_snapshot()
    -> intel_pmu_snapshot_branch_stack()
      -> __intel_pmu_snapshot_branch_stack()

an arriving PMI can still invoke bpf_overflow_handler() ->
bpf_get_branch_snapshot() -> __intel_pmu_snapshot_branch_stack() on the
same CPU, overwriting this_cpu_ptr(&lbr_snapshot) while the outer call is
between its save and restore steps. Even if the PMI does not call
bpf_get_branch_snapshot(), intel_pmu_handle_irq() updates cpuc->lbr_stack
and cpuc->lbr_entries while the interrupted snapshot is saving or
restoring them.

Since cpuc->lbr_stack only holds live sample data awaiting output during a
PMI, should the save and restore of cpuc->lbr_stack be restricted to NMI
context or otherwise protected against NMI reentrancy?

> +
>  static noinline int
>  __intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
>  				  unsigned int cnt, unsigned long flags)
>  {
>  	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
> +	struct lbr_snapshot *snapshot =3D this_cpu_ptr(&lbr_snapshot);
> +
> +	/*
> +	 * This may be called from bpf_event_handler() in a PMI context. If
> +	 * a PEBS LBR user is active, the PEBS sample record has already updated
> +	 * cpuc->lbr_stack. Reading the LBR registers here would overwrite that
> +	 * cached PEBS LBR stack, so save it first and restore it afterward. Th=
is
> +	 * keeps the cached LBR data available for later output to userspace in
> +	 * the normal PEBS record path.
> +	 */
> +	if (cpuc->lbr_pebs_users) {
> +		memcpy(&snapshot->stack, &cpuc->lbr_stack,
> +		       sizeof(struct perf_branch_stack));
> +		memcpy(snapshot->entries, cpuc->lbr_entries,
> +		       sizeof(struct perf_branch_entry) * cpuc->lbr_stack.nr);
> +		memcpy(snapshot->counters, cpuc->lbr_counters,
> +		       sizeof(u64) * cpuc->lbr_stack.nr);
> +	}

[Severity: Critical]
What happens in __intel_pmu_snapshot_branch_stack() when cpuc->lbr_users
is non-zero, but cpuc->lbr_pebs_users is 0?

In arch/x86/events/intel/lbr.c:intel_pmu_lbr_add(), cpuc->lbr_pebs_users
is only incremented when x86_pmu.intel_cap.pebs_baseline is set and
event->attr.precise_ip > 0:

	if (x86_pmu.intel_cap.pebs_baseline && event->attr.precise_ip > 0)
		cpuc->lbr_pebs_users++;

When non-PEBS hardware LBR events (precise_ip =3D=3D 0), legacy PEBS LBR
events (pre-Ice Lake where pebs_baseline =3D=3D 0), or Architectural PEBS L=
BR
events (arch/x86/events/intel/ds.c:setup_arch_pebs_sample_data(), where
pebs_baseline =3D=3D 0) are active, cpuc->lbr_users > 0 while
cpuc->lbr_pebs_users =3D=3D 0.

In those paths, handle_pmi_common(), setup_pebs_fixed_sample_data(), and
setup_arch_pebs_sample_data() call intel_pmu_lbr_save_brstack() before
perf_event_overflow() -> __perf_event_overflow() ->
bpf_overflow_handler():

	if (has_branch_stack(event))
		intel_pmu_lbr_save_brstack(&data, cpuc, event);
	...
	perf_event_overflow(event, &data, regs);

Inside include/linux/perf_event.h:perf_sample_save_brstack(), brs
(&cpuc->lbr_stack) is clamped in place and used to precompute
data->dyn_size:

	brs->nr =3D min_t(u16, event->attr.sample_max_stack, brs->nr);
	size +=3D brs->nr * sizeof(struct perf_branch_entry);
	if (brs_cntr)
		size +=3D brs->nr * sizeof(u64);
	data->br_stack =3D brs;
	data->br_stack_cntr =3D brs_cntr;
	data->dyn_size +=3D size;
	data->sample_flags |=3D PERF_SAMPLE_BRANCH_STACK;

If bpf_overflow_handler() then calls bpf_get_branch_snapshot() ->
__intel_pmu_snapshot_branch_stack() with cpuc->lbr_pebs_users =3D=3D 0, the
save and restore of cpuc->lbr_stack, cpuc->lbr_entries, and
cpuc->lbr_counters are skipped, and intel_pmu_lbr_read() overwrites them
in place:

1. In kernel/events/core.c:perf_output_sample(), data->br_stack still
   points to &cpuc->lbr_stack. Because intel_pmu_lbr_read() resets
   cpuc->lbr_stack.nr up to x86_pmu.lbr_nr, undoing the sample_max_stack
   clamp after data->dyn_size was already computed, perf_output_sample()
   can copy more perf_branch_entry (and counter) elements than
   perf_output_begin() reserved in the ring buffer.

2. The frozen LBR entries captured at PMI entry (or from the Arch PEBS
   record) in cpuc->lbr_entries are overwritten by unfrozen post-ack LBR
   registers containing PMI handler branches.

3. For branch counter groups, intel_pmu_lbr_counters_reorder() has already
   extracted counter bits from cpuc->lbr_entries[i].reserved into
   cpuc->lbr_counters[i] and cleared .reserved; calling
   intel_pmu_lbr_read() -> intel_pmu_store_lbr() writes raw counter bits
   back into cpuc->lbr_entries[i].reserved and desynchronizes
   cpuc->lbr_counters[].

Should the save and restore in __intel_pmu_snapshot_branch_stack() be
gated on cpuc->lbr_users instead of cpuc->lbr_pebs_users (and save/restore
based on the pre-clamp entry count or full array when needed)?

> =20
>  	intel_pmu_lbr_read();
>  	cnt =3D min_t(unsigned int, cnt, cpuc->lbr_stack.nr);
> -
>  	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * c=
nt);

[Severity: Medium]
On platforms with Architectural LBR and branch counter logging, does
copying cpuc->lbr_entries directly after intel_pmu_lbr_read() leak raw
branch counter bits in entries[i].reserved to BPF programs?

When intel_pmu_snapshot_arch_branch_stack() calls
__intel_pmu_snapshot_branch_stack(), intel_pmu_lbr_read() invokes
intel_pmu_arch_lbr_read() or intel_pmu_arch_lbr_read_xsave(), which calls
arch/x86/events/intel/lbr.c:intel_pmu_store_lbr():

	/*
	 * Leverage the reserved field of
	 * cpuc->lbr_entries[i] to temporarily store the
	 * branch counters information. The later code will
	 * decide what content can be disclosed to the perf
	 * tool. Pleae see intel_pmu_lbr_counters_reorder().
	 */
	.reserved =3D (info >> LBR_INFO_BR_CNTR_OFFSET) &
		    LBR_INFO_BR_CNTR_FULL_MASK,

Normally intel_pmu_lbr_counters_reorder() filters those bits and clears
cpuc->lbr_entries[i].reserved to 0 before the entries are exposed. Since
__intel_pmu_snapshot_branch_stack() copies cpuc->lbr_entries directly into
entries without calling intel_pmu_lbr_counters_reorder(), won't the raw
hardware counter bits remain in the UAPI perf_branch_entry.reserved field
returned by bpf_get_branch_snapshot()?

> +
> +	if (cpuc->lbr_pebs_users) {
> +		memcpy(&cpuc->lbr_stack, &snapshot->stack,
> +		       sizeof(struct perf_branch_stack));
> +		memcpy(cpuc->lbr_entries, snapshot->entries,
> +		       sizeof(struct perf_branch_entry) * cpuc->lbr_stack.nr);
> +		memcpy(cpuc->lbr_counters, snapshot->counters,
> +		       sizeof(u64) * cpuc->lbr_stack.nr);
> +	}
> +
>  	intel_pmu_enable_all(0);

[Severity: High]
Is it safe for __intel_pmu_snapshot_branch_stack() to unconditionally call
intel_pmu_enable_all(0) when invoked from bpf_overflow_handler() in a PMI?

In arch/x86/events/intel/core.c:intel_pmu_handle_irq(), the PMI handler
saves cpuc->enabled, sets cpuc->enabled =3D 0, and disables the PMU in
hardware:

	pmu_enabled =3D cpuc->enabled;
	...
	cpuc->enabled =3D 0;
	__intel_pmu_disable_all(true);

The PMI handler expects the PMU, PEBS, BTS, and LBRs to remain disabled in
hardware while handle_pmi_common() and __intel_pmu_pebs_last_event() drain
PEBS records and reprogram counter periods, only restoring the hardware
state at the done label if pmu_enabled was set:

	/* Only restore PMU state when it's active. See x86_pmu_disable(). */
	cpuc->enabled =3D pmu_enabled;
	if (pmu_enabled)
		__intel_pmu_enable_all(0, true);

When a BPF program runs via perf_event_overflow() ->
bpf_overflow_handler() during a PMI and calls bpf_get_branch_snapshot() ->
__intel_pmu_snapshot_branch_stack(), calling intel_pmu_enable_all(0)
invokes x86_pmu_pebs_enable_all() and __intel_pmu_enable_all(0, false)
while cpuc->enabled is 0. This re-enables MSR_IA32_PEBS_ENABLE, LBRs, BTS,
and MSR_CORE_PERF_GLOBAL_CTRL before __intel_pmu_pebs_last_event() and
handle_pmi_common() finish reprogramming counter periods, and leaves the
hardware PMU enabled after the PMI exits if the PMI interrupted an
x86_pmu_disable() section where pmu_enabled was 0.

Should __intel_pmu_snapshot_branch_stack() avoid calling
intel_pmu_enable_all(0) when cpuc->enabled is 0?

>  	local_irq_restore(flags);
>  	return cnt;
> @@ -4022,7 +4056,12 @@ static int intel_pmu_handle_irq(struct pt_regs *re=
gs)
> =20
>  	loops =3D 0;
>  again:
> -	intel_pmu_lbr_read();
> +	/*
> +	 * No need to read the LBR stack when all LBR users are PEBS events,
> +	 * since the PEBS handler updates it.
> +	 */
> +	if (cpuc->lbr_users !=3D cpuc->lbr_pebs_users)
> +		intel_pmu_lbr_read();
>  	intel_pmu_ack_status(status);

[Severity: Medium]
When cpuc->lbr_users =3D=3D cpuc->lbr_pebs_users and a BPF program calls
bpf_get_branch_snapshot() from bpf_overflow_handler() during a PMI, haven't
the hardware LBR registers already been unfrozen by
intel_pmu_ack_status(status)?

In arch/x86/events/intel/core.c:intel_pmu_handle_irq(),
__intel_pmu_disable_all(true) clears MSR_CORE_PERF_GLOBAL_CTRL but does
not clear LBR enable bits in MSR_IA32_DEBUGCTLMSR or MSR_ARCH_LBR_CTL,
relying on GLOBAL_STATUS_LBRS_FROZEN to keep the LBR stack frozen.

As noted in arch/x86/events/intel/lbr.c:__intel_pmu_lbr_enable():

	/*
	 * No need to unfreeze manually, as v4 can do that as part
	 * of the GLOBAL_STATUS ack.
	 */
	if (pmi && x86_pmu.version >=3D 4)
		return;

On PMU v4+ platforms (which include all pebs_baseline platforms), calling
intel_pmu_ack_status(status) clears GLOBAL_STATUS_LBRS_FROZEN and
immediately unfreezes the hardware LBRs. By the time handle_pmi_common() ->
x86_pmu_drain_pebs() -> __intel_pmu_pebs_last_event() sets up the PEBS
sample and invokes bpf_overflow_handler() ->
__intel_pmu_snapshot_branch_stack(), the unfrozen hardware LBR MSRs have
been recording branches inside the PMI handler itself (and
__intel_pmu_snapshot_branch_stack() then also calls intel_pmu_enable_all(0)
before the PMI finishes).

Can __intel_pmu_snapshot_branch_stack() still obtain an unpolluted hardware
LBR snapshot in this PMI path after intel_pmu_ack_status(status) has
unfrozen the LBRs?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021050711.4043=
703-1-dapeng1.mi@linux.intel.com?part=3D5
