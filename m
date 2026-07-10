Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5153CAA31
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 09:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783674005; cv=none; b=SLkRRJY0mdcJmE+qC03z9IBRI0ABqCfSnT+PQ4ulv4g3sGbepuAewY6efZR7e50l4cPM9E+Ey+VefyzXXwFbbNO8GsF/lv8+uaYpXsnjbWqlb4HG7JSHUg/f1YtRLA/iO6igCx1R/vXnrqjsGey8gBsAxDyOd9fcCYcWTGaip1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783674005; c=relaxed/simple;
	bh=oS8JiWr46yvyRVdIm+vo4jmm5y+Pze9Hw9Auct5CdPk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NmGkDyG/72cKv1NH8zyfanLl0WQQJTTblZGJzcZhWSiMcjCugEWOr+Umo91dhEMFFF1ZYbcr7DokIc8LOquq8WwTzshxNVq1pzK6LwhSbJgUcqWj7wcTR0uMLOZOcB84IDo/OANfxuCzN1XrKuEhB+MYompaCVjdbk9Nv/UYD0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lErjk0F4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lErjk0F4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5543C1F000E9;
	Fri, 10 Jul 2026 09:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783674003;
	bh=RXua4RWxZ9y6B87UBHYNM/SjjyKjb/jWQZjEKcd5TuI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lErjk0F4/EdxVLcNxPSjpquhP4bA78cmNJZ1IhsCwabyX1c/v6Qx7Lu20FRqVjsHl
	 b5707VjAoT81OuqCAqXmKYwl4nN4GLMkMHkAKnuHsKY6k5cTp+k1N81eYeaUYo/Thm
	 Zichyakuyz1i7rxSwFSbnvW5eehtcs5trZTMnkbU/QkZBsHV/GvxBEPtAMKBACp8MC
	 oZJvRZqdw//Kdr2mioM1lwu/qFGZusJEWfi5yUcl099sts93x403czhWyeUeVFozUJ
	 L60WtUQEAJhzFfEuPZlid9h1xrne3YPIwtdWmlWhhXMQA31yEFyrUggCA63dAO2FCI
	 ffuS7if2ICKsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/14] perf c2c: add column format infrastructure for
 function view
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260710084247.3576706-5-jiebin.sun@intel.com>
References: <20260626070355.1556721-1-jiebin.sun@intel.com>
 <20260710084247.3576706-1-jiebin.sun@intel.com>
 <20260710084247.3576706-5-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 09:00:02 +0000
Message-Id: <20260710090003.5543C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Incorrect cycle estimation omits peer snoop cycles and misattrib=
utes them to generic loads.
- [Medium] Performance degradation via O(N) tree walk instead of utilizing =
the O(1) cached `child_stores` field.
- [Medium] Potential NULL pointer dereference in `symbol_width()` due to un=
initialized `dim_symbol_view.se`.
--

--- Patch [4]: [PATCH v2 04/14] perf c2c: add column format infrastructure =
for function view ---
commit 27bafa4ad47ef7cdc864764ce3f927a10cdbbd23
Author: Jiebin Sun <jiebin.sun@intel.com>

perf c2c: add column format infrastructure for function view

This patch adds the column format plumbing functions used by all
function view dimensions. It introduces helper functions to calculate
column widths and render multi-line column headers.

> diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browse=
rs/c2c-function.c
> index dbc912a4a242b..d718cab6537d9 100644
> --- a/tools/perf/ui/browsers/c2c-function.c
> +++ b/tools/perf/ui/browsers/c2c-function.c
> @@ -66,6 +66,123 @@ static __maybe_unused inline u64 hist_entry__iaddr(st=
ruct hist_entry *he)

[ ... ]

> +static __maybe_unused int symbol_width(struct hists *hists, struct sort_=
entry *se)
> +{
> +	int width =3D hists__col_len(hists, se->se_width_idx);

[Severity: Medium]
Can this dereference a null pointer?

When c2c_width() is called for dim_symbol_view:

c2c_width() {
    ...
    if (dim =3D=3D &dim_symbol_view)
        return symbol_width(hists, dim->se);
}

The statically declared dim_symbol_view is uninitialized, so its se member
is null. Passing it here will cause an immediate pointer dereference
when accessing se->se_width_idx.

> +
> +	if (!c2c.symbol_full && width > SYMBOL_WIDTH)
> +		width =3D SYMBOL_WIDTH;
> +
> +	return width;
> +}

[ ... ]

> +/*
> + * Return the estimated total cycles for a c2c_hist_entry
> + * (rmt_hitm + lcl_hitm + rmt_peer + lcl_peer + other loads).
> + */
> +static __maybe_unused u64 c2c_hist_entry__cycles(struct c2c_hist_entry *=
c2c_he)
> +{
> +	double cycles_rmt, cycles_lcl, cycles_load;
> +	u64 other_load, total_hitm;
> +
> +	cycles_rmt =3D avg_stats(&c2c_he->cstats.rmt_hitm) * c2c_he->stats.rmt_=
hitm;
> +	cycles_lcl =3D avg_stats(&c2c_he->cstats.lcl_hitm) * c2c_he->stats.lcl_=
hitm;
> +	total_hitm =3D c2c_he->stats.tot_hitm;
> +	other_load =3D (c2c_he->stats.load >=3D total_hitm) ? c2c_he->stats.loa=
d - total_hitm : 0;
> +	cycles_load =3D avg_stats(&c2c_he->cstats.load) * other_load;
> +
> +	return (u64)(cycles_rmt + cycles_lcl + cycles_load);

[Severity: Medium]
Is this cycle calculation omitting the peer snoop cycles?

The comment above this function states it includes rmt_peer and lcl_peer,
but the logic drops their averages. By only subtracting total_hitm from
stats.load, it leaves the peer snoop counts (tot_peer) in the other_load
remainder.

This appears to weight the peer counts with the generic cstats.load average
instead of multiplying rmt_peer and lcl_peer counts by their respective
latencies.

> +}

[ ... ]

> +/* Sum child entries' store counts under a level-1 hist_entry. */
> +static __maybe_unused u64 hist_entry__child_stores(struct hist_entry *he)
> +{
> +	struct rb_node *nd;
> +	u64 sum =3D 0;
> +
> +	for (nd =3D rb_first_cached(&he->hroot_out); nd; nd =3D rb_next(nd)) {
> +		struct hist_entry *child =3D rb_entry(nd, struct hist_entry, rb_node);
> +		struct c2c_hist_entry *c2c_child =3D
> +			container_of(child, struct c2c_hist_entry, he);
> +
> +		sum +=3D (u64)c2c_child->stats.store;
> +	}
> +	return sum;

[Severity: Medium]
Could this use the cached child_stores field instead of walking the tree?

This loop introduces a tree walk to sum the store counts on every
render cycle. The c2c_hist_entry structure has a child_stores field that
could provide this count in constant time, avoiding the need to iterate
over all children in hroot_out.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710084247.3576=
706-1-jiebin.sun@intel.com?part=3D4
