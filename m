Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9586425B08C
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Jul 2026 19:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785007831; cv=none; b=FlWPmWoFkV6R4ecI8fKIZSHXJ8LE6GaeVT8AarGtpfgaKunO5qsns282bzNJ24fhBldyjcHpKUDGOYY8ZE4pgYC9J2yqdu7NCDhaQe6t4kmSCgoLeRU7mYZtbRGJRirCl2oREF3FxZQTm3tkBiXVV5bTYJeHl62vE5Q2er+eAVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785007831; c=relaxed/simple;
	bh=m6FRUdrmaGMqnWex9CFS6N+2BTnrqe0v56wbnyYuYP8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fMn+dMgEdtm3kn1/j0GOR4mqzcX6sedHNHNVBzuLPiz424A7qMA7/ODFURo4sxqvxVPgkgE367az7E/ntPaNaIruO++qOv21qE8DsWsfEE2TsA5tZ6sesvC4n9nYkGFALZh3hkVk3EYJQHETJHdgRJ6/4GQYwdE+Ar8vGlNvb0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HC2z2K4u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HC2z2K4u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F80C1F000E9;
	Sat, 25 Jul 2026 19:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785007830;
	bh=OZ7Nzirm2ohS7W2mz3Q+3mkpta+p6drYS4M9DL65MdE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HC2z2K4uWL/ELP6RSmONKZ8gLlQphSdvf1Calv2cgbWcL6w+hiC2dd4OUVGTLskcO
	 l9aAI9ZWNz0HndHMED8DfvbsnhldzUvt/VjfDYAa0Mb5mihFtSUKqA5DASTtdkP4KA
	 Jm1VllBF3ypsaMAZamJ5OIdF8Yl+wKB4WdQBiGJlTyKOTi2eIQEB+JLEQFsbbOFXpZ
	 S50iOYZhKydG4kmpdOnK2DXdB9kqEKa+Hz9q4IVyImjo1gb5+31MuhmUH5L9oPHMRR
	 V/gPAH/jEOGKIIkgtwSPfodu/4CiTxIIQeIx2B7SxutO04+YJfR3x02+afoC2SVrJj
	 0OGeyMwOXodHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/5] perf trace-event: Avoid double free and leak in
 trace_event__cleanup()/trace_event__init()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tanushree Shah" <tshah@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260725184953.234759-4-tshah@linux.ibm.com>
References: <20260725184953.234759-1-tshah@linux.ibm.com>
 <20260725184953.234759-4-tshah@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 19:30:29 +0000
Message-Id: <20260725193030.0F80C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Fixing a memory leak in `trace_event__init()` introduces an ex=
ploitable Use-After-Free when processing malformed or crafted `perf.data` f=
iles with multiple `PERF_RECORD_HEADER_TRACING_DATA` headers.
--

--- Patch [3]: [PATCH v4 3/5] perf trace-event: Avoid double free and leak =
in trace_event__cleanup()/trace_event__init() ---
commit 47e0085adcff000a3a6472e037799a5ddd33c012
Author: Tanushree Shah <tshah@linux.ibm.com>

perf trace-event: Avoid double free and leak in trace_event__cleanup()/trac=
e_event__init()

This commit addresses a double-free in trace_event__cleanup() and a memory
leak in trace_event__init() when a perf.data file contains multiple
PERF_RECORD_HEADER_TRACING_DATA headers. It fixes the leak by calling
trace_event__cleanup() before allocating a new tep handle.

> diff --git a/tools/perf/util/trace-event.c b/tools/perf/util/trace-event.c
> index 6a8c66c64b705..000c1e1d68c16 100644
> --- a/tools/perf/util/trace-event.c
> +++ b/tools/perf/util/trace-event.c
> @@ -26,7 +26,11 @@ static bool tevent_initialized;
> =20
>  int trace_event__init(struct trace_event *t)
>  {
> -	struct tep_handle *pevent =3D tep_alloc();
> +	struct tep_handle *pevent;
> +
> +	trace_event__cleanup(t);
> +

[Severity: Critical]
Could this cleanup introduce a use-after-free when parsing a perf.data
file with multiple PERF_RECORD_HEADER_TRACING_DATA headers?

When trace_event__cleanup(t) frees the existing tep_event objects, any=20
evsel->tp_format pointers that were set during the first header's parsing=20
are left dangling.

Specifically, in tools/perf/util/header.c:evsel__prepare_tracepoint_event(),
it short-circuits if the pointer is already set:

	/* already prepared */
	if (evsel->tp_format)
		return 0;

This short-circuit prevents evsel->tp_format from being updated to point to
the newly allocated memory. Later, tools/perf/util/evsel.c:evsel__tp_format=
()
retrieves this dangling pointer:

	if (tp_format)
		return tp_format;

Does this leave the perf tool vulnerable to memory corruption when analyzing
a malformed or maliciously crafted perf.data file?

> +	pevent =3D tep_alloc();
> =20
>  	if (pevent) {
>  		t->plugin_list =3D tep_load_plugins(pevent);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725184953.2347=
59-1-tshah@linux.ibm.com?part=3D3
