Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793767170;
	b=UC+UdNmbH2+PV9n9wTDaOL1ZrUfLaozPdCXQyp5d01QVZxJkx9doL+VHiXxcpNUFAzQ2
	 sliMAxKhuMbsqKi20eCNk4alwwJHkpq5Y/lISRg9/9nnCwhOktjSmCkZojjBKSiyJVyD5
	 q3sBmWf7gF4oOOQwJ5Z1xbcrSUhG61TKGa3YyydVTnpGs8FnPliHxkFT827dxU5MtNPTB
	 Jndq/t0I5IIacFmbWdfkr/orkkcW72KQZ89cIpMEDtZrsIj1raNO3A5O71n0YEVIVlSZ7
	 EKVHoqkrMV8FVuI+X5rovFE7ceHqBWFYqOwePIht4DR2T3wzpywVFds2qK2MpQJ/eBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793767170;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vKgJQ4r4//kqu8YoC3R4+CYmrnkwcHLl2lesv6/XaKQ=;
	b=3LSamLz0QkRUPsnobvDj85b1MojLHkjBGmA5c+Us9qUjcIHCC06PMpw6wf7Ig6Q6LOg1
	 +KrgGFLUa/ppxfXugtAs+J5LhbhiboKQAWjm5xyaIs0aP88LKSKMwsqQjpK28RZyqAtSx
	 m+4WxXcrL0D11Lr0FqdS7kQDyGInA+jXSgm/ahJsY2jgPI+hAH9TDOFPSLuOfLpE4hrVn
	 1NVGF+xzZnQwEyoO39mZDCn8uWVvq7qaPzP0UppmfxmhiGoBnqmilTH310IFQZ2OhtKdS
	 mLVFGVMkDL48NxydBo1XOSOtKut6pD+n5JX32GgEwNXmlZbMErcgbtTf2sNOJwkZsiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DVvc591C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF9B606A31B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 04:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DVvc591C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8CE51F000C1;
	Wed,  4 Nov 2026 04:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793767170;
	bh=vKgJQ4r4//kqu8YoC3R4+CYmrnkwcHLl2lesv6/XaKQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=DVvc591CU5OY7EzNUi53EexfRirdhd+SuKvZnF6yAjyqj2Pl9IgXr3KAOtUAv/GQ2
	 ZzCSAS9153GsVQQa0pkHbsGOKVE4p3Fe7I4Qu7oUY9Lbnr+q15lenWAbZBdJVZnYtU
	 QNyOobYoxnY+PfBKkgG5CkN1BYF6900p8qnhOcswv/3s5XbmqM45KW5NUsHySUwOBX
	 9/R4yRPW69nlWtziml8M45wYm6NzSbAhwuh3BtK7qzABPM4TVUDbv2+oIzjjqAc2eY
	 xOsbQXlQ1D14BoXnRzhjuAOB5deQetcTmdXVCGQWukELhmJcEDn+/8KBii7jS46Lco
	 14H9QG9BChMrA==
Message-ID: <sashiko-outbox-196659@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 23/41] perf stat report: Display metrics for recorded
 events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103234502.1008382-24-irogers@google.com>
References: <20261103234502.1008382-1-irogers@google.com>
 <20261103234502.1008382-24-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 04:39:29 +0000
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
- [Medium] perf stat: out-of-bounds read in process_stat_round_event() on e=
mpty thread map
--

commit 999492ed47788b25c2fe1aa298ea5dde850df501
Author: Ian Rogers <irogers@google.com>

perf stat report: Display metrics for recorded events

This commit updates perf stat report to display metrics for recorded events
by inspecting the recorded command line in struct perf_env and adding
support for --all-metrics, -M/--metrics, and --metric-only.

> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index f81192cec4813..12004244af0e9 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2232,6 +2232,28 @@ static int process_stat_round_event(const struct p=
erf_tool *tool __maybe_unused,
>  	struct perf_env *env =3D perf_session__env(session);
>  	const char **argv =3D env->cmdline_argv;
>  	int argc =3D env->nr_cmdline;
> +	static bool metrics_added;
> +
> +	if (!metrics_added) {
> +		struct perf_thread_map *threads =3D evlist__core(session->evlist)->thr=
eads;
> +		bool system_wide =3D !threads || perf_thread_map__pid(threads, /*idx=
=3D*/0) =3D=3D -1;

[Severity: Medium]
Can perf_thread_map__pid(threads, 0) read out of bounds on map->map[0].pid =
if
a crafted or corrupted perf.data file contains a PERF_RECORD_THREAD_MAP eve=
nt
with nr =3D=3D 0?

When perf_session__process_user_event() validates PERF_RECORD_THREAD_MAP, it
permits event->thread_map.nr =3D=3D 0:

tools/perf/builtin-stat.c:process_thread_map_event()
  -> thread_map__new_event()
     -> perf_thread_map__realloc(NULL, 0)

This allocates a non-NULL struct perf_thread_map with threads->nr =3D=3D 0 =
and
zero elements in its trailing flexible array map[], which set_maps() attach=
es
to evlist__core(evsel_list)->threads.

When process_stat_round_event() subsequently runs, threads is non-NULL, so
perf_thread_map__pid(threads, 0) in tools/lib/perf/threadmap.c dereferences
map->map[0].pid past the end of the allocation.

Should this also check perf_thread_map__nr(threads) =3D=3D 0 (or
perf_thread_map__Empty(threads)) before calling perf_thread_map__pid()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234502.1008=
382-1-irogers@google.com?part=3D23
