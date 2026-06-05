Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8A8480DED
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780646916; cv=none; b=LoHic9vuxfPGkZYeakFPR37KavNxVZcfEajaHDDDb7hUhnXOut/FjTerKvW1mKUNAuPa9VIS5hH1+5tutE7OMAEG3yI81kpFyObxP7fPFP3euX0Cjzq/01F+xUm9VHvHghH3SmU0/La3dADjDDQkM1gcW4lFgW3A0TcDVoTKOB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780646916; c=relaxed/simple;
	bh=8HSYUI1YjD4xTmJp5eieXGhnK/blv5XdnQyYg0+uVd0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bzTFsnCw1LboX9jvGjcf8GDs8lWpzbyXk/hx+719ImLcQVYHyUE1jAzWlG3XxWo3cdi1nxwqcsVpJnEmIdSAJDorCU2zLW0HZVoPdPdyCVr6a1N+Q2cLSnRATU9JtL1ZVvjHcqNXJMkWk3ERLGzAU5kCbzo8vIK3SJy5JWCdynA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R23wj9bV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R23wj9bV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2121F00893;
	Fri,  5 Jun 2026 08:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780646915;
	bh=CO5ZvqlDx9nU6T23c6qHdksapC8oNJV7g3RU8edcCmU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R23wj9bVJn/RP423rmuD0yLKIYzhGsfjoUdrAopPc/YlwC+fry6Ruds4NAqedYARf
	 P2yrAknGNsNAR/krJxf2Y8TQu4I/I75DHvvKzTE4kHYPRf+ilYE2u8UeSeCVW9rhmW
	 RM/2bDWSwK7ZuajNXljH3FBq/YTiheQjBg5cB7QFMeApdSPQcL6IUYTCG9RrQkfg14
	 UgNv9izbx/kyDwFer6XGYco+tU/CElTTCbZ4dFQvZL1stsggrc2BRNxtCiaCCINGk6
	 PvEuMgjTzkUn9y4w/z/M+g7Akqqf2zA8o95E80brSbKMpnbfzXoLUopj6qbOrhtwLe
	 SrAD7ON81saBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 07/19] perf evlist: Add reference count checking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605074003.1730715-8-irogers@google.com>
References: <20260605074003.1730715-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 08:08:34 +0000
Message-Id: <20260605080834.9D2121F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The cycle-breaking logic in `evlist__put()` suffers from a Time-of=
-Check to Time-of-Use (TOCTOU) race condition that can result in a double f=
ree if multiple threads drop their references concurrently.
- [High] Added `evsel__get()` calls in `util/session.c` for deferred sample=
 delivery unconditionally leak `evsel` references for every processed sampl=
e where `!sample->evsel` is initially true or during deferred callchain del=
ivery.
- [Medium] Raw pointer assignments of the newly reference-counted `evlist` =
handle are used instead of acquiring explicit references via `evlist__get()=
`.
--

commit 58a195e1af66c9cff3bb966d4b7b789d6cee0f42
Author: Ian Rogers <irogers@google.com>

perf evlist: Add reference count checking

This commit introduces reference count checking for the perf evlist
subsystem. It replaces direct struct accesses with new accessor functions
and adds lifecycle macros to pair gets and puts.

> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util=
/cs-etm.c
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -319,7 +319,7 @@ static int cs_etm_recording_options(struct auxtrace_r=
ecord *itr,
[ ... ]
>  	/* no need to continue if at least one event of interest was found */
>  	if (!cs_etm_evsel)
>  		return 0;
> =20
>  	ptr->evlist =3D evlist;

[Severity: Medium]
Should this raw pointer assignment use evlist__get() instead?

With the transition to reference-counted handles, bypassing the explicit
lifecycle helpers leaves the raw pointer vulnerable to becoming a dangling
handle if the original reference is dropped.

>  	ptr->snapshot_mode =3D opts->auxtrace_snapshot_mode;
> =20
>  	if (!record_opts__no_switch_events(opts) &&
[ ... ]
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -3825,7 +3825,7 @@ static int perf_sched__schedstat_record(struct perf=
_sched *sched,
[ ... ]
>  	if (IS_ERR(session)) {
>  		pr_err("Perf session creation failed.\n");
>  		evlist__put(evlist);
>  		return PTR_ERR(session);
>  	}
> =20
>  	session->evlist =3D evlist;

[Severity: Medium]
Does this assignment bypass the reference counting API?

Assigning the handle directly without evlist__get() might result in a
use-after-free if the main reference drops.

> =20
>  	sched->session =3D session;
>  	sched->data =3D &data;
[ ... ]
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1296,7 +1296,7 @@ static int __cmd_top(struct perf_top *top)
[ ... ]
>  	evlist__uniquify_evsel_names(top->evlist, &stat_config);
>  	ret =3D perf_top__start_counters(top);
>  	if (ret)
>  		return ret;
> =20
>  	top->session->evlist =3D top->evlist;

[Severity: Medium]
Could this be updated to top->session->evlist =3D evlist__get(top->evlist)
to ensure the reference is correctly tracked?

>  	perf_session__set_id_hdr_size(top->session);
> =20
>  	/*
[ ... ]
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -200,52 +200,81 @@ static void evlist__purge(struct evlist *evlist)
[ ... ]
>  void evlist__put(struct evlist *evlist)
>  {
> +	struct evsel *evsel;
> +	unsigned int count, ref_cnt;
> +
>  	if (evlist =3D=3D NULL)
>  		return;
> =20
> -	if (!refcount_dec_and_test(&evlist->refcnt))
> -		return;
> +	if (refcount_dec_and_test(evlist__refcnt(evlist)))
> +		goto out_delete;
> +
> +retry:
> +	count =3D refcount_read(evlist__refcnt(evlist));
> +	ref_cnt =3D count;
> +	evlist__for_each_entry(evlist, evsel) {
> +		if (RC_CHK_EQUAL(evsel->evlist, evlist) && count)
> +			count--;
> +	}
> +	if (refcount_read(evlist__refcnt(evlist)) !=3D ref_cnt)
> +		goto retry;
> =20
> +	if (count !=3D 0) {
> +		/*
> +		 * Not the last reference except for back references from
> +		 * evsels.
> +		 */
> +		RC_CHK_PUT(evlist);
> +		return;
> +	}
> +out_delete:

[Severity: High]
Can this result in a double free if multiple threads drop their references
concurrently?

If two threads execute this path simultaneously after failing
refcount_dec_and_test(), they could both read the same count, apply the same
decrements, evaluate count =3D=3D 0 as true, and fall through to out_delete
concurrently.

Would it be safer to protect this back-reference resolution with a lock?

>  	evlist__free_stats(evlist);
[ ... ]
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1852,7 +1852,7 @@ static int evlist__deliver_deferred_callchain(struc=
t evlist *evlist,
[ ... ]
>  			orig_sample.deferred_callchain =3D false;
> =20
>  		orig_sample.evsel =3D evlist__id2evsel(evlist, orig_sample.id);
> +		if (orig_sample.evsel)
> +			orig_sample.evsel =3D evsel__get(orig_sample.evsel);
>  		ret =3D evlist__deliver_sample(evlist, tool, de->event,
>  					     &orig_sample, machine);
> =20

[Severity: High]
Does this sequence leak the evsel reference during deferred callchain deliv=
ery?

We acquire a new reference via evsel__get(), but the lifecycle of the
sample is managed by perf_sample__init() and perf_sample__exit().

The perf_sample__exit() function does not release the sample->evsel
reference, as it has historically treated the pointer as borrowed.

Without a corresponding evsel__put(), won't every such processed event or
deferred sample permanently leak its evsel reference?

> @@ -1901,7 +1903,7 @@ static int session__flush_deferred_samples(struct p=
erf_session *session,
[ ... ]
>  		sample.file_offset =3D de->file_offset;
> =20
>  		sample.evsel =3D evlist__id2evsel(evlist, sample.id);
> +		if (sample.evsel)
> +			sample.evsel =3D evsel__get(sample.evsel);
>  		ret =3D evlist__deliver_sample(evlist, tool, de->event,
>  					     &sample, machine);

[Severity: High]
Can this also leak the reference for the same reasons as above?

When sample.evsel is populated using evsel__get(), it seems we are missing a
cleanup step after the sample is delivered.

> @@ -1959,21 +1963,23 @@ static int machines__deliver_event(struct machine=
s *machines,
[ ... ]
>  	dump_event(evlist, event, file_offset, sample, file_path);
> =20
> -	if (!sample->evsel)
> +	if (!sample->evsel) {
>  		sample->evsel =3D evlist__id2evsel(evlist, sample.id);
> -	else
> +		if (sample->evsel)
> +			sample->evsel =3D evsel__get(sample->evsel);
> +	} else {
>  		assert(sample->evsel =3D=3D evlist__id2evsel(evlist, sample.id));
> -
> +	}

[Severity: High]
Does this similarly leak an evsel reference for every processed sample where
sample->evsel is initially missing?

The evsel__get() call holds a reference, but it does not appear to be track=
ed
or released when the sample processing concludes.

>  	machine =3D machines__find_for_cpumode(machines, event, sample);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605074003.1730=
715-1-irogers@google.com?part=3D7
