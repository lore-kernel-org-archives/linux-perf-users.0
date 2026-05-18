Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2425A23505E
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 06:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779086361; cv=none; b=kkEwHuH/yrlhJ+rH3uEec9kn1ncNhbrDkMYn86231DTTscNcPU22vxa9wm/a63cjdhzqnngrFmXJ0NjIhLk7DCPEu9qhFGOT1JiC4cIsk0iLGzPICcJ9e3vqmS8TUWhbydY//STe4T1a7m3OpGT7jabRZ9qih9hYQWsNfEkDx4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779086361; c=relaxed/simple;
	bh=Un9M4p1yEMnitL979svEOsmfNjWa26t/FY+2zKpxE10=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lBiCRumq3g27YIAFsnfBr1ltiimWoCez3Vsuk2gCKeu8QUXD9L8VK4d9GKp34eracz3yPFQQ7k57s+XbTiBs8hCYgTEPEj5FOYRnVbNn6cxgu8TQ99EIFjkfECzbLFvEwq9QvuBwdZkdtjtV1RmLzNi9E5MePU+KTaDNUPTqouA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rr/BeUpg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rr/BeUpg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F6AC2BCB7;
	Mon, 18 May 2026 06:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779086360;
	bh=Un9M4p1yEMnitL979svEOsmfNjWa26t/FY+2zKpxE10=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=rr/BeUpgk8pR55j2tuQ+VpDx/mzBoeLd4xcIIYq17ZtiMFAi07fYfIe9i4+SnnA3/
	 Biyy4rmD3jDMCw7X6G5SJvSG2ptrB714XnUkn0I80ssy6UmsLRNABVdkARHVn/sVPg
	 MN3+hBxju026ik2iO8GOrOEOhp3Z5XSyVSVw+kcQwZTKRFZg1YhOWSfdP0cylD3p4P
	 34rTHD/7SsE4Xx6H0HOziNe99mXiuyoJ64GJQfprx42EB4Xbbtse5cZli/EUj1i6e5
	 79P3AMG9y1QHxk0sAUI35Cp5/J5WAA0qtk/xVLreJD4F8nhzkIkP9DiqzcJuE7S72i
	 2ZZkpEudBYIcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] perf event: Fix size of synthesized sample with
 branch stacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260518061228.2582860-2-irogers@google.com>
References: <20260518061228.2582860-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 06:39:19 +0000
Message-Id: <20260518063920.50F6AC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Heap buffer overflow and event truncation in `perf_event__convert_=
sample_callchain` due to incorrectly using unmasked `sample_type`.
- [High] Hardware tracer event corruption due to hardcoded `branch_sample_t=
ype=3D0` omitting the `hw_idx` field.
--

commit bc54c42a1fd16f8d3cc2f06f7ef9e4f81b9c3d09
Author: Ian Rogers <irogers@google.com>

perf event: Fix size of synthesized sample with branch stacks

This commit fixes the writing of the nr and hw_idx values during sample eve=
nt
synthesis by passing the branch_sample_type into the sample size and
synthesis functions.

> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
[ ... ]
> @@ -463,8 +463,13 @@ static int perf_event__convert_sample_callchain(cons=
t struct perf_tool *tool,
>  	/* remove sample_type {STACK,REGS}_USER for synthesize */
>  	sample_type &=3D ~(PERF_SAMPLE_STACK_USER | PERF_SAMPLE_REGS_USER);
> =20
> -	perf_event__synthesize_sample(event_copy, sample_type,
> -				      evsel->core.attr.read_format, sample);
> +	ret =3D perf_event__synthesize_sample(event_copy, evsel->core.attr.samp=
le_type,
> +					    evsel->core.attr.read_format,
> +					    evsel->core.attr.branch_sample_type, sample);

Is it possible this causes a heap buffer overflow or event truncation?

By using evsel->core.attr.sample_type instead of the local masked sample_ty=
pe
variable, the synthesizer is instructed to write the full user stack and
registers into event_copy. If the original stack is large, appending the ne=
wly
resolved callchain might overflow the allocation.

Additionally, since event_copy->header.size was manually adjusted to the
smaller size earlier in this function, could this cause the output event
stream to become truncated or corrupted?

I noticed this is explicitly fixed later in the patch series in commit
5881c330c2ca4300a88cc8c8e4d578c17a6ebef5 ("perf inject: Fix itrace branch
stack synthesis").

> +	if (ret) {
> +		pr_err("Failed to synthesize sample\n");
> +		return ret;
> +	}
>  	return perf_event__repipe_synth(tool, event_copy);
>  }
[ ... ]
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
[ ... ]
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

Could hardcoding branch_sample_type to 0 here cause hardware tracer event
corruption?

Hardware tracers like ARM SPE, Intel PT, and CS-ETM explicitly set
PERF_SAMPLE_BRANCH_HW_INDEX in their event attributes during setup. By
passing 0 to the synthesizer, it skips writing the 8-byte hw_idx field in
the payload.

When parsing the synthesized event later, wouldn't tools like
evsel__parse_sample() see the flag and incorrectly consume the first 8 bytes
of the branch stack entries as hw_idx, misaligning all subsequent fields?

I noticed this same hardcoded 0 is used in the cs-etm.c and intel-pt.c upda=
tes
in this commit, and that this is explicitly fixed for all hardware tracers
later in the patch series in commit 5881c330c2ca4300a88cc8c8e4d578c17a6ebef5
("perf inject: Fix itrace branch stack synthesis").

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518061228.2582=
860-1-irogers@google.com?part=3D1
