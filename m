Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD88F43E9D5
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 08:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792312269; cv=none; b=ZhGGNGHQ0hLI0VApgZwhFhmLpU11PxSGp4ss0K5Wnxfi4/DwCT14tq1ekUq406Cmnxde78rKyzIj4LiIrrh37o5IKBe2fbvxenWtekpMQ8Go6f4fmxYIW/vnuod56vPMZNBkggfRxA9XjEzIYxKx6NXItyABI/EzklGYarrWtu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792312269; c=relaxed/simple;
	bh=OnjwOdyFr/cOymvd3pORVRdT0jy5PI6rARwOdCcoYVs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=QtQgFcF/GwKSB/QQSAFl0SsWfdBWbmAc5z1YEeS9BqYsNqFDWnkBA0QGRW/spQwxRuucCryzvVCYHvzKUVS0Ved6FXUaazvBqg4HDyRDt4Q+oaVuZehHlzYLOBT2EkZ8po7Nhk3xQJQ98eEscY76QjEbtssPMk6J4tmS6AN1kU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ozb+sR3W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ozb+sR3W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1F81F000C4;
	Sun, 18 Oct 2026 08:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792312268;
	bh=ssH0tpalLEEP1kG7RwNa7/8mMm6jtGSeO5X7J6DSHpA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ozb+sR3WG/4CPKmfN0o6YLgUp4AIchB6MXaLxOQZNmqPN5s/yl7TtOocsu9YXMlcF
	 nMkvtmyDkrMamqbcvPkZh6FsQ92AYcDyLnw75Sf/+Q4hpdtTi+VAlpe1MmleKaoH3z
	 O+NdAGy3f7cnPiXBs5Is3pud4niB1SMijAUekf45aF7aCBjKM8iQT2w7brUfIDgAGO
	 ivsjCwrbkLXgwMacAfsfgodcz3Iq6cojOPr5BDQAETjm4BLJR1xjnzF2P8h7xp3MFA
	 UZ4iT98K8Nz0waF04JgvrVja6TqHeGQ1DiIB2jCzn4IsScaib1vXC3L0SX778fw37W
	 z3NVyMNUHQ4Eg==
Message-ID: <sashiko-outbox-176010@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf python: Set up callchain parameters for sessions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lalit Maganti" <lalitmaganti@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261018081452.1014460-1-lalitmaganti@gmail.com>
References: <20261018081452.1014460-1-lalitmaganti@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 08:31:08 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> perf.session never calls callchain_param_setup(), so callchains are
> resolved with callchain_param.record_mode left as CALLCHAIN_NONE rather
> than set from the sample type as in perf script and perf report.
>=20
> On arm64 this loses frames: when a sample hits a function before it has
> pushed its frame record, its caller is only in the link register, and
> recovering it needs record_mode CALLCHAIN_FP. Comparing the callchain of
> every sample with perf script, on a frame pointer recording of a
> two-thread workload on arm64, 4 of 4494 samples miss a frame, e.g.:
>=20
>   perf script: clock_gettime@plt <- now <- spin <- other_path
>   perf.session: clock_gettime@plt <- spin <- other_path
>=20
> Call callchain_param_setup() once the session is created and, as perf
> script does, again as attrs are processed, for pipe mode. With that,
> all callchains match perf script on arm64, for frame pointer and DWARF
> recordings, from a file or a pipe. On x86 they matched before and still
> do.
>=20
> Assisted-by: LLM
> Signed-off-by: Lalit Maganti <lalitmaganti@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018081452.1014=
460-1-lalitmaganti@gmail.com?part=3D1

