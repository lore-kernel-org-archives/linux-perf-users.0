Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0236141F35F;
	Thu, 16 Jul 2026 12:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784206658; cv=none; b=ftd6MzYmm+81IQux6PY1NVBe3H0lNCCX8rXFGueN39B3AewqSAWh7vV+jV01XpmvrPsDRTQe0fccYe3+K74gWVjEfq7qfW39gsy9hbHYFFIFlc9OyoDO+pzsH5QDgYz4mtV7T/Xf+6RWLjb0fIrlRWYr4G0NrpT8Ub7pwmalQPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784206658; c=relaxed/simple;
	bh=ObICsRG/XlaCC3aSq2n0utSllkXYt4iwg+idnUDFj3s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BLwDJEwfrKjtmhrNttmVoAGhRhisTKC7lW8Df4e209Nes1ZJmJ56WU4yhrPP3yxykm78k4YxVKXbo2gXrEBEPn1dLi6YPfXxXfBzVqQwQbs9XPTvp4p4Hip7xmFiVvcRCQFbdonFolsZ9CgsXYWu97NV0VjC+AdBk51wKyFgdIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3c/Mxee; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3c/Mxee"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CDD91F000E9;
	Thu, 16 Jul 2026 12:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784206655;
	bh=XM1G03t5o5IzfuWa037gvOBoG5H4m9xks97J1DYquvU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d3c/MxeefhMRsOQ/zaw4Jni5xAXnGYujiwnrn5AxzDWahjd2NuEJV+qBu5K8MwKps
	 MPDCNKiWyktijR5tKx9d1cXF+QWz/uIQocQzFLZOz2z4h0ZljX2godvHFAT8AlHnle
	 +aD/ecYG9PFRK+uY98rO2wIV3RIsilgnf8jV//SJZkJ8i2Q9HSyAuSUnMsTeabl1Et
	 FoIH4olt9gJW6mZQZtPo7nNx9wA0v7dwdC5XCIfsad3JkT58UGHdIOUYAqX+3yfMaF
	 UOwBa39/BjKfHSzkia94R5FPXwprMSAs8i0Hf6B3NDuHDH+nW00u7/oGLwTwDsAuiT
	 56qIdj/RXuTsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/15] riscv/mm: preserve Svnapot leaf-size semantics
 for page-table consumers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yunhui Cui" <cuiyunhui@bytedance.com>
Cc: linux-perf-users@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <180084b20de76f7ad61641e9b7abe6d103caf5f3.1784201104.git.cuiyunhui@bytedance.com>
References: <cover.1784201104.git.cuiyunhui@bytedance.com>
 <180084b20de76f7ad61641e9b7abe6d103caf5f3.1784201104.git.cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 12:57:34 +0000
Message-Id: <20260716125735.8CDD91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Single-CPU deadlock in `napotpte_ptep_get_lockless` when called fr=
om NMI/IRQ context during a partial Svnapot block update.
--

--- Patch [7]: [PATCH v2 07/15] riscv/mm: preserve Svnapot leaf-size semant=
ics for page-table consumers ---
commit 0488a9106519eab47850cf758ecce3d0c6bdf46e
Author: Yunhui Cui <cuiyunhui@bytedance.com>

riscv/mm: preserve Svnapot leaf-size semantics for page-table consumers

Svnapot keeps a folded 64KB mapping encoded in the page table, while the
public PTE helpers may expose a logical per-page sub-PTE view. This patch
uses the original page-table entry for leaf-size queries so consumers
continue to observe the Svnapot leaf size instead of treating a folded
mapping as PAGE_SIZE entries.

> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pg=
table.h
> index da7ffea0dcd98..e4b9c05014c00 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
[ ... ]
> @@ -580,6 +580,17 @@ static inline pte_t pte_swp_clear_soft_dirty(pte_t p=
te)
>  					napot_cont_size(napot_cont_order(pte)) :\
>  					PAGE_SIZE)
> =20
> +#define __ptep_leaf_size __ptep_leaf_size
> +static inline unsigned long __ptep_leaf_size(pmd_t pmd, pte_t *ptep, pte=
_t pte)
> +{
> +	pte_t raw_pte =3D READ_ONCE(*ptep);
> +
> +	if (pte_present_napot(raw_pte))
> +		return pte_leaf_size(raw_pte);
> +
> +	return PAGE_SIZE;
> +}

[Severity: High]
Can this lead to a single-CPU deadlock in NMI/IRQ context during a partial
Svnapot block update?

If a thread executing napotpte_convert() holds the page table lock (which
disables preemption but leaves NMIs and hardware IRQs enabled) and
sequentially clears PTEs in a 64KB Svnapot block:

arch/riscv/mm/contpte.c:napotpte_convert() {
...
	for (i =3D 0; i < nr; i++) {
		ptent_addr =3D start_addr + i * PAGE_SIZE;
		ptent =3D __ptep_get_and_clear_noptc(start_ptep + i);
...
}

And a Performance Monitoring Interrupt (PMI) interrupts this CPU after some
but not all PTEs are cleared, the PMI handler may invoke
perf_get_pgtable_size(), which eventually invokes the lockless PTE reader.

This would lead to napotpte_ptep_get_lockless() entering a retry loop:

arch/riscv/mm/contpte.c:napotpte_ptep_get_lockless() {
...
retry:
	orig_pte =3D READ_ONCE(*orig_ptep);
	if (!pte_present_napot(orig_pte))
		return orig_pte;

	ptep =3D napot_align_ptep(orig_ptep);

	for (i =3D 0; i < nr; i++, ptep++) {
		pte =3D READ_ONCE(*ptep);

		if (!napotpte_is_consistent(pte, orig_pte))
			goto retry;
...
}

Because the NMI/IRQ handler prevents the interrupted thread on the same CPU
from finishing the update, the block remains partially cleared. Does this
cause the consistency check to fail repeatedly, resulting in an infinite
loop and hard lockup?

Userspace could potentially trigger this via perf_event_open by sampling
memory accesses during Svnapot page migrations or unmapping.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784201104.gi=
t.cuiyunhui@bytedance.com?part=3D7
