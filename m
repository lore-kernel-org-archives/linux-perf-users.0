Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950D33CC9E9;
	Tue,  9 Jun 2026 06:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780986194; cv=none; b=hXYavuDdO7wP+B+mbRpHlZlcZ7mg5tDDnlB4GOo49G07bOIXYux9NPmY3BPYfdV5tJ2gyCdR/eAPFqXLwkdGseDnKXgmx77TPu0TQye9wIhl9xbIm1cOUXNRqqA4XCIMgPlf498MydiPoxMvpxl0vurgtFaXslVDckxE6sb5nK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780986194; c=relaxed/simple;
	bh=j3F2e2UjRFacqbpiK2f0qacC98jMZkUp2uW3ozs87uA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JpIwLiw63qmWXdU1z1fENEPO62Y3xuheXAISzgcIP4+L8QUJgm7M6zsSSO4bThwohqAzj8gikaUq+JfPX81mPyWQZCrzEoqYlz2y2dvoa3VxkDcUP85g4xCFWZBM6WM15M976YjfyaBj+/sFzjKRVnK8AnNlAOQdsbclnGZ1LHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzQ5sz1e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzQ5sz1e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35D11F00898;
	Tue,  9 Jun 2026 06:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780986193;
	bh=lyFj2kDucph49/ngSumvxI3tiOmTvvCdaTVY6NPmkw0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NzQ5sz1erb2LVODOvvcKr06+hqxrSgB1TC1KBJDNb9gGnbQM7NLdoEzTl9LqFc6/t
	 N+nKvx9DVO9Ui6WybZhFm1a3uc+FSErGkFH6Qshmi4IRD91BJMoGcHGscBwdP64cVC
	 XszTdELiuBbKLfGzS18xB4oworeF9TI/fILqRS8+J426f/0/6iath0KI+06Y/dG9pI
	 mwxQEFHX7O5HS15BGtcp12k42649kOFVNVJjuCxn14T+fR+HLtreggdnvh5sTx5Eu1
	 EddXgDvAaKuScHs0C0F3MzcSuih1ahT4c8nAzNJcYYrmDkUCiDbAIF+naEdZuJ0G5w
	 9t4FadHqhWRjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 15/21] RISC-V: perf: Use config2/vendor table for
 event to counter mapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: devicetree@vger.kernel.org, linux-perf-users@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260608-counter_delegation-v6-15-285b72ed65a9@meta.com>
References: <20260608-counter_delegation-v6-15-285b72ed65a9@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 06:23:12 +0000
Message-Id: <20260609062312.E35D11F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] KVM guest events for CPU cycles and instructions will fail to map =
to fixed hardware counters when counter delegation is enabled.
- [High] Fixed counter allocation unconditionally prioritizes the fixed cou=
nter index without checking its availability, breaking fallback to programm=
able counters.
- [High] Legacy events restricted to fixed counters via the vendor map fail=
 to schedule.
- [High] `get_deleg_fixed_hw_idx()` assigns fixed counters without verifyin=
g if they are actually delegated by hardware (`cmask`), enabling unprivileg=
ed DoS.
- [Medium] Missing checks for zero before calling `__fls()` leads to undefi=
ned behavior.
--

commit 3c807d0dbddd7902bf02e21b17bb5bf036dd3178
Author: Atish Patra <atishp@rivosinc.com>

RISC-V: perf: Use config2/vendor table for event to counter mapping

The counter restriction specified in the json file is passed to
the drivers via config2 paarameter in perf attributes. This allows
any platform vendor to define their custom mapping between event and
hpmcounters without any rules defined in the ISA.

> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 5bfcd3821f572..4b4f151a0744d 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c

[ ... ]

