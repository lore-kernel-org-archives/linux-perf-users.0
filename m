Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D955538CFE8
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779489641; cv=none; b=nv5AI9Cl69871FOUuIDNuLeuuUirt4RaKOmtLThnpXG8qWqtYo63bd/ILfN4nbF2K1ci4304NtLmgN/Q9Mun9k2Ldw3+yHHPbZ6BtxcVORaKXR36Elg3MxLmzNAxJQat1qyGIl+xMrDkYuL1A0ck70wFyRYiP9rp+cEr8xuK8+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779489641; c=relaxed/simple;
	bh=a7ABK3AsnkjqyqshOOV2j8dNJhNFvijHIVbFF6yJUJU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ol3O0dNonezxhGnk0Ic7TgF4G0r/2rHwz58QoT7k6dJPqJ7w6m/uXxHcgKFpmO8I8Fqc2nM4EZ0a6FTBQwF3SXPXOHz9IMlS8kAZN7cmPkNmPB+Hry+DfBSnC51K7ytd4Xpzj2jZB1O28n9R28fVwqske+KJ9ujLeTcBFox43UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VE/10brM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VE/10brM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD5C1F00A3D;
	Fri, 22 May 2026 22:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779489639;
	bh=hEL9oq0IkOP0jPmEw8obW3wicZ9GaWpdxu+/9HePqQM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VE/10brMZNym9WZFKXSWLdS2NFCupYcIuOSKh6pSETl1ViJZ5ojFuq/wDJsVAs2Xr
	 6YBOf91Ma4KTFvULZIgR6k1s6aHMT6ZUPj1De8C44g+x6B+ndBS5GItLt6nkBMPIpg
	 NNOo4TIKLP7ZiZnsomH7MiCwpo9GCF2nTq2unhab4yhyX8as5FoHEsIfCC+NGGyCkF
	 ijt8pj4yo/qoyW6/LrqjTrztpY60MtDhtRux95rHq+4PMxcGsubjJlKNt3DLtnH1u0
	 qy0gWdPZOyTrlSNRdTEgLITHX3xIjjxO959/DrG88mbKNiIQybox+q8iASQA788/6E
	 l9VnDK3knpojw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 11/23] perf evlist: Add reference count checking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260522220435.2378363-12-irogers@google.com>
References: <20260522220435.2378363-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 22:40:39 +0000
Message-Id: <20260522224039.9DD5C1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Asymmetric reference counting of `sample->evsel` causes memory lea=
ks and premature frees when processing synthesized events or deferred sampl=
es.
- [High] Concurrent calls to `evlist__put` can result in a double-free or U=
se-After-Free of the `evlist` object due to a TOCTOU race.
- [Low] Missing cleanup of dynamically allocated `evsel` on `malloc` failur=
e in `do_test()`.
- [Low] Mixed declaration and statement violates C89 standard in `cs_etm__s=
ynth_branch_sample`.

Pre-existing issues:
- [High] Reassigning the passed `evlist` pointer by value in `iostat_prepar=
e()` causes a Use-After-Free in the caller.
--

commit f7fbc61f05122c32f095347ca87933eb1cf01ec1
Author: Ian Rogers <irogers@google.com>
Date:   Fri May 22 22:04:22 2026 +0000

    perf evlist: Add reference count checking

    Now the evlist is reference counted, add reference count checking so
    that gets and puts are paired and easy to debug. This patch is adding
    accessors to evlist functions and switching to their use.

