Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794699936;
	b=0DEXdS+xO9MONGCe5bEFUS7stMaQD0iypDFh/5qoaOgR2e84s7pMONQ3cYiU+QtH2cPz
	 YUSBexO9hPjJvrmlAXrrL1C+1oHNpvpybn2Q5NWQWUpu95ZDTUzAnViPu1ZSS7Z/Uw/5a
	 QESfrVbJLg7Cywl6ayzJYwoPA5VvPmE2yLvdLQlO7J4+2vXjw2ILK3AM0ecE31zAqB/M8
	 +OIU2EEkvWFJrzR6tp5TsxS2241K0+txIeuMnT0Ha1GQ4pGEM29r9rlSQ1h0hNTVNpOP5
	 XzX81EIhXlIEgVzvZitFF9yW4qr4Z/fxvJNEhAn0riV/aU5GXmYXbVGQyIZAHpRR95Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794699936;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gg0lMX6i8NZ4aq+nASwQQjKb6bZwdDHlhGUGQJ0PWAw=;
	b=TKZzHNcfBoiwTpNzGVZG6N7qb+xRJ3dKFnHphCA4xFG+sKt24mMMif8Cymsp0Ahw2qLN
	 R8fg71AA9me1fFWCQAdNPPzyAjfXxwib8x5AL1MT8TA5l9ze9yaEwufDJ3zxVTRb576v0
	 tK4npgC7Id21D9R17PC1LheWsWwrFnLMhaEtHGT5NPTqYVMLL49BSMn6FlwJFJmFsW+zN
	 /k+NPbw2/sPxIbVrEuQcRSifFNSr/5rE2DjypdJLfgODaSTVBrw0hje0SmIudBbDIOvYy
	 TMERY6lbtBxGVJ4SYTNubGcw5nBa3PyPINnjiBxNVrn0vM+vpn1WNuHdSAkUZqDAigQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="beZE04/z";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29923606A329
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Nov 2026 23:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=beZE04/z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13F81F000C4;
	Sat, 14 Nov 2026 23:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794699936;
	bh=gg0lMX6i8NZ4aq+nASwQQjKb6bZwdDHlhGUGQJ0PWAw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=beZE04/z4MUz7IR7DgCMehvtGUZY+dslXKkiYiWztMoofbmS+NYzp9BQw6denTBrI
	 9TpnfFgMOMIPDeWoyet9t7R1vGbWcCPGgRxJOrffVa7rQW9q31xoVbuI9wtPn7hnHK
	 YPDpPIXkq6uxwvUnukmEVtmiE5yphG5B1wI/S5Gav9/fTh4yTii1aRl5Q/xb5tH0xX
	 Um73KGQV9VGvD0KimWwk/zuvdxU6GgKfRp72fIsuu6wLL/BS+/HlK5FZ9ZeboJqGT3
	 SRkAZgtlSOEGFc6RZRx9aPJSFB9e6uXlgbRFgHcVLvUoroVWGY9whIIZ5o6PsNFlj6
	 e835aSdut9QRg==
Message-ID: <sashiko-outbox-215123@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] irqchip/ath79-misc: map the performance counter
 interrupt on demand
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261114233718.86520-3-rosenp@gmail.com>
References: <20261114233718.86520-1-rosenp@gmail.com>
 <20261114233718.86520-3-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 23:45:35 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The MIPS perf code now asks for the counter overflow interrupt when the
> first event is created, instead of from an early_initcall. Create the
> mapping in get_c0_perfcount_int() then, instead of when the controller
> is initialized, so that the controller no longer has to be ready before
> the early initcalls.
>=20
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114233718.8652=
0-1-rosenp@gmail.com?part=3D2

