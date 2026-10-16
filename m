Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF77F22D7A1
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 00:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792110113; cv=none; b=N4cIOQHlk7r+5+FbCHsOM78erytruDkAaFYSlwCvTJJ14D8kVxsrcXs+APFhhoWpsj10PlZ5oUar2a7HqrluyhuW8zkfqIFoMzELbg8Yu/NYZGeng6ll1IZSg5Y5msvceP3uMvQhL7dKgUhsbWcXklBXWR8sBVeZZT6Dhc9YDD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792110113; c=relaxed/simple;
	bh=q/PbyuYkzkKDJXPM+oyNjj8jp/3hyl0nyeK3my19XSQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=fmhu+xBSQyDHNL1+04blF5rVXdHyZN8YmwsEMW5JJHa/eHMk+buqqONiHVAs5gq13Xh81G6mSwpVfAuG8fBnoWb3ZsoPh3w3TyzdK9l1IMraHCdvh+6qMXzOb7BaUZVmemhPsNeN5GYDnBXQtPnKaB3mLucvXyrOzhkyiKSqj/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHtNcrrL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHtNcrrL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBD11F000C4;
	Fri, 16 Oct 2026 00:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792110112;
	bh=amoL3aBU93ztiizxOwAKog5V98TxCD3/Jk0b0/VqRvk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SHtNcrrLzzRfEfu8tc4sAm496Y8WdDxN7ap5Qxr/eeJ/HaBQI8IEhKX+9d7ZpzH/j
	 VAIoSR9QW1ytpy/jQiwFe/NYPwqMjHqE936C5fvEwLxLsjCrgjDC/85h86/9R4/g0w
	 SDfXulM6NynYH90Y0fcw6Kgj+zD3XiSVJxuY1rqQfP2vteKQlL0gPAG8/UEoXm+D/U
	 GGWU4M9EZ7kcz3p+JZ5kj/0H5N+TFOLZ0ZLxVZEs3Qc43gD6+tPVcY/BxOKerVIN0+
	 2ydMmggAcL7zhdvHogglhvecS2w57d8ASwh8hgp4YcvJZJH85+sEJYfi6HD5jps53+
	 Ke5B9nF57oSDQ==
Message-ID: <sashiko-outbox-173512@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/19] perf test attr: Fix default stat metrics
 expectations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016001843.71978-5-acme@kernel.org>
References: <20261016001843.71978-1-acme@kernel.org>
 <20261016001843.71978-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 00:21:52 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Since commit c7adeb0974f1 ("perf jevents: Add set of common metrics based
> on default ones") and commit 2dfc0cab3da4 ("perf stat: Add detail -d,-dd,=
-ddd
> metrics") the perf stat default metrics open their events in groups, so
> group leaders and members have read_format=3D15 and members are enabled
> without enable_on_exec, while standalone events keep read_format=3D3 and
> are disabled until exec.
>=20
> Also, since commit b1c5efbfd92e ("perf parse-events: Remove hard coded
> legacy hardware and cache parsing") bare hardware events resolve to the
> core PMU sysfs/JSON events (type 4), so add the raw encodings the Intel
> and AMD core PMUs use for instructions, branch-misses, cpu-cycles and
> stalled-cycles-frontend/backend to test-stat-default and
> test-stat-detailed-1/2/3.
>=20
> Add base-stat-group, that accepts both the standalone and the group
> variants of read_format, disabled and enable_on_exec, and point the four
> default/detailed expectations at it.  test-stat-basic, test-stat-C0 and
> test-stat-no-inherit keep base-stat, whose events aren't opened in a
> group: for those, a change that groups or enables them differently is
> still something to catch.  test-stat-group1 does open its events in a
> group, but pins read_format, disabled and enable_on_exec itself, the very
> terms base-stat-group loosens, so it doesn't need it either.
>=20
> Fixes: b1c5efbfd92eb84d ("perf parse-events: Remove hard coded legacy har=
dware and cache parsing")
> Fixes: c7adeb0974f18da4 ("perf jevents: Add set of common metrics based o=
n default ones")
> Fixes: 2dfc0cab3da4a205 ("perf stat: Add detail -d,-dd,-ddd metrics")
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016001843.7197=
8-1-acme@kernel.org?part=3D4

