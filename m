Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E0542088A;
	Thu, 16 Jul 2026 13:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784206999; cv=none; b=AD5H0NdOrSMvLLJkqY65CryXLUyt17ZeBJXQVwCfyppfm3SbMO6TS7B+vKKU++4tVc4sjx2kNYzhqK+fJDI6wN5CZu4rFSjDjYtQ9GVArLGTjcZ/K76mUyk0nEKlJG7Q+DXDzwBMN8rXCqXWsk4VWsKvvfWVS3k4+LgSK8lXHpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784206999; c=relaxed/simple;
	bh=uI3Ou6xNZTPiRaCV3KpD0/6dUvLkfvz1jw+YRzKFNzk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pQzQAcHM2j57nRfldTe9F78PRWu02QBvgbhu/S6eWOHUkm+uQMYQA8vXU1mB2v35XPZtVPT52b9vOCW4pt3DK8oYfFxUUlNLdaqZ8Qrua9O/C+NMEfcoY5uMZ9o1cVb8a7gFwDuLdvmtAzEN1FoSAqPWSlI0k5f+Ci3jzmNh2kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Clb2f5se; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Clb2f5se"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360E51F000E9;
	Thu, 16 Jul 2026 13:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784206996;
	bh=CdQIL+3ZKAbNUhnb0ss4JJbFLS/AhLn3yiL/kaWAldY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Clb2f5seEhnRaF2JSZBF/qHOSv8WIndZu880jvT0AgxbN6DHUGr6KvHiiTGQxeI9y
	 5zMl9l6n/ulFZPsjlHnDS9fPlb3GfftEV1MEiriUOFX+zktmpuOT8TtPq0eDpbKfYp
	 XJmCTxzNOCHmOCRtd6Zd1IleAfP7Jb82Ws6ElYoi3DrimOLGWeEzy9spWNwHqD0CEl
	 YlximuSEQI2zIDyYhnJyeGsSNph8au077SBfsU/c+a0XcTzlXSleGZowDFbOl3c2Km
	 +cDUknvg+2Rs+5vJByhraP/X8euSePSxmavsY2NeU/Jp11xcw+UV9wLzxWRAg52fcj
	 BFjxIJewrV6Tg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/15] riscv/mm: implement Svnapot contpte update
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yunhui Cui" <cuiyunhui@bytedance.com>
Cc: linux-perf-users@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <08e6e04deb4c415f6819d677858e3eca1270b0f1.1784201104.git.cuiyunhui@bytedance.com>
References: <cover.1784201104.git.cuiyunhui@bytedance.com>
 <08e6e04deb4c415f6819d677858e3eca1270b0f1.1784201104.git.cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 13:03:15 +0000
Message-Id: <20260716130316.360E51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [Critical] Extracting sub-PTEs from a SVNAPOT PTE fails to mask out the N=
APOT size encoding bits from the PFN, resulting in incorrect physical addre=
ss mappings.
- [Critical] napotpte_clear_young_dirty_ptes() unsafely expands its bounds =
to the entire NAPOT block, clearing dirty bits for unaffected pages and cau=
sing data loss during reclaim.
- [High] napotpte_wrprotect_ptes modifies the write permission bit in-place=
 for fully-covered SVNAPOT blocks without unfolding them, temporarily viola=
ting the RISC-V SVNAPOT identical-PTE requirement.
- [High] Folding 16 4KB PTEs into a 64KB NAPOT PTE without a full TLB flush=
 creates overlapping TLB entries, leading to hardware Machine Check Excepti=
ons.
- [Medium] napotpte_ptep_clear_flush_young unconditionally issues a full sy=
nchronous TLB flush, which destroys the RISC-V page reclaim optimization.

Pre-existing issues:
- [High] Unbounded spin-retry loop in lockless PTE accessor causes livelock=
 if interrupted by an NMI or hardirq.
--

--- Patch [4]: [PATCH v2 04/15] riscv/mm: implement Svnapot contpte update =
helpers ---
commit 6810ac383bbe56cdae57e157126e14c9d376a982
Author: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: riscv/mm: implement Svnapot contpte update helpers

