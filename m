Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701543;
	b=wQxZjuMbFw4/pfwqMSPusAU1ViY6ckiw9LFQxQiuwFqFYaJ06vcVFfM6kFcHC9gf6Pqn
	 FJJrRd1Wc2pT4QafGzvD/Zkml4q8zMPRbcDM3vcq8uj5sKdi9vdX5Hq+XhCXBIwROY4A8
	 AFrdYFiZuWpF1qBr3jK9gxy/9HjqiitaLpYrzqjzahsaeU+QYA5MpFh084VXO3hY5d5GU
	 peRJjIYxsdE5ZZ8fE/wk4ZPDqmPM9i7lkqVekTfFE0qEwmSMj3j+Vs8o3rNRsRTlxfsR6
	 IcpGv868+5M/7rtJrUktFtUllUcUYCQ5FpnPBEAwB7d8qByi1I0fsdr21ow1prEsUKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701543;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xkJ+SVshEZZRilOCb8+itNxU/62wh/KXfa0M4Lru4p0=;
	b=LQ5pFh7AY6GO7BJngp0DGN+1sjv5bhxHT81jVqZ/qbbAjh5FgOkhCH9S6UjklWON3PX0
	 U4Zod8Gw3vuxR+aPXSWx2vSRQIq/hemvjjWIEsabRda3vQ5blQ93oRfFzYeZ7H3pj2Hgk
	 GEm50jM9sDShsiNfRgUgifLWl8jbr1E7Pc0nZlyj36hkTtIyu5je9+2B7WH+DDg1j78YD
	 3eklINZdXMknloreCBcZ3Ei7cW9V4bs+tCpsrjJ7ct/SOPCABqxQ0bTsOqA/Kj+fEDS96
	 Sgp+m+COFcH4VKUbzpe9bvbyOhuy5LKhMqIH5FOW2//4c80oqpdSrbhpltXkiPk/Ayw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZwmotHUV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65109606B12D
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 10:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZwmotHUV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2471F00A23;
	Tue,  3 Nov 2026 10:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701543;
	bh=xkJ+SVshEZZRilOCb8+itNxU/62wh/KXfa0M4Lru4p0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZwmotHUVL3tc+M+MbeCRX631ypcKKDMZ6q9GO0mwhK8nT/0Q3A2cd/NKvDPBxu6SX
	 H1h5D0m5FvFai2PkB2QAJ/WnLeI3Li1LWTNGyMxnSXJqEZSNpQeZMYjMZtSR0IIuQw
	 eN3zLl0PuQJIGGJMrKoBC22DxGQG4r1zJxObf/6c0FaRi09WiXMoXtjMIe+Jf5cU7X
	 4OTBQ8U7kUS2SL+MKPJ2o7GlgfmjgaDI/EE3MotrAzbrigEqV90cIgljSx6KNM4haM
	 kn8MSgLpznVhdh7pSTAaO6dOFKXjI0lZK17iMI5PoxyJMuTtjsqL0eWrzlB88lvY67
	 nPrUUZqRKNnPA==
Message-ID: <sashiko-outbox-195041@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/13] drivers/perf: apple_m1: Support
 per-implementation event size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myria Sarvay" <myrialsarvay@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261103-m3-plus-pmu-events-v1-4-a8eb6c1139fe@gmail.com>
References: <20261103-m3-plus-pmu-events-v1-0-a8eb6c1139fe@gmail.com>
 <20261103-m3-plus-pmu-events-v1-4-a8eb6c1139fe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 10:25:42 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-m3-plus-pm=
u-events-v1-0-a8eb6c1139fe@gmail.com?part=3D4

