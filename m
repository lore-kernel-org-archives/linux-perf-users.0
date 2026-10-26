Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793049447;
	b=o4Y5YFkDjCJHbGgnuHRDtfik6+APdRZpwjl63VGMenyJ75xspCoxDQrH7PBN7dFSFmi1
	 pTDaUyUhfE2w0htxGmmkyKDhdpZA39k2SWJP3c+/6d+KBJlCCgXWTSmRt5ncH02+lOwUp
	 eU8BHl7UV/76t4huXAcZASrvcAFmFKmcejY+bWCdxbx2NxIqMPGq9dNoK/9rBVwvQb7J6
	 SrQcJ8V4XNXFgsPZGiSQrhYKcV6HXhCkcB08awL8pdXFZQrpYhiGviCqmCzQrlVTMYH10
	 bHBbzic9XWsgDT2wR/OLQ3Nog365EbHqNYvFp+OU8L/by1VICLaLJfR61RL/24C/byA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793049447;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KPPnkdZevXjtKnDAIUq5Tqwo/d0wH3uvu0Zoq/QkX4I=;
	b=KrpuJ4EX+L57YHPyYIVEksUwqq71/lWrdEmCt3i5iXnd1jt5amtpZxj3MOcTxtdG3hUa
	 WeRct1As1Q8K1fjlsdSZ2YLyqAsL78kv4o5uLIXEcmczQdMqCsVLivX+0b2Vet+fe7suD
	 MpLdZxLO6r2H4AwsAE/z9u77JIxkUTf0mWIzSCKupfUaODZWC5bRME2xowFWR9C1zJOeV
	 mAe2YCxhoPUWn+boL3rNdhxMdB56gNWxhZBbGfHCrp/SH1jKwYKJlEkAyLdCozytISeM7
	 dLFM/Yq7dUXFrcqYnn5UBE1oVUGeLOIKFlDi8O5o1G8MSNxQelZMawsW2QlVJDVrZVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ImUFPE3v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52A9606A31A
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 21:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ImUFPE3v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B471F01825;
	Mon, 26 Oct 2026 21:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793049446;
	bh=KPPnkdZevXjtKnDAIUq5Tqwo/d0wH3uvu0Zoq/QkX4I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ImUFPE3v61gjZpsczKx8WLR89/pDgQI1cgUbDUlvRohBtBq7zx9fHpU8WPTaTZ7ue
	 PGkgSsMinCF4HHisS7ABhPRM/hU0DF7zuBusR+zD52n0BC5fQjr1I0AQFEyAFSRWG+
	 FoFF0ck7PboNLZWaJDzIcM8sBs6EVo+AiG6uxpFSODsikmpKrcxco6FJHc3OjaSqzc
	 ndfu8gfD233eG77xczA3/4MYByCIHCQn88ZovLz1VgTqJ0zjWd32B2A6Zljq3+ArIq
	 VGCPyuX/yed64fbSEawzAO66SJd7/HxHSjv+hfEmloziWwB4qS3xXrjUovwcrjHvfN
	 WNB6AiCDN/JfA==
Message-ID: <sashiko-outbox-185746@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] ARM: dts: BCM5301X: Enable AXI PMUs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Fainelli" <florian.fainelli@broadcom.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OkFSTSBQTVUgUFJPRklMSU5HIEFORCBERUJVR0dJTkc=?= <linux-perf-users@vger.kernel.org>
In-Reply-To: <20261026211151.3212237-4-florian.fainelli@broadcom.com>
References: <20261026211151.3212237-1-florian.fainelli@broadcom.com>
 <20261026211151.3212237-4-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 21:17:25 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Describe the three BCM5301X AXI Trace Modules and enable them on the
> BCM5301X base DTS file.
>=20
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026211151.3212=
237-1-florian.fainelli@broadcom.com?part=3D3

