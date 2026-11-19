Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795090878;
	b=bat2Db2Y2IRvzymL72rnTGw5XmWzldJ+9WfcDQ9ATaE4HufzWxMK4UDFcYITVfXBHxLO
	 1bKdK+5Hub3olBJXjPeZ178g1HGmhScZRxQeFYEV9yOljP5KYWWlQv/u1sE715Kk18CN4
	 k4cAN2dzVX0bMhTTLESus/UdPNNGzM69KHqBh2GXtP44kyYFkQ4BZ5ZFgNmmvMiyTMhCF
	 lIybW7S9ax0cIfvuhqJSU7b0b/H6EuafdKrU32QAhvw0fi9VKelIuQ3OAjaABiHVKqDx4
	 WMqlLanWTNgt8XDeqV8kEOdxbX/sI02cBJs/li4RwqHmnDa/2WH89bfXxY4q1P+lUcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795090878;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6I2YEC+fmW4iEolSGV4qHIegZa96hdiF4irktU55RsI=;
	b=H7bgGVjtpvxPKKfb3a3eXcZWNsmUr9hwbsBHhCjdsN+0MglnMjDgvtlS7snRISu9XIIQ
	 tkDsfNwVKp7u17D+j3YQUKmS4LP9oXX7qjR7vdVtiglcnoXOv4gEDWByfbViWih3zKJo/
	 kxBcE9CVHSuw4GQVlwP+ZI20hqqiN5x+sbgaRPKTSqJxunkSVsMk1HI47mcJ6/IBbmn8C
	 /fSuZVWQCNDijOdXa3EcqHuR2W9iSwTZKhrGZmXsxp85ueloRBqZuCEGadzotABKvBxEc
	 hMUKFfnaTclmGG9Ayxp2J5QKZDNScVB5RPlEbd0lG7Qv/fQuv16wkzJFxAyZe4gQa+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VqZHCrwo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1BB606A32A
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 12:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VqZHCrwo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45FF01F000C4;
	Thu, 19 Nov 2026 12:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795090878;
	bh=6I2YEC+fmW4iEolSGV4qHIegZa96hdiF4irktU55RsI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VqZHCrwoH9M6YbmqVwwpzSlUtxNtlEqEmHOKSQiDpUzE+HcM1l3brnuyMHMfFcYH+
	 wnKz1hNrEK3+7ogW7QURww0JKvi3R71a4jIxsTDwvlH1ttUF4sxpofQxqPdkqP6Vz0
	 9gP3QTmazotp98z+W2W8t2pUjlWKIdqzCUe7kjnz1Rg0IfejbHaTDjVJamf8GA/wtN
	 AmX9Uwkoqt1TYpH2/aLHzNvSG7+sx8CBLKR0zkKhkaI4ywvQBYsK3Vb7jX07Daklhc
	 2LvyTynQllbD3m7bGPcC1Bf3/oapDh+J6oJYblW3S+KJwm2mzpqyUWXFhrdWAFlt0t
	 3VXQw0sECvLeg==
Message-ID: <sashiko-outbox-223080@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 06/11] riscv: enable NMI-safe lockdep irqflags
 tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119120824.13969-19-zhangzhanpeng.jasper@bytedance.com>
References: <20261119120824.13969-13-zhangzhanpeng.jasper@bytedance.com>
 <20261119120824.13969-19-zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 12:21:17 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> An SSE handler runs with interrupts masked, but can interrupt code whose
> lockdep hardirq state is enabled. Bare nmi_enter()/nmi_exit() do not
> update that state. Consequently, lockdep_assert_irqs_disabled() in the
> perf overflow path can report a warning despite interrupts being masked.
>=20
> Select TRACE_IRQFLAGS_NMI_SUPPORT so lockdep can update its hardirq state
> inside an NMI. Pair this with irqentry_nmi_enter()/irqentry_nmi_exit() in
> the SSE wrapper: these helpers save the previous tracked state, mark
> interrupts disabled on entry and restore the tracked state on exit.
> Selecting the configuration option alone does not perform those updates.
> This follows the entry helpers used by the other RISC-V NMI-like traps.
>=20
> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119120824.1396=
9-13-zhangzhanpeng.jasper@bytedance.com?part=3D6

