Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172BF3955FF
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 09:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783674119; cv=none; b=jmWKCVIIdV7f3/Ir+NMFJAdlzD25xB/Kewufm23mewQVEvnam37ngV/SANgXWOYDubXnz+krq1nsFpjztaP6q3ttAHrMJuVYUvlu9a/n6BtLQ6/i3EjTHBI1r7XPh2bbLEf+ybVAgEqBFqJbU96jqjB8gnXlp439jGDvyYfilzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783674119; c=relaxed/simple;
	bh=6Vr96M88LmG9/L9HMnB46VeOLAo0wBJpdx4M1x3Nkig=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ElbJ/glV3Ywb/6qtaBFfWURtgrhokG7f7EocBQ+eK/tHldisACEWnPwMOQ7uzZ9aPkoeIDZHA5Otv9WC6Uh7qXdY7PWC9mPD6VOzc4P4nE4567eyJExinum2qkACq1uExEtLYhLwyL4QWlH6ck/Brrolxn9BY2sDkw2XdEdH1TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIWlJZ9e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIWlJZ9e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6E71F000E9;
	Fri, 10 Jul 2026 09:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783674118;
	bh=5ApaiVs3J17+q5Wif6EIuw1N8id035uggF+p20SmRSI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oIWlJZ9eoMvDZYyP4Bffau7iO8VFvFgZSya+uEl+Iu3BCUKE3OQGsVOwaRzyrNuTj
	 MWNTORula1F8xuGW4pu/r+DOLMwvpok5BqYkL4hUKC8WW0Ncs+KTQrJgajPised++B
	 gDg33VNLtGK/VSvcdNOLm5SlF8PNyU1wYIfYvBH88P+unIkUlwx89b4LsyOz4h1kdt
	 E82HYIO6C1eMwxL+hcod1nXacIGiEyDmyXZGKbj0Wg6jjPevl2eqQxcVJoJk5Tphk2
	 DnnVOw/Eu9afzHohxHL/Al+kvLftMUIfFUW8+c9283Fl35SMuZdv2oV5fYWnyUN08X
	 sHSAs3DFaUJTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/14] perf c2c: add HPP list parsing for function
 view histograms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260710084247.3576706-9-jiebin.sun@intel.com>
References: <20260626070355.1556721-1-jiebin.sun@intel.com>
 <20260710084247.3576706-1-jiebin.sun@intel.com>
 <20260710084247.3576706-9-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 09:01:57 +0000
Message-Id: <20260710090157.DC6E71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Calling `reset_dimensions()` for every fallback token in `c2c_fu=
nction_hists__init_output` and `c2c_function_hists__init_sort` clears the g=
lobal `taken` flags during string parsing, defeating duplicate field protec=
tion.
- [Medium] `function_hpp_list__parse` leaks dynamically allocated `c2c_fmt`=
 elements if token parsing fails midway.
- [Low] Missing newline character in error log in `function_hpp_list__add_t=
okens`.
--

--- Patch [8]: [PATCH v2 08/14] perf c2c: add HPP list parsing for function=
 view histograms ---
commit 7b3a4ebd5658b8b4b899fd6fb0008adeb8109767
Author: Jiebin Sun <jiebin.sun@intel.com>

perf c2c: add HPP list parsing for function view histograms

This commit adds the histogram initialization and column parsing
infrastructure to bridge the function view's custom dimensions with the perf
HPP list infrastructure. This enables dynamic column configuration during
hierarchy construction.

> diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browse=
rs/c2c-function.c
> index 7c2bb8f9e1139..0f21cf39f0ce6 100644
> --- a/tools/perf/ui/browsers/c2c-function.c
> +++ b/tools/perf/ui/browsers/c2c-function.c

[ ... ]

> @@ -502,7 +513,156 @@ static __maybe_unused struct c2c_fmt *get_function_=
format(const char *name)

[ ... ]

