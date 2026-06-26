Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7622F8E8E
	for <linux-perf-users@vger.kernel.org>; Fri, 26 Jun 2026 07:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782458188; cv=none; b=K1PflRMzLslzS0fm+2GXLEXI95qQA6MxVLMf1gotg/2MkXaGAfE8MsvY4C5ke2CNvIAiG8WHqlQVGAozUs7R3EYOX7VaeHtgVm2WN1hRnmA7ORxsAoYFp6ZZ/GUNB48QTgnqj9HA//rQxdxY8XpswwpA/r3bBpE228leJ+vue5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782458188; c=relaxed/simple;
	bh=fgzbOET+EIL2qG2JZOmH5baDviwVN9XG2Wetwklhjso=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R4/on/aX9jjhi+UGXYKLYXCUnbEBJcwN4RyjKPklJZrYP78z3g0GooM+Q0/5Z4D3afuOjKGhMSWbwtMJkVYhyQ9vGZ9ScFrxqUoFtP/1KkkthoCgLicfF/B8WdKpySSXsz/RBB9t1A4EOXa0qFAY3aeuxZ5iOHgiIquUAJxuqy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aq9U6ZmY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aq9U6ZmY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBDE1F00A3A;
	Fri, 26 Jun 2026 07:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782458186;
	bh=ps3BsgDNZ7VurGqJIqMF6ov5TFXEKz1FUlUqqxCLH0Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Aq9U6ZmY6bfiuQKvNUiuQY6yDIdgGicJkjorUUMDL46lByQaLps0GIATHz+T/YOKv
	 NAGTICrd9GzWdHC2+lkjUkEpBngd0VSKOZ+UNUVnFa3cnZAr7v8Shvxp9wySeCOT18
	 IycX+rl3RYhubpZLFW1G7ndaXOii0kL1rvxbWgPe5J8cSPHGOClCkSbYH+AKw9820M
	 GDdANd4rcJibbMraA+m/hMfeOpqVN2TQZqs1S2xdohsYTkOInnanw40D8Eitx+eJOQ
	 bEkPu0r3i8SvDDqggNNwwt3z6o3+c/QXxRoPpUXIEzzTBlw+9hRfXIfEIntFafRZvo
	 WxOLPFsUWT4VQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/14] perf c2c: add HPP list parsing for function view
 histograms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260626070355.1556721-9-jiebin.sun@intel.com>
References: <20260626070355.1556721-1-jiebin.sun@intel.com>
 <20260626070355.1556721-9-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 07:16:26 +0000
Message-Id: <20260626071626.9BBDE1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] OOM failures in get_function_format() are swallowed and misrepor=
ted as invalid dimensions.
--

commit c2feb45b926c3d4847f0ee3b178a0bfe059a7079
Author: Jiebin Sun <jiebin.sun@intel.com>

perf c2c: add HPP list parsing for function view histograms

This commit adds the histogram initialization and column parsing
infrastructure for the perf c2c function view. It bridges custom dimensions
with the perf HPP list infrastructure to enable dynamic column configuratio=
n.

> diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browse=
rs/c2c-function.c
> index 794a023239ce1..c11a81d93c21e 100644
> --- a/tools/perf/ui/browsers/c2c-function.c
> +++ b/tools/perf/ui/browsers/c2c-function.c
[ ... ]
> @@ -509,6 +509,146 @@ static __maybe_unused struct c2c_fmt *get_function_=
format(const char *name)
>  	return c2c_fmt;
>  }
> =20
> +static int
> +c2c_function_hists__init_output(struct perf_hpp_list *hpp_list, char *na=
me,
> +				struct perf_env *env __maybe_unused)
> +{
> +	struct c2c_fmt *c2c_fmt =3D get_function_format(name);
> +	int level =3D 0;
> +
> +	if (!c2c_fmt) {
> +		reset_dimensions();
> +		return output_field_add(hpp_list, name, &level);
> +	}

[Severity: Medium]
If zalloc() fails inside get_function_format(), it returns NULL. Does this
fallback path swallow the -ENOMEM and mistakenly treat it as an unknown
dimension?

Since it falls back to output_field_add() which will fail with -EINVAL, the
caller function_hpp_list__add_tokens() might print the misleading error
'Invalid c2c function-view field' instead of reporting the memory allocation
failure.

[ ... ]
> +static int
> +c2c_function_hists__init_sort(struct perf_hpp_list *hpp_list, char *name,
> +			      struct perf_env *env)
> +{
> +	struct c2c_fmt *c2c_fmt =3D get_function_format(name);
> +
> +	if (!c2c_fmt) {
> +		reset_dimensions();
> +		return sort_dimension__add(hpp_list, name, /*evlist=3D*/NULL, env, /*l=
evel=3D*/0);
> +	}

[Severity: Medium]
Similarly here, does this path also swallow an -ENOMEM from
get_function_format() and mistakenly treat it as an unknown dimension?

> +
> +	/* Mark symbol-backed sort keys so hists__has(hists, sym) is correct. */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626070355.1556=
721-1-jiebin.sun@intel.com?part=3D8
