Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FFC1D5AD4
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777052325; cv=none; b=dqIy/B+3PfXlfum8LSPBCQh3I8tmuzanoIfBNxP60rNA+ew8TauVxILINpWfCqN7CoUyyyJrE1M3GwURK2IXl99il9eULM+xDYWcsUHfl9sUU+E1IDL/rk66Unn4ZaF9I5PrR0u01VGCHsmdgsSd55948M5TQu5EqKz32zryDDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777052325; c=relaxed/simple;
	bh=jKWTn0NackSdKOxBEJwAEOq3J1QIelpFApqFVA1hvw0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jQReJ61gsqCoyVziOEW1dPKMGz4rzKb/R9Ip17EYzLCPH+8vpqQLsi5GXx8eTBKsHHan3efPo/y4Scqwdgs5zNlfMfYIgRWkDGqMjCUf6jbq7b5roKqRnz5j5ajERYK3RX1GgcHMaT9yZHpd3i1LG/ZX3/d2p6VD7vcVmv9EGuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPqJsF/F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPqJsF/F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BF9C19425;
	Fri, 24 Apr 2026 17:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777052324;
	bh=jKWTn0NackSdKOxBEJwAEOq3J1QIelpFApqFVA1hvw0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=EPqJsF/FypaoG4fgAGnLcwAJeFQfEzUmbofouhlVd5+btwHkG/0KM0sr7LzTi6afY
	 B+bVXBuhQh6K+Z4VfUjw06L9pXRAOUB+JmXpaZFAdslWPcFrq8GKz9+WB1TWu0ZInJ
	 IbEH1Jn20faabj7bdZ9rmc59fKoKfty53l/Ib2EVrctPVeEZR36p4EpPScgSfkl0L+
	 cYLw4DCxNN1DJ1VmmMHQCh43KCnWawcEOEoOSdyHj5lce1lf4mXdNWZibPDvbkbJDi
	 pld51q5wIVrLoAK0Vc7dI9gP6tI2YsdBjv6Q4RZUGb+dCSgBLVFsqNAM+gknCqZ9Hw
	 IRrbd92Sl4ReQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 18/58] perf python: Add callchain support
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-19-irogers@google.com>
References: <20260424164721.2229025-19-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:38:44 +0000
Message-Id: <20260424173844.C0BF9C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [Critical] Uninitialized memory in `pyrf_event__new()` causes a crash whe=
n handling errors.
- [High] Circular reference between `pyrf_event` and `pyrf_callchain` cause=
s a severe memory leak.
- [High] Eager callchain resolution contradicts 'lazy iteration' design, ca=
using massive performance overhead and leaving dangerous unreachable code.
- [Medium] Unconditional execution of `calloc(0, ...)` leads to inconsisten=
t Python API behavior across different C standard libraries.
--

commit 2f0296d6bbd37fb6c259d5c8248fe058c10c6b5a
Author: Ian Rogers <irogers@google.com>

perf python: Add callchain support

Implement pyrf_callchain_node and pyrf_callchain types for lazy
iteration over callchain frames. Add callchain property to
sample_event.

> Implement pyrf_callchain_node and pyrf_callchain types for lazy
> iteration over callchain frames. Add callchain property to

