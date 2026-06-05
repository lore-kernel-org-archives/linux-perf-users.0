Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4C0257ACF
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 19:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688522; cv=none; b=V+oRO/8JTsHJVJZV+S5hHSKVwEnIoV531+ttnxRuTcxV2ij70or2jN/sJtxC1ROtk8bXeuD8Q5NvvoWQQj+Y+kkHMvqkewDlDSeR5Bu/gdJiYu06HtM24SMMCqvb/sFigCGN/fN5AYAnpHNp5LRpttpmWerAAqr9qjHJuSg5krM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688522; c=relaxed/simple;
	bh=yMqZ7w3AYUAFmM4oE35WStGWlpJlIxgE9UuA1IsXbLE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h3w0DWMivItrCJZZI2Y6PLK/3ioRWS2DoxhJ5uOnR+NprrhftSHTnDjG2H0QbDxddavlBwxafMg1Ielp/c2QEfoDzk6ACnn5lLaMAA6MWXjCK6MRrlFlkrKBoAyG8JxQykHo21WpGDeLOAooDbjEa/PiQwNPbh+WVscNE5g5QcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G38TXH5a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G38TXH5a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6071F00893;
	Fri,  5 Jun 2026 19:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688520;
	bh=i9OgcHgYU73OycBHENb6sSJfjSSushQs/HUVM+hl9Kk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G38TXH5a71TofogKmX+PEnMPcWiEEIKQV9I6TGVbyFaEa2inVYfvY2bmD1ebACN76
	 CGOJzX0WHcj3sE89BSri2/g08dWjGeZElJQkBf2Z9m5LFjey9TGEocVAe3ejBCP71P
	 2g7nKswml3gBbecYV7tSAum3sM4/2tSMWalrNt6vI1Z6paPIMc/UCk9aI25d55UbGf
	 lMdX6d+TLmIAUPAPqLr57vBtrX7ChkHdYb7z//cimsxjQ77c3SuhvSi7XLM1bLodWe
	 Q8UR2gQIILZgienPXN02MOLvVl+iJCCzJFf0XQHQ/d8wLhkBOcPzKQFTiMsD/cdUUm
	 w9isO0+igKC4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 07/19] perf evlist: Add reference count checking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605191500.2477026-8-irogers@google.com>
References: <20260605191500.2477026-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 19:42:00 +0000
Message-Id: <20260605194200.AF6071F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [Critical] Double Free and TOCTOU Race in `evlist__put()`
- [Critical] Use-After-Free / Dangling Pointers in `evlist__put` cycle coll=
ection
- [High] Memory Leak of `evsel` via missing `evsel__put()` in sample delive=
ry
- [High] Memory leak of spliced `evlist`s due to missing re-parenting

Pre-existing issues:
- [High] Python memory leak in `pyrf_evlist__read_on_cpu`
- [High] Python object memory leak in `pyrf_evlist__add`
--

commit e390129ddc82f7909e4e9e3187e55f4b0eb8b77b
Author: Ian Rogers <irogers@google.com>
perf evlist: Add reference count checking

This patch adds reference count checking for the perf evlist to ensure that=
=20
gets and puts are correctly paired and easy to debug.

> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -183,16 +200,21 @@ static void evlist__purge(struct evlist *evlist)
> =20
>  	evlist__for_each_entry_safe(evlist, n, pos) {
>  		list_del_init(&pos->core.node);
> +		if (pos->evlist) {
> +			/* Minimal evlist__put. */
> +			refcount_dec_and_test(evlist__refcnt(pos->evlist));
> +			RC_CHK_PUT(pos->evlist);
> +		}
>  		pos->evlist =3D NULL;
>  		evsel__put(pos);
>  	}

[Severity: High]
Does ignoring the return value of refcount_dec_and_test() cause a memory le=
ak
when splicing is used? When evlist__splice_list_tail() moves evsels from a
source evlist to a destination evlist, the spliced evsels still point to the
old source evlist. When this purge logic hits the source evlist, the refcou=
nt
drops to 0 and refcount_dec_and_test() returns true, but because the return
value is ignored, the memory for the source evlist is never actually freed.

[ ... ]

> @@ -211,15 +240,43 @@ void evlist__put(struct evlist *evlist)
> +retry:
> +	count =3D refcount_read(evlist__refcnt(evlist));
> +	ref_cnt =3D count;
> +	evlist__for_each_entry(evlist, evsel) {
> +		if (RC_CHK_EQUAL(evsel->evlist, evlist) && count)
> +			count--;
> +	}
> +	if (refcount_read(evlist__refcnt(evlist)) !=3D ref_cnt)
> +		goto retry;
> =20
> +	if (count !=3D 0) {
> +		/*
> +		 * Not the last reference except for back references from
> +		 * evsels.
> +		 */
> +		RC_CHK_PUT(evlist);
> +		return;
> +	}

