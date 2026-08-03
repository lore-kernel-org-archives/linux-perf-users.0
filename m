Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23AB211A14
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Aug 2026 03:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785729341; cv=none; b=ld0J/WzMozIU2jXCpLLNrq0TrxQlXyPv8P8jeJHddxdYxeIdWgnUQtYR9BbY/w0incCfH0WoN5RM+Ka6kyK6VjSadC0hh7R2wt1ftzQDXsAtf6swiMCelEE5cbJ6JkRRjiuViXcd3tURgqEp5WX78u8BIHgcB20kqXzucoqtrtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785729341; c=relaxed/simple;
	bh=7Avtr+Vdwp6bBxLi+Avoa/BxKV6yqZij9Jtl+qwfas0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RYsd0oqS5Jtls3mBwZUvN9SZu91tWP08dAVffDIyzfegMfntzSWpZo0p309cbjshWN3SJNMSKEE0RUjufUwb86vubZbQDZkA7aiv/4Dcy27iUj3pSokPbdVkDRz5AcQa2eFb3a1zH9mliVedtufuf6D8+HQqM75G6eNFdtv8L/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XduJ4asS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XduJ4asS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FB71F000E9;
	Mon,  3 Aug 2026 03:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785729338;
	bh=PXaAeSSv+IKgBsjEm23ccF+V4hcW++0gQFbUEcLdAjA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XduJ4asSc7PoY0E3pW+hBu6DHq6hmAibn/Fi/B5Ub5Wy6NGgwMS8Ur7kuISfx7N0D
	 vGHCRB66EYvNWOdD/QnrECj+3sU4DePB8EYYaxV4FWVPKsVMCD59jeXp4C69iv4JX3
	 w6TmofiLPLK5iiwF3Df555gqHWcyySJAT22TUwzNj7Bm5NtepfzvO42Tbz78HR71we
	 YgZlNLiV6M5PGgCs4o1+jPIOtEuIUYZ2q7EYVwTj/UvF7Kx+CnuSVIQKOlwzN7M6s3
	 utEpCh0DzGehszcoHmQcT8hFothE+wFPxVZOcyiGWzEAJgcAe6GOGvn/ZULKyPmFvB
	 /D5v8vKfFOEFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/9] perf c2c: add function view browser skeleton
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260803035220.172022-3-jiebin.sun@intel.com>
References: <20260803035220.172022-1-jiebin.sun@intel.com>
 <20260803035220.172022-3-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 03:55:37 +0000
Message-Id: <20260803035537.E1FB71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The c2c function browser incorrectly relies on the host-bound `a=
rch__compare_symbol_names` for cross-platform `perf.data` analysis.
--

--- Patch [2]: [PATCH v6 2/9] perf c2c: add function view browser skeleton =
---
commit 319d5bb2b85df1b9f28814f5dc315251c6aed01a
Author: Jiebin Sun <jiebin.sun@intel.com>

perf c2c: add function view browser skeleton

Add the skeleton of the c2c function view: a new TUI browser in
tools/perf/ui/browsers/c2c-function.c reached by pressing TAB in the
cacheline view. This commit wires up the entry point, registers the file
in the build, and adds the TAB key handler and help text.

> diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browse=
rs/c2c-function.c
> new file mode 100644
> index 0000000000000..c0fd7799e4f85
> --- /dev/null
> +++ b/tools/perf/ui/browsers/c2c-function.c
[ ... ]
> +static inline __maybe_unused bool symbol_name_equal(struct symbol *a, st=
ruct symbol *b)
> +{
> +	/* Two unknown symbols compare equal, matching cmp_null() in util/sort.=
c. */
> +	if (!a || !b)
> +		return a =3D=3D b;
> +	return arch__compare_symbol_names(a->name, b->name) =3D=3D 0;

[Severity: Medium]
Does this code rely on host-bound architecture logic for symbol comparison?

Looking at arch__compare_symbol_names(), it typically uses the host's
compilation rules rather than dynamically resolving symbol comparison based
on the target machine's architecture (e.g., via e_machine from perf_env).

When performing cross-platform profiling analysis, such as opening a perf.d=
ata
file generated on an architecture with specific symbol rules (like PowerPC)=
 on
a host with different rules (like x86), could this lead to the c2c analysis
failing to match symbols properly?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803035220.1720=
22-1-jiebin.sun@intel.com?part=3D2
