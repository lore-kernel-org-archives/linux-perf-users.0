Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794700053;
	b=S55qfeHQ/La3nVq/83T0Qipg0mG3Hb7m5U4EWcHa/qYTBvhCjfscSXXcCg00dxe9wPiM
	 A1w4oA1rTv9ou6dlehFQ/twEgGvEdn5ZxV8z02Eg9DeD0mBk4aBpRmKuF6C/67zEKWg37
	 z8OabByOz8Ncvrug6cIGuxRGoEg78RCj64Ws7Ui7NgPZ04IrL9EMU8s9plDqyS4GfFHlR
	 Emi27r7/0DDS+LTyOeW+UKbsALQqVl3uEl0UYhSR/biLlKBUyG7I4qqArhIEchX21Iv+S
	 Jfxk9EvqvR5XdMzGkktt3MQa4s5Bipv2iUwzi/KBku4TO1Dk5K1z6if/YN7wdfIx6+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794700053;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=C3MYjIvgEBeFTxBo0PIXq/HuFLQTTwxnJJBJa/M3Hu8=;
	b=o6Q7/YHkYbBwvxQSBuukvOvlZ5wrgkEBJ6AY9T/0ilkcBrBYJxkTwG4f7/oWzo1XEO3E
	 gXFaSayC/ETwysle1L+ajKwmrcW6TfO4UxpzrYeweonBMIjRcslZBKhoINnDW/c8+982Z
	 ZySniGoMK3nx8hR3Belx8RLyNmeu48xUQVLr2KDDaks6/thY+8P4STQkI7vARWuxujdAa
	 lwefTsI06Zd7Mws9ML2SuKExpHt1WCZT7uTkLhiJuNreEFmkjQfz887i7MEDK4UI0uX1Z
	 5ZrBj41yf13hJPj5gTgk5Sby1Y7YUKKoSGSxnW1XnNeb5JZrBuK+Wu1msy7kKcJGiuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BKayzmyk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE19606A327
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Nov 2026 23:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BKayzmyk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D234A1F000C4;
	Sat, 14 Nov 2026 23:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794700053;
	bh=C3MYjIvgEBeFTxBo0PIXq/HuFLQTTwxnJJBJa/M3Hu8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BKayzmykzgcX67loRI3AJeuFkuuNBeYOGn9QrD/be3Ex7D3FRP6fSxH3LbT07kVYF
	 sIm6TzG38iuDfJquko+S6o7lyl6AZHCLoSho2KIxi2ZshghkX5uaVA78ocRca35gik
	 4ztgtGxPVQcwfMjfCoVMHL0pARj0nVDwQRKBm3Tdw63T3fL+HeDEZ6YBEX5FZem9KC
	 qEPZb4JHaukiFuXvIqMDTW8SUFGK3ZzgS0Dc4VaktkyI5RwyCD9grifjSbql5/N6aK
	 IxgOSFWVUgkKjOSeJTfMdGRZZlO15wpDwNoKmmugR1I+4YK6tEa14e9OPhLafTaDMr
	 vD20LKkGHgGEA==
Message-ID: <sashiko-outbox-215126@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] irqchip/ath79-misc: convert to a platform driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261114233718.86520-4-rosenp@gmail.com>
References: <20261114233718.86520-1-rosenp@gmail.com>
 <20261114233718.86520-4-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 23:47:32 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The MISC interrupt controller is cascaded from a CPU interrupt, and its
> users are all platform devices, which defer their probe until it is
> available. The performance counter interrupt, the only one needed
> before the early initcalls, is now mapped on demand.
>=20
> Probe the controller as a platform driver, and use device-managed
> resources, which also fixes the leak of the register mapping when the
> irq domain cannot be created.
>=20
> The driver now probes after plat_time_init(), which on QCA956x and
> TP9343 enables the MIPS timer interrupt in the MISC controller, without
> which there are no jiffies. Keep that enable bit when disabling the
> other interrupts, which leaves the register as it was with the old init
> order.
>=20
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114233718.8652=
0-1-rosenp@gmail.com?part=3D3

