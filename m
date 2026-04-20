Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756BA232367
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 01:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776647817; cv=none; b=J84mIuUoG9tHtti78/l+NGqvZVe1rgODDWonyE7A3iaVCNQM96+ix6fO12/jqsL9BHwBUWrWMv1aL2Ta+SXgVS47vN+v9RgdeXi1vtvlKiK9gyoFVZ45qG7ACEYCn+eyodSe4zHt8KyRkk5CkCgilxFF9WlEZ1P7+focBg6/epI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776647817; c=relaxed/simple;
	bh=t4LXA8OahQ2dSw6SGjEuidtWLBPcHl8hZDWXUBr4ltY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VLcTYczQ139WGGoe8qI8gqmoJqQDhT3mhty7ldqEMeFm5r6D+Aata+DsaxFO76LvG0k3Oj1uaS3jewEmKvP1f8mrSV698t1e28IVgiaXNAnd5vfM/+bkQQ4q7CwlrVZWHMDakgBdyrK8YvRU/x4KElQxH1yiak0n8Vgou4D3nvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvOTMNRI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvOTMNRI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF712C2BCAF;
	Mon, 20 Apr 2026 01:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776647817;
	bh=t4LXA8OahQ2dSw6SGjEuidtWLBPcHl8hZDWXUBr4ltY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=QvOTMNRIpDm83p9OjgYtDOIhd9ihLDpT3uy1HMzy7w15U3NuYYx44FNx7qY3cMMO0
	 ZJWNrfQilWJD0r8m21KZPyM/Aw0MrvFcbFMvJMg5eVi54XMfP3piVh4yYjGqY+Tjmy
	 jafH2nTuVb46yx8mxv80+jIabJG1s+AMMowuvMgTjE1x4NwKINbe1elLguNcO6KlrQ
	 qE39noiD1Sq+rd3L6a27kGfYpS1lYSCvaQ2MKOXdew9TxSzybhRWBVZ5YmRWCTzn1C
	 4tWZ9zyjhHFtJ4wsZKDqY14XAO/zmMp9QF77bzNwnuAcLcv9GOymSrnBXhx3garFn8
	 pTFkr27SnIHOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 17/58] perf python: Refactor and add accessors to
 sample event
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-18-irogers@google.com>
References: <20260419235911.2186050-18-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 01:16:56 +0000
Message-Id: <20260420011656.CF712C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 6 potential issue(s):
- [High] Use-After-Free and state corruption in `pyrf_sample_event__srccode=
` when looking up arbitrary addresses.
- [Medium] Uninitialized Memory in `pyrf_event__new` causes segmentation fa=
ults and unpredictable behavior.
- [Medium] Memory and reference leak of `addr_location` objects in `pyrf_ev=
ent__delete`.
- [Medium] Missing object destructors for `comm_event` and `read_event` lea=
ds to memory leaks.
- [Medium] NULL pointer dereference when accessing `.evsel` on newly create=
d events.
- [Medium] API regression by removing `sample_time` and other common proper=
ties from non-sample events.
--

commit ef6281ba2b3c8cf8ea4de7bc8f5ede27f2933284
Author: Ian Rogers <irogers@google.com>

perf python: Refactor and add accessors to sample event

This commit adds a common field for the evsel of an event, derived from
PERF_SAMPLE_ID or PERF_SAMPLE_IDENTIFIER. It also restricts certain fields
like sample_ip to sample events and introduces new accessors for various
sample event properties.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 84a186532353e..09b5667075638 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -52,21 +60,48 @@ PyMODINIT_FUNC PyInit_perf(void);
> =20
>  struct pyrf_event {
>  	PyObject_HEAD
> +	/** @sample: The parsed sample from the event. */
>  	struct perf_sample sample;
> -	union perf_event   event;
> +	/** @al: The address location from machine__resolve, lazily computed. */
> +	struct addr_location al;
> +	/** @al_resolved: True when machine__resolve been called. */
> +	bool al_resolved;
> +	/** @event: The underlying perf_event that may be in a file or ring buf=
fer. */
> +	union perf_event event;
>  };

Could the newly added al and al_resolved fields be left containing
uninitialized memory?