[Severity: Critical]
Can this TOCTOU race lead to a double free? If two threads concurrently drop
an external reference to the evlist, they both might execute
refcount_dec_and_test(). If the refcount drops to the number of evsels with
back-references, both threads could enter the retry block simultaneously, r=
ead
the count, and decrement it to 0. Since the refcount hasn't changed during
the loop, the verification evaluates to false for both. Both threads would
see count =3D=3D 0 and fall through to out_delete, causing a double free.

[Severity: Critical]
Does this cycle collection logic prematurely free the evlist by ignoring the
refcounts of the evsel objects themselves? If an external user holds a stro=
ng
reference to an evsel (where its refcount > 1), it relies on the evsel's
strong reference to the evlist to keep the evlist alive. By proceeding to
destroy the evlist here without checking evsel refcounts, evlist__purge()
will set pos->evlist =3D NULL, leaving the external user with a dangling or
NULL evlist pointer.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -1804,27 +1823,32 @@ static PyObject *pyrf_evlist__add(struct pyrf_evl=
ist *pevlist,
>  				  PyObject *args,
>  				  PyObject *kwargs __maybe_unused)
>  {
> -	struct evlist *evlist =3D pevlist->evlist;
> +	struct evlist *evlist;
>  	PyObject *pevsel;
>  	struct evsel *evsel;
> =20
> +	CHECK_INITIALIZED(pevlist->evlist, "evlist");
> +
> +	evlist =3D pevlist->evlist;
>  	if (!PyArg_ParseTuple(args, "O!", &pyrf_evsel__type, &pevsel))
>  		return NULL;
> =20
> -	Py_INCREF(pevsel);
>  	evsel =3D ((struct pyrf_evsel *)pevsel)->evsel;
> -	evsel->core.idx =3D evlist->core.nr_entries;
> +	CHECK_INITIALIZED(evsel, "evsel");
> +
> +	Py_INCREF(pevsel);
> +	evsel->core.idx =3D evlist__nr_entries(evlist);
>  	evlist__add(evlist, evsel__get(evsel));

[Severity: High]
This isn't a bug introduced by this patch, but does calling Py_INCREF(pevse=
l)
here cause a memory leak? The Python wrapper object is incremented but never
stored in any Python collection or decremented later. The underlying C evsel
is added to the C evlist (which takes its own reference via evsel__get).
Because the Python reference is incremented but never decremented, the wrap=
per
is permanently leaked, preventing its destructor from running and leaking t=
he
initial C reference it holds.

[ ... ]

> @@ -1836,13 +1860,16 @@ static struct mmap *get_md(struct evlist *evlist,=
 int cpu)
>  static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
>  					  PyObject *args, PyObject *kwargs)
>  {
> -	struct evlist *evlist =3D pevlist->evlist;
> +	struct evlist *evlist;
>  	union perf_event *event;
>  	int sample_id_all =3D 1, cpu;
>  	static char *kwlist[] =3D { "cpu", "sample_id_all", NULL };
>  	struct mmap *md;
>  	int err;
> =20
> +	CHECK_INITIALIZED(pevlist->evlist, "evlist");
> +
> +	evlist =3D pevlist->evlist;
>  	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "i|i", kwlist,
>  					 &cpu, &sample_id_all))
>  		return NULL;

[Severity: High]
This is a pre-existing issue, but does this function leak the python object
on failure? If evlist__parse_sample() fails, the code returns an exception
via PyErr_Format() but fails to Py_DECREF() the allocated pyevent object,
permanently leaking it. Additionally, if it succeeds, it calls Py_INCREF()
before returning it, bumping the refcount to 2 while the caller only expects
1, preventing the object from ever being garbage collected.

> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1959,21 +1963,23 @@ static int machines__deliver_event(struct machine=
s *machines,
> =20
>  	dump_event(evlist, event, file_offset, sample, file_path);
> =20
> -	if (!sample->evsel)
> +	if (!sample->evsel) {
>  		sample->evsel =3D evlist__id2evsel(evlist, sample->id);
> -	else
> +		if (sample->evsel)
> +			sample->evsel =3D evsel__get(sample->evsel);
> +	} else {
>  		assert(sample->evsel =3D=3D evlist__id2evsel(evlist, sample->id));
> -
> +	}
>  	machine =3D machines__find_for_cpumode(machines, event, sample);

[Severity: High]
Does adding evsel__get() here introduce a memory leak? The sample delivery
path populates sample->evsel and takes a reference, but the cleanup paths
like perf_sample__exit() do not appear to have a matching evsel__put(). This
permanently leaks the evsel object and its reference wrapper for events
processed this way.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605191500.2477=
026-1-irogers@google.com?part=3D7
