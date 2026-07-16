Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B0D41B8E4;
	Thu, 16 Jul 2026 12:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784206774; cv=none; b=uSKGJDJzVRxvaVLUYfEdUIRz+UbwGO5NUGxpfzrh6685f3FPqvSbguP9fdRJTXYtfz9h6jfk9WFxrQFhf6z5DAZ/+v1cgfoACmMmKKcDIOz6CFqe/jG+/1TNKpKMsEMbV7xQu6kZ9dxehSDkhf8lG/xOWWsDadyo5FA+DHtMojE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784206774; c=relaxed/simple;
	bh=Z8d2Y93UNJnvjgmzxqFvJb1ohgg70kbo8kj+FdYkAvk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VLs0A0KXXcyeiWL6j+lwZ3cpif/3FYiTOL7z7NGJBYQULRwKf2eBrHDOvQvsP2yyoLB/dPYfxonVlGBNHXosTxLCkogih8bsjIdqlyiG3VkpEGyPjcMQRUyJpw7jK5mA+M17q2nQg9oXXMCVVARjKTHryNxsgxxmKkqIoSa0vrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D36d53Dr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D36d53Dr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078981F00A3A;
	Thu, 16 Jul 2026 12:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784206773;
	bh=ElAdf+OaR1FAE8nRi++tcdAgvUoyFAxBx5hwmbFrMKs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D36d53DrjBp15Mj+tEVOofDCMBgBTqWnjViVKybzGXDucQ8ZA/yLMAFmzqDCKZPH/
	 J4vzcGp2OWzM+z2B3BeJz7tWZpI7ks514Sku5aFsI+SVjV7GBleSdtbPKeGKxnRBux
	 Pxmmcq8oho0Iash+ieaXSGn5XpksaAyIBPCn8WrgxyX/u9JSoDo5ICzQVx7mg4E17x
	 L+pt2O6ZP+dt6tBqPiCu082HWlVWUw39nutlkZ+Os4QLmpwcXxPTuMHRFiMontuywG
	 1kqjcEbe77XqGJLbkKqNWvcl8EVPaw17TjEoFAMFTaGd5CZVwmwO+eS+YXkdDDVJTK
	 048kVdN+IGvUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/15] riscv/mm: implement Svnapot contpte read-side
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yunhui Cui" <cuiyunhui@bytedance.com>
Cc: linux-perf-users@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <0c93b57b5315147c6ae6586371d795fb629dcc7a.1784201104.git.cuiyunhui@bytedance.com>
References: <cover.1784201104.git.cuiyunhui@bytedance.com>
 <0c93b57b5315147c6ae6586371d795fb629dcc7a.1784201104.git.cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 12:59:32 +0000
Message-Id: <20260716125933.078981F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Missing single-PTE modifier overrides for NAPOT blocks break c=
ontiguous encoding, causing Use-After-Free and lockups.
- [High] Unbounded retry loop in `napotpte_ptep_get_lockless()` causes same=
-CPU deadlock if interrupted by NMI/IRQ.
- [High] `page_table_check` refcount corruption during Svnapot block conver=
sion/clearing.
- [Medium] `ptep_get` and `ptep_get_lockless` strip the `_PAGE_NAPOT` bit, =
breaking `pte_leaf_size()` for generic MM.
--

--- Patch [3]: [PATCH v2 03/15] riscv/mm: implement Svnapot contpte read-si=
de helpers ---
commit 5e07f7373fe29103de43866f47711b800fb7a33e
Author: Yunhui Cui <cuiyunhui@bytedance.com>

riscv/mm: implement Svnapot contpte read-side helpers

This patch introduces read-side helpers for Svnapot contiguous mappings to
allow generic MM code to operate on the logical sub-PTEs. The public PTE
getters are routed through these helpers.

> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pg=
table.h
> index a0f64e980e981..fce6d04ea65db 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -706,37 +706,37 @@ static inline pte_t __ptep_get_lockless(pte_t *ptep)
>  	return __ptep_get(ptep);
>  }
> =20
> +#ifdef CONFIG_RISCV_ISA_SVNAPOT
> +
> +#define ptep_get ptep_get
> +static inline pte_t ptep_get(pte_t *ptep)
> +{
> +	pte_t pte =3D __ptep_get(ptep);
> +
> +	if (likely(!pte_present_napot(pte)))
> +		return pte;
> +
> +	return napotpte_ptep_get(ptep, pte);
> +}
> +
> +#define ptep_get_lockless ptep_get_lockless
> +static inline pte_t ptep_get_lockless(pte_t *ptep)
> +{
> +	pte_t pte =3D __ptep_get_lockless(ptep);
> +
> +	if (likely(!pte_present_napot(pte)))
> +		return pte;
> +
> +	return napotpte_ptep_get_lockless(ptep);
> +}
> +

[Severity: Critical]
Does this implementation miss overriding ptep_get_and_clear and=20
ptep_modify_prot_start for NAPOT blocks?

