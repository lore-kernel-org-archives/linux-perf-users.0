Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257B3E56A
	for <linux-perf-users@vger.kernel.org>; Sun,  2 Aug 2026 00:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785628902; cv=none; b=n1Kw830/GSAs1CcHhvk8EszjK4ChnMbcMZxoo/xGg3bzZR+Z+K2cQccw/S0fAlW+6K4YvUJ/9ooGIjRGe0Pikzf2QhhigNfNqfHSl3JTRIDR15d++lUk9501yy5ukvoUU8Iytntq6B4F9N/eaavi27vtvYFQNCgHydOKoI14EPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785628902; c=relaxed/simple;
	bh=SClEYCVuO133nuG8AYqjIidniTZBYeyiO0Y+7Ik5rA8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OSdyJqczvwpPHmvy03cPtNwRlA3dzRyjqCzqjXZKcY1gaZvPqvVThqTir3y4SWyo8L42RMLG2WSHvxBa0PYAFwWTMVCEXEvZR4MQ05muouYBta5o2LqHdsv6YXb76okouDlRBOks5K4Dj0iTN5yIuESebzIvn/a0wf/hS3xb09g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyiAvRpJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyiAvRpJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90AE91F00AC4;
	Sun,  2 Aug 2026 00:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785628900;
	bh=D5QqZfZWaQmzODpp7kMaARDmpxdVLIpw+MeZwbtsMj4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DyiAvRpJXJBAznzULQLh0pIa1lH9JCCxqCXVYTGg+0Mo3+XptD/Yzt9XUvrLhkerh
	 nxwAQfyTxyI6UbK8AhjfMZd3r4DmWtlqcak9pwdWmYT/NOowYsZtsDZ/db4Uu+ODzY
	 ahKMJq9R0pxBQy4cMWac5xlHoqL5ms4+ye5zMhbAJlBTN3XMqTw7Z6l11JznIcGwA4
	 lqqL4kRjB9Bo0CkvcpTxrFOVQ0lUb4EMyYaIJsH3qjn9mu9BAgCcIgcdc+tOaAWuPk
	 82GHL5Wy+AfYtTzQJLeaJ9gvyP16kL9TTZJHnABE9mMFvgXk5VB/kI0ltgmPbwv4s0
	 pELz7vZz0sogQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/4] perf sched: Handle missing trace samples in pipe
 mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260801234008.176724-3-atomlin@atomlin.com>
References: <20260801234008.176724-1-atomlin@atomlin.com>
 <20260801234008.176724-3-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 00:01:40 +0000
Message-Id: <20260802000140.90AE91F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Using `evsel->handler =3D=3D NULL` to conditionally initialize han=
dlers inside the sample processing hot path causes repeated O(N) evlist ite=
rations for unhandled events and drops late-arriving tracepoints.

Pre-existing issues:
- [High] `symbol__init` accesses the `perf_env` before it is populated by p=
ipe feature events, leading to incorrect host-fallback initialization for c=
ross-platform traces.
- [High] `perf sched timehist` remains completely broken for pipe mode stre=
ams.
--

--- Patch [2]: [PATCH v6 2/4] perf sched: Handle missing trace samples in p=
ipe mode ---
commit bdcbf92a5b81c957ee21cce440488c2da3569c14
Author: Aaron Tomlin <atomlin@atomlin.com>

perf sched: Handle missing trace samples in pipe mode

For pipe mode streams, event attributes are received dynamically during
event processing, meaning session->evlist is not populated prior to
perf_session__process_events(). To handle pipe input correctly:
  - Register the missing .attr, .tracing_data, .build_id, and .feature
    callbacks in cmd_sched()
  - Promote the handlers array to file-scope (latency_handlers[]) and
    invoke evlist__set_tracepoints_handlers() dynamically inside
    perf_sched__process_tracepoint_sample() when evsel->handler is NULL
  - Perform the trace check post-processing when handling pipe data

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 94a323da0799a..0abf9f1f3c2e2 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
[ ... ]
> @@ -1946,6 +1955,14 @@ static int perf_sched__process_tracepoint_sample(c=
onst struct perf_tool *tool __
>  	struct evsel *evsel =3D sample->evsel;
>  	int err =3D 0;
> =20
> +	if (evsel->handler =3D=3D NULL && sample->evsel->evlist) {
> +		/* prefer sched_waking if it is captured */
> +		if (evlist__find_tracepoint_by_name(sample->evsel->evlist, "sched:sche=
d_waking"))
> +			latency_handlers[2].handler =3D process_sched_wakeup_ignore;
> +
> +		evlist__set_tracepoints_handlers(sample->evsel->evlist, latency_handle=
rs);
> +	}
> +

[Severity: High]
Does this cause an O(N) traversal on every sample for unhandled events?

If a tracepoint is explicitly recorded but not in latency_handlers (such as
sched:sched_process_fork), evsel->handler will remain NULL. For every sample
of these unhandled events, this condition evaluates to true.

This repeatedly triggers evlist__find_tracepoint_by_name() and a call to
evlist__set_tracepoints_handlers(), which immediately aborts with -EEXIST.

Could this drop late-arriving tracepoints and cause a significant performan=
ce
regression on the event processing hot path?

>  	if (evsel->handler !=3D NULL) {
>  		tracepoint_handler f =3D evsel->handler;
>  		err =3D f(tool, sample, machine);
[ ... ]
> @@ -2011,14 +2020,17 @@ static int perf_sched__read_events(struct perf_sc=
hed *sched)
> =20
>  	symbol__init(perf_session__env(session));

[Severity: High]
This is a pre-existing issue, but does this early symbol__init() call break
cross-platform pipe mode?

In pipe mode, perf_env is populated during event processing. Calling
symbol__init() here accesses an uninitialized env->arch.

This causes perf_env__os_release() to fall back to the host's uname(),
permanently poisoning env->os_release and vmlinux_path__init() with host
paths.

> -	/* prefer sched_waking if it is captured */
> -	if (evlist__find_tracepoint_by_name(session->evlist, "sched:sched_wakin=
g"))
> -		handlers[2].handler =3D process_sched_wakeup_ignore;
[ ... ]

I also noticed a related pre-existing issue in perf_sched__timehist()
where timehist remains broken for pipe mode streams:

tools/perf/builtin-sched.c:perf_sched__timehist() {
[ ... ]
	/* setup per-evsel handlers */
	if (perf_session__set_tracepoints_handlers(session, handlers))
		goto out;

	/* sched_switch event at a minimum needs to exist */
	if (!evlist__find_tracepoint_by_name(session->evlist, "sched:sched_switch"=
)) {
		pr_err("No sched_switch events found. Have you run 'perf sched record'?\n=
");
		goto out;
	}
[ ... ]
}

[Severity: High]
This is a pre-existing issue, but does this strict check break the
perf sched timehist subcommand for pipe streams?

Since the evlist is unpopulated before processing pipe events,
evlist__find_tracepoint_by_name() fails immediately, causing the timehist
command to abort.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801234008.1767=
24-1-atomlin@atomlin.com?part=3D2
