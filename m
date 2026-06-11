Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7907E3612F5
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 06:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781159178; cv=none; b=pmPPN19KmI4kL6M8MGkRBAsP2bo/3QbGj2Osmckhfw/Lvb/3uwU/NoNK5LY0EDRT0jDoxrDNxE2gvWmn8ZIl30bk9+tlAaXj2NDLO5CecBkdV2BLY8JoT5sETeYZup4TogjNni+m0jWedt3YSFP7hzCAiAMgmIXn/BMmc/xJcdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781159178; c=relaxed/simple;
	bh=Mqqq9gXgH3hK/RP+O8n8YSGrCfd78b08LmsxXRggA88=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o1Vu+9B/9b9JV55xcFri6FGARm4DwwDMyMegpO7Qu3QwA3W7ppniyWRynoyn9ewLALn573v0VD6iA/kFu7O80uj4IH7WDLiN/slRFshjUvkNqaRd4E2fwIM5MbJW/4cAyKAft9JKmrQdlITvQQZvDelaq7Y5AY9U4hcAFr71A2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7KUAy81; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7KUAy81"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306B11F00898;
	Thu, 11 Jun 2026 06:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781159176;
	bh=M88dKdeMDPL8ZFm4CHWk1VLkPs8JXc0AoMl0DmGrQR0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f7KUAy81Tk13FIsXCyMly/MPWsAGJ79/FFvvMVh/LcYq4buPB1EtdZirBohIqWyz0
	 AYo8lHQFnaaWUAWHbkEz/MHPwbuwDvzwvcHirT06INX8JTGFozsxQlXPpqAnS6hbyw
	 3ByvRj502y+U8TPm6lM2Pa2UHY7Qg2C5tJ6PVTb361+ShFbzMRP1D7IphxWwgMGwnv
	 aHeHDWyFy9exCZUqbqX6ir7ZO+iGDe7kOjh7tpgORwn5R5/j+YqvojRXu0tCrvKbKj
	 sUlaJleSEhY7NIIuLyHwOSO0Um4In00nCz9APcc+K8462qHmaAgC8U7uF6xu/+fzRn
	 MJl2mSEwHC3PQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] docs/mm: update document for split i_mmap tree
Reply-To: sashiko-reviews@lists.linux.dev
To: "Huang Shijie" <huangsj@hygon.cn>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260611061915.2354307-5-huangsj@hygon.cn>
References: <20260611061915.2354307-5-huangsj@hygon.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 06:26:15 +0000
Message-Id: <20260611062616.306B11F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message claims to document the `i_mmap_tree_unlock_wr=
ite` helper, but it is completely omitted from the documentation text chang=
es.
--

commit d14051a8e507a6d5364fa4f0f61edf41becf1526
Author: Huang Shijie <huangsj@hygon.cn>

docs/mm: update document for split i_mmap tree

This commit updates the documentation to reflect i_mmap locking changes. It
details the split i_mmap tree architecture, new per-tree lock helpers, and
updated lock ordering and page table freeing semantics.

> Add documentation for:
> - CONFIG_SPLIT_I_MMAP split i_mmap tree architecture with per-tree locks
> - New per-tree lock helpers: i_mmap_tree_lock_write/unlock_write

[Severity: Medium]
Does the commit message accurately reflect the changes in the patch?

The message mentions adding documentation for the unlock helper, but
looking at the updated text in the patch, it appears to be missing.

> diff --git a/Documentation/mm/process_addrs.rst b/Documentation/mm/proces=
s_addrs.rst
> index 042d64d72421b..bc0d1ac7136d9 100644
> --- a/Documentation/mm/process_addrs.rst
> +++ b/Documentation/mm/process_addrs.rst

[ ... ]

> @@ -60,6 +60,15 @@ Terminology
>    :c:func:`!i_mmap_[try]lock_write` for file-backed memory. We refer to =
these
>    locks as the reverse mapping locks, or 'rmap locks' for brevity.
> =20
> +  When :c:macro:`!CONFIG_SPLIT_I_MMAP` is enabled, the file-backed i_mma=
p tree
> +  is split into multiple sibling trees (one per NUMA node or a number ba=
sed on
> +  CPU count), each with its own :c:type:`!struct i_mmap_tree` containing=
 a
> +  red/black interval tree and a :c:type:`!struct rw_semaphore`. In this
> +  configuration, :c:func:`!i_mmap_lock_read` and :c:func:`!i_mmap_lock_w=
rite`
> +  acquire all per-tree locks, while VMA insert/remove operations use the
> +  per-tree granularity :c:func:`!i_mmap_tree_lock_write` to lock only the
> +  relevant sibling tree, significantly reducing lock contention.

[Severity: Medium]
Was the documentation for i_mmap_tree_unlock_write accidentally omitted from
this section? The text explains the locking side but does not mention the
corresponding unlock function.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611061915.2354=
307-1-huangsj@hygon.cn?part=3D4
