Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AC93E274A
	for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 08:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779179939; cv=none; b=MCn1n6zaFDlmo57pkeSNiapZ1YSvduSbwlXH0VqckKeMZFHslNMNnA3tcH5jTZgb69yFETOr42qUvBkejBOfNjZt0wu+cHQeCS4fHhlBO7lxK938BzfjgiD6/enISfJZV4T6W4eQx9p8ORwfgIeirfF2Qe//jtKxNGCkdaokg9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779179939; c=relaxed/simple;
	bh=9ZmsvmiPOVMCRsRTTeYYTlZ7m+tPSkm2p5ZzW9srLno=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YqxX3c/JTaHdxLW8qFXgl5hXCldeJBG3P5VHU6WlbMPYFiXD/Xz7bFCrvP7BYeBcIsEXlGOBtGipqXKo6hLuyLefx2OIKfh40ufirn3p28MeH0kwHWXThZq3FD3qKw6Dvx2JgV+ztVXb5sUZeI/ycAC0tCjOa3sDxiP9PprhuLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltFK1jzq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltFK1jzq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9A3C2BCC6;
	Tue, 19 May 2026 08:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779179939;
	bh=9ZmsvmiPOVMCRsRTTeYYTlZ7m+tPSkm2p5ZzW9srLno=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ltFK1jzqzB/ozg+fSnfS9OAbznzWuNyba4jfmPeaqNhDDD5f8DihM4wnD/l7Sn3NP
	 d07jiXdpOYsdk2KdrDLvWy+Hhsseokbdfum/ujlGMwOOySWGKMtN3Scemu49ye7Tfp
	 g6dBsaIEJD9V6ZDDsSJVri7BskWC5K2dDg6dZLnxqqqvkLwNSRHAUXZk+kX5W7zXHk
	 HrjAmGcy/aGp0PfPX31RJ3fbR64yaVOHQMxiKlRGMyRH0ai87zoz3pMwv3XyUinKIj
	 7RctYV6Zssoo3LuutxjzJVy25CyGJd7St5NIA+Bzg73MBmbgCDmdKGEdX1tKukXne7
	 Br6qjQdAI8h5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/4] perf maps: Add maps__mutate_mapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260519080824.3329601-2-irogers@google.com>
References: <20260519080824.3329601-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 08:38:58 +0000
Message-Id: <20260519083859.1F9A3C2BCC6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Recursive read-to-write self-deadlock on maps rw_semaphore during =
lazy symbol loading
- [Medium] Spurious -ENOMEM failure in maps__load_maps() for empty map coll=
ections
--

commit d7722461d022cc4c35c94806250c76c0a6c00722
Author: Ian Rogers <irogers@google.com>

perf maps: Add maps__mutate_mapping

This commit introduces maps__mutate_mapping() to provide thread-safe
modifications to map boundaries using a write lock. It also adds
maps__load_maps() to allow pre-loading of kernel maps without triggering
runtime mutations.

Fixes: 39b12f781271 ("perf tools: Make it possible to read object code from=
 vmlinux")

> diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> --- a/tools/perf/util/maps.c
> +++ b/tools/perf/util/maps.c
[ ... ]
> @@ -576,6 +576,32 @@ void maps__remove(struct maps *maps, struct map *map)
>  #endif
>  }
> =20
> +int maps__mutate_mapping(struct maps *maps, struct map *map,
> +			 int (*mutate_cb)(struct map *map, void *data), void *data)
> +{
> +	int err =3D 0;
> +
> +	if (maps)
> +		down_write(maps__lock(maps));
> +
> +	err =3D mutate_cb(map, data);

Does this unconditional down_write() create a recursive read-to-write
self-deadlock during lazy symbol loading?

Looking at the existing codebase, map__load() is often called while holding
the read lock. For example, in maps__for_each_map() or maps__load_first(),
a read lock is taken before iterating:

maps__for_each_map() {
    ...
    down_read(maps__lock(maps));
    ...
        cb(map, data);
    ...
}

The callback can trigger map__load() which calls dso__load_kernel_sym().
Since dso__load_kernel_sym() and dso__process_kernel_symbol() are updated
in this patch to call maps__mutate_mapping(), which acquires the write lock
on the same rw_semaphore, won't this cause a guaranteed deadlock for existi=
ng
paths that haven't been updated to use the new maps__load_maps() pre-loading
API?

[ ... ]
> @@ -626,6 +652,35 @@ int maps__for_each_map(struct maps *maps, int (*cb)(=
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
> +	maps_copy =3D calloc(nr_maps, sizeof(*maps_copy));
> +	if (!maps_copy) {
> +		up_read(maps__lock(maps));
> +		return -ENOMEM;
> +	}

Can this return a spurious -ENOMEM if the maps list is empty?

If nr_maps is 0, calloc(0, size) is implementation-defined and permitted to
return NULL. If it does, this error path will be taken instead of safely
returning 0 for an empty list.

Should this code explicitly check for nr_maps =3D=3D 0 before attempting the
allocation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519080824.3329=
601-1-irogers@google.com?part=3D1
