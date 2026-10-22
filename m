Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792638842;
	b=1ZX/G/7owJYHWrIA9RQS4/nKcXz0cUOqEDufNu9VPU4901J4VtfO4NUqOKeYBB3iePOM
	 hhkosfOy/duCReA71YtpyyuTDu6CCj88oiVSKFb13Rorg2QqZIkmUuNhGSgV4RKCLDhnR
	 MmsxQjaEBZowaDbFyY9k7j5ieXmL7uGrFC4Vl85tFAYf35YQWB0A45FgsKZUlUXp8uRBW
	 f2tlyJJeh8OfywprSEVALkzsadtJ1feVw5AgAPbPM65m9fOqUUPbfAEL89TwmOlAz9j1I
	 PS3FzOKsngzQonKLTT8sGnDBtsiIzB8jZ8BXx80btfEqZ9ZfwjZ18w+z6ep6dnMUkdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792638842;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GWaVA28AQnWNN2E6+d9AhmxogxCmve7gDtUuhDNkgUc=;
	b=PEmNgT6+RUSEP6fUCP1rtsxK225zRNR1mQVlJgFhFPno6fS0MzgLnp5OuofhxyEv+bYN
	 rN2fdl7uPzEsieXCxdliP/Q7NIQaIAWmFg5nnUV+mwYCshzMUraqlIRby7CYxn/CDnM7P
	 8Yj2jhD8hs8qc67/9CtqN74rD6HNHB/AF4gJq0v5oyKGY5UlnhFG+08rt/mrTiu30kP4E
	 bzaURVA5mlYYnSzCWRyXH4c8gsTuQqSlij2Uh60SE6H/08Nz/JCoC1RwtAUz4Y5Fb4xeK
	 XlJt/LAi2AKhfBoCiY5Qes0HGxR1bawzVBWnkPWNuWLgN2QqYhgNW37nfJvCrJmrJDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z3MnwUU9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E97F606A32F
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 03:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z3MnwUU9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244AF1F000C4;
	Thu, 22 Oct 2026 03:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792638842;
	bh=GWaVA28AQnWNN2E6+d9AhmxogxCmve7gDtUuhDNkgUc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Z3MnwUU98/vFPE+UC60StS3Q30REoAQwPggH04eRo2TmcXXzsZCFWk5/Qm1Nr8p45
	 kQUb2+bKeVP+RFtNyIxJ4tqeX9hSjnZleyYvr/sthmoDInrvN1B77UnzjdzFhM2l9w
	 QWLePG4LF16O95PLKJ16pjR/fdZdgurz/qFYT3cBloq9imBr/QlL56dlwJNTJ8qxWU
	 eMPhzae31pM03ePLEvqgAInTK1kvija9NNOI1/EmbRZLY2DzF2zSA0i3lVsZbcN0xP
	 5ARLbofgEeCXnkA0Hpv9Sm6beYa8VIJheBy8LHZgpE8/mh3qGgR0/m1TO44Han3aLO
	 fOp8fipB0Vewg==
Message-ID: <sashiko-outbox-180901@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf stat: Start tool events when enable_on_exec is
 used
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261022024919.263876-1-takano32@gmail.com>
References: <20261022024919.263876-1-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 03:14:01 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf stat: NULL dereference in enable_counters() on unsupported =
events
--

commit 63681c497cb81f27ece4b03357873947bd854a0c
Author: TAKANO Mitsuhiro <takano32@gmail.com>

perf stat: Start tool events when enable_on_exec is used

This commit explicitly enables tool events in enable_counters() when
target__enable_on_exec() is true, since tool events are emulated in userspa=
ce
and are not started by the kernel on exec.

> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index c50cf230f16ed..2062623682fb2 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -510,6 +510,15 @@ static int enable_counters(void)
>  	if (!target__enable_on_exec(&target)) {
>  		if (!all_counters_use_bpf)
>  			evlist__enable(evsel_list);
> +	} else {
> +		/*
> +		 * Tool events are emulated in perf, so enable_on_exec above
> +		 * does not start them.
> +		 */
> +		evlist__for_each_entry(evsel_list, evsel) {
> +			if (evsel__is_tool(evsel))
> +				evsel__enable(evsel);
> +		}
>  	}
>  	return 0;
>  }

[Severity: Medium]
Can calling evsel__enable(evsel) here without checking evsel->supported or
evsel->core.fd dereference a null pointer when an event fails to open?

Prior to calling enable_counters(), __run_perf_stat() frees core.fd for any
unsupported event:

tools/perf/builtin-stat.c:__run_perf_stat() {
	...
	evlist__for_each_entry(evsel_list, counter) {
		if (!counter->supported) {
			perf_evsel__free_fd(&counter->core);
			continue;
		}
	...
}

When target__enable_on_exec() is false, evlist__enable() ->
__evlist__enable() skips events where pos->core.fd is null:

tools/perf/util/evlist.c:__evlist__enable() {
	...
		if (!evsel__is_group_leader(pos) || !pos->core.fd)
			continue;
	...
}

In the new else branch, if a user_time or system_time event fails in
evsel__tool_pmu_open() after evsel->disabled =3D true is set (for example o=
n a
subsequent thread or repeat run), evsel->supported is false and
evsel->core.fd is freed. Calling evsel__enable() then follows:

evsel__enable()
  -> evsel__tool_pmu_enable()
    -> evsel__tool_pmu_enable_cpu()
      -> tool_pmu__read_stat()

where tool_pmu__read_stat() dereferences evsel->core.fd via:

	int fd =3D FD(evsel, cpu_map_idx, thread);

Similarly, if a tool event such as user_time or system_time is the group
leader of a group whose member failed to open (such as
perf stat -e "{user_time,cycles}" -- sleep 0.1, where opening cycles with t=
he
procfs fd as group_fd fails and frees cycles->core.fd), evsel__enable()
iterates over the group members:

tools/perf/util/evsel.c:evsel__enable() {
	...
		for_each_group_member(member, evsel) {
			if (evsel__is_non_perf_event_open_pmu(evsel) ||
			    evsel__is_non_perf_event_open_pmu(member)) {
				int mem_err =3D evsel__enable(member);
	...
}

which calls evsel__enable(member) -> perf_evsel__enable(&member->core) and
dereferences member->core.fd when evaluating xyarray__max_x(evsel->fd).

Should enable_counters() and the group member loop in evsel__enable() check
supported (or core.fd) before enabling?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022024919.2638=
76-1-takano32@gmail.com?part=3D1
