Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048840;
	b=xWkH6HNLj+Q26J52JIyIVx94JuI1JpzUuEjBvxAee449BtEWmv/LaDV8/+rRoWpNMFlm
	 fWHH0k6SbQzErLFO2iUf+lYZtdcUXYvtrBKJDdMQkqChIdw6e+aA8bHzAfdTUszXb8oMe
	 KjyiP0VtPl0LEZMqr6/6igdn9DzaM8toodQHUTBTs3QJm/Bxw53XQGGC2b50EWZTTqR8i
	 TkFjtxQGN0JYJoxUaPpI4ndjBcP3APfoUDKJ+rVT/KcAQ2l4Bdmwqfcyn8GnpiSkR5sKO
	 wIQ45hnVM/fr6YJxhKCh8Iuq8emZIZXo2/ACmxgoO2HxXjpY+h3M99vjNrourqmkojg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048840;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vwSyQnil98sPSV6KhKz8eevM6zq8r0XSvryPOBRBht0=;
	b=PChfGPqt2lOxkI3wM9TdpwkMV5K2DfwSw0jvuII51XtyTRwcDevr6zF7ol+phpK9SK/O
	 Du6TItmOMG9UQaWv9jiExeIyiyVZ4+vKpqB2FhmEHGRQZj593VavcbXCURA2V9qEQFwj0
	 reuMwmY/OFlEPXKDG58g04JVrRIUACraSMPj/u7SLshY9gTraYBN3HntMDU0PH3XVARHE
	 p0A0p2gW5wTokAxpl80ahYVOK3Md0TpL8DBni1YAy+BiyfexQgG893IvSIg2v5K8FZCXh
	 0/JGWBMuTjq3wCFc8iFELTovj7WrMUYXuHq3FH0pyYex3dw/bQa64iqisEyw9UvO7Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mr0h2ZXE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5ED606A32D
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Nov 2026 10:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mr0h2ZXE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13361F0089F;
	Sat,  7 Nov 2026 10:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048840;
	bh=vwSyQnil98sPSV6KhKz8eevM6zq8r0XSvryPOBRBht0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mr0h2ZXEWLG0/Tbxm0Gr3sIzznfJ+pTxV11F8EBoTJP6DB1IfOBud847Jk9sw1c+x
	 aqf1lq8cQI7QX3KY9lRF0Fn1LveKp1DxdwLWU/cu3lBTFBjXjzlpMC/MUQGCVeuLbt
	 4LzfBEIs/txWQ4RyetIe19lfID691V7dalqzaKRtBM5+EA8ykpQ7ZsiBr7NjaEldXz
	 bW3ImYNAKF2q/OnCwDCRWFB3545rd4xjgzsnoH7A7/94+oEIK5/vmzTs639zT7ymo7
	 YxEY+WBZh71kS1Iri1cOxVrRt3lAa6k336MmY0hEjuQJ2PuzF5BHXMD7SAHcFMkist
	 H2VySqif0jrPA==
Message-ID: <sashiko-outbox-202828@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/15] drivers/perf: apple_m1: Add Apple M3 Series
 Support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myria Sarvay" <myrialsarvay@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261107-m3-plus-pmu-events-v2-6-acf1e78da039@gmail.com>
References: <20261107-m3-plus-pmu-events-v2-0-acf1e78da039@gmail.com>
 <20261107-m3-plus-pmu-events-v2-6-acf1e78da039@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 10:53:59 +0000
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
> Add support for the CPU PMU in the M3 Series chips. These events are
> encoded with 16 bits, and similar events have different codes when
> compared to the M1.
>=20
> Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107-m3-plus-pm=
u-events-v2-0-acf1e78da039@gmail.com?part=3D6

