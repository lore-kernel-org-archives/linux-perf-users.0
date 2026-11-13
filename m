Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590039;
	b=KhD5xTeO8kfdX/CKxDyFzFSRV66G0xbK1onv+IuOVLkLvHPOUZC7V5AdNtI3gb89RWkR
	 HT33wQ1pqkmHwQ9MBm9v/UwSu4N5vwlCzEooTNwRMtou7Odd+fJ6sa4BKZsd1c4+PJ/kO
	 VbC58Qu74dWlX8rm8dcm2GK7d4ZEwsAYGfxF3TCwmfATF7f8RrlEX4hydY57IFTKEbdZF
	 nOgGN8tWbcFoj16wRAFMcRZlHG2bKelWFoynIHk4JxqeWAa8cKz/VODTQIRqBJAwxD0VZ
	 jEraYxVaj6rcaFok2TMgrMti0zin8v0wd/twjr0pB7f4TgqwjMJqeGTLFFaASJGvbNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590039;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=n2sTuyz0kMTS80nmArmVB8PkGqAAi2sOW27fgTUQd2s=;
	b=JnFnbO8GwyWctV1kfnqzZlnOYV4zAkRKfGibXBWxWrYhgqZOPyNFP+z9HdQV8nUBO4/H
	 qe4z8h3HqdQB1gMmAHqrJIGQsJCBDTlc4OKtiCv1FkMmRKso7ms45tGvyZBLidrUMEQfz
	 FVmJPMqcFMjDDkvPOx+AFILxLNLkIM/ghIicYT9EUHR9rhPZWQ36lGmsb5wYUPylQBcv8
	 7CnnaiskayA1N6rKWeKQQSYfbiU27iQWdvCpqCw241emZKadY0L8TkehNopkHG/VlK3oA
	 9rrTlKfO0rdgxYKjt+GSWiixF1QzR8UBjQzcwnvLN7HlkxyQCPlxmHYRB7RMYvfll0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XGi8vFNZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE29606E23F
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XGi8vFNZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9230F1F000C7;
	Fri, 13 Nov 2026 17:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794590038;
	bh=n2sTuyz0kMTS80nmArmVB8PkGqAAi2sOW27fgTUQd2s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XGi8vFNZQAdDNDtew+9HCfDnup1flTQdtnqzA31wlUcPTrkWihbJ0K04uw6o5Gm+i
	 wSPEIsdKRZHuS6+hUtQwsFg9v0yrjhrMUulDzsAn6d/yXmsIlrSlWqm9YkRVhz95Sv
	 DF/2PIvEpfflUMVsZSi7dC2afhi+pkiS49sIdcjrCGf0JUZLRlR0pup+TSxR1DqFTA
	 A3X2xW7RohGIXKASmZLS9Lt4F2WCdmLhINgPobqGmNS0RMYsl195xi3MdN+uZNd9BG
	 9HnvhtI4Ewvwfi39b/ugNexLvH5l+Nitz2HtmKRijeVa9kHAEOFKmR61FTJlqtgxBq
	 3nGwj3wm3ZYpg==
Message-ID: <sashiko-outbox-213286@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 15/21] perf intel-tpebs: Fix race in tpebs_stop()
 and tpebs_cmd.out fd handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113164152.2095566-16-irogers@google.com>
References: <20261113164152.2095566-1-irogers@google.com>
 <20261113164152.2095566-16-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:13:58 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] perf intel-tpebs: race and broken error cleanup in
  evsel__tpebs_open()
--

commit a6a4e6c8987e63cad1bc76ddde1b72c0404e3b8e
Author: Ian Rogers <irogers@google.com>

perf intel-tpebs: Fix race in tpebs_stop() and tpebs_cmd.out fd handling

This commit fixes lifecycle races around the background perf record
process, sample reader thread, and control/ack file descriptors in
intel-tpebs.

> diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
> index 7c0b8b15bd10e..5cb090b27fbd7 100644
> --- a/tools/perf/util/intel-tpebs.c
> +++ b/tools/perf/util/intel-tpebs.c

[ ... ]

