Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1FB3F0772
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 18:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777055017; cv=none; b=EQBvdaTd0uF8RgCa5KowdYenSY8FR2kFIa3cMD1QdsoEh8nMY/bKjQ9h00ZFY7NqiTghcFLPDMrs3L/pMUUXOPmNytYJoVHJUXnuwgGge6E+lbfnJJBGWjJ3cMXFCAwZp+aVkEa+LA1fH54yww0OiiIfiBx81WfmrxSWOu+jy8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777055017; c=relaxed/simple;
	bh=toLLBYnJV4HxijYjLyPg8hYLV4SfXs2A+41LTYoyX/4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iBCQawnAhWKb8AWToXomcv1kK4DfAow8jAOC+XBjeCSd+qyLoChgs5pmQiH7Cf6rT0dT9inH9PfnXHMuk30ECyf50Vpn9H9sjOfh6IzHean05BbS1p4WXdgbJJyckNKUYKNb2QuFX5b5d2HZqYEN9r7sEOOUbbF1LbDGTf406A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tyz7s3cV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tyz7s3cV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B47FC19425;
	Fri, 24 Apr 2026 18:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777055017;
	bh=toLLBYnJV4HxijYjLyPg8hYLV4SfXs2A+41LTYoyX/4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Tyz7s3cVnRBBHHIDvS4T/Wke4d8IEj64OJ0b8GDwrdFCQsM8caR6Kz2Gd2vL2fHbW
	 +DPhnmjDX/hYYs/FvEviSnqbCbZT5g79kytLDOYCoQKPGNfbHB046yRyHe1rysYImT
	 pjNoYU6n2C6/O0jOI7OHEmlUSbMpkVKB1JVnuZg9MUjgLkh7BPmgt3zTzyjOhMiUTg
	 JNh69efHCbsVmwB9t5ocQjo64Yu0/LWoac57eW9Vkc7u5apB4/Mt3x2pM5iA3BS/sz
	 msbD41DecsivvU4XL71PjVvY+srUuV6y0betq5NsLH56Tli9dMeoEe/nyDOzJkHxdw
	 uA8M12wEFb4ag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 17/58] perf python: Refactor and add accessors to
 sample event
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-18-irogers@google.com>
References: <20260424164721.2229025-18-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 18:23:36 +0000
Message-Id: <20260424182337.3B47FC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Critical] Removal of `perf_sample__init()` in `pyrf_event__new()` leaves=
 `pevent->sample` fields uninitialized, leading to an invalid free and cras=
h on error paths.
- [High] Missing `.tp_new` and `.tp_dealloc` handlers for `pyrf_comm_event_=
_type` and `pyrf_read_event__type` causes reference leaks and breaks instan=
tiation.
--

commit 29c4c2cca09bd95b3e744cfebbcaf70891ec3916
Author: Ian Rogers <irogers@google.com>

perf python: Refactor and add accessors to sample event
   =20
This commit refactors event sample types by creating common fields for evsel
and relocating sample-specific fields. It also adds several accessors for
sample events and introduces an address location structure.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index f240905e07d6c1..63ee9bc65721bb 100644
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

Are .tp_new and .tp_dealloc missing from this structure?

Since the earlier runtime assignments of PyType_GenericNew were removed
during this refactoring, leaving .tp_new NULL breaks direct instantiation
from Python.

Additionally, leaving .tp_dealloc NULL means the Python garbage collector
bypasses the pyrf_event__delete() destructor, so perf_sample__exit() is
never executed.

Could this permanently leak the evsel reference that gets elevated during
evsel__parse_sample() every time a comm event is processed?

[ ... ]

> @@ -269,6 +322,7 @@ static PyTypeObject pyrf_read_event__type =3D {
>  	.tp_flags	=3D Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
>  	.tp_doc		=3D pyrf_read_event__doc,
>  	.tp_members	=3D pyrf_read_event__members,
> +	.tp_getset	=3D pyrf_event__getset,
>  	.tp_repr	=3D (reprfunc)pyrf_read_event__repr,
>  };

Similar to the comm event above, does this read event structure also need
.tp_new and .tp_dealloc populated to prevent memory leaks and instantiation
errors?

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

Can removing perf_sample__init() lead to a crash on error paths?

PyObject_New() allocates memory but does not zero-initialize it.
If evlist__event2evsel() fails to find an event, pyrf_evlist__read_on_cpu()
takes this error path:

pyrf_evlist__read_on_cpu() {
    pyevent =3D pyrf_event__new(event);
    ...
    evsel =3D evlist__event2evsel(evlist, event);
    if (!evsel) {
        Py_DECREF(pyevent);
        Py_RETURN_NONE;
    }
...
}

The Py_DECREF() will invoke the destructor pyrf_event__delete(), which
unconditionally calls perf_sample__exit().

Because perf_sample__init() was removed, the pevent->sample fields like
user_regs and intr_regs might contain uninitialized garbage values.

Will the zfree() calls inside perf_sample__exit() attempt to free invalid
pointers in this scenario?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D17
