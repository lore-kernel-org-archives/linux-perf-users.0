Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600142;
	b=b+ipKfRZYNZNZ5aIb35ALb5aFM1BPNq3LImQfos9u3npYFNa1UjYtrTw5EbU6rfCZQwE
	 K7zBLXom4UJKTJ0O7fdgjyQ6aO7lzA2rB1VsWgAWmljzwUoKaGVu7gBm5BEhIxqOvuIkx
	 HrR2PYpWXTkl/u4v8S+r9d7kegWZ9QU1PIi+u0O7Q/YHS9zyCQUDs+GaQzwwviZTSAxH6
	 XpYhwpULmgEydRTllsF1hxRWZyvHxm5Q001/FBbb00bGENk8mrx1jW/7aMV+kwmPVCbhZ
	 trQSKSat2hO2N9HbuKzi1B1tCEaoy8gR6kEpjyZr9iCJyZcxCoiQcrBffdHxJiqEjAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600142;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=K2gWWzI3fTu3RZENP6QzB4CXr2fkYQmKsWBOtj4a+Xw=;
	b=LB6lHWEKyHOqEjhBgpWVzv/hhiL+wR5t+70Nwdiw6GH+Ivo5/682M+2MOJoKJn9t4vc+
	 bnrLx8PY3ehn8lbbYVq0oe9Lk9RbN4g0xkJ2QIaRSw8jvelyLQFa3WCd1Pe4HeegqPcRQ
	 2MIWXMG2WbKeJd8BWM3URPyiAi6QZvjDD7rna/mO3Xg1OII1nn8esO5EcT51D9sn3UpFh
	 SNmSdEmjV+5Jo+sRA//UH163639zWwed+SsjqnuDdB2FkgOwlc0zq7Zy+Hrmz4jsU89F0
	 D0rFo0zrl+tpSmsJFaOb8zetmfXtB8dOSdBclKVw8gNraFck0Pl9ErUz2B/Jx7etoWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QkRsnV7r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DB0606A881
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 20:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QkRsnV7r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B291F000C5;
	Fri, 13 Nov 2026 20:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794600142;
	bh=K2gWWzI3fTu3RZENP6QzB4CXr2fkYQmKsWBOtj4a+Xw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QkRsnV7rzlDEEjQNxk51F2eNDsztxlmU/y+q01CK9+bfbHw6Hg74R6IJpATsw7oC/
	 czzRE+ngO+dmAcyzIEXcYSJAov99uN3i243E2nlIL3AbCOQyaAjqGrDjuxwZppT8Ox
	 lmZFhD53+cH05nZIN5Qop+IPuUCh0Th8Bc5Y+/e/GaiZwKwzQVWFvYzqCZyo0x0xr0
	 yHOXo3MLxULfsFIwf3HHRlx3SA1WHEqCGP2ZiPw9aW07inN6deErJk4fNjQDLD95HC
	 +ZONQE5pTKLmSoc8In410FwMD/FhWOCSdmfdEnEAsuY4ruO+ZYa8DypNEI3PGpnyPB
	 fZw1wnUd2OUSA==
Message-ID: <sashiko-outbox-213603@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/30] perf script: Don't drop metric samples for
 CPUs missing from the evsel
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113195335.2865725-4-irogers@google.com>
References: <20261113195335.2865725-1-irogers@google.com>
 <20261113195335.2865725-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:02:22 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> perf script -F metric looks up the index of the sample's CPU in the
> evsel's CPU map and, when it isn't present, prints "Missing CPU map
> entry for CPU <n>" and ignores the sample. When the perf.data file
> doesn't record the CPUs of an event, as is the case for perf record,
> __perf_evlist__propagate_maps() sets the evsel's CPUs to the host's
> online CPUs. If a CPU is offline when perf script is run, or the
> perf.data file was recorded on a machine with more CPUs, then every
> sample on such a CPU is dropped from the metrics with a message, for
> example thousands of:
>=20
>   Missing CPU map entry for CPU 1
>=20
> perf script currently only supports global aggregation of the counts
> used for metrics, the counts of all CPUs are summed. So place the counts
> of a sample whose CPU isn't in the evsel's CPU map in the first CPU of
> the map, as was already done for samples without a CPU. This doesn't
> change the metric values computed for samples of the CPUs in the map,
> the summed counts just include the previously dropped samples, and so
> isn't a regression. Aggregating per CPU, and using the CPUs of the
> perf.data file's environment rather than the host's, would be future
> improvements.
>=20
> Fixes: 3622990efaab ("perf script: Change metric format to use json metri=
cs")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113195335.2865=
725-1-irogers@google.com?part=3D3

