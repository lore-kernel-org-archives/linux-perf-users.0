Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4696C757EA
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 06:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787554409; cv=none; b=b/ntu4frHXx2jWKBzII/gvk1lm9Yb4VfdR6dWoSMMW9NoNp8hjUkZcckQDXUrWotnLQvc3tRIMPmu56CRrYbua66UNuASIwqEgSGelNZC8qlTWmcFKHI+b5vOc9n2dt030Kh67hqPsA4Tu9T6sG5+xvpZW9Xl4EYxGYzs4WsPmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787554409; c=relaxed/simple;
	bh=1EyHVrBmN1Ka0PtTaPLuA2jB4mqseA3DNts7FAbP+L8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D+2y0EHJrkokC4IQN9dDASim/hIXykMb7qpkyZC2WK4ByfUIKADOaka2M5590Q6RwvcnqoGxMNkY4Inh79Y8xm76UEd3MJTHgpudZWRd2dXoj2u+8Wl9EsSKNcEKLztlOsTO3p3IZalq/aBelisTm1eJZHU7Aa0cOAdV8VbWdRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBEgkaYn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBEgkaYn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3FC1F000E9;
	Mon, 24 Aug 2026 06:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787554408;
	bh=6vMt+eend/xPrHEdH7jt5di8huOn5E3l4vKoMKej6E4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gBEgkaYnRbtfEl5sZdaoSBkwXbswRGUlVSAFtY5n4DBbaI5pXENDMdcIgNYQpt5If
	 f3f/w1+hwvK5DGFhpyGB2a7CYV2IXPzaNgSmM2X9j7YVKe93rcmeDjoTjN3rwOjsvX
	 m89MjXiN1ojNaLw2co7/bt4vACWmXYJFzmKQuIxf+k5WDqcXjhH0t2lgsNUvcD5FPL
	 n+efOjM7tjxSND8PVmEhpG8SEVQLUWgfe3EOJ9P7653YZ+vxnK4uUanuviGT3m+Q7n
	 GJkexEl93idIz59fDOcIOCuFxy0jB8w8S/CmPTFjFE1lihtBRqANzactxTGpD3TFG3
	 xAkvN10i1yMCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/7] perf evlist: Implement evlist__can_merge_hybrid
 using first_wildcard_match
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260824063744.1533837-2-irogers@google.com>
References: <20260813132519.4099508-1-andi@firstfloor.org>
 <20260824063744.1533837-1-irogers@google.com>
 <20260824063744.1533837-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 06:53:27 +0000
Message-Id: <20260824065327.ED3FC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `first_wildcard_match` field in `struct evsel` is assigned as =
a raw pointer without incrementing the reference count of the target `evsel=
`, risking a use-after-free if the target is freed.
--

--- Patch [1]: [PATCH v1 1/7] perf evlist: Implement evlist__can_merge_hybr=
id using first_wildcard_match ---
commit fefc17e1de9b340818e3dce0b74337b9595b7aa3
Author: Ian Rogers <irogers@google.com>

perf evlist: Implement evlist__can_merge_hybrid using first_wildcard_match

Add logic to dynamically identify mergeable events spawned from the same
wildcard alias via first_wildcard_match, breaking reliance on hardcoded
PMU metrics or type IDs.

> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index c3d7847278106..431759e05e260 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
[ ... ]
> @@ -125,12 +128,21 @@ struct evlist *evlist__new_default(const struct tar=
get *target, bool sample_call
>  		if (err)
>  			goto out_err;
>  	} else {
> +		struct evsel *leader =3D NULL;
>  		while ((pmu =3D perf_pmus__scan_core(pmu)) !=3D NULL) {
>  			snprintf(buf, sizeof(buf), "%s/cycles/%s", pmu->name,
>  				can_profile_kernel ? "P" : "Pu");
>  			err =3D parse_event(evlist, buf);
>  			if (err)
>  				goto out_err;
> +			if (!leader)
> +				leader =3D evlist__last(evlist);
> +			else {
> +				struct evsel *last =3D evlist__last(evlist);
> +
> +				if (last !=3D leader)
> +					last->first_wildcard_match =3D leader;

[Severity: High]
Should we be taking a reference here with evsel__get()? Assigning the leader
as a raw pointer without a reference count could lead to a use-after-free if
the leader event is removed or freed before this member event.

> +			}
>  		}
>  	}
[ ... ]
> @@ -148,6 +160,202 @@ struct evlist *evlist__new_default(const struct tar=
get *target, bool sample_call
[ ... ]
> +				if (!evsel__is_hybrid(peer)) {
> +					if (!is_pmu_core_len(peer_name, peer_match - peer_name) ||
> +					    perf_pmus__num_core_pmus() <=3D 1)
> +						continue;
> +				}
> +
> +				if (!strcmp(pos_match, peer_match)) {
> +					peer->first_wildcard_match =3D pos;

[Severity: High]
Similar to above, could this raw pointer assignment leave a dangling pointer
in peer->first_wildcard_match if the matching event (pos) is freed later?
Using evsel__get() and evsel__put() might be needed for reference counting.

> +					has_wildcard =3D true;
> +				}
> +			}
> +		}
> +	}
> +
> +	return has_wildcard && (nr > 1);
> +}
[ ... ]
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index d4cb455f4a7d4..3f56a0e6f9d65 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2052,6 +2052,8 @@ static void evsel__exit(struct evsel *evsel)
>  	evsel__free_config_terms(evsel);
>  	cgroup__put(evsel->cgrp);
>  	perf_evsel__exit(&evsel->core);
> +	if (evsel->first_wildcard_match)
> +		evsel->first_wildcard_match =3D NULL;

[Severity: High]
If first_wildcard_match is holding a reference, would we need evsel__put()
here instead of just setting it to NULL? Also, this only clears its own
pointer, but doesn't it leave dangling pointers in other events that might
have this evsel set as their first_wildcard_match?

>  	zfree(&evsel->group_name);
>  	zfree(&evsel->name);
>  #ifdef HAVE_LIBTRACEEVENT

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824063744.1533=
837-1-irogers@google.com?part=3D1
