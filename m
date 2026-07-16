Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C03041F7D7;
	Thu, 16 Jul 2026 13:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784207123; cv=none; b=SkUkHoPXGmY727abs5QKRsNvTZ1jwtEn9zXBbr/DQqTw/0OmEdHv5YwWxn3DhAnc0VuPEeFYCH1uI7yMVoCmWVWUkgOROmK2TDVPp5PQEvWEdWa0V0/+zwLPwBVg3Nr11s4nuAVBEipx6kIHYHYW8TeHXfz+dvCNUqIQx6Rp7Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784207123; c=relaxed/simple;
	bh=nLeLyZl2djG754eY9ds9OmlBnWDTT3BETxI5qOV3LB8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QybyjlKnF35rbxmbo21sBSkUrNiPP54Ycwv7u6i0GIuPvhfVjnShuw4I5bslu+B8qcWYMQ9foCTLLab66rSWYyqKUy0CfHNFc/zEdQ/WZ8tFVo/GHqgd25ypDq8wfEeErF1aYwn6TNaXapiyCK8mKa3lOEg/V1Dpqt4/FIMO4oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhET5CrT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhET5CrT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D071F000E9;
	Thu, 16 Jul 2026 13:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784207122;
	bh=HmFmb89jPmau23+NPX2OADAl9O/Cn0juKg2cW1X6VxE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UhET5CrTvt9av3gofUV/QoXNqa3ffu956t0P2nlxS7oGLxVTonCeSbpvuASnqo8SK
	 +mjzdpyIp5Bc1mOakFEfIPXunEWNAhUSARf/1YKyPpdoedXl+diXFD0e0ZCdF/NPDY
	 CdFQ7Jg5K/MAylVQ3rLMdlpJfOHFQgYa8sg/J0CmOwF8Car2d9CF1ugVFVMouZCfLF
	 lZNOzbdPa7wKbyCLSJsXhhJJKiHFmA0bif08fZaFXGi04YCM1ZYve/lcqUXau1NY+m
	 wC78dWoHVrS8OI8hPBXqWzbbERLQrm4fs9kHG7yMTOGx3Uzdl+BW4ZHpg0KMviIQ2Y
	 uD9ETrIUR1nuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/15] riscv: switch arch page-table users to raw PTE
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yunhui Cui" <cuiyunhui@bytedance.com>
Cc: kvm@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <304b13bffd2f5299da4ae80c37803e527fb1719d.1784201104.git.cuiyunhui@bytedance.com>
References: <cover.1784201104.git.cuiyunhui@bytedance.com>
 <304b13bffd2f5299da4ae80c37803e527fb1719d.1784201104.git.cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 13:05:21 +0000
Message-Id: <20260716130521.D9D071F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Svnapot huge page set and clear paths have mismatched page_table_c=
heck PFN tracking and use unaligned addresses, leading to immediate BUG_ON =
panics.
- [Medium] The conversion to raw PTE helpers incorrectly bypasses the page_=
table_check framework for non-NAPOT hugetlb pages.

Pre-existing issues:
- [Critical] KVM stage-2 page table pages are freed before the stage-2 TLB =
is flushed, causing a use-after-free race.
- [High] huge_pte_clear() and huge_ptep_get_and_clear() fail to clear all c=
ontiguous PTEs for non-present entries like migration or hwpoison entries.
--

--- Patch [2]: [PATCH v2 02/15] riscv: switch arch page-table users to raw =
PTE helpers ---
commit 3f0c1de9839b5c9daaa76b96222e6c57e5096eda
Author: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: riscv: switch arch page-table users to raw PTE helpers

This patch converts RISC-V internal page-table walkers and mutators to
use raw PTE helpers. It also adds a raw get-and-clear helper and updates
the hugetlb Svnapot paths to operate on contiguous blocks using the raw
helper model.

> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index c4c3b79567f10..67b2c75f5cec1 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c

[ ... ]

