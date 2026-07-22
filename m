Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9229D221DB6
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 06:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784700964; cv=none; b=Dlln/Lwox+8blYKYr+SUnyDPbv5Q9d7LDud8HZ8ijUjPtQEEHgT2C5vf906JLYvbiYD/R5fcQfQGzJ76OZwpGyubmFL0TLuMbLivaZPF5+HuucKAIwn7g1HnxpoWqJwqMdwbaenDVcSbWVtd5o3ZrflMm9xR19L3cZl0D2MT5KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784700964; c=relaxed/simple;
	bh=5BERvvzD3siWU8mAymVgYR9e41jugcbARjJJZg+PxVQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r2hCuLbxWV6fFlff6J5uPKhI+Wd9zVd8AF7mKMsuxAP2eiSHSLlepuppjWRUvzvUA8yOKZWazvUC/UozR1RH3DUEX+lmB1I9hGC/WoJDe5In4uR2GQz2hXRvQzUsGXb0DFRbNurWrtYGqr7Wlg1h/gu9Yx7QDuZr/0nT1kcGa88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+he7flE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+he7flE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A2E1F000E9;
	Wed, 22 Jul 2026 06:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784700963;
	bh=AeDDwY8GLksVKaFI1HkWcUqhohq2DhHRA3D2y3fJqGw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C+he7flEYOn3SGs4ftWALYv9sHTrbAmh3TSW/Axc9nV4Yr3+OPekyDFqluM0b0RGX
	 8szIi5zsEXXMLG1FvCtgJAqPjFTp2jDTYA+0++R3aoEpu6OcAOOI7chv1gpzJfKPEL
	 UeOL8qeqMePHdpnmijbpfBrNsURcyVpv0ETWVI9+oKnep/00I4zNY1xvGfLG2MU8kI
	 LGqdz2jEqzDPpQCpfVkxR2WM4OXggMCT4v57Vwf6d2sL4zIJNKB09oUUk5iCnXGg1F
	 9h+td17PbW7CEfaMrR5wG573nQ1hXXOBpdxnTkBj5l/rJ15ywxJfl3gGCehddaWHiT
	 7QeTA64NFE+QQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/core: unaccount mmap pages from the charged owners
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael B. Dias" <rafaelbttdias@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260722060353.24-1-rafaelbttdias@gmail.com>
References: <CAFhB66oYbThmK59NiT1YwFZ4z=xkNxj9paga4EJW+mGFHa8f8A@mail.gmail.com>
 <20260722060353.24-1-rafaelbttdias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 06:16:02 +0000
Message-Id: <20260722061603.11A2E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Secondary mmaps (aliases) of a perf event ring buffer permanently =
leak `user->locked_vm` accounting, allowing unprivileged users to trivially=
 exhaust their `RLIMIT_MEMLOCK`.
--

--- Patch [1]: [PATCH] perf/core: unaccount mmap pages from the charged own=
ers ---
commit ab7cc1fb3c31285ce5c06e49334a15704ae57a1b
Author: Rafael B. Dias <rafaelbttdias@gmail.com>
Subject: perf/core: unaccount mmap pages from the charged owners

This commit modifies perf mmap accounting to retain references to the
mm_struct and user_struct charged during ring buffer allocation. It then
uses these stored owners during the final unaccounting to prevent cross-mm
accounting imbalances caused by short-lived donor processes.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 51c1200ea3fdd..12b300c58420d 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
[ ... ]
> @@ -7259,13 +7263,15 @@ static void perf_mmap_account(struct vm_area_stru=
ct *vma, long user_extra, long
>  	atomic64_add(extra, &vma->vm_mm->pinned_vm);
>  }
> =20
> -static void perf_mmap_unaccount(struct vm_area_struct *vma, struct perf_=
buffer *rb)
> +static void perf_mmap_unaccount(struct perf_buffer *rb)
>  {
>  	struct user_struct *user =3D rb->mmap_user;
> =20
>  	atomic_long_sub((perf_data_size(rb) >> PAGE_SHIFT) + 1 - rb->mmap_locke=
d,
>  			&user->locked_vm);
> -	atomic64_sub(rb->mmap_locked, &vma->vm_mm->pinned_vm);
> +	atomic64_sub(rb->mmap_locked, &rb->mmap_mm->pinned_vm);
> +	mmdrop(rb->mmap_mm);
> +	rb->mmap_mm =3D NULL;
>  }

[Severity: High]
This is a pre-existing issue, but does this unaccounting logic permanently
leak locked_vm charges for secondary mmaps (aliases)?

Looking at perf_mmap_rb(), every time a secondary mmap is created, it
charges the user's locked_vm:

    if (refcount_inc_not_zero(&event->rb->mmap_count)) {
        /*
         * Success -- managed to mmap() the same buffer
         * multiple times.
         */
        perf_mmap_account(vma, user_extra, extra);
        refcount_inc(&event->mmap_count);
        return 0;
    }

The same pattern exists in perf_mmap_aux() for AUX buffers, where
perf_mmap_account() is unconditionally called for alias mappings.

However, in perf_mmap_close(), perf_mmap_unaccount() is only called on the
final unmap when the refcount drops to zero. Similarly, the AUX unaccounting
is gated behind refcount_dec_and_mutex_lock(&rb->aux_mmap_count, &rb->aux_m=
utex),
which skips secondary unmaps.

Since an unprivileged user can repeatedly mmap and munmap the same perf
event alias, won't this leak locked_vm charges on every secondary munmap,
eventually allowing trivial exhaustion of their RLIMIT_MEMLOCK?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722060353.24-1=
-rafaelbttdias@gmail.com?part=3D1
