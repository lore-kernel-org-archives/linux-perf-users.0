Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA23232FA14
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 20:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777407618; cv=none; b=GrJH2A+yxFtK4qwlziGGXHK8KKc2+HtZ3ZPGVUhbNC1Etd4mqltH96ayUufShb/HupzN2l5hJh0FoaBfqdOmnNwILMzKFwwvT6CpN+14ULSXCCcEgQI9vtvxopLcOZtsJSxMEHzCOlhADXfYm0FCzEMK8jY82PXGCinTO/fTK0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777407618; c=relaxed/simple;
	bh=ECjgqLUTDXEqhJRl07odiqBg1xy+bdcqlPXpw0zZDzY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BdLzwhB7aXh6tKHqL1XX2rhPYbRX+9n1dTQVMXwteFQwIzUj3pQ48moYbaU3Lk03FuECAmleahJ/02FdL4e4QCOHFxUHJJpj+uATmJ3H4V09xtAhJObcgq8ZdXNoo9HjrFYIdW0+JNOKmhArG53GUWBm4jV90Mr5hcPKKv6sCQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwI3Jvad; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwI3Jvad"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD63C2BCAF;
	Tue, 28 Apr 2026 20:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777407618;
	bh=ECjgqLUTDXEqhJRl07odiqBg1xy+bdcqlPXpw0zZDzY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=HwI3JvadZxzfyZwHIJbGojmNiyidVBxmffIe53p6ZoHI1K2eAlEFszFYJxM5uq/zf
	 elR3svzYZoAFCIt1y7wVPyYvO5HtXA5XxYbnrj/uSiJSPXTaWAE+MVIPbdBXhLxe9f
	 cKyat3SL2TGgxcUkklSwxXHVWuXNOwdQ2J2nR9mCw7Ot+aL6+HxvFlfy7/ocasEaYH
	 g3AanX3koK373dYvteKRB+F4PinD44aOvOZEeD8nHFjgA2Kp3d901s7XD2TrFVkSuN
	 e9eacFinLKJYvsBrG4UoVry5ZmSTXCnA4sctjq1c3QKk3QQjQh7jHGvqidf25INFOA
	 fNF3lFsSyH3kg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/2] perf inject: Fix itrace branch stack synthesis
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260428070328.1880314-3-irogers@google.com>
References: <20260428070328.1880314-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Apr 2026 20:20:17 +0000
Message-Id: <20260428202018.4FD63C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] Silent data corruption due to removed error check in perf_event__c=
onvert_sample_callchain().
- [High] Pipe mode attribute headers incorrectly advertise PERF_SAMPLE_AUX,=
 breaking downstream parsers.
- [High] Out-of-bounds write and parser breakage in perf_event__repipe_attr=
().
- [High] Unadvertised `size` field left in payload by perf_inject__cut_auxt=
race_sample() breaks parsing.
- [High] Off-by-one error in sample size overflow check causes infinite par=
sing loops.
- [High] Dangling pointer vulnerability via `sample->branch_stack` stack va=
riable assignment.
- [High] `hw_idx` omission in PEBS synthesis causes header vs payload misma=
tch.
--

commit e339fa2584e0f4ca5e2c4e8eb68d763fd40fbc59
Author: Ian Rogers <irogers@google.com>

perf inject: Fix itrace branch stack synthesis

This patch fixes several issues with perf inject --itrace=3DL when synthesi=
zing
branch stacks from AUX data. It adjusts the sample types and event layout,
and addresses parsing issues and potential heap overflows.

> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c

[ ... ]

> @@ -223,6 +223,11 @@ static int perf_event__repipe_attr(const struct perf=
_tool *tool,
>  						  tool);
>  	int ret;
> =20
> +	if (inject->itrace_synth_opts.add_last_branch) {
> +		event->attr.attr.sample_type |=3D PERF_SAMPLE_BRANCH_STACK;
> +		event->attr.attr.branch_sample_type |=3D PERF_SAMPLE_BRANCH_HW_INDEX;
> +	}
> +

Does modifying event->attr.attr.sample_type before calling
perf_event__process_attr() risk an out-of-bounds write if the event buffer
is truncated?

Also, this populates the session's internal evsel with
PERF_SAMPLE_BRANCH_STACK, which might cause perf_evsel__parse_sample() to
fail on subsequent raw records that lack this data.

For pipe mode, this function dynamically emits headers but doesn't clear
PERF_SAMPLE_AUX from the repiped event->attr. Since the payload has the AUX
data stripped, does this cause downstream parsers to misinterpret event
boundaries because the header advertises data that isn't there?

>  	ret =3D perf_event__process_attr(tool, event, pevlist);

[ ... ]

