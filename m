Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793275307;
	b=n2jbjXHCQH+UaofUGzOh/5PA0otBfEalcx3WdFhKiKMXSFTh10ZckbtGnZtc0kBtM6dC
	 87UHPhdUVRUMB4m6YlckiMzzMYN0VgQy+E2pIwOCEK2DYpToEXnxmQ6R4P/jv89v3ukYT
	 xz1vKH8sS7Na7Won/Rn9avak4mVA/Jfj6xffWEzlXvmormLkMhZ7URKQy+H3gAh6CKQxW
	 fjj5wzG8TIVz5u+P8vkBPiAXxByLcuwCSDz72XwAkqpf7HrfNAiY700+nVCx2qYCy2QjC
	 gFBw9QIbxYNqM+VaL+aB+3tu0ECD2kCSWD53oJUFSsE3VS7suWX/TVhDLkLBjP9lbEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793275307;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=26QqZRS2vLLl5rTQZomsyDD/cM80sUXKbNnnwIRqf3Q=;
	b=AC0ZYrp3Df8m/LvWU9V30dIDVcaHmx3+zmTsn13o24SBFcq1H1cVp45Cvj9qWpFeSogk
	 6Ry0vOHWYETuH+yf6pdignqzVhlPNsNRoRmx/AI0nkE+fMTkjAmE9VFGftKmzyjL1665b
	 1aqFxH0CiqdaHadkP1SgWAFOSFQ5Ih7V++J0G8PJ9tsOHy945jndS74qkaxligFB/frVw
	 /IINvYOriRdmrUpLNCvfvFJSYeCHNzOknHVpFMlRXs3M/6pPYkRaIokgiEjXXRffsvxyz
	 XBgYPA312SL4Uk+HAhwR6PWcKsQDOz4caYnKNzG2pMwoxIcCrDc5GJOY6Tft8mLj1Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="a6ol/aph";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34A5606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 12:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a6ol/aph
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E221F01825;
	Thu, 29 Oct 2026 12:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793275306;
	bh=26QqZRS2vLLl5rTQZomsyDD/cM80sUXKbNnnwIRqf3Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a6ol/aphykYsymaZV2VXL67viI7f+YkQiwKCnwlGD9BZjk0iBtED5Ssm2yNP4wccW
	 9idJDbM4VW1WNvOW0LybKHyWr7Qcc3PT4Q99qftygjSMgrCiZhmEA1FIz7kF4hVxSB
	 xgt/GwIU7NGsYBeRiyPtLglHtsbsTHLP1I8hfwv+E7tObs8X+TC1VRedGdeybOOWr1
	 FIkWOHuAxZxSOhEJT7RG6tG6XmmY66pJVXLvIN2E8TPyku2NmMnhPU8JLMy/8PuUds
	 QZjS38tyn2Rn75UbA6ZuD0JnPIghKOqzeWyLhGUyHVDsRqMK/xi2XHgXaXHetnTzb0
	 ySnlkD8EEok4Q==
Message-ID: <sashiko-outbox-189234@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 07/20] perf: Always inline the empty perf_lopwr_cb()
 stub
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261028120034.871983-8-sashal@kernel.org>
References: <20261028120034.871983-1-sashal@kernel.org>
 <20261028120034.871983-8-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 12:01:45 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> perf_lopwr_cb() is called from the noinstr acpi_idle_do_entry(). The
> x86 implementation is __always_inline, but the empty fallback is a
> plain static inline function, which the compiler won't inline into
> noinstr code when building with code coverage instrumentation:
>=20
>   vmlinux.o: warning: objtool: acpi_idle_do_entry+0x4: call to perf_lopwr=
_cb() leaves .noinstr.text section
>=20
> Make the stub __always_inline as well.
>=20
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028120034.8719=
83-1-sashal@kernel.org?part=3D7

