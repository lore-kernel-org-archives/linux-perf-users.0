Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711C31A6838
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 23:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786664623; cv=none; b=iPAJb31t2ipOahLJpBydQzwP6bmqzKY+EEhQgFFix2/kcOCmvBUqobR0c/SkNcoeF3IYTbdO1Cc8uiJwrPs0uzWX1/+ixd0jgS1dp3+oJWjMT6mdPv2IZyPNuRGcHWMho6eEWmwIm0OxjYe8p93FZhQHkTq0LMw3SKmASWDo5n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786664623; c=relaxed/simple;
	bh=QG6c2pN0w32emXsrXfdE7q0HeSRcbPRa+3boFS2ahHM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YSxeF2B57I6m+w7/QboJIoFTjUa/FsMIxD3+gaViOQxGnHrm4/cGgmDOg4yyjZQHE2ytVY7wog0OEnxnSND7h52kH9G3Z/NN+j87KctpP6wTFUJpCtuQSZvWq2h/yM8qjxp8yxNlRpmZHmZxZzKsH1cEyCgXsaIg42/eLbmB8SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYhQvyIv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYhQvyIv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D6D1F000E9;
	Thu, 13 Aug 2026 23:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786664622;
	bh=4RqaDV6srC2w02pPaGPWvbKCAlfMDujWiO1oW5suZD4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gYhQvyIvv8UcvyDyt5miIFTv71U0XWhzhRR+QlfWyoxG0A73WAYBL762lQToVSEM7
	 dGZInhsO3gsLbDyihCXEVG7NwnRwtsG8vaM82bJZFkNZ88uzMR3n2R2Q0KSfY7ZLU7
	 lFWkvadg8J1rTSGzxVwJN0FgSGI3nVOb51H6i6w0mJu9teogZVG81c3TV/y0A3zRYb
	 rR4cPMcs9pAbFYaUdl76dZMCMVE1FQuZ42Q848QU1zojZArGOoBh4myBVNnHtLrwa3
	 YRsP1MEH5UAYx1Z0mADukRZ+QrNHtExrjyFrIZcKd+1XBaW0XYNOjTUv7X9gt/lCLC
	 C7QJu0S3R9jmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/25] perf sample: Make sure perf_sample__init/exit
 are used
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260403204017.2919994-3-irogers@google.com>
References: <20260403204017.2919994-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 23:43:36 +0000
Message-Id: <20260813234337.B3D6D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] The return value of `perf_evsel__parse_id_sample` is silently ig=
nored for non-`PERF_RECORD_SAMPLE` events.

Pre-existing issues:
- [High] In the Python bindings, if `evlist__event2evsel` fails during even=
t parsing, an uninitialized `struct perf_sample` is passed to `perf_sample_=
_exit()`, resulting in a free of garbage pointers.
- [High] Missing check for `deferred_callchain` allows a malformed event to=
 crash the tool by dereferencing a NULL callchain.
- [High] Missing bounds check on `event->callchain_deferred.nr` leads to ma=
ssive out-of-bounds read and potential heap overflow.
--

--- Patch [2]: [PATCH v5 02/25] perf sample: Make sure perf_sample__init/ex=
it are used ---
commit 24e922c277122af1d6e4cb75082ba12f77262a00
Author: Ian Rogers <irogers@google.com>

perf sample: Make sure perf_sample__init/exit are used
   =20
The deferred stack trace code wasn't using perf_sample__init/exit. Add
the deferred stack trace clean up to perf_sample__exit which requires
proper NULL initialization in perf_sample__init. Make the
perf_sample__exit robust to being called more than once by using
zfree.

> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index f879b84f8ff99..f031cbbeeba8b 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -1919,6 +1922,7 @@ int sample__merge_deferred_callchain(struct perf_sa=
mple *sample_orig,
>  	memcpy(&callchain->ips[nr_orig], sample_callchain->callchain->ips,
>  	       nr_deferred * sizeof(u64));

[Severity: High]
This is a pre-existing issue, but does this lack a bounds check on
event->callchain_deferred.nr before copying from the event buffer?

In tools/perf/util/evsel.c:evsel__parse_sample(), data->callchain->nr is
checked against UINT64_MAX / sizeof(u64) rather than being bounded by the
actual event->header.size.

When sample__merge_deferred_callchain() is called, nr_deferred * sizeof(u64)
can integer-overflow on 32-bit systems (causing a small heap allocation and=
 a
subsequent buffer overwrite) or cause a massive out-of-bounds read on 64-bit
systems.

Could we validate the nr field against the actual event size?

> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index c702741a91738..f46e1d40bad73 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1632,8 +1632,11 @@ int evlist__parse_sample(struct evlist *evlist, un=
ion perf_event *event, struct
>  	struct evsel *evsel =3D evlist__event2evsel(evlist, event);
>  	int ret;
> =20
> -	if (!evsel)
> +	if (!evsel) {
> +		/* Ensure the sample is okay for perf_sample__exit. */
> +		perf_sample__init(sample, /*all=3D*/false);
>  		return -EFAULT;
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but does the Python binding
code have a similar issue where an uninitialized sample is cleaned up on
error?

In tools/perf/util/python.c:pyrf_event__new(), the pyrf_event is allocated
via PyObject_New without zeroing the memory, meaning the sample member is
uninitialized.=20

If evlist__event2evsel() fails during event parsing in
pyrf_evlist__read_on_cpu(), Py_DECREF triggers the destructor
pyrf_sample_event__delete(), which calls perf_sample__exit(&pevent->sample).
This passes uninitialized garbage pointers to zfree(), which can corrupt
memory.

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 5a294595a6776..4d3615d7b8859 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
[ ... ]
> @@ -3236,25 +3238,26 @@ int evsel__parse_sample(struct evsel *evsel, unio=
n perf_event *event,
[ ... ]
>  	if (event->header.type !=3D PERF_RECORD_SAMPLE) {
> -		if (!evsel->core.attr.sample_id_all)
> -			return 0;
> -		return perf_evsel__parse_id_sample(evsel, event, data);
> +		if (evsel->core.attr.sample_id_all)
> +			perf_evsel__parse_id_sample(evsel, event, data);
> +		return 0;
>  	}

[Severity: Medium]
Is it intentional that the return value from perf_evsel__parse_id_sample()
is now silently ignored for non-PERF_RECORD_SAMPLE events?

If perf_evsel__parse_id_sample() fails on a malformed or truncated event,
returning 0 instead of propagating the error or taking the out_efault path
might leave perf_sample fields uninitialized or zeroed, potentially leading
to incorrect downstream analysis.

> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 09de5288f9e15..6fb481fda4926 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1367,14 +1367,18 @@ static int evlist__deliver_deferred_callchain(str=
uct evlist *evlist,
[ ... ]
> -		if (sample->tid !=3D orig_sample.tid)
> +		if (sample->tid !=3D orig_sample.tid) {
> +			perf_sample__exit(&orig_sample);
>  			continue;
> +		}
> =20
>  		if (event->callchain_deferred.cookie =3D=3D orig_sample.deferred_cooki=
e)
>  			sample__merge_deferred_callchain(&orig_sample, sample);

[Severity: High]
This is a pre-existing issue, but could this comparison succeed improperly
and cause a crash?

Since orig_sample is zero-initialized by perf_sample__init(), if it has no
callchain, its cookie is 0 and its callchain pointer is NULL.=20

If the incoming event also has a cookie of 0, this equality check passes and
we call sample__merge_deferred_callchain(), which then dereferences
sample_orig->callchain->nr without a NULL check.

Should this verify that orig_sample.deferred_callchain is actually true?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260403204017.2919=
994-1-irogers@google.com?part=3D2
