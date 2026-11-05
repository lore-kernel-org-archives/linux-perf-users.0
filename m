Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793886273;
	b=Yh6DoUaQ9M8PTZLHBJMD5/gs3ruqDS8jf77zOPkwk/fRtTTMp4CXoXvheCNExtTJgfOf
	 gDoSf6kwx5bgiuHDS5N2GLBZwZeOOUlXdDJuJ4fnpYd4eBhYj9s9VixUK+g17deRL2VW7
	 U56Nzp7ZW12e+g1jVBmyXmlPZzjB7rtKGYlStse+goSOe7WYrLpQ+De9iYgFXtvq0xcpr
	 XuZsjxoOt22Vg5nVazWfsxn7ylDTJe+iEsdyo3k14atTzjSW2knL5/IfDu3EcW6QmPkUF
	 35WZgzTFtV7i2k4kkbgeUPWYObtGTYH2vwwf1ZSnJCBcVJRWPaK8tWH7zghpvLeFakQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793886273;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uKcLm/8sd342tLuES73oajFaCUfADIwu5RKGZL3cP70=;
	b=kX5GXyoZozmsuGM8UiOjwnz87DVkSipJ5/voCqVoZc2PwdbEOOEBSnS+4BVLFwCdf/fM
	 pI1q4ErDNRm+wTAI+30nEmCPpEQKwiVz/Zn4Dhl/hwQrgFG6v7OjS2IFC4jXwvaovrVL4
	 bWJ4d+gUfaBxktDNM8kpVrZj88EaTwZL9K0hMyB6ho/zdJ9RxrLQHa7GAj3seMP6aGfch
	 5SLeTol34gYBm7xSh1KRYYgd+QE8FsOzHGzAGPUQ4bvZMTDAMDkYZXcGy2ZaGqOJLHL+0
	 aEh7cyzebaBneFK0vj9+UPFKuouqQamDfF1ukJusSihFw02xcWm14oqjZfFUc7pqehQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Uvg/pwXN";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2073606A31B
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 13:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uvg/pwXN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C09E1F000C1;
	Thu,  5 Nov 2026 13:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793886273;
	bh=uKcLm/8sd342tLuES73oajFaCUfADIwu5RKGZL3cP70=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uvg/pwXNwSvVtcgJDnVGy/t3kEffvjc4Ns5TZAFC/uujvPHGEu3m8depFs5WcRArh
	 ScHayOuD7vj/FrAfRAVEEZUaQrtHfSLEe4xwkbzOkRTmqysYuPDSkgqYUNPnhXetiB
	 VRgwOTpdjY4oSLMCp1Qo/kuGnNqaIn0ujCbIkC2tcfS/kYOgaeKleIumZIUKm5boO/
	 0F8raX92wyk4njbQKILs2D2Z8AyG1gEq27moXb8toqtehZA+01PvUvk06R2CkvxNWK
	 BtueQLpanscbpoKQAZNnm0j25+jk1ycypFAGgznnhS4sifyTwyyokUwlLnkLnE+6w1
	 nD0R42vTT9HaA==
Message-ID: <sashiko-outbox-199170@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 17/19] perf test: cs-etm: Add test for per-thread
 mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105-james-cs-unformatted-per-thread-fix-v4-17-7759e0ce2449@linaro.org>
References: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
 <20261105-james-cs-unformatted-per-thread-fix-v4-17-7759e0ce2449@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 13:44:32 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Test that per-thread mode works when the process migrates across CPUs
> and that the decode happens in the correct order.
>=20
> A TODO is left in for when support for decoding in order with Perf
> records is added.
>=20
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> Tested-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-james-cs-u=
nformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org?part=3D17

