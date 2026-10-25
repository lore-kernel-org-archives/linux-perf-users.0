Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792966921;
	b=aZpRTnbbA/457s1e6t7hKb7AC/QJprO4dO3gY7n65L6cd9nffIhvlssjgS29lSHF2NPc
	 +1UKx404wG08Wjym6XJ1HAwFElRwvxdhJgolo580aWK81nhjw/KgdhhJXmjCVwHYWeY+O
	 KmujfrVOGun6ss2mmnWUhKugw1c1PZiN4CcHZ7Z1cqfFdqIXKneEAIlfI9f91b51dQ8qE
	 zw8msRX8PtiacubhTQZJR80DJoLcx42o6fvLErpvauhtdGjXD38Y3cJK/jkrQkcZ9htyX
	 NBl9ayUXssdll0Bl2rlF1f/m/BXwb3gdqKaoYWCo1wB0NBIUCw3aSgk+1alaPyH4wkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792966921;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WDgGkaNLO6eeeeWKTAXXLPRuagwNWkluVgeLbU7Whco=;
	b=KK4SAXKE7jKLxVxCLq7fytLALzxdv3kJgf44LNHACgd5pxDkF47RKYU7ojuj6yNwuZwe
	 pOejq1cWy+r86fPxu8v4MkB5y4Y0wCXKCnyOEsrgBHaYfxIumSBk7scP7nOkNf/QyJUGR
	 oJWotA7qvsBQXW8Cwk7rLYVQyCuMv3U5nIm06BR6G48TOU54s6T/+/BA+XZyM9eWD2U/5
	 wYrIhsKVf0ARpeg9hStJOItPoiPmdT5Q9pdXVnaBrwHeG0awsO0F+ylQNO1LxJOAG8TLF
	 uUOljQLFPpVzEUjG72quwxUEELCLu38/4kWR+mz3wAPhly+9rOagM12tthk6PM8wW/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c0WxVFp7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BC1606A31A
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 22:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c0WxVFp7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA391F01825;
	Sun, 25 Oct 2026 22:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792966921;
	bh=WDgGkaNLO6eeeeWKTAXXLPRuagwNWkluVgeLbU7Whco=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=c0WxVFp72KwlhBvOlMKrBPKgh23LBd3Z2kg3uB4A40mFCkbxz8lxvLvLS6ALfrEmb
	 4qV5KgXJ8NjXqicEXeGZFuMXuSq3IwUzpH9am6B8y5M1xnieoS9lcf+Olf7lvnE26O
	 ENT4BMfWVkM20A26Rr5YYol4c2CXScyd2kI//0Rh8yXf3R2Qz8KlDMntN/fp83w8b1
	 AujiLPe07Jmyefl78inp0rtGSIyEtHUFggwEKNvA9a56sIQD5wZfxbBMRuK4hpe8CJ
	 YHAYQMQMGWHR/khDzn3LZlI+5bF5yYOydQ5CcN8xwmc+AvreBxpFKbhYC1ym+IU+zN
	 Rx50J1y3A3uRg==
Message-ID: <sashiko-outbox-184473@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] perf test switch-tracking: Fix hybrid cpu-cycles and
 spin timing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261025215056.1228120-1-irogers@google.com>
References: <20261025215056.1228120-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 22:22:00 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> On hybrid systems, parse_event(evlist, "cpu-cycles:u") creates multiple
> evsels (e.g. cpu_atom/cpu-cycles/ and cpu_core/cpu-cycles/), but
> test__switch_tracking() only configured, enabled/disabled, and checked
> evlist__last(evlist). If the test process ran on another core PMU during
> one of the spin phases, the tracked evsel recorded no samples and the
> test failed with 'Missing cycles events'. Additionally, the other core
> PMU evsels did not have PERF_SAMPLE_TIME set, which add_event() missed
> because __evsel__parse_sample() initializes sample.time to -1ULL rather
> than 0.
>=20
> Use evsel__match(evsel, HARDWARE, HW_CPU_CYCLES) to configure,
> enable/disable, and check all cycles evsels created by parse_event(),
> check for sample.time =3D=3D -1ULL in add_event(), and use
> CLOCK_THREAD_CPUTIME_ID in spin_sleep() so preemption under load does
> not finish the 50ms spin without on-CPU cycles.
>=20
> Fixes: 94f9eb95d954 ("perf pmus: Remove perf_pmus__has_hybrid")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025215056.1228=
120-1-irogers@google.com?part=3D1