> +static int
> +c2c_function_hists__init_output(struct perf_hpp_list *hpp_list, char *na=
me,
> +				struct perf_env *env __maybe_unused)
> +{
> +	struct c2c_fmt *c2c_fmt;
> +	int level =3D 0;
> +	int ret;
> +
> +	ret =3D get_function_format(name, &c2c_fmt);
> +	if (ret =3D=3D -ENOMEM)
> +		return ret;
> +	if (ret =3D=3D -ENOENT) {
> +		reset_dimensions();

[Severity: Medium]
Does calling reset_dimensions() here wipe out the global taken flag for all
previously processed tokens? If a user provides a string with multiple
fallback tokens, it seems this clears the flags and defeats the duplicate
field protection, which might allow duplicate columns and lead to
double-frees or list corruption during teardown.

> +		return output_field_add(hpp_list, name, &level);
> +	}

[ ... ]

> +static int
> +c2c_function_hists__init_sort(struct perf_hpp_list *hpp_list, char *name,
> +			      struct perf_env *env)
> +{
> +	struct c2c_fmt *c2c_fmt;
> +	int ret;
> +
> +	ret =3D get_function_format(name, &c2c_fmt);
> +	if (ret =3D=3D -ENOMEM)
> +		return ret;
> +	if (ret =3D=3D -ENOENT) {
> +		reset_dimensions();

[Severity: Medium]
Does this repeated call to reset_dimensions() for sort tokens also cause the
same state corruption as in the output field initialization?

> +		return sort_dimension__add(hpp_list, name, /*evlist=3D*/NULL, env, /*l=
evel=3D*/0);
> +	}

[ ... ]

> +static int function_hpp_list__add_tokens(struct perf_hpp_list *hpp_list,=
 char *list,
> +					 struct perf_env *env, hpp_list_add_fn add)
> +{
> +	char *tok, *tmp;
> +	int ret;
> +
> +	if (!list)
> +		return 0;
> +
> +	for (tok =3D strtok_r(list, ", ", &tmp); tok; tok =3D strtok_r(NULL, ",=
 ", &tmp)) {
> +		ret =3D add(hpp_list, tok, env);
> +		if (ret) {
> +			if (ret =3D=3D -EINVAL || ret =3D=3D -ESRCH)
> +				pr_err("Invalid c2c function-view field: %s", tok);

[Severity: Low]
This isn't a bug, but does this pr_err() need a trailing '\n' to prevent
garbled terminal output? The pr_err() macro in tools/perf wraps eprintf
and does not implicitly append a newline.

> +			return ret;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static int
> +function_hpp_list__parse(struct perf_hpp_list *hpp_list,
> +			 const char *output_str,
> +			 const char *sort_str,
> +			 struct perf_env *env)
> +{
> +	char *output =3D output_str ? strdup(output_str) : NULL;
> +	char *sort   =3D sort_str   ? strdup(sort_str)   : NULL;
> +	int ret =3D 0;
> +
> +	if ((output_str && !output) || (sort_str && !sort)) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
> +
> +	ret =3D function_hpp_list__add_tokens(hpp_list, output, env,
> +					    c2c_function_hists__init_output);
> +	if (ret)
> +		goto out;

[Severity: Medium]
If function_hpp_list__add_tokens() fails midway and returns an error, does
this goto out leak the dynamically allocated c2c_fmt elements? It appears
the previously allocated and registered elements in hpp_list are not freed
when bypassing the normal cleanup path.

> +
> +	ret =3D function_hpp_list__add_tokens(hpp_list, sort, env,
> +					    c2c_function_hists__init_sort);
> +	if (ret)
> +		goto out;

[Severity: Medium]
Does returning early here if the sort string parsing fails also leak the
allocations already made during the output string parsing?

> +
> +	perf_hpp__setup_output_field(hpp_list);
> +out:
> +	free(output);
> +	free(sort);
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710084247.3576=
706-1-jiebin.sun@intel.com?part=3D8
