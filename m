Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C4A361974
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 18:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788201767; cv=none; b=NjzJu/cEht/znmrD7KMofQw0tqzhDkCpbCkoyZjRvagVc72ruTdfPzEIRebB5zJO64eP08aPrkbb+9EzMWJ/cnPi6R07J+/jA5Pc/rqbIGiUzJ+OorVv8+2Rnn3O7I4QTEArYDIYro21W6Plv8UOfc4cMIRqOwEa285LMZNWSdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788201767; c=relaxed/simple;
	bh=ID2gj108UpcLdNiBfJkQ13itDG2w4eaZYP8bq5rk6HM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hLl+vVQTUGAb1cMVM2TodiWeT32jRtrPWgUgxbM1yTtmCZgdzrWzxBFadMKmSPkXjxWqk4Gblkebpf8QdOGMg27wrwL/LnSHxC4/TYeEF7SwcneAdMyySfSrNhJU+4TElw+t32FVZgdFbOnIHFLMJS86ks6D3FZhJSihibL/ryo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O20EnJLB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O20EnJLB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA1B1F00A3D;
	Mon, 31 Aug 2026 18:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788201766;
	bh=fi2oIATrXQ/Q5wUv9UZ9J856FUd0lsAojxXObm/T+I0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O20EnJLBgceQNSdH009CTWxK9CtUNpQNCCXrRUeVmU15mHuWVO0AQDgZcNDyUGSAS
	 6EyfIEyzOlVLLd6J68lLFnth+cr+4hQEiaJBqhFp4jkimU5kJMFuDxAyXSi/9Bs4Wb
	 FCv9hkrQI+Ahsn2ycOMeNwjuS4q4GmxB8mn3z9MpeS/hHZhIdSS10HkbzyHKYs8t/p
	 GPV7+JYK9NHutp3bE6YfVIY7V/o5WDb14y5qq94fFBfFxOYWTt/otz7i7aUuNVPGJT
	 Zitq0Vndq5s4flUDTpc4iIwuX7LW0LrngkRFIvRMStnB1K39XwRmx3Zr5YokdeHtBN
	 up/eDv34wRm2A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC v1 03/19] uprobes: Print warning for missing breakpoint
 install
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831150651.1134594-4-ak@kernel.org>
References: <20260831150651.1134594-1-ak@kernel.org>
 <20260831150651.1134594-4-ak@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:42:45 +0000
Message-Id: <20260831184246.1EA1B1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing VMA write lock during uprobe registration exposes page tab=
le modifications to races
--

commit c4ab2afca2dc57fb6a2f6789af30c2bec5a5064c
Author: Andi Kleen <ak@kernel.org>

uprobes: Print warning for missing breakpoint install
   =20
When a uprobe breakpoint installation fails, the error is currently silently
ignored. This commit adds a rate-limited warning to log these failures and
make debugging easier.

> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 4287c4ff4c0fd..941b52c478585 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1630,7 +1630,13 @@ int uprobe_mmap(struct vm_area_struct *vma)
>  		if (!fatal_signal_pending(current) &&
>  		    filter_chain(uprobe, vma->vm_mm)) {
>  			unsigned long vaddr =3D offset_to_vaddr(vma, uprobe->offset);
> -			install_breakpoint(uprobe, vma, vaddr);
> +			int err =3D install_breakpoint(uprobe, vma, vaddr);
                        ^^^^

[Severity: High]
This isn't a bug introduced by this patch, but modifying install_breakpoint=
()
reminded me of a pre-existing issue where it is called from
register_for_each_vma() without isolating the VMA.

In register_for_each_vma(), the code acquires mmap_write_lock(mm) and
dispatches install_breakpoint() or remove_breakpoint():

kernel/events/uprobes.c:register_for_each_vma() {
    ...
		mmap_write_lock(mm);
    ...
		if (is_register) {
			/* consult only the "caller", new consumer. */
			if (consumer_filter(new, mm))
				err =3D install_breakpoint(uprobe, vma, info->vaddr);
		} else if (mm_flags_test(MMF_HAS_UPROBES, mm)) {
			if (!filter_chain(uprobe, mm))
				err |=3D remove_breakpoint(uprobe, vma, info->vaddr);
		}
    ...
}

Both install_breakpoint() and remove_breakpoint() ultimately call
uprobe_write() to clear PTEs and collapse PMDs via __uprobe_write() and
collapse_pte_mapped_thp().

However, as per VMA lock invariants, mmap_write_lock alone does not exclude
concurrent per-VMA read lock holders (like page faults) that acquired the l=
ock
prior to the write lock.

Should register_for_each_vma() call vma_start_write(vma) before dispatching
these functions? Failing to drain per-VMA lock holders could allow readers =
to
concurrently walk the VMA's page tables while uprobe_write() clears them,
potentially leading to use-after-free of PTE pages or stale PMD reads.

> +
> +			if (err)
> +				pr_warn_ratelimited(
> +					"uprobes: probe %pD+0x%llx failed to install (%d)\n",
> +					vma->vm_file,
> +					(unsigned long long)uprobe->offset, err);
>  		}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831150651.1134=
594-1-ak@kernel.org?part=3D3
