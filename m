Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE8D54705D
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 06:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789713946; cv=none; b=r9T/rKcIV1TvYbgLqZpFRTovmhnH1TA72PwqqBR94po6YUxRLzBAhvb4sVqDJQ2E8PhubaVDmZ67VkCksMW8u+oSknwIYsr7SkCgSTDoRAx1BFyunHcv7vUyud8qd3fhMqlr79fuNi43sb6eFi5c8wBKQJkfgfjSmT5tXyDDryw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789713946; c=relaxed/simple;
	bh=R8wBxpi/PInh0tcHx4DnPgwsvfjjx3LNdL5U9OCgzl0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=trHfPAoQAw+VDlF2/KWXZlyMDnh1DoyF/o9BitIGR1h54hZGf3QPe/6pCvb7fbd2c5PrLW4WFs3k60Tmkf0Y7kS1VlEuEZB4VOjVsBKFysEkYjVPsej41/sAsPy770thUpneBjVJ27Ps9ZBkRTb/xNJ2dEAF/+8knTnOs9AIKcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItppT9qY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItppT9qY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4B31F000FF;
	Fri, 18 Sep 2026 06:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789713944;
	bh=SESlCiovGynHUaPxAiAO1t3U9ZMiURn+9/5keSCOpQ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ItppT9qY0AmzA2BfFSkmvtNE715bLIvCck6JTb7sb2eVdllLzsV04EDuKlAhsZmw0
	 8TXOWYFN090FOybecleAtxuyGhFObRpkS5ObKn8r2OCa4UTskzhmeV+eyiXTHz1EqM
	 UE+LAUM5GRtwHSTTbFgnzq1OeIweCrPkw2dEdCVn/5kAckPP17XFUkzB5wIdGpFXGP
	 RH4l008yWd3t/wKwXyP1ZQ0hAbbuVdGuun1H5oMQMM8sCTLxMXZd7V+sgkPZPqxqeI
	 81fiayesPnfT00+8/jrkhEWA9WOMkqTmzASQhoalQqSY957SXaMmkuKDtup7ExVHPo
	 i8/hXLmNBlHDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/5] perf trace: Free the host machine allocation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918063249.2172589-5-irogers@google.com>
References: <20260918063249.2172589-1-irogers@google.com>
 <20260918063249.2172589-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 06:45:44 +0000
Message-Id: <20260918064544.8A4B31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> trace__symbols_init() creates the host machine with machine__new_host(),
> which allocates a struct machine, but trace__symbols__exit() released it
> with machine__exit(). That tears down the contents of the machine and
> leaves the allocation itself behind, so use machine__delete(), which
> does both. The replay path points trace->host at the machine embedded in
> the session and never reaches here, so nothing else is affected.
>=20
> The leak was hidden from leak sanitizer because trace__symbols_init()
> passes the machine to trace_event__register_resolver(), which stores it
> as the private pointer of the global tep handle. The handle kept the
> machine reachable for as long as the process lived, so it was only once
> the handle started being freed that this was reported:
>=20
>   Direct leak of 1256 byte(s) in 1 object(s) allocated from:
>       #1 __machine__new_host util/machine.c:135
>       #2 machine__new_host util/machine.c:155
>       #3 trace__symbols_init builtin-trace.c:2105
>       #4 trace__run builtin-trace.c:4759
>       #5 cmd_trace builtin-trace.c:6091
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918063249.2172=
589-1-irogers@google.com?part=3D4

