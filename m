Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9F11C8604
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Aug 2026 00:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786667936; cv=none; b=MkpmR6temrqcOlU6LBtlVB/sx+HPfoVUWQ9ttIqgBQ9x/PCmifrA2whxntJQRsr4+GQtGggkb7Aq9pIDaQb4/gpvjgzYs5CXLQiRIM2GJkuSnMLrLMFCdogVBaWgGDFpk9kVCNYMQGNOBebJku3EGCXVp8hKwHiEahCk32/rP24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786667936; c=relaxed/simple;
	bh=Q1jku/v/krqK0BjBxZGvjSVxFh/2P6rdgQRBSsEf1jI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TLbapoP9PderoG8ktSM0kpZIXsjYv0XXw7eg6Ff3GYQsXHaxTudS2bvwOua+f0vGX9Y9dsiib7YiIPhC3jcMhIwjlMX4+2W9anwszKO4dxiJLrNf5Id+Uj/H9P6XZ24964npm/HRjtJwnPJXUeWMNmOuVP5XNsfcKy7McA1/Uhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtpEMfI+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtpEMfI+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DEE1F000E9;
	Fri, 14 Aug 2026 00:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786667934;
	bh=xRlauGIyyyY7bK4xnOOuosrfTdSfKQLcdfwL1/Xf2n4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TtpEMfI+g0bLeiGu4Fglypz9WWkUwLblo4G9sKBJHJObWO6bqhh7w+lgxIg3/cb61
	 cZUzzzKvgiPVaLPYuiJ70tOM6AI+JHn1EnWuhsdZozeKgk2H6K+dj5yLilFglmUx3n
	 aolCSrlUWBBATafAQEVROyxmfMu3QUgSbj2poh+5Vh0c6fDUWHVqkNlLWOrZpm2tao
	 DMWc1HsoWKMe3F3nQ7qYIBNr4JsDciC57CPCjgDkksL23Zw9lCEXirLUb9sc1zX1yM
	 L5kMDMV9ii+f1/ePMJq55nAOY7DsuIaH3mvi8S8ZKdywQ/h5ACCuphh8MhLHIjQykH
	 msrd280/SVcbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 06/33] perf callchain: Don't pass evsel and sample
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260413041143.1736055-7-irogers@google.com>
References: <20260413041143.1736055-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 00:38:54 +0000
Message-Id: <20260814003854.87DEE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unchecked dereference of `sample->evsel` in callchain resolution t=
riggered by synthesized samples from `jitdump`, leading to a segmentation f=
ault.
--

--- Patch [6]: [PATCH v12 06/33] perf callchain: Don't pass evsel and sampl=
e ---
commit 27ec660b6457cfb9bcb1b7bd6fcdf72bb85c9ee4
Author: Ian Rogers <irogers@google.com>

perf callchain: Don't pass evsel and sample

Change callchain resolve code to not pass an evsel with the sample,
instead just read the evsel from the sample.

> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index e76f8c86e62a6..c2e0a99efe97d 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2778,13 +2778,13 @@ static u64 get_leaf_frame_caller(struct perf_samp=
le *sample,
> =20
>  static int thread__resolve_callchain_sample(struct thread *thread,
>  					    struct callchain_cursor *cursor,
> -					    struct evsel *evsel,
>  					    struct perf_sample *sample,
>  					    struct symbol **parent,
>  					    struct addr_location *root_al,
>  					    int max_stack,
>  					    bool symbols)
>  {
> +	struct evsel *evsel =3D sample->evsel;

[Severity: High]
This is a pre-existing issue, but could this lead to a NULL pointer
dereference when processing synthesized samples from jitdump?

When processing a JIT_CODE_MOVE record, jit_repipe_mmap() in
tools/perf/util/jitdump.c synthesizes a perf_sample using
perf_sample__init(), which leaves sample.evsel as NULL. It then calls
build_id__mark_dso_hit(), which unconditionally passes the sample to
sample__for_each_callchain_node().

The sample is propagated here, where sample->evsel is extracted and
subsequently dereferenced in evsel__has_branch_callstack(evsel) without
a NULL check. This issue existed before this patch, as jit_repipe_mmap()
previously passed a NULL evsel argument directly.

>  	struct branch_stack *branch =3D sample->branch_stack;
>  	struct branch_entry *entries =3D perf_sample__branch_entries(sample);
>  	struct ip_callchain *chain =3D sample->callchain;
[ ... ]
> @@ -2986,10 +2986,11 @@ static int unwind_entry(struct unwind_entry *entr=
y, void *arg)
> =20
>  static int thread__resolve_callchain_unwind(struct thread *thread,
>  					    struct callchain_cursor *cursor,
> -					    struct evsel *evsel,
>  					    struct perf_sample *sample,
>  					    int max_stack, bool symbols)
>  {
> +	struct evsel *evsel =3D sample->evsel;
> +

[Severity: High]
This isn't a bug introduced by this patch, but does this share the same
risk as thread__resolve_callchain_sample() above?

The extracted evsel is blindly dereferenced immediately on the next line
to access evsel->core.attr.sample_type. A synthesized sample from jitdump
without a set evsel would cause a segmentation fault here as well.

>  	/* Can we do dwarf post unwind? */
>  	if (!((evsel->core.attr.sample_type & PERF_SAMPLE_REGS_USER) &&
>  	      (evsel->core.attr.sample_type & PERF_SAMPLE_STACK_USER)))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260413041143.1736=
055-1-irogers@google.com?part=3D6
