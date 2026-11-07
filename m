Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048813;
	b=OL70m7UiIdBhz/QBpaOcBXqRiyMMQTz7zu5yt381uizEksuBX7HyDnyJpTBbqMDCuvnO
	 Bh5iI5rEI4yW5tE2JECJoZH+7rs76RaatvR8Rl9hE3flWx0nGH6eyCqOSwhxSv4hRG7yC
	 7+ZTYqfy4vBrlS3uZm4C15pzfF5swkID9UoIq4+t+l61SXlNFui8/AESystA+8KkNwXtf
	 T03zPwjfjV5YMerQ2iT1qPwHyOWxTnvhE3eVswbtju/Z5xdGl7bL5mxzGJFhO3bhH/lZ0
	 DxqARcghpqH2grEXdcVakt48QthuEsKsrCbELRMAEhfAvmoJWPC9rrFs0kOOsiaDiHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048813;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SOivQdH2CF98d5thEz18DlwEMkwInajjw4BlfmZ0/sU=;
	b=PoC9aCbXAKD8/yvoUTvPtSR4ApZmE0dJOAYgbRtEgZ0/Yg/xxQLkDZtf7N5EryvfYBop
	 3kb+duHO37fLK0e0VIk0cCwphFMaQd2Mij3uxc2LYPn7pf4lGHFpjU1W28lP4BQ8R7jeI
	 BizOwOs6zjHaKVU3v3h/2cQnFen0eJUtRIPM37vT2H35LD1EBhggBhbTEKHuBNpmULM3B
	 xWs8s6+WDgT6bVdnSYwWu0VcIQ1Jiw655nndio7pKTLBVkWlKsSQGkXxQK0dEZu4U+FOz
	 o/qL52omP/AT7k33a3bkp3GnrI4cs9BuZloxTc2ljss/b1zkn7jvY49aLz9Z6L4O10A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TZA4rsLg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9D7606A326
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Nov 2026 10:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TZA4rsLg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B0F1F008A2;
	Sat,  7 Nov 2026 10:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048813;
	bh=SOivQdH2CF98d5thEz18DlwEMkwInajjw4BlfmZ0/sU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TZA4rsLgnXHgIZooFOQNn72hZCE9hLoFjNHmzCHCU7N859G1W0Duohzu8SeMt6CpJ
	 +SlTZnjvwk+ms1nEanklMn3YTpX2gw5zkPYX9RLQDvFTfotTfxMtSsw3bSIBcXjNjU
	 9rdDB3vMu/WI/R6dGzwbQjcapNW6WTi5VPBxiwCUO7rAvZud/7w2NuPTip2TtGqBwm
	 dxt4zW2+WIGNI/ht1FDoo2g+ixgxSvblFDNHcUNHFPg/ywL8DEc68hfb+f+I9JdBfN
	 6YFvKT2wu4j49NhF5TTjkVbSvKi9t94JyUF3eemKTKJWvgYwGRcVXrvE3U4EJ+rOzA
	 JzDrlfLdVo6Dg==
Message-ID: <sashiko-outbox-202825@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/15] drivers/perf: apple_m1: Support
 per-implementation event size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myria Sarvay" <myrialsarvay@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261107-m3-plus-pmu-events-v2-4-acf1e78da039@gmail.com>
References: <20261107-m3-plus-pmu-events-v2-0-acf1e78da039@gmail.com>
 <20261107-m3-plus-pmu-events-v2-4-acf1e78da039@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 10:53:32 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Myria Sarvay <myrialsarvay@gmail.com>
>=20
> On M3 and later silicon, events are 16-bits instead of the 8-bits of
> earlier implementations.
>=20
> Co-developed-by: Yuvan Shen <yuvanshen09@gmail.com>
> Signed-off-by: Yuvan Shen <yuvanshen09@gmail.com>
> Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107-m3-plus-pm=
u-events-v2-0-acf1e78da039@gmail.com?part=3D4

