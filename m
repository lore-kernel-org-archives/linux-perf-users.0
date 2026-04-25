Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677FA38F65F
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777159028; cv=none; b=GDu00Dxcg0rdp/E1nK8RkbrgvZmQ/DrsbrB5KmcaJ6Ro98zok0iDnXZMWAHdCYOc6NA7Oyx13KJPcaI4x30W9RcX4/6YXFR6jr0oQLAOQQg5koyGqu+C3FeWq821ximlK5Yxhkmt9/V9EulhTYkWstikeOezrXDoGSBIbW8me3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777159028; c=relaxed/simple;
	bh=1g1ZET6dWAA9EaW6A7utZ+G5qALrqQRo5K7DWL0wyww=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J3xQfRT1qXBWJkqXu1XQQZ1Ytjxx8GOFfML4LuxLTJ3b3VzJ2kC/+eAFFPJvqb5dfytykvz7/BqMs3lxXIEasvA7hc82Bvl+sf6yqzv8oPb+0kpaKYJ3qlKb2sHXOqZvJMltQkK2YvLu3VuJ2gVTNPRVFUyi3h8Uspc0olStf/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEHLCLGb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEHLCLGb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2CD0C2BCB0;
	Sat, 25 Apr 2026 23:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777159028;
	bh=1g1ZET6dWAA9EaW6A7utZ+G5qALrqQRo5K7DWL0wyww=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=TEHLCLGb1o1RpbDGZHW9g1XoAvdbSNuR1FbuQ3dcPc0BKGERlhfdk4k2OmBDoDWLz
	 qweaXLqrGOkC0HdyrPgGy73gvPQxU5Vv7iYtp3Hj9piBZkzGXrNAT5/fYdb1NOusBh
	 vjK5I44ZstKpFewbzBEm+m2z2WTTJ1di+4n8vEcmQSJdI2TScTc4cLRuQ9AcZl+Sr0
	 xUQln4bcY8NggbI34jnPCbEJT45OAC8O6OIVSuaq9F1QO6OvXDMlv11HHnlzJmM4Ps
	 Gqi8TSADd/wC6TAgEVnVR2RGVPrstm4bBBxW3gfbF9fl1vB6/r+ecLw4uODY/pptrQ
	 NQdjzV6q00O4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/59] perf evlist: Add reference count
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-11-irogers@google.com>
References: <20260425224951.174663-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:17:07 +0000
Message-Id: <20260425231707.F2CD0C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Invalid free and heap corruption during garbage collection of Pyth=
on evlist objects.
- [High] Semantic breakage of `evlist[i]` and potential heap corruption via=
 `evsel__clone()`.
--

commit e33440fbca0408414cb97b8a9d0bb28896b24bf7
Author: Ian Rogers <irogers@google.com>

perf evlist: Add reference count

This commit introduces reference counting for struct evlist to aid in
lifecycle management, especially for the Python bindings. It replaces
evlist__delete() with evlist__put(), which decrements the reference
count and cleans up the object when the count drops to zero.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -1285,15 +1285,22 @@ static int pyrf_evlist__init(struct pyrf_evlist *=
pevlist,
[ ... ]
>  static void pyrf_evlist__delete(struct pyrf_evlist *pevlist)
>  {
> -	evlist__exit(&pevlist->evlist);
> +	evlist__put(pevlist->evlist);
>  	Py_TYPE(pevlist)->tp_free((PyObject*)pevlist);
>  }

Can this lead to an invalid free during garbage collection?

When evlist__put() drops the reference count to zero, it calls
evlist__purge(), which iterates over the events and calls
evsel__delete(). evsel__delete() unconditionally calls free(evsel).

However, for events added via the Python API (evlist.add()), the evsel
pointer passed to the C evlist is an interior pointer embedded directly
within the Python pyrf_evsel object (set up via
evsel =3D &((struct pyrf_evsel *)pevsel)->evsel;). Calling free() on this
interior pointer would cause heap corruption.

I notice this issue is resolved in a subsequent commit "perf evsel: Add
reference count", which dynamically allocates evsel and implements proper
reference counting.

[ ... ]
> @@ -1786,7 +1793,23 @@ static Py_ssize_t pyrf_evlist__length(PyObject *ob=
j)
>  {
[ ... ]
> +static PyObject *pyrf_evsel__from_evsel(struct evsel *evsel)
> +{
> +	struct pyrf_evsel *pevsel =3D PyObject_New(struct pyrf_evsel, &pyrf_evs=
el__type);
> +
> +	if (!pevsel)
> +		return NULL;
> +
> +	memset(&pevsel->evsel, 0, sizeof(pevsel->evsel));
> +	evsel__init(&pevsel->evsel, &evsel->core.attr, evsel->core.idx);
> +
> +	evsel__clone(&pevsel->evsel, evsel);
> +	if (evsel__is_group_leader(evsel))
> +		evsel__set_leader(&pevsel->evsel, &pevsel->evsel);
> +	return (PyObject *)pevsel;
>  }
> =20
>  static PyObject *pyrf_evlist__item(PyObject *obj, Py_ssize_t i)
> @@ -1794,17 +1817,16 @@ static PyObject *pyrf_evlist__item(PyObject *obj,=
 Py_ssize_t i)
>  	struct pyrf_evlist *pevlist =3D (void *)obj;
>  	struct evsel *pos;
> =20
> -	if (i >=3D pevlist->evlist.core.nr_entries) {
> +	if (i >=3D pevlist->evlist->core.nr_entries) {
>  		PyErr_SetString(PyExc_IndexError, "Index out of range");
>  		return NULL;
>  	}
> =20
> -	evlist__for_each_entry(&pevlist->evlist, pos) {
> +	evlist__for_each_entry(pevlist->evlist, pos) {
>  		if (i-- =3D=3D 0)
>  			break;
>  	}
> -
> -	return Py_BuildValue("O", container_of(pos, struct pyrf_evsel, evsel));
> +	return pyrf_evsel__from_evsel(pos);
>  }

Does returning a clone of the evsel instead of the original object break
the semantics of evlist[i]?

Python scripts that rely on retrieving and modifying an event inside an
evlist (for example, evsel =3D evlist[0]; evsel.sample_freq =3D 100) will n=
ow
modify the ephemeral clone, leaving the original event untouched.

Additionally, if evsel__clone() fails internally, its error path calls
evsel__delete(dest) on the provided pointer. Since dest here points to
the interior evsel embedded in the Python object, this would trigger an
invalid free and corrupt the heap.

This semantic breakage and heap corruption issue is also fixed in the
subsequent commit "perf evsel: Add reference count", which removes this
cloning workaround.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D10
