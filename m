Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB9740DFCD
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776646498; cv=none; b=FlTyxqjQ+F4Wn+CX6YWEUu9izYdgttGCxMZ9YbxDj1RkV9cC3PgKCe5BWUXlRHwStQ49tt1QeDF6mo0umDQZj5xRiKepY0+hYy+vnBndEYGfnfNGubzM1DlkXd13m1I0kA6vOWTR/qYXCad055+j83XwrOdW6GeaB7IIVXLVwCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776646498; c=relaxed/simple;
	bh=7yee58CptBchaCgBc3oivNFgeMs5jMG3ASgFpr7kbxg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tpWv9T+PIqN/l5LTQocyMNaIfwVjpzpuDHnchRbjFUkypJKLOuDfAEM8d7rYKoLzWBbmJHrMlljSytfn1o+5vuquv4MGUlGS/1Vvv5k2ohREKt/HiiGiIwBdfjDL1bFPwYUaXWe3Qz7a1Czyovmt25Dg/64Ne/YTm5m6jsBVV/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o24MsJK9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o24MsJK9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A08BC2BCAF;
	Mon, 20 Apr 2026 00:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776646498;
	bh=7yee58CptBchaCgBc3oivNFgeMs5jMG3ASgFpr7kbxg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=o24MsJK9SHyOXocQtjbaocDlJ/RxNqlC2/VeD0BOqi0mxjpjjjCZmt+Q/KUB56Bm9
	 2mGApY+TqdLLGvU3MRt3rMWHY+FPIO3/yI8MHi5k8WKVwQA/Vri/VBQ1bLeqZ4z7l3
	 SAw8quGi2SscvuyVhQUBN+2qsUnOI0wlVeCffjVoUF8PQy65AhT7314t41WuaT8frC
	 MjrVrjphsONbmxR3OeoRRuH8RxLnx9BHUWkR3R12BO3kUdK31ciQqIxD3LroqHdxTO
	 hTPL4j4CZW//XnjO6GPRgmDldTQg3tasJhTyqLl4rvXmMutNj4z/WW9CWl/0Fvk6+x
	 UA+foMrpitBZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 12/58] perf evlist: Add reference count checking
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-13-irogers@google.com>
References: <20260419235911.2186050-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:54:57 +0000
Message-Id: <20260420005458.1A08BC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [High] Missing NULL checks on the return values of `from_list_start()` an=
d `evlist__get()` lead to NULL pointer dereferences on OOM.
- [High] Dangling back-pointers causing Use-After-Free (UAF) due to indepen=
dent wrapper lifetimes in `REFCNT_CHECKING` mode.
- [Medium] Memory leak of the core `evlist` structure in `evlist__new()` if=
 the RC wrapper allocation fails.
- [Low] Incorrect use of `TEST_ASSERT_VAL` macro in a boolean-returning tes=
t function masks test failures.
--

commit ca121cd135cb57c668a2abf625563e5436802b00
Author: Ian Rogers <irogers@google.com>

perf evlist: Add reference count checking

This commit adds reference count checking to the perf evlist structure to
ensure gets and puts are paired correctly. It introduces new accessors for
evlist functions and updates the subsystem to use these checked variants.

> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
[ ... ]
>  struct evlist *evlist__new(void)
>  {
> -	struct evlist *evlist =3D zalloc(sizeof(*evlist));
> -
> -	if (evlist !=3D NULL)
> -		evlist__init(evlist, NULL, NULL);
> +	struct evlist *result;
> +	RC_STRUCT(evlist) *evlist;
> =20
> -	return evlist;
> +	evlist =3D zalloc(sizeof(*evlist));
> +	if (ADD_RC_CHK(result, evlist)) {
> +		perf_evlist__init(evlist__core(result));

If the ADD_RC_CHK allocation fails internally, it returns a NULL pointer for
the wrapper. Does this code leak the original evlist allocated via zalloc
since the function will return without freeing it?

[ ... ]
> +static struct evlist *from_list_start(struct perf_evlist *core)
> +{
> +#ifdef REFCNT_CHECKING
> +	RC_STRUCT(evlist) *core_evlist =3D container_of(core, RC_STRUCT(evlist)=
, core);
> +	struct evlist *evlist;
> +
> +	if (ADD_RC_CHK(evlist, core_evlist))
> +		refcount_inc(evlist__refcnt(evlist));
> +
> +	return evlist;
> +#else
> +	return container_of(core, struct evlist, core);
> +#endif
> +}
[ ... ]
>  static struct perf_mmap*
>  perf_evlist__mmap_cb_get(struct perf_evlist *_evlist, bool overwrite, in=
t idx)
>  {
> -	struct evlist *evlist =3D container_of(_evlist, struct evlist, core);
> +	struct evlist *evlist =3D from_list_start(_evlist);
>  	struct mmap *maps;
> =20
> -	maps =3D overwrite ? evlist->overwrite_mmap : evlist->mmap;
> +	maps =3D overwrite ? evlist__overwrite_mmap(evlist) : evlist__mmap(evli=
st);

Since from_list_start can return a NULL pointer under memory pressure when
REFCNT_CHECKING is enabled, could this lead to a NULL pointer dereference
when evlist__overwrite_mmap subsequently attempts to access the pointer?

Other functions like evlist__get also appear to return NULL on allocation
failure without subsequent checks by callers.

[ ... ]
>  void evlist__add(struct evlist *evlist, struct evsel *entry)
>  {
> -	perf_evlist__add(&evlist->core, &entry->core);
> +	perf_evlist__add(evlist__core(evlist), &entry->core);
>  	entry->evlist =3D evlist;
>  	entry->tracking =3D !entry->core.idx;

With the new reference count checking, evlist__get creates a new wrapper and
evlist__put frees it via RC_CHK_PUT, even if the underlying shared object
is still active.

If entry->evlist stores the specific wrapper pointer passed to evlist__add,
and that wrapper is later freed while the underlying list remains active,
could accessing entry->evlist elsewhere trigger a use-after-free regression?

> diff --git a/tools/perf/tests/time-utils-test.c b/tools/perf/tests/time-u=
tils-test.c
> --- a/tools/perf/tests/time-utils-test.c
> +++ b/tools/perf/tests/time-utils-test.c
[ ... ]
>  static bool test__perf_time__parse_for_ranges(struct test_data *d)
>  {
> -	struct evlist evlist =3D {
> -		.first_sample_time =3D d->first,
> -		.last_sample_time =3D d->last,
> -	};
> -	struct perf_session session =3D { .evlist =3D &evlist };
> +	struct evlist *evlist =3D evlist__new();
> +	struct perf_session session =3D { .evlist =3D evlist };
>  	struct perf_time_interval *ptime =3D NULL;
>  	int range_size, range_num;
>  	bool pass =3D false;
>  	int i, err;
> =20
> +	TEST_ASSERT_VAL("Missing evlist", evlist);

TEST_ASSERT_VAL returns TEST_FAIL (-1) if the condition is false. Since
this function returns a boolean, -1 evaluates to true. Does this regression
inadvertently mask the error and cause a failing test to report as passing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D12
