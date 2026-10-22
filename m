Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792701333;
	b=odQ2yO3wp4wdHf8+FWtTdk4crD3FluPePirfom9dZd9l32jJ+3kU7AUKq+yU/JHt/xFG
	 DWlZMwb762ywKUxZmmGh4T8P27VfkJD0mTQbq7vreJGhKqzXhKtt/0SsZba2G8zYTfNvv
	 nX0zQjR9IwXTUty8cwR5KzQoeyiRyArVIrrZJOzRieN8N/MW9Qe7Xj7Ldshfu+pglkoqx
	 8CwH4GAXJTOMgeUmQdDli+KJa6P+UXw4wsSabYAv0yRCgFfIjMWwnt16xFsTwU+Y989X2
	 SkULttG6oNmfmpaCagx4/sTkiuXAZIQeTw7wzfyUA1VoogiUxHzQQvemllwh1fC207w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792701333;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VyQV+KxPvR8R+lV3YrcqX86S1ecS5EwyZ0qZPDEi9II=;
	b=tjRdEe54JUmuk5xSWdfGR/07Bt683oUUEThknFj4W9FR+puC6QKXf2bs3zpo8tTM7nWs
	 HN0SVRIu+MNd/mHOpaNGm6cGz2dl3VN5PC0MzlkU+ahpn1IdofWyAy+WBGFy/hUp6u5Ib
	 l6jz6D5MbToIZ9cDjbfAquuIVrROO0Zten3fKhr1zSCA6uzOVXMId+g65Q9+5PQbXzsxv
	 567k5PSX/D7G/pl9nO0eE4gWHxgNpRlw8r9CN2JPjWJ+TOxg6RIbaHqbEJJ95NxF/zjFc
	 BNUkDe4h0yWHA8TUGFDZ9CzYKkzqPTWmxYg4tyLEtduehvVFQYpEdApMbOYfuBJcd6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HCoY74qn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4C0606A319
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HCoY74qn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2E81F01825;
	Thu, 22 Oct 2026 20:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792701332;
	bh=VyQV+KxPvR8R+lV3YrcqX86S1ecS5EwyZ0qZPDEi9II=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HCoY74qndjD7zYiLrP+XOBZ+XpIxQczRn0IFz2FNbY5FlqPxf5W39uPHcMWPYVibH
	 kHkSIbjty46X+dBkuZ2kcRYTNuXdLbw/GzLXPSrkkc2QSxwVxglbLaHwCxOz9P/YDt
	 nRjBWbthGIPrH3HzeuImAXfDShjwOC0cuJ+aninAzEUSMEsg8WwWXjXcaVanEMsMQv
	 VHIlZcDXu+46BKx2YFq22EDNzrH0bh01ulhQZ44whS2X7uS+PiS2+EhcmLv9zhsD3s
	 01VgZcZWSvu3M/EnjUIU8sGMgOHLjXpqVpvL0Nf4ybnU2+655JNbqqnkMlQ4YpFCOP
	 6WeaHtsrDs88A==
Message-ID: <sashiko-outbox-182013@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/11] perf bpf-filter: Fix bpf_link leak by using
 PERF_EVENT_IOC_SET_BPF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022203003.1779152-2-irogers@google.com>
References: <20261020205859.1080743-1-irogers@google.com>
 <20261022203003.1779152-1-irogers@google.com>
 <20261022203003.1779152-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 20:35:32 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> In perf_bpf_filter__prepare(), the unpinned filter path attaches
> skel->progs.perf_sample_filter to each FD(evsel, x, y) using
> bpf_program__attach_perf_event_opts() and ignores the returned
> struct bpf_link *, leaking the allocated struct bpf_link_perf and its
> BPF_PERF_EVENT link fd.
>=20
> Furthermore, bpf_program__attach_perf_event_opts() is designed for
> callers that transfer ownership of the perf_event fd to the returned
> bpf_link: when bpf_link__destroy() is called, bpf_link_perf_detach()
> unconditionally disables and closes perf_link->perf_event_fd. Because
> evsel->core.fd owns FD(evsel, x, y) and closes them in evlist__close(),
> destroying the returned bpf_link would double-close the perf_event file
> descriptors.
>=20
> Fix this by attaching the program directly with
> [ ... ]
>=20
> Reported-by: Namhyung Kim <namhyung@kernel.org>
> Closes: https://lore.kernel.org/linux-perf-users/20261020053226.55936-1-n=
amhyung@kernel.org/
> Fixes: 56ec9457a4a2 ("perf bpf filter: Implement event sample filtering")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022203003.1779=
152-1-irogers@google.com?part=3D1

