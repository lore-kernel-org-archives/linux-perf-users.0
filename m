Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175AD37DAA8
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779489313; cv=none; b=FMNdc/+xvxBTCFu43ip/gvrhor7aa9fAUbCpviNgexF1i/d8fJgy5Zq3ZI/ZSBaF0hSRBCOiXPKXx739VxVc6ctDfyYGyG6Xz5aFEImH074EM8MxtJs+KQqOt9ZZKGf+MF7UUGBTex9j4XnI3jhSPA5dzE2VGbsDHqHlxGripsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779489313; c=relaxed/simple;
	bh=5wStwq5Eu2ZRvrExPk0XyE3BmUpUSLzGHl/N9qvywak=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qiYBCLuf3HcOMeZzP5sVwyDKiWiX7GA1a/0depC/ml6HEATKPAH4pMisChcJgmrP041xf1qOQGLALokjJxLtqmpiG3cINt2MRxSL2svmET0aEalbfeYKLzce+46ywWlyWSTThO8JrOv41uq4ytxhuQs2F47wrwMH/KgcyW96cZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyDqyZF6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyDqyZF6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9847A1F000E9;
	Fri, 22 May 2026 22:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779489311;
	bh=aGqV6kz2/875qnZ84wcdVqjclps8P4oE7gAgZxzLORE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LyDqyZF6sgAovKgaF3Bnqn5HW3u98ZI5qdu8+CX12+yVTyBHABt0cXoR4qez/jc5Y
	 vvDoQaao8daPEvg0NDbhRSZRoSWsvUzWyljGapbXS12J1fRpp3OkhENoK2t7+uPSDk
	 ba2Z/ejIMI3PCqPD3NiI2xYgMySp2ryjtc7dsFmQfRHVFacsAuqyaoxblKqDUC68XD
	 9Xaezaj7Dz8dKh9aVl+hyAjMiYm7F+ohuwqMn3xX09lEJIPaxqXzNh38qwSAVg/Gyt
	 hC6JgLv6YhTd/m9gWYH2qdF0lM1r51vnddqBCoLwBiZ5aNHO6g3HBS6zSAOmFGtqUh
	 ALw2CLvBbJxBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 17/23] perf python: Add callchain support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260522220435.2378363-18-irogers@google.com>
References: <20260522220435.2378363-18-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 22:35:10 +0000
Message-Id: <20260522223511.9847A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] A circular reference between `pyrf_event` and `pyrf_callchain` cre=
ates a permanent memory leak for every processed event containing a callcha=
in.
- [Medium] Eager callchain resolution contradicts the 'lazy iteration' desi=
gn, causing severe parsing overhead and leaving behind dead code.
- [Medium] The `.callchain` property returns an exhaustible iterator instea=
d of a repeatable iterable, causing silent failures on subsequent accesses.
--

commit 2ae22d7a748138d318f9939992a43e386f407964
Author: Ian Rogers <irogers@google.com>

perf python: Add callchain support

This commit adds support for callchains to the perf Python extension,
introducing new types for callchains and nodes, and appending a
callchain property to sample events.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index daedd67f12d58..de7a513895728 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c

[ ... ]

> @@ -669,6 +672,181 @@ static PyObject *pyrf_sample_event__insn(PyObject *=
self, PyObject *args __maybe_

[ ... ]

> +static PyObject *pyrf_callchain__next(struct pyrf_callchain *pchain)
> +{
> +	struct pyrf_callchain_node *pnode;
> +
> +	if (!pchain->resolved) {
> +		struct evsel *evsel =3D pchain->pevent->sample.evsel;
> +		struct evlist *evlist =3D evsel->evlist;

[Severity: Medium]
The commit message states this implements "lazy iteration over callchain
frames", but is this block ever executed?

Since thread__resolve_callchain() is called eagerly during pyrf_event__new(=
),
pchain->resolved is always true here. This seems to defeat the lazy
resolution and leaves this block as unused dead code.

Does this also force heavy symbol resolution on all events immediately upon
creation, even if the Python script doesn't access the callchain property?

> +		struct perf_session *session =3D evlist ? evlist__session(evlist) : NU=
LL;
> +		struct addr_location al;
> +		struct callchain_cursor *cursor;

[ ... ]

> +		pchain->resolved =3D true;
> +		addr_location__exit(&al);
> +	}
> +
> +	if (pchain->pos >=3D pchain->nr_frames)
> +		return NULL;
> +
> +	pnode =3D PyObject_New(struct pyrf_callchain_node, &pyrf_callchain_node=
__type);
> +	if (!pnode)
> +		return NULL;
> +
> +	pnode->ip =3D pchain->frames[pchain->pos].ip;
> +	pnode->map =3D map__get(pchain->frames[pchain->pos].map);
> +	pnode->sym =3D pchain->frames[pchain->pos].sym;
> +
> +	pchain->pos++;

[Severity: Medium]
Does returning an exhaustible iterator from the property cause issues on
subsequent accesses?

Because the .callchain property caches this single iterator instance and
pyrf_callchain__next() increments pchain->pos without any reset mechanism,
the iterator will be permanently exhausted on the first pass.

Will subsequent attempts to iterate over event.callchain silently yield
zero elements instead of repeating the iteration?

> +	return (PyObject *)pnode;
> +}

[ ... ]

> @@ -1046,6 +1239,49 @@ static PyObject *pyrf_event__new(const union perf_=
event *event, struct evsel *ev
>  		return PyErr_Format(PyExc_OSError,
>  				    "perf: can't parse sample, err=3D%d", err);
>  	}
> +	sample =3D &pevent->sample;
> +	if (machine && sample->callchain) {
> +		struct addr_location al;
> +		struct callchain_cursor *cursor;
> +		u64 i;
> +		struct pyrf_callchain *pchain;
> +
> +		addr_location__init(&al);
> +		if (machine__resolve(machine, &al, sample) >=3D 0) {
> +			cursor =3D get_tls_callchain_cursor();
> +			if (thread__resolve_callchain(al.thread, cursor, sample,
> +						      NULL, NULL, PERF_MAX_STACK_DEPTH) =3D=3D 0) {
> +				callchain_cursor_commit(cursor);
> +
> +				pchain =3D PyObject_New(struct pyrf_callchain, &pyrf_callchain__type=
);
> +				if (pchain) {
> +					pchain->pevent =3D pevent;
> +					Py_INCREF(pevent);

[Severity: High]
Does this create a circular reference that leaks memory?

The pchain object holds a strong reference to pevent via Py_INCREF, and
then pevent takes ownership of pchain by storing it in pevent->callchain
below.

Since neither pyrf_event__type nor pyrf_callchain__type implement Python's
garbage collector traversal functions (tp_traverse, tp_clear), this cycle
is invisible to the GC. When processing large files, will this permanently
leak the event object, the callchain object, and all associated kernel map
references for every event with a callchain?

> +					pchain->nr_frames =3D cursor->nr;
> +					pchain->pos =3D 0;
> +					pchain->resolved =3D true;
> +					pchain->frames =3D calloc(pchain->nr_frames,
> +								sizeof(*pchain->frames));
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
>  	return (PyObject *)pevent;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522220435.2378=
363-1-irogers@google.com?part=3D17
