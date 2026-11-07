Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048834;
	b=EWXrlv9cvMtPlvGbScQZ4ktmxoi9HX5gm/pUxUeurSOtjJA2ADkHKz3wSsjoPZlrB0nP
	 bIYN1VryEs/cmPRX1phGFb/qMIlj2/sJi3a3D3wjLbWM2APPs5h8DFC7ZIuQr4/fT8PFe
	 mCqs1m2hhS11e3VMvbF1styBuOTTyEwLodTPT4r1yoQxW4I18eGXbiVb3zteeswanK1Wf
	 XO4dmwjKchfbqj8nev1fPac9H29IzudhQlqbl5C5KOeraAWoQi8zmDalKFMQYHvXVoRZy
	 eAS0uGJVrQn7+KwPluDwULg7kLlV9xAHBbVWBjeiPpPpX0J6CZITnHPemmMsyxabh8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048834;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=v5GZUdd22nv6p2T9Mnx0IzsgqhRzpvFfWZ0a6XDelKo=;
	b=KDM7sUS92RIi+jkNPVa8s7HkUw/wNjVRLunM7U/kozp0Zpilrp5X056Q1hgF8qDhNOkl
	 hjX5gQVba3m+vtiV6oSYfa8Bmgnv2/DWqvtx9UmsxJwpCkigpAnUXZuF3T5QFvMFRMW3O
	 NrEGWp/4oRNUcsfRBRojm6kkZgV7vUqM9MWIob0FEPsOpWjgPUmmBJ4K/xGYuXehhRtRR
	 +IBkGovZfcWBImUHd/5tMx38licm8eJuRnVvo5m8MU0lu3583RGaj3cOaQbhre29wn4FV
	 2vMVW/q4XCdHm9pqpHsZq2DliI/aYEX0XHH31qPPxCr5OK3hfddxwo94FaQ3/LpKK6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TODuKJRW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87651606D80A
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Nov 2026 10:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TODuKJRW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDE51F008A1;
	Sat,  7 Nov 2026 10:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048834;
	bh=v5GZUdd22nv6p2T9Mnx0IzsgqhRzpvFfWZ0a6XDelKo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TODuKJRWoNxgb+gmTp8Y3x7xPJabNq65jmieHhcPv12/K/j/eq9Maf80q0G6dCLhc
	 SaNq9K8t2Yc3/M7NvTbpOjGq4QT8hpwm33sdke7TL4dysTvbhj9WGnKNw2INeN1BEy
	 Yb85u+ru34ulXHLqlaTrTMpaOibzdMUY+eXlBmQU1tMZZboljiOXzKlrgu4IzKea0A
	 W/lX5zYGKOByoWVu5DrHngPU1Sc7rHDNQjbFoDNHl3Upw5bVJt6UE+NIEZWJg7CHXO
	 0nIcCGIrtNVyRG1RZPX/gpR5rAWM4IxI4p22ofNGcU3rS51Lwy3s/BIckeDZpbGSst
	 fR+ST74V2r8EA==
Message-ID: <sashiko-outbox-202827@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/15] arm64: dts: apple: t603*: Add core interrupt
 affinities
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myria Sarvay" <myrialsarvay@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261107-m3-plus-pmu-events-v2-9-acf1e78da039@gmail.com>
References: <20261107-m3-plus-pmu-events-v2-0-acf1e78da039@gmail.com>
 <20261107-m3-plus-pmu-events-v2-9-acf1e78da039@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 10:53:53 +0000
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
> Add the cpu interrupt affinities for M3 Pro/Max SoCs
>=20
> Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107-m3-plus-pm=
u-events-v2-0-acf1e78da039@gmail.com?part=3D9

