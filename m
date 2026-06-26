Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1317C1A38F9
	for <linux-perf-users@vger.kernel.org>; Fri, 26 Jun 2026 07:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782458395; cv=none; b=EG58OsKoffsVIC7GWWJjCLzbLoD7yeaxcHE3+0cANlePA4Hw++6Tp0FLCL6XFJjfZRhoTprLRfc4uU+qtzXtsXo7n8tj5/of3b3TgqZHPxA1ROAhtYL6WhUW6X98ytucxaS4HeC7qEiQAQpVw4t6NhsV0agu42E3Znou6BoVcXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782458395; c=relaxed/simple;
	bh=tCuzeTigIwWaKLrqpNtYoHLs8BKE3iN9MzOWVjRXmb8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h7IKoQ6jsWtAie2k3KlQQ6V49Tg7HKbhyePkY4bR+q53xVxH88nyvy+qlAWg/b4Jlns0RUFEHUI3OqvtxHJj9aqo41cO+ddMk4zKPTAZh586m1w65tQvU7l9K7hczXvrjiSpS1J/kAgYQ2XbX+IlAOAm4yc1fiXnxhPSO3MxXDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E48nvgzC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E48nvgzC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8CA51F000E9;
	Fri, 26 Jun 2026 07:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782458393;
	bh=Vz6QO8/eWaumtwsafpWm/g78X6GrNH6DDbyfz19xXq4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E48nvgzC8wKohsiJlYmxlUJuIpxLi59k3o72VH6xu+/m/sfa3J7CM9/TJguauZhMH
	 xsW7z2UAlxY31l487O/dP6qoWtGxpqCiwWt+ET93lPqHGNFuOunIZMbkWV1pHnYbMW
	 X0afbxBtluUbZlzFYfeLsBNwMwTpGUsL8Tjxq+NhJmjnPael0S2wPNf8SlLWtANgly
	 xh3/K3Djbs3Y8Yn8A/8dH5zW5gh5lqGcmIYtrhFaeZq++Zi7074q7f6MG6o+4+YiRW
	 NlaGTeJ7XsNql0AiwkOApyMLVwt15QIlmmgZ2buoNOc5oRfIg9rqBgTF51LuJ0EpsY
	 eP+U9HjAGZymA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/14] perf c2c: add hierarchy entry creation and lookup
 functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260626070355.1556721-11-jiebin.sun@intel.com>
References: <20260626070355.1556721-1-jiebin.sun@intel.com>
 <20260626070355.1556721-11-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 07:19:53 +0000
Message-Id: <20260626071953.C8CA51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Raw pointer assignment of reference-counted `thread` and `map_sy=
mbol` structs violates subsystem architectural rules.
--

commit 1ca4db3fb5b5554b1481105028f0603bdc285571
Author: Jiebin Sun <jiebin.sun@intel.com>

perf c2c: add hierarchy entry creation and lookup functions

This commit adds functions for creating and finding entries at each level
of the 3-level function view hierarchy for perf c2c. It introduces
c2c_child_entry__alloc() for allocation and other helper functions to build
the hierarchy.

> diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browse=
rs/c2c-function.c
> index a42378f395f59..a881839299e37 100644
> --- a/tools/perf/ui/browsers/c2c-function.c
> +++ b/tools/perf/ui/browsers/c2c-function.c

[ ... ]

> +static struct c2c_hist_entry *
> +c2c_child_entry__alloc(struct hist_entry *parent_he, struct hist_entry *=
src_he,
> +		       int depth, u64 ip)
> +{
> +	struct c2c_hist_entry *child_c2c;
> +	struct hist_entry *child_he;
> +	size_t callchain_size;
> +
> +	callchain_size =3D symbol_conf.use_callchain ? sizeof(struct callchain_=
root) : 0;
> +	child_he =3D c2c_he_zalloc(callchain_size);
> +	if (!child_he)
> +		return NULL;
> +
> +	child_c2c =3D container_of(child_he, struct c2c_hist_entry, he);
> +	child_he->callchain_size =3D callchain_size;
> +	if (callchain_size)
> +		callchain_init(child_he->callchain);
> +
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
Does this code bypass the reference tracking helpers for the thread and
map_symbol structs?

Using memcpy() for map_symbol and raw pointer assignment for the thread
handle circumvents the reference count checking safety mechanisms. Should
this use explicit lifecycle helpers like thread__get() and map__get() to
ensure proper reference count balancing?

> +	child_he->cpumode =3D src_he->cpumode;
> +	child_he->cpu =3D src_he->cpu;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626070355.1556=
721-1-jiebin.sun@intel.com?part=3D10
