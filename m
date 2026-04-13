Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F257828E00
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 01:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776045358; cv=none; b=D1kJVCrUlt0oQIpf+BmDoqpm2eOmmFuVy6Z9dqPK8LpSlDICs9d52b683bhrUYriatuOCHsOokfwhL12sQDDduICY74wINMvf2rXm+U3CdNROzBI3AYLkdFTXeqj1/MnAen+Y8PA6IZnxTokC+q1T7BQbFA8oeTq1jbOXdlq4UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776045358; c=relaxed/simple;
	bh=pwT3brcd7acgTH94yFHZC53kr9VQsTeFet2R/9Qfob8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sfOFriiL7Ae1bv+nEmyR53fTeGfpo9GmxU5PMy9vaaRKoZv3az6+aDBd7/0JuqLeTmoRYjh7I1aYS2NyWzfo1TcmKHpgPuzRBrZXcBQ4WgWTv7LyvDj9oIJiKD+TYrMyVA+M+Jqd6X6LMsMXiKTxX+PZKLpg9e+7s5wpFetcxZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6zjNh8C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6zjNh8C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E35C19424;
	Mon, 13 Apr 2026 01:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776045357;
	bh=pwT3brcd7acgTH94yFHZC53kr9VQsTeFet2R/9Qfob8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=X6zjNh8CwBwa0t0VckjcypqppAVAHx0fxo2eqWPVRr3ioZL0vE6mLdoMmPiQtGkAE
	 dLNKIbwZtuWIp7jZdDSXsS9MD/kZ83wQa2O/WalmwIVcGM/V5ImC2M6VnekBt/GKDw
	 3/XRTkssRci1oOvoHIVQ6fQJVdDNFbH0Ljbw9JRXvmDn/28TeFTZkkfh13Cw2xJh+J
	 w7e44w2FEioOlIb2MOn6dFR+mD7tKjFAv9FRg5piHcxEd29zjNqTI/wVZhip/HA2kl
	 IdvVw3KQl4c8sRYl/AXfr29WXOMQfkT/KW+ae5CGCtPSqA+M15TLbWr4DM0RijjZCf
	 FjTrXtSd7NoSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 27/33] perf synthetic-events: Bound check when
 synthesizing mmap2 and build_id events
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260413012227.1089445-28-irogers@google.com>
References: <20260413012227.1089445-28-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Apr 2026 01:55:56 +0000
Message-Id: <20260413015557.72E35C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [Critical] Pre-existing buffer overflow and struct corruption due to copy=
-paste error in build ID truncation.
- [High] The new bounds check silently drops events for valid long paths by=
 returning `-E2BIG`.
- [Low] Abstraction break in bounds checking logic.
--

commit 7fd80916fb020cf9f0223c8f3c7b78eaf05a550e
Author: Ian Rogers <irogers@google.com>

perf synthetic-events: Bound check when synthesizing mmap2 and build_id eve=
nts

This commit adds bound checks when synthesizing mmap2 and build_id events
to make sure the filename doesn't overflow the event and lead to stack
corruption.

> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthet=
ic-events.c
> index de812a2befbc7..a7fef7ac3da68 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -2257,14 +2257,20 @@ int perf_event__synthesize_build_id(const struct =
perf_tool *tool,
>  				    const char *filename)
>  {
>  	union perf_event ev;
> -	size_t len;
> +	size_t len, filename_len =3D strlen(filename);
[ ... ]
> -	len =3D sizeof(ev.build_id) + strlen(filename) + 1;
> +	if (filename_len >=3D sizeof(ev.mmap2.filename))
> +		return -EINVAL;

This isn't a bug, but does it make sense to check the filename length again=
st
ev.mmap2.filename in a build_id event? It might be cleaner to use PATH_MAX
directly to avoid coupling the bounds check to the mmap2 struct definition.

> +
> +	len =3D sizeof(ev.build_id) + filename_len + 1;
>  	len =3D PERF_ALIGN(len, sizeof(u64));
> =20
> +	if (len + MAX_ID_HDR_ENTRIES * sizeof(__u64) > sizeof(ev))
> +		return -E2BIG;

Will this check silently drop events for valid but long paths?

Since union perf_event is statically sized to fit its largest member, paths
that approach the maximum length might leave less than 48 bytes of headroom
for the sample ID headers.

This would cause the function to return -E2BIG for valid files instead of
safely truncating the filename to leave room for the sample IDs, potentially
dropping the event entirely.

> @@ -2303,14 +2309,21 @@ int perf_event__synthesize_mmap2_build_id(const s=
truct perf_tool *tool,
>  					  const char *filename)
>  {
>  	union perf_event ev;
> +	size_t filename_len =3D strlen(filename);

[ ... ]

While reviewing this function, there appears to be a pre-existing issue just
below the diff context regarding how the build_id size is truncated:

	ev.mmap2.build_id_size =3D bid->size;
	if (ev.mmap2.build_id_size > sizeof(ev.mmap2.build_id))
		ev.build_id.size =3D sizeof(ev.mmap2.build_id);
	memcpy(ev.mmap2.build_id, bid->data, ev.mmap2.build_id_size);

Because ev is a union, modifying ev.build_id.size does not actually truncate
ev.mmap2.build_id_size.

Could this allow the memcpy() to overflow the 20-byte mmap2.build_id array =
and
corrupt adjacent fields if bid->size is too large?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260413012227.1089=
445-1-irogers@google.com?part=3D27
