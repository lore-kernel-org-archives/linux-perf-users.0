Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B56B52F8B
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776646421; cv=none; b=J5tBHFUuzBtgkqGV6PFRWIcWmLMjYlnNPH9IAaBHfX2Esp+nDvkCaPNsD5ZucwyDoUvkK4eXT3HME6SvNPyy2V5uMdbRU5zZ3nepaXWQX0vR/Ixdhc2S0LrCWgYpQxpx+6Y76igeLBeUKcrsbVfxtN/RzeKwu6paRhuSh5fRD9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776646421; c=relaxed/simple;
	bh=MAjy9yRgC3VFzkiLLPBSiQUuM/hNwJ7x+vdaVZXSY6U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B97MBhDb3NIZ0HmOIdwxdvCwBli6HRAgMuK8KXo8Ym3yk3aqXtU01dSf4eZVQrhGOdFr0h72CMvWXDgG5/+/LUzwaIlkOFP7eayrjEaZKmFd/qlylZgYbWeD4VKqHo5ia0LUgzA5fFsZHzFoi5h2N59lfiURJOvh0qnBbXx2dCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Si84I92q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Si84I92q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C67C2BCB5;
	Mon, 20 Apr 2026 00:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776646421;
	bh=MAjy9yRgC3VFzkiLLPBSiQUuM/hNwJ7x+vdaVZXSY6U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Si84I92q46B5/dBkJ9yJIQzeM/3ezHT/XybsuNArNlNET0PI1HQ3gbsrta+kcOlEM
	 IpT/iUO8tAuxZbdGhLEXCy5p03GDfLM5w5ldwww2LD9m1kPzLWGpaG7SWBkqDoIo9e
	 VU2x0Q+FOcASwNA1HaM6fFSaMJWsGNfMiEOw8MEegRurDEoVgjWcYk02qDdetsMItH
	 4n5SD6X/UUdAbsGsuVOvoxw79rsj12sWI2HBVB90qceALJkaq6P0gjNV/jU8a/paax
	 cvn3l4S+yrk84ueiy4Z0a5UXkO0hP6Ke0YYBZdjezhrKeke5tm6quHL2YfD/bpwHaM
	 bnkqtNtf+lEfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 10/58] perf evlist: Add reference count
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-11-irogers@google.com>
References: <20260419235911.2186050-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:53:40 +0000
Message-Id: <20260420005341.06C67C2BCB5@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [High] Calling `evlist__put()` in the Python bindings triggers `free()` o=
n an interior pointer, corrupting the heap.
- [High] Accessing an evlist item from Python returns a detached clone, bre=
aking interaction with opened events.
- [High] Double `evlist__put()` causing a Use-After-Free / Double Free in `=
builtin-trace.c`.
- [Medium] `pyrf_evlist__init` leaks the previously allocated `evlist` if `=
__init__` is called multiple times.
--

commit c68aec7a307f75660ac1e10cdc04f9b5d7aa17be
Author: Ian Rogers <irogers@google.com>

perf evlist: Add reference count

This patch introduces a reference count for the evlist structure, replacing
evlist__delete with evlist__put. In the Python bindings, the evlist is now
allocated dynamically instead of inline, preparing the way for further
reference counting changes for evsels.

> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
[ ... ]
> @@ -5364,7 +5364,7 @@ static void trace__exit(struct trace *trace)
>  		zfree(&trace->syscalls.table);
>  	}
>  	zfree(&trace->perfconfig_events);
> -	evlist__delete(trace->evlist);
> +	evlist__put(trace->evlist);

Can this cause a use-after-free and double free? Looking at trace__replay(),
trace->evlist is assigned to session->evlist without taking a reference. At
the end of that function, perf_session__delete() is called, which drops the
reference to session->evlist and frees it. Then cmd_trace() calls
trace__exit(), which executes this evlist__put() on the freed memory.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -1285,15 +1285,21 @@ static int pyrf_evlist__init(struct pyrf_evlist *=
pevlist,
>  	if (!PyArg_ParseTuple(args, "OO", &pcpus, &pthreads))
>  		return -1;
> =20
> +	pevlist->evlist =3D evlist__new();
> +	if (!pevlist->evlist) {
> +		PyErr_NoMemory();
> +		return -1;
> +	}

Does this leak the previously allocated evlist if __init__ is called multip=
le
times on the same instance? In Python, __init__ can be called repeatedly, a=
nd
the previous pointer would be unconditionally overwritten without calling
evlist__put().

[ ... ]
>  static void pyrf_evlist__delete(struct pyrf_evlist *pevlist)
>  {
> -	evlist__exit(&pevlist->evlist);
> +	evlist__put(pevlist->evlist);
>  	Py_TYPE(pevlist)->tp_free((PyObject*)pevlist);
>  }

Can this trigger free() on an interior pointer and corrupt the heap? In
pyrf_evlist__add(), an evsel embedded inside a Python object is added direc=
tly
to the C evlist. When the reference count drops to 0 here, evlist__put() ca=
lls
evlist__purge(), which iterates over the entries and calls evsel__delete().
This blindly invokes free() on the embedded pointer.

I see from upstream discussions that this issue is resolved in a later comm=
it
(perf evsel: Add reference count).

[ ... ]
> @@ -1794,17 +1816,16 @@ static PyObject *pyrf_evlist__item(PyObject *obj,=
 Py_ssize_t i)
>  	struct pyrf_evlist *pevlist =3D (void *)obj;
>  	struct evsel *pos;
> =20
> -	if (i >=3D pevlist->evlist.core.nr_entries) {
> +	if (i >=3D pevlist->evlist->core.nr_entries) {
>  		PyErr_SetString(PyExc_IndexError, "Index out of range");
>  		return NULL;
>  	}
> =20
> -	evlist__for_each_entry(&pevlist->evlist, pos) {
> +	evlist__for_each_entry(pevlist->evlist, pos) {
>  		if (i-- =3D=3D 0)
>  			break;
>  	}
> -
> -	return Py_BuildValue("O", container_of(pos, struct pyrf_evsel, evsel));
> +	return pyrf_evsel__from_evsel(pos);
>  }

Does accessing an evlist item from Python return a detached clone? The new
return path uses pyrf_evsel__from_evsel(), which deep-copies the event via
evsel__clone() instead of returning the opened event. Modifying the returned
event or accessing its file descriptors would operate on this copy.

I note this is addressed in a later patch in the series (perf evsel: Add
reference count).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D10