> @@ -375,7 +380,60 @@ static int perf_event__repipe_sample(const struct pe=
rf_tool *tool,
> =20
>  	build_id__mark_dso_hit(tool, event, sample, evsel, machine);
> =20
> -	if (inject->itrace_synth_opts.set && sample->aux_sample.size) {
> +	if (inject->itrace_synth_opts.set &&
> +	    (inject->itrace_synth_opts.last_branch ||
> +	     inject->itrace_synth_opts.add_last_branch)) {
> +		union perf_event *event_copy =3D (void *)inject->event_copy;
> +		struct branch_stack dummy_bs =3D { .nr =3D 0, .hw_idx =3D 0 };
> +		int err;

[ ... ]

> +		if (!sample->branch_stack)
> +			sample->branch_stack =3D &dummy_bs;

If PERF_FORMAT_GROUP is used, could this leave a dangling pointer?

If deliver_sample_group() reuses the exact same sample structure for
subsequent deliveries, sample->branch_stack will point to dummy_bs which
is allocated on the stack and goes out of scope when this function returns.

> +
> +		if (inject->itrace_synth_opts.add_last_branch) {
> +			/* Temporarily add in type bits for synthesis. */
> +			evsel->core.attr.sample_type |=3D PERF_SAMPLE_BRANCH_STACK;
> +			evsel->core.attr.branch_sample_type |=3D PERF_SAMPLE_BRANCH_HW_INDEX;
> +		}
> +		evsel->core.attr.sample_type &=3D ~PERF_SAMPLE_AUX;
> +
> +		sz =3D perf_event__sample_event_size(sample, evsel->core.attr.sample_t=
ype,
> +						   evsel->core.attr.read_format,
> +						   evsel->core.attr.branch_sample_type);
> +
> +		if (sz > PERF_SAMPLE_MAX_SIZE) {

Does this allow sz to be exactly PERF_SAMPLE_MAX_SIZE (65536)?

If sz evaluates to 65536, assigning it to event_copy->header.size (a __u16)
would overflow and wrap to 0. Emitting an event with header.size =3D 0 can
cause downstream parsers to enter an infinite loop.

Should this check be >=3D PERF_SAMPLE_MAX_SIZE?

> +			pr_err("Sample size %zu exceeds max size %d\n", sz, PERF_SAMPLE_MAX_S=
IZE);
> +			return -EFAULT;
> +		}

[ ... ]

> +		if (err) {
> +			pr_err("Failed to synthesize sample\n");
> +			return err;
> +		}
> +		event =3D event_copy;
> +	} else if (inject->itrace_synth_opts.set && sample->aux_sample.size) {
>  		event =3D perf_inject__cut_auxtrace_sample(inject, event, sample);

This fallback leaves an 8-byte size field (set to 0) in the sample payload.

Since PERF_SAMPLE_AUX is now globally cleared from the evsel headers in
__cmd_inject(), will parsers misinterpret this 8-byte field as the next
field in the format (like DATA_SRC) and shift all subsequent fields?

>  		if (IS_ERR(event))
>  			return PTR_ERR(event);

[ ... ]

> @@ -463,13 +521,9 @@ static int perf_event__convert_sample_callchain(cons=
t struct perf_tool *tool,
>  	/* remove sample_type {STACK,REGS}_USER for synthesize */
>  	sample_type &=3D ~(PERF_SAMPLE_STACK_USER | PERF_SAMPLE_REGS_USER);
> =20
> -	ret =3D perf_event__synthesize_sample(event_copy, evsel->core.attr.samp=
le_type,
> -					    evsel->core.attr.read_format,
> -					    evsel->core.attr.branch_sample_type, sample);
> -	if (ret) {
> -		pr_err("Failed to synthesize sample\n");
> -		return ret;
> -	}
> +	perf_event__synthesize_sample(event_copy, sample_type,
> +				      evsel->core.attr.read_format,
> +				      evsel->core.attr.branch_sample_type, sample);
>  	return perf_event__repipe_synth(tool, event_copy);

Is it safe to remove the error check here?

If synthesis fails and returns a negative error code, event_copy might
remain uninitialized. Unconditionally passing it to perf_event__repipe_synt=
h()
could write malformed or uninitialized memory to the output stream.

>  }

[ ... ]

> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c

[ ... ]

> @@ -1731,6 +1731,7 @@ static void intel_pt_prep_b_sample(struct intel_pt =
*pt,
>  static int intel_pt_inject_event(union perf_event *event,
>  				 struct perf_sample *sample, u64 type)
>  {
> +	event->header.type =3D PERF_RECORD_SAMPLE;
>  	event->header.size =3D perf_event__sample_event_size(sample, type, /*re=
ad_format=3D*/0,
>  							   /*branch_sample_type=3D*/0);
> =20

Since __cmd_inject() globally sets PERF_SAMPLE_BRANCH_HW_INDEX on all evsels
when add_last_branch is true, does passing branch_sample_type=3D0 here omit
the hw_idx field from synthesized PEBS samples?

Downstream parsers might misalign the payload if the file header advertises
its presence but the payload omits it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428070328.1880=
314-1-irogers@google.com?part=3D2
