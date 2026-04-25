Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D8D36682A
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777140700; cv=none; b=qIvih+dcPnc34aDt57rR9Gk8OQHRDPZrSkX7eZzCGc9E8+d4S/rtWrE0+WvmbBwxKcUE1fnAeKl8NqNGXMFGVuKHYDDuZBKrkpVKCj70Q+uXlEJVANSy1XSKvMpQI4F7o7cOLUS/gHCBhQjae734O8JHqSHv5BY434/FctjCF4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777140700; c=relaxed/simple;
	bh=DTebHjeVKbmowPczD08ijirx/SWxFnCwGfMh9Ic5b1o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Rl4oVaVyldtq/yr7xOS1zPOrl+ig72udLHgiP0iJcbJqUjDRQhvnKgqdDSoPF3tDd7M+YWNt+8eDGvrfzSq+W+1K6AZFeOZlG+S9yE5fv6LDbVlwlv4vluuaNikcdfD4vOyNIq/LkHWqR1Pa9PGaz3rNywUwg2gzANIhLPbUrjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/IVV3Xd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/IVV3Xd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30CC6C2BCB0;
	Sat, 25 Apr 2026 18:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777140700;
	bh=DTebHjeVKbmowPczD08ijirx/SWxFnCwGfMh9Ic5b1o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=b/IVV3Xdv+jrzJbIE6EWsagrmpdlT5/g4nGc/xMnWIs7jnvyxQ1LybmiyeadOf4ap
	 Rj+R6Q8t9ICZpzk365FixgIrgd59Co5PUIhIQBhV5gNb/34tazeDkV+nus3vvw02Fx
	 d1rcYLljD/65HAHGQlqwar/Dcl8EMfhk7Ti1VJ8+5xHH/0NW5fiYd/I+cb/jCPH0WL
	 ZjDJOzioSheUSxApkA93XZ1AOHE665vCyLg9uV3LXIyrf7fpYhuk2qcC79JZVODnGo
	 hnOw7D710Q2Zub9hd52jU1mf1NrkXfHV7NowZpJF58/GzEEsGNV1WgWm2zmKrLyEri
	 kUYdGnrNU8BhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 21/59] perf python: Expose brstack in sample event
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-22-irogers@google.com>
References: <20260425174858.3922152-22-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:11:39 +0000
Message-Id: <20260425181140.30CC6C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Unbreakable reference cycle between `pyrf_event` and `pyrf_branch_=
stack` causes a severe memory leak.
- [Medium] The `brstack` property returns a stateful, single-use iterator, =
causing unexpected exhaustion on subsequent accesses.
--

commit ef363ec34c32fba7451b2ff51e897d5e1d90b521
Author: Ian Rogers <irogers@google.com>

    perf python: Expose brstack in sample event
   =20
    Implement pyrf_branch_entry and pyrf_branch_stack for lazy
    iteration over branch stack entries.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 37764a287a71..228c1c628bf4 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c

[ ... ]

> @@ -870,6 +874,144 @@ static PyObject *pyrf_sample_event__get_callchain(P=
yObject *self, void *closure
>  	return pevent->callchain;
>  }
> =20

[ ... ]

> +struct pyrf_branch_stack {
> +	PyObject_HEAD
> +	struct pyrf_event *pevent;
> +	struct branch_entry *entries;
> +	u64 nr;
> +	u64 pos;
> +};
> +

[ ... ]

> +static PyObject *pyrf_branch_stack__next(struct pyrf_branch_stack *pstac=
k)
> +{
> +	struct pyrf_branch_entry *pentry;
> +
> +	if (pstack->pos >=3D pstack->nr)
> +		return NULL;

[ ... ]

> +	pstack->pos++;
> +	return (PyObject *)pentry;
> +}
> +
> +static PyTypeObject pyrf_branch_stack__type =3D {
> +	PyVarObject_HEAD_INIT(NULL, 0)
> +	.tp_name	=3D "perf.branch_stack",
> +	.tp_basicsize	=3D sizeof(struct pyrf_branch_stack),
> +	.tp_dealloc	=3D (destructor)pyrf_branch_stack__delete,
> +	.tp_flags	=3D Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
> +	.tp_doc		=3D "perf branch stack object.",
> +	.tp_iter	=3D PyObject_SelfIter,
> +	.tp_iternext	=3D (iternextfunc)pyrf_branch_stack__next,
> +};
> +
> +static PyObject *pyrf_sample_event__get_brstack(PyObject *self, void *cl=
osure __maybe_unused)
> +{
> +	struct pyrf_event *pevent =3D (void *)self;
> +
> +	if (!pevent->brstack)
> +		Py_RETURN_NONE;
> +
> +	Py_INCREF(pevent->brstack);
> +	return pevent->brstack;
> +}

This property returns the same pyrf_branch_stack object on every access. Si=
nce
pyrf_branch_stack is a stateful iterator that modifies pstack->pos, will
accessing event.brstack a second time return an exhausted iterator yielding
zero elements?

[ ... ]

> @@ -1180,6 +1335,27 @@ static PyObject *pyrf_event__new(const union perf_=
event *event, struct evsel *ev
>  			addr_location__exit(&al);
>  		}
>  	}
> +	if (sample->branch_stack) {
> +		struct branch_stack *bs =3D sample->branch_stack;
> +		struct branch_entry *entries =3D perf_sample__branch_entries(sample);
> +		struct pyrf_branch_stack *pstack;
> +
> +		pstack =3D PyObject_New(struct pyrf_branch_stack, &pyrf_branch_stack__=
type);
> +		if (pstack) {
> +			Py_INCREF(pevent);
> +			pstack->pevent =3D pevent;
> +			pstack->pos =3D 0;
> +			pstack->nr =3D bs->nr;
> +			pstack->entries =3D calloc(bs->nr, sizeof(struct branch_entry));
> +			if (pstack->entries) {
> +				memcpy(pstack->entries, entries,
> +				       bs->nr * sizeof(struct branch_entry));
> +				pevent->brstack =3D (PyObject *)pstack;

Does setting pstack->pevent =3D pevent and pevent->brstack =3D pstack creat=
e an
unbreakable reference cycle?

Since neither pyrf_event nor pyrf_branch_stack implement Python's cyclic
garbage collection interface, Python's GC won't be able to detect or break
this cycle.

When the external references to the event are dropped, won't this permanent=
ly
leak the event, the branch stack, and the pstack->entries array for every
processed sample?

Is the pstack->pevent reference needed, given that pstack->entries is an
independent copy and pstack->pevent appears unused during iteration?

> +			} else {
> +				Py_DECREF(pstack);
> +			}
> +		}
> +	}
>  	return (PyObject *)pevent;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D21
