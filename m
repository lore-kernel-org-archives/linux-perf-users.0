Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA1328373
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 03:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786074370; cv=none; b=Q7zGrRXRlYvy7sW2ftgxRfft0MuxusjAXvehlnBIgXx60yJ/PoC1vQEoG1AVbW1d/PcDzGzfbR1SGHTfToy+rWfK03xhqCM5nG54r3USEBapt2Pswc52ztkGLzZ7BVIJtKEjbzMc8WJxf0sRp7ETFyvpeO9uBZpWXcXNdqD/vo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786074370; c=relaxed/simple;
	bh=gVDpOteyigwCl+PnMoWT7XIKCdtFBQlTJh4ja9exKy8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H2tlBoBRwj2WJ733Wzq344w3qVGvmflyYVMhjHXpN/X9J9xrnZSslbPz57AQ//D0UdXoRGIrV21NbzjowHU1acBf61HtLMvf27Pj4fw6800KZ5tul4hq6GRy72rVk6jWoAGvw5JLqHXoDePW0wZ/Xtt+ya54u2W84PNl1YHuRvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEqPkVp+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEqPkVp+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E841F000E9;
	Fri,  7 Aug 2026 03:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786074369;
	bh=fPg+wdecWH9OzPHvQoIsIIpqR6wXbGR0qaYoBJgX0dE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cEqPkVp+TnY5oI8a6IB7YA2Dn1I8xiuz33gcim+SdjThIaZZCAbqJpRn+o5A0PzrI
	 sL4szt67o0MZpPseehKAzyBbtySGX1mMYcaZq1LjOZ6F2BaqBkxm9lgyBjp5HWbBqb
	 CczIAdmAdRdWlh/E52DueZtl4KHxPoHdc/VnBUbVoRjVtGZ8mxTytvpJ2u+8SYxxYU
	 JknmfE2pGA4uChJalRbaw+pV5HLIjBeNyVZApSGYd62/Tcohh/mj5BwEPa34sxQhYI
	 ASfAVS31KMRBOPZh3h2+JW40lZ9Fp0fjByrolvcnlOBbB6E4naEbqI+2zl+p34Fpls
	 ucR73u6v/RlEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf: RISC-V: check cpu_hw_evt before dereference in
 overflow IRQ
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xixin Liu" <liuxixin@kylinos.cn>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <prp0001riscv.1786064390.git.liuxixin@kylinos.cn>
References: <prp0001riscv.1786064390.git.liuxixin@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 03:46:08 +0000
Message-Id: <20260807034608.D4E841F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but skipping non-sam=
pling events during overflow handling fails to clear their hardware overflo=
w state, causing an interrupt storm.
- [High] This problem wasn't introduced by this patch, but the `BIT()` macr=
o is improperly used with 64-bit masks, causing undefined behavior and corr=
uption on RV32 systems when counter indices are >=3D 32.
- [High] This problem wasn't introduced by this patch, but incorrect interr=
upt pending bit clearance bypasses alternative instructions, causing interr=
upt storms on custom PMUs (e.g., Andes).
- [High] This problem wasn't introduced by this patch, but global variable =
`cmask` is defined as a 32-bit `unsigned long` on RV32 but is processed as =
a 64-bit bitmap, causing out-of-bounds memory reads.
- [High] This problem wasn't introduced by this patch, but restarting overf=
lowed hardware counters incorrectly mixes `unsigned long` arrays with `u64`=
 masks, breaking counter isolation for indices >=3D 32 on RV32 systems.
--

--- Patch [1]: [PATCH] perf: RISC-V: check cpu_hw_evt before dereference in=
 overflow IRQ ---
commit 4fa941d0eec411e362522077608e4fec275e7349
Author: Xixin Liu <liuxixin@kylinos.cn>

perf: RISC-V: check cpu_hw_evt before dereference in overflow IRQ

The overflow IRQ handler dereferences cpu_hw_evt before the null check.
Move the check first. Defensive only; the cookie is valid on the normal
path today.

> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 50220f7b46d9b..cb7148d0c87ad 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -1050,11 +1050,13 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, v=
oid *dev)
>  	u64 overflowed_ctrs =3D 0;
>  	struct cpu_hw_events *cpu_hw_evt =3D dev;
>  	u64 start_clock =3D sched_clock();
> -	struct riscv_pmu_snapshot_data *sdata =3D cpu_hw_evt->snapshot_addr;
> +	struct riscv_pmu_snapshot_data *sdata;
> =20
>  	if (WARN_ON_ONCE(!cpu_hw_evt))
>  		return IRQ_NONE;
> =20
> +	sdata =3D cpu_hw_evt->snapshot_addr;
> +
>  	/* Firmware counter don't support overflow yet */
>  	fidx =3D find_first_bit(cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTERS);
>  	if (fidx =3D=3D RISCV_MAX_COUNTERS) {

[Severity: High]
This isn't a bug introduced by this patch, but does clearing the interrupt
pending bit manually here bypass alternative instructions?

For the Andes custom PMU, riscv_pmu_irq_num evaluates to 274. Using
BIT(274) on a 64-bit integer overflows and wraps to BIT(18), which would
erroneously clear bit 18 in the standard CSR_SIP register instead of using
the custom register.

Could this cause an interrupt storm on custom PMUs like Andes?


[Severity: High]
This problem wasn't introduced by this patch, but looking further down in
pmu_sbi_ovf_handler(), does skipping non-sampling events during overflow
handling fail to clear their hardware overflow state?

drivers/perf/riscv_pmu_sbi.c:pmu_sbi_ovf_handler() {
    ...
		/* Skip if invalid event or user did not request a sampling */
		if (!event || !is_sampling_event(event))
			continue;
    ...
}

When a non-sampling counting event overflows, its bit isn't added to
overflowed_ctrs.=20

Consequently, when restarting the counter, the
SBI_PMU_START_FLAG_SET_INIT_VALUE flag isn't set, which means the hardware
overflow state (scountovf) isn't cleared and the interrupt is immediately
re-asserted.

Will this cause an interrupt storm?


[Severity: High]
This is a pre-existing issue, but does using the BIT() macro against 64-bit
variables like overflow and overflowed_ctrs cause undefined behavior on
32-bit RISC-V systems?

drivers/perf/riscv_pmu_sbi.c:pmu_sbi_ovf_handler() {
    ...
		/* check if the corresponding bit is set in scountovf or overflow mask in=
 shmem */
		if (!(overflow & BIT(hidx)))
			continue;

		/*
		 * Keep a track of overflowed counters so that they can be started
		 * with updated initial value.
		 */
		overflowed_ctrs |=3D BIT(lidx);
    ...
}

On RV32, BIT() resolves to a 32-bit unsigned long, so shifting by 32 or more
results in truncation or wrapping.=20

Should this use BIT_ULL() instead?


[Severity: High]
This problem wasn't introduced by this patch, but is cmask undersized
for a 64-bit bitmap on 32-bit architectures?

drivers/perf/riscv_pmu_sbi.c:
...
static unsigned long cmask;
...

drivers/perf/riscv_pmu_sbi.c:pmu_sbi_event_map() {
    ...
	for_each_set_bit(i, &cmask, RISCV_MAX_COUNTERS) {
    ...
}

On RV32, unsigned long is 4 bytes, but for_each_set_bit() with
RISCV_MAX_COUNTERS (64) expects an 8-byte buffer, which would cause an
out-of-bounds read into adjacent memory.=20

Should this be defined using DECLARE_BITMAP(cmask, RISCV_MAX_COUNTERS)?


[Severity: High]
This is a pre-existing issue, but does this bitwise operation incorrectly m=
ix
a 32-bit unsigned long element (on RV32) with a 64-bit u64 mask?

drivers/perf/riscv_pmu_sbi.c:pmu_sbi_start_ovf_ctrs_sbi() {
    ...
		ctr_start_mask =3D cpu_hw_evt->used_hw_ctrs[i] & ~ctr_ovf_mask;
    ...
}

For i=3D1 (handling counters 32-63), the 64-bit result is truncated when
assigned to the 32-bit ctr_start_mask, erroneously evaluating against the
lower 32 bits of ctr_ovf_mask instead of the upper 32 bits.

Could this break counter isolation for indices >=3D 32?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/prp0001riscv.178606=
4390.git.liuxixin@kylinos.cn?part=3D1
