Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4634A35C6AA
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789969238; cv=none; b=beTyM4oKF0F+QWuEhr91kUionRscaEvVORaZ/jZtydZDrX06ekNI5YJWC7B6J0IllClUydtsCfUaoMd2ymJImg6UCHSDmTnQ02Ip5/IUMReOD2Nv9njjg6yNaIvUodI3W79Ubgd46Xu28zDeJwQzdVbqRFV7XQlWdX18eerkfMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789969238; c=relaxed/simple;
	bh=Qw9LMFtjTJRcBc2OOW2aCiRgTiaoFeDPGJsGmrx8jio=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nUAul12RWQ+qD1eDdJ6TQSq4KvnExtGX9Lcd8UICvhXL6CLTtI+uLaODtsUw/CvovRYYXaCHcxrnkd+kxXT2GJqHwRr/KqxXjIw+K1ppDo6LEnFtS+np8PvZt45yBsQd8Z64HbopefD+sSfutHREN8d9k5zSrNLZWGeyP/wtnJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKBgB4yK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKBgB4yK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7711F00898;
	Mon, 21 Sep 2026 05:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789969237;
	bh=ucBy/XobQFTpRotDp9dOVN94xTJujT8SLN7BYcHsieA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SKBgB4yKP/JaReMV69cGxH92AVbpZwm0MZxtniHjglTXr+lpo7EDnG7jqSv5Ewd5d
	 JbLC6V2oAvI1PhVabRNG7yaPtQ1AkgRyUtdvNWUQyKijwukUdBtxwGpCvDQaXDKRoI
	 Nw+WmQWuLGvlVY+q7OP+rS2XmPsqrMyzrSQRFeOBzRjFRZU4UuRk26Gb/7nZKvB4hf
	 AC7Hf2y+Hiv7ftNDeWUuwgGHBiNK8YlggeRwFcAz4txPahsUFBPQfmudyGUbOV4bTJ
	 V8/gBTJTwfsRwNYyVODy4cE5/zQNOiOqTcM2BLwL73X/ZiCWeolw7jynpD2ybgXoF+
	 F3dnZ/W4Ku9Xw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 16/49] perf python: Port stat-cpi to perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <4863f0e45258e4a82e69b2cbffba68a7189289f0.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <4863f0e45258e4a82e69b2cbffba68a7189289f0.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:40:36 +0000
Message-Id: <20260921054036.EE7711F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port stat-cpi.py from the legacy embedded scripting framework to a
> standalone Python script in tools/perf/python/ to calculate Cycles Per
> Instruction (CPI) per interval per CPU or thread.
>=20
> Improvements compared to the legacy script:
> - Support both perf.data file mode (via perf.session stat callbacks)
>   and live counter collection mode (using perf.parse_events,
>   evlist.open, and evsel.read across intervals), with automatic fallback
>   to user-space (:u) and self-process monitoring when perf_event_paranoid
>   restricts system-wide events (EACCES).
> - Compute per-interval counter deltas (val, ena, run) keyed by raw event
>   name so cumulative PERF_RECORD_STAT snapshots and hybrid PMU events
>   (e.g. cpu_core/cycles/, cpu_atom/cycles/) are accumulated accurately,
>   and scale counts by time_enabled / time_running when multiplexed.
> - Replace hard-coded CPU ([0, 1]) and thread ([0]) arrays with dynamic
>   CPU and thread discovery so arbitrary system topologies work
>   automatically.
> - Add CLI option handling (-i, -I, -p) via argparse and type annotations
>   passing mypy and pylint.
>=20
> Add a shell test (test_stat_cpi_python.sh) to verify the standalone
> script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D16

