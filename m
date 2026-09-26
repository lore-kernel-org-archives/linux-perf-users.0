Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79E235A387
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404304; cv=none; b=L03h1X+zeu4NrHOgDXfqETvlDGAnmnuEjmCLtBVCK5o8uJv8Uz5QIbdAVkmaI2FUWv/sT32T7BSd9nEdSKTbiXoKO27o/KbEcbBsUYd52/72H8MxuSVxdHjYujgD3dnjv4wg7YKaJED75Rc+MiLRLzvJdMAPyhIZ3aPBdfioS6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404304; c=relaxed/simple;
	bh=MVWtCL4yWCLFW8NFAxVbnhUGfihf3IG+0BvtwE6e4MM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=umajJ/rx+fWqkyIHeLXlGKcVRBqHv4YYDGOq+PM938Gr7st3eg9uA4rkMLia6k8CqMXa/gKVHMTGmAfdryrd8FbnVeFtMU6Q1ST1uhaRHNnwDm9BJRUyqiRqXtMgicxj+e+OzZsJW6YYOqAIgtMaQHAW4ttdB8d79M39DglT9og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHCJqUWn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHCJqUWn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247741F000FF;
	Sat, 26 Sep 2026 06:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404303;
	bh=U1tlFLoszBu+ZEKFbmqosu3nAFS6UAdvYAgOs8RKbnA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RHCJqUWnv7PQIq9iLOUb4fbLXZWCdpuGGj9grud5ollleaA1uaDvUwkj+/BTMZYZF
	 33Ka/okmrqSLmEl07k1SixMPIuBOs7o4ia+E28JNaejyGVdfxLywTfHNh3CalHEafk
	 n3JEb00CHPDxeq9krHS+6+D+lRgYXPKQnHcFsiTaQy+CIOSziU4VyiKCqjESlyfDkF
	 lIHLZBaaYWkc86n7jn4x1JFzE/5yjKn0Fqc6T0i+8Vewo0svBYIhvMCtG3T+K0uyex
	 +198MUJ2xCxDkQNVSbGhV+Q1Oi3JGmr7Ualm8aHAmPQ25ev28d3DM7zbOqWwNJzjBZ
	 hOWlgXtBIUdhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 16/49] perf python: Port stat-cpi to perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-17-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:31:42 +0000
Message-Id: <20260926063143.247741F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D16

