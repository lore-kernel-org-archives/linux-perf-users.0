Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350AF37268A
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 04:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776919283; cv=none; b=AuxJyR559EytHU890I3jyubLWhRMQVuxm7I2+tgNw20rHd/DdZWKfFQOddNJPyds1884eCehvJgh71TrhTHMKk3ij4qnfypleNxWuQUTh4n6Z4f1j3TOecrWyvN0s69TuVQydo835IqIdPrj4BZnuHMacf7RczUCKPhZ41tMpEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776919283; c=relaxed/simple;
	bh=gfm2c0NO9rs0jEGBlyoVynUmhi1bK51tj0EPE26HRqE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BaB5/qn7SqbKX4EfiV28fVJnd0EI487KVmZzJ6rpg6SadiuNuT2Odkzm8+haBay4bdUIjvAl+DYELXLuny32q725VjOWSCpN5I2lVCkk4CQM2/La6jUgovz9X79RsA7faSDwjtRRr+K/qadn1sZBmVd3Wn8RI3XnDlr243quYGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKZMOWJA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKZMOWJA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A670BC2BCB2;
	Thu, 23 Apr 2026 04:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776919282;
	bh=gfm2c0NO9rs0jEGBlyoVynUmhi1bK51tj0EPE26HRqE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=pKZMOWJA2CHyPhQjDSVdWiJO4dNs4Iv/1mLY4k8jnFvalHVJ41/jVtFTxQ8O1b1lN
	 JNDom2anft46dEHiSd7CR/Z38nak1GD03QbydOZTPOK92SispQI5MMOzukbs+5FU7H
	 8cGvOXacZnt/sL6lg74R2Karf5hpf7T5QziuxbJDjFOFbaCvytwf/1dqUmn5+DPrcS
	 BrmP7PJWnemcQOhELIgRF28fIuVZQ1zkoiKZkSFIOB9oDvRyaZ5ejbb0T2/WD/LUSa
	 43gX9tipvNRQZYBOLCnx5VY4fBrT5YepkULjMHV2rN6QW6I9mOcmObOYp8/QUvkgMT
	 4rR2nTrwsKNDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/58] perf inject: Fix itrace branch stack synthesis
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-2-irogers@google.com>
References: <20260423035526.1537178-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 04:41:22 +0000
Message-Id: <20260423044122.A670BC2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] Hardware trace decoders omit `hw_idx` from synthetic events, causi=
ng payload corruption
- [High] Pipe mode emits mismatched ATTR headers and SAMPLE payloads, break=
ing stream parsing
- [High] Using `--itrace=3Dl` bypasses AUX data removal, leaking raw payloa=
ds and breaking the ATTR schema
--

commit 78a2f7c742856a8438c089f3906861c87cebd8bd
Author: Ian Rogers <irogers@google.com>

perf inject: Fix itrace branch stack synthesis

When using "perf inject --itrace=3DL" to synthesize branch stacks from AUX
data, several issues caused failures. This commit fixes them by adjusting
how sample_type and branch_sample_type are handled in synthesis, record
layout, and early injection processing.

> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index f174bc69cec45..88c0ef4f5ff19 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -375,7 +375,59 @@ static int perf_event__repipe_sample(const struct pe=
rf_tool *tool,
[ ... ]
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

If --itrace=3Dl is passed, last_branch is true but add_last_branch is false.

Will the code enter the first if branch but skip the add_last_branch block,
meaning evsel->core.attr.sample_type is not modified and still contains
PERF_SAMPLE_AUX?

Since it took the first if branch, it bypasses the else if fallback block
that calls perf_inject__cut_auxtrace_sample(). Does this mean it fails to
drop the AUX data?

Later, __cmd_inject() unconditionally strips PERF_SAMPLE_AUX from the file
header. Will this result in the output file falsely claiming there is no
AUX data in its header, while retaining the raw AUX payloads in the records?

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

These permanent evsel->core.attr modifications appear to be located in a
block that only runs when not in pipe mode (!inject->output.is_pipe).

In pipe mode (perf inject -o -), input ATTR events are repiped early and
unchanged. Later, perf_event__repipe_sample() temporarily mutates
evsel->core.attr.sample_type to inject the branch stack and removes AUX
data, repiping the SAMPLE payload using this modified layout.

Does this cause the downstream pipe consumer to receive ATTRs that specify
no branch stack and include AUX data, while the SAMPLE payloads are
mutated? Could this mismatch cause the parser to misinterpret the branch
stack bytes as subsequent fields, leading to out-of-bounds reads?

> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index fc9eec8b54b82..2dce6106c038d 100644
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

Hardware trace injection functions like intel_pt_inject_event pass 0 for
the branch_sample_type parameter here. Consequently, the hw_idx field is
not written to the synthetic sample payloads.

However, the event attributes generated by these trace synthesizers declare
that hw_idx is present (PERF_SAMPLE_BRANCH_HW_INDEX).

When perf report parses these events, will it expect the hw_idx field based
on the attribute header, misalign the payload, and consume the first branch
entry's from address as hw_idx?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D1
