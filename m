Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BCC3BE168
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 07:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784187621; cv=none; b=FxB0/m7HefeUmgSGCdCt3ejQyBkQrZBZEQ1IWVdipbadwfKTmf2osRAE5YFhWlx/1ZFQA2pwIkIgB0DxiXfVoz4ejGxQIHIoK7bsoqg+YZgHeKS9goHvj8AQxWkyd7JPu4GqESGusziE5UcsU7d6ohQZ0FcJpv2xmNeNHtYon38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784187621; c=relaxed/simple;
	bh=RM/3Ecb8fZQgL48kmwV0kCi9Yi8RUBjNze42y7mKnt0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UR0uhTP5YcsEgQ9apk7DhbZEssnl6C5ji41+5r5D3bmrXt2Ah5a9Hg4oNtWINhr3UJeX4Ekp18HF86DMdWMRT6gKifPH4WPGAleEt8xcuMrjV+HokWFbBvowzV1nqR+pg/odmsAhQQsPljKEv4gzvsC9nexY0vz7NmKbimLqzwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+TaabZF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+TaabZF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AEFA1F000E9;
	Thu, 16 Jul 2026 07:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784187612;
	bh=wljr/T2LlshqeQ22Csuh+E5q13PHDlmxUBqc5ijKtMg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h+TaabZFtDVw1Egp8y99mzhHnM+tyqS4ks+NKsiIEY6zCk1+96+IrKNLC2SIT5usI
	 /9AAPYRxFawJNzazwaqAUzUnHr/oiBj2uCCjdbeJywRENO39N3BPeVycXlR3qfvm1P
	 Gx/r6qdaWxemFMqKpDvIJOAr2F0+MI12z9Ftu7ElzQ2SL1ZHIYDN2m0VvpEw/E7/bQ
	 /DO/PbMN2i6fwmUjc7HWuQsHoimvgWT6FEfiPaMa457efeRQxivcukMXZWJOuWhUVI
	 36fmjwR1n+dl1mV038y6HvYw7BiNDb7+2CTJjE1ooiC3bZVBaAgCGsHtNz/6x5t2Wb
	 Bsrsma0TFdLUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/10] perf ui hists: Fix uninitialized stack memory
 free on pstack allocation failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260716072351.560311-2-irogers@google.com>
References: <20260710053628.1861645-1-irogers@google.com>
 <20260716072351.560311-1-irogers@google.com>
 <20260716072351.560311-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 07:40:12 +0000
Message-Id: <20260716074012.7AEFA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `hists->symbol_filter_str` points to a local stack array, leading =
to a dangling pointer Use-After-Free when the function returns.
--

--- Patch [2]: [PATCH v6 02/10] perf ui hists: Fix uninitialized stack memo=
ry free on pstack allocation failure ---
commit ee0809111abadd84f6d0242516fc731b6121c8a4
Author: Ian Rogers <irogers@google.com>

perf ui hists: Fix uninitialized stack memory free on pstack allocation fai=
lure

This commit fixes a potential heap corruption issue in the hists browser. It
ensures that the options and actions arrays are initialized prior to alloca=
ting
the pstack, which prevents uninitialized stack pointers from being freed if=
 the
allocation fails.

Closes: https://lore.kernel.org/linux-perf-users/20260709035230.6DBEE1F000E=
9@smtp.kernel.org/
Fixes: f2b487db45f2 ("perf hists browser: Fix possible memory leak")

> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hist=
s.c
> index 671961946d56c..45958bbe45092 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -3064,15 +3064,15 @@ static int evsel__hists_browse(struct evsel *evse=
l, int nr_events, const char *h
>  		browser->min_pcnt =3D min_pcnt;
>  	hist_browser__update_nr_entries(browser);
> =20
> +	memset(options, 0, sizeof(options));
> +	memset(actions, 0, sizeof(actions));
> +
>  	browser->pstack =3D pstack__new(3);
>  	if (browser->pstack =3D=3D NULL)
>  		goto out;
> =20
>  	ui_helpline__push(helpline);
> =20
> -	memset(options, 0, sizeof(options));
> -	memset(actions, 0, sizeof(actions));
> -
>  	if (symbol_conf.col_width_list_str)
>  		perf_hpp__set_user_width(symbol_conf.col_width_list_str);
> =20

[Severity: High]
This isn't a bug introduced by this patch, but while looking at
evsel__hists_browse(), is it safe to assign the local stack array buf to
hists->symbol_filter_str?

tools/perf/ui/browsers/hists.c:evsel__hists_browse() {
    char buf[128];
    ...
		case '/':
			if (ui_browser__input_window(..., buf, ...)) {
				hists->symbol_filter_str =3D *buf ? buf : NULL;
				hists__filter_by_symbol(hists);
				hist_browser__reset(browser);
			}
    ...
}

Since buf is allocated on the stack, the pointer becomes invalid once
evsel__hists_browse() returns.

If the user exits the browser and the background timer later fires while in=
 the
parent menu, the timer executes:

perf_top__sort_new_samples()
  perf_top__resort_hists()
    hists__collapse_resort()
      hists__apply_filters()

Could this result in hists__apply_filters() reading from the dangling stack
pointer and causing a crash?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716072351.5603=
11-1-irogers@google.com?part=3D2
