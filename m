Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD2245EF55
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 22:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792189726; cv=none; b=QiISZXEZ08w4y0iavkPvezhGchMzHeLY2a0+Sfd1etgdDixgUA7TpMfDYP4lUHrN8HilCM5ElbtdtPl7n3luD+kxPV7ToZFYeB8Eqrhw8bZc3eidj0SzGw/PnXwKqBoa8rf+mc5tVBalCBqmjFB4QoZJBER1WOHSUxiurQGBqmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792189726; c=relaxed/simple;
	bh=Pgt/ut5kWM3Wch4aUB09lewXSymvHVlxrogWV+keGxc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=EcNQ4fsQLwYwyQUDIXAf46vr5b/0Wg1xvDyTp0x+/ykCnVEIceYyBUBL+65H1j+kzXJPrKcAJVm1vi43YAc5y/F1gRbo28BI4CKZfoqFGik2G0CVyFOX8+WvBRnhgMjvgca8JBvEthAJt9Ggxj7yyWPtTLSLOm5qY6tWckjc20U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuRDubGr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuRDubGr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F90B1F000C4;
	Fri, 16 Oct 2026 22:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792189724;
	bh=g+5lLoRJmRIaUcXICwyH3aDmtWYCjSFjXouuqpWiUQg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UuRDubGr7n7TYI/Y3dQtjOECrOQjsv+rly3BydCtMBa477mnGtkEySZ93h9So6Acd
	 PwpK7qP/vgyKIYzdnrsGT9SLbHxAhPWfmrVsDGdOTVzL2dlIf5YftfwHe9oRr0ArAg
	 5qzj6N4CR4UVHveUz1y2jZYNYiUqMltqKVbnWXHwoYMZYr5Qx4VxfS0QZzX67055gS
	 eixSr55X6HOLMX4IcjWqlOUbu4xNM3bVJlOI+dwC7WuE5+mXYMsp389I5hf8McID5o
	 P0eutRyEupYxtru3AX2wKeh2K8zfrxkDYelr8lz+CuEYKIXgH4WAFZbuektTuMTvdK
	 CRKNJUPiO2GdQ==
Message-ID: <sashiko-outbox-175019@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/17] perf intel-tpebs: Fix race in tpebs_stop() and
 tpebs_cmd.out fd handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016221700.1282659-14-irogers@google.com>
References: <20261016173106.679725-1-irogers@google.com>
 <20261016221700.1282659-1-irogers@google.com>
 <20261016221700.1282659-14-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 22:28:43 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf intel-tpebs: tpebs_cmd.pid left as -1 on start_command() fa=
ilure
--

commit b2fed373fbeb105d8b92b7db69497b84b98deb1e
Author: Ian Rogers <irogers@google.com>

perf intel-tpebs: Fix race in tpebs_stop() and tpebs_cmd.out fd handling

This commit fixes a race on tpebs_reader_thread in tpebs_stop(), transfers
ownership of tpebs_cmd.out to __sample_reader() to prevent a double-close,
and updates error handling in evsel__tpebs_start_perf_record() and
evsel__tpebs_open().

> diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
> index 7c0b8b15bd10e..5954811a94dfe 100644
> --- a/tools/perf/util/intel-tpebs.c
> +++ b/tools/perf/util/intel-tpebs.c

[ ... ]

> @@ -119,6 +125,8 @@ static int evsel__tpebs_start_perf_record(struct evse=
l *evsel)
>  	tpebs_cmd.argv =3D record_argv;
>  	tpebs_cmd.out =3D -1;
>  	ret =3D start_command(&tpebs_cmd);
> +	if (ret)
> +		tpebs_cmd.out =3D -1;
>  	zfree(&tpebs_cmd.argv);
>  	list_for_each_entry(t, &tpebs_results, nd)
>  		t->started =3D true;

[Severity: Medium]
Should tpebs_cmd.pid also be reset to 0 when start_command() fails (and
should setting t->started =3D true be skipped)?

In tools/lib/subcmd/run-command.c:start_command(), when fork() fails after
pipe(fdout) succeeds, cmd->pid is left set to -1:

tools/lib/subcmd/run-command.c:start_command() {
    ...
	cmd->pid =3D fork();
	if (!cmd->pid) {
        ...
	}
	if (cmd->pid < 0) {
		int err =3D errno;
        ...
		if (need_out)
			close_pair(fdout);
		else if (cmd->out)
			close(cmd->out);
        ...
		return err =3D=3D ENOENT ?
			-ERR_RUN_COMMAND_EXEC :
			-ERR_RUN_COMMAND_FORK;
	}
}

On the error path in evsel__tpebs_open(), tpebs_cmd.pid is only cleared when
tpebs_cmd.pid > 0, leaving tpebs_cmd.pid =3D=3D -1 and any remaining entrie=
s added
by evsel__tpebs_prepare() on tpebs_results marked with t->started =3D true.

Because tpebs_stop() and the entry checks in evsel__tpebs_open() test
tpebs_cmd.pid !=3D 0, a subsequent evsel__tpebs_close() -> tpebs_stop() on =
the
remaining prepared evsels will see tpebs_cmd.pid !=3D 0 (-1) and call
pthread_join() on tpebs_reader_thread even though pthread_create() was never
called:

> @@ -331,12 +341,19 @@ static int tpebs_stop(void) __must_hold(tpebs_mtx_g=
et())
>  	/* Like tpebs_start, we should only run tpebs_end once. */
>  	if (tpebs_cmd.pid !=3D 0) {
>  		pid_t actual_pid =3D tpebs_cmd.pid;
> +		pthread_t reader_thread;
> =20
>  		tpebs_stopping =3D true;
>  		tpebs_send_record_cmd(EVLIST_CTL_CMD_STOP_TAG);
> +		/*
> +		 * tpebs_results is empty when stopping; clear pid so
> +		 * process_sample_event() ignores any late samples while
> +		 * draining the pipe.
> +		 */
>  		tpebs_cmd.pid =3D 0;
> +		reader_thread =3D tpebs_reader_thread;
>  		mutex_unlock(tpebs_mtx_get());
> -		pthread_join(tpebs_reader_thread, NULL);
> +		pthread_join(reader_thread, NULL);
>  		mutex_lock(tpebs_mtx_get());

[ ... ]

> @@ -586,9 +607,22 @@ int evsel__tpebs_open(struct evsel *evsel)
> =20
>  		if (started_process) {
>  			if (tpebs_cmd.pid > 0) {
> -				kill(tpebs_cmd.pid, SIGTERM);
> +				pid_t actual_pid =3D tpebs_cmd.pid;
> +
> +				tpebs_stopping =3D true;
> +				kill(actual_pid, SIGTERM);
> +				tpebs_cmd.pid =3D 0;
> +				if (started_thread) {
> +					pthread_t reader_thread =3D tpebs_reader_thread;
> +
> +					mutex_unlock(tpebs_mtx_get());
> +					pthread_join(reader_thread, NULL);
> +					mutex_lock(tpebs_mtx_get());
> +				}
> +				tpebs_cmd.pid =3D actual_pid;
>  				finish_command(&tpebs_cmd);
>  				tpebs_cmd.pid =3D 0;
> +				tpebs_stopping =3D false;
>  			}
>  			if (tpebs_cmd.out >=3D 0) {
>  				close(tpebs_cmd.out);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016221700.1282=
659-1-irogers@google.com?part=3D13