> @@ -1480,24 +1482,80 @@ static int rvpmu_deleg_find_ctrs(void)
>  	return num_hw_ctr;
>  }
> =20
> +/*
> + * The json file must correctly specify counter 0 or counter 2 is availa=
ble
> + * in the counter lists for cycle/instret events. Otherwise, the drivers=
 have
> + * no way to figure out if a fixed counter must be used and pick a progr=
ammable
> + * counter if available.
> + */
>  static int get_deleg_fixed_hw_idx(struct cpu_hw_events *cpuc, struct per=
f_event *event)
>  {
> -	return -EINVAL;
> +	struct hw_perf_event *hwc =3D &event->hw;
> +	bool guest_events =3D event->attr.config1 & RISCV_PMU_CONFIG1_GUEST_EVE=
NTS;
> +
> +	if (guest_events) {
> +		if (hwc->event_base =3D=3D SBI_PMU_HW_CPU_CYCLES)
> +			return 0;

[Severity: High]
Does this check fail to map KVM guest events to fixed hardware counters
when counter delegation is enabled?

The check relies on hwc->event_base being populated with generic SBI
event IDs. However, under counter delegation, rvpmu_cdeleg_event_map()
sets econfig but returns 0 on success. This return value is assigned to
hwc->event_base, making it permanently 0.

Could this cause the comparison against SBI_PMU_HW_CPU_CYCLES (1) to
always fail and return -EINVAL?

> +		if (hwc->event_base =3D=3D SBI_PMU_HW_INSTRUCTIONS)
> +			return 2;
> +		else
> +			return -EINVAL;
> +	}
> +
> +	if (!event->attr.config2)
> +		return -EINVAL;

[Severity: High]
Are we inadvertently rejecting fixed counters for legacy events here
unless userspace explicitly provides config2?

For standard legacy events (like perf stat -e cycles), config2 is 0, so
it falls through to get_deleg_next_hpm_hw_idx(). If a vendor restricted
an event to fixed counters via the vendor map, would returning -EINVAL
here cause standard perf commands to fail?

> +
> +	if (event->attr.config2 & RISCV_PMU_CYCLE_FIXED_CTR_MASK)
> +		return 0; /* CY counter */

[Severity: High]
Is it safe to assign fixed counters based directly on userspace config
without validating if they are actually delegated by hardware (cmask)?

If the platform did not delegate these counters, they remain
uninitialized in pmu_ctr_list. Unprivileged users could request these
counters and cause perf to read CSR 0, triggering
pr_err("Invalid performance counter csr...") on every PMU read.

Could this flood the kernel log and enable a Denial of Service?

[Severity: High]
This block unconditionally prioritizes the fixed counter index (0 or 2)
without checking if the counter is already in use.

If the fixed counter is busy, rvpmu_deleg_ctr_get_idx() attempts
test_and_set_bit() on it, fails, and jumps directly to out_err.

Could this break the fallback logic in get_deleg_next_hpm_hw_idx(),
which might have successfully allocated an available programmable
counter allowed by the config2 mask?

> +	else if (event->attr.config2 & RISCV_PMU_INSTRUCTION_FIXED_CTR_MASK)
> +		return 2; /* IR counter */
> +	else
> +		return -EINVAL;
>  }
> =20
>  static int get_deleg_next_hpm_hw_idx(struct cpu_hw_events *cpuc, struct =
perf_event *event)
>  {
> -	unsigned long hw_ctr_mask =3D 0;
> +	u32 hw_ctr_mask =3D 0, temp_mask =3D 0;
> +	u32 type =3D event->attr.type;
> +	u64 config =3D event->attr.config;
> +	int ret;
> =20
> -	/*
> -	 * TODO: Treat every hpmcounter can monitor every event for now.
> -	 * The event to counter mapping should come from the json file.
> -	 * The mapping should also tell if sampling is supported or not.
> -	 */
> +	/* Select only available hpmcounters */
> +	hw_ctr_mask =3D cmask & (~0x7) & ~(cpuc->used_hw_ctrs[0]);

[Severity: High]
By explicitly excluding fixed counters (~0x7) from the available mask
here, do we prevent legacy events from scheduling if they are restricted
to fixed counters via the vendor map?

If the event falls back from get_deleg_fixed_hw_idx() due to config2
being 0, and the vendor mapped the event exclusively to a fixed counter
(temp_mask =3D 1 or 4), hw_ctr_mask &=3D temp_mask will result in 0.

Would this cause the function to return -EINVAL and break standard perf
commands?

[ ... ]

> @@ -1526,10 +1584,6 @@ static int rvpmu_deleg_ctr_get_idx(struct perf_eve=
nt *event)
>  	u64 priv_filter;
>  	int idx;
> =20
> -	/*
> -	 * TODO: We should not rely on SBI Perf encoding to check if the event
> -	 * is a fixed one or not.
> -	 */
>  	if (!is_sampling_event(event)) {
>  		idx =3D get_deleg_fixed_hw_idx(cpuc, event);

[Severity: High]
Will KVM guest events that map to fixed hardware counters be skipped
here since they define a sample period?

Because is_sampling_event() evaluates to true for guest events, it
appears they will bypass this fixed counter assignment block entirely.

>  		if (idx =3D=3D 0 || idx =3D=3D 2) {

[ ... ]

> @@ -1547,10 +1601,14 @@ static int rvpmu_deleg_ctr_get_idx(struct perf_ev=
ent *event)
>  		goto out_err;
>  found_idx:
>  	priv_filter =3D get_deleg_priv_filter_bits(event);
> +	if (test_and_set_bit(idx, cpuc->used_hw_ctrs))
> +		goto out_err;
>  	update_deleg_hpmevent(idx, hwc->config, priv_filter);
> +	return idx;
>  skip_update:
> -	if (!test_and_set_bit(idx, cpuc->used_hw_ctrs))
> -		return idx;
> +	if (test_and_set_bit(idx, cpuc->used_hw_ctrs))
> +		goto out_err;
> +	return idx;

[Severity: Medium]
Are there missing checks for zero before calling __fls() in the
surrounding code within rvpmu_deleg_ctr_get_idx() and
get_deleg_hw_ctr_width()?

The macro __fls() maps directly to __builtin_clzl(), which results in
undefined behavior if the input is 0.

Could this happen in rvpmu_deleg_ctr_get_idx() if no hardware counters
are delegated and cmask is 0, or in get_deleg_hw_ctr_width() if a
hypervisor configures the WARL CSR as hardwired to 0?

>  out_err:
>  	return -ENOENT;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-counter_de=
legation-v6-0-285b72ed65a9@meta.com?part=3D15
