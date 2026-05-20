Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1A83BE162
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 11:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779275947; cv=none; b=qx2yTUlP7ELOgcuqJ9a2S9TA0bPbCUhWOD3EHTJHDabN2jDZsrd/qQgj4Ts8B/wG75D92mMOmD//43nOyQCN2INKrjOi9CaQ0uH54gBzmKK8puSKh2Fix+qhoCrWyflG60vQcseEMGTgtEklA3e85CLwW7YqFIn5Z4Mz3iqWITE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779275947; c=relaxed/simple;
	bh=u6kqb6FJ9k0xxQRuDo1VV8mIdPOU279zNstCwMmO7Qk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mZJ7nKjEHd+OhE8fxFemlG6/4KeuWHB42y+b9G77IvmkxqjDsM7bdqY+Kr+cF/8v32N19uupBjSdceZCxumdzY91LvhgtpnWVBM/L8QthNwkji9tKNVLoWfHmqThj0Q37tLsNFx9uFn4zCxkABCpaHZuAZ6o3Q9HDQ+RSRwlNc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGijcjAm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGijcjAm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE571F000E9;
	Wed, 20 May 2026 11:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779275946;
	bh=HL4NpIgl74bIur/2b64sKL518FDV2wAdmu3ItXdZyEs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PGijcjAmmKZ63EqREeVL3jPp1GEFS4xVKEmRk+FLzBJ29Jk+iBzfWOJTTuXmgNIYv
	 vDyjsB0uLMRdl73n5hWnimgeV05fKNeqpWcIEX6JwhZG0wrRRxEpSLcScfVvkvyEkD
	 xhfjsXlRhAbZhrLQp64Nv/UXX0MpZqBFAB9ePakgMToJSMxUdsKY1ksTBCOnfoCN31
	 AajVB3lrQW0KVurhxPOGpPCFYXMPCjDg5Sw1uUsYzHHLELKQXpVHItUeemcB8EtajB
	 CJblrDblJyOCDxz3HXZgbc3fBOh98QppP+DCODHs99l8WlGd2c7zOMONGxSCAqZZ7P
	 OGcU84byhMMTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] perf sched stats: Fix SIGCHLD vs pause() race in
 schedstat_live()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Swapnil Sapkal" <swapnil.sapkal@amd.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260520102017.293419-3-swapnil.sapkal@amd.com>
References: <20260520102017.293419-3-swapnil.sapkal@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 11:18:57 +0000
Message-Id: <20260520111906.2DE571F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The polling loop introduces unnecessary periodic wakeups when runni=
ng system-wide without a workload.
--

commit 7bab731e30cd90b3c5ff6f388399fa3469974523
Author: Swapnil Sapkal <swapnil.sapkal@amd.com>

perf sched stats: Fix SIGCHLD vs pause() race in schedstat_live()

This commit addresses a lost-wakeup race in schedstat_live where a
short-lived workload's SIGCHLD could be consumed before entering pause().
It replaces the pause() call with a polling loop.

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c

[ ... ]

> @@ -4698,8 +4699,11 @@ static int perf_sched__schedstat_live(struct perf_=
sched *sched,
>  	if (argc)
>  		evlist__start_workload(evlist);
> =20
> -	/* wait for signal */
> -	pause();
> +	while (!done) {
> +		if (argc && waitpid(evlist->workload.pid, NULL, WNOHANG) > 0)
> +			break;
> +		sleep(1);
> +	}

[Severity: Low]
When no workload is provided (argc =3D=3D 0), there is no child process and=
 thus
no risk of a SIGCHLD lost-wakeup race. Does replacing pause() with a=20
sleep(1) loop unconditionally introduce unnecessary periodic wakeups for
the system-wide case?

> =20
>  	if (reset) {
>  		err =3D disable_sched_schedstat();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520102017.2934=
19-1-swapnil.sapkal@amd.com?part=3D2
