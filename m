Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BF5134CCF
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jun 2026 01:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780883496; cv=none; b=VGgnX+Nr/CFfgp7xYQbb3eFIsN5I2tNLU/3zmaMycN9zZZwf0+Gc6rTmR0ZqDIL8tCpqNXdCx+21tQU8BmnjowO+YLIrxhJnf/Qiyg7RkjuKUSh4jLkUEeEmrmrlrLLUt+0Vo01L6JcgMstGhlORckJo79AVBww2TY7z7Vb9lR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780883496; c=relaxed/simple;
	bh=7Ty1UzMcacFVCNDSEzGBgYIRMkmH6ixWSSsrEnLg3X4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=coWCdK7YEgjLvvIBxAQeLD63wj+xtWdqfVJzSKDv4w4vVA7Bu9PhLZ4CoHmjrP+5ixmzNuN1jUr5f1F0x2vFHZw0jdqbN3lbVjbp08JspDSs8Dd1Psi71C2fTCpYaaB29vbqmjQ4drsqQyrVyQ3mVgI+TCCa+rLuseFxODygXXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vb6iVvvp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vb6iVvvp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A498B1F00893;
	Mon,  8 Jun 2026 01:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780883494;
	bh=B6HbPwNbZfZQCVvqT+CairbTvOvram3d/FNruQ6Fovs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vb6iVvvpHUaFz3iaDyvaF1JQNX/0byNAt51J1eTMBOLu3eXMkvAEEPEdE4eQmUWp3
	 /7acoTf9pO9x/eYXxqnXhMxx/8DDjH5sPIvJqjeoV16QLLg5ISTH5gobYUvvGu+kEN
	 5+Srk/m1TN4GGVI6vOgBmgzjqLLPn4aeMH+DsPzb2znMp56HgY5ggbBJ2XcMKAi3q1
	 x9XzXq7j8l+037eg/hNNQN6kGJBUZZGe1S4YDIQ5rJn6FZWXYo+VnfDJ2FLp5BHzqe
	 E+MAJRBgmBOjYpZOMtF3dzZ0deV0mZ/jrn5OSoA6GU7z9XHMZ/XaG9teT9B6H/iTNW
	 U0oBBgBGTyKmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/11] perf sched: Bounds-check prio before test_bit()
 in timehist
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260608013057.1942953-7-acme@kernel.org>
References: <20260608013057.1942953-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 01:51:34 +0000
Message-Id: <20260608015134.A498B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Integer truncation of `sample->cpu` into `int16_t` bypasses boun=
ds checks and silently misattributes data
- [Medium] perf sched subcommands fail to register required API callbacks (=
`.attr` and `.feature`) for pipe mode
--

commit ccee4e7598c7486d2e3310b0d4a29fa61c041674
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf sched: Bounds-check prio before test_bit() in timehist
   =20
timehist_skip_sample() reads prio from untrusted tracepoint data via
perf_sample__intval(sample, "prev_prio") without bounds validation.
A crafted perf.data with prev_prio >=3D MAX_PRIO (140) causes test_bit()
to read past the end of the prio_bitmap, which is only MAX_PRIO bits.
Add a prio >=3D 0 && prio < MAX_PRIO check before the test_bit() call.

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 1ff01f03d2ad1..ded511d851880 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -2645,7 +2645,9 @@ static bool timehist_skip_sample(struct perf_sched =
*sched,
>  		else if (evsel__name_is(sample->evsel, "sched:sched_switch"))
>  			prio =3D perf_sample__intval(sample, "prev_prio");
> =20
> -		if (prio !=3D -1 && !test_bit(prio, sched->prio_bitmap)) {
> +		/* prio comes from untrusted tracepoint data =E2=80=94 bounds-check be=
fore test_bit */
> +		if (prio >=3D 0 &&
> +		    (prio >=3D MAX_PRIO || !test_bit(prio, sched->prio_bitmap))) {
>  			rc =3D true;
>  			sched->skipped_samples++;
>  		}

[Severity: Medium]
This is a pre-existing issue, but I noticed that the sample->cpu value is
narrowed to a 16-bit integer during struct initialization in map_switch_eve=
nt()
and perf_timehist__process_sample() in tools/perf/builtin-sched.c.

Does this narrowing regression allow wrapped out-of-bounds cpu values to by=
pass
the subsequent validation check?

For example in map_switch_event():

	struct perf_cpu this_cpu =3D {
		.cpu =3D sample->cpu,
	};

	/* perf.data is untrusted input =E2=80=94 CPU may be absent or corrupted */
	if (this_cpu.cpu >=3D MAX_CPUS || this_cpu.cpu < 0) {

If sample->cpu is larger than 32767, it will silently wrap, passing the bou=
nds
check but potentially misattributing data. A similar pattern exists in
perf_timehist__process_sample().

[Severity: Medium]
This isn't a bug introduced by this patch, but looking at cmd_sched() and
perf_sched__timehist() in tools/perf/builtin-sched.c, it appears the perf s=
ched
subcommands fail to register required API callbacks like .attr and .feature
for pipe mode.

In cmd_sched():

	perf_tool__init(&sched.tool, /*ordered_events=3D*/true);
	sched.tool.sample	 =3D perf_sched__process_tracepoint_sample;
	sched.tool.comm		 =3D perf_sched__process_comm;
	sched.tool.namespaces	 =3D perf_event__process_namespaces;
	sched.tool.lost		 =3D perf_event__process_lost;
	sched.tool.fork		 =3D perf_sched__process_fork_event;

And in perf_sched__timehist():

	sched->tool.lost	 =3D process_lost;
	sched->tool.attr	 =3D perf_event__process_attr;
	sched->tool.tracing_data =3D perf_event__process_tracing_data;
	sched->tool.build_id	 =3D perf_event__process_build_id;

Without the .attr callback, no evsel structures are created, and without the
.feature callback, perf_env remains unpopulated in pipe mode.

Does this omission lead to a regression where dropped events or uninitializ=
ed
system metadata occur when processing pipelined inputs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608013057.1942=
953-1-acme@kernel.org?part=3D6
