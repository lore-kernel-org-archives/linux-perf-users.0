Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6279635959
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 02:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784254755; cv=none; b=UMcrqZ8BNflyw6mdvwkoaDAZz9YobjkPe0jfRAi/LB4QfvTFTz4UCT6IW5ZUm7VnnQzeoScm4tlIlaFIzcaRM1NGXsk4qew8eb42B4ipKZXxuioTMNdlsNv63CdbDHUUv6OvegMjqJN4NpvmYB9QOf5Ciocw9+ysVsMbHWzwyRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784254755; c=relaxed/simple;
	bh=VWYdhXQL8iawyoxzMDQqRi/B0Ow7DvJrNiFK5IdN0L0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dc89J1oxByNr0+5ghIHaoe+pbxeCO7dV3yni1rj/CHrXHL9MnP/pQpJRjforTOZidVDCptDcV29C7b3gapKbxyDMPhEaZbZN1k7sbAAsLEWdsZnyTodjraB/UpfN4Rg7WH4Vw8AamdQSlAMH+10NJz6+EX5ScTSzQnYyFTlv+Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlCNHHS3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlCNHHS3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BD51F000E9;
	Fri, 17 Jul 2026 02:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784254753;
	bh=w+HjGWtgcmwejEjASH3IS0mTt90v8qbBvoTcDhmXJ4o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jlCNHHS3nN4bkX+jB+Kjv108Q2w5yh9MHwhpuGjnElJWFnHSs575y5Sqw6bB84T8+
	 3TjPcwRTtQWpVDPbSHCKh01pjIK96/tErFqZRYJgi750d57DsdMSs+foc5OoMddHfx
	 6oaxKoEHBYiz70zVvIrAZ4UyZqy2KlB9vcXXyRKpTu/tFCOlHI+3nDr4T8M4lDYN+4
	 LCUryZSyQwHaKLpOZHd6SZcmltkFYBJo7rCvRLjXVo+kCxIjeTDZU/xLb2DbPybYe7
	 bhfch7Br/k3Ut2hKlTy59mzmFVpiaIrBMaBVSef9a/QKuSHBNDuTad12IA6okFihuC
	 guR3bMyr0wsew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/14] perf c2c: add column entry functions for
 function view
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260717020530.1645123-6-jiebin.sun@intel.com>
References: <20260710084247.3576706-1-jiebin.sun@intel.com>
 <20260717020530.1645123-1-jiebin.sun@intel.com>
 <20260717020530.1645123-6-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 02:19:13 +0000
Message-Id: <20260717021913.86BD51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Cycles percentage estimation incorrectly calculates peer-snoop c=
ycles by grouping them with generic loads.
--

--- Patch [5]: [PATCH v3 05/14] perf c2c: add column entry functions for fu=
nction view ---
commit 4bb0adbd5755e4c2cab2297cfb8207a0361395f1
Author: Jiebin Sun <jiebin.sun@intel.com>

perf c2c: add column entry functions for function view

This commit adds rendering functions for each column in the perf c2c functi=
on
view. This includes entry functions for total stores, cacheline symbols,
instruction addresses, symbol names, and estimated load-cycle percentages.

> diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browse=
rs/c2c-function.c
> index ace7e3f27b55c..a9add0ba4cdaf 100644
> --- a/tools/perf/ui/browsers/c2c-function.c
> +++ b/tools/perf/ui/browsers/c2c-function.c

[ ... ]

> +/*
> + * cycles_percent_entry - Render cycles percentage column
> + */
> +static __maybe_unused int
> +cycles_percent_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
> +		     struct hist_entry *he)
> +{
> +	struct c2c_hist_entry *c2c_he;
> +	int width =3D c2c_width(fmt, hpp, he->hists);
> +	u64 fn_cycles, total_cycles;
> +	char folded_sign;
> +	double pct;
> +	int ret, pct_width;
> +
> +	/* Hide Cycles Percent for child functions and cachelines. */
> +	if (he->parent_he)
> +		return scnprintf(hpp->buf, hpp->size, "%*s", width, "");
> +
> +	c2c_he =3D container_of(he, struct c2c_hist_entry, he);
> +	fn_cycles =3D c2c_hist_entry__cycles(c2c_he);

[Severity: Medium]
The commit message mentions this function renders an estimated load-cycle
percentage for "(HITM, peer-snoop and other-load cycles)". However, looking
at the implementation of c2c_hist_entry__cycles():

static __maybe_unused u64 c2c_hist_entry__cycles(struct c2c_hist_entry *c2c=
_he)
{
	double cycles_rmt, cycles_lcl, cycles_load;
	u64 other_load, total_hitm;

	cycles_rmt =3D avg_stats(&c2c_he->cstats.rmt_hitm) * c2c_he->stats.rmt_hit=
m;
	cycles_lcl =3D avg_stats(&c2c_he->cstats.lcl_hitm) * c2c_he->stats.lcl_hit=
m;
	total_hitm =3D c2c_he->stats.tot_hitm;
	other_load =3D (c2c_he->stats.load >=3D total_hitm) ? c2c_he->stats.load -=
 total_hitm : 0;
	cycles_load =3D avg_stats(&c2c_he->cstats.load) * other_load;

	return (u64)(cycles_rmt + cycles_lcl + cycles_load);
}

This estimation logic ignores cstats.rmt_peer and cstats.lcl_peer latencies.

Because total_peer is not subtracted alongside total_hitm, do the peer-snoop
counts remain in other_load and get incorrectly multiplied by the non-snoop
generic load average (cstats.load) rather than their actual tracked
peer-snoop latencies?

> +	/* Populated by build_function_view_hierarchy() once the L1 tree is bui=
lt. */
> +	total_cycles =3D c2c_ext.total_cycles;
> +	pct =3D total_cycles > 0 ? (double)fn_cycles / total_cycles * 100.0 : 0=
.0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717020530.1645=
123-1-jiebin.sun@intel.com?part=3D5
