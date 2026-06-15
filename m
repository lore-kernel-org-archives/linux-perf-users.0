Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF551C2AA
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 00:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781484249; cv=none; b=QZZL6IoFyfw6YgtLdxM7i1JMQLQUaCHSKtr6zk2iCyii3wzY/RiP3YvN6yuNtr+TOkfdIEU5Un2yktR/3bo2bTLaBbH0t1haeJ618z4KKFWK+l95rmHSVf2eTdogPcvec9t6bEVXqa5gL/UdWSibSn1PdZTXuz7ms/PjToss7ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781484249; c=relaxed/simple;
	bh=LGxlZ9uhBe5tR1qfpe1R48v9Qgb3I5zx7fTAFMCdUuI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s0od4GfApim0cLgE/5U2cE7k3bazjdro35+gR39byKu+gKEbGZu3n25/WjGoGvcK/NWhH0MkgYVcGCagl7o/bD69XpClSF2jVdhKzrmGgRgbJU7284ZFBtkEWJTpUzfsniKDTM1vWPSk3JLA5sJ1X++Or/4yEDsnvyJ7sqKqxAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeycoDvz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeycoDvz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A469B1F000E9;
	Mon, 15 Jun 2026 00:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781484247;
	bh=K1kAu1oIQRvmxYOwhUlzm4nd+PTtF9+FGL9FESWecGs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EeycoDvznlzB8TpRfIxqPxEqbM0YrTW/RRIN98nWq1txp5SuXRyEEHRxzE5L8F+vB
	 utbRAB4dERSSbxvIfIoaFtesdtcNeZx6g1OBMPu5Ny0MtxufoJRIKZsuiSlu4nyB5l
	 of4RLQX0YNMwdxVNWU+dOpI5vz/h75wrxQBBD8soaSJBG5Nmf4wzp5eZhpLefV8dWl
	 v8YFgoAUv7PTltkwwNsi1qgQ/GygU0YnjpfnUcLtFB0k4cHyYSAQSOIc44l7t7tEkV
	 Oy99N8slx/K81im6wDXMqCTbvWv1HZjZPDUt4wP78unrDI6kr5I/iuPEhTFhdrTax0
	 yMV994ecE42iQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 11/20] perf python: Refactor and add accessors to
 sample event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615002812.2234795-12-irogers@google.com>
References: <20260615002812.2234795-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 00:44:07 +0000
Message-Id: <20260615004407.A469B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Hardcoded host machine for symbol resolution ignores guest machine=
s.
- [Medium] Incomplete implementation of memory allocation optimization for =
events.
--

commit 2346f47e5c0f6f2dccc593b2044f8f61590b6696
Author: Ian Rogers <irogers@google.com>
Subject: perf python: Refactor and add accessors to sample event

This commit refactors Python perf events to include a common evsel field
and moves sample-specific fields into sample events. It adds various
accessors for sample events and attempts to ensure offsets are within
bounds while optimizing memory allocations for copied events.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index d68f7650100b6..6a84cfcc34ea8 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -394,6 +449,199 @@ get_tracepoint_field(struct pyrf_event *pevent, PyO=
bject *attr_name)
>  }
>  #endif /* HAVE_LIBTRACEEVENT */
> =20
> +static int pyrf_sample_event__resolve_al(struct pyrf_event *pevent)
> +{
> +	struct evsel *evsel =3D pevent->sample.evsel;
> +	struct evlist *evlist =3D evsel ? evsel->evlist : NULL;
> +	struct perf_session *session =3D evlist ? evlist__session(evlist) : NUL=
L;
> +
> +	if (pevent->al_resolved)
> +		return 0;
> +
> +	if (!session)
> +		return -1;
> +
> +	addr_location__init(&pevent->al);
> +	if (machine__resolve(&session->machines.host, &pevent->al, &pevent->sam=
ple) < 0) {

[Severity: High]
Does hardcoding the host machine here prevent resolving symbols for KVM gue=
sts?

If the sample originated from a guest, resolving against
session->machines.host instead of the appropriate guest machine seems like
it would either fail or yield incorrect symbols.

When Python scripts lazily access properties like event.symbol or event.dso,
it appears they will fall back to the host machine. Could we use the correct
machine based on the sample instead?

> +		addr_location__exit(&pevent->al);
> +		return -1;
> +	}
> +
> +	pevent->al_resolved =3D true;
> +	return 0;
> +}
[ ... ]
> @@ -511,33 +840,57 @@ static PyTypeObject *pyrf_event__type[] =3D {
>  	[PERF_RECORD_SWITCH_CPU_WIDE]  =3D &pyrf_context_switch_event__type,
>  };
> =20
> -static PyObject *pyrf_event__new(const union perf_event *event)
> +static PyObject *pyrf_event__new(const union perf_event *event, struct e=
vsel *evsel)
>  {
>  	struct pyrf_event *pevent;
[ ... ]
> +	size_t copy_size =3D event->header.size;
> +
> +	if (copy_size > sizeof(pevent->event)) {
> +		return PyErr_Format(PyExc_TypeError, "Unexpected event size: %zd < %zu=
",
> +				    sizeof(pevent->event), copy_size);
> +	}
> +
> +	pevent =3D PyObject_New(struct pyrf_event, pyrf_event__type[event->head=
er.type]);

[Severity: Medium]
The commit message states: "Allocate just enough memory for the copied even=
t,
don't make the maximum event size each time."

Does this implementation actually achieve that memory optimization?

Looking at the type definitions, pyrf_event__type[event->header.type]->tp_b=
asicsize
is set to sizeof(struct pyrf_event) for all event types. Since struct pyrf_=
event
statically embeds union perf_event by value, the allocated size appears to =
still be
the maximum event size.

> +	if (pevent =3D=3D NULL)
> +		return PyErr_NoMemory();
> +
> +	/* Copy the event for memory safety and initialize variables. */
> +	memcpy(&pevent->event, event, copy_size);
> +	if (copy_size < sizeof(pevent->event))
> +		memset((char *)&pevent->event + copy_size, 0, sizeof(pevent->event) - =
copy_size);

Because PyObject_New allocates the full maximum size, this memset just zero=
-fills
the unused tail bytes, rather than allocating a smaller object. Should the
allocation mechanism be adjusted to truly allocate less memory?

> +
> +	perf_sample__init(&pevent->sample, /*all=3D*/true);
> +	pevent->al_resolved =3D false;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615002812.2234=
795-1-irogers@google.com?part=3D11
