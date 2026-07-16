Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12F041F7D7;
	Thu, 16 Jul 2026 13:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784207191; cv=none; b=jTvZ8qMlqJ5kw8xuCTKjbyV2ERNJ5KriYQz3KkEROMTYfOnKvDzWRYRhJvwB0pQxHbbHiGIjseKZttbGfVURW4yb1HSM2b+zjpY3u1otDGr+9u8Y5xAuYQnqYqnvuCEjYgbrhYpg8y1INTd90iMn25qgsEm+PAeTedSIllcfYqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784207191; c=relaxed/simple;
	bh=tDyCN2wiQVO6b4PwSKz5OstXUmYBNKdI4D5moRpF6Q0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Wuah5rzR+tWe/8biuHDW0h1JJtonTcVlZxbUY9e1Zt80BaZufuTHfxod0LZFTaC69yx3ZL8ulQaNGoLUi80yWU+YLApt+emGsKXLXbjwH1rLj/uDLvMjahE3mMmCyG5i01PNUl2tF4NqjEr9Mma5yOgzOOfnMtfHJVBqYHOUaMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFlhBgVi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFlhBgVi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7AE1F000E9;
	Thu, 16 Jul 2026 13:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784207189;
	bh=fuqlvCXq2EvpbA8IyXyLRbkFBLbGKsq8xX+k+4zCO4I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kFlhBgViFiObe/6FVII0a906KR2oJJ/DAp1twBGOZrTGW/jYBdvlXSc5RNqKaexLN
	 Co+7mQ22N8BqZJcDMyQlcWyzjT0JYudCDGyVtf+wlhZhYKvEbd/krpxgIwsOLT8Ml6
	 ZDFrG/Kb0ekv5f7xfgrk0cMKrLQGPcBAcvQHfnsECWYJuGApRoTwwddmMLtYo6PBcK
	 czU4BxZstehzeuu+4+7dAudBWZsYQp4ZzEalpzxHb3aEQOEEt52jM0c/3zZcmet8zL
	 XjU0W/uM7u+S60qQ/W+kmMPAiXZyETkSU2w2rFh0oNLEzJlhOC3F4hvEK9Qqq7V1c0
	 U1F9kBZJetznQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/15] mm: extend pte batch and leaf-size helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yunhui Cui" <cuiyunhui@bytedance.com>
Cc: linux-perf-users@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <e821b31e023ee0e5b1c54daed253034bd4da0398.1784201104.git.cuiyunhui@bytedance.com>
References: <cover.1784201104.git.cuiyunhui@bytedance.com>
 <e821b31e023ee0e5b1c54daed253034bd4da0398.1784201104.git.cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 13:06:28 +0000
Message-Id: <20260716130629.7A7AE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The new `__ptep_leaf_size` API encourages a double-read TOCTOU r=
ace in the lockless page table walker `perf_get_pgtable_size()`, violating =
generic lockless walk concurrency rules.
- [Low] The `__pte_batch_clear_ignored()` inline function breaks the build =
for architectures without an MMU (!CONFIG_MMU).
--

--- Patch [5]: [PATCH v2 05/15] mm: extend pte batch and leaf-size helpers =
---
commit a6d281b7dea89e7c1eed5117dbe4f8bc7a9fd3f6
Author: Yunhui Cui <cuiyunhui@bytedance.com>

mm: extend pte batch and leaf-size helpers

This commit extends pte_batch_hint() with batch flags and introduces
__ptep_leaf_size() to give leaf-size users access to the original PTE point=
er.
It also moves batch flag helpers into pgtable.h.

> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 8c093c119e5a8..da14328093a86 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h

[ ... ]

> @@ -1917,6 +1948,17 @@ static inline pmd_t pmd_swp_clear_soft_dirty(pmd_t=
 pmd)
>  }
>  #endif
> =20
> +static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
> +{
> +	if (!(flags & FPB_RESPECT_DIRTY))
> +		pte =3D pte_mkclean(pte);
> +	if (likely(!(flags & FPB_RESPECT_SOFT_DIRTY)))
> +		pte =3D pte_clear_soft_dirty(pte);
> +	if (likely(!(flags & FPB_RESPECT_WRITE)))
> +		pte =3D pte_wrprotect(pte);
> +	return pte_mkold(pte);
> +}
> +

[Severity: Low]
Does moving __pte_batch_clear_ignored() to the global scope in pgtable.h
break the build for !CONFIG_MMU architectures?

The functions pte_mkclean(), pte_wrprotect(), and pte_mkold() are generally
undefined without an MMU. Since this is now placed outside of any CONFIG_MMU
guard, it appears it could cause implicit function declaration errors for
nommu targets.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 51c1200ea3fdd..37b860abe9e61 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -8551,7 +8551,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *=
mm, unsigned long addr)
> =20
>  	pte =3D ptep_get_lockless(ptep);
>  	if (pte_present(pte))
> -		size =3D __pte_leaf_size(pmd, pte);
> +		size =3D __ptep_leaf_size(pmd, ptep, pte);
>  	pte_unmap(ptep);
>  #endif /* CONFIG_HAVE_GUP_FAST */
> =20

[Severity: Medium]
Could the new __ptep_leaf_size() API introduce a Time-Of-Check to
Time-Of-Use race in lockless walkers like perf_get_pgtable_size()?

In perf_get_pgtable_size(), we acquire an atomic snapshot of the PTE using
ptep_get_lockless(), and then pass both the snapshot (pte) and the raw
pointer (ptep) to __ptep_leaf_size().

If an architecture implementation of __ptep_leaf_size() reads the ptep
pointer directly to handle folded mappings, it would perform a second
non-atomic read. A concurrent page table modification could alter the PTE
between the initial ptep_get_lockless() snapshot and the architecture's
read, leading to a mismatched evaluation.

Lockless walkers typically need to derive all information from a single
atomic snapshot to ensure concurrency rules are respected.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784201104.gi=
t.cuiyunhui@bytedance.com?part=3D5
