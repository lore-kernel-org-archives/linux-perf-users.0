Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E093939A2
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 19:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790449907; cv=none; b=i1UsTXsJFXX2qVQMyv3rP5DbS3HhGZqU3RnBn3wJ6Uj6jLyxlxwbgocNBMBocChNiQFtuVPMbgPlNRD/juOrbcIghHqT6GOsd352MhpT2txbmke+pXNZXbfaghnB94jMdPhEAMMxynth/WKdZU7srR9zvtBnxYsWzmpFM4ciwTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790449907; c=relaxed/simple;
	bh=MtlXosM9uOEsaYHO6HExujIAUgCmB7a7AOVAxOsxE24=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bY2+6h9eSeIK10VhUewCFmpihDyh1eStV3Vqe5mxi/ANfLr5zDntYq9H1H5szmou4eT7EmgwLLw423QMyzzU2555vGnWXt8ZowK4330CsWmqe6sP6ZWkxOV4xpNwwfU09Vlfm7deSeuUaoVQWRi8mGzA37AoepNEVakePJYgYO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVjUTYaK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVjUTYaK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCCB11F000FF;
	Sat, 26 Sep 2026 19:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790449905;
	bh=MtlXosM9uOEsaYHO6HExujIAUgCmB7a7AOVAxOsxE24=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RVjUTYaKimizeShZYmw268npdy/8qOeajR5HuNS4fLbgsEGMwp5uKWcjIjx03GT9e
	 d5LKVO1T8dr7v1+jM6u9gsZLlCdvV8eqLeJ5GRsD32AqmlX9BFc7rAYqhp8wuVO0h5
	 Xu1UqgJKGh5i9rk69VP7bEtAlH4ZtFsMvCwwJEbfLlyjkxnKVjPT/gaTEpcQYkTvXg
	 Pm+wD0XmhTYJm7DhC573ucnnAWXYSQmsRTcfXpGyIEpw09edJZddP/TuJEJccD3+WZ
	 X5iGb5V91oz2Kv6McYHwaTe5+a+m3/W/wU4RM3Z8bYE9erbDbkEwUWIOBdKZQA8EeD
	 kSU7mSNiHgUrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/8] perf bench futex: Use the whole timeval for elapsed
 times
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Pluta" <michalpl2003@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926190407.1106421-4-michalpl2003@gmail.com>
References: <20260926190407.1106421-1-michalpl2003@gmail.com>
 <20260926190407.1106421-4-michalpl2003@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 19:11:45 +0000
Message-Id: <20260926191145.BCCB11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Several futex benchmarks read only one field of the struct timeval that
> timersub() produces, so part of the elapsed time is lost.
>=20
> 'futex wake', 'futex wake-parallel' and 'futex requeue' print tv_usec,
> so a run that takes 1.5 s is shown as 500 ms. 'futex hash' and 'futex
> lock-pi' divide their operation count by tv_sec, which overstates the
> throughput when a run is stopped early, and gives 0 if that happens
> within the first second. Their "total secs" is truncated in the same
> way.
>=20
> Use the whole timeval and print "total secs" with two decimals. With
> --runtime=3D0 the rate is now computed over the time that actually
> elapsed, instead of showing 0.
>=20
> Fixes: 27db78307481 ("perf bench: Add futex-wake microbenchmark")
> Fixes: 0fb298cf95c0 ("perf bench: Add futex-requeue microbenchmark")
> Fixes: a043971141f1 ("perf bench: Add futex-hash microbenchmark")
> Fixes: d2f3f5d2e9ca ("perf bench futex: Add lock_pi stresser")
> Fixes: d65817b4e707 ("perf bench futex: Support parallel waker threads")
> Assisted-by: LLM
> Signed-off-by: Michal Pluta <michalpl2003@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926190407.1106=
421-1-michalpl2003@gmail.com?part=3D3

