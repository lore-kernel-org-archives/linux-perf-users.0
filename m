Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA5528640B
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 02:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784254924; cv=none; b=o2YQ4qZ/dwJ6vOCyVRKGkRwsk+zBWJF+dHuAgQQZmufxIHHIW0s/wpMBN/vnyvUxZLpnsqyWnXD3VWKJd6k9IFgqRUleG1buZ9GJbP7wbO0eZ4tdvyvBDB53QPBTCUTf772V4RAsYxriidMJQ6w6iS4/HLUbVdsJfqeSAhxRdAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784254924; c=relaxed/simple;
	bh=+wWqJZ+gahxEnFb30aAvjOJHpzF8BHMA4JsuiB1b/tc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r1j7tInztofCnXOsGITUxBsbS9GJGjPq4W7TU6IxFK13UMddNawDWN06Yh4T7c8LLk7cM5nI1/4GjZvM29ZSkAb9XL7GitAR1G5xQgx5closMToYSCMKxCz5a6lqf+fF9h0J30y0V2GMNKn/S11c+Rb1ZLof0Okl9c3Oz0wjHGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PM3Nqjrc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PM3Nqjrc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659971F000E9;
	Fri, 17 Jul 2026 02:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784254922;
	bh=tbO5kU7ojV4IOUxkTOMsQhwh7/4FA//2ZYTX912loGk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PM3NqjrczcwK+x1mkR0U3rakYO28iofI+dR+PNDqv9vltli/hfZ0jANlqX5NuWqKS
	 QiPQOKovUm+KGoC4dCyYYCIBgWCsRjXNXmNt+SwIOvUBLnm+LklSUN+DZGDdT1VT+e
	 RQjWXgpj7jyhgmBAQBajfh9MLcyAlZuWVO2rMkAKvdTjiDKUvBs8p4FrNvZDJt/o2z
	 cMYkchIHDsv+oeXacyCdur7aqvMfR56TBKg2G66GSNoFpvgRyKa7wCdwegs+0h7qox
	 SSuX2MLmhLjGh2LTyPTZWyqes0i9RMtM+3n/G/Phch1jA6oQm7uC0CxN8uycQwmULi
	 KAqw1EbPR9Zxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/14] perf c2c: add HPP list parsing for function
 view histograms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260717020530.1645123-9-jiebin.sun@intel.com>
References: <20260710084247.3576706-1-jiebin.sun@intel.com>
 <20260717020530.1645123-1-jiebin.sun@intel.com>
 <20260717020530.1645123-9-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 02:22:01 +0000
Message-Id: <20260717022202.659971F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Calling `perf_hpp__setup_output_field()` with a local list inadver=
tently pollutes the global `perf_hpp_list` and fails to populate the local =
list's output fields with the missing sort keys. This causes a type confusi=
on/out-of-bounds read and completely breaks the newly added function view.
--

--- Patch [8]: [PATCH v3 08/14] perf c2c: add HPP list parsing for function=
 view histograms ---
commit f3ca20deabb9c494811fc6797c416d4130121e41
Author: Jiebin Sun <jiebin.sun@intel.com>

perf c2c: add HPP list parsing for function view histograms

This adds the histogram initialization and column parsing infrastructure
for the function view in perf c2c. It provides functions to parse column
strings and initialize histograms with custom dimensions.

> diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browse=
rs/c2c-function.c
> index d79d131b1f18c..487f9a68d4a43 100644
> --- a/tools/perf/ui/browsers/c2c-function.c
> +++ b/tools/perf/ui/browsers/c2c-function.c

[ ... ]

> +static int
> +function_hpp_list__parse(struct perf_hpp_list *hpp_list,
> +			 const char *output_str,
> +			 const char *sort_str,
> +			 struct perf_env *env)
> +{

[ ... ]

> +	ret =3D function_hpp_list__add_tokens(hpp_list, sort, env,
> +					    c2c_function_hists__init_sort);
> +	if (ret)
> +		goto out;
> +
> +	perf_hpp__setup_output_field(hpp_list);

[Severity: High]
This is a pre-existing issue in the core formatting infrastructure, but
will calling perf_hpp__setup_output_field() here fail to populate the local
list's output fields?

The underlying function in tools/perf/ui/hist.c hardcodes registration to
the global perf_hpp_list. This causes the local list to remain empty, while
polluting the global list with local dynamic formats.

This also triggers a type confusion and out-of-bounds read. When a standard
format is compared to a c2c_fmt in perf_hpp__setup_output_field(),
c2c_fmt_equal() casts the standard format to c2c_fmt and reads the
out-of-bounds dim pointer.

> +out:
> +	if (ret)
> +		perf_hpp__reset_output_field(hpp_list);
> +	free(output);
> +	free(sort);
> +	return ret;
> +}
> +
> +static __maybe_unused int
> +c2c_function_hists__init(struct c2c_hists *hists,
> +			 const char *sort,
> +			 int nr_header_lines,
> +			 struct perf_env *env)
> +{
> +	__hists__init(&hists->hists, &hists->list);
> +
> +	perf_hpp_list__init(&hists->list);
> +
> +	hists->list.nr_header_lines =3D nr_header_lines;
> +
> +	return function_hpp_list__parse(&hists->list, /*output=3D*/NULL, sort, =
env);

[Severity: High]
Because this passes NULL for the output format string and relies entirely on
perf_hpp__setup_output_field() to populate the missing sort keys, won't the
new function view fail to render any columns?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717020530.1645=
123-1-jiebin.sun@intel.com?part=3D8