> @@ -371,18 +371,18 @@ bool kvm_riscv_gstage_op_pte(struct kvm_gstage *gst=
age, gpa_t addr,
> =20
>  	WARN_ON(addr & (page_size - 1));
> =20
> -	if (!pte_val(ptep_get(ptep)))
> +	if (!pte_val(__ptep_get(ptep)))
>  		return false;
> =20
>  	if (ptep_level && !gstage_pte_leaf(ptep)) {
> -		next_ptep =3D (pte_t *)gstage_pte_page_vaddr(ptep_get(ptep));
> +		next_ptep =3D (pte_t *)gstage_pte_page_vaddr(__ptep_get(ptep));
>  		next_ptep_level =3D ptep_level - 1;
>  		ret =3D gstage_level_to_page_size(gstage, next_ptep_level, &next_page_=
size);
>  		if (ret)
>  			return false;
> =20
>  		if (op =3D=3D GSTAGE_OP_CLEAR)
> -			set_pte(ptep, __pte(0));
> +			__set_pte(ptep, __pte(0));
>  		for (i =3D 0; i < PTRS_PER_PTE; i++)
>  			flush |=3D kvm_riscv_gstage_op_pte(gstage, addr + i * next_page_size,
>  							 &next_ptep[i], next_ptep_level, op);
>  		if (op =3D=3D GSTAGE_OP_CLEAR)
>  			put_page(virt_to_page(next_ptep));

[Severity: Critical]
This is a pre-existing issue, but does this unconditionally free the child=
=20
page table page before the stage-2 TLB is invalidated?=20

The page is freed here by calling put_page() before returning the flush=20
boolean to the caller. This allows a concurrent hardware page table walk=20
to use the cached TLB directory entry to read from the freed page.

> diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
> index a6d217112cf46..5ededac02161d 100644
> --- a/arch/riscv/mm/hugetlbpage.c
> +++ b/arch/riscv/mm/hugetlbpage.c

[ ... ]

> @@ -145,28 +145,52 @@ unsigned long hugetlb_mask_last_page(struct hstate =
*h)
>  	return 0UL;
>  }
> =20
> +static unsigned long napot_hugetlb_block_addr(pte_t pte, unsigned long a=
ddr)
> +{
> +	unsigned long order;
> +
> +	if (!pte_napot(pte))
> +		return addr;
> +
> +	order =3D napot_cont_order(pte);
> +
> +	return addr & napot_cont_mask(order);
> +}
> +
> +static pte_t napot_hugetlb_get_and_clear(struct mm_struct *mm,
> +					 unsigned long addr, pte_t *ptep)
> +{
> +	pte_t pte;
> +
> +	pte =3D __ptep_get_and_clear_noptc(ptep);
> +	page_table_check_pte_clear(mm, addr, pte_mknonnapot(pte, addr));
> +
> +	return pte;
> +}

[Severity: High]
Does this cause a refcount underflow and trigger a BUG_ON in the=20
page_table_check logic?=20

When a SVNAPOT huge page is unmapped, get_clear_contig() iteratively calls=
=20
napot_hugetlb_get_and_clear() 16 times for a 64KB block. Each iteration cal=
ls=20
page_table_check_pte_clear() with the exact same encoded PTE (base_PFN + 8)=
.=20
Since set_huge_napot_ptes() tracks the block consecutively, untracking the=
=20
same base PFN + 8 sixteen times will underflow the counter and panic.

[ ... ]

> @@ -207,14 +234,31 @@ static void clear_flush(struct mm_struct *mm,
>  			unsigned long ncontig)
>  {
>  	struct vm_area_struct vma =3D TLB_FLUSH_VMA(mm, 0);
> +	pte_t pte =3D __ptep_get(ptep);
>  	unsigned long i, saddr =3D addr;
> =20
> +	addr =3D napot_hugetlb_block_addr(pte, addr);
> +	if (pte_napot(pte))
> +		ptep =3D huge_pte_offset(mm, addr,
> +				       napot_cont_size(napot_cont_order(pte)));
> +	saddr =3D addr;
> +
>  	for (i =3D 0; i < ncontig; i++, addr +=3D pgsize, ptep++)
> -		ptep_get_and_clear(mm, addr, ptep);
> +		napot_hugetlb_get_and_clear(mm, addr, ptep);
> =20
>  	flush_tlb_range(&vma, saddr, addr);
>  }
> =20
> +static void set_huge_napot_ptes(struct mm_struct *mm, unsigned long addr,
> +				pte_t *ptep, pte_t pte, unsigned long pte_num)
> +{
> +	unsigned long i;
> +
> +	page_table_check_ptes_set(mm, addr, ptep, pte, pte_num);
> +	for (i =3D 0; i < pte_num; i++)
> +		__set_pte_at(mm, ptep + i, pte);
> +}

[Severity: High]
Can this pass an unaligned faulting address to page_table_check_ptes_set()
and track the wrong PFNs?

When called from huge_ptep_set_access_flags(), addr is the unaligned=20
faulting address, whereas the clear path block-aligns it. This tracks and=20
untracks different virtual address ranges.=20

Additionally, passing pte_num to page_table_check_ptes_set() tracks=20
consecutive PFNs starting from the raw encoded PFN (base_PFN + 8 for order =
4)=20
instead of the true base PFN.

[ ... ]

> @@ -256,19 +300,18 @@ void set_huge_pte_at(struct mm_struct *mm,
> =20
>  	if (!pte_present(pte)) {
>  		for (i =3D 0; i < pte_num; i++, ptep++, addr +=3D pgsize)
> -			set_ptes(mm, addr, ptep, pte, 1);
> +			__set_ptes(mm, addr, ptep, pte, 1);
>  		return;
>  	}
> =20
>  	if (!pte_napot(pte)) {
> -		set_ptes(mm, addr, ptep, pte, 1);
> +		__set_ptes(mm, addr, ptep, pte, 1);
>  		return;
>  	}

[Severity: Medium]
Does this bypass the page_table_check framework for non-NAPOT 2MB huge page=
s?

The conversion to the raw __set_ptes() helper removes the internal=20
page_table_check_ptes_set() call that set_ptes() previously provided. Witho=
ut=20
a manual page_table_check call on this fallback path, memory corruption=20
detection is lost for 2MB PMD-mapped huge pages.

[ ... ]

> @@ -306,14 +348,13 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
>  			      unsigned long addr,
>  			      pte_t *ptep, unsigned long sz)
>  {
> -	size_t pgsize;
> -	pte_t orig_pte =3D ptep_get(ptep);
> +	pte_t orig_pte =3D __ptep_get(ptep);
>  	int pte_num;
> =20
>  	if (!pte_napot(orig_pte))
> -		return ptep_get_and_clear(mm, addr, ptep);
> +		return __ptep_get_and_clear(mm, addr, ptep);

[Severity: High]
This is a pre-existing issue, but does this fail to clear all contiguous PT=
Es=20
for non-present entries like migration or hwpoison entries?

Since non-present entries do not have the hardware _PAGE_NAPOT bit set,=20
pte_napot() evaluates to false. This fallback path returns early after=20
clearing only a single 4KB PTE, leaving the remaining 15 stale entries=20
in the page table.

[Severity: Medium]
Also related to the conversion to raw PTE helpers, does replacing=20
ptep_get_and_clear() with __ptep_get_and_clear() bypass the page_table_chec=
k=20
framework for non-NAPOT 2MB huge pages?

[ ... ]

> @@ -363,19 +403,16 @@ void huge_pte_clear(struct mm_struct *mm,
>  		    pte_t *ptep,
>  		    unsigned long sz)
>  {
> -	size_t pgsize;
> -	pte_t pte =3D ptep_get(ptep);
> -	int i, pte_num;
> +	pte_t pte =3D __ptep_get(ptep);
> +	int pte_num;
> =20
>  	if (!pte_napot(pte)) {
> -		pte_clear(mm, addr, ptep);
> +		__pte_clear(mm, addr, ptep);
>  		return;
>  	}

[Severity: High]
This is a pre-existing issue, but does this also fail to clear all contiguo=
us=20
PTEs for non-present entries (migration or hwpoison) because pte_napot()=20
evaluates to false?

[Severity: Medium]
Similar to the issue above, does replacing pte_clear() with __pte_clear()=20
without a manual page_table_check call disable memory corruption tracking=20
for non-NAPOT 2MB huge pages?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784201104.gi=
t.cuiyunhui@bytedance.com?part=3D2
