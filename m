Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64567126F3B
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777140936; cv=none; b=rc/uiG675L609j3piSdFtb6XXDKaoNxb/RJ309/fJl+DNeQkD1EcGOse2hJ+j+Ja+R6ZRu58txnqJVz/TQtOYdGZ2h9sP+aRS5KivDnXFqGTD18Salj/hkbDSnERxOrbFcQtFIn7zsoHWmjB3XcgirkaZvuRLkJy1hktggA/hpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777140936; c=relaxed/simple;
	bh=dh7bu5swxFBbYrsdgi8+iXfu3fz0K+NEEMYtfZI2iqM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iT2cC6tKfszQU+jqZzDU2cD9aBzcj5PEhHxpnkgS6oxlV65NmhtjAy7Kov8bSBYtA1Pbq8Qhsg6KvNY5KfjM11U8uGXJfAbXO98R2TruoHEA6f0FKOKbSwPu2njzbGeAIEvJ60XGqGRWOHdwMXbVgsbgeowYN8kK7X+RE6PWFIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VizUFIf7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VizUFIf7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE534C2BCB0;
	Sat, 25 Apr 2026 18:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777140936;
	bh=dh7bu5swxFBbYrsdgi8+iXfu3fz0K+NEEMYtfZI2iqM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=VizUFIf7sAbwBPYAQd7h8PM6sVZgm5cLCNJ9GYvwXaGJIJ3iOK+oILDkIgcQ2gD+F
	 Twj3dmrRHCpv3ZwhVtOYdmDor9jyl+n3Swnb0b1BOpjJq6rWNkpPWpC0hLj520SyYi
	 /6G1gHyxcWC89aJNSmZVIKxBnwxspRqgAkCszZiQaja3zV3gYiYUbOR4LEmAv6kRmE
	 oFN0AYY339zZOoeNMEvXY4fxb2iDHPrT/OxE2sC14XbHwj+atXsnVmRQ3GEid2XVJr
	 xDEeUOpJTqGc9gnx0Orq06lvH9dyv8lRrEwysHeps1vRDMXMkMlHa95nLl2FQPyzop
	 ZmAl9I9Ol9slA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 18/59] perf python: Add callchain support
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-19-irogers@google.com>
References: <20260425174858.3922152-19-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:15:35 +0000
Message-Id: <20260425181535.EE534C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] Uncollectable reference cycle between pyrf_event and pyrf_callchai=
n causes a massive memory leak.
- [High] API Contract Violation: Returning a valid object while a Python ex=
ception is pending causes a SystemError.
- [Medium] Dead code and massive performance overhead due to unconditional =
eager callchain resolution.
--

commit 7bc74d913363ad9f3cdd6b5c806d339f33ec75b9
Author: Ian Rogers <irogers@google.com>

perf python: Add callchain support
   =20
Implement pyrf_callchain_node and pyrf_callchain types for lazy
iteration over callchain frames. Add callchain property to
sample_event.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c

[ ... ]

> @@ -822,10 +1012,12 @@ static PyTypeObject *pyrf_event__type[] =3D {
>  };
> =20
>  static PyObject *pyrf_event__new(const union perf_event *event, struct e=
vsel *evsel,
> -				 struct perf_session *session __maybe_unused)
> +				 struct perf_session *session)
>  {

[ ... ]

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
> +			if (thread__resolve_callchain(al.thread, cursor, evsel, sample,
> +						      NULL, NULL, PERF_MAX_STACK_DEPTH) =3D=3D 0) {
> +				callchain_cursor_commit(cursor);

The commit message mentions lazy iteration over callchain frames, but this
appears to eagerly call machine__resolve() and thread__resolve_callchain()
for every sample event with a callchain.

Does this make the lazy evaluation logic in pyrf_callchain__next() dead
code, since pchain->resolved is always set to true here?

Also, could this impose a large performance overhead for scripts that
do not access the callchain property?

> +
> +				pchain =3D PyObject_New(struct pyrf_callchain, &pyrf_callchain__type=
);
> +				if (pchain) {

If PyObject_New() fails and returns NULL, the Python C API automatically
sets a MemoryError exception.

Since the code falls through the if block and returns the valid pevent
pointer at the end of the function, does returning a valid object pointer
while an exception indicator is set cause the interpreter to crash with a
SystemError?

Should PyErr_Clear() be called if the intent is to gracefully degrade witho=
ut
a callchain on allocation failure?

> +					pchain->pevent =3D pevent;
> +					Py_INCREF(pevent);
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

Since pchain holds a strong reference to pevent, and pevent holds a strong
reference to pchain, does this create an uncollectable reference cycle?

Neither of these Python extension types appears to implement Python's
cycle-breaking garbage collector (via Py_TPFLAGS_HAVE_GC, tp_traverse,
and tp_clear).

Will this permanently leak the event, the callchain, the frames array,
and the associated map objects when the Python script discards the event?

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D18
