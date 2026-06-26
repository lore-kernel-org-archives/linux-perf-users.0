Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28C2362130
	for <linux-perf-users@vger.kernel.org>; Fri, 26 Jun 2026 07:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782458091; cv=none; b=RTcgxufV25prJmfzVFarVB2V3oynqWvG1F+md8uGyfiE2KKpVCXnGYyCta34+73WWgmLsxLbCciTIW88FAqMO3DlnJ+AAq3vdJXmMDXAFVZLhbqwReBr7dl9qfdYV/DqyVyrBXEjYeuMpQC6lxLGpple/zG2yzuDgNAPkX2P2lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782458091; c=relaxed/simple;
	bh=nJwfv+KYXFm6EdCf8y4OiuuLF9VL9/m4vroghJ+aJ0I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YORJfEhkFwUCiASbiz/+DekAQP01MFK19rBcxIKmEOz7pIzxE8MNgo9R4tTZ6+G0/gCI0uSPQbWtmh0Y3rnU64+6WNn92XEVGMOBP9ZDmFpgrddXY6Lo0vCID7dIlZF8hW65BnBxbX7wLMj8tDv1MlW7F9akSeF0R6yRu3Qf7oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DF6kRi4H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DF6kRi4H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0CC1F000E9;
	Fri, 26 Jun 2026 07:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782458090;
	bh=+9xCvj9nnJhIAw2/IXynkgTiWYV3mXW1gZFNlgto8os=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DF6kRi4HZMrrer9n2NojGXsobV5cxe2RNMXe0evauQx1S4JGwWgh5h85XBjtqsZEF
	 caeAPlJkZcQjcgpCxaO35UCcgcBQXr+f1JyEWTEW+qjyC/sXiWrYSKDVBwg8maOCSG
	 zbjMidvqmyiZS7tHSo41JLTiusX5DyZjvmPYaPbIX22sbZ3hXqA+voIA2+XLW+LerE
	 Cg+aRXf8Tuq9+Fn7Vur/rNRgJxJv/jYdZqkwOZS/4tgI7admRvdy7zjJlyxLMtinoX
	 zHIsmaPPj6kaBC2V1jU25eUxYa7j8G/seEA61hkqg3nFyjIfj1h9wKpigptuEyfcay
	 Up3NutFECxr3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/14] perf c2c: add function view type definitions and
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260626070355.1556721-4-jiebin.sun@intel.com>
References: <20260626070355.1556721-1-jiebin.sun@intel.com>
 <20260626070355.1556721-4-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 07:14:49 +0000
Message-Id: <20260626071450.3B0CC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `symbol_name_equal` helper relies on host-bound `arch__compa=
re_symbol_names()`, which breaks cross-platform analysis for the c2c functi=
on view.
--

commit a7beef2e1248ae5cd6dc127b26c6803a87eb9dd4
Author: Jiebin Sun <jiebin.sun@intel.com>

perf c2c: add function view type definitions and helpers

Add the foundational type definitions and helper functions for the
function view browser.

> diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browse=
rs/c2c-function.c
> index 040266288be3d..dbc912a4a242b 100644
> --- a/tools/perf/ui/browsers/c2c-function.c
> +++ b/tools/perf/ui/browsers/c2c-function.c
[ ... ]
> +static __maybe_unused inline bool symbol_name_equal(struct symbol *a, st=
ruct symbol *b)
> +{
> +	return a && b && arch__compare_symbol_names(a->name, b->name) =3D=3D 0;

[Severity: Medium]
Does this break cross-platform analysis for the c2c function view?

Calling arch__compare_symbol_names() relies on a weak symbol bound to the h=
ost
architecture at compile time, since files in tools/perf/arch/ are condition=
ally
linked based on the build machine.

If a user runs perf c2c on an x86 host to analyze a perf.data file recorded=
 on
PowerPC, this falls back to strcmp(). Can this result in failing to correct=
ly
group identical symbols that have architecture-specific variations (like
PowerPC's .my_func vs my_func)?

Should this dynamically query the e_machine of the analyzed perf.data file
instead of relying on host-bound architecture functions?

> +}
> +
> +static __maybe_unused inline u64 hist_entry__iaddr(struct hist_entry *he)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626070355.1556=
721-1-jiebin.sun@intel.com?part=3D3
