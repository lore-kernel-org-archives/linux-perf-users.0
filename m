Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C18A38F92F
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777159086; cv=none; b=WBfJ2xVONVP7v5k936KaUkdybZv1tKaHEJhmMMneC9m0ZqYdIIVBdnVzFYoEuWv6TVQ4M0LufaOyMPDcdqlGaMsvpaZZZBZ5e1j3N8VCdGGxjeCYKkEhDQbG/qZw2tMSPDimyQj3zAc5eSTLytcqW93sxhTeEFiNxlYcjTmIF+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777159086; c=relaxed/simple;
	bh=7sKKXYpFT7lWUAdn2v8DBW8+86G3usPSaF4tLkjspUc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tayGbqvORnKJ6QcsLoPkJa2fxBFbfCn0YQ/P29fsfLtaeZP2ef3FoZG9i33TbSSH3nNi0UwBsoe6agl6IJB8rs1zmZTmtClkKLbXwIYFIl0VnE5slxY7/FnBTvnxTlCeLyy3gizdwitdLLNHw8TVAQse1HSEIInwS8sxTr1ihtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQ/y07H7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQ/y07H7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF7FC2BCB0;
	Sat, 25 Apr 2026 23:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777159086;
	bh=7sKKXYpFT7lWUAdn2v8DBW8+86G3usPSaF4tLkjspUc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=dQ/y07H78+tdGThhjI/JDQLckhl7Z+SqeDwLs//ZFPaEfMuFgNWdHHrfRXd7oJdtX
	 HD+7FXCUWpQSvw62PWYOgae05KHwYDCrm0VnCVlv8henZU/yrsgbnjvzi0a4/pt7yv
	 /limYkhtIDrKiAD7y+5TNlxMMJe97tvEENuBIPZBodINdTGhhGuY5jW+Lba1vozdtu
	 jcxvciwdLd3k/jDoFt230ZltpOLAScJihdimTuGidjWLaQqo2sm6eNJ4WaDTyc2QGf
	 igoWmGyVWyl60DQmKibC8lCx2XFBc7orNO8d8SlZ6GOM4jGOSW6z3eUuAvp/b647OM
	 gvtnahLN+wWEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 11/59] perf evsel: Add reference count
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-12-irogers@google.com>
References: <20260425224951.174663-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:18:05 +0000
Message-Id: <20260425231805.CCF7FC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 5 potential issue(s):
- [Critical] `pyrf_evlist__add` blindly casts arbitrary Python objects, all=
owing type confusion and arbitrary memory writes.
- [High] Premature `evsel__put()` on a borrowed pointer in `evlist__deliver=
_deferred_callchain()` causes a use-after-free.
- [High] Uninitialized Python `perf.evsel` objects bypass `tp_getattro` pro=
tection, causing NULL pointer dereferences.
- [High] Early deallocation of `pyrf_event` passes uninitialized memory to =
`perf_sample__exit()`, risking a crash.
- [Medium] Python wrapper leaks `evsel` reference counts for non-sample eve=
nts.
--

commit 29b017250bae114f17460d0bc6b4902994eeb29d
Author: Ian Rogers <irogers@google.com>

perf evsel: Add reference count

This commit adds reference counting to evsel to prevent assertion failures
in the Python code when events are cloned. It initializes the reference cou=
nt
to 1 at allocation and decrements it on deletion. Getset functions are added
for the evsel members so the Python API remains unchanged.

> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -506,8 +507,10 @@ static PyObject *pyrf_event__new(const union perf_ev=
ent *event)
> =20
>  	ptype =3D pyrf_event__type[event->header.type];
>  	pevent =3D PyObject_New(struct pyrf_event, ptype);
> -	if (pevent !=3D NULL)
> +	if (pevent !=3D NULL) {
>  		memcpy(&pevent->event, event, event->header.size);
> +		pevent->evsel =3D NULL;
> +	}
>  	return (PyObject *)pevent;
>  }

Does this pass uninitialized memory to perf_sample__exit()?

When pyrf_event__new() creates a new object, pevent->sample is left
uninitialized. If event parsing fails shortly after creation, the object
is deallocated:

>  static void pyrf_sample_event__delete(struct pyrf_event *pevent)
>  {
> +	evsel__put(pevent->evsel);
>  	perf_sample__exit(&pevent->sample);
>  	Py_TYPE(pevent)->tp_free((PyObject*)pevent);
>  }

