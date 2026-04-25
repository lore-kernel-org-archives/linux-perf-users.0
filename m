Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C339219ADA4
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 19:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777143993; cv=none; b=mx4IcU4l6RD0dH6/mx/VcQrDZNPO2q4SkiKuKeLjnfGbDh/SX/aKpd8af4fJi20SegaeOV/0gikE3wtiAzvzofpCBR04H5cWNOep2QGaXbh8r9gUze/UhMS9MhCXM+fEAPeCwNWGybl0bCXgzcOc4EMLNXAAoBWopJs61kEZSyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777143993; c=relaxed/simple;
	bh=MJ7LR+fDiG51rh0z50SoRHWyLtuCgRhVT0Ws2wtCSjw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WZ3zmfirYp336n5gZkpvYAtBKLTLnQu8jethTK3OR4LooCc9XFYJ+ReDKhZs0bFYSv3zEuLk+HP6ygunhapTg60dgi9Nfq2aeo7WE942sLqccWQcY+7wAOZ6/WNvhQLAtEl2aMM1jcp5K5lYra1jDagLOrqGYYuhQbeoyToSxr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDy0a0ln; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDy0a0ln"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7465AC2BCB0;
	Sat, 25 Apr 2026 19:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777143993;
	bh=MJ7LR+fDiG51rh0z50SoRHWyLtuCgRhVT0Ws2wtCSjw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=LDy0a0ln/kzCouBUT8OAdkvOkgAZGAbT1cMYbXJ1vYG3+JRKRG6yVYk8RuP8wSDsm
	 IFwuvD9HrHz/LMhIYkGCsYrYVThLc2Z9M2GiXXfR3vZCbzC3hsyHbn79xI5kr9hIKB
	 +YVPct9AZveGQsolGCYTDbOHRfoxUaCp+5/X56d4BQyUSiFfFInG/UN3cLzgbxzAZS
	 KoUWvtBJi2GPXFOaenz/iEYnH9Q3GRqLSfW+DWy2q6csx2cKcBjJLhhD7SPeGWpRlF
	 yq6i3fyPU3AHg1usbLHO8l6mEJ7LgVpv/rLoaERze3gmTpEWpdQOn6jM5w0CwdF0Hn
	 qj5cv71Hy5B/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 13/59] perf python: Use evsel in sample in pyrf_event
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-14-irogers@google.com>
References: <20260425174858.3922152-14-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 19:06:32 +0000
Message-Id: <20260425190633.7465AC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Python bindings leak the `evsel` reference for all non-SAMPLE even=
t types upon garbage collection.
- [High] Reassigning `sample.evsel` without dropping the existing reference=
 causes an evsel reference leak for deferred callchains.
--

commit 7853ce0ab6089ce39f4b73ee696251d881df5b58
Author: Ian Rogers <irogers@google.com>

perf python: Use evsel in sample in pyrf_event

Avoid a duplicated evsel by using the one in sample. Add evsel__get/put to
the evsel in perf_sample.

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 3015b9b4b4da..9b16d832810f 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3235,7 +3235,7 @@ int evsel__parse_sample(struct evsel *evsel, union =
perf_event *event,
>  	union u64_swap u;
> =20
>  	perf_sample__init(data, /*all=3D*/true);
> -	data->evsel =3D evsel;
> +	data->evsel =3D evsel__get(evsel);

Will this leak the evsel reference for non-SAMPLE event types in the Python
bindings?

In tools/perf/util/python.c, pyrf_evlist__read_on_cpu() calls
evsel__parse_sample() for all event types read from the ring buffer. This n=
ow
unconditionally acquires an evsel reference.

However, pyrf_event__setup_types() only registers the custom destructor
pyrf_sample_event__delete() (which calls perf_sample__exit() to drop the
reference) for pyrf_sample_event__type. Other event types fall back to the
default deallocator, bypassing perf_sample__exit(). When these objects are
garbage collected, the evsel reference appears to be permanently leaked.

I see this regression was fixed later in the series in commit 1daefbea296a4=
7c
("perf python: Refactor and add accessors to sample event"), but wanted
to confirm the behavior introduced here.

Could this also cause an evsel reference leak for deferred callchains?

In tools/perf/util/session.c, both evlist__deliver_deferred_callchain() and
session__flush_deferred_samples() process deferred samples by calling
evlist__parse_sample(), which internally calls evsel__parse_sample(),
acquiring the reference here.

Immediately after, both functions execute:

    sample.evsel =3D evlist__id2evsel(evlist, sample.id);
    if (sample.evsel)
        sample.evsel =3D evsel__get(sample.evsel);

Does this overwrite the non-NULL sample.evsel pointer without dropping the
original reference, and then increment the reference count a second time?

If so, perf_sample__exit() will only drop one reference, permanently leaking
the first one for every deferred sample.

>  	data->cpu =3D data->pid =3D data->tid =3D -1;
>  	data->stream_id =3D data->id =3D data->time =3D -1ULL;
>  	data->period =3D evsel->core.attr.sample_period;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D13
