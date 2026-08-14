Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C252405EB
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Aug 2026 00:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786667380; cv=none; b=oyhsXBwKJbJh4Y0P0+4+bT5by0S2/f0tiU3QnJJmI/Blktnyc6ypM0B/LE4aRkiYa9do6Gi0Uze9aF6HG6tJlz0+ddWf2Ap9Llrg6ShfC/oqc/ECblllycgY/+HCBUSbCBRxnMwho32a8ZXiTl6dUnP2Lis/TOzfFJm3fvf4ZTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786667380; c=relaxed/simple;
	bh=gYHMJbl1IiSrAvFGOGomw4eVzsZPLXEHB0Jiu39eKG8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hpcw41WtYqmNbk8LuMouCdP7IF7CKCgu4z3GANyR4y4781aEMm6/pO3TVIwLpKQiFkoek/LEDMkgYktNayIQdGCBDtrJxAGzt05SzN3ThOsoHAnG1L1mgbdX3He6z3oF2s5pMAnPBtdxvb8LDCdhiMDSXI5rP9drfJzqtsPcSl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERvulkn4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERvulkn4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0309E1F000E9;
	Fri, 14 Aug 2026 00:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786667379;
	bh=V1rtvqH3etpWU4CyXAbl26scw5euxwD0uR1926sroNE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ERvulkn4tTC0GgatIFvwduukHzVQmKYSjHwz3hOeAd560E/amdHtGgF7cNBkA2+YE
	 EyO4qA8kkXX4iZkUSarzzgnlQrp1ji0t3/HMKuY2TEDoBFitMMCKRrpFwrXLFyY32r
	 TaOTl2m1stK63SsSd0pAx+vyyF1nquVHKx32DEi/h90lggSIgccBKpMC5qbpdH5UQN
	 0srZGz0EwQx6OfYvTZszEupbc+v1fhQEcm8kuNmlh1YOTgx0gRLdBHWYcrESPzGg6R
	 brRTeLWpyLlLlhpzEvxmGuaw+1ckvo+T2PRRQyzZLqHo+Nf3Zxy7RhL6fzhthFH02t
	 nQq5TaSvVEqcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 13/33] perf inject: Don't pass evsel with sample
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260413012227.1089445-14-irogers@google.com>
References: <20260413012227.1089445-14-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 00:29:38 +0000
Message-Id: <20260814002939.0309E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] In `perf_inject__sched_stat`, a mismatch between the `sample_type`=
 of the `sched:sched_switch` event and the `sched:sched_stat_*` event cause=
s a heap out-of-bounds write.
--

--- Patch [13]: [PATCH v11 13/33] perf inject: Don't pass evsel with sample=
 ---
commit 5a323f56faef1c75c44630fb2ace9d44a71d43aa
Author: Ian Rogers <irogers@google.com>

perf inject: Don't pass evsel with sample

This commit removes the explicit evsel parameter from several functions sin=
ce
it is already contained within the sample structure. This cleans up the
handling of sample and mmap_evsel when synthesizing build id events and mma=
p2
events with build ids.

> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c

[ ... ]

> @@ -1049,13 +1053,12 @@ static int perf_inject__sched_process_exit(const =
struct perf_tool *tool,
>  static int perf_inject__sched_switch(const struct perf_tool *tool,
>  				     union perf_event *event,
>  				     struct perf_sample *sample,
> -				     struct evsel *evsel,
>  				     struct machine *machine)
>  {
>  	struct perf_inject *inject =3D container_of(tool, struct perf_inject, t=
ool);
>  	struct event_entry *ent;
> =20
> -	perf_inject__sched_process_exit(tool, event, sample, evsel, machine);
> +	perf_inject__sched_process_exit(tool, event, sample, machine);
> =20
>  	ent =3D malloc(event->header.size + sizeof(struct event_entry));

[ ... ]

> @@ -1074,13 +1077,13 @@ static int perf_inject__sched_switch(const struct=
 perf_tool *tool,
>  static int perf_inject__sched_stat(const struct perf_tool *tool,
>  				   union perf_event *event __maybe_unused,
>  				   struct perf_sample *sample,
> -				   struct evsel *evsel,
>  				   struct machine *machine)
>  {
>  	struct event_entry *ent;
>  	union perf_event *event_sw;
>  	struct perf_sample sample_sw;
>  	struct perf_inject *inject =3D container_of(tool, struct perf_inject, t=
ool);
> +	struct evsel *evsel =3D sample->evsel;

[Severity: High]
This is a pre-existing issue, but can this allocation and synthesis mismatc=
h=20
result in a heap out-of-bounds write?

When perf_inject__sched_switch() allocates the ent buffer, it sizes it
precisely for the sched_switch event:

ent =3D malloc(event->header.size + sizeof(struct event_entry));

However, when perf_inject__sched_stat() later repopulates this buffer, it c=
alls
perf_event__synthesize_sample() using the sample_type bitmask of the sched_=
stat
event:

perf_event__synthesize_sample(event_sw, evsel->core.attr.sample_type,
                              evsel->core.attr.read_format, &sample_sw);

If the sched_stat event was configured with a larger sample_type payload th=
an
the sched_switch event (such as callchains or raw data), could
perf_event__synthesize_sample() write sequentially out-of-bounds and
overflow the ent buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260413012227.1089=
445-1-irogers@google.com?part=3D13
