Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4D0339853
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 23:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781564579; cv=none; b=GRBSfr9A70zoS2WyRjD4/dt5kuH3T3YVqR8vxvO5Ml6ApEyRPqIGOMrrcijC7fz0spzc5NFP5giLi2BAakg/6UsER7BAwSCgn3ycdgi8PKNMp8cDFw2fheXRsUkUUAM/eLtSSsTQEbeo/bNVKCgjAxxRfTQDrlD1LxLk34pP4U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781564579; c=relaxed/simple;
	bh=nq3atYby2c9tZY3JhW8oyWP+iqwjYQJfAtxsYyGBaho=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=klW9C6ji6TorSlvQmrpM9ObBViLdkSd8XKkcyofaQLd0Ow4Uj2s/uyurlF5rctAqcGX3gkeeH1U7+kw31g5j48BV0mYYg0LQJN3CKLjGR1Y5H4Mrj9ErFUycTTzaaIrvngGkJYE/IKsagqUgrPClghjdHt0MbX6PVWGeQD0KuFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edXlrzud; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edXlrzud"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B7FD1F000E9;
	Mon, 15 Jun 2026 23:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781564577;
	bh=Ln8MmH1V4nnJ7LtHp51rOiByRMYo6+ErBZxf8vyJSrs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=edXlrzudwVzCjhFMSO7jzebi3q4QO/q4t6KFvux2ULnkdFlkEXKPKdEmxTa2RGrXk
	 zrYnNXpANWc6k8//38rr735G+uvfdWQZDLyBO1VM9cO/01Ku7qlCgK1b41cYAEvrcr
	 ILFkRBApTo2FiS9GIOeiltbTpv5OUWFky9A7RogOvV2eBjVyfaeezGdhPICK27BRB8
	 hQ62Xzo/sWyzsE/TOafUOVJkA2MJ168VO03gvIfEb7ktYAQo71b6nfPMwtQBEt3dgz
	 tmZVUP67yv9OkOA52JCR5SSJKlcBmUw6PM9OTB6pK2og1p5wRwHjcDyDQAR0SXT4Zr
	 2GdOkHgT0O34Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 08/21] perf python: Use evsel in sample in
 pyrf_event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615223011.3873955-9-irogers@google.com>
References: <20260615223011.3873955-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 23:02:56 +0000
Message-Id: <20260615230257.6B7FD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Unchecked NULL pointer passed to evsel__get() causes a segmentat=
ion fault on malformed perf.data.
- [Medium] Memory leak of evsel reference and dynamic perf_sample fields on=
 the error path in test__perf_time_to_tsc.
--

commit 84354b1d17171465e121f0b606e0dbe0206da819
Author: Ian Rogers <irogers@google.com>

perf python: Use evsel in sample in pyrf_event

Avoid a duplicated evsel by using the one in sample. Add
evsel__get/put to the evsel in perf_sample.

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index ec759a11f7588..d79112cebb716 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3365,7 +3365,7 @@ int __evsel__parse_sample(struct evsel *evsel, unio=
n perf_event *event,
>  	union u64_swap u;
> =20
>  	perf_sample__init(data, /*all=3D*/true);
> -	data->evsel =3D evsel;
> +	data->evsel =3D evsel__get(evsel);

[Severity: Medium]
Does acquiring the reference this early introduce a leak on error paths?

If evsel__parse_sample() fails later in this function (e.g., when jumping to
out_efault), the caller receives an error code but the evsel reference has
already been taken.

For example, in tools/perf/tests/perf-time-to-tsc.c:test__perf_time_to_tsc(=
):

    CHECK__(evsel__parse_sample(evsel, event, &sample));
    ...
out_err:
    evlist__put(evlist);

If parsing fails, it exits without calling perf_sample__exit(). Could this
leave a valid evsel reference inside the sample and leak it?

>  	data->cpu =3D data->pid =3D data->tid =3D -1;
>  	data->stream_id =3D data->id =3D data->time =3D -1ULL;
>  	data->period =3D evsel->core.attr.sample_period;

[ ... ]

> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 89d0f4cec6c7f..18af70488e07a 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1854,6 +1854,7 @@ static int evlist__deliver_deferred_callchain(struc=
t evlist *evlist,
> =20
>  	list_for_each_entry_safe(de, tmp, evlist__deferred_samples(evlist), lis=
t) {
>  		struct perf_sample orig_sample;
> +		struct evsel *new_evsel;
> =20
>  		perf_sample__init(&orig_sample, /*all=3D*/false);
>  		ret =3D evlist__parse_sample(evlist, de->event, &orig_sample);
> @@ -1874,7 +1875,11 @@ static int evlist__deliver_deferred_callchain(stru=
ct evlist *evlist,
>  		else
>  			orig_sample.deferred_callchain =3D false;
> =20
> -		orig_sample.evsel =3D evlist__id2evsel(evlist, orig_sample.id);
> +		new_evsel =3D evlist__id2evsel(evlist, orig_sample.id);
> +		if (new_evsel !=3D orig_sample.evsel) {
> +			evsel__put(orig_sample.evsel);
> +			orig_sample.evsel =3D evsel__get(new_evsel);

[Severity: Medium]
Can new_evsel be NULL here?

If a perf.data file is crafted with a malformed sample ID,
evlist__id2evsel() will return NULL. Will passing this NULL pointer to
evsel__get() cause a segmentation fault when it attempts to increment the
reference count?

> +		}
>  		ret =3D evlist__deliver_sample(evlist, tool, de->event,
>  					     &orig_sample, machine);
> =20
> @@ -1903,6 +1908,7 @@ static int session__flush_deferred_samples(struct p=
erf_session *session,
> =20
>  	list_for_each_entry_safe(de, tmp, evlist__deferred_samples(evlist), lis=
t) {
>  		struct perf_sample sample;
> +		struct evsel *new_evsel;
> =20
>  		perf_sample__init(&sample, /*all=3D*/false);
>  		ret =3D evlist__parse_sample(evlist, de->event, &sample);
> @@ -1913,7 +1919,11 @@ static int session__flush_deferred_samples(struct =
perf_session *session,
>  		}
>  		sample.file_offset =3D de->file_offset;
> =20
> -		sample.evsel =3D evlist__id2evsel(evlist, sample.id);
> +		new_evsel =3D evlist__id2evsel(evlist, sample.id);
> +		if (new_evsel !=3D sample.evsel) {
> +			evsel__put(sample.evsel);
> +			sample.evsel =3D evsel__get(new_evsel);

[Severity: Medium]
Does this have the same NULL pointer vulnerability as the previous location?

If evlist__id2evsel() returns NULL for an invalid sample ID, could calling
evsel__get() without a NULL check crash the perf tool?

> +		}
>  		ret =3D evlist__deliver_sample(evlist, tool, de->event,
>  					     &sample, machine);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615223011.3873=
955-1-irogers@google.com?part=3D8
