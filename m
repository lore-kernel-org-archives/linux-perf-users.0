Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA06219EB
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 17:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777483986; cv=none; b=GiMkuLQMzsyzSivSeiRzXFQBCXyW+BZNr3nxlG5r0+QFY20qQn2dTRGMyiSYekJeSC3AVYRYgN4gjOLXcWuNHVUtXntDIMlz+LsDSPlAiciGF9YaCI0vVoXcfOy+qTA0J5wId1v8Uf0zu0g+94T2z8vEdrreaG/k0z0B/cIRMWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777483986; c=relaxed/simple;
	bh=6SV3yBiPr4Clmo2K3FrR73YH9iC3jv5cimPK1hB1Lk8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L5Q4No/Bq5EZEBrNd6R+kGVb1Ww+IvTadKeoUo0bwyZDwXOZ+NoRez7WerXWE0KLzSi6sawHT9Eo7xmgUL7zioUbT8IDMDvmNCbK60NmqxTA+VZFV4NlVn3A1k4VGVkz0iVZyX9frTWgKZTBQOdJI5akmsa0JWxRydM9bN1cI/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffHq1L3m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffHq1L3m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9421EC19425;
	Wed, 29 Apr 2026 17:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777483985;
	bh=6SV3yBiPr4Clmo2K3FrR73YH9iC3jv5cimPK1hB1Lk8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ffHq1L3mCtvfzHrDzM1IL9vGALkt0/2ky/C4Ji3+WucvSjhOqJnOADg1hr8+ayhxd
	 DVJbHGcmwFeclerDlH77VdUiMsvPIuEXnbK4GxjXVxF7QmH+BZbdX3yyuuNmJuyexJ
	 tdbwJTfs1zo657G7ihc5y12unWlPWgtEVM3Xgp3MrzDAHPKM0G/NB/TFh1MzF9S3FD
	 qO/QjIrHyYTjd4Xuq+TLFbuszoGWHlGIr7ZCPrAolWUvHQXP7GTkTC68mboFba/gAQ
	 pKQpnJ+8p3Afsy0tcogg6jgtzTxw40Oa1BtK5vGvOlEwbKFwAGhqMRrXpTwqj/yvCs
	 bXjl83+NhWtnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/madvise: preserve uprobe breakpoints across
 MADV_DONTNEED
Reply-To: sashiko@lists.linux.dev
To: "Darko Tominac" <dtominac@cisco.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260429131522.4049054-1-dtominac@cisco.com>
References: <20260429131522.4049054-1-dtominac@cisco.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 17:33:04 +0000
Message-Id: <20260429173305.9421EC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Incorrect VMA classification using vma->vm_file instead of vma_is_=
anonymous()
- [High] VMA addresses used as boolean flags (0 used as 'not found' sentine=
l)
- [High] Ignored return value in the slow path of madvise_dontneed_free() s=
ilently swallows errors
--

commit 0e33540d810d6a2eadc17b982d88ac4970eca760
Author: Darko Tominac <dtominac@cisco.com>

mm/madvise: preserve uprobe breakpoints across MADV_DONTNEED

This patch modifies MADV_DONTNEED and MADV_FREE behavior to prevent discard=
ing
file-backed pages that contain active uprobe software breakpoints. It adds
checks to identify if a VMA contains uprobes and handles them via a slow pa=
th
that skips zapping the specific pages containing breakpoints.

Cc: xe-linux-external@cisco.com
Cc: danielwa@cisco.com
Signed-off-by: Darko Tominac <dtominac@cisco.com>

> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 4084e926e284..0f8aea99b96f 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
[ ... ]
> @@ -1654,6 +1675,60 @@ vma_has_uprobes(struct vm_area_struct *vma, unsign=
ed long start, unsigned long e
>  	return !!n;
>  }
> =20
> +/**
> + * vma_first_uprobe_addr - find first uprobe in a vma range.
> + * @vma: the vma to search.
> + * @start: start address of the range (inclusive).
> + * @end: end address of the range (exclusive).
> + *
> + * Used by madvise to skip directly to uprobe pages.
> + *
> + * Return: the page-aligned virtual address of the first uprobe in
> + * [@start, @end), or 0 if none exists.
> + */
> +unsigned long vma_first_uprobe_addr(struct vm_area_struct *vma,
> +				    unsigned long start, unsigned long end)
> +{
> +	loff_t min, max, first_offset;
> +	struct inode *inode;
> +	struct rb_node *n, *t;
> +	struct uprobe *u;
> +
> +	/* No uprobes possible on anonymous mappings */
> +	if (!vma->vm_file)
> +		return 0;

Should this use !vma_is_anonymous(vma) instead of checking vma->vm_file?

Since private anonymous mappings of /dev/zero have vm_file !=3D NULL but are
otherwise treated as anonymous, won't this incorrectly classify them as
file-backed and unnecessarily proceed with uprobe checks?

Also, since valid virtual addresses (like vm_start) can legitimately be zer=
o,
is it safe to use 0 as a sentinel value for not found? If a uprobe is
installed at virtual address 0, it seems this would incorrectly signal that
no uprobe was found.

[ ... ]
> diff --git a/mm/madvise.c b/mm/madvise.c
> index ce238dd96f15..c9d3c26efd74 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
[ ... ]
> @@ -947,12 +972,46 @@ static long madvise_dontneed_free(struct madvise_be=
havior *madv_behavior)
>  		VM_WARN_ON(range->start > range->end);
>  	}
> =20
> -	if (behavior =3D=3D MADV_DONTNEED || behavior =3D=3D MADV_DONTNEED_LOCK=
ED)
> -		return madvise_dontneed_single_vma(madv_behavior);
> -	else if (behavior =3D=3D MADV_FREE)
> -		return madvise_free_single_vma(madv_behavior);
> -	else
> -		return -EINVAL;
> +	/*
> +	 * Preserve uprobes: if any uprobes are active in this VMA range,
> +	 * avoid discarding pages that contain active breakpoints.
> +	 *
> +	 * Fast path: if no uprobes are registered system-wide, or the VMA
> +	 * is not file-backed (uprobes only instrument file-backed mappings,
> +	 * so anonymous VMAs can never contain breakpoints), or no uprobes
> +	 * are present in this VMA range, proceed with the full operation.
> +	 */
> +	if (likely(!any_uprobes_registered()) ||
> +	    !madv_behavior->vma->vm_file ||

Similar to the question above, should this use vma_is_anonymous() instead
of checking vm_file, to avoid erroneously taking the slow path for private
/dev/zero mappings?

> +	    !vma_has_uprobes(madv_behavior->vma, range->start, range->end))
> +		return madvise_dontneed_free_range(madv_behavior,
> +						   range->start, range->end);
> +
> +	/*
> +	 * Slow path: jump from uprobe to uprobe via rbtree lookup, zapping
> +	 * the clean range before each uprobe page. This is O(M * log N)
> +	 * where M is the number of uprobes in the range and N is the total
> +	 * uprobe count, versus O(pages) for a page-by-page scan. 'cur'
> +	 * tracks the beginning of the current clean range.
> +	 */
> +	cur =3D range->start;
> +	end =3D range->end;
> +	while (cur < end) {
> +		uprobe_addr =3D vma_first_uprobe_addr(madv_behavior->vma,
> +						    cur, end);
> +		if (!uprobe_addr) {

If uprobe_addr is 0 (a potentially valid virtual address), does this loop
terminate early and incorrectly zap the uprobe at address 0?

> +			/* No more uprobes - zap the rest */
> +			madvise_dontneed_free_range(madv_behavior, cur, end);

Does this code need to check the return value of madvise_dontneed_free_rang=
e()?

If madvise(MADV_FREE) is called on a file-backed VMA with uprobes, the fast
path would return -EINVAL. However, because the return value here is ignore=
d,
won't the slow path unconditionally return 0 and silently swallow the error?

> +			break;
> +		}
> +		/* Zap the clean range before the uprobe page */
> +		if (cur < uprobe_addr)
> +			madvise_dontneed_free_range(madv_behavior, cur,
> +						    uprobe_addr);

Does this call also need its return value checked to prevent swallowing err=
ors?

> +		/* Skip past the uprobe page */
> +		cur =3D uprobe_addr + PAGE_SIZE;
> +	}
> +	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260429131522.4049=
054-1-dtominac@cisco.com?part=3D1