If a NAPOT block is partially unmapped or modified via madvise() or
mprotect(), the generic MM code will call ptep_get_and_clear() on a single
PTE. Because these functions are not overridden, they fall back to the raw
__ptep_get_and_clear().

This clears only one PTE, leaving the other 15 with _PAGE_NAPOT still set,
which breaks hardware rules. Additionally, it returns the raw NAPOT PTE whe=
re
pte_pfn() evaluates to the base PFN, causing the core MM to drop the
mapcount and refcount on the base sub-page instead of the actual targeted
sub-page. Could this lead to data corruption or a use-after-free?

[ ... ]

> diff --git a/arch/riscv/mm/contpte.c b/arch/riscv/mm/contpte.c
> new file mode 100644
> index 0000000000000..43ea76e424492
> --- /dev/null
> +++ b/arch/riscv/mm/contpte.c
> @@ -0,0 +1,273 @@

[ ... ]

> +static inline pte_t napotpte_subpte(pte_t *ptep, pte_t pte)
> +{
> +	unsigned long pfn;
> +	pgprot_t prot;
> +
> +	if (!pte_present_napot(pte))
> +		return pte;
> +
> +	pfn =3D pte_pfn(pte) + (ptep - napot_align_ptep(ptep));
> +	prot =3D __pgprot(pte_protval_no_pfn_no_napot(pte));
> +
> +	return pfn_pte(pfn, prot);
> +}

[Severity: Medium]
Since this helper strips the _PAGE_NAPOT bit by using=20
pte_protval_no_pfn_no_napot(pte), does it break pte_leaf_size() for generic=
 MM?

If pte_leaf_size() expects the Svnapot bit to be present to return the
contiguous block size, returning a subpte without it will cause callers like
perf_get_page_size() to falsely evaluate the mapping as PAGE_SIZE.

> +
> +static inline pte_t __napot_ptep_get_and_clear(struct mm_struct *mm,
> +					       unsigned long addr, pte_t *ptep)
> +{
> +	pte_t pte;
> +
> +	pte =3D __pte(atomic_long_xchg((atomic_long_t *)ptep, 0));
> +	page_table_check_pte_clear(mm, addr, pte_mknonnapot(pte, addr));
> +
> +	return pte;
> +}

[Severity: High]
Can this cause page_table_check refcount corruption during Svnapot block
conversion?

pte_mknonnapot() returns the raw PTE unmodified. Because the raw Svnapot PFN
encoded in all 16 PTEs is identically base_pfn | 0x8, pte_pfn() inside
page_table_check_pte_clear() evaluates to the exact same base_pfn for all
16 iterations.=20

Will this cause the refcount for the base PFN to be decremented 16 times
while leaking the remaining 15 mapped sub-PFNs?

> +
> +static void napotpte_convert(struct mm_struct *mm, unsigned long addr,
> +			     pte_t *ptep, pte_t target)
> +{
> +	unsigned long start_addr, end, ptent_addr;
> +	pte_t *start_ptep;
> +	pte_t ptent, pte;
> +	unsigned int i, nr;
> +
> +	start_addr =3D napot_align_addr(addr);
> +	start_ptep =3D napot_align_ptep(ptep);
> +	nr =3D napotpte_pte_num();
> +	end =3D start_addr + napotpte_size();
> +
> +	for (i =3D 0; i < nr; i++) {
> +		ptent_addr =3D start_addr + i * PAGE_SIZE;
> +		ptent =3D __napot_ptep_get_and_clear(mm, ptent_addr,
> +						   start_ptep + i);

[Severity: High]
Does this create a preemption window that can lead to a CPU deadlock?

napotpte_convert() modifies NAPOT blocks by clearing their 16 PTEs sequenti=
ally
while holding the PTL, but it does not disable local interrupts.

[ ... ]

> +pte_t napotpte_ptep_get_lockless(pte_t *orig_ptep)
> +{
> +	pte_t orig_pte, pte;
> +	pte_t *ptep;
> +	unsigned int i, nr;
> +
> +	if (!napot_hw_supported())
> +		return READ_ONCE(*orig_ptep);
> +
> +	nr =3D napotpte_pte_num();
> +
> +retry:
> +	orig_pte =3D READ_ONCE(*orig_ptep);
> +	if (!pte_present_napot(orig_pte))
> +		return orig_pte;
> +
> +	ptep =3D napot_align_ptep(orig_ptep);
> +
> +	for (i =3D 0; i < nr; i++, ptep++) {
> +		pte =3D READ_ONCE(*ptep);
> +
> +		if (!napotpte_is_consistent(pte, orig_pte))
> +			goto retry;

[Severity: High]
If a perf NMI interrupts napotpte_convert() on the same CPU while the block=
 is
partially cleared and attempts a lockless page table walk, won't this loop
spin indefinitely?

The getter detects the intermediate inconsistency, jumps to retry, and spins
forever because the writer is interrupted on the exact same CPU and cannot
resume to restore consistency.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784201104.gi=
t.cuiyunhui@bytedance.com?part=3D3
