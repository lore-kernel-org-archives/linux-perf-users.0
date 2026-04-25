Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA24288AD
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777158976; cv=none; b=COe8QFegGEPXcQh3Ue3KhAWnG2wE4bu3QDQMm4KkMn5G0DE5/bstN4XL3VnHyxH1JDxhZzVW2pP5lzBWUxfgtBOU+lJ/n/BpJX3Qb1o/s6UQsfKoqxBZ7mDNGSr17X4OPLH2p/7zJoTFqYWtou2lwWdZu6cM6NmFtO+x4AWZG2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777158976; c=relaxed/simple;
	bh=AqiNcZRK3auhd6RhW+8OfBhF/otXq1FMTHlZeHlGJgw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mqAOC0/nBi1wSgqO4VVfdrT4Q+ZuujbSBRy3SW07tSSGQlDVRmxK28YdHrmv5TGPiM7oENLqPyVgjBJSMIL9xMd2E0O5OL3SeTXydZugdZrV+DUKErLfYqcxJPbJtSSao/AN8BAi50A2AccTnPP+29aQMC0p44+8N2GNznVYbKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nj7L/KBj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nj7L/KBj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15B1C2BCB0;
	Sat, 25 Apr 2026 23:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777158975;
	bh=AqiNcZRK3auhd6RhW+8OfBhF/otXq1FMTHlZeHlGJgw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=nj7L/KBjhik3u7texZpFUE3K/9vSo7YE9fAJAOSWq5eXQYQ4PDf7RSMEBKMz73yPy
	 fgnB9p10Ubs/4CO9ATW13DIEOTe6/xKgGN2AG4PNiuhBTxnrXUyx6HhYCvtzv35k0J
	 wp7rRncoXxMvCT41N6xH/2JOLvl8OkuZeHI7FXCRnSWeGIqr6+PJidp2CHzt+ZXNt+
	 2JYUW87AyydrascVrvHXkJQpWNoUgGIrToZaTkww0dC94oqSjzQz9T1TV6YcNN22CU
	 xWvVa8yi+eFBu/NTVux5trdq35GwKMXxrCg3EMqJgcKxnQSA/gtaXk8PDiCbZ7nv0I
	 rTulvfpie1neA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 18/59] perf python: Add callchain support
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-19-irogers@google.com>
References: <20260425224951.174663-19-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:16:15 +0000
Message-Id: <20260425231615.A15B1C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [High] A strong reference cycle between `pyrf_event` and `pyrf_callchain`=
 causes a massive memory leak for every parsed event with a callchain.
- [High] Missing `addr_location__exit(&al)` cleanup when `machine__resolve(=
)` fails, leading to reference leaks.
- [Medium] Callchain frames are unconditionally resolved eagerly, contradic=
ting the commit message's claim of lazy iteration and introducing significa=
nt performance overhead.
- [Medium] The `callchain` property returns an exhaustible iterator rather =
than a reusable iterable, violating expected property semantics and causing=
 silent data loss on subsequent accesses.
--

commit b62d05aa15240820653407b6e4ce71632cf3899c
Author: Ian Rogers <irogers@google.com>

perf python: Add callchain support

This commit adds python bindings for callchain iteration in perf scripts.
It introduces pyrf_callchain_node and pyrf_callchain types and adds a
callchain property to sample events.

> Implement pyrf_callchain_node and pyrf_callchain types for lazy
> iteration over callchain frames. Add callchain property to
> sample_event.

Does this actually provide lazy iteration?=20

The pyrf_event__new() implementation unconditionally performs the
machine__resolve() and thread__resolve_callchain() operations, allocating
all frames upfront whenever an event has callchain data.

This eager execution appears to make the lazy evaluation fallback logic in
pyrf_callchain__next() unreachable.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 824cf58645e0..2953c4c8e142 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -635,6 +813,12 @@ pyrf_sample_event__getattro(struct pyrf_event *peven=
t, PyObject *attr_name)
>  }
> =20
>  static PyGetSetDef pyrf_sample_event__getset[] =3D {
> +	{
> +		.name =3D "callchain",
> +		.get =3D pyrf_sample_event__get_callchain,
> +		.set =3D NULL,
> +		.doc =3D "event callchain.",
> +	},

Will this property return an exhaustible iterator rather than a reusable
iterable?

When a script accesses the callchain property, it receives the exact same
pyrf_callchain iterator instance. As the script iterates over it,
pyrf_callchain__next() increments pchain->pos.

Once consumed, pchain->pos is not rewound, so any subsequent iteration
attempts on the same event will silently yield an empty sequence.

[ ... ]
> @@ -896,6 +1089,49 @@ static PyObject *pyrf_event__new(const union perf_e=
vent *event, struct evsel *ev
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

If machine__resolve() partially populates the addr_location structure but
ultimately fails and returns a negative value, is it possible to leak the
thread or map references?

Since addr_location__exit() is only called inside the success block at the
end of this function, the failure path skips the cleanup entirely.

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

Could this create an uncollectable strong reference cycle between the
pyrf_event and pyrf_callchain objects?

The newly created pchain takes a strong reference to pevent here, and later
pevent takes ownership of the callchain:

    pevent->callchain =3D (PyObject *)pchain;

Because neither of these C extension types implement Python cycle garbage
collector hooks, it looks like this cyclic reference will never be broken,
leaking both objects and their dynamically allocated structures on every
parsed sample.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D18
