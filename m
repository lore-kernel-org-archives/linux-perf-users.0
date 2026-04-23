Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16EA14EC73
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 04:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917978; cv=none; b=e3E1nMG7tEjHJl0/xgN+vTHms+dUQsl/H74EkUm5IwOjxgIDnjz7YKPpFl08M34isNNGVpel+gCtOaWnYQx7JBPhrfURTBxU1zR3RJKFE1ju77m8kUItf64bW0Yg0oMkF6yiySn7tR5AkSn2ZBI+Fq9NMO4fTPkKmy+Yn6bOftc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917978; c=relaxed/simple;
	bh=MfTbZw0TgzhPwqIzKPyPi6wa0h3W5RwbPNfAupzXsD4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pxRiwUvASXohAy1+KIZaUOgsOv61hCfQKgEnleU0XkophrFuaoWMJQA+RIX7KP5AUFX+K1U/cEcEW/CheWF+zoaIcvDTCugGBVo4EAQ6/ajSMXyHIbEE8MXXKdsIJ9FQQ7kruz49K1wnWehQh/hBEc1Zt/lbhhymRwN1ggEyahY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EA3TU7o4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EA3TU7o4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4077CC2BCB2;
	Thu, 23 Apr 2026 04:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917978;
	bh=MfTbZw0TgzhPwqIzKPyPi6wa0h3W5RwbPNfAupzXsD4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=EA3TU7o4B1rJvXti8QtDMuw+GbwXgxd0PnSm5lpf6hDmglaizSoNnj7RGRr3Fm7lK
	 h8FyTEtAstqqcgWfoaG7/YyYIU+2Uft6TtVyZTohu554UxFwwxV37EYJf0F5oHtF1H
	 hGiFuYGBvI6otnzl5AyFA4GxTsnrAopJf1NbhbvBlyebrVanqUgEYdw6F+Rk9TKp8L
	 SH4nLcqQ772JSGD8DKlfsUYmDZCTXL3wj4QWuLbEcYmiPBkA/RPBxAjmh6e83yjSb7
	 ZgZjH0/ejG8fXjYOVbSrjzvFpM1TSs226Wzw98Vbbcd0P3pjt/3NL9LlDYpglEPDve
	 qpA9uXtmh9r5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 18/58] perf python: Add callchain support
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-19-irogers@google.com>
References: <20260423035526.1537178-19-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 04:19:37 +0000
Message-Id: <20260423041938.4077CC2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] Unbreakable reference cycle between pyrf_event and pyrf_callchain =
causes a severe memory leak.
- [Medium] Leftover deferred resolution block in pyrf_callchain__next() is =
unreachable dead code.
- [Medium] Implementation-defined behavior when resolving a callchain with =
0 frames.
--

commit 73aebb639c981fd42b85740cef6e54f7fa723e79
Author: Ian Rogers <irogers@google.com>

perf python: Add callchain support

This commit implements pyrf_callchain_node and pyrf_callchain types for lazy
iteration over callchain frames. It also adds a callchain property to
sample_event to expose this information to Python scripts.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 3e0534744f0a2..ebbb10c0efeb8 100644
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

Is this deferred resolution block reachable?

It appears that pchain->resolved is unconditionally set to true when the
callchain is eagerly resolved in pyrf_session_tool__sample(). Since the
pyrf_callchain__type does not define a tp_new function to be instantiated
directly from Python, it seems this condition will never be met, making this
dead code.

> +		struct evsel *evsel =3D pchain->pevent->sample.evsel;
> +		struct evlist *evlist =3D evsel->evlist;
> +		struct perf_session *session =3D evlist ? evlist__session(evlist) : NU=
LL;
> +		struct addr_location al;
> +		struct callchain_cursor *cursor;
> +		struct callchain_cursor_node *node;
> +		u64 i;
> +
> +		if (!session || !pchain->pevent->sample.callchain)
> +			return NULL;
> +
> +		addr_location__init(&al);
> +		if (machine__resolve(&session->machines.host, &al, &pchain->pevent->sa=
mple) < 0) {
> +			addr_location__exit(&al);
> +			return NULL;
> +		}
> +
> +		cursor =3D get_tls_callchain_cursor();
> +		if (thread__resolve_callchain(al.thread, cursor, evsel,
> +					      &pchain->pevent->sample, NULL, NULL,
> +					      PERF_MAX_STACK_DEPTH) !=3D 0) {
> +			addr_location__exit(&al);
> +			return NULL;
> +		}
> +		callchain_cursor_commit(cursor);
> +
> +		pchain->nr_frames =3D cursor->nr;
> +		if (pchain->nr_frames > 0) {
> +			pchain->frames =3D calloc(pchain->nr_frames, sizeof(*pchain->frames));
> +			if (!pchain->frames) {
> +				addr_location__exit(&al);
> +				return PyErr_NoMemory();
> +			}
> +
> +			for (i =3D 0; i < pchain->nr_frames; i++) {
> +				node =3D callchain_cursor_current(cursor);
> +				pchain->frames[i].ip =3D node->ip;
> +				pchain->frames[i].map =3D map__get(node->ms.map);
> +				pchain->frames[i].sym =3D node->ms.sym;
> +				callchain_cursor_advance(cursor);
> +			}
> +		}
> +		pchain->resolved =3D true;
> +		addr_location__exit(&al);
> +	}

[ ... ]

> @@ -2807,6 +2998,49 @@ static int pyrf_session_tool__sample(const struct =
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

Does this create an unbreakable reference cycle?

pchain takes a strong reference to pevent here, and shortly below,
pevent takes ownership of pchain via pevent->callchain =3D (PyObject *)pcha=
in.

Since neither pyrf_event__type nor pyrf_callchain__type implements the
Py_TPFLAGS_HAVE_GC flag and the required tp_traverse/tp_clear callbacks,
the Python garbage collector won't be able to break this circular reference.
Will this cause both objects, the frames buffer, and the map references to
leak for every sample event with a callchain?

> +					pchain->nr_frames =3D cursor->nr;
> +					pchain->pos =3D 0;
> +					pchain->resolved =3D true;
> +					pchain->frames =3D calloc(pchain->nr_frames,
> +								sizeof(*pchain->frames));

What happens when resolving a callchain with 0 frames?

If cursor->nr is 0, we pass 0 to calloc(), which is implementation-defined.
If libc returns NULL (like musl), the subsequent if (pchain->frames) check
will fail, discarding pchain and leaving event.callchain as None.
If libc returns a valid pointer (like glibc), the check passes and
event.callchain becomes an empty iterator.

Could we skip the allocation or handle the 0-frame case explicitly to avoid
inconsistent API behavior across different libc implementations?

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
> +					} else {
> +						Py_DECREF(pchain);
> +					}
> +				}
> +			}
> +			addr_location__exit(&al);
> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D18
