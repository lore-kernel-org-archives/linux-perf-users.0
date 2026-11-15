Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794703454;
	b=o03wQ5VY04lNUlWx7SPJGSG1h3EyobBjSTdK/ePW5CbbwjoskX7d66Py+b9Y8u1t6i7I
	 gJ/I912a4gW13ltbRIj3cwkiDt4US+gktm1oWPCdBK5oRH1jLcZyAYViIL3Db6WP7sXHf
	 NfD7bXKe9FvtjOnoQyQfe+7if0L4oeEq5hZlm3bBsEC7+iMbzKT5d+AsnwkF9M63g/gpD
	 qMo7AvAQCZqjM2gcTXxVBKxmNCTeaGvv7b8+FNadz/mxintifkvudNiT1LREoYPqHLYEF
	 OL4qMuLoREl4m7qkOLjHyZrhOJeB0N5IKKxGFcECzMUkI9wLFoyRNNQZ8MS5HQhMRhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794703454;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=z7HhpQamuub5YLnLij5WOOoC8x46kSgM5HO1XNe9+lc=;
	b=wiZ6jHoBrVjqP0p6drhFWn4TSSzaF2fecGhMgxrzW5dA5y+4iBrEx0YMUn7z6zsRotrM
	 d1y1ugRZ+woZ4Ddl84/moFudK157ITcAKfnR8TZ82ekyY89+ejwk7m72RdZGLIpLYXY/U
	 /S2siLFo0e7PfcpJawJR1CrwU3ab7LBqDwPPxfUjBHInKGNFq25qsC2CMGvmOB4OEdQtx
	 O5KegXh+D92EAqVBDb0kVCD2m4adk3IEwxKT32h60Cgi/80M1WRNZFRc/1+c5M63KEug8
	 DqZk6hs7LPsWV8o+AsDuKi909U2ETqeWjtUNs46DuYI3Abt5b4GvXx4HyPFI8S0/Y6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NEXrnk96;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169E9606A329
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 00:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NEXrnk96
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF8C1F000C4;
	Sun, 15 Nov 2026 00:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794703453;
	bh=z7HhpQamuub5YLnLij5WOOoC8x46kSgM5HO1XNe9+lc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NEXrnk96vsYr3tHqCH1zCB7RnoDkELdo8fGPHlAl/XH+ny1fnC2S0hhKw+2jWjAUY
	 9OKQA+YSk1s/MsJJCN4hcnp4bIxMj40x8ek5Xmo5mq32yizr1Malrkwj5NBVxVcVHJ
	 cZXlkiqstYIvL3JSG1XZSGQ4X8Ewr7ZFV5ppGOlRNFOoR0OdMjTvuX1PI3BRYYo7EL
	 EGFKMKuER9GQYJhy2n6iB1qz2LDiG+PHzHY0AQukiYwFuadjNq93gOuB/invdqqlqu
	 OLQAEcEA86zDUUsGW+QqfhHfbXxTzER9k7J2D2WePS4IeCrfvz7tQ+gFknkS0apLte
	 gRBC+xyH1/0DQ==
Message-ID: <sashiko-outbox-215155@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] perf python: Add clockid attribute to session
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lalit Maganti" <lalitmaganti@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261115003916.1873857-3-lalitmaganti@gmail.com>
References: <20261115003916.1873857-1-lalitmaganti@gmail.com>
 <20261115003916.1873857-3-lalitmaganti@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 00:44:13 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> With perf record -k/--clockid, sample times come from the given clock
> instead of the perf clock, and the clock is saved in the perf.data
> header. perf.session doesn't expose it, so a script can't tell which
> clock its timestamps are in.
>=20
> Add a "clockid" attribute with the clockid_t from the header, or None
> if the default perf clock was used.
>=20
> Assisted-by: LLM
> Signed-off-by: Lalit Maganti <lalitmaganti@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115003916.1873=
857-1-lalitmaganti@gmail.com?part=3D2

