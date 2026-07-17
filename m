Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F73227FD75
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 02:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784254844; cv=none; b=WEU8SQm5VrVrc21PglT6qERQTHmGZ/ZM2DHJVNtjqU4zDlxaBPQ0rw2XVPKYPExR+hPpg/NyLuInQdN5t2KkWo6/0wlVeBo3uF+xzuI8sMJVFhON2deFyMphjd54mwYBh+b/pLK800iheGTqRU+z+6pkjvTphrpKbaioLZqjuV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784254844; c=relaxed/simple;
	bh=buEPMQI7iUGfPyvJDQ3tkwo5V7nbNrlLtxVilU44jjo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=phSPvl0MJHahmSwgcAJVZr5/iuV12jax1mkXClpCxdqjrANd6ovubcZCTfIGniU9sCowPleJH0GN7VnyH46H67lS24HVDgqLOiNIX48bG3vAar9XMDjrrJGwpOq2VmEwEDD3W/7J6BwIF+wC7WKiyfP86aQ1RYBv6Uk7fgfejaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AP7++NO6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AP7++NO6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B581F000E9;
	Fri, 17 Jul 2026 02:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784254843;
	bh=yf3ILgcfVDZSgXbHZNX4DWz0dB8EtK8oqkmRHmvGan0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AP7++NO64FjuiNlEC5uCkMZkrYlpymOU8WSf33MZH/xd4aX8XOmLgZWFDvr3/wrXg
	 iOtQ9cMVh4yfu/ZJTI+gGiorGtQQTLq4gFgty2VLTEp7D/PCGm1j6L+Q3ERycKQqjF
	 VSQKG1ENU6wy2w3wN1xln4V8sd2E7D52Ap951lfMoamQ7f8IF/RrbGSm2zoCx29yzk
	 MAvt0qNbfcoiOsVRAnN7fZTSSP40c4OdPC+s/UAAG1HLpIUfj36tft4DqTeuHlZ5PO
	 m0T2u3x7TxJnFQEkXilu9Xmf8/lHtVp5KIFjsAAippOShjaVWLfNBbjX7Bx3LWriS8
	 +O7wFWDp2PLtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/14] perf c2c: add hierarchy entry creation and
 lookup functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260717020530.1645123-11-jiebin.sun@intel.com>
References: <20260710084247.3576706-1-jiebin.sun@intel.com>
 <20260717020530.1645123-1-jiebin.sun@intel.com>
 <20260717020530.1645123-11-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 02:20:42 +0000
Message-Id: <20260717022042.E0B581F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Raw pointer assignments and `memcpy` are used to borrow referenc=
e-counted pointer handles (`thread` and `map`), which violates the referenc=
e count handling guidelines.
--

--- Patch [10]: [PATCH v3 10/14] perf c2c: add hierarchy entry creation and=
 lookup functions ---
commit bb7c62a6a034d98a01913f7e22d4e719873b55ff
Author: Jiebin Sun <jiebin.sun@intel.com>

perf c2c: add hierarchy entry creation and lookup functions

Add functions for creating and finding entries at each level of
the 3-level function view hierarchy.

> diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browse=
rs/c2c-function.c
> index 8459a1c82f294..34c627876d876 100644
> --- a/tools/perf/ui/browsers/c2c-function.c
> +++ b/tools/perf/ui/browsers/c2c-function.c
[ ... ]
> +static struct c2c_hist_entry *
> +c2c_child_entry__alloc(struct hist_entry *parent_he, struct hist_entry *=
src_he,
> +		       int depth, u64 ip)
> +{
[ ... ]
> +	memcpy(&child_he->ms, &src_he->ms, sizeof(struct map_symbol));
> +
> +	if (src_he->mem_info) {
> +		child_he->mem_info =3D mem_info__clone(src_he->mem_info);
> +		if (!child_he->mem_info)
> +			goto out_free;
> +	}
> +
> +	child_he->thread =3D src_he->thread;

[Severity: Medium]
Does this raw pointer copying bypass the reference count lifecycle helpers?

Looking at c2c_child_entry__alloc(), src_he->ms is copied via memcpy, which
includes the map pointer handle. Additionally, src_he->thread is directly
assigned to child_he->thread without using map__get() or thread__get().

If perf is built with REFCNT_CHECKING, won't this share the explicit pointer
wrapper handles between the source and child entries?

If the source entry is freed and drops its references, the wrapper will be
invalidated. Could this result in an ASAN use-after-free trap when the child
entry later accesses these dangling pointers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717020530.1645=
123-1-jiebin.sun@intel.com?part=3D10
