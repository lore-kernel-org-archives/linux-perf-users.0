Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4AB27470
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 01:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776044830; cv=none; b=Cn0zzt/b0mguclxsUjl9EQgiTYKFZAX8A+Gd4CJmhxk5jCgMnt609ei/0NQlW7Rj2kHDOkDlZvD6/DDl/qkzD2em2RRIgaz0OMYZtiUlmLVqRY06/zWaQm8YoStFKrr0K1TYY4m7IuF9jq1EzadAV3E228JKhK3aBkRpWA3Lxko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776044830; c=relaxed/simple;
	bh=eJScwfMSf7tdudMjNrpXKHGh6yJ5wLx61Gg1tODO18o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m5JR7JI8vJuPCbP0i79Twrd6IsXQQJaJmXDFp78iIrvOtkkO/s01GYnxt4jCzjEjQO/LA716UGQITZgp02MXyiWPOMMJJNDJHWHgammuxXTkqbjI/5obTUyO220mmQXAiBD/bx88Z9n78dWTIYv8slKRy9YlHskAYelZFEX+bbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0z4idNL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0z4idNL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E82C19424;
	Mon, 13 Apr 2026 01:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776044830;
	bh=eJScwfMSf7tdudMjNrpXKHGh6yJ5wLx61Gg1tODO18o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=b0z4idNLu2pBL8tc1jwni7fXTcNwUQrEbkBawDxr1JNiEwK6b3pqlqJHYX3KINNR+
	 Q1PG0zYEvYVcOZ7OZaIAkNCqrfs2kCyi3kVvQzDbyulH4Xjbgxy4Wfe7V/ooL+8NA+
	 jlejAGVdc8zeejB3PszZ4eon0Ag9RIzn7GEiSjdmybaklejZgOmNgPmMgFlvCVZ3Pn
	 Te39E1hQRwxn+D17hzxEgywqlwN8s5gYQ3xM+gs66Ag+ekxYoJ4d7YgDVFG7dkN5eS
	 fAAW9Z49QbO/uEilQsVVvnCBKMm70CHSAe+Yif/2MXGG1QrE/NKcfm3BKkVU+3aw02
	 QfSHIcQHdTZVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 28/33] perf kmem: Add bounds checks to tracepoint
 read values
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260413012227.1089445-29-irogers@google.com>
References: <20260413012227.1089445-29-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Apr 2026 01:47:09 +0000
Message-Id: <20260413014709.E1E82C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The expression `kmem_page_size << order` is evaluated before the=
 bounds check on `order`, leading to undefined behavior for large values.
--

commit ca9443054d9f6f035d544a17db70ef586c3b3ae2
Author: Ian Rogers <irogers@google.com>

perf kmem: Add bounds checks to tracepoint read values

This commit adds bounds checking for order and migrate_type in page
allocation and free events to prevent out-of-bounds array accesses.

> diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
> --- a/tools/perf/builtin-kmem.c
> +++ b/tools/perf/builtin-kmem.c
> @@ -826,6 +826,16 @@ static int evsel__process_page_alloc_event(struct pe=
rf_sample *sample)
>  {
>  	u64 page;
>  	unsigned int order =3D perf_sample__intval(sample, "order");
>  	unsigned int gfp_flags =3D perf_sample__intval(sample, "gfp_flags");
>  	unsigned int migrate_type =3D perf_sample__intval(sample, "migratetype"=
);
>  	u64 bytes =3D kmem_page_size << order;

Could this bitwise shift invoke undefined behavior if a malformed event
provides an order value larger than the bit width of kmem_page_size?

>  	u64 callsite;
>  	struct page_stat *pstat;
>  	struct page_stat this =3D {
>  		.order =3D order,
>  		.gfp_flags =3D gfp_flags,
>  		.migrate_type =3D migrate_type,
>  	};
> =20
> +	if (order >=3D MAX_PAGE_ORDER) {
> +		pr_debug("Out-of-bounds order %u\n", order);
> +		return -1;
> +	}

Since the bounds check on order happens down here, would it be safer to
move the calculation of bytes until after the validation?

[ ... ]

> @@ -892,6 +902,11 @@ static int evsel__process_page_free_event(struct per=
f_sample *sample)
>  {
>  	u64 page;
>  	unsigned int order =3D perf_sample__intval(sample, "order");
>  	u64 bytes =3D kmem_page_size << order;

Does this have the same evaluation issue, where a corrupted order value
could cause an invalid shift before reaching the bounds check?

>  	struct page_stat *pstat;
>  	struct page_stat this =3D {
>  		.order =3D order,
>  	};
> =20
> +	if (order >=3D MAX_PAGE_ORDER) {
> +		pr_debug("Out-of-bounds order %u\n", order);
> +		return -1;
> +	}
> =20
>  	if (use_pfn)
>  		page =3D perf_sample__intval(sample, "pfn");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260413012227.1089=
445-1-irogers@google.com?part=3D28
