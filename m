Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFE0424D41
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188116; cv=none; b=XR+/V5vz12NC3CXrJsxvjfX3EJKNqdCvzsI7/CDZiN6i/LwgZ97JdHSAjapqTv7F/IpTaIKsWy9P/ZWNtT5DHHb17QZJw87rwy8xrQTrG8nG42uIkD1bAcbN6kwu6kO4qlyLwPp1fjrXf9vvawTlMZWcG65T5qJj/VaPXxcIX28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188116; c=relaxed/simple;
	bh=XJ8iyWahk/7wbYl7Vj/Xg/489E97wS/WzCOjVpR7+0Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aQ/gsTZGXd0OhkFJxSJyyCD3Y22dyvWIcufagzr4MQH3wVcQFVo1KaHom3qsEJSLp/a1uq/DF/ASF0wKaosppcjpIGu+SKIOHQWE0i2qmWTS3Hl+ASJqCzqhKyd8gLmuK/vOThX6Cl8y0hNuS4UTf8kLhPPpj4CcH5O/b/5Lxyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBV49wYB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBV49wYB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D40B1F000FF;
	Wed, 23 Sep 2026 18:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790188115;
	bh=s96iNtk85v39KWBinTUSZjJsjaXnwR6FOKNdb8VDFOE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mBV49wYByjk8qzAQceKKN+up359ZxwNGCfo1tRnrWg8n8pPkW9ztzi+cRwLKrtR0d
	 KxzIxab2WygUQ7/nRDIA8HAm0X+aObPyBV/lvct9zz+UIakYYzpRUr7gAldeVK350B
	 eBmc+7Z/Ue+5uDjUw8YJf6MALf1isQHoh1pyOYy/P6352M7DaRUJMaNk/ZSEw2Qqrr
	 yaSMim9goY0iLK9bFUNRoP/czFOatB+ShWHtax1qDgykNBxidI0UdHjPCfDgYZibzL
	 WFiObdUqxdnX0d2HJwcZQEUZtjK7zAKuBaK1y4EJwY1nfiN6705v6ZYsn6rEHIyADB
	 7igySJC2uaVow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 16/49] perf python: Port stat-cpi to perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-17-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:28:34 +0000
Message-Id: <20260923182835.2D40B1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D16

