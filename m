Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DAC4A99D5
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 18:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791916997; cv=none; b=pTkqSHFb6PzNL9AvCwRrQzqlMakH0HcFLRDLoWlbq3vWVWC7GdVxT0bciPTd+PCoW5Fh4TsQVkSISW5kLPtRpdKiubuPHPdhZnD9uBJEwHYIXiU03xqVYsGZkyHZu5LstRMEGu6tCPG5SJxXhQF/Nkk/xXPhroPtFpBe5qn1BZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791916997; c=relaxed/simple;
	bh=abqUKJ5zA4VPu7PMzxKv1XTDTyqV/hXyafE7tr827W0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=WPD7gZ1fIWRTDRbNmojmCXJ3bfP8zCqqC7b5h5nKsMsBUzw2hmT1CNaYyc1q9U8wJMwoEpdrcoTvBXusS93JbhmxdzIGt5FAchFvEOI+84Jd/4dcFltGa7kyQcCKwIeGQSFoJ3t2vGizQ5CPsSR1MDbhPBrAc/vDh4NJTu/ixdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVzXNtg4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVzXNtg4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1151F000FF;
	Tue, 13 Oct 2026 18:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791916995;
	bh=dGheKe58XgIkF8gtvHidtlT5Yf3jnrejrTIXw8ZZ/OU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UVzXNtg4nk7dt67WQ2VWGzdGew6E5cuaVZfe9r0ufmTIqnM8gaKyXsp6PWPMVOhqW
	 07Bv16Qn+e7UiREl5hKCcJkLleMuWvZysTXiml15jGdjIkcAgDFlskJALNmbmJHEOy
	 KmeIHyVBI56YckKYZQHalQCyGxRL+7kD0SUedReu8PfPqM6aotvCLQOvGaA4Vb4qkf
	 O3bSlJdG93JsHu8+EepIkMb1IxBD+ye7tciI7IKw+KJLRpQUTHOvBGKEcA7na1Tgun
	 TB4nHZOM31Vp2wganiYYVEUnZ9gGgsjhISodwii5bU4ABWGaFt2tQxPvkySI5O+nBL
	 XlkiboTxSx7rw==
Message-ID: <sashiko-outbox-170347@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 10/10] perf maps: Add context analysis annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013182458.1234616-11-irogers@google.com>
References: <20261013182458.1234616-1-irogers@google.com>
 <20261013182458.1234616-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 18:43:15 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf maps: Recursive read-to-write deadlock in maps__load_first()
--

commit a66bec7dd23ce4df0be90007a645d5cd9c4e05dc
Author: Ian Rogers <irogers@google.com>

perf maps: Add context analysis annotations

This commit adds compiler context analysis annotations to the perf maps
subsystem. It annotates map struct fields and internal helper functions
to verify locking invariants at compile time.

> diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> --- a/tools/perf/util/maps.c
> +++ b/tools/perf/util/maps.c

[ ... ]

> @@ -1495,7 +1495,7 @@ void maps__load_first(struct maps *maps)
>  {
>  	down_read(maps__lock(maps));
> =20
> -	if (maps__nr_maps(maps) > 0)
> +	if (__maps__nr_maps(maps) > 0)
>  		map__load(maps__maps_by_address(maps)[0]);

[Severity: Medium]
Can this lead to a recursive read-to-write deadlock on maps__lock?

Here in maps__load_first(), maps__lock is acquired in read mode via
down_read() before calling map__load(). For kernel maps on x86_64,
map__load() triggers the x86_64 entry trampolines mapping:

map__load()
  -> dso__load()
    -> machine__map_x86_64_entry_trampolines()
      -> machine__create_extra_kernel_map()

The machine__create_extra_kernel_map() function then inserts a new map into
the same kernel maps array:

tools/perf/util/machine.c:machine__create_extra_kernel_map() {
    ...
    err =3D maps__insert(machine__kernel_maps(machine), map);
    ...
}

And maps__insert() attempts to acquire the exact same lock in write mode:

tools/perf/util/maps.c:maps__insert() {
    ...
    down_write(maps__lock(maps));
    ...
}

Since maps__load_first() still holds the read lock when map__load()
is called, wouldn't the down_write() in maps__insert() cause a
self-deadlock? Other APIs like maps__load_maps() copy the map array
and drop the read lock before loading to explicitly prevent this scenario.

> =20
>  	up_read(maps__lock(maps));
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013182458.1234=
616-1-irogers@google.com?part=3D10
