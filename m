Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA6E3822AA
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 05:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776922195; cv=none; b=SkINqWmF4cojqM8dgLg6KDjJ+d6iIPxU6d0yl18t8cVna4phDqOMLKCT69FhSIEnAKjMCvwijk4BGT+bvO00Imgic7Pq/ISPGDCT28ytsgAeO/ezPIyxnAExh3rNFPzfSwqcRx+Ekm96C0x5eJY0Yq6PVB2nlvOSWt+h4VziKEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776922195; c=relaxed/simple;
	bh=WFqT9jj6x6NC9U2IsXczUk/yQD1DeRCht/2thyElsFw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sisHghIM6HSxtxgvuxOKbERbuGUelECEpKs8pDZSY8YitHmiZtMuCukf9c3Rx3WwOdvMUOfVJWhcQEicmvWq6Cp6fNTgHZOstIhNqQE8d/h1cjYF2nLKerRd7TU2LACSXVixVjWk6dnM8ioMxBSbMZa1BYXmRyLYW7GvFLJpgLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0CehK/R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0CehK/R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EA3C2BCB2;
	Thu, 23 Apr 2026 05:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776922195;
	bh=WFqT9jj6x6NC9U2IsXczUk/yQD1DeRCht/2thyElsFw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=H0CehK/RNCQgQJEZ2hgaYElmJltTSl/GU4rFb8dX1UVoohWhKvk15TsoXuPK2OxDC
	 Bzh12KsfgO2SR6wfD3Vp+/IpaG3Xd0jRy1ZKtn8WnwchX7dlau3idqKXvmN+EcQ8bx
	 /KO8cKgt2ZOKMdf1doxdAUFKKZ03alYtxPOr8DKO1lYUQo06qba9GxfXsdgA+46+Uo
	 HnekeBfTGW9w3k0a/Xk8MDCMoNhPCDELLNDqENnAeC5Ls4K4CqE6wnL05CTaKJYX2p
	 8Od+V8Ej/eVVhINJTZJZD7m9RpVbg6XzBs9flSeaRe+vXj246n//OzTy/Wdbxcg4eY
	 Cc+XyrMPhbc7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 17/58] perf python: Refactor and add accessors to
 sample event
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-18-irogers@google.com>
References: <20260423035526.1537178-18-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 05:29:54 +0000
Message-Id: <20260423052955.36EA3C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [Critical] Removing perf_sample__init from pyrf_event__new leaves pevent-=
>sample pointer fields uninitialized, leading to a wild free crash during e=
vent deallocation.
- [High] The Python property getters pyrf_sample_event__get_dso, pyrf_sampl=
e_event__get_dso_long_name, and pyrf_sample_event__get_dso_bid dereference =
the DSO pointer without checking if it is NULL.
- [High] A failure in evsel__parse_sample causes a double evsel__put() on t=
he event's evsel reference, leading to a refcount underflow.
- [Medium] pyrf_comm_event__type and pyrf_read_event__type are missing the =
.tp_new and .tp_dealloc definitions.
--

commit ce9c27681f1b9926dd2fe6af946174166412ca45
Author: Ian Rogers <irogers@google.com>

perf python: Refactor and add accessors to sample event

This commit adds a common evsel field for events and moves sample-specific
fields to only be present in sample events. It also introduces new accessors
for sample events and refactors object type initialization in the Python
bindings.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index d90aa24e53105..3e0534744f0a2 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c

[ ... ]

> @@ -172,6 +218,7 @@ static PyTypeObject pyrf_comm_event__type =3D {
>  	.tp_flags	=3D Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
>  	.tp_doc		=3D pyrf_comm_event__doc,
>  	.tp_members	=3D pyrf_comm_event__members,
> +	.tp_getset	=3D pyrf_event__getset,
>  	.tp_repr	=3D (reprfunc)pyrf_comm_event__repr,
>  };

Are pyrf_comm_event__type and pyrf_read_event__type missing their .tp_new a=
nd
.tp_dealloc assignments after the initialization refactor?

