Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1837126ED41
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777141878; cv=none; b=RUkcnfiZJijTXfUuYUFGFJSk5Qf6TM9AWrL/fvJXX8Um10XtqLioA6zO9SNournU16eJQ4CELMuGGX/jJAHYS/j8FGayIleIiT3YiYqI2TZdMpPOKwR2xgS14kRdjx82hwAzolyt3/45VsEVJpxYuAfMuc/feJ3k2gK1CnAQBZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777141878; c=relaxed/simple;
	bh=EeF31MbXMI87gCJihGsguziF/nVnOBhPRuGi0zwVE6w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k6CPNStlGb/srNHSrZsGLDvAWzRogisPKiZRa7xvJAdM4d9RYSPGsyG5Vrl8Pb4fxPhoauVbkgFJTqexg9zh5rWIszHfQE1j+Q2gIWVhfFhn4rfKtqguh3FFsCJLyUwErpU3WCS3wfP2GEpIBWd1IADbPspmGmOnoguIyY2A52E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuvyEzEF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuvyEzEF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DDFC2BCB0;
	Sat, 25 Apr 2026 18:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777141877;
	bh=EeF31MbXMI87gCJihGsguziF/nVnOBhPRuGi0zwVE6w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=fuvyEzEFuhiOIjAEweWGG9lcIE5ZK1Lnh1Qf21U0d77Nu1JijuUdKtjGKWobltXfK
	 l/A6aPZSfIC1mnBG90u+cqt8zyo4ZDdsDcg9mmbQwGlzdk4Rwxqd0nO+g6z+1VYxTq
	 +894KFtJ8OARxiuMgf7ecNRgyBFNeIGlsHnvCDVnHhWo2lQiJ5aTLwYl0KavDgqIvL
	 H4l3k9gvzFXgNeiwTaQr5U1DMIXZtM+0im+LyDBWwjGXd/tePwQLUjGX+ufXRB3Hdc
	 mmkeuaORG477ROzlk0LT7Bl7xRiuTHjpXV9f27cYZBohZILWaUFxfi3tXqvvIFa/a0
	 I4uc9+KEvhsOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/59] perf inject: Fix itrace branch stack synthesis
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-2-irogers@google.com>
References: <20260425174858.3922152-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:31:16 +0000
Message-Id: <20260425183117.53DDFC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] Missing initialization of `event_copy->header.misc` in `perf_event=
__repipe_sample()` causes corruption of output events.
- [High] Hardcoded `branch_sample_type=3D0` in trace decoders omits `hw_idx=
` from branch events, creating corrupted `perf.data` files.
- [High] `perf_event__repipe_sample` fails to strip `PERF_SAMPLE_AUX` when =
`--itrace=3Dl` is used, leading to `-EFAULT` abortion or file corruption.
--

commit 9516abbe162f4ebd2ee0085c49fc396bb54c1328
Author: Ian Rogers <irogers@google.com>

perf inject: Fix itrace branch stack synthesis

When using "perf inject --itrace=3DL" to synthesize branch stacks from
AUX data, several issues caused failures.

> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index f174bc69cec4..88c0ef4f5ff1 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
[ ... ]
> @@ -375,7 +375,59 @@ static int perf_event__repipe_sample(const struct pe=
rf_tool *tool,
> =20
>  	build_id__mark_dso_hit(tool, event, sample, evsel, machine);
> =20
> -	if (inject->itrace_synth_opts.set && sample->aux_sample.size) {
> +	if (inject->itrace_synth_opts.set &&
> +	    (inject->itrace_synth_opts.last_branch ||
> +	     inject->itrace_synth_opts.add_last_branch)) {
> +		union perf_event *event_copy =3D (void *)inject->event_copy;
> +		struct branch_stack dummy_bs =3D { .nr =3D 0 };
> +		int err;
> +		size_t sz;
> +		u64 orig_type =3D evsel->core.attr.sample_type;
> +		u64 orig_branch_type =3D evsel->core.attr.branch_sample_type;
> +
> +		if (event_copy =3D=3D NULL) {
> +			inject->event_copy =3D malloc(PERF_SAMPLE_MAX_SIZE);
> +			if (!inject->event_copy)
> +				return -ENOMEM;
> +
> +			event_copy =3D (void *)inject->event_copy;
> +		}
> +
> +		if (!sample->branch_stack)
> +			sample->branch_stack =3D &dummy_bs;
> +
> +		if (inject->itrace_synth_opts.add_last_branch) {
> +			/* Temporarily add in type bits for synthesis. */
> +			evsel->core.attr.sample_type |=3D PERF_SAMPLE_BRANCH_STACK;
> +			evsel->core.attr.branch_sample_type |=3D PERF_SAMPLE_BRANCH_HW_INDEX;
> +			evsel->core.attr.sample_type &=3D ~PERF_SAMPLE_AUX;
> +		}

If `--itrace=3Dl` is used (so `last_branch` is true but `add_last_branch` is
false), does `evsel->core.attr.sample_type` retain the `PERF_SAMPLE_AUX`
flag here?

If the flag remains set, wouldn't `perf_event__sample_event_size()` include
the massive `sample->aux_sample.size` in the new event size, potentially
exceeding `PERF_SAMPLE_MAX_SIZE` (64KB) and causing `perf inject` to abort
with `-EFAULT` below?

> +
> +		sz =3D perf_event__sample_event_size(sample, evsel->core.attr.sample_t=
ype,
> +						   evsel->core.attr.read_format,
> +						   evsel->core.attr.branch_sample_type);
> +
> +		if (sz > PERF_SAMPLE_MAX_SIZE) {
> +			pr_err("Sample size %zu exceeds max size %d\n", sz, PERF_SAMPLE_MAX_S=
IZE);
> +			return -EFAULT;
> +		}
> +
> +		event_copy->header.type =3D PERF_RECORD_SAMPLE;
> +		event_copy->header.size =3D sz;

Does this code leave `event_copy->header.misc` uninitialized?

Since `event_copy` is allocated via `malloc()` without clearing the memory,
and `type` and `size` are set explicitly but `misc` is skipped, could this
write uninitialized heap memory into the `misc` field? This might corrupt
privilege level flags like `PERF_RECORD_MISC_USER` and break symbol resolut=
ion.

[ ... ]
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index e5835042acdf..c4ed9f10e731 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -484,8 +484,11 @@ static void arm_spe__prep_branch_stack(struct arm_sp=
e_queue *speq)
> =20
>  static int arm_spe__inject_event(union perf_event *event, struct perf_sa=
mple *sample, u64 type)
>  {
> -	event->header.size =3D perf_event__sample_event_size(sample, type, 0);
> -	return perf_event__synthesize_sample(event, type, 0, sample);
> +	event->header.type =3D PERF_RECORD_SAMPLE;
> +	event->header.size =3D perf_event__sample_event_size(sample, type, /*re=
ad_format=3D*/0,
> +							   /*branch_sample_type=3D*/0);
> +	return perf_event__synthesize_sample(event, type, /*read_format=3D*/0,
> +					     /*branch_sample_type=3D*/0, sample);
>  }

Can hardcoding `0` for `branch_sample_type` cause the `hw_idx` field to be
omitted from the synthesized binary event payload?

If the trace decoder setup configures synthetic event attributes with
`PERF_SAMPLE_BRANCH_HW_INDEX`, tools parsing this injected `perf.data` file
will expect the 8-byte `hw_idx` field. Its absence could cause out-of-bounds
reads and corrupt parsing for subsequent sample fields.

[ ... ]
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 8a639d2e51a4..1ebc1a6a5e75 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1425,8 +1425,10 @@ static void cs_etm__update_last_branch_rb(struct c=
s_etm_queue *etmq,
>  static int cs_etm__inject_event(union perf_event *event,
>  			       struct perf_sample *sample, u64 type)
>  {
> -	event->header.size =3D perf_event__sample_event_size(sample, type, 0);
> -	return perf_event__synthesize_sample(event, type, 0, sample);
> +	event->header.size =3D perf_event__sample_event_size(sample, type, /*re=
ad_format=3D*/0,
> +							   /*branch_sample_type=3D*/0);
> +	return perf_event__synthesize_sample(event, type, /*read_format=3D*/0,
> +					     /*branch_sample_type=3D*/0, sample);
>  }

This code appears to have the same issue with hardcoding `branch_sample_typ=
e`
as `0`, potentially omitting `hw_idx`.

[ ... ]
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index fc9eec8b54b8..2dce6106c038 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -1731,8 +1731,12 @@ static void intel_pt_prep_b_sample(struct intel_pt=
 *pt,
>  static int intel_pt_inject_event(union perf_event *event,
>  				 struct perf_sample *sample, u64 type)
>  {
> -	event->header.size =3D perf_event__sample_event_size(sample, type, 0);
> -	return perf_event__synthesize_sample(event, type, 0, sample);
> +	event->header.type =3D PERF_RECORD_SAMPLE;
> +	event->header.size =3D perf_event__sample_event_size(sample, type, /*re=
ad_format=3D*/0,
> +							   /*branch_sample_type=3D*/0);
> +
> +	return perf_event__synthesize_sample(event, type, /*read_format=3D*/0,
> +					     /*branch_sample_type=3D*/0, sample);
>  }

Similarly here, could hardcoding `0` omit the `hw_idx` field and lead to
corrupted `perf.data` files?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D1
