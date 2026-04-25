Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DEC391E74
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777159777; cv=none; b=Eus2CPL+0ZxUufNV1dRHxptzlvg6lRJBz5OFmpzPBZpHxr/aFmOWD7jK/97mx29vbqS/EXzv2Fg+bOJmvP8ETFZ0NkNfOUV37PY6kcVOHD88DKsHHVBUq6+jtzHexnmcez9USQxveejkYoFI4ArrEAXv8S9mVNmQvlmL/7UPfNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777159777; c=relaxed/simple;
	bh=xvmk8fVo7Xu4BEqbN0BVSmhJI9530gdSSyrpMnsHLGE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fsusvZYf8kAqUEZQ0Rjd9XldkJOR/14l8kMXC8FEfV5mYiBdtfvnvR0msraxjmYhcturNSj/mLIzQ0/imqy8CZd4iiJ5e/pfNtf2YN9wLzqh1NJs2U+tablWbFnjyCaYsOPpV+x00/O19qBEfLhslr3DJpObVrU12yuOKzpb8CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4QhVwN5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4QhVwN5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E97CC2BCB0;
	Sat, 25 Apr 2026 23:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777159777;
	bh=xvmk8fVo7Xu4BEqbN0BVSmhJI9530gdSSyrpMnsHLGE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=N4QhVwN52AAipmjY59CSdq2YzlSALQDpmXAzQhjNuV+9Af0zDy0NJX8RSE9a3d792
	 Osybnj9wAAUEQ4Vea7zrsje1Zhu5c/Rt9LSXmiRy/klG75g4mfdYLkchYVBrai90ye
	 Ze1kGxWCFESqEOuSr0LoniCvKGHQI4rlOx0X/DRKPgXjsCOya1eYBahfEIqgLe+qlV
	 8/7vamGuUgYTeFQksJZcRv/6smQEiVmgZeMMsVbe1LeLFG/UwI0ERbjinyrH5kJlJN
	 /207qgOD47+I7OTfYT0RfUUhY+Ba80WhiT/cJB0bpaV21Z4q+lh5K74hPEDMBeSJnP
	 mjMV4E8muRBKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/59] perf inject: Fix itrace branch stack synthesis
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-2-irogers@google.com>
References: <20260425224951.174663-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:29:36 +0000
Message-Id: <20260425232937.3E97CC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [High] Uninitialized `header.misc` field in synthesized branch stack samp=
les corrupts CPU mode metadata.
- [High] Pipeline stream corruption in pipe mode due to missing ATTR header=
 updates.
- [High] Hardcoded `branch_sample_type=3D0` in auxtrace decoders omits `hw_=
idx` for PEBS samples, breaking alignment.
- [High] `last_branch` injection bypasses AUX data stripping, causing a mis=
match between the payload and the file header.
--

commit f5581930b39cbe639866b1a06c082d518b3d6c69
Author: Ian Rogers <irogers@google.com>

perf inject: Fix itrace branch stack synthesis

When using "perf inject --itrace=3DL" to synthesize branch stacks from aux =
data,
failures occurred due to incorrect sample_type and unhandled hardware indic=
es.
This commit fixes sample_type flags during synthesis and explicitly passes
branch_sample_type to properly write the nr and hw_idx fields.

> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index f174bc69cec4..88c0ef4f5ff1 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
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

Since event_copy is allocated with malloc(), is it possible that
event_copy->header.misc is left uninitialized?

event_copy->header.type and event_copy->header.size are populated below, but
header.misc seems to be skipped. Could this result in garbage data being
passed for CPU mode and other flags, corrupting downstream symbol resolutio=
n?

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

If perf inject is run with --itrace=3DL, last_branch is true but
add_last_branch is false, so PERF_SAMPLE_AUX is not stripped here.

Since __cmd_inject() unconditionally strips PERF_SAMPLE_AUX from the output
session header, could this lead to samples being synthesized and written wi=
th
their aux data intact, causing a mismatch between the declared header
attributes and the actual sample payload?

[ ... ]
> @@ -2434,12 +2488,25 @@ static int __cmd_inject(struct perf_inject *injec=
t)
>  		 * synthesized hardware events, so clear the feature flag.
>  		 */
>  		if (inject->itrace_synth_opts.set) {
> +			struct evsel *evsel;
> +
>  			perf_header__clear_feat(&session->header,
>  						HEADER_AUXTRACE);
> -			if (inject->itrace_synth_opts.last_branch ||
> -			    inject->itrace_synth_opts.add_last_branch)
> +
> +			evlist__for_each_entry(session->evlist, evsel) {
> +				evsel->core.attr.sample_type &=3D ~PERF_SAMPLE_AUX;
> +			}
> +
> +			if (inject->itrace_synth_opts.add_last_branch) {
>  				perf_header__set_feat(&session->header,
>  						      HEADER_BRANCH_STACK);
> +
> +				evlist__for_each_entry(session->evlist, evsel) {
> +					evsel->core.attr.sample_type |=3D PERF_SAMPLE_BRANCH_STACK;
> +					evsel->core.attr.branch_sample_type |=3D
> +						PERF_SAMPLE_BRANCH_HW_INDEX;
> +				}
> +			}
>  		}

This block updates the attributes to reflect the new sample payload, but
it is inside an if (!inject->output.is_pipe && !inject->in_place_update)
check.

When pipe mode is used, attributes are emitted inline at the start of the
stream. If the payload is modified in perf_event__repipe_sample() without
the corresponding attribute updates in pipe mode, will downstream pipe
consumers receive initial attributes that do not match the modified payload=
s?

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

Passing 0 for branch_sample_type here hardcodes the synthesis to omit the
hw_idx field.

Since intel_pt_inject_event() is used for synthesizing pebs samples which
inherit the original evsel configuration, what happens if the original pebs
evsel had PERF_SAMPLE_BRANCH_HW_INDEX enabled? Will this cause the payload
to omit hw_idx while the attributes still expect it, misaligning all
subsequent payload reads?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D1
