Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FE041F37C;
	Thu, 16 Jul 2026 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784206780; cv=none; b=AWBFDVT13tTLQLsdNRMyYRtUqgWBUNA+h7fXFoKIurkdZZ853XNTp9XHqqchLS7pFpdA/VJXuMRqyimlo4GRUK/lpDQi8otH/rnH7AON677RYI/Pwq6Aj1Sf3VAj/ZpukEWJ8aLOXEXkrITWYNB6XSrWLPohUT1U6eD5tT/QX7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784206780; c=relaxed/simple;
	bh=t7fhUZzJT4qZZAXrfEXIsIZIhLUygCk1BaCIuFXx3wI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tff5c+/y9S8zHDyXBXq2dLJBAj5a0HimeOCbFbyCwszOyn6i5Luod5walqFSoKylpJnqwRmn2Cy3bMKhnKdOsNKBG8S7T0w0UkzEV/R5fPHkYEE1ImNdfMhA9Y/CzvGnIv8XQtiJnzeUIs+bNaf/tfRHiYidIFvNDYowuowhPYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgDpmqQ/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgDpmqQ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BF91F00A3A;
	Thu, 16 Jul 2026 12:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784206779;
	bh=hS66ZXYYGoAh87Bknj8kTIMTIVapmK3qYDvLb8h9VBI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jgDpmqQ/JxHIYGtiWU5RlOCxVgPUrggND37NCyFcMK1cJzAvkCjC/T14+kOZK43jC
	 9dPRe/W9UmWh6sXwPq+ViqwW5GMcSvHxPGOW8qo6VXa2xw/loqonDcka0goneaYj6V
	 Iysv+/aMuI37t04xshA5KKdhwG/ZOhUrF4ewDSavCuEeywna3Y/lxqK04pNCq2ub/8
	 s2PMsrTULAWZY9ZS1khXyVmy+/lnX3vf6XhhyRhDfHfn8zJVo0wOmsjq5mzcJagQy0
	 +YnKIE5LW7zhDd7aU6aK/JefadMZbsNMqzb73JfMsCCUA/fTrpDQ8RCyWNYjyHMmqX
	 hNCefTiD7te0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/15] riscv: introduce raw PTE helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yunhui Cui" <cuiyunhui@bytedance.com>
Cc: linux-perf-users@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <2bde82cde4c262d35663d386e8a16455c76ec3e6.1784201104.git.cuiyunhui@bytedance.com>
References: <cover.1784201104.git.cuiyunhui@bytedance.com>
 <2bde82cde4c262d35663d386e8a16455c76ec3e6.1784201104.git.cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 12:59:38 +0000
Message-Id: <20260716125938.E6BF91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The patch declares raw PTE helpers `__ptep_test_and_clear_young` an=
d `__ptep_set_access_flags` but never defines them, causing a linker error.

Pre-existing issues:
- [High] Non-atomic read-modify-write in `__ptep_set_wrprotect` can overwri=
te concurrent hardware A/D bit updates, causing silent data corruption.
--

--- Patch [1]: [PATCH v2 01/15] riscv: introduce raw PTE helpers ---
commit 3ca72eca5363bad7487aaf256a6d44b7c83506ca
Author: Yunhui Cui <cuiyunhui@bytedance.com>

riscv: introduce raw PTE helpers

Svnapot needs RISC-V to distinguish between two PTE views: the raw encoded
entries used by architecture code, and the logical per-page PTE view that
will later be exposed to generic MM paths. Split the low-level RISC-V PTE
operations from the public helpers so the raw helpers can keep operating on
the hardware encoding.

> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pg=
table.h
> index a810655ce8f9b..8ca5da9534967 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
[ ... ]
>  #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS	/* defined in mm/pgtable.c */
>  extern int ptep_set_access_flags(struct vm_area_struct *vma, unsigned lo=
ng address,
>  				 pte_t *ptep, pte_t entry, int dirty);
> +int __ptep_set_access_flags(struct vm_area_struct *vma,
> +			    unsigned long address, pte_t *ptep,
> +			    pte_t entry, int dirty);
>  #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG	/* defined in mm/pgtable.c=
 */
>  bool ptep_test_and_clear_young(struct vm_area_struct *vma,
> -		unsigned long address, pte_t *ptep);
> +			       unsigned long address, pte_t *ptep);
> +bool __ptep_test_and_clear_young(struct vm_area_struct *vma,
> +				 unsigned long address, pte_t *ptep);
> =20

[Severity: Low]
Are the newly declared __ptep_test_and_clear_young() and
__ptep_set_access_flags() functions implemented anywhere in this patch?

They appear to be declared here but missing definitions, which could cause a
linker error when __ptep_clear_flush_young() calls them below.

[ ... ]
>  #define __HAVE_ARCH_PTEP_SET_WRPROTECT
> -static inline void ptep_set_wrprotect(struct mm_struct *mm,
> -				      unsigned long address, pte_t *ptep)
> +static inline void __ptep_set_wrprotect(struct mm_struct *mm,
> +					unsigned long address, pte_t *ptep)
>  {
>  	pte_t read_pte =3D READ_ONCE(*ptep);
>  	/*
> @@ -705,9 +784,11 @@ static inline void ptep_set_wrprotect(struct mm_stru=
ct *mm,
>  			((pte_val(read_pte) & ~(unsigned long)_PAGE_WRITE) | _PAGE_READ));
>  }

[Severity: High]
This is a pre-existing issue, but does this non-atomic read-modify-write
sequence overwrite concurrent hardware A/D bit updates?

If a concurrent hardware A/D bit update (e.g. via the RISC-V Svadu hardware
page table walker) occurs between the READ_ONCE(*ptep) and the
atomic_long_set(), it seems any bit set by the hardware during this window
would be permanently lost. Could this lead to silent data corruption if a
dirty bit is lost on a writable page during writeback?

This would also propagate to huge pages since pmdp_set_wrprotect()
delegates to this helper.

> +#define __ptep_set_wrprotect __ptep_set_wrprotect
> +
>  #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
> -static inline bool ptep_clear_flush_young(struct vm_area_struct *vma,
> -		unsigned long address, pte_t *ptep)
> +static inline bool __ptep_clear_flush_young(struct vm_area_struct *vma,
> +					    unsigned long address, pte_t *ptep)
>  {
>  	/*
[ ... ]
> -	return ptep_test_and_clear_young(vma, address, ptep);
> +	return __ptep_test_and_clear_young(vma, address, ptep);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784201104.gi=
t.cuiyunhui@bytedance.com?part=3D1
