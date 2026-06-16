Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAAD25A2B5
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 00:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781571264; cv=none; b=DC9pR5KkUby/g88zHlz92sg0OXpTmjW1bKUjZcFgXzi+4kPzddXKZyAu/dWFoLBWfXMtdS9xtYjqaHuzxqqa3JcnCPw2HSTKHqWRvRolIlWwfLzHnUtBSt0KZ8GUhhdW7MFaOV3rMMBVaeDxhOez8vn6B+8IdgQ6gUERfj9GLjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781571264; c=relaxed/simple;
	bh=RST8ZvFpfjMifxj3Y4uUv83bHD1+q8Z2BwkWQK/aHnY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O7qydAc0OV5bIps6YpCvSJgOoO4v/L8ABO6BEkvoHAybK9mRKuVS4EXg2LWQdmXsjYhjeqMy5Pk0DAfE4EFEJIT+AXYDJyJXRmnXWhv1UpjOSzAD/GO+TGJw1rNDz+672vj4Uhm21GqXuXpU9uStloU+JHb/dG192T6BLBPKp7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CD66HFLY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CD66HFLY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74BC41F000E9;
	Tue, 16 Jun 2026 00:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781571262;
	bh=ZmU3SeNF0uDikA4nVb1xCdorEPUbTGdEXysOoWh/tq0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CD66HFLYkOzEt24TWfubi47BpQ9IDdtad4c4ZHLkcjq31VbdIWgDSwnFXx6kcUYrU
	 SxmDBtOJZKmVyWmKwnp5Z+jFZ/nEEpTJlg9mY2ualSiPl/6MRYS+6K3TD4ZIwoaZKx
	 +dQgs5BZgFcl8sgBGzaOJC8KSdTZeLvh20asfb8W3WXcwI3A5VUcw8A7vQs8Z3UoiB
	 O9WswDft9qL4TGPdCTFAfk1S5x2j51MRTBb3lzhulRdDvl2OE0aM8G7zck9h5Op8V/
	 Aop7/+diNoouey8cabz+G45Z2EhMvniOkJ9Ho2OovyuGaI/iehouFCNbH4yyCJHxc+
	 LIbCDXe5Aiftg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 11/21] perf python: Refactor and add accessors to
 sample event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615223011.3873955-12-irogers@google.com>
References: <20260615223011.3873955-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 00:54:21 +0000
Message-Id: <20260616005422.74BC41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Accessor functions for `dso` blindly dereference the result of `ma=
p__dso()` which can be NULL.
- [Medium] 64-bit map start and end addresses are truncated to 32 bits when=
 `perf` is compiled on a 32-bit host.
--

commit 18ea80c7f1771915bbf09a1482be621af384623d
Author: Ian Rogers <irogers@google.com>

perf python: Refactor and add accessors to sample event

Add common evsel field for events and move sample specific fields to
only be present in sample events. Add accessors for sample
events. Ensure offsets are within the bounds of the event. Allocate
just enough memory for the copied event, don't make the maximum event
size each time.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index dc71fe7e37877..72d297156ad05 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c

[ ... ]

> @@ -394,6 +451,199 @@ get_tracepoint_field(struct pyrf_event *pevent, PyO=
bject *attr_name)
>  }
>  #endif /* HAVE_LIBTRACEEVENT */
> =20
> +static int pyrf_sample_event__resolve_al(struct pyrf_event *pevent)
> +{

[ ... ]

> +static PyObject *pyrf_sample_event__get_dso(struct pyrf_event *pevent,
> +					    void *closure __maybe_unused)
> +{
> +	if (pyrf_sample_event__resolve_al(pevent) < 0 || !pevent->al.map)
> +		Py_RETURN_NONE;
> +
> +	return PyUnicode_FromString(dso__name(map__dso(pevent->al.map)));

[Severity: High]
Does this code risk a NULL pointer dereference? map__dso() can return NULL =
for
certain mappings, and passing it unconditionally to dso__name() would crash
the python process.

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

[Severity: High]
Can map__dso() return NULL here as well, leading to a NULL pointer derefere=
nce
in dso__long_name()?

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

[Severity: High]
Similarly, if map__dso() returns NULL, will this cause a crash when passed =
to
dso__bid()?

> +	return PyUnicode_FromString(sbuild_id);
> +}
> +
> +static PyObject *pyrf_sample_event__get_map_start(struct pyrf_event *pev=
ent,
> +						  void *closure __maybe_unused)
> +{
> +	if (pyrf_sample_event__resolve_al(pevent) < 0 || !pevent->al.map)
> +		Py_RETURN_NONE;
> +
> +	return PyLong_FromUnsignedLong(map__start(pevent->al.map));

[Severity: Medium]
Since map__start() returns a u64, will PyLong_FromUnsignedLong() truncate t=
he
upper 32 bits of the address on 32-bit hosts? This might break cross-platfo=
rm
analysis when analyzing 64-bit perf.data files. Should this use
PyLong_FromUnsignedLongLong() instead?

> +}
> +
> +static PyObject *pyrf_sample_event__get_map_end(struct pyrf_event *peven=
t,
> +						void *closure __maybe_unused)
> +{
> +	if (pyrf_sample_event__resolve_al(pevent) < 0 || !pevent->al.map)
> +		Py_RETURN_NONE;
> +
> +	return PyLong_FromUnsignedLong(map__end(pevent->al.map));

[Severity: Medium]
Will this also truncate the 64-bit end address on 32-bit hosts?

> +}
> +
> +static PyObject *pyrf_sample_event__get_map_pgoff(struct pyrf_event *pev=
ent,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615223011.3873=
955-1-irogers@google.com?part=3D11