Calling perf_sample__exit() on garbage memory will attempt to free invalid
pointers, such as zfree(&sample->user_regs).

I see this was fixed later in the patch series (perf python: Use evsel
in sample in pyrf_event) by adding perf_sample__init(&pevent->sample, false)
to the initialization, but I wanted to mention it here.

[ ... ]
> +static PyObject *pyrf_evsel__str(PyObject *self)
> +{
> +	struct pyrf_evsel *pevsel =3D (void *)self;
> +	struct evsel *evsel =3D pevsel->evsel;
> +
> +	return PyUnicode_FromFormat("evsel(%s/%s/)", evsel__pmu_name(evsel), ev=
sel__name(evsel));
> +}

Could an uninitialized perf.evsel object cause a NULL pointer dereference
here?

The patch adds a tp_getattro handler to protect against uninitialized
objects (where pevsel->evsel is NULL). However, tp_getattro only intercepts
attribute reads.

Direct method calls like str(e) or repr(e) invoke tp_str, which passes the
NULL pointer directly to evsel__pmu_name(), leading to a segmentation fault.
Similarly, property setters (like e.tracking =3D True) use the C setters
directly, bypassing tp_getattro and dereferencing the NULL pointer.

[ ... ]
> @@ -1566,9 +1738,9 @@ static PyObject *pyrf_evlist__add(struct pyrf_evlis=
t *pevlist,
>  		return NULL;
> =20
>  	Py_INCREF(pevsel);
> -	evsel =3D &((struct pyrf_evsel *)pevsel)->evsel;
> +	evsel =3D ((struct pyrf_evsel *)pevsel)->evsel;
>  	evsel->core.idx =3D evlist->core.nr_entries;
> -	evlist__add(evlist, evsel);
> +	evlist__add(evlist, evsel__get(evsel));
> =20
>  	return Py_BuildValue("i", evlist->core.nr_entries);
>  }

Can this lead to an arbitrary memory write if a Python user passes the wrong
object type?

PyArg_ParseTuple(args, "O", &pevsel) accepts any Python object without
checking if it is actually a pyrf_evsel. It is then blindly cast to
struct pyrf_evsel *, and its evsel pointer is dereferenced to write the
index.

While this type confusion existed before this patch, changing it from an
address-of operator to a direct pointer dereference turns it into an
arbitrary memory write. Should this use "O!" with &pyrf_evsel__type to
enforce type safety?

[ ... ]
> @@ -1626,7 +1798,7 @@ static PyObject *pyrf_evlist__read_on_cpu(struct py=
rf_evlist *pevlist,
>  			return Py_None;
>  		}
> =20
> -		pevent->evsel =3D evsel;
> +		pevent->evsel =3D evsel__get(evsel);
> =20
>  		perf_mmap__consume(&md->core);

Does this leak reference counts for non-sample events?

Here, evsel__get() is called for all parsed events. However, only
pyrf_sample_event__type overrides the destructor to call evsel__put():

>  static void pyrf_sample_event__delete(struct pyrf_event *pevent)
>  {
> +	evsel__put(pevent->evsel);
>  	perf_sample__exit(&pevent->sample);
>  	Py_TYPE(pevent)->tp_free((PyObject*)pevent);
>  }

Other event types (like mmap or comm) fall back to the default deallocator,
meaning their evsel reference counts are never decremented.

I note this is addressed in subsequent commits by unifying the event
destructors, but wanted to bring it up.

> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
[ ... ]
> @@ -1373,6 +1373,7 @@ static int evlist__deliver_deferred_callchain(struc=
t evlist *evlist,
>  		sample->evsel =3D evlist__id2evsel(evlist, sample->id);
>  		ret =3D tool->callchain_deferred(tool, event, sample,
>  					       sample->evsel, machine);
> +		evsel__put(sample->evsel);
>  		sample->evsel =3D saved_evsel;
>  		return ret;
>  	}

Does this cause a use-after-free? evlist__id2evsel() returns a borrowed
pointer to the evsel without incrementing its reference count. Calling
evsel__put() here drops the reference count incorrectly.

I see this was fixed later in the patch series (in perf python: Use evsel
in sample in pyrf_event) by adding the missing evsel__get(), but I am
pointing it out for completeness.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D11
