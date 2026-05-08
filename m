Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B823CCFA8
	for <linux-perf-users@vger.kernel.org>; Fri,  8 May 2026 20:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778272650; cv=none; b=cYP4pPUjF2C3bpQTPuME0sxpM/XKEa/rLkH2hUOxHaUmG9g7Q56C1z95yULH5kCByP8bpKpTvo4bqZ8Y0bJ8fx5Aes/K/aA5UebECHY47D+zLU9ZKzx2ogbU8nuw9jNlt83Q/Wk2hQa0au6VZ1FKC/bdRBrlVgtRO5AJHTpukpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778272650; c=relaxed/simple;
	bh=nNzugf9samZjpR+W1dPwBg68E6UpDhdw8DjdI4G5GO8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qR8AI/kCcNZ8dGC1bAiRBPwPCOjdOrDjh8uk25m+0gk2iNjJB17WcB3jxwgCAzcIrfPqkzshozvt3u/AxrkB1t31BiMdz+lrnP4m/ff9akS3bhDcIIokV+LjHef+OIbCiNvvA+ptcl15q4iXf6V6yZ0AmmKjCJ4dy6qBiqCvnW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gE+d8IT6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gE+d8IT6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FBEC2BCB0;
	Fri,  8 May 2026 20:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778272650;
	bh=nNzugf9samZjpR+W1dPwBg68E6UpDhdw8DjdI4G5GO8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=gE+d8IT6QyQs/Z4MEvrXbAQ0XneR2g0zuKkZIAypz1MmHCpD+sq4kxrbiUVJOvnj4
	 GU9PGYWPb8vzp2e0mockPRD4Lw/XczDh/ID7khVjxD7PZflabjo/OEYIHRJtKbCf0j
	 vJlrUwQEOw7Y8yf5RGCvwuozz+bkPcowJ2oj7jzCTFkAHtiC47QArpeWnKst9S0T+O
	 A5FrHXOmnoK6PShLQM4BAD6jINUdaD7rM2NOvvW9SR9SBaWM9hZ3oxaZX/DiA1lmeE
	 9x0ktQnQfwjXkdJ6DjygLa9jLwa2WrTOFpxBWDosDnveRrNGi6PWCziOT+q13KCg3X
	 J4OHhoCTKTYMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/6] perf maps: Add maps__mutate_mapping
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260508082726.2795191-4-irogers@google.com>
References: <20260508082726.2795191-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 20:37:29 +0000
Message-Id: <20260508203730.07FBEC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Self-deadlock in the kallsyms symbol loading path.
--

commit 1340dc1c4b3b633e8a032536f0c7948f87b17ce3
Author: Ian Rogers <irogers@google.com>

perf maps: Add maps__mutate_mapping

This commit introduces maps__mutate_mapping to safely update map boundaries
by acquiring a write lock on the maps collection. It applies this new
synchronization to kernel ELF parsing, kallsyms image loading, and dynamic
memory map updates to close concurrent lookup races.

> There is a potential for self deadlock if maps__mutate_mapping is called
> with the lock held, such as with maps__for_each_map but this problem also
> existed with the previous remove and insert approaches.

Is this commit message accurate for all modified paths? Prior to this patch,
dso__load_kernel_sym and dso__load_guest_kernel_sym used map__fixup_start a=
nd
map__fixup_end directly without locking.

> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index fcaeeddbbb6b9..09b93e844887d 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
[ ... ]
> @@ -2121,10 +2128,11 @@ static int dso__load_kernel_sym(struct dso *dso, =
struct map *map)
>  	free(kallsyms_allocated_filename);
> =20
>  	if (err > 0 && !dso__is_kcore(dso)) {
> +		struct maps *kmaps =3D map__kmaps(map);
> +
>  		dso__set_binary_type(dso, DSO_BINARY_TYPE__KALLSYMS);
>  		dso__set_long_name(dso, DSO__NAME_KALLSYMS, false);
> -		map__fixup_start(map);
> -		map__fixup_end(map);
> +		maps__mutate_mapping(kmaps, map, map_fixup_cb, NULL);

Can this cause a self-deadlock when resolving kernel symbols by name?

If a tool resolves a symbol upon first load, the call chain appears to hold=
 a
read lock while attempting to acquire a write lock on the exact same maps
collection:

maps__find_symbol_by_name()
  maps__for_each_map()                  <-- acquires read lock
    maps__find_symbol_by_name_cb()
      map__load()
        dso__load_kernel_sym()
          maps__mutate_mapping()        <-- attempts to acquire write lock

Since rw_semaphore cannot be upgraded from read to write without releasing =
the
read lock first, won't this immediately deadlock on the kmaps lock?

>  	}
> =20
>  	return err;
[ ... ]
> @@ -2164,10 +2172,11 @@ static int dso__load_guest_kernel_sym(struct dso =
*dso, struct map *map)
>  	if (err > 0)
>  		pr_debug("Using %s for symbols\n", kallsyms_filename);
>  	if (err > 0 && !dso__is_kcore(dso)) {
> +		struct maps *kmaps =3D map__kmaps(map);
> +
>  		dso__set_binary_type(dso, DSO_BINARY_TYPE__GUEST_KALLSYMS);
>  		dso__set_long_name(dso, machine->mmap_name, false);
> -		map__fixup_start(map);
> -		map__fixup_end(map);
> +		maps__mutate_mapping(kmaps, map, map_fixup_cb, NULL);

Does this guest kernel symbol loading path suffer from the exact same
self-deadlock sequence?

>  	}
> =20
>  	return err;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508082726.2795=
191-1-irogers@google.com?part=3D3
