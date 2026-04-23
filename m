Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613FC2D3ED2
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 06:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776924060; cv=none; b=fi3gh9en5XTp3Ki3DPY6AipoZoCsSDjFY61X3wv1pBrWFULATZ18ea9lnnYa4YzV3YR7n9MX0wtB+S/qDzxxID8qOsXLtkl9uzJFoE2uauOn7l+m7Q8IoJN40I18zkpSaQjbUn5Zassg7sGPVdN6SjfSqcNIvYovwzjMut2zfhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776924060; c=relaxed/simple;
	bh=978y1Hy8A0IogvNGbuR/tNK4wAyVCbxsHYYcSHkicY8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZD1FLGYKIzO2pheUAuLGYHznoD7tguvlJOylF2tAZXA6cA0o31jUiMf8Emst+5vS7M/6W/OI4ziL3NmbG5BMZp5B2I1PhPfD4CYOADG9lZkMgHE47wPB7zln30gbwZFMOdtT1arB3niEkFSLX1lTdQCw+OlX7hiY7zwMR01Asvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c68bfMij; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c68bfMij"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062BDC2BCAF;
	Thu, 23 Apr 2026 06:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776924060;
	bh=978y1Hy8A0IogvNGbuR/tNK4wAyVCbxsHYYcSHkicY8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=c68bfMijhLfO0JZfKOVHr7elblVf7PkyJLAv9mAwNZBrujCMLFOK0AXpkG0RQAocL
	 otGjkwC2uOREgxAV/SmAW7XKT4/sgY8sYod9ABuDAQE+6sbBumsIEibBGLUFYR+WjL
	 jrtSxXYW/IGSlqJPJKUyyeOPcjGk1Da5rIuWRJ7HGTBmcCXo0ZHDCa8frd+DsLGGrI
	 jND+LKEGqiKiqnw4GIBErLx3acXbW2FBWHGFyIl6lu1K0aHnc1dFNUV4v2d0v+sBF9
	 Z+vrpheEd/AFDqMv2QCE4/PiLwdpRCpab9nAa5tCxa/qiBJx9WMDVCJSKpBXaE7rMo
	 nltWcW1MTaoMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/58] perf python: Use evsel in sample in pyrf_event
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-14-irogers@google.com>
References: <20260423035526.1537178-14-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 06:00:59 +0000
Message-Id: <20260423060100.062BDC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] Double-put of `evsel` reference count on `evsel__parse_sample()`=
 error paths.
- [Medium] `evsel` reference leak in the Python perf extension for non-samp=
le events.
--

commit e5d351204a63fd8edb73b920515cecae1b0cd957
Author: Ian Rogers <irogers@google.com>

perf python: Use evsel in sample in pyrf_event

This commit avoids a duplicated evsel by using the one present in the sampl=
e.
It adds evsel__get() and evsel__put() to the evsel stored in perf_sample.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 0162d8a625de3..0424290f8b77f 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -274,7 +273,6 @@ static PyMemberDef pyrf_sample_event__members[] =3D {
> =20
>  static void pyrf_sample_event__delete(struct pyrf_event *pevent)
>  {
> -	evsel__put(pevent->evsel);
>  	perf_sample__exit(&pevent->sample);
>  	Py_TYPE(pevent)->tp_free((PyObject*)pevent);
>  }

Does this leak the evsel reference for non-sample events?

In pyrf_evlist__read_on_cpu(), evsel__parse_sample() is called for all
event types, which acquires an evsel reference and stores it in the Python
event object:

pyrf_evlist__read_on_cpu()
    err =3D evsel__parse_sample(evsel, &pevent->event, &pevent->sample);

However, only pyrf_sample_event__type has a custom tp_dealloc method
(pyrf_sample_event__delete) that calls perf_sample__exit().

Other event types fall back to the default Python deallocator and bypass
perf_sample__exit(), which skips dropping the refcount and leaks the evsel
reference along with any dynamic structures in perf_sample.

I see this regression is fixed later in the patch series by commit
ce9c27681f1b (perf python: Refactor and add accessors to sample event),
which adds a universal tp_dealloc for all event types.

[ ... ]
> diff --git a/tools/perf/util/sample.c b/tools/perf/util/sample.c
> index cf73329326d72..106848404fdf0 100644
> --- a/tools/perf/util/sample.c
> +++ b/tools/perf/util/sample.c
[ ... ]
> @@ -29,6 +34,7 @@ void perf_sample__init(struct perf_sample *sample, bool=
 all)
> =20
>  void perf_sample__exit(struct perf_sample *sample)
>  {
> +	evsel__put(sample->evsel);
>  	zfree(&sample->user_regs);
>  	zfree(&sample->intr_regs);

Does this cause a double-put on error paths?

If evsel__parse_sample() encounters an error and jumps to out_efault, it
calls perf_sample__exit() internally and drops the refcount.

If callers like do_test() in tools/perf/tests/sample-parsing.c or
pyrf_evlist__read_on_cpu() catch the error, they execute their own
cleanup paths and call perf_sample__exit() again on the same sample object.

Since sample->evsel is not set to NULL after evsel__put() here, could the
second call lead to a reference count underflow and a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D13
