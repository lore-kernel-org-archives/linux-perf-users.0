Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB15619C542
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777159342; cv=none; b=U8b9t/jG8DgZlTKuIEt7Xy98sPUSLYRh1Ghc3IUY2YJFLXBIhg9QpIgsMA5OG6uepDClKhjlxFg0hw+IKZM6YDF64A9nGkE20YGZBOO04oTwP6bOfeN6IjShW3VPOAspRaYTRgMcZq9FgJykvFd3btEa/3GylgHGWA1x+3hraX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777159342; c=relaxed/simple;
	bh=4qD3mMW5hsxM4rzm1hxhx6cKRV6v88J3KjVyR+WRJkU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aKUkFcGMqHMDIqLsfZi9tuvwWMMBuxikdl9v8Km08srJlookDZgg55rwm7/+cLKYvDhTNL+eL+VFch0xsowebQhjg/AWDU94r/P03XrWog4qxetk2Ztt75Dq8wo5I76i6wydkH0SJXAHuAEcAXxzENE3S0ZQnKORrc7TjOKXjyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFAuo33s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFAuo33s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5193CC2BCB0;
	Sat, 25 Apr 2026 23:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777159342;
	bh=4qD3mMW5hsxM4rzm1hxhx6cKRV6v88J3KjVyR+WRJkU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=nFAuo33smdB5mCRjUMDXMox7PwjQWol41FIkT3cILRKWA0lXP6whBPkCamGtG6qLJ
	 7PFVuVkUB3+qvp10bhLdzqS5nCQr9/IhBnjIpuwbPf2h0MzQqOR9trzcDcynJtgyB/
	 nLSNvzoV8JX5x0I4OObsFBnCDTG8z6gQAWVA0LLqiM3mVvOQhD+nFrcONVTvLZxIAo
	 LwrE8WOZ8/KSedG5XDyA8cLBa2Y3wn2iApOThGXJrBFHDyjPHNlLYAyZMjqI+Roo6e
	 5kERhVqO7cYR5Hapkxx4CyAnnNNmZncjdFZ4EmT70xPRFM6/IFUgQPPPh3G0uSwKwt
	 +WslvtuNMDuSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 13/59] perf python: Use evsel in sample in pyrf_event
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-14-irogers@google.com>
References: <20260425224951.174663-14-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:22:21 +0000
Message-Id: <20260425232222.5193CC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] Python bindings permanently leak `evsel` references for all non-sa=
mple events.
- [High] The patch introduces an `evsel` reference leak in `evlist__deliver=
_deferred_callchain` and `session__flush_deferred_samples` by overwriting `=
sample.evsel` without dropping the original reference.
- [Medium] Reusing a `struct perf_sample` inside an event loop silently lea=
ks `evsel` references because `perf_sample__init()` overwrites the struct.
--

commit a1ae9ec86975ece28a0d9433cc02e89b27323d4f
Author: Ian Rogers <irogers@google.com>

perf python: Use evsel in sample in pyrf_event

This commit avoids a duplicated evsel by using the one in the sample. It
also adds evsel__get and evsel__put to manage the evsel reference in
perf_sample.

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

Does this leak the evsel reference when parsing deferred callchains?

In tools/perf/util/session.c, both evlist__deliver_deferred_callchain()
and session__flush_deferred_samples() call evlist__parse_sample() which
populates sample and acquires the reference. Then they overwrite the
pointer without dropping the original reference:

    sample.evsel =3D evlist__id2evsel(evlist, sample.id);

Could reusing a struct perf_sample inside an event loop silently leak
evsel references now?

In tools/perf/tests/perf-record.c (test__PERF_RECORD), the sample
variable is declared outside the event processing loop and passed to
evlist__parse_sample() repeatedly. Since evsel__parse_sample() internally
calls perf_sample__init(data, true) which zeroes the struct, it seems the
evsel pointer from the previous iteration is silently overwritten.

>  	data->cpu =3D data->pid =3D data->tid =3D -1;

[ ... ]

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 22cc57914ad4..2ba3556c4f16 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c

[ ... ]

> @@ -1798,8 +1796,6 @@ static PyObject *pyrf_evlist__read_on_cpu(struct py=
rf_evlist *pevlist,
>  			return Py_None;
>  		}
> =20
> -		pevent->evsel =3D evsel__get(evsel);
> -
>  		perf_mmap__consume(&md->core);
> =20
>  		err =3D evsel__parse_sample(evsel, &pevent->event, &pevent->sample);

Can this leak evsel references for non-sample events in the Python
bindings?

pyrf_evlist__read_on_cpu() unconditionally parses all events using
evsel__parse_sample(), acquiring the reference. However,
pyrf_sample_event__delete() (which calls perf_sample__exit()) is only
assigned to pyrf_sample_event__type. Other event types like
pyrf_mmap_event__type rely on Python's default object deallocator, which
does not call perf_sample__exit().

It appears this was fixed later in commit 5565efd86942 (perf python:
Refactor and add accessors to sample event).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D13
