Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5018D145A1F
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 02:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789872359; cv=none; b=eeCa2VCAJnkHX1+/7u4+y5aMO0kO0/M1fvxdXvh3Kuy9gqkjPkdweu3e9BTXeUnTcFJBlPWtad9UURFSoncoy6nV2yRcqBoIjU/U6aPyJ0yLjET87r/SxYoj/JLUNxIEoL+EO6kkkUWlvwpMuUAbO2m8PH3M5nmNPsE4sD1t/pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789872359; c=relaxed/simple;
	bh=842a4zy0323v82Xof21t0m7ibjLF1iK8Pu5ifZD2rq8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=accBl0gkUhPTFYGoAyOF8RobtB+5iSDPB0Nsj5gu5odk2EC9nPcQ9VtkKw66vs0hfrvCXhJodLThH8OOeGAwquJ4pBBZ7DCD4OvdPSqjPYNxgUUwnLGoF2VxYfJ1l05XvSyvH6R4DMkBM3jzI01Re3ruokOhR99YkaO/Ug4amOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYd8CzAo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYd8CzAo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B51D81F000FF;
	Sun, 20 Sep 2026 02:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789872357;
	bh=kb7uao4Z5VVvmB9zjNkzpU8qLlX9Osb18hKxvLrM+hM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cYd8CzAolhkg0fy5lJ7q/bbhdANpel/s4kgaPo0yj4l7Op5dJQLgOSUy5QTng+5l2
	 IVSGPEwTkzcK3RLnduJkzf86dWombWlIcDd9JK6nfpS3QKcywdu62CP2pWzxj/hf+q
	 EDyoBEpQyuRy866VkymKgPRsSHJgCeFY/zuHecrzCAM4PyUr7tQII8OYfpbCo6kDAB
	 yt4sWDFlQUUHwwmm5YMU9FrxGmE+LoZzDQ1T4oKvNJUh9Xjzp+0ix1qhABVs1xyEf2
	 PE4chkebeLk2TcF0kXYjs/xCAclVisO09DxGiMkLqbWhV0amv/253UNLyIFkjsnQff
	 bidyzZLApdZVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] perf script: Add --lazy-load-symbols for lazy
 symbol loading
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alireza Haghdoost" <haghdoost@uber.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260919-perf-symbol-memory-send-v2-3-495b8f00ad7c@uber.com>
References: <20260919-perf-symbol-memory-send-v2-0-495b8f00ad7c@uber.com>
 <20260919-perf-symbol-memory-send-v2-3-495b8f00ad7c@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 02:45:57 +0000
Message-Id: <20260920024557.B51D81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] perf: Use-After-Free of dso->symbol_names during concurrent lazy m=
aterialization
- [Medium] perf: missing memory barrier in dso__ondemand check leads to rbt=
ree corruption
--

commit 2498c78d5ec3921571fc9c4a22667912c81f3010
Author: Alireza Haghdoost <haghdoost@uber.com>

perf script: Add --lazy-load-symbols for lazy symbol loading

This commit adds a lazy-load-symbols option to perf script to resolve symbo=
ls
lazily instead of loading full symtabs. It builds a compact sorted index and
materializes symbols that appear in samples, which reduces memory footprint
when profiling large binaries.

> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
[ ... ]
> +void dso__reset_symbol_names(struct dso *dso)
> +{
> +	zfree(&RC_CHK_ACCESS(dso)->symbol_names);

[Severity: High]
Can this zfree() lead to a use-after-free during concurrent lookups?

If dso__materialize_symbols_ondemand() returns early due to max-symbol-bytes
budget limits during a concurrent lookup by name in map__find_symbol_by_nam=
e_idx(),
the dso__ondemand pointer is left non-NULL. The thread then calls dso__sort=
_by_name(),
constructing the dso->symbol_names array, and begins a lockless binary sear=
ch on it.

Concurrently, a lookup by address in another thread evaluates dso__ondemand,
takes the lock, calls dso__find_symbol_ondemand(), and successfully materia=
lizes
a different symbol. This triggers dso__reset_symbol_names(), which immediat=
ely frees
dso->symbol_names via zfree() while the first thread is actively reading it.

> +	RC_CHK_ACCESS(dso)->symbol_names_len =3D 0;
> +	RC_CHK_ACCESS(dso)->sorted_by_name =3D false;
> +}
> +
> +void dso__free_ondemand(struct dso *dso)
> +{
> +	struct dso_ondemand *od =3D RC_CHK_ACCESS(dso)->ondemand;
> +
> +	if (!od)
> +		return;
> +	RC_CHK_ACCESS(dso)->ondemand =3D NULL;

[Severity: Medium]
Does this missing release barrier risk exposing partially written rbtree no=
des?

A thread evaluating dso__ondemand locklessly in map__find_symbol() could
read the state as NULL, bypassing the dso__lock acquisition, and proceed to
traverse the rbtree. Another thread executing dso__free_ondemand() stores N=
ULL
into dso->ondemand as a plain write.

Without smp_store_release() on the writer and smp_load_acquire() on the
reader, a weakly-ordered CPU can reorder the reader's loads such that it
reads the rbtree nodes before ondemand is loaded, observing stale memory.

> +	free(od->sorted);
> +	symbol__unaccount_bytes(od->nr_alloc * sizeof(*od->sorted));
> +	dso__data_close(od->data_dso);
> +	dso__put(od->data_dso);
> +	free(od);
> +}