If Python objects are allocated without zero-initializing the memory, these
fields might contain random data. If al_resolved evaluates to true from
garbage memory, pyrf_sample_event__resolve_al() could return immediately,
and subsequent property reads might dereference uninitialized pointers in
pevent->al.map.

Furthermore, if the parsed evsel is not attached to pevent->sample.evsel
during event reads, pyrf_event__delete() might call evsel__put() on garbage
memory, causing a crash.

>  #define sample_members \
> -	sample_member_def(sample_ip, ip, T_ULONGLONG, "event ip"),			 \
>  	sample_member_def(sample_pid, pid, T_INT, "event pid"),			 \
>  	sample_member_def(sample_tid, tid, T_INT, "event tid"),			 \
> -	sample_member_def(sample_time, time, T_ULONGLONG, "event timestamp"),		=
 \
> -	sample_member_def(sample_addr, addr, T_ULONGLONG, "event addr"),		 \
>  	sample_member_def(sample_id, id, T_ULONGLONG, "event id"),			 \
>  	sample_member_def(sample_stream_id, stream_id, T_ULONGLONG, "event stre=
am id"), \
>  	sample_member_def(sample_period, period, T_ULONGLONG, "event period"),	=
	 \
>  	sample_member_def(sample_cpu, cpu, T_UINT, "event cpu"),

Does removing sample_time from sample_members break existing Python scripts?
When perf_event_open is called with sample_id_all, non-sample events like
mmap_event and comm_event contain valid timestamps. Removing this property
prevents chronologically sorting streams of heterogeneous events.

> +static PyObject *pyrf_event__get_evsel(PyObject *self, void *closure __m=
aybe_unused)
> +{
> +	struct pyrf_event *pevent =3D (void *)self;
> +
> +	return pyrf_evsel__from_evsel(pevent->sample.evsel);
> +}

What happens if this is accessed on a newly created event where
pevent->sample.evsel is NULL? It appears pyrf_evsel__from_evsel() calls
evsel__get() which immediately increments the refcount, causing a NULL
pointer dereference.

[ ... ]
> +static void pyrf_event__delete(struct pyrf_event *pevent)
> +{
> +	evsel__put(pevent->sample.evsel);
> +	perf_sample__exit(&pevent->sample);
> +	Py_TYPE(pevent)->tp_free((PyObject *)pevent);
> +}

Does this code leak the map and thread references? If machine__resolve() was
previously called and populated pevent->al, it acquires reference counts.
It seems addr_location__exit(&pevent->al) should be called here to prevent
leaking these references upon garbage collection.

[ ... ]
> @@ -172,6 +213,7 @@ static PyTypeObject pyrf_comm_event__type =3D {
>  	.tp_flags	=3D Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
>  	.tp_doc		=3D pyrf_comm_event__doc,
>  	.tp_members	=3D pyrf_comm_event__members,
> +	.tp_getset	=3D pyrf_event__getset,
>  	.tp_repr	=3D (reprfunc)pyrf_comm_event__repr,
>  };

Is the tp_dealloc assignment missing here for pyrf_comm_event__type and
pyrf_read_event__type?

The dynamic initialization was removed from pyrf_event__setup_types(), but
tp_dealloc doesn't seem to be statically assigned here. When created from C,
these objects might use the generic Python destructor, bypassing
pyrf_event__delete() and leaking evsel references and internal perf_sample
allocations.

[ ... ]
> +static PyObject *pyrf_sample_event__srccode(PyObject *self, PyObject *ar=
gs)
> +{
> +	struct pyrf_event *pevent =3D (void *)self;
> +	u64 addr =3D pevent->sample.ip;
[ ... ]
> +	if (addr !=3D pevent->sample.ip) {
> +		thread__find_symbol_fb(pevent->al.thread, pevent->sample.cpumode, addr,
> +				       &pevent->al);
> +	}

Can this sequence cause a use-after-free of the thread object?

When thread__find_symbol_fb() is called, it passes pevent->al.thread as the
first argument while passing &pevent->al as the location output. Inside
thread__find_map() this can execute thread__zput(al->thread).

Since al aliases &pevent->al, this drops the reference to the thread. If it
was the last reference, the thread object is freed. Immediately after, it
calls thread__get(thread) using the aliased pointer which now points to
freed memory.

Additionally, does this overwrite the cached pevent->al struct, corrupting
subsequent property reads (like .symbol) for the original event IP?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D17
