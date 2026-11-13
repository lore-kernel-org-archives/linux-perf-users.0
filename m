Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604619;
	b=xX/BPv6DCDjtERx8Q6PJcCM9tM3E2gL/ynJLNu9sNqe2+5LojOB7m0GzN4Jw0adkHOKO
	 RzdQXVtwD4w5oFujKMO7BgQZdxSD8mN9zltG82tFYFDyruFJ5qC/Ccpp1silRQwUvWlpm
	 gbrdnRsRTXW0xplt4U8LwpPxUkKeyNC6/cTfdeX+XnGSpvvxiQdXXSBZDGYYu0qlel8Fs
	 EbvhIUTUe8JTWP2xHJMd64uC8H81RQkO/yDiDKJtmwS3FJ6v+UnOTWtSFGGNXussNzVFl
	 F3WbSPTOK+Z15Br5nbZxhZly/i3nhIOaeWYRZ/VOAm7PBkRnIwqAARjT3WcHzbX5A0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604619;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MKS45e/R8A8a/j8IaYrH+BW6yvMJ8wilPZ4yAmXdI8U=;
	b=2VRjz5YJN+VLCUvnVrYEr8zx7f23r9E7XlnyWYFSPSb9Yy7jbAcOEu8uUpekp0muGC07
	 E6WDLLAt26K51lOrI1kGsYrx0lGdgUezvsoEMT0BONr/EFRzTqV6f69yBladN71N8AdL+
	 mSTUNt6ZlMOp7VMtyaBUnNWKvDXXcXi7YI/M++xyIkNvYJuw1I0yXMdFLhDLBueBCdx8R
	 0aAlTSYE1AtdddHcfq+ZYbZU5NQ7OP8I1aKLcNWGQkSi0jXogJtlYZJtWZH/G18tdvzsO
	 j0+6dAlyes8Aiv7baseJ/npFYfbRxeK0XBOxu8lBHgQ9E0oBuSReDAZtb0xvztNO89A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qny4n2fD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775BC606A333
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qny4n2fD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0631F000C4;
	Fri, 13 Nov 2026 21:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794604619;
	bh=MKS45e/R8A8a/j8IaYrH+BW6yvMJ8wilPZ4yAmXdI8U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qny4n2fDS2boH8W2GXIYajAe/w6sRIe/Mo49pzZiUNU2h1GJFpvOkReQMCA3df9Fx
	 jQE6lCJlG6rhmaV9bdRO5jkplBBk7V/6vitlXqdKZu0VcEDrw1JehODRpu5KNXfEI4
	 8vXxw8EdLT5hS/sbZeoqcpl6LDbMWi+/f94WKz5wqNbGo6nafmUzOyvTGXsi3W0C17
	 3pgbD3Hw7bg+nCS71EhX48XEV7c/dC1yqBf2NK3unMbzhqApEp4ETVbaM7GzSuEjpU
	 BMBxF7Pk8qu6Tov9D6uSflJO9G/fhBXyPdgZQXV2tGeSR6mIS7VwTS2nWxB0nc0x0j
	 TxY1HEscU49Xw==
Message-ID: <sashiko-outbox-213705@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/10] perf jevents: Add block-indexed string packing
 and --compress=zlib
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113210822.3112700-6-irogers@google.com>
References: <20261113210822.3112700-1-irogers@google.com>
 <20261113210822.3112700-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 21:16:58 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Compressing big_c_string (~6.9 MiB on x86) as a single monolithic stream
> would force perf to allocate and decompress megabytes of unused CPU
> models' strings on startup just to look up a single event or metric,
> whereas compressing each short string individually suffers from poor
> compression ratios and per-string framing overhead.
>=20
> Introduce "block-indexed string compression" via a --compress=3D<formats>
> option to jevents.py (defaulting to 'none'):
> - Sorted, non-folded BigCString byte records are packed sequentially
>   into ~8 KiB blocks without splitting any multi-field event or metric
>   record across a block boundary (with suffix-folded strings inheriting
>   their parent record's block and intra-block offset plus suffix delta).
> - Each block is compressed independently into big_c_string_blob[],
>   indexed by big_c_string_block_offsets[] and big_c_string_raw_lens[],
>   while sharing a common dictionary across blocks so ~8 KiB blocks
> [ ... ]
> --compress=3Dzlib shrinks pmu-events-string.o from ~6.90 MB to ~716 KB
> (~9.6x reduction) while only decompressing touched 8 KiB blocks on
> demand.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113210822.3112=
700-1-irogers@google.com?part=3D5