[ ... ]
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
[ ... ]
>  struct symbol *map__find_symbol(struct map *map, u64 addr)
>  {
> +	struct dso *dso;
> +	struct symbol *sym;
> +
>  	if (map__load(map) < 0)
>  		return NULL;
> =20
> -	return dso__find_symbol(map__dso(map), addr);
> +	dso =3D map__dso(map);
> +	if (dso__ondemand(dso)) {

[Severity: Medium]
This is the lockless read mentioned above. Is an smp_load_acquire() needed
here to pair with a release barrier in dso__free_ondemand()?

> +		/*
> +		 * On-demand lookup may materialize and insert a symbol.  Keep
> +		 * both the lookup and insertion under the DSO lock so another
> +		 * thread cannot traverse or modify the rb-tree concurrently.
> +		 */
> +		mutex_lock(dso__lock(dso));
> +		sym =3D dso__find_symbol(dso, addr);
> +		if (!sym)
> +			sym =3D dso__find_symbol_ondemand(dso, addr);
> +		mutex_unlock(dso__lock(dso));
> +	} else {
> +		sym =3D dso__find_symbol(dso, addr);
> +	}
> +	return sym;
>  }
> =20
>  struct symbol *map__find_symbol_by_name_idx(struct map *map, const char =
*name, size_t *idx)
> @@ -396,6 +414,16 @@ struct symbol *map__find_symbol_by_name_idx(struct m=
ap *map, const char *name, s
>  		return NULL;
> =20
>  	dso =3D map__dso(map);
> +	if (dso__ondemand(dso)) {
> +		mutex_lock(dso__lock(dso));
> +		/*
> +		 * Name lookup requires a complete name-sorted array. Preserve
> +		 * that API by materializing the remaining address index first.
> +		 * An explicit symbol-byte limit can leave a partial set.
> +		 */
> +		dso__materialize_symbols_ondemand(dso);
> +		mutex_unlock(dso__lock(dso));
> +	}
>  	dso__sort_by_name(dso);
> =20
>  	return dso__find_symbol_by_name(dso, name, idx);

[Severity: High]
This is where the concurrent lockless binary search over dso->symbol_names
happens, which may race with the zfree() in dso__reset_symbol_names().

[ ... ]
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
[ ... ]
> +static struct symbol *dso__materialize_symbol_ondemand(struct dso *dso, =
u32 pos)
> +	EXCLUSIVE_LOCKS_REQUIRED(dso__lock(dso))
> +{
[ ... ]
> +	s =3D symbol__new_bounded(idx->start, idx->end - idx->start,
> +				idx->binding, idx->type, name, &budget_exceeded);
> +	free(demangled);
> +	free(name_heap);
> +	if (!s && budget_exceeded)
> +		symbol_budget_warning();
> +	if (s) {
> +		if (idx->flags & SYM_IDX_FLAG_IFUNC_ALIAS)
> +			symbol__set_ifunc_alias(s, true);
> +		dso__reset_symbol_names(dso);

[Severity: High]
This is the call to dso__reset_symbol_names() that triggers the use-after-f=
ree
if a concurrent thread is searching the array locklessly in
map__find_symbol_by_name_idx().

> +		__symbols__insert(dso__symbols(dso), s);
> +		idx->flags |=3D SYM_IDX_FLAG_MATERIALIZED;
> +	}
> +	return s;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919-perf-symbo=
l-memory-send-v2-0-495b8f00ad7c@uber.com?part=3D3
