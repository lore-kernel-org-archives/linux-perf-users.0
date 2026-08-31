Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C99825FA29
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 18:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200991; cv=none; b=Axz5SLIciyTy6wOqOxGNbx6/LPukCZ53D58MvZdDXxghIvEGu/JZvOnG6Q6i1zC/JBw+b1uIo44xOybP9Pkqi07XTjnbQnxC+OHGdnVRHNIv4IcnBAisTPMZnDjAN+UbVwkD+JWtDk+/koQP7e/BYe+l7AI84zleKNoIMy51B5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200991; c=relaxed/simple;
	bh=DLahMF+nf9n96LssX4aM+RMgs/c3atRaUw+LDbxlc7I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kXoxeEx9DSBZiAxhhKLG/29f+n4a2FSKL4BtPS42H3x1kpHg2juAPNdcOVWa0JwarJnEkPORs0dydHmM2VqgNm1BMpt85milHXu9RUM+8cqmjmH/GWqI/8Y3aU2UmrxyITP/s6+Nzg4sOIfA0NE70u/3DnRDj33z8Ym8Q1Pg0Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lv2wLJ+q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lv2wLJ+q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48221F000E9;
	Mon, 31 Aug 2026 18:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788200990;
	bh=2/8mtHt3fvMWqcD+ZjS1zJS8YtTtD+zK1O9OWTEu9yA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lv2wLJ+qOw549hTjL+dHw+ikhgHST6EC/eYX4XloD5eY+jz2Ap/or7v54ZjN45b5p
	 WAbTqrkUuhJ0meRa01qiRoiZIozgY32s3XrRkQkC7zpOw1jCL/WF6ngAsVwzSyahAs
	 FF6S8AcyC7aCHaW06wHlGWWWUT+FrXw6h6HAieVW7wHW18UUwVn/jvrpB8lWELvP6u
	 Kw19vhDcSPYvuWYxNCSZM5lQfJFl+6TW03rlxTrVgx8uMeiVulf+f5homuAVQZtHAb
	 ul08Ycdxv5LISg0MOiOG8iz5YuRlZay5TmJLdEfNNvTt/X9o9oB4xTtLE7DD1S+7Wd
	 zZcMNirs9Q3Tw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC v1 02/19] uprobes: Correctly reject anonymous VMAs for
 breakpoint installation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831150651.1134594-3-ak@kernel.org>
References: <20260831150651.1134594-1-ak@kernel.org>
 <20260831150651.1134594-3-ak@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:29:49 +0000
Message-Id: <20260831182949.D48221F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Page tables are modified under mmap_write_lock without calling vma=
_start_write(vma), risking a race with concurrent per-VMA locked operations.
- [High] Several functions access vma->vm_file or use it for classification=
 without first checking !vma_is_anonymous(vma), leaving them vulnerable to =
anonymous VMAs that have a vm_file set.
--

commit e85d99904cf4af95b805f715ec281558955b0733
Author: Andi Kleen <ak@kernel.org>

uprobes: Correctly reject anonymous VMAs for breakpoint installation

This patch updates valid_vma() to correctly check for anonymous VMAs=20
using vma_is_anonymous() instead of relying only on vm_file.

> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 7709ea8824778..4287c4ff4c0fd 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -139,7 +139,8 @@ static bool valid_vma(struct vm_area_struct *vma, boo=
l is_register)
>  	if (is_register)
>  		flags |=3D VM_WRITE;
> =20
> -	return vma->vm_file && (vma->vm_flags & flags) =3D=3D VM_MAYEXEC;
> +	return !vma_is_anonymous(vma) && vma->vm_file &&
> +		(vma->vm_flags & flags) =3D=3D VM_MAYEXEC;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but since you are fixing the
anonymous VMA check here in valid_vma(), do we need to apply this same
!vma_is_anonymous(vma) check to other functions in this file?

Several other functions, such as valid_ref_ctr_vma(),=20
find_active_uprobe_speculative(), find_active_uprobe_rcu(), and=20
uprobe_mmap(), appear to rely directly on vma->vm_file to determine if=20
a VMA is file-backed.=20

For example, valid_ref_ctr_vma() checks:

    return uprobe->ref_ctr_offset &&
           vma->vm_file &&
           file_inode(vma->vm_file) =3D=3D uprobe->inode;

If an anonymous VMA happens to have a backing file (e.g., from a private=20
mapping of /dev/zero or a driver mapping using vma_set_anonymous()), could=
=20
this incorrectly match the inode and update reference counters in anonymous
memory, or compute incorrect file offsets in the speculative lookups?

[Severity: High]
This is a pre-existing issue, but while reviewing the VMA handling in
uprobes, does this file also need to call vma_start_write(vma) when
modifying page tables?

Paths like register_for_each_vma() and unapply_uprobe() take
mmap_write_lock() and eventually call uprobe_write() to modify page
tables via folio_walk_start() in __uprobe_write().=20

Because mmap_write_lock() does not drain per-VMA read locks, a concurrent=20
page table operation (like MADV_DONTNEED) under a per-VMA lock could=20
clear a PMD and free the PTE page while uprobe_write() is walking it.

Could this race lead to a use-after-free or page table corruption when
tracers manipulate the memory layout concurrently without the protection of=
=20
vma_start_write() draining concurrent VMA-lock readers?

> =20
>  static unsigned long offset_to_vaddr(struct vm_area_struct *vma, loff_t =
offset)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831150651.1134=
594-1-ak@kernel.org?part=3D2