This commit adds Svnapot-aware contpte update helpers to preserve logical
per-page views for generic MM users. It routes public PTE operations through
these helpers to manage Svnapot folded mappings safely.

> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pg=
table.h
> index fce6d04ea65db..771faabb2b00b 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
[ ... ]
> @@ -413,6 +413,30 @@ static inline int pte_special(pte_t pte)
> +#ifdef CONFIG_RISCV_ISA_SVNAPOT
> +static inline pte_t pte_mknonnapot(pte_t pte, unsigned long addr)
> +{
> +	unsigned long pfn;
> +	unsigned long offset;
> +	pgprot_t prot;
> +
> +	if (!pte_present_napot(pte))
> +		return pte;
> +
> +	offset =3D (addr & (napot_cont_size(napot_cont_order(pte)) - 1)) >>
> +		 PAGE_SHIFT;
> +	pfn =3D pte_pfn(pte) + offset;

[Severity: Critical]
Does pte_pfn() return the raw PFN including the NAPOT size encoding bit (li=
ke
PPN[3] for 64KB blocks)?

If the size bit is not masked out before adding the offset, it appears this
could shift the physical mapping by 32KB and map the wrong physical memory
when breaking down a PTE.

> +	prot =3D __pgprot((pte_val(pte) & ~_PAGE_PFN_MASK) & ~_PAGE_NAPOT);

[ ... ]
> @@ -870,7 +881,169 @@ static inline bool __ptep_clear_flush_young(struct =
vm_area_struct *vma,
[ ... ]
> +static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
> +			    pte_t *ptep, pte_t pteval, unsigned int nr)
> +{
> +	pteval =3D pte_mknonnapot(pteval, addr);
> +
> +	if (likely(nr =3D=3D 1)) {
> +		napotpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
> +		__set_ptes(mm, addr, ptep, pteval, 1);
> +		napotpte_try_fold(mm, addr, ptep, pteval);

[Severity: High]
Can folding 16 4KB PTEs into a NAPOT PTE here without a full TLB flush crea=
te
overlapping TLB entries?

Since napotpte_convert() skips the flush expecting the caller to handle it,
the remaining 15 4KB entries might stay cached alongside the new 64KB entry.
On RISC-V, overlapping TLB entries can trigger hardware machine check
exceptions.

> +		return;
> +	}
> +
> +	napotpte_set_ptes(mm, addr, ptep, pteval, nr);
> +}

> diff --git a/arch/riscv/mm/contpte.c b/arch/riscv/mm/contpte.c
> index 43ea76e424492..3f8a0a2970afb 100644
> --- a/arch/riscv/mm/contpte.c
> +++ b/arch/riscv/mm/contpte.c
> @@ -62,6 +62,24 @@ static inline unsigned long pte_protval_no_pfn_no_napo=
t(pte_t pte)
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

[Severity: Critical]
Similar to pte_mknonnapot(), is the NAPOT size encoding bit left unmasked
here when extracting the base PFN?

> +	prot =3D __pgprot(pte_protval_no_pfn_no_napot(pte));

[ ... ]
> +void __napotpte_try_unfold(struct mm_struct *mm, unsigned long addr,
> +			   pte_t *ptep, pte_t pte)
> +{
> +	pte_t target;
> +	pgprot_t prot;
> +
> +	if (!napot_hw_supported() || !mm_is_user(mm) ||
> +	    !pte_present_napot(pte))
> +		return;
> +
> +	prot =3D __pgprot(pte_protval_no_pfn_no_napot(pte));
> +	target =3D pfn_pte(pte_pfn(pte), prot);

[Severity: Critical]
Does target need to mask the NAPOT size bit out of pte_pfn(pte) here as well
before generating all 16 base PTEs?

> +
> +	napotpte_convert(mm, addr, ptep, target);
> +}

[ ... ]
> +pte_t napotpte_ptep_get_lockless(pte_t *orig_ptep)
> +{
[ ... ]
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
This is a pre-existing issue, but can this unbounded spin-retry loop cause a
hard lockup?

If a page table writer is interrupted by an NMI or hardirq while modifying a
NAPOT block, and napotpte_ptep_get_lockless() is called from that interrupt
context, it appears the NMI will spin forever waiting for the block to beco=
me
consistent since the interrupted writer cannot resume.

> +
> +		if (pte_dirty(pte)) {

[ ... ]
> +void napotpte_clear_young_dirty_ptes(struct vm_area_struct *vma,
> +				     unsigned long addr, pte_t *ptep,
> +				     unsigned int nr, cydp_t flags)
> +{
> +	struct mm_struct *mm;
> +	unsigned long start, end;
> +	unsigned int total;
> +
> +	mm =3D vma->vm_mm;
> +	if (!napot_hw_supported() || !mm_is_user(mm)) {
> +		__clear_young_dirty_ptes(vma, addr, ptep, nr, flags);
> +		return;
> +	}
> +
> +	start =3D addr;
> +	end =3D start + nr * PAGE_SIZE;
> +
> +	if (pte_present_napot(READ_ONCE(*(ptep + nr - 1))))
> +		end =3D ALIGN(end, napotpte_size());
> +
> +	if (pte_present_napot(READ_ONCE(*ptep))) {
> +		start =3D napot_align_addr(start);
> +		ptep =3D napot_align_ptep(ptep);
> +	}

[Severity: Critical]
Could this unbounded expansion of the operating range cause data loss?

If madvise_free_pte_range() passes a restricted nr for a partially split
folio, expanding the bounds to the full 64KB block will clear hardware dirty
bits for unaffected pages outside the requested range.

This could lead to those pages being dropped without writeback during memory
reclaim.

> +
> +	total =3D (end - start) >> PAGE_SHIFT;
> +	for (; total; total--, ptep++, start +=3D PAGE_SIZE)
> +		napotpte_clear_young_dirty_pte(ptep, flags);
> +}

[ ... ]
> +void napotpte_wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
> +			     pte_t *ptep, unsigned int nr)
> +{
> +	unsigned int i;
> +
> +	if (!napot_hw_supported() || !mm_is_user(mm)) {
> +		for (i =3D 0; i < nr; i++, ptep++, addr +=3D PAGE_SIZE)
> +			__ptep_set_wrprotect(mm, addr, ptep);
> +		return;
> +	}
> +
> +	napotpte_try_unfold_partial(mm, addr, ptep, nr);
> +
> +	for (i =3D 0; i < nr; i++, ptep++, addr +=3D PAGE_SIZE)
> +		__ptep_set_wrprotect(mm, addr, ptep);

[Severity: High]
Does modifying the write permission bit in-place for fully-covered blocks
violate the identical-PTE requirement?

If the fully-covered blocks are not unfolded first, iterating sequentially
through __ptep_set_wrprotect() creates a window where PTEs in the same NAPOT
block have mixed write permissions.

This transient state could trigger a machine check exception if the block is
accessed concurrently.

> +}

[ ... ]
> +int napotpte_ptep_clear_flush_young(struct vm_area_struct *vma,
> +				    unsigned long address, pte_t *ptep)
> +{
> +	unsigned long start_addr;
> +	int young;
> +
> +	young =3D napotpte_ptep_test_and_clear_young(vma, address, ptep);
> +	if (!young)
> +		return 0;
> +
> +	start_addr =3D napot_align_addr(address);
> +	flush_tlb_range(vma, start_addr, start_addr + napotpte_size());

[Severity: Medium]
Will this unconditional flush_tlb_range() trigger an IPI storm during memory
reclaim?

The base RISC-V implementation deliberately avoids TLB flushes when clearing
the accessed bit to optimize reclaim, and adding a heavyweight flush here
appears to heavily degrade system performance.

> +
> +	return young;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784201104.gi=
t.cuiyunhui@bytedance.com?part=3D4
