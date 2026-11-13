Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794613521;
	b=b7yAlFCP3tMzLQZZKu1W9oivVi6t9aIpVASzrTSW63fSVMGsVWWstyUjS14Mn33moCZE
	 BUvidOlaIhKyQyAkW+/HwAuQmtDeE9iXncaNrWNdNMZ7Qr/7jlq+G6uJ6QcIrxyjNlZFN
	 Qa2EmAhlrC6YrYp4KphMsd09sG0qFDHG9yvQDLQPLDelC+xKXTUpzz9DDKK2/T32zUFc1
	 r1QVs9j4gDknSIEMaubzO4Mkv7wEq8CPnIhyp1WWoC2TNJIhX/kPCDpMoWDvuzq/1joWh
	 pZbfIoUwp+hHG1MuG9shsrfAhJ5N/BRWoKtAsVuus8wEEMrzaZuPkZ2ivbZlE1ohDpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794613521;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nXIa2LIBoJObDY1on2+z1jcZ+AppL6UIDEBEAAoNlhc=;
	b=CKkX9sHSqSTn/gvWOaDAZj9zDJvMT/iD7zjgGuIcxsWnp+t/Ys2uSZ6sMgPlYM+37dQ5
	 CmNrzW8AZw1e1mVZMKunaPt/0NI9VSrfSsGdzHyNrYVgoKF4D00GL1t81mvSAtYisEl4d
	 Zqa6DdRdJdfHi48kPQSMeIzhphqxF+nenwOEvMOz8udNfdDXZ4JcMqBnfC4gBpzislgtg
	 s+jOI7fqqtxBwgFnALCPALGjct/WaWCvFtks2tbKasZpNbgZuDZ/VLiU5nfavOAsKnfRE
	 Gi9EzeUN6j/0mDkzyw/oEGHHzbdw5lJ7cDY8s6v2yeYfrYTu1y9uAGTTqcRg79n/89g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UO6nNrb1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BD7606A333
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 23:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UO6nNrb1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1B51F000C5;
	Fri, 13 Nov 2026 23:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794613520;
	bh=nXIa2LIBoJObDY1on2+z1jcZ+AppL6UIDEBEAAoNlhc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=UO6nNrb1RcDlX4z6SxUoQt7lTtJE2s1BIA2O2CDM3TGw0pSvoAjkC4rpgst+SPVhO
	 LQhjis912dhXl1bhTWlJqDWwryuUiQJcmUsWX8nWlVPbeFnZsqLeE6W9gYtZmNnvoV
	 HJGK9/Q22Jyfidn1289peMObR5Cw4xbca8CB5/UpZ0U1Hwlwe0QTUrOodU+TSeas78
	 QpabscZ/5LLd3tjXhK4tumjJjln8FKOPHPCRYrynDvc3WOMkMvfkQmzCp1ruJq6j2i
	 taZLUQfPqkAZX9Ev6LCqfhEvVntRSIqO0B+VcuElV6Di0V67IbNfvDCAro+1PNbNeo
	 Yz+z8DtrJ1Qxw==
Message-ID: <sashiko-outbox-213872@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] perf test tool_pmu: Add memory, network and
 schedstat tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261113233739.3626499-5-irogers@google.com>
References: <20261113233739.3626499-1-irogers@google.com>
 <20261113233739.3626499-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 23:45:20 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Extend the Tool PMU unit test suite with subtests covering:
> - Per-process, multi-threaded Tgid deduplication, and system-wide reading
>   of memory events (smaps_rollup and statm).
> - Per-process open rejection (-EINVAL) and synthetic /proc/net/dev
>   parsing (including space-padded and unpadded columns) across
>   enable/disable transitions for network events.
> - Per-process open rejection (-EINVAL) and per-CPU synthetic
>   /proc/schedstat delta accumulation across enable/disable transitions
>   for schedstat events.
> - Mixed CPU-map tool groups ({schedstat_yield,net_rx_bytes} and
>   {net_rx_bytes,schedstat_yield}) across evlist__enable() and
>   evlist__disable().
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113233739.3626=
499-1-irogers@google.com?part=3D4

