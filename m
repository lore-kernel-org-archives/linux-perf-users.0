Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC1B2FE58C
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 20:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777495896; cv=none; b=OJ3UJhXYJoGZlaqzullXzE9SyMLVvJ3LzKFC/aUPbsJs4LMaZ0RrimDEPNnfgnWH7Jd2Jveq50LID03F5Pi8PmGKKx8PK/4YajjBIVTPSPrc1ndmdCJxXc5712pUuu9Re/g9nnxL+XH53QTqhmSxA0wt4BDH64mEAQbh58cw3kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777495896; c=relaxed/simple;
	bh=c8JcYvUrLnJr9ppSMKpYoWvk4JLFYELR1Cku/8uf70o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WMXQYD+wMY/cKUraJrNFom5bV4zvLW0I/ytE+OoWZJM8S1LP+AHXfgePEvSWgmQIc9ZJTbj9h/KVUwXOqOqmPswBeqSzyZM6Mfq/3dk8C05NxRbfnuODUcAiBwflMzPxoiRDNZtATeQ0nwn8Ei00ELB7esenBFguTJ57TsUYMB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPWzX9U/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPWzX9U/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13279C19425;
	Wed, 29 Apr 2026 20:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777495896;
	bh=c8JcYvUrLnJr9ppSMKpYoWvk4JLFYELR1Cku/8uf70o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=VPWzX9U/c7OgABVXrcr/oIX2xdaIdSoRadYkE0eWAldzBcO3h6Y6YfBB6bFWXXFAF
	 C1qBEfGQ7elS0+ho8WV6rg2R455POKBaq9WRMB3MaRH5zbkumVJ5G8mSYamBl61mXw
	 7QNm7rF+elWO7evkxDJqTIqXZLW2Ss0ChGLhPK0hFWA1sAOlxCLDzsnGx3nhhtI3ai
	 vZkGaWGhW4DLiJbfCoxZ3NedcptLl4i2uUu4SPO6Wjf0Zw3X+cPY3ta/yFad72B0Pr
	 QdXW3wPCANHZ20I5iysviqkct/X3b0aNQjnnoAAUAB3p77MS605d80c+OgItCGoPsu
	 pm8U75zC5BbqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] perf event: Fix size of synthesized sample with
 branch stacks
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260429181136.2712655-2-irogers@google.com>
References: <20260429181136.2712655-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 20:51:34 +0000
Message-Id: <20260429205136.13279C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Synthesized branch stack samples in hardware tracers (arm-spe, cs-=
etm, intel-pt) omit the hw_idx field despite the event attribute claiming i=
ts presence, causing parsers to read misaligned data.
- [High] In perf_event__convert_sample_callchain(), passing the unmasked ev=
sel->core.attr.sample_type causes the generated payload to serialize stack =
and register data out of sync with the reduced header.size, leading to data=
 stream corruption.
--

commit eb27565513c2df3df4959ab5f50b38abd090fa86
Author: Ian Rogers <irogers@google.com>

perf event: Fix size of synthesized sample with branch stacks

This commit updates sample event synthesis to correctly size and write the
nr and hw_idx values for branch stacks by explicitly checking the
PERF_SAMPLE_BRANCH_HW_INDEX flag.

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

I noticed this is fixed later in the patch series by commit "perf inject:
Fix itrace branch stack synthesis".

Does passing the unmasked evsel->core.attr.sample_type here instead of the
local masked sample_type variable cause the generated payload to serialize
stack and register data out of sync with the reduced header size?

[ ... ]
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
[ ... ]
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

I see this is fixed for intel-pt.c later in the series by commit
"perf inject: Fix itrace branch stack synthesis", but it appears it remains
unfixed for arm-spe.c and cs-etm.c.

If branch_sample_type is hardcoded to 0 here, will it omit the hw_idx field
even if the synthesized event attribute claims it is present?

If so, will parsers reading the payload misinterpret the first 8 bytes of
the branch entries as the hw_idx field, shifting subsequent sample fields?

[ ... ]
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
[ ... ]
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

Does this function suffer from the same issue, where hardcoding
branch_sample_type to 0 omits the hw_idx field and causes misaligned reads
during parsing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260429181136.2712=
655-1-irogers@google.com?part=3D1
