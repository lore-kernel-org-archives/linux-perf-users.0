Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A95F1A0B15
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776646097; cv=none; b=ICAiDCnd1cuVmVH3kR8t5HHdkmAGpxkiC1azJJlR/lenxkLEJI4cHP9e6ojdHA8UuWzo1ouc33BtLLHuPaeZaDPzOhJtA4UCwXd0YfBexhhqn74iZ0DO+VExLxsX+bNF0rkq92FjasmnoZ+yP/uOZrOqeOap9yVKTU47gBDynUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776646097; c=relaxed/simple;
	bh=Dk3T0WE4Gphqjk5uejMU6ZcQQbkz71p5hYxLoq33Ax4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FrOPYmqeIa5AsE9Ere+Nl63eL0gfiOYY8ktSvvoMyji0XEExC0kAzrxGnRDZaDUNUCtjGGYyK7Et1LFKjSjm+g72jiU2JlattD3bzx2gQ3t4FuKOYllXdlBN4xRjr65nZVjOhIFQuJP61WJkwZgcLNxBxZflooi3zVkeY7g+kUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuMYStsq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuMYStsq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01027C2BCAF;
	Mon, 20 Apr 2026 00:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776646097;
	bh=Dk3T0WE4Gphqjk5uejMU6ZcQQbkz71p5hYxLoq33Ax4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=iuMYStsq8ItgPundowwGAMvTATxn4pBX5TkJ6l0I+mr8DchEUicNj5n1V13IJ+k3A
	 PulDNttcETvVnbEbvhCaBt6pMttmTp5ucIVbPyN6fnhfQUCoj472/teJPisNAHOTmZ
	 WbsTOA3Lam7kYfCiT8FVE+8bO2D64NmgCZc9dlEbTApPPw7J+lcvOfeY2Q7YUuZgcJ
	 TqB+U14bILs/HVb2TMt5npCywgznY5S2Ts9lY5TAsg40Mmykn72zx5M4KvtUMpQteW
	 KNvC7BldlmZm/LaDJhFa/KMPABz5MRQQoiKGnQeLPF0SUVcFOCXV+dYqVs6Rgsf+59
	 gIePC6OnZjNYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 11/58] perf evsel: Add reference count
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-12-irogers@google.com>
References: <20260419235911.2186050-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:48:16 +0000
Message-Id: <20260420004817.01027C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 6 potential issue(s):
- [High] Missing `evsel__get()` in `pyrf_evlist__read_on_cpu` causes a Use-=
After-Free of the `evsel` structure.
- [High] Uninitialized pointer dereference in the `pyrf_evlist__read_on_cpu=
` error path causes a crash.
- [High] Memory leak of the Python wrapper and Use-After-Free of the C `evs=
el` in `pyrf_evlist__add`.
- [Medium] NULL pointer dereference in `perf.evsel` property getters and se=
tters crashes the interpreter.
- [Medium] Memory leak of the `evsel` structure upon multiple calls to `per=
f.evsel.__init__`.
- [Low] Python C API violation in `pyrf_evsel__init` returns an error witho=
ut setting an exception.
--

