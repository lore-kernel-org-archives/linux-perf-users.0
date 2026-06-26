Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1C13DCDA0
	for <linux-perf-users@vger.kernel.org>; Fri, 26 Jun 2026 07:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782458595; cv=none; b=qo0JQY0foTdNWofXivbQ/yit8eEh+lzpd0KPcfJpv1fjIk3XgMub8l5sGtJ328aKB+eUMgyFeUFGJAn/jasVbMYoVMlsc5X69kB0XWmNGK/i9RVqLqrmDUXtAhQuQOET+gKrIvfvraTMgIFn9hWZaE87LxJttXY+Rz50saL4rqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782458595; c=relaxed/simple;
	bh=UMbDdZEeapsVZsIRRk+lWKmmEMjzG85qHp37RfD9eHQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UfPLMirRg1owBCV/RMuwB2fQFcXgtrWVrEMsZIg2uMmmWsdBdmc9Mx94sqsUlTpDYAdryboTISsLU7/xC9dSyvxmMxedVi3dkH8U3reqxCG3DOkgnMZOIgNavn0bNHFjp818Qxz6jP9fCySYGQwhOuOws9oBy4NjURp8+pMkqFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6i/7nYP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6i/7nYP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98DC31F000E9;
	Fri, 26 Jun 2026 07:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782458593;
	bh=f0hd9oY2adgV2IGh51wK6dAqFob7yU9EFNjsewaSb7M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f6i/7nYPBmQlrmTsFq96p74qI3MDWPlu8ycES6qTp9Z2nLJgk9GzZ+PnwKAj+/VRk
	 G1sTwdLORSIocrR5i7aRFxwB4aMj1ketm0584TlIGWqf1CLn3HB3iOPsM+9QDnmugN
	 hrE6aakltLcU9eJb63RiuTxdsdroEcSdu1uMZFl9U38b7njm2I90Rf307wXBktemyR
	 Eg0q7dTyCrSyaaTg1poqy3Vp7+6KvC8v3aD+4j0F8uPkhirQgf4DpTtDx3Cv9ACImx
	 tOmeuVg4TY7hOHdRtMLja/LcSf6ufgNoGoPTzqZz8c4QgHuIp+8Mbamn1Bh3IxKa+J
	 pb5pbeGYPcDHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/14] perf c2c: add dimension definitions and format
 creation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260626070355.1556721-8-jiebin.sun@intel.com>
References: <20260626070355.1556721-1-jiebin.sun@intel.com>
 <20260626070355.1556721-8-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 07:23:13 +0000
Message-Id: <20260626072313.98DC31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The c2c_se_cmp wrapper improperly forces fmt->sort to use dim->s=
e->se_cmp instead of dim->se->se_sort.
--

commit 160d3ea9bf317fa78359c422d21e9cf0a3470f5a
Author: Jiebin Sun <jiebin.sun@intel.com>

perf c2c: add dimension definitions and format creation

This patch adds function view dimension definitions that bind column names
to their rendering and comparison functions. It also introduces lookup and
format creation helpers for the function view.

> diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browse=
rs/c2c-function.c
> index 172e1aa86ecab..794a023239ce1 100644
> --- a/tools/perf/ui/browsers/c2c-function.c
> +++ b/tools/perf/ui/browsers/c2c-function.c

[ ... ]

> @@ -390,6 +390,125 @@ total_stores_cmp(struct perf_hpp_fmt *fmt __maybe_u=
nused,

[ ... ]

> +/* Wrappers so sort_entry-backed dimensions sort/collapse via their se. =
*/
> +static int64_t c2c_se_cmp(struct perf_hpp_fmt *fmt,
> +			  struct hist_entry *a, struct hist_entry *b)
> +{
> +	struct c2c_fmt *c2c_fmt =3D container_of(fmt, struct c2c_fmt, fmt);
> +	struct c2c_dimension *dim =3D c2c_fmt->dim;
> +
> +	return dim->se->se_cmp(a, b);
> +}
> +
> +static int64_t c2c_se_collapse(struct perf_hpp_fmt *fmt,
> +			       struct hist_entry *a, struct hist_entry *b)
> +{
> +	struct c2c_fmt *c2c_fmt =3D container_of(fmt, struct c2c_fmt, fmt);
> +	struct c2c_dimension *dim =3D c2c_fmt->dim;
> +	int64_t (*collapse_fn)(struct hist_entry *a, struct hist_entry *b);
> +
> +	collapse_fn =3D dim->se->se_collapse ?: dim->se->se_cmp;
> +	return collapse_fn(a, b);
> +}
> +
> +static __maybe_unused struct c2c_fmt *get_function_format(const char *na=
me)
> +{
> +	struct c2c_dimension *dim =3D get_function_dimension(name);
> +	struct c2c_fmt *c2c_fmt;
> +	struct perf_hpp_fmt *fmt;
> +
> +	if (!dim)
> +		return NULL;
> +
> +	c2c_fmt =3D zalloc(sizeof(*c2c_fmt));
> +	if (!c2c_fmt)
> +		return NULL;
> +
> +	fmt =3D &c2c_fmt->fmt;
> +
> +	c2c_fmt->dim =3D dim;
> +	INIT_LIST_HEAD(&fmt->list);
> +	INIT_LIST_HEAD(&fmt->sort_list);
> +
> +	fmt->cmp	=3D dim->se ? c2c_se_cmp : dim->cmp;
> +	fmt->sort	=3D dim->se ? c2c_se_cmp : dim->cmp;

[Severity: Medium]
Does this assignment incorrectly bypass the sort_entry's se_sort callback?

Because c2c_se_cmp strictly calls dim->se->se_cmp:

static int64_t c2c_se_cmp(struct perf_hpp_fmt *fmt,
                          struct hist_entry *a, struct hist_entry *b)
{
        ...
        return dim->se->se_cmp(a, b);
}

Using c2c_se_cmp for fmt->sort means we will use se_cmp instead of se_sort.
For example, sorting by the symbol column might sort by memory address offs=
et
rather than alphabetically by symbol name.

Should there be a separate c2c_se_sort wrapper that delegates to
dim->se->se_sort, or similar logic?

> +	fmt->color	=3D dim->color;
> +	fmt->entry	=3D dim->entry;
> +	fmt->header	=3D c2c_header;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626070355.1556=
721-1-jiebin.sun@intel.com?part=3D7
