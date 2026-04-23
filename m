Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E869D36654C
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 04:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776918295; cv=none; b=EZ9mWSx4WbYm7/oO0gKmNAW/cbbZK9AhwdeSLL947KjhZNk2s6GRjAxjlLo0FFoNQ3MOCrWtIF3TfNRQDVtX/Zzw9JFEtORl8QacqVzODCQOoz3mA1q/VAO4JrExIX+EtAm42/2snArB653nsWdbvp1l0YXY0a6urumGpFaK2Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776918295; c=relaxed/simple;
	bh=0WEuvrmwKxBKz/b8CBUyeyvTB3/2kW/Wk1mc/6pSaeo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YIj5rKs3zy/YRZoigt94qnG4zLXTfspz5SPoRUSbkW/h73Ot5Lde1Q74rUExgbDlhe2HRAxcVWB3AqkfOuGNaGbUMjaVNsAqVnm/neMmxstEyCHd8bEDnDB101BGxDRVtCG2SWQbmZn0oLdsyKBSSWnscIEXEFIpSZM9JL4Hg7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QACdjVEf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QACdjVEf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5748C2BCB2;
	Thu, 23 Apr 2026 04:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776918294;
	bh=0WEuvrmwKxBKz/b8CBUyeyvTB3/2kW/Wk1mc/6pSaeo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=QACdjVEfg4CSvzzqMC91AByEf/GXFobkOCF316lf3GwMmO4TayQP0Cg96Onhf1yza
	 6TQpxtxFOYKwRTle8/nYnTNhmhEHXc9fCz1HvKcaCj3E26FhKt7HTzn575hX9cmkFy
	 RYZumYKvai91P0fUQJGd0sHQWUEIb89hP8I8KDcaC6a8eWuAfgist9ZKaUM1u1B+ua
	 wQ1Q4ogwenJrTC6s+afOdzq8v3c0bgD3f8vzZlo6iReWI8RZLt1nprNlznzyoZO8lH
	 HdY4XOKbp+8V+4uozjcB3Pd5arKaQ0vzm34W8OOm4U78+b6U80yAA69UE/C+BzgRX5
	 +CpMNXp2pW6eA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/58] perf evsel: Add reference count
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-12-irogers@google.com>
References: <20260423035526.1537178-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 04:24:54 +0000
Message-Id: <20260423042454.B5748C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [Critical] Type confusion in `pyrf_evlist__add` leads to arbitrary memory=
 write.
- [High] Memory leak of Python `perf.evsel` wrapper objects in `pyrf_evlist=
__add`.
- [High] Reference count and resource leak for non-sample events in Python =
API.
- [High] Incomplete mitigation for uninitialized `perf.evsel` objects leadi=
ng to NULL pointer dereferences.
--

commit 6ccf91b0693b6b304d41b9ebc58803ae64346935
Author: Ian Rogers <irogers@google.com>

    perf evsel: Add reference count
   =20
    As with evlist this a no-op for most of the perf tool. The reference
    count is set to 1 at allocation, the put will see the 1, decrement it
    and perform the delete. The purpose for adding the reference count is
    for the python code. Prior to this change the python code would clone
    evsels, but this has issues if events are opened, etc. leading to
    assertion failures. With a reference count the same evsel can be used
    and the reference count incremented for the python usage.  To not
    change the python evsel API getset functions are added for the evsel
    members, no set function is provided for size as it doesn't make sense
    to alter this.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 3f0758d5bd904..8585ae992e6b0 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c

[ ... ]

> @@ -274,6 +274,7 @@ static PyMemberDef pyrf_sample_event__members[] =3D {
> =20
>  static void pyrf_sample_event__delete(struct pyrf_event *pevent)
>  {
> +	evsel__put(pevent->evsel);
>  	perf_sample__exit(&pevent->sample);
>  	Py_TYPE(pevent)->tp_free((PyObject*)pevent);
>  }

Is it possible that non-sample events will leak the underlying evsel
reference?

The patch adds evsel__put() to pyrf_sample_event__delete(), but other
event types like pyrf_mmap_event__type or pyrf_task_event__type rely on
the default Python object destructor.

Since pyrf_evlist__read_on_cpu() acquires an evsel reference for all event
types, does this mean non-sample events will permanently leak the reference
when they are garbage collected?

[ ... ]

> +static PyObject *pyrf_evsel__getattro(struct pyrf_evsel *pevsel, PyObjec=
t *attr_name)
> +{
> +	if (!pevsel->evsel) {
> +		PyErr_SetString(PyExc_ValueError, "evsel not initialized");
> +		return NULL;
> +	}
> +	return PyObject_GenericGetAttr((PyObject *) pevsel, attr_name);
> +}

Does this protection fully prevent dereferences of uninitialized evsel
objects?

Since this only implements tp_getattro and not tp_setattro, could property
setters bypass this and directly call C setter functions like
pyrf_evsel__set_tracking() which then dereference pevsel->evsel?

Also, could calling methods directly on the class (e.g., perf.evsel.open(e))
bypass tp_getattro and lead to a NULL dereference?

[ ... ]

> @@ -1566,9 +1728,9 @@ static PyObject *pyrf_evlist__add(struct pyrf_evlis=
t *pevlist,
>  		return NULL;
> =20
>  	Py_INCREF(pevsel);

Since evsel is now dynamically allocated and reference-counted independentl=
y,
does this Py_INCREF() cause the Python wrapper object to be leaked?

Before this change, evlist held a pointer to the embedded evsel struct insi=
de
the Python object, making Py_INCREF necessary. Now that evlist__add() takes
its own reference to the standalone C struct via evsel__get(evsel) and never
calls Py_DECREF, shouldn't this Py_INCREF(pevsel) be removed?

> -	evsel =3D &((struct pyrf_evsel *)pevsel)->evsel;
> +	evsel =3D ((struct pyrf_evsel *)pevsel)->evsel;

Does this cast introduce an arbitrary memory write if a different Python
object is passed?

In this function, the user argument is parsed using
PyArg_ParseTuple(args, "O", &pevsel) which accepts any Python object without
type validation.

If a different type (like a bytes object) is passed, this unconditionally
casts it to struct pyrf_evsel *. Now that evsel is a pointer instead of an
embedded struct, the code will read the pointer from the attacker-controlled
object's memory and later execute:

	evsel->core.idx =3D evlist->core.nr_entries;
	evlist__add(evlist, evsel__get(evsel));

Could this result in an arbitrary memory write and atomic increment?

Additionally, does this directly access ((struct pyrf_evsel *)pevsel)->evsel
without validating it, potentially bypassing the pyrf_evsel__getattro() che=
ck
above and causing a NULL dereference on uninitialized perf.evsel objects?

>  	evsel->core.idx =3D evlist->core.nr_entries;
> -	evlist__add(evlist, evsel);
> +	evlist__add(evlist, evsel__get(evsel));
> =20
>  	return Py_BuildValue("i", evlist->core.nr_entries);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D11
