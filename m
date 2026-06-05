Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E863B9DB3
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 06:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780640408; cv=none; b=CtyB62FT/dGuuTWfyyb/rxuKgSz5E3wRvieX4RhpbSyIPR59UK6Ju70Bxb8gGfhZ6VpEI1IXqvJS/8dnJ05ruvhEhoKaHz6Oj1hgjk2NKMwDYt/laRkBm+d6atlX9k7tKMHFSO0XoQzzsYhBVUigJdb9Aa1d5F3u/0oYlZRXCL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780640408; c=relaxed/simple;
	bh=CngxGHmQamK6XCJujDdROz1cAW/14M76EdaTX8HTcYo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EssEKm2EGI5dk5JkobH5rprILMwzXXK5O1PZQkZmVBeWekZ8sxcS/LTF6xiaGXBVfple5TIia73u9XVz3nZkhxs2iZA4nE3/2bIIKL3JK/Mip3wobph45jRaVojQakBARrlPOa7X8UHffaiWqexhglztIHKMFg1vHac8bUfStQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJFcaecs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJFcaecs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1C91F00893;
	Fri,  5 Jun 2026 06:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780640406;
	bh=Gb12AmsF1fUxq8jHSUbL7DbIYQ2JoF8W8Xw5IoNzOV8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WJFcaecsUMlNdz29C9GSfubrntJnmofqS9bXKkS3/7U5QXYvho2VFffdhMxD8ChGi
	 uBb8srpPDcKkltjlwdJsGICU0bxzuhNw4L+et2LGne2kUa4FwGAot+NEVy60T7ukq1
	 +v9MAg6BmFkcl9cjztC+ikdepczm0O06XYJTEpwXXBCv5Qg9KHSBfONiBQR2CjxDfH
	 LZC/ZZ9k6PoC9VpDFYWGXIiQTz9j9HhpvmOdFRb1dy1HWiyIt1TJ6y8hyttAeB3Cof
	 oAsuRD+oqLL4AHlPypw3KHMAGDE1jqZjMjjcFjXmQ3jJnekWXoXVRMv7sEAbyvMsmB
	 +tDgxmPMevJ4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/5] perf maps: Add maps__mutate_mapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605060610.1529996-2-irogers@google.com>
References: <20260605060610.1529996-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 06:20:06 +0000
Message-Id: <20260605062006.BC1C91F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Data race and logical corruption by modifying map sorting flags un=
der a read lock on the memory allocation error path in `maps__load_maps()`.
- [High] A single module load failure in `maps__load_maps()` causes `maps__=
find_symbol_by_name()` to abort the entire symbol lookup.
- [High] The lockless map pre-loading exposes a TOCTOU race that still lead=
s to the read-to-write recursive self-deadlock.
--

commit 2675e44926570b5a06b75a048fcec8958d572142
Author: Ian Rogers <irogers@google.com>

perf maps: Add maps__mutate_mapping

This patch introduces maps__mutate_mapping() to apply map boundary mutations
under a write lock to fix a concurrent lookup race. It also introduces
maps__load_maps() to pre-load modules and bypass dynamic runtime mutations
to prevent read-to-write self-deadlocks.

[ ... ]

> diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> index 923935ee21b66..be77dee16041b 100644
> --- a/tools/perf/util/maps.c
> +++ b/tools/perf/util/maps.c

[ ... ]

> @@ -626,6 +669,41 @@ int maps__for_each_map(struct maps *maps, int (*cb)(=
struct map *map, void *data)
>  	return ret;
>  }
> =20
> +int maps__load_maps(struct maps *maps)
> +{
> +	struct map **maps_copy;
> +	unsigned int nr_maps;
> +	int err =3D 0;
> +
> +	if (!maps)
> +		return 0;
> +
> +	down_read(maps__lock(maps));
> +	nr_maps =3D maps__nr_maps(maps);
> +	if (nr_maps =3D=3D 0) {
> +		up_read(maps__lock(maps));
> +		return 0;
> +	}
> +	maps_copy =3D calloc(nr_maps, sizeof(*maps_copy));
> +	if (!maps_copy) {
> +		RC_CHK_ACCESS(maps)->maps_by_address_sorted =3D false;
> +		RC_CHK_ACCESS(maps)->maps_by_name_sorted =3D false;

[Severity: High]
Does this code create a data race by modifying shared state under a read
lock?

We only hold the down_read() semaphore here, but we are writing to the
shared boolean flags.

Also, since the memory allocation failed and no maps were actually mutated,
is it necessary to invalidate the sorted state? This seems like it will
unnecessarily force future readers to acquire a write lock to re-sort an
already sorted array.

> +		up_read(maps__lock(maps));
> +		return -ENOMEM;
> +	}
> +	for (unsigned int i =3D 0; i < nr_maps; i++)
> +		maps_copy[i] =3D map__get(maps__maps_by_address(maps)[i]);
> +	up_read(maps__lock(maps));
> +
> +	for (unsigned int i =3D 0; i < nr_maps; i++) {
> +		if (map__load(maps_copy[i]) < 0)
> +			err =3D -1;
> +		map__put(maps_copy[i]);
> +	}
> +	free(maps_copy);
> +	return err;
> +}

[ ... ]

> @@ -700,6 +778,8 @@ struct symbol *maps__find_symbol_by_name(struct maps =
*maps, const char *name, st
>  		.sym =3D NULL,
>  	};
> =20
> +	if (maps__load_maps(maps) < 0)
> +		return NULL;

[Severity: High]
Will a single module load failure cause this to abort the entire symbol loo=
kup?

If maps__load_maps() encounters a single failure (for example, due to a mis=
sing
kernel module debuginfo), it propagates an error of -1.

By returning NULL immediately here, don't we bypass searching all the
successfully loaded modules? Previously, individual map load failures
were silently skipped, allowing the search to gracefully continue.


[Severity: High]
Can a concurrent insertion defeat this lockless pre-loading and still trigg=
er
the recursive self-deadlock?

maps__load_maps() drops the read lock after copying the map pointers. What
happens if a concurrent thread inserts a new, unloaded kernel map right
after maps__load_maps() returns, but before maps__for_each_map() executes?

It looks like maps__for_each_map() would then iterate over the newly insert=
ed
map, invoke map__load() while holding the down_read() lock, and trigger
maps__mutate_mapping().

Won't maps__mutate_mapping() then unconditionally attempt to acquire the
down_write() lock, triggering the exact read-to-write self-deadlock this
patch intends to fix?

>  	maps__for_each_map(maps, maps__find_symbol_by_name_cb, &args);
>  	return args.sym;
>  }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605060610.1529=
996-1-irogers@google.com?part=3D1
