Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1F5392C24
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 20:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783713711; cv=none; b=Ru0QXMOrBw/ZFoqQbP1c/rnSz7hudxvgo0wZkcBUPvGg1OYpYfAxXdtMH1VXnD4sEZflT3GzKGKI+zaI1FtsIMFFlm5AA8GyfaNhG+jhu7KuLY/qAUOUiZFRqCXeFjGut82mlUdMwo5vPAOefcNqlsp6QaLVTifCAX3XYMyEwlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783713711; c=relaxed/simple;
	bh=C0yc/uuYLvsgrEUyGp2+4X3CQjTzJkNe2dy2iIdTLnw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eiqE8JY4QYZEDDkqWJ43rfEkcuO5loh5C/3U7pXoVT1vzagc+ECRroup0/O05UcLHVXhSCzYwpR6iEXDCieSlhhu/w+S119grHwQF1a5d+W4FPQJXtssMLD5+DVXVPw3YZAdb84qdloj1woiA7eBMS2Jk+gHe2aMUjneteJGFGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ln7ykrWp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ln7ykrWp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FE71F00A3A;
	Fri, 10 Jul 2026 20:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783713710;
	bh=5No/mzDZ1Sv9PD4QmKza+uDoF4kKtMwYG031Uk1oizM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ln7ykrWp9FMX2YIhL/33o5wbwGIf/7jJ6jg+4LR1VCFo7VcBNmvjtiLtCwoecKA4L
	 slmvX8RanA4z5/c4VDT0ky4E0BzZ4a6s9JPuIMyV+mPs0/hSqEaLEkv7Jci9ifcndr
	 4OgVnxuPkSvXQLjRR4G9aeS9KNWpxP5SU70pFlUruF1F1J1kmCxV7uSFKIxszaTwsa
	 7C1+rT7/YszBK2dxBS3VV3lOSQK2h12Ev4ojlpZXIOjmDi3IkLh0T230f23HxqbNtR
	 ujOSd2sUd+ZlqhDVYe/RLnXmKjo+TPeYiJTn/mF2eZ84zasW1iUyeYF9QCFLQ6W63+
	 NDNZ1w37PQTug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tools/lib/api: Check nonfilterable in fdarray__filter()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260710194222.1788638-1-namhyung@kernel.org>
References: <20260710194222.1788638-1-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 20:01:49 +0000
Message-Id: <20260710200150.11FE71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] If `realloc` for `fda->priv` fails in `fdarray__grow()`, a danglin=
g pointer is left in `fda->entries`, leading to a double-free during error =
cleanup.
--

--- Patch [1]: [PATCH] tools/lib/api: Check nonfilterable in fdarray__filte=
r() ---
commit f87f1b3c291ca03e96598f96697566a328711de3
Author: Namhyung Kim <namhyung@kernel.org>

    tools/lib/api: Check nonfilterable in fdarray__filter()
   =20
    IIUC fdarray__filter() should check filterable events only and leave
    non-filterable events to be handled outside.  The recent change to set
    fd to -1 made perf record test stuck forever.  Adding the check the flag
    fixes the problem for me.

> diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
> index ffe8272af59b2..b4570e4981492 100644
> --- a/tools/lib/api/fd/array.c
> +++ b/tools/lib/api/fd/array.c
> @@ -117,6 +117,8 @@ int fdarray__filter(struct fdarray *fda, short revent=
s,
>  	for (fd =3D 0; fd < fda->nr; ++fd) {
>  		if (!fda->entries[fd].events)
>  			continue;
> +		if (fda->priv[fd].flags & fdarray_flag__nonfilterable)
> +			continue;

[Severity: High]
This is a pre-existing issue, but while looking at this file I noticed a
potential double-free in fdarray__grow() during error handling.

If the realloc for fda->entries succeeds but the realloc for fda->priv
fails, the error path frees the newly allocated entries:

tools/lib/api/fd/array.c:fdarray__grow() {
    ...
	struct pollfd *entries =3D realloc(fda->entries, size);

	if (entries =3D=3D NULL)
		return -ENOMEM;

	priv =3D realloc(fda->priv, psize);
	if (priv =3D=3D NULL) {
		free(entries);
		return -ENOMEM;
	}
    ...
}

However, fda->entries is neither updated to point to the new entries block
nor cleared to NULL. If realloc moved the allocation to a new block, the
old fda->entries pointer is now freed memory.

When fdarray__exit() is later called to clean up, it executes
free(fda->entries), which would trigger a double-free on that old pointer.

Would it be better to clear fda->entries to NULL here, or avoid modifying
the struct state until both allocations succeed?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710194222.1788=
638-1-namhyung@kernel.org?part=3D1
