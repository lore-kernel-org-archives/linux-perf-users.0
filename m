Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEAD3F8EDE
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Jul 2026 10:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784887371; cv=none; b=hvdvyY/4/lPSRb9fZG+5UCG74GrPrdQ68cFcwIuTUiWHr+os9k1mJnMR13aq3jhxAqZOifS3C+mYf8lA7ggVOdaTcEASdgYWZPNppTqqYTgjprN3/jN0aoeZxBzLMGYNDApho13pGjeP7FaQwyH1XW+L0rtRnZUBii1U7pqPkkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784887371; c=relaxed/simple;
	bh=2MXyhrwNjXqwMQtP0N43Og1oFZ+aNLVXpZRv/5yojZA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WAeElk18cJr3VbDLT4PnveTNVl79d3LmzZVS+ZNS0oOrcqw9jn2SjUnKE9C9ILTwhhMLvVEjWZey2hm13xcinV5qingJke3lBF8VMe4RkWZKHntSBNCUjG8iEt3HYfLhfzi9Qf1NC4oRaCVvHYn/FFIQi07ZV8o29LwjwwNwsNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VruHV6iP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VruHV6iP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314251F00A3A;
	Fri, 24 Jul 2026 10:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784887367;
	bh=Bf6PgeN9XulDIxpKb3Kw6URs/iSUk/cDteSNibSgkEs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VruHV6iPfymnH1K6vNu2wr2r5ZlCM0zEceEjefyLyEXuSphEJ8LSyknyfC9xlPs9+
	 d1GZJxdr0Q9FgW1nf41ovmGKWu9u7G/RG/NAVuKKr6Q2K+2OabpKiZvklgakVDTmwJ
	 GH50buT9WZ5eUxq9OYG6Mf8ULWDKGJrtIqQwD7uJB5uSThiX/aYtTSo77MG4ZHkDLs
	 ZFhcvjXHEEyqavJ6my4g+nOdwVasJz3rQ71pRpIzJgSosA+gjeovulPOUUZgZwpQ2K
	 cZMxOhfyNj9o4zavEueO/EHHB4U5EOpnCIzz+CQWChXdW2P0ZlGLSiuDX3AtIkIJbx
	 difVk2YaUl8Ng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/9] perf c2c: add HPP list parsing for function view
 columns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260724095842.995920-5-jiebin.sun@intel.com>
References: <20260717020530.1645123-1-jiebin.sun@intel.com>
 <20260724095842.995920-1-jiebin.sun@intel.com>
 <20260724095842.995920-5-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 10:02:46 +0000
Message-Id: <20260724100247.314251F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message claims to modify the core `perf_hpp__setup_ou=
tput_field()` function to operate on a caller-provided list, but the patch =
actually implements a local workaround function instead.
--

--- Patch [4]: [PATCH v4 4/9] perf c2c: add HPP list parsing for function v=
iew columns ---
commit c0d30306be98707f48f543440ba43c56408600b2
Author: Jiebin Sun <jiebin.sun@intel.com>

perf c2c: add HPP list parsing for function view columns

This commit adds parsing to turn an output/sort column string into the func=
tion
view's hpp_list. It includes dimension lookup, comparator wrappers, format
allocation, and initialization entry points.

> Make perf_hpp__setup_output_field() register appended sort keys on the
> hpp_list passed by its caller.  It previously used the global-list wrappe=
r,
> which left a local list without output fields and linked its formats into
> the global perf_hpp_list instead.

[Severity: Medium]
This isn't a bug, but the commit message states that it modifies the core
perf_hpp__setup_output_field() function to operate on a caller-provided lis=
t.
However, the patch does not actually modify perf_hpp__setup_output_field().

> diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browse=
rs/c2c-function.c
> index 4eda97894d1d4..21e156bbbef35 100644
> --- a/tools/perf/ui/browsers/c2c-function.c
> +++ b/tools/perf/ui/browsers/c2c-function.c
[ ... ]
> @@ -400,13 +400,277 @@ static struct c2c_dimension dim_symbol_view =3D {
[ ... ]
> +/*
> + * Append the function view's sort keys to its own output fields, mirror=
ing
> + * perf_hpp__setup_output_field() but on the local @list. The shared hel=
per
> + * registers onto the global perf_hpp_list, which would leave this local=
 list
> + * without output columns, so the function view keeps its own copy here.
> + */
> +static void c2c_function_hists__setup_output_field(struct perf_hpp_list =
*list)
> +{
> +	struct perf_hpp_fmt *fmt;
> +

Could the commit message be updated to accurately reflect that this local
helper c2c_function_hists__setup_output_field() was introduced rather than
modifying the core function?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724095842.9959=
20-1-jiebin.sun@intel.com?part=3D4
