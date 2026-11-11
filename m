Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429800;
	b=ED1TaEFi11X49egYxm3pIlonEYkYP45qG24igF64EaH4tNDXg3eydI4z218NCT71EvX5
	 1aCMEqnQziVpppBVESjMlA/xZeNSNVT/vN0j5NMSdg5WDQ3nPvQ8+xVcWybpZzIouYnme
	 DRwniEmThrNjSrcF0BgjcbNFDIc4ftTdsoNymjpLMs2GIrzPMJruPYK4GjrxZWlJPGgSM
	 o/rFHXOJn2MQ3b6XqcdTWHs6T86gUdOVWMP/8A06il5biHbLUnKz6PfjPYZCWsKgnBSa5
	 Q2xyPrbFrwhmqckgdSxHWSJSm8n1LW7RRxPYfgM1VDUNCtucJI6lAgJPbexYxGScTYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429800;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bDzJd3eQYDlD/yJY/wVTosMEIAjytSJsGer2qHzzqSY=;
	b=rSaXfJKtM3+a2RhK85nV1Eew5B9zzQARp0+qe37RwMBrqiMTB8jQw73AxcBUIM5Oe/7j
	 ucL12y5iGr4O+QahcOpbcHXAMwpj1UoFWMqLeoh6LEr0iu7qcPG9X/guCfxtAPzAFMWO3
	 9Uwd1lcuPm1htQUoCwCYVIunv8PxONcywvXrsV3rkj6NFWS0Zt1Fph6EXAL05BKBmfRc5
	 IrISfIftHWMl5XiQPXnEz8jmreaZ0Nc3jLuqc9ob3laQgchj/rMmtgd+VU/zdP4icBI4v
	 /fHzvfiokewE4X907urwqgECXeFmY1btUm/NW7CgA1V9NSuY433nFzlg7GqSY0B/oXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ImO6XjiH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852A8606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 20:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ImO6XjiH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4186F1F00A05;
	Wed, 11 Nov 2026 20:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794429800;
	bh=bDzJd3eQYDlD/yJY/wVTosMEIAjytSJsGer2qHzzqSY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ImO6XjiHsp5m2+jljz6omL04qqtAR+Z1R4lUEO6WmlyAqGS/i2tCQy8nHJHvdiRDE
	 6bfOcCN2jgJ6CwaFN1OT4kwFOdC4EGEe1f3ZUO5qaOlRu927q3fuSbZCejZ/wW1dB0
	 6w0EKV/wZqAMxAMXqx5oPEnqX6VTaAEncukNUuo8Vus/y4vzDH2dNTkPBX0ckP2tsf
	 t5zTvuN9TsUmVNPkVSXvaAyzt93vMUu4BwbZXgGM3ym0edCIxKKGjCMDZs/mbr8Vov
	 X1RF2cyQ6QhfWUUJAZnXsEhKrNpmQcnTiJO+Inu/dvE68sG+4Ua95erf327LMegG4V
	 O7X5EVGA6vppg==
Message-ID: <sashiko-outbox-209672@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 15/20] perf intel-tpebs: Fix race in tpebs_stop()
 and tpebs_cmd.out fd handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261111174213.3526604-16-irogers@google.com>
References: <20261111174213.3526604-1-irogers@google.com>
 <20261111174213.3526604-16-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 20:43:19 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> In tpebs_stop(), read tpebs_reader_thread into a local variable before
> releasing tpebs_mtx to call pthread_join().
>=20
> Transfer ownership of tpebs_cmd.out to __sample_reader() by passing it
> as the thread argument and setting tpebs_cmd.out =3D -1 in
> evsel__tpebs_open() so tpebs_stop() does not double-close the fd closed
> by perf_session__delete(). Also reset tpebs_cmd.pid =3D 0 and
> tpebs_cmd.out =3D -1 and return early if start_command() fails in
> evsel__tpebs_start_perf_record(), as start_command() closes the pipe
> internally and may leave cmd->pid =3D -1 on error.
>=20
> Serialize tpebs_send_record_cmd() with teardown via tpebs_cmd_in_flight
> and tpebs_cmd_cond, newline-terminate control commands so consecutive
> writes cannot coalesce in evlist__ctlfd_recv(), check
> check_if_command_finished(&tpebs_cmd) under tpebs_mtx only when not
> stopping, ignore late samples in process_sample_event() once
> tpebs_stopping is set, and guard evsel__tpebs_open() against a
> concurrent tpebs_stop() with tpebs_gen, tpebs_enabled, and
> tpebs_stopping across closing the fds and finish_command().
>=20
> Include <pthread.h>, <signal.h>, <stdint.h>, <stdlib.h>, <string.h>, and
> <unistd.h> explicitly.
>=20
> Fixes: 8db5cabcf1b6 ("perf stat: Fork and launch 'perf record' when 'perf=
 stat' needs to get retire latency value for a metric.")
> Fixes: bded0398ac19 ("perf tpebs: Fix concurrent stop races and PID reuse=
 hazards in tpebs_stop")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111174213.3526=
604-1-irogers@google.com?part=3D15

