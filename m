Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315A6285CA4
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 21:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779140259; cv=none; b=dS3Y0AizPlIP0u2pFzo5sN7MxMg6BYMm28E2IfDGFAPVxAobUjIunAvelwtPUUhy6c16xbYzXzGFv+9T+VI/E3mrnr6R2RiQdXDNm39HylEGxqzvYAu1drD+s4IwKJypvX66td7hcrpDQB513ojFCBqwAkT2gXfRfPnMejmt1M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779140259; c=relaxed/simple;
	bh=wIqaVtcEJzvyUJjMEMurHaK1NhKEUFFxQZjAs1flii8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Pnvb7rtaA5mqZ2C9wwhnj8kWKGqrsuLXYFr/JmUaa1pY+4qWWfA24r+vC1E2jMJOweRynnXORhL0eLauyAlkL3fWVpkleM8MwtG9qM3gP5VpuQzINkiWG+zAiUMS8e1zesp9sfj2CC6dR1PXncOrnVLhZxxG6Wnrd1YGOREtfQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LX3uE9bf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LX3uE9bf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02AFC2BCB7;
	Mon, 18 May 2026 21:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779140258;
	bh=wIqaVtcEJzvyUJjMEMurHaK1NhKEUFFxQZjAs1flii8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=LX3uE9bfPLKer0EDOtGsMnM27PRHE7lSUTwiQnVlK9q6eAz0dGI1g+EX7ES/GUaEM
	 zTgdqkYD72rgpzgbG4RhqCxeHt3xJL6NUXhl9z5K09oGNG95knFxbI+w3ZY7u/jgqC
	 Nkm6d2dPZWJoS8hnbJFy7woRku9tQovQPSxApceOR0LyCQQmlY3wGyLUOzuBaismL+
	 GUtt7Ul2kvYTDJp+SZKSZQz4kT+tZiC4iq/7GXjt0EWmOCcL1RYMLI0IHUTKa6rgda
	 FNuBCYdioM1OXtoO0/ZY5Eq7A+UW104q/dB5mFytqbRWFi1ggHhgVcWbh6JIl9m+af
	 Cp2cIhO8YPPSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/2] perf inject: Fix itrace branch stack synthesis
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260518203805.2955241-3-irogers@google.com>
References: <20260518203805.2955241-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 21:37:38 +0000
Message-Id: <20260518213738.B02AFC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unconditional dereference of `evsel` in `perf_event__repipe_samp=
le` can cause a SIGSEGV when processing events with unknown IDs.
--

commit f883a5f637221df403997603ff0a3d50c5cf401b
Author: Ian Rogers <irogers@google.com>

perf inject: Fix itrace branch stack synthesis

This commit addresses several issues with synthesizing branch stacks from
AUX data when using "perf inject --itrace=3DL". It fixes sample types, modi=
fies
event attributes, and addresses multiple parsing, size calculation, and poi=
nter
issues in event repiping paths.

> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 5f06ee1c14a08..45eb883f86797 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
[ ... ]
> @@ -375,7 +415,67 @@ static int perf_event__repipe_sample(const struct pe=
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

If machines__deliver_event() encounters a PERF_RECORD_READ event with an
unknown or missing sample ID, evsel may be evaluated to NULL and passed
to this callback. Does this unconditionally dereference evsel, leading to
a crash when analyzing a malformed perf.data file?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518203805.2955=
241-1-irogers@google.com?part=3D2
