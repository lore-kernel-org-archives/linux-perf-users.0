Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E96C379C21
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 04:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878775; cv=none; b=LHupLVAoawX1B/KInwW7kqCkC147a9QxJV+/XyXbltvrZ7402FRFBTDAq2YXxKfdJsfr0J+tBdckonv/7S8v99PTFL8FsSYLz3KBhpNlVNjWl3pfczTDEojKuISpAv7rV3vPP5yQ5/Rr8vKicohBeMIkXCb+9ro9dI04WleWyiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878775; c=relaxed/simple;
	bh=9tk1vVSuAFhAR37UuQujSS17OICewt++HgV6lBhs1t0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qgb+iOGCkEZ6rOmXoAGK1lsMnx11kGmFSKVCGuja2t0kgX/a1UEZzkYnj9jFTzzW08iOed70yP32jqIhqt6UgvZvW3/Uqy9x7NGsoycnUgt+2Nk5L6DgK+DmjBwhvBCaa9oapnBk4KsvrHw9aapLJp05AChDIoiEKvYKZl/I9zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PP8TsBmP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PP8TsBmP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C96B1F000E9;
	Wed,  1 Jul 2026 04:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782878766;
	bh=PRix4r3mm87USVLGtChm5ILz3LumII6/9o4SEYGEQcc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PP8TsBmPc0nx/7frQHJyDsalIEl90HFqTJr5evQUmQcMK8QzDvHtka1S8dyDQuEXg
	 7J0zmDH6xjoqKKjE4s8I9Ip/aATnlWA8Ek9+RLTkIciO8py5HjdnBZ1So7OqLnR8cz
	 1qcdb6w6tHbrSPvqVHdRlO78r07HC1H0bFeHGDCodAf8xZGXEtv67vJ3QeEGUL2ADz
	 Et4VmBAiCyt3Dg/NcqUylS5tRzjwUWlNO5Kfsd18vWt2wiumA0ye0cMudW93qxeJ1c
	 KN/v2d/PyVjgcwV6Ue0Dqf0oqPLPyX3S+3Su37yRJiumHy7h+gCdToxizGW59UlsD9
	 SwAJvUMaVd68w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/21] perf annotate: Deduplicate overlapping ARM SPE
 events for data type profiling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260701035355.752944-11-wutengda@huaweicloud.com>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-11-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 04:06:05 +0000
Message-Id: <20260701040606.2C96B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Invalid union access causes severe type punning, false positive =
event dropping, and logic failure.
- [Medium] Unprotected dereference of potentially NULL `evsel->name` causin=
g a segmentation fault.
--

commit 21f6f127e80c94aececac4065deebfce02da27b3
Author: Tengda Wu <wutengda@huaweicloud.com>

perf annotate: Deduplicate overlapping ARM SPE events for data type profili=
ng

When data type profiling is enabled on ARM SPE, multiple overlapping
events are synthesized for a single sampled instruction. This patch
implements automatic deduplication in process_sample_event() by retaining
only the "instructions" event when data type annotation is enabled and no
explicit itrace options are configured.

> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index 69cb72b2082a6..46b2bd3fb2013 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -283,9 +283,22 @@ static int process_sample_event(const struct perf_to=
ol *tool,
>  				struct machine *machine)
>  {
>  	struct perf_annotate *ann =3D container_of(tool, struct perf_annotate, =
tool);
> +	struct evsel *evsel =3D sample->evsel;
>  	struct addr_location al;
>  	int ret =3D 0;
> =20
> +	/*
> +	 * ARM SPE synthesizes multiple overlapping events (e.g., l1d-miss,
> +	 * tlb-access) for a single sampled instruction. When data type is
> +	 * enabled, counting all of these overlapping events would inflate
> +	 * the profile and distort the data type statistics. To avoid this,
> +	 * deduplicate by retaining only the comprehensive "instructions" event.
> +	 */
> +	if (ann->data_type && !ann->session->itrace_synth_opts->set &&
> +	    event->auxtrace_info.type =3D=3D PERF_AUXTRACE_ARM_SPE &&

[Severity: Medium]
Since event is a union of all perf events, does checking
event->auxtrace_info.type on a PERF_RECORD_SAMPLE event read the sample data
payload as if it were an auxtrace type?

If a normal event's first 32-bit payload (like PID 4 when PERF_SAMPLE_TID
is the first element) equals 4 (PERF_AUXTRACE_ARM_SPE), could this falsely
match and silently drop the event?

> +	    strcmp(evsel->name, "instructions") !=3D 0)

[Severity: Medium]
Could evsel->name be NULL here if the event is unnamed or if we are
processing a perf.data file missing the HEADER_EVENT_DESC feature?

Passing NULL to strcmp() would cause a segmentation fault. Would it be safer
to use the evsel__name(evsel) wrapper instead?

> +		return 0;
> +
>  	addr_location__init(&al);

[ ... ]

> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 552f063f126e6..e027e3b200bfb 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -403,6 +403,7 @@ static void arm_spe_prep_sample(struct arm_spe *spe,
>  	event->sample.header.type =3D PERF_RECORD_SAMPLE;
>  	event->sample.header.misc =3D sample->cpumode;
>  	event->sample.header.size =3D sizeof(struct perf_event_header);
> +	event->auxtrace_info.type =3D PERF_AUXTRACE_ARM_SPE;

[Severity: Medium]
Writing to auxtrace_info.type modifies offset 8 of the event union, which
aliases the sample payload.

If trace injection is used, does perf_event__synthesize_sample() subsequent=
ly
overwrite this offset with the actual sample payload (such as sample->id),
erasing this magic value and breaking the deduplication entirely?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701035355.7529=
44-1-wutengda@huaweicloud.com?part=3D10