Without these, it appears direct Python instantiation could break, and miss=
ing
the C-level destructors could leave their lifecycle management inconsistent
compared to other perf event objects.

[ ... ]

> +static PyObject *pyrf_sample_event__get_dso(struct pyrf_event *pevent,
> +					    void *closure __maybe_unused)
> +{
> +	if (pyrf_sample_event__resolve_al(pevent) < 0 || !pevent->al.map)
> +		Py_RETURN_NONE;
> +
> +	return PyUnicode_FromString(dso__name(map__dso(pevent->al.map)));
> +}
> +
> +static PyObject *pyrf_sample_event__get_dso_long_name(struct pyrf_event =
*pevent,
> +						      void *closure __maybe_unused)
> +{
> +	if (pyrf_sample_event__resolve_al(pevent) < 0 || !pevent->al.map)
> +		Py_RETURN_NONE;
> +
> +	return PyUnicode_FromString(dso__long_name(map__dso(pevent->al.map)));
> +}
> +
> +static PyObject *pyrf_sample_event__get_dso_bid(struct pyrf_event *peven=
t,
> +						void *closure __maybe_unused)
> +{
> +	char sbuild_id[SBUILD_ID_SIZE];
> +
> +	if (pyrf_sample_event__resolve_al(pevent) < 0 || !pevent->al.map)
> +		Py_RETURN_NONE;
> +
> +	build_id__snprintf(dso__bid(map__dso(pevent->al.map)), sbuild_id, sizeo=
f(sbuild_id));
> +	return PyUnicode_FromString(sbuild_id);
> +}

Could map__dso(pevent->al.map) return NULL here?

The accessors check if pevent->al.map is NULL, but if map__dso() itself ret=
urns
NULL, passing it to dso__name(), dso__long_name(), or dso__bid() could trig=
ger
a NULL pointer dereference.

[ ... ]

> @@ -516,7 +847,9 @@ static PyObject *pyrf_event__new(const union perf_eve=
nt *event)
>  	pevent =3D PyObject_New(struct pyrf_event, ptype);
>  	if (pevent !=3D NULL) {
>  		memcpy(&pevent->event, event, event->header.size);
> -		perf_sample__init(&pevent->sample, /*all=3D*/false);
> +		pevent->sample.evsel =3D NULL;
> +		pevent->al_resolved =3D false;
> +		addr_location__init(&pevent->al);
>  	}
>  	return (PyObject *)pevent;
>  }

Since PyObject_New() does not zero-initialize memory, does removing
perf_sample__init() leave pointer fields in pevent->sample uninitialized?

If pevent is later garbage collected (for non-sample events, or if
evlist__event2evsel() fails below), pyrf_event__delete() will call
perf_sample__exit(&pevent->sample). This attempts to free pointers like
sample->user_regs or sample->intr_regs. Could this lead to a wild free crash
when it operates on uninitialized heap memory?

[ ... ]

> @@ -1807,8 +2137,7 @@ static PyObject *pyrf_evlist__read_on_cpu(struct py=
rf_evlist *pevlist,
>  		return pyevent;
>  	}
>  end:
> -	Py_INCREF(Py_None);
> -	return Py_None;
> +	Py_RETURN_NONE;
>  }

While not introduced directly by this patch, it seems the failure path for
evsel__parse_sample() right above this block might have a refcount underflow
issue:

	err =3D evsel__parse_sample(evsel, &pevent->event, &pevent->sample);
	if (err) {
		Py_DECREF(pyevent);

If evsel__parse_sample() fails, it cleans up by calling perf_sample__exit(),
which calls evsel__put() on the evsel reference without setting sample->evs=
el
to NULL.

When Py_DECREF(pyevent) is subsequently called here, it triggers the
pyrf_event__delete() destructor, which will call perf_sample__exit() a seco=
nd
time. Does this cause a double evsel__put() and potential use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D17
