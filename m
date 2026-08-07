Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D8334DCE0
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 09:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786094231; cv=none; b=RXUl5igVELRhVPt2de8gGIiaTTQdTEUjx+87EEbK67iAffdhqb0UmNZPYlD0QMTR3+MIcE2sOS6GAhxzZMzxst4Db5DKHJCN1EG4wQQ1N5xQ8WU2xKfJp4zMtwP8lj76YW22D7XZNlpiJSAybx5P8iNxJ5+P6aC+MNA1JUlsB4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786094231; c=relaxed/simple;
	bh=fHWEiM8x0gEin26oxlBByGH/SvqyHWN8avgJ4NuJrlY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I2RLvHKxFi6GwAivi41OQldnb45FriuwWi+OLi5s+CY71fUAI58R4F+gjXIxdRmcChQZh0bW0sKunhvxgGDpjmpPt0sF6HUPlxyvBK4qHbSkjdvBZNrszDTijpQy0CUlG7X1S7NeQBLM2ugUT/wiZM0XZombP/BJqX0gqJVQFQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOraT54q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOraT54q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87F01F000E9;
	Fri,  7 Aug 2026 09:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786094229;
	bh=Cl1ECq4bBesXGsAoI+S/3oQPqf/4B/nA81fKaWRCrr0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eOraT54q/I6rUG3Q21kRrYRMbvfkVzkg2u7CYKVSXu9xUul7xm7dmQU3LXymFBhOU
	 ljf/oxMxcxqf6aQ4mwt3jGUuVEjYHdVQT7fjyV71kKmBQjAzqVM5p75KuwAsjdLALN
	 k9sf26r4HOSUd7ECDmraOsZTsZaata2QWMo0eO6/jiW3wKBdCv3CIUbSJ8K0kFPFjV
	 RH5u8F4sTfPHk4TDfMXpxDV1KnG+vMbjxO+/xg9E9KZeYufPVaA0tMoMuGzzIw9Qix
	 14dw0QaqBTw+Eg+HNIh280KdKuukvvq5qImzPIEfWWsgqTcgKJQLeyGUFDvefBsDLB
	 7pkj2bJ75q6og==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] perf: RISC-V: use BIT_ULL for u64 overflow masks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xixin Liu" <liuxixin@kylinos.cn>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <prpmask01bitul.1786092600.git.liuxixin@kylinos.cn>
References: <cover.1786092600.git.liuxixin@kylinos.cn>
 <prpmask01bitul.1786092600.git.liuxixin@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 09:17:09 +0000
Message-Id: <20260807091709.C87F01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Invalid SBI base index due to out-of-scope loop variable in pmu_sb=
i_start_ovf_ctrs_snapshot().
- [High] Incorrect mask arithmetic in pmu_sbi_start_ovf_ctrs_sbi() on RV32 =
mixes up counter indices.
- [High] Buffer over-read and undefined shift behavior due to global cmask =
being an unsigned long.
- [High] Early exit path in pmu_sbi_ovf_handler() triggers undefined shift =
and incorrect CSR access on Andes custom PMUs.
- [High] Absolute 64-bit SBI PMU snapshot shared memory structures are inco=
rrectly shifted or indexed relative to cbase on RV32.
--

--- Patch [1]: [PATCH v1 1/2] perf: RISC-V: use BIT_ULL for u64 overflow ma=
sks ---
commit d452f12b31f1955f29f737a7fc0bc5084ebd71af
Author: Xixin Liu <liuxixin@kylinos.cn>
Subject: perf: RISC-V: use BIT_ULL for u64 overflow masks

This patch replaces BIT() with BIT_ULL() for u64 overflow status and
restart masks in the RISC-V SBI PMU driver. This fixes truncation and
wrapping issues on RV32 where BIT() resolves to an unsigned long shift.

> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 50220f7b46d9b..8ea5ae6173471 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -1002,7 +1002,7 @@ static inline void pmu_sbi_start_ovf_ctrs_snapshot(=
struct cpu_hw_events *cpu_hw_
>  	struct riscv_pmu_snapshot_data *sdata =3D cpu_hw_evt->snapshot_addr;
> =20
>  	for_each_set_bit(idx, cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTERS) {
> -		if (ctr_ovf_mask & BIT(idx)) {
> +		if (ctr_ovf_mask & BIT_ULL(idx)) {
>  			event =3D cpu_hw_evt->events[idx];
>  			hwc =3D &event->hw;
>  			max_period =3D riscv_pmu_ctr_get_width_mask(event);

[Severity: High]
This isn't a bug introduced by this patch, but since we're fixing issues in
pmu_sbi_start_ovf_ctrs_snapshot(), there is an SBI base index problem sligh=
tly
lower in this same function:

pmu_sbi_start_ovf_ctrs_snapshot() {
    ...
    for (i =3D 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++) {
        for_each_set_bit(idx, &cpu_hw_evt->used_hw_ctrs[i], BITS_PER_LONG)
            ...
        sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, idx * BITS_PER_LO=
NG,
                  cpu_hw_evt->used_hw_ctrs[i], flag, 0, 0, 0);
    }
}

Does this pass an invalid base index to the SBI firmware? The for_each_set_=
bit()
macro terminates with idx equal to BITS_PER_LONG. So idx * BITS_PER_LONG wo=
uld
evaluate to something like 4096 on RV64, which seems like it would cause an
SBI_ERR_INVALID_PARAM error. Should this use i * BITS_PER_LONG instead?

[Severity: High]
This is another pre-existing issue in pmu_sbi_start_ovf_ctrs_snapshot() rel=
ated
to RV32 shared memory structures:

pmu_sbi_start_ovf_ctrs_snapshot() {
    ...
    for (i =3D 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++) {
        for_each_set_bit(idx, &cpu_hw_evt->used_hw_ctrs[i], BITS_PER_LONG)
            sdata->ctr_values[idx] =3D
                cpu_hw_evt->snapshot_cval_shcopy[idx + i * BITS_PER_LONG];
    ...
}

Since ctr_values is a 64-element array indexed by absolute counter IDs, does
using the relative idx (0-31) incorrectly overwrite the states of counters =
0-31
when processing chunk i=3D1 (counters 32-63)?

[ ... ]

> @@ -1109,14 +1109,14 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, v=
oid *dev)
>  			hidx =3D info->csr - CSR_CYCLE;
> =20
>  		/* check if the corresponding bit is set in scountovf or overflow mask=
 in shmem */
> -		if (!(overflow & BIT(hidx)))
> +		if (!(overflow & BIT_ULL(hidx)))
>  			continue;
> =20
>  		/*
>  		 * Keep a track of overflowed counters so that they can be started
>  		 * with updated initial value.
>  		 */
> -		overflowed_ctrs |=3D BIT(lidx);
> +		overflowed_ctrs |=3D BIT_ULL(lidx);
>  		hw_evt =3D &event->hw;
>  		/* Update the event states here so that we know the state while readin=
g */
>  		hw_evt->state |=3D PERF_HES_STOPPED;

[Severity: High]
This is a pre-existing issue, but while looking at pmu_sbi_ovf_handler(), t=
he
early exit path near the beginning of the function caught my eye:

pmu_sbi_ovf_handler() {
    ...
    fidx =3D find_first_bit(cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTERS);
    if (fidx =3D=3D RISCV_MAX_COUNTERS) {
        csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
        return IRQ_NONE;
    }
    ...
}

For the Andes custom PMU, riscv_pmu_irq_num can be assigned values like 274
(ANDES_SLI_CAUSE_BASE + ANDES_RV_IRQ_PMOVI). Does BIT(274) cause an undefin=
ed
out-of-bounds shift? Furthermore, does clearing CSR_SIP work for Andes PMUs
which use custom SLIE CSRs for these IRQs? Could this lead to an unacknowle=
dged
interrupt storm?

[Severity: High]
This is a pre-existing issue, but I noticed another mask arithmetic problem=
 on
RV32 that might cause broken PMU statistics. In pmu_sbi_start_ovf_ctrs_sbi(=
):

pmu_sbi_start_ovf_ctrs_sbi() {
    ...
    for (i =3D 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++) {
        ...
        ctr_start_mask =3D cpu_hw_evt->used_hw_ctrs[i] & ~ctr_ovf_mask;
        ...
}

On RV32, when i =3D 1 (counters 32-63), used_hw_ctrs[1] is a 32-bit unsigne=
d long,
but ctr_ovf_mask is a 64-bit absolute mask. Since ~ctr_ovf_mask isn't shift=
ed
down by i * BITS_PER_LONG, doesn't this evaluate the usage bits for counters
32-63 against the overflow status of counters 0-31?

[Severity: High]
This is also a pre-existing issue, but related to 32-bit mask truncation, i=
s the
global cmask variable affected?

drivers/perf/riscv_pmu_sbi.c:
    static unsigned long cmask;

pmu_sbi_get_hpm_info() {
    ...
    for_each_set_bit(i, &cmask, RISCV_MAX_COUNTERS) {
    ...
}

On RV32, unsigned long is 32 bits, but RISCV_MAX_COUNTERS is 64. Does calli=
ng
for_each_set_bit() here force a 64-bit read that accesses out-of-bounds mem=
ory
adjacent to cmask? Should cmask be declared with DECLARE_BITMAP()?

[Severity: High]
Finally, this is a pre-existing issue, but similar to the ctr_values array,=
 the
overflow mask is also shifted out-of-bounds on RV32 in pmu_sbi_stop_hw_ctrs=
():

pmu_sbi_stop_hw_ctrs() {
    ...
    for (i =3D 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++) {
        ...
        temp_ctr_overflow_mask |=3D sdata->ctr_overflow_mask << (i * BITS_P=
ER_LONG);
        ...
}

On RV32, shifting the 64-bit ctr_overflow_mask by 32 bits when i=3D1 pushes
the absolute bits 32-63 out of bounds. Doesn't this discard the overflow st=
ate
for counters 32-63?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786092600.gi=
t.liuxixin@kylinos.cn?part=3D1
