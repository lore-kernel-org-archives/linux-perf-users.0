Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497AB331EAB
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 22:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781303564; cv=none; b=j+9KQVqMMHXXKecYN4lOT3xU6S2mAhTDix5a9h2mssfWDWaEfe4l6cjYcVqW0FM96IW70TZK+clySlzwcNElWyWa8MD8PSDYvFgQL3fICceZYiU5xxFGQwQLKqbsiEINDLv/dQ/CwUTzenHcBTOA9YgpRQqjhx4CCPOYx7WiThI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781303564; c=relaxed/simple;
	bh=osFaJvuceDg83WMRV0hmaMjNVTYi/vxtJazhyxIGngQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h3jt6l/ZOfrUbzSa8Bw+25Ja90ewK0aIOIKLc5dFojaKqHt+QHAGgpG3GrIDTBU5cIK7bIhVoF2i740de3oFtzgY2mHWuWOpbMP0BjWy9hvwptcCkhT/3G9jKx39MgFY9TYKkTvLr1g5251o0mULEbHHvHRaslKp1N6JrzIRBX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SM+6BhvK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SM+6BhvK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71781F000E9;
	Fri, 12 Jun 2026 22:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781303562;
	bh=9N9Dk/NYD8UgbGQyZhENis/TPBjK4GrT4K2OE7wNHvw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SM+6BhvKXoK3HTHBkU3bhEePLw9fbYkELKtvtLZKUWEhnv66gwsK1vKKSpwWyLhXp
	 IpsAYDYojq+SubwBVd9KBSXSFMm80nqu4RctadGKt/00btYXqplzSbB4KYxM09YkWn
	 aSpefnPM5JPen1GJR45IlZ/5aJ5lmEQUzLdXBetKElojDhQySy9QwC0B1F/d9zQ0Jb
	 Yl5KGG9RVbr8+sJ98XhKT/sn0mqJekBlS24VvbVPQ0hghgi5bKHkoBRClvq9TBdH/Z
	 hT2IhkJ5aiRctDYLUN7+R0YNLDN4rZ0Q0mepeeAnN38EDGU1RHDpI9n6hFC9cxDW6v
	 HqEVKzawtzweQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 14/19] perf python: Extend API for stat events in
 python.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260612221211.1221305-15-irogers@google.com>
References: <20260612221211.1221305-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 22:32:42 +0000
Message-Id: <20260612223242.B71781F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Calling `perf_session__process_events` from Python on a `perf.data=
` file containing `PERF_RECORD_STAT` events without explicitly providing a =
`stat` callback will cause a segmentation fault.
--

commit 77ed782811229e6257147595967331dc103b7a95
Author: Ian Rogers <irogers@google.com>

perf python: Extend API for stat events in python.c

Add stat information to the session. Add call backs for stat events.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index ce1e32e919190..ff8b893af2ba5 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -3460,8 +3625,13 @@ static PyObject *pyrf_session__new(PyTypeObject *t=
ype, PyObject *args, PyObject
>  	} while (0)
> =20
>  	ADD_TOOL(sample);
> +	ADD_TOOL(stat);
>  	#undef ADD_TOOL
> =20
> +	if (stat)
> +		psession->tool.stat_round =3D pyrf_session_tool__stat_round;
> +
> +
>  	psession->tool.comm		=3D perf_event__process_comm;
>  	psession->tool.mmap		=3D perf_event__process_mmap;
>  	psession->tool.mmap2            =3D perf_event__process_mmap2;
> @@ -3474,7 +3644,8 @@ static PyObject *pyrf_session__new(PyTypeObject *ty=
pe, PyObject *args, PyObject
>  	psession->tool.build_id         =3D perf_event__process_build_id;
>  	psession->tool.attr		=3D perf_event__process_attr;
>  	psession->tool.feature		=3D perf_event__process_feature;
> -	psession->tool.stat		=3D perf_event__process_stat_event;
> +	if (!stat)
> +		psession->tool.stat	=3D perf_event__process_stat_event;

[Severity: High]
Does this code cause a segmentation fault when a stat callback is not
provided?

In tools/perf/util/python.c:pyrf_session__new(), when no stat callback
is passed to perf.session(), the code defaults to using
perf_event__process_stat_event() as the callback.

However, the Python bindings never appear to call evlist__alloc_stats()
to allocate memory for the counter values. When a PERF_RECORD_STAT
event is encountered, it triggers this path:

perf_session__process_events()
  perf_event__process_stat_event()
    perf_counts(counter->counts, ...)

Since counter->counts is unallocated, perf_counts() evaluates to
&(NULL->values[...]), causing a null pointer dereference.

Can this regression be triggered by simply calling
perf_session__process_events() on a perf.data file containing
PERF_RECORD_STAT events (like those generated by perf stat record)
without providing a stat callback?

>  	session =3D perf_session__new(&pdata->data, &psession->tool);
>  	if (IS_ERR(session)) {
>  		PyErr_Format(PyExc_IOError, "failed to create session: %ld", PTR_ERR(s=
ession));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612221211.1221=
305-1-irogers@google.com?part=3D14