> diff --git a/tools/perf/arch/x86/util/iostat.c b/tools/perf/arch/x86/util=
/iostat.c
> index e0417552b0cbd..a0baa6cdefd89 100644
> --- a/tools/perf/arch/x86/util/iostat.c
> +++ b/tools/perf/arch/x86/util/iostat.c
> @@ -334,7 +334,7 @@ static int iostat_event_group(struct evlist *evl,
> =20
>  int iostat_prepare(struct evlist *evlist, struct perf_stat_config *confi=
g)
>  {
> -	if (evlist->core.nr_entries > 0) {
> +	if (evlist__nr_entries(evlist) > 0) {
>  		pr_warning("The -e and -M options are not supported."
>  			   "All chosen events/metrics will be dropped\n");
>  		evlist__put(evlist);
>  		evlist =3D evlist__new();

[Severity: High]
This is a pre-existing issue, but doesn't reassigning the evlist parameter
by value here cause a use-after-free in the caller? Since the caller in
cmd_stat retains its original pointer after iostat_prepare returns, it
seems it would point to freed memory.

> diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-=
parsing.c
> index 55f0b73ca20e0..5db85f996cd8c 100644
> --- a/tools/perf/tests/sample-parsing.c
> +++ b/tools/perf/tests/sample-parsing.c
[ ... ]
> @@ -311,7 +312,7 @@ static int do_test(u64 sample_type, u64 sample_regs, =
u64 read_format)
>  	}
> =20
>  	sz =3D perf_event__sample_event_size(&sample, sample_type, read_format,
> -					   evsel.core.attr.branch_sample_type);
> +					   evsel->core.attr.branch_sample_type);
>  	bufsz =3D sz + 4096; /* Add a bit for overrun checking */
>  	event =3D malloc(bufsz);
>  	if (!event) {
>  		pr_debug("malloc failed\n");
>  		return -1;
>  	}

[Severity: Low]
Does this leak the dynamically allocated evsel when malloc fails?
Because the function returns -1 directly here, it bypasses the out_free
label and evsel__put, losing the reference to the newly created evsel.

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 6ec48de294410..fff1f38b50619 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1636,8 +1636,10 @@ static int cs_etm__synth_branch_sample(struct cs_e=
tm_queue *etmq,
>  {
>  	int ret =3D 0;
>  	struct cs_etm_auxtrace *etm =3D etmq->etm;
> -	struct perf_sample sample =3D {.ip =3D 0,};
> +	struct perf_sample sample;
>  	union perf_event *event =3D tidq->event_buf;
> +
> +	perf_sample__init(&sample, /*all=3D*/true);
>  	struct dummy_branch_stack {
>  		u64			nr;
>  		u64			hw_idx;

[Severity: Low]
Could this cause a build failure on compilers enforcing C89 standards?
The function call to perf_sample__init is placed before the declaration of
the dummy_branch_stack struct, creating a mixed declaration and statement.

> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index a362f338f1044..82e9a7ade4fc2 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
[ ... ]
> @@ -208,18 +215,35 @@ static void evlist__exit(struct evlist *evlist)
> =20
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
Is this custom cyclic reference checking algorithm thread-safe?
If two threads concurrently drop an external reference via evlist__put,
could one thread reach 0 and proceed to out_delete to free the object,
while the other thread evaluates count =3D=3D 0 after subtracting cyclic
references and jumps to out_delete as well? This TOCTOU race seems like
it could result in a double-free or use-after-free.

> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 43fef473bbb49..32c99dbfd42b8 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
[ ... ]
> @@ -1400,6 +1402,8 @@ static int evlist__deliver_deferred_callchain(struc=
t evlist *evlist,
>  			orig_sample.deferred_callchain =3D false;
> =20
>  		orig_sample.evsel =3D evlist__id2evsel(evlist, orig_sample.id);
> +		if (orig_sample.evsel)
> +			orig_sample.evsel =3D evsel__get(orig_sample.evsel);
>  		ret =3D evlist__deliver_sample(evlist, tool, de->event,
>  					     &orig_sample, machine);
> =20
[ ... ]
> @@ -1438,6 +1442,8 @@ static int session__flush_deferred_samples(struct p=
erf_session *session,
>  		}
> =20
>  		sample.evsel =3D evlist__id2evsel(evlist, sample.id);
> +		if (sample.evsel)
> +			sample.evsel =3D evsel__get(sample.evsel);
>  		ret =3D evlist__deliver_sample(evlist, tool, de->event,
>  					     &sample, machine);
> =20
[ ... ]
> @@ -1465,21 +1469,23 @@ static int machines__deliver_event(struct machine=
s *machines,
> =20
>  	dump_event(evlist, event, file_offset, sample, file_path);
> =20
> -	if (!sample->evsel)
> +	if (!sample->evsel) {
>  		sample->evsel =3D evlist__id2evsel(evlist, sample->id);
> -	else
> +		if (sample->evsel)
> +			sample->evsel =3D evsel__get(sample->evsel);
> +	} else {

[Severity: High]
Can the asymmetric reference counting of sample->evsel cause a memory leak
or premature free? It appears that evsel__get is called in these new code
blocks when resolving the evsel by ID, but perf_sample__exit does not call
evsel__put. This looks like it would result in a permanent memory leak.

Additionally, if the evsel is populated via evlist__parse_sample it does
not hold a reference, creating an ownership inconsistency that could lead
to a use-after-free if an explicit put is called elsewhere expecting the
get to have occurred.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522220435.2378=
363-1-irogers@google.com?part=3D11
