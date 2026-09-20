Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF4E345ED9
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882496; cv=none; b=OBgiUEIU0zarYQGIz209VXLUG++icrgZr3dFC0cKT9Rq/CnlIEkZ7MU1CXIqI5PdIccoIIQbfBdoagS6/sj3eKOWAdaZ6sUAwcIfaDZbm8u2yjWczrLkxvQQPh0IFh9cYuHyPaSSb3CqbE44KTt2l1z8hDos9H0eWtm7Acp0KFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882496; c=relaxed/simple;
	bh=LbQmc2wJDWNSznqPpO5GdUI4Cbj0ExYZGRxNEGf1Zuw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fKrehwn1Sf8WHJbKxvC/nf/dXpJtkR2ipD/uayu8Km8dAWd/keDKXe6EbfdBDiSYya6ptMgo1BLNwt8V6qOlB3pQgzEI7FYGOdIrcECz/LkL4Jhw1ztbdZFqhcf73osSdjIAK/PZUBCWau5NvMxHPELudDU1EZXmUHnoELbLumc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=In1/Im3q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="In1/Im3q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822BF1F000FF;
	Sun, 20 Sep 2026 05:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882495;
	bh=hUJS91nIkNpb549IdGAsawrGjIRP2xgRFaLOzDW/XO8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=In1/Im3qDy5ShXdBWPJlIrqGOYb7PDRUFty3f0Dm441b4iPzopVCl8+LsyyEi5FuO
	 7/P5moCfFDU5rNIu6F2gh/UaGW8yM7/x+i51ynsmiDuGUBko/F9kR2hufoT3akgAG/
	 qk3lZwCVQB3Em4yCAzdLsV735aaq5sl5pGn80D52GoTA0mCJVA+eclh5x3eWazB+7N
	 o6Ql3xRP3K5B4IUAs5eeBuZCxwyOS7zShu2+zgOMdP9SFaCu5wEpc+295dDPnoKqZx
	 grydOtV2RMND5A0gbSYfBCV+e9q3E58NnbSSqpZZOUNWjPfGaXOP4mFgKHlLuOZzWj
	 h5ewM8VIvJakw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 16/49] perf python: Port stat-cpi to perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <95294f05467e0c96f2dc4ea605f1c3ab1a2e3f71.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <95294f05467e0c96f2dc4ea605f1c3ab1a2e3f71.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:34:55 +0000
Message-Id: <20260920053455.822BF1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D16

