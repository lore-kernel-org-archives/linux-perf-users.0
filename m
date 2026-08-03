Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688AB40B11C
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Aug 2026 15:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785769641; cv=none; b=rKI/embUcr1G4PFk9jpVX2NL0Utypdx3kK8bENEid3uQlLW2UvSn3FiJ+OF3zs6lODDhNQFc9Z6BiiEW2ZK2I21Urj6eWIlSHPbhhwOJn4aTOY0f4+5mDhY/dLc+8wJIhb3ieUXOEtaMtd+/LdP59qfaHP6onqSccIXFKluJahc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785769641; c=relaxed/simple;
	bh=7LCkkaHDIwhzFF9xsw6cf678pSpO60Z+9+2HupLBVwU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lkbopWtLZEnrX9r8iXTqg+m2J6GqaNaqzdiLliEWFKXdA7Tvxg72dtbBTNsjk8s9TuDDbF3gYCTUTUMKWhzAP4NnqYYGJc9g7bBqE2Gt9vwsNumAcy337AKnKg3qnx3ontZuVGpopIbueNuR7P+W3CvGT9ATaUHYfoYV2PYOxVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kc7Mo3JV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kc7Mo3JV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69A81F000E9;
	Mon,  3 Aug 2026 15:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785769640;
	bh=1HfqNstYAWqopEwpXwMT+ACK9Tnax65+YHaER1y6NOg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kc7Mo3JVmx+nAn4BKMFMOlj7JcJLrdLQTCmqmX4bxCyuItmZG4IufIOv5skAYwsow
	 s9ZLTMhTCmTsedPbWfd3jnkAbIdkfvCZkTx2C4C6C7Ebqpq6tW6Kab+i7Dw/EO+UuV
	 TzPRb8Hs37G67SKU3SonIU/c45gq2uaJzzEgN0iNDyfznWbiTfI6aofQKzP9lIn3s9
	 j1ry+XDrHb8Okpy2BadDCbyo/XWA/SCPB8BHbzKXmpD+cKK21Y+aniHGivYG+azCjA
	 z3cfm8YwCVEL071DqkyIR8afYjAO9LvKJnqOChdiztyX/hlTOuSFbWGm0GplrYbOP9
	 Z97B8TaIY53Hg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] perf c2c: Clean up registered formats on
 c2c_hists__init() failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260803144119.185637-3-acme@kernel.org>
References: <20260803144119.185637-1-acme@kernel.org>
 <20260803144119.185637-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 15:07:19 +0000
Message-Id: <20260803150719.D69A81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unconditional memory leak of dynamically allocated format structur=
es in `print_pareto()`.
- [High] Architectural/API Misuse: `perf_hpp__setup_output_field()` and `pe=
rf_hpp__append_sort_keys()` silently corrupt the global `perf_hpp_list`.
--

--- Patch [2]: [PATCH 2/2] perf c2c: Clean up registered formats on c2c_his=
ts__init() failure ---
commit c2ba37f5e0548f4ffed858d39e640349044131b2
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf c2c: Clean up registered formats on c2c_hists__init() failure

This commit addresses a memory leak when c2c_hists__init() fails partway
through parsing. It ensures partially registered format structures are
unregistered before returning the error. This protects callers from leaking
memory during report generation.

> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index b0f2ba8318304..e66e9ca8618dc 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -2142,6 +2142,8 @@ static int c2c_hists__init(struct c2c_hists *hists,
>  			   int nr_header_lines,
>  			   struct perf_env *env)
>  {
> +	int ret;
> +
>  	__hists__init(&hists->hists, &hists->list);
> =20
>  	/*
> @@ -2154,7 +2156,13 @@ static int c2c_hists__init(struct c2c_hists *hists,
>  	/* Overload number of header lines.*/
>  	hists->list.nr_header_lines =3D nr_header_lines;
> =20
> -	return hpp_list__parse(&hists->list, NULL, sort, env);
> +	ret =3D hpp_list__parse(&hists->list, NULL, sort, env);
> +
> +	/* Unregister any formats added before the failure point */
> +	if (ret)
> +		perf_hpp__reset_output_field(&hists->list);
> +
> +	return ret;
>  }

[Severity: High]
This is a pre-existing issue, but does print_pareto() unconditionally leak
dynamically allocated format structures?

Every time print_pareto() is called during C2C reporting, it initializes
a local stack variable for the formats:

tools/perf/builtin-c2c.c:print_pareto() {
        struct perf_hpp_list hpp_list;
        ...
        perf_hpp_list__init(&hpp_list);
        ret =3D hpp_list__parse(&hpp_list, cl_output, NULL, env);
        ...
}

However, when the function exits on both success and error paths, it doesn't
call perf_hpp__reset_output_field() on hpp_list. Does this mean the formats
attached to this local list are permanently leaked when the list goes out of
scope?

[Severity: High]
This is a pre-existing issue, but do perf_hpp__setup_output_field() and
perf_hpp__append_sort_keys() unintentionally corrupt the global
perf_hpp_list instead of updating the passed local list?

When these functions are called with a local list, they iterate over the
local list but invoke the register functions directly:

tools/perf/ui/hist.c:perf_hpp__setup_output_field() {
        ...
        perf_hpp__column_register(fmt);
        ...
}

tools/perf/ui/hist.c:perf_hpp__append_sort_keys() {
        ...
        perf_hpp__register_sort_field(fmt);
        ...
}

These wrappers appear to be hardcoded to insert elements into the global li=
st:

tools/perf/util/hist.h:
#define perf_hpp__column_register(format) \
        perf_hpp_list__column_register(&perf_hpp_list, format)

Does this leave the required fields missing from the local list, while
simultaneously polluting the global perf_hpp_list state with dynamically
allocated objects?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803144119.1856=
37-1-acme@kernel.org?part=3D2
