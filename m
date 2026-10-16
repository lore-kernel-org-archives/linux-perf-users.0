Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84301442FCE
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 21:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792185954; cv=none; b=dToc/qgDZ5aq4o5rM8gCFK4H20EuIbYA0ZlW9C/HlCz9JGnHAudc0wUxrILDfeSS3VnAn1ZaMmoDxnc+9DbzAxoZ2CqBIDBFYIVRklmfqLSkfiU35nFgcsOltRcr8Z96qS76NIVsT7xCA6bCIEH6+R7CVkY3huoo8cwAWfDnTQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792185954; c=relaxed/simple;
	bh=WclaLqBhI4aO8104HUi0zCz4jYW2ax4ifjBYIjSrPYo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Gxrg3EomnYT/CwU3uqrUJkK3TVosa9/3bhM5ktH9F48d5StdUri+GPT7gwZ0lKFE1byEQ9cY5MXPLJ1eQVlE/N9/PoFRFZ1qK6aUG0SafSrf59zTe4atMXb7FVDnoRGar7JlO7UxvVa4S2oHzYWAe2i6Adcs3eNi1n35W/uq8U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLvWCXXg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLvWCXXg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44FD01F000C4;
	Fri, 16 Oct 2026 21:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792185953;
	bh=XqbYxFMAra0C0qMYgIKr1PrPql2IiAOCTpEvaXaBmqE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VLvWCXXgmR029NJlXfq1h1Fq9FbfMTs5SmsAWdo02Nocv4sINABN0lHNFZIe4RbES
	 TofWwdDgOVggqAe2gLCwC5bv4s1snsETTw7KXXkxdSKCoOCjdGPS9gMzBj9bz18LEy
	 yVZQAkhEURPh8AVTHoeDTuy7xOyG98o56du+B9krCwVXl4/by2a2vJkmWc6zUAhUkL
	 EuvYEdc6hX27K0RJcXpVdIPjRZbE5gj9B5RVPrSzlwHWjeAMaGW7f7YReX9FW9XV4D
	 Yk4QhvCOVTakzsPOzJZKw1e7E5k8BZQGaT7UKbqCMec3ki3AKWw3YpyAN8cZkRoYkB
	 D7wdnl9N+djcg==
Message-ID: <sashiko-outbox-174967@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 20/21] perf mutex: Add a robust, process-shared mutex
 initializer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016212102.76550-21-acme@kernel.org>
References: <20261016212102.76550-1-acme@kernel.org>
 <20261016212102.76550-21-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 21:25:52 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> A mutex held by a process that can die before unlocking it, like the
> tests forked by 'perf test' that will take turns using the per user
> budget set in kernel.perf_event_mlock_kb, has to be taken over by the
> next locker instead of staying locked forever.
>=20
> Robust mutexes, on top of the kernel's robust futexes, do that: when an
> owner dies while holding it the kernel marks the futex word owner-died
> and the next pthread_mutex_lock() returns EOWNERDEAD, then mutex_lock()
> makes it consistent and takes it over; mutex_trylock() and cond_wait()
> come back with EOWNERDEAD too, so they take it over the same way, with
> mutex_trylock() giving the mutex back when it can't be taken over: it
> is held all the same, and a failed trylock must not leak it.
>=20
> Add mutex_init_pshared_robust(), returning false when robust mutexes
> aren't available: from libcs without the API, gated by a feature check,
> to musl and glibc refusing them at runtime, when get_robust_list(2) or
> set_robust_list(2) aren't usable.  glibc only sets a flag in
> pthread_mutexattr_setrobust(), refusing the mutex itself in
> pthread_mutex_init() with ENOTSUP instead, other errors from it still
> being reported.  Robust mutexes being unavailable isn't an error, just a
> debug message for whoever then falls back.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016212102.7655=
0-1-acme@kernel.org?part=3D20

