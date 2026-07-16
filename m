Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CD5421A07;
	Thu, 16 Jul 2026 13:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784207227; cv=none; b=Iyz/2MJA3/ly7X/CaC91my4bLxrnWWUSTA0dN9ZEtnEoxbIngqyud0QHFAFolaBPp+jAMM2HjTNpY8B+Sb/7qs0vcrYQmaymqFmZWwrt0IST7IcGqL7Z4vZDt4NhrISoho9B/xblkHGVbn6c0/EOLFDaeVKpMoyOnMhSXBsGFZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784207227; c=relaxed/simple;
	bh=vQ1VLJ8+lpVZ1rzcAUqcsZcjVbkihhQYjO0AwQy4PdA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q/xXbTZstKePrnioqXCGsae0BsLW+xdck/gXbR9caY/4unCac2mevAVj1+0rNrq59BS+sxU8HpryA/K8Pxup07/VOv4ZE1jGFV4BiN2CGX51mc29lrKp+gvTxNOY1BvT9ZPPl6NeWH/QB+TF6It/sXpBnO3dpTUk2GRWMyCs3X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhfkrX8H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhfkrX8H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94691F00A3D;
	Thu, 16 Jul 2026 13:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784207225;
	bh=4/tRVPcuLUMAyhxQKgpYwo0MKnx4emvhUYvD3ZzSLuo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DhfkrX8HpJSvzjJt7Yo/yRisAUSG2O011vmQP2lnvDAT8QtuTIEQjk2M5DzQ0GdM3
	 mgfGKeGvAHs8IZW925O6Yvx6ovpc3PVTTi3Shn3hzZGCO/6WCsIR5ojD77naz6TQeC
	 tuCHy8zIy0H7eEs6ux6NRY8XFg+PsPKoTiZjpmgAvUQRhg7vu6j6aiaGQYubsvzqaI
	 oWKHV+yWfIoL63xJ3/P7dKuJvNi715edNS0wwCZ18HMT2LHyWvogelY+wdRqFALlWx
	 hGdGv3NsB9BRZk3WAGysBLvOYX/bYFR+G5+GagA/Urq+dpklfTh5FnKFPdTNO9DbTR
	 7BXPOBj3xLTnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/15] riscv/mm: optimize mprotect for Svnapot
 mappings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yunhui Cui" <cuiyunhui@bytedance.com>
Cc: kvm@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <8b79ddc3311e1dc32b150b7efbaed5a187ee5ccd.1784201104.git.cuiyunhui@bytedance.com>
References: <cover.1784201104.git.cuiyunhui@bytedance.com>
 <8b79ddc3311e1dc32b150b7efbaed5a187ee5ccd.1784201104.git.cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 13:07:05 +0000
Message-Id: <20260716130705.A94691F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The fallback path corrupts userspace memory tracking by erroneou=
sly injecting `_PAGE_SOFT_DIRTY` via `pte_mkdirty()`.
--

--- Patch [14]: [PATCH v2 14/15] riscv/mm: optimize mprotect for Svnapot ma=
ppings ---
commit f75eddb541d9ba388068a3cbeef6571534eb416b
Author: Yunhui Cui <cuiyunhui@bytedance.com>

riscv/mm: optimize mprotect for Svnapot mappings

This commit optimizes mprotect operations for Svnapot mappings by handling
full blocks in a single batched operation. A fallback loop is retained for
partial, unaligned, or otherwise inconsistent mappings.

> diff --git a/arch/riscv/mm/contpte.c b/arch/riscv/mm/contpte.c
> index 8289f39d6e188..6a1156629d115 100644
> --- a/arch/riscv/mm/contpte.c
> +++ b/arch/riscv/mm/contpte.c

[ ... ]

> +pte_t modify_prot_start_ptes(struct vm_area_struct *vma, unsigned long a=
ddr,
> +			     pte_t *ptep, unsigned int nr)
> +{
> +	struct mm_struct *mm =3D vma->vm_mm;
> +	unsigned long ptent_addr;
> +	pte_t raw, pte, ptent;
> +	unsigned int i;
> +
> +	if (napotpte_can_modify_prot_block(mm, addr, ptep, nr, &raw)) {

[ ... ]

> +			if (pte_dirty(ptent))
> +				pte =3D riscv_pte_mkhwdirty(pte);

[ ... ]

> +		return pte;
> +	}
> +
> +	pte =3D __ptep_modify_prot_start(vma, addr, ptep);
> +	while (--nr) {
> +		ptep++;
> +		addr +=3D PAGE_SIZE;
> +		ptent =3D __ptep_modify_prot_start(vma, addr, ptep);
> +		if (pte_dirty(ptent))
> +			pte =3D pte_mkdirty(pte);

[Severity: Medium]
Does this fallback path unintentionally set the soft-dirty bit for userspace
tracking?

On RISC-V, pte_mkdirty() sets both the hardware _PAGE_DIRTY bit and the
userspace-visible _PAGE_SOFT_DIRTY bit. If a Svnapot mapping was previously
written to (hardware dirty) but its soft-dirty bit was explicitly cleared by
userspace (e.g. via /proc/pid/clear_refs), calling mprotect() on a partial
or unaligned segment of this block triggers this fallback path.

Since the fallback path uses pte_mkdirty() to accumulate the dirty state, it
would inadvertently re-set the _PAGE_SOFT_DIRTY bit on the final batched PT=
E.
Userspace tracking tools like CRIU could subsequently falsely record this
memory as modified.

The fast path correctly uses riscv_pte_mkhwdirty(pte) to avoid this exact
issue. Should this loop also use riscv_pte_mkhwdirty(pte) instead of
pte_mkdirty(pte)?

> +		if (pte_young(ptent))
> +			pte =3D pte_mkyoung(pte);
> +	}
> +
> +	return pte;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784201104.gi=
t.cuiyunhui@bytedance.com?part=3D14
