Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC8B3A8743
	for <linux-perf-users@vger.kernel.org>; Fri, 26 Jun 2026 07:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782458543; cv=none; b=h0wY1tdSQwiAOORbc9ojHAC8ORIC0Fsv8dD06fEwDTRFU8g7/pIXPOC8RarseE7yjT5JeuAeqbBNmxG02/4NDeZV5n9l5v7z4wGgM43wmDwT2e1xShklS9Fr1atr/ZJ5im9dTgPDdvrzYWYS0NSbNaN01TOXNk/OYKnqY3Lx1Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782458543; c=relaxed/simple;
	bh=JTPRPVVB5rWhosjr/on9tjLssvrOILW9t2Rd91KhjUc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LDXvg5awn7NBY5H0Dp14sGEcJEDOp9MCNGY1Abc4xPHu/65eoGyUrWFaULK78Ic/kebmkBrhYHReDisDVt3Muzoz9YBfLfwPpqDuc4RzTM55eyBR869/4M5ytFFnt8IAaqjSsiZQrot74zGVzUgGE+BwNBHipgqsE+c+2KG1PrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LtF/EVPx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtF/EVPx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CBB71F00A3D;
	Fri, 26 Jun 2026 07:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782458542;
	bh=MdK59rXLHPBpSTSvlwbUrsvIQkqGcdxJffiRsKfC/Ws=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LtF/EVPxkJcyltrwLd4R1dQzWOZnZAFkUJ2VHjtrN0k6Dx//Hlk8x/q4eMkRFgFdH
	 EzkSPGv5DIjwJSZl/vlUU8pRCOZAWA1HBRyGmxzaHPmJqBai164QhjvWJMQEpzQXCT
	 cFiLZxCbvKaObag4Xyq61FY98ciHITTIevg7kQg6gad6tcjlBnmNuIsSXaGuK2eysc
	 1sn2igmEISsbvn3Mzpoy5sTOlZjSYgQO9FfUPfDciAV6PBXobYN1DXA7go3wO8DzLR
	 dXXK9C+65u3/m7NCyghFCX2dggAwwKz7f1rF7Jc9pCbo6wXT3jw0swWT4K3zi303Zd
	 Uk6NStbxrGatA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/14] perf c2c: add comparison functions for function
 view sorting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260626070355.1556721-7-jiebin.sun@intel.com>
References: <20260626070355.1556721-1-jiebin.sun@intel.com>
 <20260626070355.1556721-7-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 07:22:21 +0000
Message-Id: <20260626072222.1CBB71F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] total_stores_cmp performs an O(M) traversal of child hists durin=
g the sorting phase, introducing an O(N * M log N) scaling bottleneck.
- [Low] Comment in iaddr_symbol_cmp incorrectly describes the sorting order=
 as descending when the implementation sorts in ascending order.
--

commit f2c1f87b66997d6b6a124f1e2e94dfbb11092062
Author: Jiebin Sun <jiebin.sun@intel.com>

perf c2c: add comparison functions for function view sorting

This patch adds sort comparison functions for the function view columns in=
=20
perf c2c. It includes functions like cycles_percent_cmp, iaddr_symbol_cmp,=
=20
and total_stores_cmp to support sorting.

> diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browse=
rs/c2c-function.c
> --- a/tools/perf/ui/browsers/c2c-function.c
> +++ b/tools/perf/ui/browsers/c2c-function.c
[ ... ]
> +static __maybe_unused int64_t
> +iaddr_symbol_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
> +		 struct hist_entry *left, struct hist_entry *right)
> +{
[ ... ]
> +	left_iaddr =3D hist_entry__iaddr(left);
> +	right_iaddr =3D hist_entry__iaddr(right);
> +
> +	/*
> +	 * Descending by instruction address (same direction as sort__iaddr_cmp=
(),
> +	 * which also returns r - l): the expression is +1 when left < right.

[Severity: Low]
This isn't a bug, but the comment describes the sorting order as descending,
while returning +1 when left < right instructs the sorting algorithm to pla=
ce
smaller elements before larger ones, resulting in an ascending order.=20

Should the comment be updated to accurately reflect the actual sort order?

> +	 * Uses hist_entry__iaddr(), which falls back to he->ip when mem_info is
> +	 * NULL, so it matches what iaddr_symbol_entry() displays.
> +	 */
> +	return (left_iaddr < right_iaddr) - (left_iaddr > right_iaddr);
> +}
[ ... ]
> +static __maybe_unused int64_t
> +total_stores_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
> +		 struct hist_entry *left, struct hist_entry *right)
> +{
> +	struct c2c_hist_entry *c2c_left =3D container_of(left, struct c2c_hist_=
entry, he);
> +	struct c2c_hist_entry *c2c_right =3D container_of(right, struct c2c_his=
t_entry, he);
> +	u64 left_store, right_store;
> +
> +	/* Match total_stores_entry(): L1 sums child stores, L2/L3 use their ow=
n. */
> +	left_store =3D left->parent_he ? (u64)c2c_left->stats.store :
> +				       hist_entry__child_stores(left);
> +	right_store =3D right->parent_he ? (u64)c2c_right->stats.store :
> +					 hist_entry__child_stores(right);

[Severity: Medium]
Will this cause a severe UI slowdown or hang on large profiles?=20

During the sorting phase, the tree resort calls total_stores_cmp for node
comparisons. Since hist_entry__child_stores() performs a full traversal of
child entries, this introduces a scaling bottleneck on every comparison.=20

Can the sum be cached instead of dynamically recalculating it by iterating
through children over and over during the tree sort?

> +
> +	return (left_store > right_store) - (left_store < right_store);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626070355.1556=
721-1-jiebin.sun@intel.com?part=3D6