> @@ -567,13 +635,22 @@ int evsel__tpebs_open(struct evsel *evsel)
>  			goto out;
> =20
>  		if (pthread_create(&tpebs_reader_thread, /*attr=3D*/NULL, __sample_rea=
der,
> -				   /*arg=3D*/NULL)) {
> +				   (void *)(intptr_t)tpebs_cmd.out)) {
>  			kill(tpebs_cmd.pid, SIGTERM);
>  			pr_err("Could not create thread to process sample data.\n");
>  			ret =3D -1;
>  			goto out;
>  		}
> +		/* __sample_reader now owns and closes the output fd. */
> +		tpebs_cmd.out =3D -1;
> +		started_thread =3D true;
>  		ret =3D tpebs_send_record_cmd(EVLIST_CTL_CMD_ENABLE_TAG);
> +		if (!ret) {
> +			if (tpebs_gen !=3D open_gen)
> +				ret =3D -EBUSY;
> +			else
> +				tpebs_enabled =3D true;
> +		}
>  	}
>  out:
>  	if (ret) {
> @@ -584,11 +661,25 @@ int evsel__tpebs_open(struct evsel *evsel)
>  			tpebs_retire_lat__delete(t);
>  		}
> =20
> -		if (started_process) {
> -			if (tpebs_cmd.pid > 0) {
> -				kill(tpebs_cmd.pid, SIGTERM);
> -				finish_command(&tpebs_cmd);
> +		if (started_process && tpebs_gen =3D=3D open_gen) {
> +			pid_t actual_pid =3D tpebs_cmd.pid;

[Severity: Medium]
Can concurrent or failing calls to evsel__tpebs_open() corrupt
tpebs_results or return before events are enabled?

First, evsel__tpebs_start_perf_record() sets tpebs_cmd.pid and marks all
entries in tpebs_results with t->started =3D true before
tpebs_send_record_cmd(EVLIST_CTL_CMD_ENABLE_TAG) drops tpebs_mtx:

tools/perf/util/intel-tpebs.c:evsel__tpebs_open() {
    ...
	if (tpebs_cmd.pid !=3D 0) {
		struct tpebs_retire_lat *t;
		bool valid;

		t =3D tpebs_retire_lat__find(evsel);
		valid =3D t && t->started;
		mutex_unlock(tpebs_mtx_get());
		/* May fail as the event wasn't started. */
		return valid ? 0 : -EBUSY;
	}
    ...
}

A second caller entering evsel__tpebs_open() while ENABLE is in flight
sees tpebs_cmd.pid !=3D 0 and t->started =3D=3D true without checking
tpebs_enabled, returning 0 before events are enabled (or even if ENABLE
then fails).

Second, in the out: error path, tpebs_retire_lat__find(evsel) removes and
deletes t outside the (started_process && tpebs_gen =3D=3D open_gen) guard:

tools/perf/util/intel-tpebs.c:evsel__tpebs_open() {
    ...
	mutex_lock(tpebs_mtx_get());
	if (tpebs_stopping || tpebs_cmd.pid !=3D 0) {
		ret =3D -EBUSY;
		goto out;
	}
    ...
out:
	if (ret) {
		struct tpebs_retire_lat *t =3D tpebs_retire_lat__find(evsel);

		if (t) {
			list_del_init(&t->nd);
			tpebs_retire_lat__delete(t);
		}

		if (started_process && tpebs_gen =3D=3D open_gen) {
    ...
}

If a second thread races through evsel__tpebs_prepare() and hits
tpebs_cmd.pid !=3D 0 (or if tpebs_gen !=3D open_gen after a concurrent stop
and reopen), jumping to out: deletes the active tpebs_retire_lat entry
owned by the running session.  When that entry is the only one in
tpebs_results, a later evsel__tpebs_close() will not find it and will
never call tpebs_stop(), leaking the background perf record process,
reader thread, and pipes.

Conversely, when (started_process && tpebs_gen =3D=3D open_gen) is true on
failure, evsel__tpebs_prepare() added all retire_lat evsels on
evsel->evlist to tpebs_results, but out: only deletes the single evsel
passed to evsel__tpebs_open(), leaving the sibling entries behind with
stale started state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113164152.2095=
566-1-irogers@google.com?part=3D15
