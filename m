Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F713CDBC3
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 07:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779088062; cv=none; b=Xo7ALo13Evar1QTBKzkiByY7sWFzCco80Hs0Bbk5oKRaq83mzaRMCmFbk/pEOk8BusDECxNg3lTxyUtyguWQ+NqqBu4m59vZhKNrq6J95Ho06c3om43xNpJN33ogzs4+KRWktWqwL5RkKyxCiALd/BJEdByAZrH3ukdHBeyWoHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779088062; c=relaxed/simple;
	bh=izNXAtLWRHussJllq7BiVeLqLI/b2po5Hu3hpsvAlHg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O/FO0G4g4TTGdbZKnarMhrpLVj5iMIfu8TX52X2j3bkidcSSd7Q1UQ8h/llioAajqcW4VTbWi7isIiijQW2eboA1TENK4AuaGQ4MQbi/iVzgmUvKyWdjlyKAl42yfyHV+bYTDxNYgDwS1G5qiwotlrTvTlSg+NLtlzpDU1w4yS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuBMVgOb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuBMVgOb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7041EC2BCB7;
	Mon, 18 May 2026 07:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779088061;
	bh=izNXAtLWRHussJllq7BiVeLqLI/b2po5Hu3hpsvAlHg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=EuBMVgObM4HkXwDUXPB4o8uENBCDduBzjQ6G5ryldJaSKH+LyKLR1snJ5iRO4APY8
	 8UGw3Ncv+2IR3J0thzTIS79GruYdwSaZWYdeUCxe3oNdX3rWOKRo1SSjrKUiUPgO06
	 VNRjLWkAKQZHKHs6xpJkplshOb/X2VFzEyU/dcsKum2VI0333wQSx2g0uPGyBDdNBW
	 WKAu37iZ7Ht6BmjbRRXNb2WFSJJq4RCVOaRCob71z4HfzmnAgq95HWl1HhrjZEhsZX
	 F5+3ewcnabQ4rIqHOrbXkCUs/ffcdFEq9rC+cUYgOjlgrh3V5aD9eYMoo2unmVDj1s
	 5aoGdhMEWQcMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] perf inject: Fix itrace branch stack synthesis
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260518061228.2582860-3-irogers@google.com>
References: <20260518061228.2582860-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 07:07:40 +0000
Message-Id: <20260518070741.7041EC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] Missing `PERF_SAMPLE_MAX_SIZE` bounds check in auxtrace inject=
ion helpers causes Heap Overflow.
- [High] Failure to strip size field on empty AUX samples breaks downstream=
 parsing.
- [High] Early error return in `perf_event__repipe_sample` leaves a danglin=
g pointer and corrupted shared state.
- [High] Integer underflow and out-of-bounds read in `perf_event__repipe_at=
tr`.
- [Medium] Missing `attr.size` update in file mode branch stack injection.
--

commit 5881c330c2ca4300a88cc8c8e4d578c17a6ebef5
Author: Ian Rogers <irogers@google.com>

perf inject: Fix itrace branch stack synthesis

When using "perf inject --itrace=3DL" to synthesize branch stacks from
AUX data, several issues caused failures with the generated file.

> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 0c51cb4250d1e..fe03cab7e9907 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -231,7 +242,24 @@ static int perf_event__repipe_attr(const struct perf=
_tool *tool,
>  	if (!inject->output.is_pipe)
>  		return 0;
> =20
> -	return perf_event__repipe_synth(tool, event);
> +	if (!inject->itrace_synth_opts.set)
> +		return perf_event__repipe_synth(tool, event);
> +
> +	attr =3D event->attr.attr;
> +	n_ids =3D event->header.size - sizeof(event->header) - event->attr.attr=
.size;
> +	n_ids /=3D sizeof(u64);
> +	ids =3D perf_record_header_attr_id(event);

Could event->header.size underflow n_ids here if it is smaller than the
combined size of the header and attribute?

If an event is crafted with a maliciously small size, the direct struct
assignment might trigger an out-of-bounds read, and the underflowed n_ids
could lead to a large out-of-bounds memcpy() in perf_event__synthesize_attr=
().

[ ... ]
> @@ -375,7 +402,63 @@ static int perf_event__repipe_sample(const struct pe=
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
> +		size_t sz;
> +		u64 orig_type =3D evsel->core.attr.sample_type;
> +		u64 orig_branch_type =3D evsel->core.attr.branch_sample_type;
> +
> +		struct branch_stack *orig_bs =3D sample->branch_stack;
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
> +		}
> +		evsel->core.attr.sample_type &=3D ~PERF_SAMPLE_AUX;
> +
> +		sz =3D perf_event__sample_event_size(sample, evsel->core.attr.sample_t=
ype,
> +						   evsel->core.attr.read_format,
> +						   evsel->core.attr.branch_sample_type);
> +
> +		if (sz >=3D PERF_SAMPLE_MAX_SIZE) {
> +			pr_err("Sample size %zu exceeds max size %d\n", sz, PERF_SAMPLE_MAX_S=
IZE);
> +			return -EFAULT;
> +		}

Does this early return leave a dangling pointer in sample->branch_stack and
corrupt the shared evsel state?

Since the cleanup logic that restores evsel->core.attr.sample_type,
evsel->core.attr.branch_sample_type, and sample->branch_stack is bypassed,
sample->branch_stack may be left pointing to the out-of-scope dummy_bs
variable, which could cause a use-after-free if the sample is processed
further.

[ ... ]
> +		evsel->core.attr.sample_type =3D orig_type;
> +		evsel->core.attr.branch_sample_type =3D orig_branch_type;
> +		sample->branch_stack =3D orig_bs;
> +
> +		if (err) {
> +			pr_err("Failed to synthesize sample\n");
> +			return err;
> +		}
> +		event =3D event_copy;
> +	} else if (inject->itrace_synth_opts.set && sample->aux_sample.size) {
>  		event =3D perf_inject__cut_auxtrace_sample(inject, event, sample);
>  		if (IS_ERR(event))
>  			return PTR_ERR(event);

If the original event had PERF_SAMPLE_AUX set but sample->aux_sample.size i=
s 0,
will bypassing perf_inject__cut_auxtrace_sample() leave an 8-byte size field
in the payload?

Because PERF_SAMPLE_AUX is globally stripped from evsel->core.attr.sample_t=
ype,
downstream parsers won't expect this 8-byte field, which might misalign
subsequent fields and cause parsing of the generated file to fail.

[ ... ]
> @@ -2440,12 +2526,25 @@ static int __cmd_inject(struct perf_inject *injec=
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

If the input file was recorded with an older, smaller attribute size, should
evsel->core.attr.size be expanded to PERF_ATTR_SIZE_VER2 here as well?

Unlike the pipe mode logic in perf_event__repipe_attr(), attr.size isn't
expanded here. The newly set branch_sample_type field might reside beyond
attr.size and be silently omitted when headers are written to the output fi=
le.

> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index c4ed9f10e731f..7504b2cb5edd8 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -482,13 +482,23 @@ static void arm_spe__prep_branch_stack(struct arm_s=
pe_queue *speq)
>  	bstack->hw_idx =3D -1ULL;
>  }
> =20
> -static int arm_spe__inject_event(union perf_event *event, struct perf_sa=
mple *sample, u64 type)
> +static int arm_spe__inject_event(struct arm_spe *spe, union perf_event *=
event,
> +				 struct perf_sample *sample, u64 type)
>  {
> +	struct evsel *evsel =3D NULL;
> +	u64 branch_sample_type =3D 0;
> +
> +	if (spe->session && spe->session->evlist)
> +		evsel =3D evlist__id2evsel(spe->session->evlist, sample->id);
> +
> +	if (evsel)
> +		branch_sample_type =3D evsel->core.attr.branch_sample_type;
> +
>  	event->header.type =3D PERF_RECORD_SAMPLE;
>  	event->header.size =3D perf_event__sample_event_size(sample, type, /*re=
ad_format=3D*/0,
> -							   /*branch_sample_type=3D*/0);
> +							   branch_sample_type);

Could the computed event->header.size exceed PERF_SAMPLE_MAX_SIZE here?

The sz >=3D PERF_SAMPLE_MAX_SIZE bounds check was added to
perf_event__repipe_sample() and perf_event__convert_sample_callchain(), but
appears to be missing from the hardware tracing helpers (arm_spe__inject_ev=
ent,
cs_etm__inject_event, intel_pt_inject_event).

If the computed size exceeds PERF_SAMPLE_MAX_SIZE, it might truncate the va=
lue
when assigned to the u16 header.size, while perf_event__synthesize_sample()
writes the full size and overflows the buffer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518061228.2582=
860-1-irogers@google.com?part=3D2
