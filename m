Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1682D1911
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786634260; cv=none; b=ITNAL47R4EFddNuhnhTWuQobW7YL/6mGWdLS+c77L+kfG+nKOKkQevbCyCBwIcGkk7yy8TyKhVSvQSq3d5lpUX4o7mO+R6jEb8coDQeDo9U+/zQ8pQilwINkz613wZH7Lrhp2QtDU9aHpItix97WKO+KdgzsECQ9bFomESSrHuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786634260; c=relaxed/simple;
	bh=h5pstI8iJb/M1qgkFco/YvDxXsz6dUkF8CmWdCBDouA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lBFvC1i7r4N7cpJ6Ow7HmP+urLrB448AZmB0Z4jXBkkQ+xU2QgqSp1Q4I7GHbrbNyh/0xuLz7jxSlAEU4gYks4M8aiBJhgm6V57/JwcNkUjT1cOISwWjX4BFJc9FsTjKHFX2acX4y3Eo5uMDOMyWFxCrHjdzRtVkCmvMDCXv4iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCbGFZ5R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCbGFZ5R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2AA1F000E9;
	Thu, 13 Aug 2026 15:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786634258;
	bh=tq20gecEBA73cxTK65ajj4VYDPCzfNDjOl8MKbCnnaE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dCbGFZ5RwZ+zA5b6wcP07qSHfl3ZiesY3BbCO+gTeIq8hSVuXB9dAoJA2j5JpDqZY
	 eVw/j2H3dXl9nsoppAfDvkA2pB79EgucRq8aDSnBaUKhRfAZvuZZWbUFqQAauB+gfl
	 t5oMnqJFGWynPr2Omg8XIk/Q42buHFr01ssXe2onvhy8NeJomIAf8WrEWnQ9NpWpb0
	 bct3GogZxaVX0T7TSqLLA9YCsU1ZhMOHJ7M6Sw/ck49qcu9Gr1o88j8epjEf8pivYK
	 JyX+q4TmSCZwOE4XZeF0q4EIQiRQrkI03ZnH0h+d6lv3mm3fZoreDIckw7jsoKBJuX
	 9ZZIbZBH6tw4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] perf dso: Use stored fd error instead of stale
 errno in file_read() and file_size()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260813151148.23169-4-acme@kernel.org>
References: <20260813151148.23169-1-acme@kernel.org>
 <20260813151148.23169-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 15:17:38 +0000
Message-Id: <20260813151738.7C2AA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> file_read() and file_size() use ret =3D -errno when
> dso__data(dso)->fd is negative after try_to_open_dso() fails.  By this
> point errno has been through mutex_lock(), nsinfo__mountns_enter(), and
> multiple open() attempts inside try_to_open_dso() =E2=80=94 it no longer
> reflects the actual open failure.  If errno happens to be 0, ret =3D 0
> looks like EOF rather than an error, and file_size() callers like
> dso__data_size() would then report a zero-sized file instead of
> failing.
>=20
> dso__data(dso)->fd is always negative on failure =E2=80=94 -errno from
> __open_dso() when no filename could be built (e.g. -EINVAL, -ENOENT),
> or -1 when do_open() itself failed =E2=80=94 and never 0, so use it direc=
tly
> instead of reading the stale global errno.
>=20
> No assert() or comment is needed after the assignment: the enclosing
> if (dso__data(dso)->fd < 0) already guarantees ret < 0
> [Namhyung Kim review].
>=20
> Fixes: 33bdedcea2d7 ("perf tools: Protect dso cache fd with a mutex")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813151148.2316=
9-1-acme@kernel.org?part=3D3

