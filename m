Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793120958;
	b=g5HITRtBybPaJUELvferX1o4+HppI0Pk8Tv9nweeQrlITZOstcYGHsV9pxiIfd98Rsf9
	 QTkvpOOf8tHnSF/mgtMg2alUAOg/fCjKO9UhCE7KMvFYblrldZwRh1HRDFm7UXMHLcCZ5
	 mQZIyDvpq6R9Mis9/pu6mjYsJMPV5YI2jIV6/7o7XPwJxgHThWJWFZRWfbeGVMq8ycFDJ
	 X3/r1d7Rx8gZNonMR4DqTfAIn3CjapDNz0Xkuj6tNwVLPdD9yL8EmwR6jF3yTIlelUxhE
	 Y5le9Rf7nFpI+faj2XU6jfmcsooopKzMd/QY3vIEFOQaxm8BiMC1nL7JmdkgNPxvxDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793120958;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QEfZZvlVdfCgH6Pzx2kpJS3ntrmyjRFO2pUJMviMrzM=;
	b=LEixyD23cv8UgZg1jNed4aaOoSTxdd/5i+P7vMpsPJaQqUhbMFWhCUxy04r9HPI/yP9l
	 5ujMKS8Kt+Quacw6S6SPf1BoE2WicqMbBhzUhY1pcpOcOB+Ng5IXb8jAm1/Mc/3lbpz1v
	 wDFIA6eqYDXqkuD3duEU5GSxuS5dR4qsG9rny2AekS0efGe1HUSDipNbiA9l3mgNEihAO
	 +pvfHiTCMnpdN+ibt112UbpQOr4zY8S/K8wSooxigoAl/+T0wOpn0eBRRwn/T4JoTnCuu
	 Wkn4VPX7bsrLE/A+FPyIP5qm+UEDpl7imPBS0BkvzkQpm1+Ketg5+A+sGlvPGkU3Klg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oyp5Kub4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62976606A31B
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 17:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oyp5Kub4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5371F01825;
	Tue, 27 Oct 2026 17:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793120958;
	bh=QEfZZvlVdfCgH6Pzx2kpJS3ntrmyjRFO2pUJMviMrzM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Oyp5Kub4J+uyO6GDyxJbg6+ti6ZboTnJG/hDhfojxaVMGROLqtgqkPwDl4kZLQ4oa
	 m9A80KgS68Y54Aib4tqhuAa6FN4KcO0JcfDCXMbEWjVyAAQNBUQC1F+CqkzvJQXYW4
	 RwVr8u5BgRZ4D0GYOu3ZRjXLekLWGSY1woGKNI4zpGpUJaY/NnHJ11IH7vwSMbFkdS
	 MOwqvyzFESagh4JkWRk548CLUGGjLsh/czKifu4oj7cYntctpTcUC+AC4BcaidNutb
	 WDG/Wx3CGwTEKcCxALCxEK0BMSqLxeWWbin1L+tGURr84RSbhF4iF5KmUAmbLVR+S2
	 iPBmaYrXjbuBA==
Message-ID: <sashiko-outbox-186973@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/4] perf off-cpu: Fix cgroup_filter map sizing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261027170415.2815859-3-irogers@google.com>
References: <20261027170415.2815859-1-irogers@google.com>
 <20261027170415.2815859-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 17:09:17 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> off_cpu_prepare() assumed that if evlist__first(evlist)->cgrp is set,
> the number of cgroups is evlist__nr_entries(evlist) - 1 (excluding the
> dummy bpf-output event). This can under-size cgroup_filter when
> non-cgroup events precede cgroup events or when no dummy bpf-output
> event is added.
>=20
> Count the number of evsels in evlist that have a cgroup set and use that
> count to size and populate cgroup_filter.
>=20
> Fixes: 685439a7a037 ("perf record: Add cgroup support for off-cpu profili=
ng")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027170415.2815=
859-1-irogers@google.com?part=3D3

