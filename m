Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC222C234E
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 00:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792110541; cv=none; b=nQ31yHz1MylQ76n7XhPEQFj2PabSNzXamnjUqLfg73eF/e4OzJ1chhIaggOKmoWbhBmZl+UsysmRn0QH6B+EmeGaxoswpO43v5yqVetdqOpAM184iuMue0yhrtcT/JoV3yolioc3wdKWLHCCwPBZT6T9SgXb8z3mpyjbKg1e2uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792110541; c=relaxed/simple;
	bh=73bz1xvakn6xtsWhL0xtt7QUNpQnMMn1qmHYbWwewtw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Nkoz1kXxRHlJFZdRaFIztTeuFZeDRwdKNkvnpQDhF53H2bvNDy3TcTysoDwqDUIv4LMZxqUlMIeoEERAerDWTsartt82IvNKQe2F0nDy6Ft/DIbsuT2l2KpF5DBhY34tjfJcBPDslVzonNURVoiP8v3JoQbNHTd3aMzwNvw/A3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqKLocyX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqKLocyX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0971F000C4;
	Fri, 16 Oct 2026 00:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792110539;
	bh=m2UkUgvsCPt8IKOaGPJlizILiNKTzndvczPxvGb0l4w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YqKLocyXufidqxJjgB0HsStn4vvE+jwY2pA8DXNnbuxshaxMid1YJpHzUVOpotgjD
	 1MZXeOYtckdAHQHyBTnHhHIpmwd5PjrjEdw/g2T201DSgZQ1TRiiWmZTFMw9Xr92D/
	 pEmcVxOSosg35OiFv8qeb5epZebThJziijVijUbDNjH6KA221Fwaq9be/y5oofG4KN
	 D3irjiSkysyR2Nk8yJ51saIoKDWxbZAI7P20nFrbtZJnaNwwlL5OiO55YgAS9F9YlV
	 FDOd1/tUqOxCK/oxlq7w3wWo2xlcumU2DwDpp08gEZzbxiGgXygoADFwtAw3axtOE9
	 JYW6BbaLOrddg==
Message-ID: <sashiko-outbox-173530@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 18/19] perf mutex: Add a robust, process-shared mutex
 initializer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016001843.71978-19-acme@kernel.org>
References: <20261016001843.71978-1-acme@kernel.org>
 <20261016001843.71978-19-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 00:28:59 +0000
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

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016001843.7197=
8-1-acme@kernel.org?part=3D18

