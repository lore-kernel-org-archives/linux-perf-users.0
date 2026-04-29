Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA9D3921E4
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 21:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777497493; cv=none; b=WnZS7oMsPClf7VjjqJda5swm7n+cDyVoJJH0ahv2r1R0qFb0rFRpgBcJ/amgP+SaKim8rEQDc0VFrX9Iuuf/RNkUO9zhfrD2b2q3p73500aR+cYfdBqFNyNt+3RStkdMK18xdaGeSmPmGf376nA6QEFNAREX8tcnhLA3H9F3+S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777497493; c=relaxed/simple;
	bh=F8fdBGzzp3QKBLyXCvELrVU2w7hIFt/6PhbRA7GY790=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NywBRgvyMkmJf1+vkCVCQO12JalBtK6+vd8+xft0ekBivmnp/lXI3WTVKN+OgJIl+7U1nUlafHm262lCLgbABcjfG/W8Xefhn2J695zp8M+z94jwOrUc0mdysPzOErKzqqcVa6CJrq5noYh0Ez0qMOfdVowkyr+RdfXnMzQaj3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUJucfmN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUJucfmN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D2AC2BCB4;
	Wed, 29 Apr 2026 21:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777497493;
	bh=F8fdBGzzp3QKBLyXCvELrVU2w7hIFt/6PhbRA7GY790=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=FUJucfmNdbjwcpWC+V83cYj0ir8g6O2xg544Fe1NBMZKWQX/gPX46FJrXk2XEVFHT
	 xLyiwNpPit2ObQPVESoVYNTpYhWU8AMRhIkQ3V2rhlhRMfSLe2CINuwUszKJLOirey
	 J59rwsD22EjL+3o/na28kaMXFf7Hwj+ShzZjSp3rVTVBcmf5JawNMh5qtTP5SysLFL
	 oGFMvWf7EYu0VOkAurp1Cvx1FRp86I2QWYThO9cPifpp+HvlTvb4Jvp0QMmP4wT5so
	 YWFtNLjGKvxklxtQagpwRkjMTtIAvs3Sq1gjyy9C1IOC4LyuST4KcVs9Q+DCBQICLD
	 y1m1IOjoWdiZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] perf inject: Fix itrace branch stack synthesis
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260429181136.2712655-3-irogers@google.com>
References: <20260429181136.2712655-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 21:18:12 +0000
Message-Id: <20260429211813.01D2AC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Modifying `event->attr.attr` in-place in `perf_event__repipe_a=
ttr` causes SIGSEGV and completely breaks sample parsing.
- [High] The size check in `perf_event__repipe_attr` incorrectly rejects va=
lid older files and causes out-of-bounds writes.
- [High] Flawed `sample_size` recalculation in `perf_event__convert_sample_=
callchain` causes heap memory leaks and malformed output.
--

commit 64e2d17135bd2355121cf62d57be79321e910c46
Author: Ian Rogers <irogers@google.com>

perf inject: Fix itrace branch stack synthesis

This commit addresses several issues with synthesizing branch stacks from
AUX data when using "perf inject --itrace=3DL". It modifies sample types ea=
rly
to handle missing branch stack flags and fixes sample synthesis logic.

> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 0c51cb4250d1..13fb1f05ceb2 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -223,6 +223,19 @@ static int perf_event__repipe_attr(const struct perf=
_tool *tool,
>  						  tool);
>  	int ret;
> =20
> +	if (event->header.size < sizeof(struct perf_record_header_attr)) {

Does this size check incorrectly reject valid older files?

Older perf.data files have a smaller attr.size (e.g., 64 bytes). Valid
events from older kernels may have a total size of 72 bytes, triggering
this check and causing perf inject to wrongly reject them.

If an older event has enough trailing IDs to pass the size check, the struct
ends at offset 64 and the id[] array begins at offset 72. Modifying
event->attr.attr.branch_sample_type writes to offset 80, which overlaps with
the id[] array and can corrupt the event ID data.

> +		pr_err("Attribute event size %u is too small\n", event->header.size);
> +		return -EINVAL;
> +	}
> +
> +	if (inject->itrace_synth_opts.set)
> +		event->attr.attr.sample_type &=3D ~PERF_SAMPLE_AUX;
> +
> +	if (inject->itrace_synth_opts.add_last_branch) {
> +		event->attr.attr.sample_type |=3D PERF_SAMPLE_BRANCH_STACK;
> +		event->attr.attr.branch_sample_type |=3D PERF_SAMPLE_BRANCH_HW_INDEX;
> +	}

Could modifying event->attr.attr in-place here cause a segmentation fault?

When reading from a standard perf.data file, perf_session__process_events()
mmaps the file into memory using PROT_READ. The event pointer passed to
perf_event__repipe_attr() points directly into this read-only buffer, so
writing to event->attr.attr.sample_type could immediately trigger a SIGSEGV.

Even when reading from a pipe where the buffer might be writable, applying
these modifications before calling perf_event__process_attr() alters the
flags received by the internal evsel. The sample records arriving next
in the stream still physically contain the original layout, which causes
evsel__parse_sample() to misinterpret payload offsets and abort the session.

>  	ret =3D perf_event__process_attr(tool, event, pevlist);

[ ... ]

> @@ -463,7 +531,7 @@ static int perf_event__convert_sample_callchain(const=
 struct perf_tool *tool,
>  	/* remove sample_type {STACK,REGS}_USER for synthesize */
>  	sample_type &=3D ~(PERF_SAMPLE_STACK_USER | PERF_SAMPLE_REGS_USER);
> =20
> -	ret =3D perf_event__synthesize_sample(event_copy, evsel->core.attr.samp=
le_type,
> +	ret =3D perf_event__synthesize_sample(event_copy, sample_type,

This wasn't introduced by this patch, but does the sample_size recalculation
just above this cause heap memory leaks and malformed output?

When adjusting the size of the synthesized sample, the function adds the
size of the newly injected callchain but fails to subtract the size of the
original callchain present in the event. Additionally, when removing
STACK_USER, it only subtracts the payload size, failing to remove the 16 by=
tes
of length prefix and suffix metadata.

This heavily inflates the calculated sample_size. While
perf_event__synthesize_sample() correctly writes the smaller, actual data to
the heap buffer, perf_event__repipe_synth() writes the inflated sample_size
to the output pipe, leaking uninitialized heap memory into the file and
resulting in an oversized, malformed record.

>  					    evsel->core.attr.read_format,
>  					    evsel->core.attr.branch_sample_type, sample);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260429181136.2712=
655-1-irogers@google.com?part=3D2
