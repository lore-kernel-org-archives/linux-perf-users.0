Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F051A0B15
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776646118; cv=none; b=S11QMi6qpzWxyUj7VHYX5QwPQKpj+Q9FNdBjWWgV2TyM2r3lo+ZUgRuO8FptDkygOpliJZCsfQzhNMq4ZcELxl4LVT6dJKchlwwJqDDQ2dCYncf7tOYNDnx6cW38z5OxyAB6lBYC8zkG1Bi6n6TsEdPu7C3y6H6P652Y1R8uPxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776646118; c=relaxed/simple;
	bh=piKRlcZSjRPy5oWJ75R+wCkR2x2aAXjq5tQJIz3Bx04=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iHyGNofJXmHbGT69gNGypMYSSywcADVwZ67Q5cm5VG1BheJNZberU/GLtazHFRIUgBOKoiuSOJJyh8nD+HQ9usGLQJErv6WCw//L9NITV6jSblAihRo6rGVtSLxK9krr98DKuQS6bb4FP9KiY+SsDlAfUsrGt9SyN1lrreEOclQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKwNhDrt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKwNhDrt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31EFC2BCAF;
	Mon, 20 Apr 2026 00:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776646117;
	bh=piKRlcZSjRPy5oWJ75R+wCkR2x2aAXjq5tQJIz3Bx04=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=SKwNhDrtlUXFeK9L1ThOGdPSQotgzv43H/JJZtuA/BSKaLRh9+tXHIpaVbSemwHs4
	 AWGQrYj3jnAQo9z/3S7icKeFXLfwPdZ+vQJcESjsE4sy2BHmQ5RihbKclGDZI8SHHO
	 FBaBooU8PaYCktFykc/Qzj4X73L2ALIrQhyYlws5eipRNnawm/X3Zlmxj3/5tSpjaV
	 utZ6zLmKJf39iB4Y1r4GUZuds4ulo55bdbCEeazLYGnEntt8xgzOMD8ZgLUd8RY+xi
	 xrdwr2w86oZEPDEbGENHjqIqi6ezy+b4h2IaDuehQsSI4vD+0zYPD2ZLiwB6AHxXf/
	 +RxvnvQlZyEsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 18/58] perf python: Add callchain support
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-19-irogers@google.com>
References: <20260419235911.2186050-19-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:48:37 +0000
Message-Id: <20260420004837.C31EFC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [Critical] Lazy evaluation of callchain resolution accesses a transient m=
map buffer after it may have been overwritten or unmapped.
- [High] Missing NULL pointer check for `evsel` causes a deterministic cras=
h on uninitialized or malformed events.
- [High] Potential Use-After-Free (UAF) of `evlist` and `session` when acce=
ssing `evsel->evlist` during deferred evaluation.
- [Medium] Unprotected state modifications of global `symbol_conf` in insta=
nce initialization.
--

commit c812b2453db1f3bc8f2944a3e0a29148617b9c48
Author: Ian Rogers <irogers@google.com>

perf python: Add callchain support
   =20
Implement pyrf_callchain_node and pyrf_callchain types for lazy
iteration over callchain frames. Add callchain property to
sample_event.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 09b5667075638..6baf38a086901 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c

[ ... ]

> +static PyObject *pyrf_callchain__next(struct pyrf_callchain *pchain)
> +{
> +	struct pyrf_callchain_node *pnode;
> +
> +	if (!pchain->resolved) {
> +		struct evsel *evsel =3D pchain->pevent->sample.evsel;
> +		struct evlist *evlist =3D evsel->evlist;

If the event is manually instantiated in Python or yielded from a context
where the evsel lookup failed, evsel might be NULL. Could this cause a
NULL pointer dereference when accessing evsel->evlist?

> +		struct perf_session *session =3D evlist ? evlist->session : NULL;

The pyrf_event object holds a reference count to its evsel, keeping it
alive even if the parent evlist and perf_session are closed or garbage
collected.

Since evsel does not hold a strong reference back to evlist, could
evsel->evlist be a dangling pointer here once the evlist is destroyed?

If the Python script has dropped the session but retained the event,
would accessing evlist->session dereference freed memory?

> +		struct addr_location al;
> +		struct callchain_cursor *cursor;
> +		struct callchain_cursor_node *node;
> +		u64 i;
> +
> +		if (!session || !pchain->pevent->sample.callchain)
> +			return NULL;
> +
> +		addr_location__init(&al);
> +		if (machine__resolve(&session->machines.host, &al, &pchain->pevent->sa=
mple) < 0) {
> +			addr_location__exit(&al);
> +			return NULL;
> +		}
> +
> +		cursor =3D get_tls_callchain_cursor();
> +		if (thread__resolve_callchain(al.thread, cursor, evsel,
> +					      &pchain->pevent->sample, NULL, NULL,
> +					      PERF_MAX_STACK_DEPTH) !=3D 0) {

The callchain property defers resolution until iteration.

However, pchain->pevent->sample.callchain points directly into the
kernel's mmap ring buffer. If the Python script stores the callchain
and iterates it outside the immediate event callback, the underlying mmap
buffer might have already advanced or been unmapped.

Could this deferred parsing cause thread__resolve_callchain() to parse
overwritten memory or trigger a segfault? Would it be safer to perform
callchain resolution eagerly when the event is processed?

[ ... ]

> @@ -2836,6 +3035,9 @@ static int pyrf_session__init(struct pyrf_session *=
psession, PyObject *args, PyO
>  		return -1;
>  	}
> =20
> +	symbol_conf.use_callchain =3D true;
> +	symbol_conf.show_kernel_path =3D true;
> +	symbol_conf.inline_name =3D false;
>  	if (symbol__init(perf_session__env(psession->session)) < 0) {

symbol_conf is a process-wide global configuration structure.

Does modifying it unconditionally in pyrf_session__init() mean that
initializing a new Python perf.session instance could overwrite the global
configuration for all other concurrent sessions in the same Python process?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D18
