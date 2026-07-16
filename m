Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239FA40910E;
	Thu, 16 Jul 2026 13:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784207847; cv=none; b=EWm95oCi9gkb0X08LH/XBI0sAOaSkCxTeKQRDPMyhV+jlGwhOvxb08/varaE+TrvKPqLptny3zJ6nXRAD5jRDrfs5KlaHGc2DUck/p+S/4Dn3V1hanJ58aGOda8C1u9BuW0aDVIJr+LqY0rBRUM1uUWpXDj89YFuz8HR03Z+QAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784207847; c=relaxed/simple;
	bh=lr92YBWuGonAiGMBx5Xs7h+SntONI76vYo4pO/lz+8g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e/OZEHlnrSRDKBPEC+hRUPrmSMcccrepIVvzyH3iAwjXKq9KhNd2/xWlFcBhmkqIHvBaA1358I/ivnBxkPen/PCf72qQPY8rn5wsK1TvVOgrpp54XM+XGOpC8LuQV9DYJ4DxfAgqvF6PaCh9qCKLleTXVv0rEkhLI9z7bv+2YSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5G73+GJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5G73+GJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A901F00A3A;
	Thu, 16 Jul 2026 13:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784207844;
	bh=Z5D2miPTCZmKPLOcG+UKYAib/BuPKDcRPbdhjcULxk8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j5G73+GJXoFvym3sJUkus2RsWq0JI/C5iqS9vpTHlOCP3MMJYzqS614KhAzUqHwjI
	 E6vLu2oHX7DJTGsVohZXfPKkuDLEl122xLmAGMK7m0FbJcHdUCwCJRHlqcuF8wNliQ
	 b0Z2THrRstFewWzvMvY5ZNR3Je0CmL036LzK+VaS/kRlrPQIptm+yY8DkZIufTxUYA
	 Jh7dRSO0yTtBigkqSdf0rh9MJ4WgbbO1ZSmiywYXwnGzGT1eS8ZuXn3tCkecoW+Ur6
	 U84ZhjLTAJFigbD4l7QKdl0RA7jfNCwpzGvwkCxJnbUIa1w5niDM4eCW60w32hiHqQ
	 A0bzChMNq1KAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/15] riscv/mm: remove redundant TLB flush in
 napotpte_convert
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yunhui Cui" <cuiyunhui@bytedance.com>
Cc: kvm@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <e55fb906990083b05272648f5299514a68cf8456.1784201104.git.cuiyunhui@bytedance.com>
References: <cover.1784201104.git.cuiyunhui@bytedance.com>
 <e55fb906990083b05272648f5299514a68cf8456.1784201104.git.cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 13:17:23 +0000
Message-Id: <20260716131724.61A901F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removing the TLB flush in napotpte_convert() allows stale 4KB TLB =
entries to survive when folding base PTEs into a NAPOT block, leading to si=
lent data corruption during partial-block TLB flushes.
--

--- Patch [13]: [PATCH v2 13/15] riscv/mm: remove redundant TLB flush in na=
potpte_convert ---
commit 63217ab7f83ce36005df21143bf66fc315027a26
Author: Yunhui Cui <cuiyunhui@bytedance.com>

riscv/mm: remove redundant TLB flush in napotpte_convert

This commit removes the TLB flush during the conversion between a NAPOT
block and its equivalent base PTEs in napotpte_convert(). The justification
is that since the effective translations (PFNs and permissions) are unchang=
ed,
TLB invalidation can be deferred to operations that actually change the
effective mapping.

Link: https://lists.riscv.org/g/tech-privileged/message/2950

> diff --git a/arch/riscv/mm/contpte.c b/arch/riscv/mm/contpte.c
> index b0b8ff0aade3a..8289f39d6e188 100644
> --- a/arch/riscv/mm/contpte.c
> +++ b/arch/riscv/mm/contpte.c

[ ... ]

> @@ -149,8 +149,15 @@ static void napotpte_convert(struct mm_struct *mm, u=
nsigned long addr,
>  			target =3D pte_mkyoung(target);
>  	}
> =20
> -	flush_tlb_mm_range(mm, start_addr, end, PAGE_SIZE);
> -

[Severity: High]
Does removing this TLB flush allow stale 4KB TLB entries to survive when
folding base PTEs into a NAPOT block?

When set_ptes() maps a single page that completes a 16-page aligned block
backed by a large folio, __napotpte_try_fold() folds the 16 base PTEs into
a 64KB NAPOT block via napotpte_convert(). The CPU may have already cached
separate 4KB TLB entries for the existing 15 pages. Without the TLB flush
in napotpte_convert(), these 4KB TLB entries can survive the folding proces=
s.

Could this lead to silent data corruption during partial-block TLB flushes?

Later, if an operation like madvise(MADV_FREE) targets a single 4KB subpage
of this NAPOT block, it calls split_folio(), which splits the underlying
folio but does not alter the NAPOT page table entries. On retry, the loop
processes the now order-0 folio with nr =3D 1 and calls
clear_young_dirty_ptes() with nr =3D 1.

Because the PTE still has the NAPOT bit set, napotpte_clear_young_dirty_pte=
s()
correctly expands the operation to clear the young and dirty bits for all 16
PTEs in the page table to maintain the NAPOT encoding invariant. However,
madvise_free_pte_range() then queues only a 1-page TLB flush:

	tlb_remove_tlb_entries(tlb, pte, 1, addr);

If the TLB held a 64KB NAPOT entry, the single-page sfence.vma would
successfully invalidate the entire 64KB block. But because the old 4KB TLB
entries survived the folding, the flush only invalidates the single targeted
4KB entry, leaving the other 15 4KB TLB entries valid.

Since their dirty bits were cleared in the page table but they are still
cached as dirty in the TLB, subsequent writes to these 15 pages will not set
the hardware dirty bit in the page table. Will the kernel later view these
modified pages as clean and discard them without writeback during memory
reclaim, dropping dirty data?

> +	/*
> +	 * This conversion only changes the representation of the same
> +	 * effective translations: NAPOT encoding <-> equivalent base PTEs.
> +	 * A flush here would not replace the TLB maintenance required by a
> +	 * later permission downgrade, because writable base-PTE translations
> +	 * could be refilled after this conversion and before that downgrade.
> +	 * Leave TLB invalidation to the operation that changes the effective
> +	 * mapping.
> +	 */
>  	page_table_check_ptes_set(mm, start_addr, start_ptep, target, nr);
>  	if (pte_napot(target)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784201104.gi=
t.cuiyunhui@bytedance.com?part=3D13
