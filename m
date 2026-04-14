Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DC638423D
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 22:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776205253; cv=none; b=AscuQ3sOOQzV2yhjSrL+nRCHiKW6QF/1xK/Ir91nxNWtxmIi8/AX0DYqX5aUxSdUqlaYsg1MpHt2gZS2HcKu6+ru2eNeDWilDViJXNn0LWPGZERG0nirTr80t1xu8NdOzsvlZsMaLiyYuNU8ddT9/BXF1IGdK/Or6Dw5YNjBL6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776205253; c=relaxed/simple;
	bh=2Jh+NBQWd69xM9+LGgLAiVNwpMD+0mzDU4gkJ20bQRU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qrGqk+lgSEj6QUNrMWCP/ay3mkpxFcKWwMwpV/oAfLhqwcrwgbBxFQL8fcqeqOsbBOBatW0Jem/WmnIQY0+3R6MA/NvBvdhnos7bwO5dZ0mHlKsV/orH/x7J7f2yeqBkJLUnkrrFFN9DEOohA+5S4BlG09HruW5xbYcQhLR7uME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lX9nnaj/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lX9nnaj/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64651C19425;
	Tue, 14 Apr 2026 22:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776205253;
	bh=2Jh+NBQWd69xM9+LGgLAiVNwpMD+0mzDU4gkJ20bQRU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=lX9nnaj/Jva+LmatMNgpAvjbnBLMpNThw9gUVAVVYTJvfO161DDLtEOZJFzfOekEj
	 j+Sux8sbVjTq4Bz9cbGbgS3uOwwzK1si7XHl34UVskgTThfbcoWlUwK8ZWHZbgL5KE
	 RgRoGZcTXo9u6PwYy++uNGk8xPCmcYkGNaRFTJkRALZXviqRA4EH4VNgkMEksKplkF
	 XYlBNyYjPqb1lBNLvd7ZTYX3TCJRhzSqyYIYLCNNDY9j/YhGAwk35Os/Ozy5OOeH7G
	 MXuLg/rBr+M9UJvONALx54t5ra7Lb3tMp3MIuq0EQyYgrh7MQh46FxJqZqfHgN547F
	 eFsbgMyFLMR8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] perf header: Sanity check HEADER_EVENT_DESC
Reply-To: sashiko@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260414204847.293557-4-acme@kernel.org>
References: <20260414204847.293557-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Apr 2026 22:20:52 +0000
Message-Id: <20260414222053.64651C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [Critical] The patch rejects `sz =3D=3D 0` but fails to enforce a minimum=
 safe length for `sz`, leading to a critical heap buffer overflow during at=
tribute byte-swapping. This problem wasn't introduced by this patch, but th=
e patch's attempt to sanitize `sz` is incomplete.
- [Critical] The newly added bounds check for `nre` can be trivially bypass=
ed, allowing a 32-bit integer overflow when allocating the `events` array t=
hat results in a massive heap out-of-bounds write. This problem wasn't intr=
oduced by this patch, but the patch completely fails to prevent it.
- [High] The newly added bounds check introduces a division-by-zero vulnera=
bility on 32-bit architectures.
--

commit 49409abdc9adae8ec3fbd6033ac0123dfbe6b50b
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf header: Sanity check HEADER_EVENT_DESC

read_event_desc() reads nre, sz, and nr from the file and uses them to
control allocations and loops. This commit adds bounds checks to reject
sz =3D=3D 0, sz exceeding section size, and checks that nre and nr fit in
the remaining section.

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index f8acd06ae9235..696f19739074e 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -2101,6 +2101,13 @@ static struct evsel *read_event_desc(struct feat_f=
d *ff)
>  	if (do_read_u32(ff, &sz))
>  		goto error;
> =20
> +	/*
> +	 * The minimum section footprint per event is sz bytes for the attr
> +	 * plus a u32 for the id count, check that nre events fit.
> +	 */
> +	if (sz =3D=3D 0 || sz > ff->size || nre > (ff->size - ff->offset) / (sz=
 + sizeof(u32)))

Could this regression cause a division by zero on 32-bit architectures?

Since sz is a 32-bit unsigned integer read directly from the file, if it is
set to 0xFFFFFFFC, sz + sizeof(u32) will overflow to 0 on 32-bit systems wh=
ere
sizeof() evaluates to a 32-bit size_t. This would evaluate to:
(ff->size - ff->offset) / 0

Also, does this code allow a small sz value to cause an out-of-bounds access
later during byte-swapping?

If sz is set to a small value between 1 and 7 (e.g., 4), buf =3D malloc(sz)=
 will
allocate a tiny chunk. If the file requires byte-swapping, the subsequent c=
all
to perf_event__attr_swap() will unconditionally read attr->size (bytes 4-7).
This would read out of bounds and potentially use heap garbage to byte-swap
adjacent memory.

Finally, is ff->size validated against the actual physical file size before
this check?

If ff->size is an unvalidated value from the file header, this bounds check
can be bypassed with a huge value. If a file then sets nre to 0xFFFFFFFF,
it would cause the subsequent allocation to overflow to 0:

events =3D calloc(nre + 1, sizeof(*events));

This would return a valid minimal chunk, but the following loop:

for (i =3D 0, evsel =3D events; i < nre; evsel++, i++) {
    evsel->core.idx =3D i;
    ...

would iterate 0xFFFFFFFF times, overwriting the heap array.

> +		goto error;
> +
>  	/* buffer to hold on file attr struct */
>  	buf =3D malloc(sz);
>  	if (!buf)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260414204847.2935=
57-1-acme@kernel.org?part=3D3