The commit message states this implements lazy iteration, but the code appe=
ars
to unconditionally and eagerly resolve the callchain for every processed sa=
mple.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 63ee9bc65721bb..28961ad47010c6 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -621,6 +624,181 @@ static PyObject *pyrf_sample_event__insn(PyObject *=
self, PyObject *args __maybe_
>  					 pevent->sample.insn_len);
>  }
> =20
[ ... ]
> +static PyObject *pyrf_callchain__next(struct pyrf_callchain *pchain)
> +{
> +	struct pyrf_callchain_node *pnode;
> +
> +	if (!pchain->resolved) {
> +		struct evsel *evsel =3D pchain->pevent->sample.evsel;
> +		struct evlist *evlist =3D evsel->evlist;
> +		struct perf_session *session =3D evlist ? evlist__session(evlist) : NU=
LL;
> +		struct addr_location al;
> +		struct callchain_cursor *cursor;
> +		struct callchain_cursor_node *node;
> +		u64 i;

Since pchain->resolved is hardcoded to true upon creation in
pyrf_session_tool__sample(), is this entire block unreachable dead code?

Additionally, if this were to be reached, would accessing
pchain->pevent->sample.evsel without holding an active reference to the
underlying perf_session risk a use-after-free?

[ ... ]
> @@ -848,6 +1038,7 @@ static PyObject *pyrf_event__new(const union perf_ev=
ent *event)
>  	if (pevent !=3D NULL) {
>  		memcpy(&pevent->event, event, event->header.size);
>  		pevent->sample.evsel =3D NULL;
> +		pevent->callchain =3D NULL;
>  		pevent->al_resolved =3D false;
>  		addr_location__init(&pevent->al);
>  	}

This isn't a bug introduced by this patch, but since pevent is allocated wi=
th
PyObject_New(), wouldn't pevent->sample be left uninitialized?

If an error occurs later and Py_DECREF(pyevent) is called, pyrf_event__dele=
te()
will call perf_sample__exit(&pevent->sample) on uninitialized garbage point=
ers,
which could cause a segmentation fault.

Should pevent->sample be explicitly zero-initialized during creation?

[ ... ]
> @@ -2810,6 +3001,49 @@ static int pyrf_session_tool__sample(const struct =
perf_tool *tool,
>  	if (pevent->sample.merged_callchain)
>  		pevent->sample.callchain =3D NULL;
> =20
> +	if (sample->callchain) {
> +		struct addr_location al;
> +		struct callchain_cursor *cursor;
> +		u64 i;
> +		struct pyrf_callchain *pchain;
> +
> +		addr_location__init(&al);
> +		if (machine__resolve(&psession->session->machines.host, &al, sample) >=
=3D 0) {
> +			cursor =3D get_tls_callchain_cursor();
> +			if (thread__resolve_callchain(al.thread, cursor, evsel, sample,
> +						      NULL, NULL, PERF_MAX_STACK_DEPTH) =3D=3D 0) {
> +				callchain_cursor_commit(cursor);
> +
> +				pchain =3D PyObject_New(struct pyrf_callchain, &pyrf_callchain__type=
);
> +				if (pchain) {
> +					pchain->pevent =3D pevent;
> +					Py_INCREF(pevent);

Doesn't this create a circular reference? The pchain object stores a strong
reference to the event here, and below, the event stores a reference to the
callchain.

Since neither pyrf_event__type nor pyrf_callchain__type implements the Pyth=
on
cyclic garbage collector protocols, will this permanently leak both the eve=
nt
and the callchain objects (along with all mapped C structures) on every
processed sample?

> +					pchain->nr_frames =3D cursor->nr;
> +					pchain->pos =3D 0;
> +					pchain->resolved =3D true;
> +					pchain->frames =3D calloc(pchain->nr_frames,
> +								sizeof(*pchain->frames));

If cursor->nr is 0, this calls calloc(0, ...). Since the behavior of calloc=
(0)
is implementation-defined, couldn't this return NULL on some systems (treat=
ing
it as an allocation failure) and a unique zero-sized pointer on others?

Will this cause the exact same perf.data file to unpredictably yield either
None or an empty iterable depending on the host's C library?

> +					if (pchain->frames) {
> +						struct callchain_cursor_node *node;
> +
> +						for (i =3D 0; i < pchain->nr_frames; i++) {
> +							node =3D callchain_cursor_current(cursor);
> +							pchain->frames[i].ip =3D node->ip;
> +							pchain->frames[i].map =3D
> +								map__get(node->ms.map);
> +							pchain->frames[i].sym =3D node->ms.sym;
> +							callchain_cursor_advance(cursor);
> +						}
> +						pevent->callchain =3D (PyObject *)pchain;

The event stores the reference to the callchain here, completing the circul=
ar
reference.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D18
