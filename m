Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048725;
	b=Vo+eL0o0bJAILdJMBBKPNt4na70sXsWMcpOXnSxVh65vDYBTCcaeB9y07vtWIP4fnP1Y
	 WOLHm6E+3DznPa5NvLCLVEhtK39ukFrIcisLmAujYHuek9khWW4TW0oDnbT6WXxz2D1Oh
	 S6DYfUuoGnY+LGttqkW+542Af00EzP3q8N8kpuC9/5g/VUeCmHWapHDk0Fi9EGpuKVGTv
	 KjCEau/2LnDyj2XAMRsZGJFQoQx/lAC8XK6mOJdyMQ6JKDdRrwZJxAwfxDlt92uSuDjKB
	 Im2nFf8o/B5ggUkswszwCktvAJ1nIgInVNq4/ZUcvhEMgGVXHVo1PQt+J0LNqWvO1Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048725;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FXe7jZ9cPA2zkCvXw/9nuhXlaFjJAaCax2aMxJN3sIs=;
	b=yGm3F7u8p5jvPNFQQArQ2kkQvGPHr6EF3AArXtRhM0HUj5ouMyGJjpw+4ZwHYHaepDTO
	 IvwFur5nUGypstmw7DR7fpuXQHufdnVju4+aYF/bkf7qBcEqqRhloNo87fI/2wFobKOBF
	 KeSAGVPXy5DYh5LuaikCG1y4zG7FmVPV8hF4uuaA6O4hQyczhrrpQ4oz5W4uh7l+uhR9h
	 4Bk07WOoNXlRcub+DWggwB9WTWCeL42TO2Afu3dtHjyqMBolgTlelujhBUK3zZZN/cYYg
	 El3vkO8f0M2wrKRtqI4sLktp2KMHTdUvoUW1HcWu80ZyqBGV9IQfEbpPQMDEZNxFZNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MXduIpwJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A015C606A32E
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Nov 2026 10:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MXduIpwJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587A81F0089F;
	Sat,  7 Nov 2026 10:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048725;
	bh=FXe7jZ9cPA2zkCvXw/9nuhXlaFjJAaCax2aMxJN3sIs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MXduIpwJIOF6vvV3G7wEhW5CFSDHcTMWM9rigHw6m4FFGzbV+EDrmjfWSmspvt5EK
	 2QAflQJss9CJAmAxOL6ufo+ja5iTslQJhwMWAhmXaW0r4jhGwGLsfPvnEHLfvT6mLc
	 98yKkGFNjcZIyaUKcmtuNbEtZMOr1TnaRd5Fp8tOpl94NrsY8iCS5x10J3bwlLUMos
	 SiCa4QA8UF7VVn+itzEv24aq/YGMvYlH4wmvAu2HxpFDU6aYQ6WhntTJSP69c8OBAE
	 fu/vj3w4kQWSgzTVcIb9v2F7p6gk6dRV5VmUNFSscijTU83aofCkeCf08R1EwCVjan
	 s3cl3TlsZ1h/g==
Message-ID: <sashiko-outbox-202822@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/15] dt-bindings: arm: pmu: Add Apple M3/M4/A18 Pro
 SoC CPU PMU compatibles
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myria Sarvay" <myrialsarvay@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261107-m3-plus-pmu-events-v2-1-acf1e78da039@gmail.com>
References: <20261107-m3-plus-pmu-events-v2-0-acf1e78da039@gmail.com>
 <20261107-m3-plus-pmu-events-v2-1-acf1e78da039@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 10:52:04 +0000
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
> Document the compatibles for all current M3, M4 and A18 Pro SoC PMU
> variants. Note that the M4+ are split out by chip codenames, instead of
> name for the types of cores, as they no longer have individual names for
> the performance and efficiency cores.
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107-m3-plus-pm=
u-events-v2-0-acf1e78da039@gmail.com?part=3D1

