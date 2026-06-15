Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4CB4183B4
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 17:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544535; cv=none; b=PTY+6QmZKbVGKtQ2u2F4WjakuJgroeTCV+T1T9FkCfJwEHzDLCBpmkpP/24j+PfnUkil1gZfV8R/veZy7bnOWwhj/OIqKOrkkUuh2sNBahUBDyiVc10JWh5w4zZpqWfNcNq30depr2CuEDtT6AdjUOvrv5W40OL1vD6maTacLGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544535; c=relaxed/simple;
	bh=4K5MHVJ9pqZipLKeUaMD8YXxiOJ0+baC7AsJjyqw2iI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JYacQwLvQ7BzYNdnNWgmFd4QZ61mGSaRa//NafOc/30sgSh4v4he1/1+E5IwIZP9zf/gZxm7w2yUXWpxuBvOYOIljwpOxAF3fwXNeGM+tnerQ9orlYXGd0hJT8F8MreW6KpoktDxBKIK/guzLd13il+DtMKPqmMH+/apwEG3sfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ms0nTUCB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ms0nTUCB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F2C1F000E9;
	Mon, 15 Jun 2026 17:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781544534;
	bh=IFW67/sH8Dj50lW6RrWhVZlmcYx2wCxDcXHEnwpc/Fo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ms0nTUCBbYeFklXAnRFdTMihH6E4oRFKpnr/0rvxn3U95jXqna1MFkoQaEm7OgCsq
	 0NNDGXxOCw3rUOI38P/QB9L4yS0aKSigaDbmI+OqXlxGKmPrFbdl929p9InPd+nJPF
	 pm8rCxcTlxi0nFXGrTQfV9dFLjmYls6SpCLIcdX75b54RLavnTVtkT2IIK7+MRY6ks
	 kXxio/X3KeeIASTBFc6TJnb2BwkF2TLbXhAXav6CN8KRohezZPNE7CiFmlYXfGOZBx
	 EEm71NxS1fZaliJfcvagAn/wQmWgeG40GGkTEHQUR8n1axEKpEx3jhI8E0cKOLHgYX
	 sX/4RcmfjfcpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 11/20] perf python: Refactor and add accessors to
 sample event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615165010.2724690-12-irogers@google.com>
References: <20260615165010.2724690-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 17:28:53 +0000
Message-Id: <20260615172854.04F2C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Use-After-Free in lazy symbol resolution when python event out=
lives session.
- [Medium] Failure to dynamically size memory allocations despite commit me=
ssage claims.
--

commit 793942a7b7e1c4bf7ac632f9e47448f90687784f
Author: Ian Rogers <irogers@google.com>

perf python: Refactor and add accessors to sample event

This commit adds a common evsel field for events and moves sample specific
fields to only be present in sample events. It also attempts to lazily
compute address locations and allocate dynamically sized events.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
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

[Severity: Critical]
Can this result in a use-after-free if the Python script retains the event
but drops the session?

If the script or garbage collector deletes the session object, it directly
calls perf_session__delete() and frees the memory. However, the event
object can outlive the session, keeping the evsel and evlist alive.

When accessing the event's symbol, dso, or srccode later, this function
evaluates session =3D evlist__session(evlist). Since evlist->session is
never NULLed upon session deletion, this yields a dangling pointer and
dereferences it at &session->machines.host.

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
Does this actually allocate just enough memory?

The commit message states:
"Allocate just enough memory for the copied event, don't make the maximum
event size each time."

However, PyObject_New relies on the tp_basicsize of the provided type
object, which is statically defined as sizeof(struct pyrf_event) for all
event types. Is every allocation still statically sized to the maximum size
instead of strictly the required copy_size?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615165010.2724=
690-1-irogers@google.com?part=3D11
