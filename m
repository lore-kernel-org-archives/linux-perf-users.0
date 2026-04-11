Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A933264E4
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 07:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775892119; cv=none; b=h5duUSdHCEXU2fvSJmode9G6xPD0LuO1KYHCr7Gt0O5MwCVdGH5YQNJF1xDjtb8kifNmQmIUp9zlD5bp4m+oOcFlQhD0zZpizUNW/03VIxohRYW+h4M7zGjv2M2wquWNk2Cb0UM5iFWkkXyz7WvWUfSfc9GcDd25brLHRMPKMmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775892119; c=relaxed/simple;
	bh=p3DoLS/XEIkLnXkAYwHLXTK427KiSvfOcRelULMuHDw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=raUgVZs3YVjxS7l6K0dZjZFa0m3+QpFD3ZFeio0LsJfcO4olXdOvjqhWQLbKRYScIZq8L2Z90u8dgUyXFRWa1t3C31fu2iGUmyo9f4JiZQPllCfD4GDxMe1WYGvbM8CWtkdbsGaNghfmVy9LAe+CXJtxmGvDbskzJFnONGfcQbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVUMP8PD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVUMP8PD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B2AC4CEF7;
	Sat, 11 Apr 2026 07:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775892119;
	bh=p3DoLS/XEIkLnXkAYwHLXTK427KiSvfOcRelULMuHDw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=RVUMP8PDafoAZZfg74SNEXI8xuHYX1xyqoIxGw9kYJkvhD/yy5BPcedgr0pnKE5dQ
	 qRPbjsfkUTJLirfZTjF2+anywxgVqZtGAGNr81EEHk9s4Nufd8B+Ork5wNI+AQCepI
	 NrcTdsbVR6nmiClXL6HqI74QsG4Z/WcaIsncc8CSIHusNEqadYGR5acZ4KpXXBSHsO
	 dZ/UCULuKnsibzbkxONs6UwN+ddO8uaFGdb0jexGzdFrGcvHF6jHoQjkPySxCBnSxg
	 XEVoDCtCkxdMcZ+9cXum8oK5ekwTqKFQAkei8iGuNblEU1AnZGufFKXgUdA4IE5avm
	 8914mNZAFonwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 24/29] perf kmem: Add bounds checks to tracepoint
 read values
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260411065718.372240-25-irogers@google.com>
References: <20260411065718.372240-25-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Apr 2026 07:21:58 +0000
Message-Id: <20260411072158.E8B2AC4CEF7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Returning -1 for unsupported page orders or migrate types silent=
ly aborts the entire `perf` event processing loop.
--

commit 3ddfc38ea8afb79021fcd1c50f48982373408ace
Author: Ian Rogers <irogers@google.com>

perf kmem: Add bounds checks to tracepoint read values

This commit adds bounds checks for the order and migrate_type fields in
page_alloc and page_free events. It prevents out-of-bounds memory accesses
when updating the order_stats tracking array.

> diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
> --- a/tools/perf/builtin-kmem.c
> +++ b/tools/perf/builtin-kmem.c
> @@ -826,6 +826,16 @@ static int evsel__process_page_alloc_event(struct pe=
rf_sample *sample)
>  		.migrate_type =3D migrate_type,
>  	};
> =20
> +	if (order >=3D MAX_PAGE_ORDER) {
> +		pr_debug("Out-of-bounds order %u\n", order);
> +		return -1;

Could returning -1 here abort the entire perf event processing loop?

On architectures like ARM64, the kernel's maximum page order can sometimes =
be
configured higher than 11. Since MAX_PAGE_ORDER is fixed at 11 in this file,
valid high-order allocation events might be legitimately recorded in the
trace.

If we return -1 on these events, does it completely stop the trace processi=
ng
for those architectures instead of just skipping the unsupported sample?
Would it be safer to return 0 to ignore it?

> +	}
> +
> +	if (migrate_type >=3D MAX_MIGRATE_TYPES) {
> +		pr_debug("Out-of-bounds migratetype %u\n", migrate_type);
> +		return -1;

Similarly, could returning -1 here cause the tool to exit prematurely if an
unexpected migrate_type is encountered?

[ ... ]
> @@ -892,6 +902,11 @@ static int evsel__process_page_free_event(struct per=
f_sample *sample)
>  		.order =3D order,
>  	};
> =20
> +	if (order >=3D MAX_PAGE_ORDER) {
> +		pr_debug("Out-of-bounds order %u\n", order);
> +		return -1;

Would returning 0 here also be better to avoid aborting the entire session
when a free event with a large order arrives?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260411065718.3722=
40-1-irogers@google.com?part=3D24
