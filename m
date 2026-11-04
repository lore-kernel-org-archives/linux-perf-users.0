Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793765790;
	b=gFtSGA01Pq79Fo1e98qNCm8FrZJoksNEEsCc+9HAJ+GuCPyO/dk6dKYBwLv01LawkXWR
	 QefDI8cTpzYLMBo0mQspAHBCWjE9AMdTWwwdFVzXKAVcoSQKeYLH8aYt7PMu++tueLbDe
	 bUFHSYzGw5wkctF+5UK5v6j/hOx79YO3RlXWKzP1rrnMPKYwpuj7DAVySU0rKF85hiLrY
	 7eXrvL/xxOYOlaMUfLgGjo0irCTrsC08l9iyvUYC5GeLr4mFbhGDz8I8zMUG6Whc3n2tA
	 KgCslcIwNhoKB4KjjteITEqJ6YlOtKYer9HJGFgs7SSGForWsIy9aUxW9qiRlzd3EwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793765790;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=e1DNbtA+mB/S1XR0r0u+kEZvz3av14mpckgUIMJNaEU=;
	b=DC077p0mAYrO/8m79ORuFm0k386SEwfyMSax1Ki/KbG+zSrZzqDSaS2thIrGP2URbcoq
	 a7cfNgWwjyKI2mCIDXPilDxlgllNINCpkYkEk2fyawe7Afi9NDT+n8Bvjne+xfuIPhhpl
	 dSkpORyrhynSuNo8bqApR9QeEqbogkJhDCBW0y3PabLbi8bIQMNfJmPM7RuFkLc07b787
	 OvGvtEofqr90AusThiD4zCaHF/I0AMup3YfBXkbDvMyxOkH2I6VtSineyczfu2rQxCqHU
	 DAHtmn2dWa0a6VR9RCUuzKt0u1V0BkjG9hh46poOENXuHmGb9Y/XTb+P3mQSj3/GFKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QR6Bshkj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877E0606A32E
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 04:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QR6Bshkj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001781F000C1;
	Wed,  4 Nov 2026 04:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793765790;
	bh=e1DNbtA+mB/S1XR0r0u+kEZvz3av14mpckgUIMJNaEU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=QR6BshkjpuxLELiq5LDjWzTnBU5usxvEXZtYW3H9CWAN+Q5MlzAfK4GTRdg16IjIW
	 UPBKZ1nrnTnxhEGMBO9pQGOAyGrhSiU/e4cc+Uqg4F3yxqGYTrfP2CiiaPIPocFx14
	 TSidfAlwfIr5bFJKARr6uE3kQfIttVG617Wf+mv+oFIBzhORxm08w0Z7Q7Yr6OLB94
	 1b/mC9t2d0oSHh8VZDIg5sOg+W+M9pZSqdUQXGRPgGsHI7vJLhQwgOFedjR8+4+KhW
	 0GIk+ttXRvl6+qVH2egPiX0cWMhndXzQ4yD60D2kSuG80nHxAI80iml9S0ypcWHKeN
	 nQDXDYEaccQxw==
Message-ID: <sashiko-outbox-196647@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 21/41] perf script: Fix metrics computed from samples
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103234502.1008382-22-irogers@google.com>
References: <20261103234502.1008382-1-irogers@google.com>
 <20261103234502.1008382-22-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 04:16:29 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> perf script -F metric computes metrics from the sum of sample periods of
> the events, but the computed values were wrong and the output was
> garbled:
>=20
>  - perf_stat_process_counter() replaces each count with its delta from
>    the previous raw count. As counts were left as deltas, the next sample
>    computed negative deltas for the counts of all CPUs and threads other
>    than the sample's. Restore the counts to the running totals after
>    processing.
>=20
>  - Metrics for all events were displayed after every sample. Only display
>    the metrics associated with the sampled event.
>=20
>  - The new_line callback started a metric line that the next metric
>    started again. Each metric starts its own line, so make it a no-op.
> [ ... ]
> of the sample periods of all CPUs.
>=20
> Fixes: 4bd1bef8bba2 ("perf script: Allow computing 'perf stat' style metr=
ics")
> Fixes: 3622990efaab ("perf script: Change metric format to use json metri=
cs")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234502.1008=
382-1-irogers@google.com?part=3D21

