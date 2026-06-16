Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2F038E124
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 02:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781575356; cv=none; b=oktCvsdi6Sr7l4TWMzlNmXg1esvd/F3yxwzYyEzl/sx93S7nx706taNKvGwxROVaHMM3bSZU+nMAq1NGtmlNMCqt2NenP2aSpA//MQ/icgw65JwBaA7ZtkT7yoMiw3ad2xTChF9ZHfZKBpv8DxrcIq4Z4a4QE8t4CNznkvzgA+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781575356; c=relaxed/simple;
	bh=dibUrtODILnr8AkhqjuNUHrem770pkO7brDvHFM1QVk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=isAvNdOsv/OcMjJ7dh7nMdRz6zKL6P7i/q8GZSk/J+eupXctPLWoxyEwn2Z8arKOgBRQp/mG96831ZRC+o77Lq+KtyfsckuSC0DM83n6bl2xw/UT4SNJbVffrAdeNldEshDlJIFf7X+oYhOkdVLR5ShlRZNZ4dhmqqVHpbX0APA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUZ5ZhLX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUZ5ZhLX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2821F000E9;
	Tue, 16 Jun 2026 02:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781575354;
	bh=Q4yqeFHRMw81icKamygWC+iF2hiv6U9qzvSxHVl1htU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZUZ5ZhLX5RjvBEDPQ+AGVWy20a6raQy6HQpw/AWxhI3Ju1AcKzuchGJdR8CW5XmR9
	 zpP9ral/9DVgBXDdM3UiTGvwQysGq21Sp99Xm7TaMm32lraRDyRp5H20gIMU67H3Q2
	 Vdx7W3FuOKL8ttJZ5k6O6hfYxjXWScC4ZnvIQKLBea95p/4R1T+IBHmrZs5iKIYEzv
	 p4ebP3TF9vxIuPUeKTNUhzpruHAuLIYZAmOa1sXzEWYMvCaTnxtOHQEZdOEUEEEL8p
	 7JDI4yQRGAR0MqKi2e+oU+O/x3k2fUuELuJID4Y9jcVNrkVhAzZcIShS1kVyRQd6a4
	 6mnUL+4/jff9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 18/21] perf python: Handle Py_None for thread and
 cpu maps
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616011543.4037138-19-irogers@google.com>
References: <20260616011543.4037138-19-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 02:02:34 +0000
Message-Id: <20260616020234.BA2821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing Python object type check before pointer cast in `pyrf_evse=
l__open` leads to type confusion and potential memory corruption.
--

commit 3a81d3b48b518ddfa19a43ac15366264b0a3588b
Author: Ian Rogers <irogers@google.com>

perf python: Handle Py_None for thread and cpu maps

This commit fixes a memory corruption issue where passing None for threads
and cpus to perf bindings results in Py_None being incorrectly cast and
dereferenced. It adds explicit checks for Py_None alongside NULL in several
Python binding functions.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c

[ ... ]

> @@ -2091,10 +2091,10 @@ static PyObject *pyrf_evsel__open(struct pyrf_evs=
el *pevsel,
>  					 &pcpus, &pthreads, &group, &inherit))
>  		return NULL;
> =20
> -	if (pthreads !=3D NULL)
> +	if (pthreads !=3D NULL && pthreads !=3D Py_None)
>  		threads =3D ((struct pyrf_thread_map *)pthreads)->threads;
> =20
> -	if (pcpus !=3D NULL)
> +	if (pcpus !=3D NULL && pcpus !=3D Py_None)
>  		cpus =3D ((struct pyrf_cpu_map *)pcpus)->cpus;

[Severity: High]
This is a pre-existing issue, but is it possible for a user to pass an
arbitrary Python object (like an integer or string) instead of a thread or
cpu map here?

It looks like pyrf_evsel__open() uses the "|OOii" format specifier to parse
generic PyObject pointers, but it does not verify the object types before
casting the pointers to struct pyrf_thread_map and struct pyrf_cpu_map.

While other functions like pyrf__parse_events() and pyrf__parse_metrics()
use PyObject_TypeCheck() to validate these arguments, pyrf_evsel__open()
seems to be missing this validation. If an invalid object type is provided,
could casting and dereferencing it cause memory corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616011543.4037=
138-1-irogers@google.com?part=3D18
