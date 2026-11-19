Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795090485;
	b=uPBul9/z9330WtG4g9ByR1myIPw8OFP7QRsdMIhI95E92eO8ql8OdNBTKbW1wytgCY9p
	 /CYoVAgZ2LextUaIFfKoZFnU76yNj+/bZrvoW3MFADEIHQ3UpcMlQs0odVpSkjKicwknv
	 CjkjShucPHf7JMyloIGGFUwxgcxIPpBcSo1jx+PSgPMvlYWnyEfPFpZRDGkZZE0lwx14A
	 BEixwEQW66dRHp6FrbNLfrNHHNu1/vm9fOzCRCG5AhfVFRJegpQopwfOkugMTMS9o6XQC
	 JP4gZK/lfWk9yIyQp98U4IBq87AGzFzVWvlsKHxilGZcUe3ohTuEWF4agMYvaq1YaIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795090485;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4xoNPNQqc1B1A6xzu4SQ7ag1X5QPYk2t73GVJamXLtY=;
	b=gImNFdfHF8uWjSbMo4xWhkQtGvM5KDYHg0yRS9jMUEaoLwMQ6TaBU+OxgTlUilJwLQBT
	 oRKn5R5/X8i98JOzGoY2sVlGUzmi9W8LyrXrt/BraiKcLAh1DCAYo+Ny6+2aOMrlOYS3K
	 ITwJQf7Ed3xSPpb9injXXh4lAiu4Pj67yVejaTTy0cKYFQo0uUdUgaeTth4y46nGoW+kY
	 JZ2raU7/rOKBXYsPeFsCXRtbSPbLWS9vcxtyLlEJXXNTKxjp3eXZtBotNIrxlJC4jiM/U
	 eu6JOP43N2/ttMYqTitaDITwmCRAueg0U1Wi4ueMuQ/SL8hBrcY4gI+re7Y8b6J23bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TG8x7+A6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426D1606A320
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 12:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TG8x7+A6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52201F000C4;
	Thu, 19 Nov 2026 12:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795090484;
	bh=4xoNPNQqc1B1A6xzu4SQ7ag1X5QPYk2t73GVJamXLtY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TG8x7+A6jgCbnIONHyKPWb4MtDUywZKTGfUo9EvuAffbjwn0Vur7JAVu5uR1dF7TE
	 1Ss+DBPjgrqqkUhmhYs5z2zPtpeyHwk/pASjgpcEY2Jg7HYSviZEtmuI5w0Kc/Juqs
	 bPskG5wxFMHoRspKvR7Zvgv/6Oa7xvldtDUr+0fjkejCeuV4w52P6GkKF8MVVmmlKk
	 cpwsQbOKnPmxcOO2oesgMmhKdQZEFdTU50vHD5q+lq3VBoTxVQPP/2XNWTR41zOp2S
	 hZrQtEysCgMUptbkYKdjW6r0aa/PFgueKqZNTjxKt3qAzX2desshiJ6CuG9vD6OMdt
	 ynQcW1LXPq55A==
Message-ID: <sashiko-outbox-223077@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 01/11] riscv: add SBI SSE extension definitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119120824.13969-14-zhangzhanpeng.jasper@bytedance.com>
References: <20261119120824.13969-13-zhangzhanpeng.jasper@bytedance.com>
 <20261119120824.13969-14-zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 12:14:44 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
>=20
> Add definitions for the SBI Supervisor Software Events extension [1].
> This extension enables the SBI to inject events into supervisor software
> much like ARM SDEI.
>=20
> [1] https://lists.riscv.org/g/tech-prs/message/515
>=20
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> Co-developed-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> Co-developed-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119120824.1396=
9-13-zhangzhanpeng.jasper@bytedance.com?part=3D1

