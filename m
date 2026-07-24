Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73549426EB2
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Jul 2026 10:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888549; cv=none; b=G8AAwy2I/yH/pf7aVPaDv3WRGBDyV/KWZ5iwe2pMSiq34bZv78DnVmrXWahXKoXGjQxjTIUlMODHHk2yuSDYPC/hlCOy4f63YdLu4/pYk70Ul3+dGZT49C70U6jU6IwB5oZ2RtTrdcmoL6SArwumSiOyThUIKs+0fuMhp7+e36g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888549; c=relaxed/simple;
	bh=NLb0dqOGwcktSYbe9lka3YxkN/4q9A7FS4Ppi+1Rsl0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gxcIgXMj9prko4sJRqrrqOa4hG0+z2ewEu++/BNyGk24Mtnkp8TMSI/37FwjF3RYLuQj0TK9yp6tPNH+adlcAB10HASB3KM/T0eZvgHWGaP3Tavu947cR9nqOzfTZJryQHaKBa5Xn7EqLtnUfiP7iCgFw/tEDNwkD/t1YrpvylE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mp4qW0lD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mp4qW0lD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C939E1F00A3D;
	Fri, 24 Jul 2026 10:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784888548;
	bh=1Ap/tr8rjwt4TsxWwot1CHvcUifesv2BC3rDL4acq2I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mp4qW0lDz9+993RvFOsqRSWcR9ZF/SWep/Ke0IqHRy32MBz9aGjdSCQzZ7zvjt2lc
	 EqydVY+Q6ov0xC4WojgR8xa54qrJIAkC2sZjlyJ3+Y7v5WmY2IE3BXEw7q5wE2z+4w
	 du3JCmN5t7AWq2hy+n2nQGIOxFcljityxuYLkdYyn9ezW0fyg3ACmkIUuS2Ngj+92V
	 zffZ4zgIOcSgUzSmvEJHvhmYdsTnP0wK/yp/4D0u2dlwhBOZ4LruREM2hsP4D15YiK
	 vPud++nRJ6uMUKbQfs9fGh5dgPhHEzooshpJU82WZa0S9daojz0R8+aRxSnXKOS4Sd
	 E4Ra5lfbp1KpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 7/9] perf c2c: build and finalize the function view
 hierarchy
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260724095842.995920-8-jiebin.sun@intel.com>
References: <20260717020530.1645123-1-jiebin.sun@intel.com>
 <20260724095842.995920-1-jiebin.sun@intel.com>
 <20260724095842.995920-8-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 10:22:27 +0000
Message-Id: <20260724102227.C939E1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Cross-platform analysis violation due to host-specific symbol so=
rting.
- [Medium] Reference count bypass causing potential Use-After-Free under RE=
FCNT_CHECKING.
- [Medium] Unprotected NULL pointer dereference when calculating symbol sta=
rt address with a missing map.
--

--- Patch [7]: [PATCH v4 7/9] perf c2c: build and finalize the function vie=
w hierarchy ---
commit f2e1f195d1ddc82d8ab908b3806ba29cab6acf88
Author: Jiebin Sun <jiebin.sun@intel.com>

perf c2c: build and finalize the function view hierarchy

Add the builder that walks the cacheline histograms once and, for each
read-side function, records the functions that write the lines it reads
(level 2) and the specific cachelines they contend over (level 3),
aggregating the write traffic per contending function. Add the store-count
resort, the pruning of writers/functions with no contention, and the
finalize pass that computes the per-function cycle totals.

> diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browse=
rs/c2c-function.c
> index 9a7b1353e11ca..bb7f967ab904b 100644
> --- a/tools/perf/ui/browsers/c2c-function.c
> +++ b/tools/perf/ui/browsers/c2c-function.c

[ ... ]

> @@ -1044,7 +1044,7 @@ c2c_function_hists__level1_entry(struct symbol *sym,
>   * same writer function aggregate into one row without merging identical=
ly
>   * named functions from different DSOs.
>   */
> -static __maybe_unused struct c2c_hist_entry *
> +static struct c2c_hist_entry *
>  c2c_function_hists__level2_entry(struct c2c_hist_entry *level1_c2c,
>  				 struct symbol *sym, struct hist_entry *detail_he)
>  {

[Severity: Medium]
When calling c2c_child_entry__alloc() inside this function (and also when
allocating the level 3 entry), the underlying allocation directly assigns
reference-counted structs without taking a reference:

c2c_child_entry__alloc() {
    ...
    memcpy(&child_he->ms, &src_he->ms, sizeof(struct map_symbol));
    ...
    child_he->thread =3D src_he->thread;
    ...
}

Does this bypass the reference count and risk a use-after-free when
REFCNT_CHECKING is enabled? Should this code use map__get() and
thread__get() to acquire proper reference handles?

[Severity: Medium]
Does this code risk an unprotected NULL pointer dereference when calculating
the symbol start address?

Inside this function, and similarly in c2c_function_hists__level1_entry(), =
the
map is used to unmap the IP:

    sym ? map__unmap_ip(detail_he->ms.map, sym->start) : hist_entry__iaddr(=
detail_he);

If detail_he->ms.map is NULL (which can happen with unmapped symbols), pass=
ing
it directly to map__unmap_ip() will dereference it. Should this verify that
detail_he->ms.map is valid before calling map__unmap_ip()?

[ ... ]

> @@ -1132,6 +1132,453 @@ c2c_function_hists__level3_entry(struct c2c_hist_=
entry *level2_c2c, u64 cl_addr,
>  	return level3_c2c;
>  }
> =20
> +/*
> + * Re-sort child entries of @parent_he by total store count, descending.
> + */
> +static void c2c_he__resort_by_stores(struct hist_entry *parent_he)
> +{

[ ... ]

> +		while (*p) {
> +			struct hist_entry *iter =3D rb_entry(*p, struct hist_entry, rb_node);
> +			u64 iter_store =3D hist_entry__displayed_stores(iter);
> +
> +			parent =3D *p;
> +			if (he_store !=3D iter_store) {
> +				cmp =3D he_store > iter_store ? -1 : 1;
> +			} else {
> +				/* Stable tie-break: instruction address, then name. */
> +				u64 a =3D hist_entry__iaddr(he), b =3D hist_entry__iaddr(iter);
> +
> +				if (a !=3D b)
> +					cmp =3D a < b ? -1 : 1;
> +				else if (he->ms.sym && iter->ms.sym)
> +					cmp =3D arch__compare_symbol_names(he->ms.sym->name,
> +									 iter->ms.sym->name);

[Severity: Medium]
Does using arch__compare_symbol_names() here break cross-platform sorting?

This invokes a host-compiled architecture-specific hook instead of dynamica=
lly
querying the target e_machine, which can cause incorrect sorting behavior
during cross-platform analysis of perf.data files.

> +				else
> +					cmp =3D (iter->ms.sym ? 1 : 0) - (he->ms.sym ? 1 : 0);
> +			}
> +
> +			if (cmp < 0) {
> +				p =3D &parent->rb_left;
> +			} else {
> +				p =3D &parent->rb_right;
> +				leftmost =3D false;
> +			}
> +		}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724095842.9959=
20-1-jiebin.sun@intel.com?part=3D7