commit bb899a0ed142a93e92ca4732f6ff756c67b3f57c
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
> index 9878547e98d6f..66093f7c753db 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -274,6 +274,7 @@ static PyMemberDef pyrf_sample_event__members[] =3D {
> =20
>  static void pyrf_sample_event__delete(struct pyrf_event *pevent)
>  {
> +	evsel__put(pevent->evsel);
>  	perf_sample__exit(&pevent->sample);
>  	Py_TYPE(pevent)->tp_free((PyObject*)pevent);
>  }

With this new evsel__put() added, could this cause a use-after-free regress=
ion
or a crash when handling errors in pyrf_evlist__read_on_cpu()?

In pyrf_evlist__read_on_cpu(), the event object is allocated without
zero-initialization, and evsel is assigned later:

        PyObject *pyevent =3D pyrf_event__new(event);
        struct pyrf_event *pevent =3D (struct pyrf_event *)pyevent;
        struct evsel *evsel;

        if (pyevent =3D=3D NULL)
                return PyErr_NoMemory();

        evsel =3D evlist__event2evsel(evlist, event);
        if (!evsel) {
                Py_DECREF(pyevent);
                Py_INCREF(Py_None);
                return Py_None;
        }

        pevent->evsel =3D evsel;

If evlist__event2evsel() returns NULL, Py_DECREF(pyevent) is called. Since
pevent->evsel is uninitialized, won't pyrf_sample_event__delete() pass a
garbage pointer to evsel__put() and crash?

Additionally, if evsel is successfully assigned, pyrf_evlist__read_on_cpu()
sets pevent->evsel =3D evsel without incrementing the reference count via
evsel__get(). When this Python event is garbage collected, the unconditiona=
lly
called evsel__put() will decrement the reference count owned by the evlist.
Could this regression lead to premature freeing of the evsel and a subseque=
nt
use-after-free when the evlist tries to access it?

[ ... ]

> @@ -1053,20 +1054,20 @@ static int pyrf_evsel__init(struct pyrf_evsel *pe=
vsel,
>  	attr.sample_id_all  =3D sample_id_all;
>  	attr.size	    =3D sizeof(attr);
> =20
> -	evsel__init(&pevsel->evsel, &attr, idx);
> -	return 0;
> +	pevsel->evsel =3D evsel__new(&attr);
> +	return pevsel->evsel ? 0 : -1;
>  }

Since __init__ can be manually invoked multiple times in Python, could this
cause a memory leak regression? If a user calls __init__ again on an existi=
ng
object, the previously allocated evsel pointer in pevsel->evsel will be
overwritten without calling evsel__put(), leaking the evsel memory.

Also, if evsel__new(&attr) fails and returns NULL, this function evaluates =
to
-1 and returns. Is it required to set a Python exception like PyErr_NoMemor=
y()
before returning -1 here? Returning an error without setting an exception
violates the Python C API contract.

[ ... ]

> @@ -1225,26 +1226,170 @@ static PyMethodDef pyrf_evsel__methods[] =3D {
>  	{ .ml_name =3D NULL, }
>  };

[ ... ]

> +static PyObject *pyrf_evsel__get_attr_type(PyObject *self, void */*closu=
re*/)
> +{
> +	struct pyrf_evsel *pevsel =3D (void *)self;
> +
> +	return PyLong_FromUnsignedLong(pevsel->evsel->core.attr.type);
> +}

Could this lead to a NULL pointer dereference regression? The pyrf_evsel__t=
ype
uses PyType_GenericNew for its .tp_new slot, which allows a user to
instantiate an object directly via perf.evsel.__new__(perf.evsel).

This allocates the Python object with zeroed memory, leaving pevsel->evsel =
as
NULL. If __init__ is bypassed, any access to the object's properties (such =
as
.type calling this function) will unconditionally dereference the NULL
pevsel->evsel and crash the interpreter.

[ ... ]

> @@ -1565,7 +1710,7 @@ static PyObject *pyrf_evlist__add(struct pyrf_evlis=
t *pevlist,
>  		return NULL;
> =20
>  	Py_INCREF(pevsel);
> -	evsel =3D &((struct pyrf_evsel *)pevsel)->evsel;
> +	evsel =3D ((struct pyrf_evsel *)pevsel)->evsel;
>  	evsel->core.idx =3D evlist->core.nr_entries;
>  	evlist__add(evlist, evsel);

Could this lead to a memory leak of the Python wrapper and a use-after-free
regression of the C evsel? The Python object's reference count is
intentionally incremented via Py_INCREF(pevsel) to keep it alive, but the
inner evsel is added to the evlist without calling evsel__get().

When the evlist is purged, it will call evsel__put(), which drops the
reference count and frees the evsel structure. Won't the permanently leaked
Python wrapper then hold a dangling pointer, leading to a use-after-free if
its attributes are accessed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D11
