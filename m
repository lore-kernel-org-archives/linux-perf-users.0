Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEE1368D66;
	Wed, 13 May 2026 20:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778704618; cv=none; b=OQwFW3xUkx7I6rVvp0nEpGHndsB/omlKcN/ULkOL/3hV0E8LyVDijv4hnY2X/anDFEKGS6U9W2zsQXR3FNNGGLrf7XsT7+N6NKaHb576PxueXyAagpr8oT19A03DutfE3s8k9jtvnWnYiIRanF3szlSHR6Zu/5X1bSOM6ghvb68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778704618; c=relaxed/simple;
	bh=pl0s1XtFqjnpjniWMs7jjDyVivilo+hv64u1Dlpz2y0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lsAM0NlY7W2/vMWZGl7+HiH6k9iu8vEFDgBEYpgIeG76TZ7IsR1YIrNoq6hQNy2+ylqChmb9MCAPmWZvTMp9Hd98itkt9Lu+LuqDzV4fPNCOUQKdzw2r6L8Gxvb/3U9MBwYw8eX9D97YWdDoGKaTLcVfTdOkoXlujB2bkJlaHvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKrqgsXv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKrqgsXv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE29C19425;
	Wed, 13 May 2026 20:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778704618;
	bh=pl0s1XtFqjnpjniWMs7jjDyVivilo+hv64u1Dlpz2y0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=sKrqgsXvnmh5ojCCSYQ7r162FftxVyE7YluORvnxOVCe1d96G63akhw8iY27tBCM0
	 tOr1JIzhajDVFRg7kCMrgUEbbTe4xTuTl79ijo6fe6k88ce9mtsqhU93Y3YyXaXaaf
	 rMQ4Z/LMMfKbZrtupM1udnCQC+MAFhWs16w9sdyfpY3fBwHtSBWDQBgXlh8TvxXnOg
	 n7EdVF23fIEALapXAiybonuFiO4ahlQghXiAAb4+F70bV9siw9Zs/+9+DYArB+5fG7
	 zYkFWRJICEp4IuUnvChuq45H190U9S9Vti6tqJEN6cDC+rIAGc8xZw6IKzO50Bz2MG
	 5/+NDcixsoLlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 07/14] perf build: Move static libbpf dependency out
 of prepare step
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260512053539.3410189-8-irogers@google.com>
References: <20260512053539.3410189-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 20:36:57 +0000
Message-Id: <20260513203658.1DE29C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Removing `$(LIBBPF)` from the `prepare` target dependencies creates=
 a parallel build race condition for `$(LIBPERF_TEST_IN)`, leading to spora=
dic compilation failures in `tests/sigtrap.c`.
--

commit f64d4116318da61817b68460818308db46b21447
Author: Ian Rogers <irogers@google.com>

perf build: Move static libbpf dependency out of prepare step

This commit moves the static libbpf dependency out of the prepare step to
reduce serialization during parallel builds. The libbpf dependency is
explicitly added to the perf, bench, and util targets instead.

> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
[ ... ]
> @@ -636,10 +636,6 @@ prepare: $(OUTPUT)PERF-VERSION-FILE \
>  	$(LIBSUBCMD) \
>  	$(LIBSYMBOL)
> =20
> -ifdef LIBBPF_STATIC
> -prepare: $(LIBBPF)
> -endif
> -

Does removing this dependency from prepare create a parallel build race
condition for $(LIBPERF_TEST_IN)?

It appears that $(LIBPERF_TEST_IN) is missing the $(LIBBPF) dependency
that was added to $(PERF_IN), $(LIBPERF_BENCH_IN), and $(LIBPERF_UTIL_IN).

During a parallel build, $(LIBPERF_TEST_IN) might start compiling test files
before $(LIBBPF) finishes installing headers to the include directory.

This could lead to sporadic compilation failures in files like
tools/perf/tests/sigtrap.c which includes <bpf/btf.h> when HAVE_BPF_SKEL
is enabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512053539.3410=
189-1-irogers@google.com?part=3D7
