Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FC73EC800
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Jul 2026 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337240; cv=none; b=DSpwMOFhxDxLDuzsPkRI1T2QgUyG0IU/AEwOZigeQxmuVK74aDrkP5gFpMaBck5P//F4zo6NsfPA/cNcpOGCiK1YZdZ//II0iqNTqxIc8Urij5WSJ3pHJ60VX8YAhD6crERH1Wd7cY50APyzmpAznnR5KVwcwIzIFNLRNqSvEbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337240; c=relaxed/simple;
	bh=1A7NrMenHf8TiJJ1Ha33KEkcn5+cFSL53awpbaRj3FI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z07wLK/HRRKkXdDNSUQzWyi+clj/M/qPZAC0ua+40Wbpu2SzsDpP4FMcUAvDgjf9q/ssnjj1accPdoaMr8fx8mPLpy8URjIPFdzv2cKm+/MclDVMSpxV5u3zCBbqsuVWMMXYUo1ARGTPSzc7aHAM7NBAUYZGPdgOeyNWwdnXU6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGHA7hPr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGHA7hPr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1941F000E9;
	Wed, 29 Jul 2026 15:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785337239;
	bh=oENj4r6HVvjxJGubbnxaMtXLVsArFoJ54ooeKUPMxOQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FGHA7hPrObBn5WgOkvubCu4GVxhgQ3kPXd73jQzZNI5aFYnO4gCQfxCLd5HdnRkpi
	 CUFuuLNS92+hGbpCpBJX6AAeLtnEcy4/MVy8UxJFrBcCkw+8E2HM4tSg8Cyp0GLwGl
	 ex1+fmRAgtsUdi3STQr6eCWxiUs7SKd6mYzUvmx98Zg/XN78xorOp9L2v4aBy3Wg2k
	 5CrGldYDyGDTS2ern7dc3wHhMWC8mmthglUHHHlfqTXYRux3LZ7KkHvM3184J7Lfq6
	 LcAUCbpX6M+hlhUZ+b0XHTCm0EDfZOFRIbRPaRZi+PMyDj/ZrQAMk0PQSqq+wP6XlB
	 yhvYwpUC9Io0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] perf sched: Suppress latency table output when
 trace samples are missing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260729144451.38286-2-atomlin@atomlin.com>
References: <20260729144451.38286-1-atomlin@atomlin.com>
 <20260729144451.38286-2-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 15:00:38 +0000
Message-Id: <20260729150039.4C1941F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Tracepoint handlers are not set for events read from a pipe, cau=
sing all trace samples to be silently dropped.
- [Medium] The patch adds dynamic callbacks for pipe mode but omits the `.f=
eature` callback, leaving `perf_env` unpopulated.
--

--- Patch [1]: [PATCH v4 1/3] perf sched: Suppress latency table output whe=
n trace samples are missing ---
commit e9be5c25be0368a795779cd7fdb10479f3b3c099
Author: Aaron Tomlin <atomlin@atomlin.com>

perf sched: Suppress latency table output when trace samples are missing

This commit updates perf_sched__read_events() to abort early and return an
error when trace samples are missing. It also adds callbacks in cmd_sched()
to support pipe mode streams and adds a null check in map_switch_event().

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 7fd63a9db4574..fabd99a18aad4 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c

[ ... ]

> @@ -2001,7 +2001,7 @@ static int perf_sched__read_events(struct perf_sche=
d *sched)
>  		.mode  =3D PERF_DATA_MODE_READ,
>  		.force =3D sched->force,
>  	};
> -	int rc =3D -1;
> +	int rc =3D -1, err;
> =20
>  	session =3D perf_session__new(&data, &sched->tool);
>  	if (IS_ERR(session)) {
> @@ -2018,18 +2018,25 @@ static int perf_sched__read_events(struct perf_sc=
hed *sched)
>  	if (perf_session__set_tracepoints_handlers(session, handlers))
>  		goto out_delete;

[Severity: Medium]
Does setting the tracepoint handlers before processing events work for
pipe mode?

Since the evlist is empty in pipe mode until events are processed, it appea=
rs
perf_session__set_tracepoints_handlers() won't set up the handlers.

When samples later arrive in perf_sched__process_tracepoint_sample():

    if (evsel->handler !=3D NULL) {
        tracepoint_handler f =3D evsel->handler;
        err =3D f(tool, sample, machine);
    }

Will they be silently dropped because evsel->handler is NULL?

> -	if (perf_session__has_traces(session, "record -R")) {
> -		int err =3D perf_session__process_events(session);
> -		if (err) {
> -			pr_err("Failed to process events, error %d", err);
> -			goto out_delete;
> -		}
> +	if (!perf_data__is_pipe(session->data) &&
> +	    !perf_session__has_traces(session, "record -R"))
> +		goto out_delete;
> =20
> -		sched->nr_events      =3D session->evlist->stats.nr_events[0];
> -		sched->nr_lost_events =3D session->evlist->stats.total_lost;
> -		sched->nr_lost_chunks =3D session->evlist->stats.nr_events[PERF_RECORD=
_LOST];
> +	err =3D perf_session__process_events(session);

[ ... ]

> @@ -5167,6 +5174,9 @@ int cmd_sched(int argc, const char **argv)
>  	sched.tool.namespaces	 =3D perf_event__process_namespaces;
>  	sched.tool.lost		 =3D perf_event__process_lost;
>  	sched.tool.fork		 =3D perf_sched__process_fork_event;
> +	sched.tool.attr		 =3D perf_event__process_attr;
> +	sched.tool.tracing_data	 =3D perf_event__process_tracing_data;
> +	sched.tool.build_id	 =3D perf_event__process_build_id;

[Severity: Medium]
Does this code omit the feature callback required for pipe mode?

Without registering perf_event__process_feature to tool.feature, it seems
feature events from the pipe stream will be silently dropped, leaving
struct perf_env unpopulated.

> =20
>  	argc =3D parse_options_subcommand(argc, argv, sched_options, sched_subc=
ommands,
>  					sched_usage, PARSE_OPT_STOP_AT_NON_OPTION);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729144451.3828=
6-1-atomlin@atomlin.com?part=3D1
