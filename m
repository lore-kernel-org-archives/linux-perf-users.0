Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0D01D5AD4
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777052294; cv=none; b=K7wpeBZ/jT1fIe8MbC9+Zdkj+comXZDz9II86W5s2+vES/ct8JqBFHTOM/uXPoGkPSifp1xG7bIWO5DVqIvqejmBKIb+4lfgNZQqP/O8xJ10XZeBBPKWGDrUrlsDc9z1fTeoOJp6XhIRbnh08LneYIoJVqbBTVpMJqgyfOIE/iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777052294; c=relaxed/simple;
	bh=UpWNZiyPjVDHOjYslAuWXGwF3dA8LE/O1ZUvXcTKwZU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZoaMO1d4sgClCus7xr7xvGNkOvlJn7Cvhs7Bf+DUCffTEtVD/pIkQh0JWLD71LMc/dnf8be/33rNX+Lmt+If59d0uqFqqJUzh9R5/EpPBakQjQ0FPZabmv7KaXwpYrYGGKFw7umy5Khm2/fbvDw1vhNGauyfUE1a9+GPCQYnAGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hV7YMSTG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hV7YMSTG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A73CC19425;
	Fri, 24 Apr 2026 17:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777052293;
	bh=UpWNZiyPjVDHOjYslAuWXGwF3dA8LE/O1ZUvXcTKwZU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=hV7YMSTGGgdIr48H3xp8rgKqdsoSrrztNBxfzWlEUfC9/Go0FEYQQI/nK+qelfCZG
	 /l8pd7uSLNhQxabgHgB/f2G3i3/UQ4L8R5P0Kkq7oGvMDfWUkt0vyEyF8TRiQBbSNi
	 L/g6kRGGiotVLmFCXo2RuW7anI41405paTAEqMEt/6SFqu2JV9+xEXjp3QlrSPs7JT
	 uoC1ORxqvvnEmM06+DJMwYhtd4igH8Qyx5Yr69gTZuZd9ifmHen2tqPZi5+rOqJVNX
	 SpGQXfnxx8s938wm0B5J6ybLMRvzI+qHB/ep11NoOXqVfUe6hC87SP1oW+18NshP0j
	 xgx0/bF3qSmxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 21/58] perf python: Expose brstack in sample event
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-22-irogers@google.com>
References: <20260424164721.2229025-22-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:38:12 +0000
Message-Id: <20260424173813.8A73CC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] Unbreakable reference cycle between `pyrf_event` and `pyrf_branch_=
stack` causes a memory leak on every sample.
- [High] Unhandled Python exception from `PyObject_New` propagates into `Py=
Object_CallFunction`, violating the C-API contract.
- [Medium] The `branch_entry` Python type fails to expose critical fields f=
rom `struct branch_flags`.
--

commit d2aa87cc1645801ae5e1749160678a984b4fb28a
Author: Ian Rogers <irogers@google.com>

perf python: Expose brstack in sample event
   =20
Implement pyrf_branch_entry and pyrf_branch_stack for lazy
iteration over branch stack entries.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index c4f0e01b64f364..b446b1e9cfb646 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -870,6 +874,144 @@ static PyObject *pyrf_sample_event__get_callchain(P=
yObject *self, void *closure
[ ... ]
> +static PyGetSetDef pyrf_branch_entry__getset[] =3D {
> +	{ .name =3D "from_ip",      .get =3D (getter)pyrf_branch_entry__get_fro=
m, },
> +	{ .name =3D "to_ip",        .get =3D (getter)pyrf_branch_entry__get_to,=
 },
> +	{ .name =3D "mispred",   .get =3D (getter)pyrf_branch_entry__get_mispre=
d, },
> +	{ .name =3D "predicted", .get =3D (getter)pyrf_branch_entry__get_predic=
ted, },
> +	{ .name =3D "in_tx",     .get =3D (getter)pyrf_branch_entry__get_in_tx,=
 },
> +	{ .name =3D "abort",     .get =3D (getter)pyrf_branch_entry__get_abort,=
 },
> +	{ .name =3D "cycles",    .get =3D (getter)pyrf_branch_entry__get_cycles=
, },
> +	{ .name =3D "type",      .get =3D (getter)pyrf_branch_entry__get_type, =
},
> +	{ .name =3D NULL, },
> +};

This isn't a bug, but struct branch_flags contains additional fields like
spec, new_type, priv, and not_taken. Are these intentionally omitted, or
should they be exposed to match the data available to native perf scripts?

[ ... ]
> @@ -3160,6 +3315,28 @@ static int pyrf_session_tool__sample(const struct =
perf_tool *tool,
>  		}
>  	}
> =20
> +	if (sample->branch_stack) {
> +		struct branch_stack *bs =3D sample->branch_stack;
> +		struct branch_entry *entries =3D perf_sample__branch_entries(sample);
> +		struct pyrf_branch_stack *pstack;
> +
> +		pstack =3D PyObject_New(struct pyrf_branch_stack, &pyrf_branch_stack__=
type);

If PyObject_New() fails and returns NULL, the Python MemoryError exception
indicator is set. Since the code skips the block below and falls through to
PyObject_CallFunction() with this exception still pending, could this viola=
te
the C-API contract and trigger a fatal assertion failure in the Python
runtime?

> +		if (pstack) {
> +			Py_INCREF(pevent);
> +			pstack->pevent =3D pevent;

Will this create an unbreakable reference cycle?

pstack takes a reference to pevent here, and then pevent takes ownership of
pstack below via pevent->brstack =3D (PyObject *)pstack. Because neither
pyrf_sample_event__type nor pyrf_branch_stack__type implement the Python
cyclic garbage collection protocol (Py_TPFLAGS_HAVE_GC), the cycle is hidden
from the garbage collector.

Would this cause both objects, along with the dynamically allocated
pstack->entries, to leak on every sample that has a branch stack?

Also, since the branch entries are eagerly copied into pstack->entries belo=
w,
does pstack actually need to keep a reference to pevent?

> +			pstack->pos =3D 0;
> +			pstack->nr =3D bs->nr;
> +			pstack->entries =3D calloc(bs->nr, sizeof(struct branch_entry));
> +			if (pstack->entries) {
> +				memcpy(pstack->entries, entries,
> +				       bs->nr * sizeof(struct branch_entry));
> +				pevent->brstack =3D (PyObject *)pstack;
> +			} else {
> +				Py_DECREF(pstack);
> +			}
> +		}
> +	}
> +
>  	ret =3D PyObject_CallFunction(psession->sample, "O", pyevent);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D21
