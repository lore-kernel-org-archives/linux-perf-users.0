Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793275153;
	b=ZNyniOML4bg40GXO6/yfKYUe00hOHHJx9p+laV+oDNAEPkxBZ68yjnUVbYFKBlb8/vDS
	 UM/zAToeGqV+RGiumXq4BRWPcH33s+Rt+9THmbxFlGJZiu/SRDR0OczX7GvdPnTtlelJL
	 Q5YcIVrGqYjoiYyqOpNd+a9/q9HeUDNtlq3YlTBkNJlqGrJAPyn88MGgp+P5UR+4pEtNs
	 qiziEsznilgddS9/ikXcCBgoQ53D/zjkUM2aJKHnyB+rhmlxUzP7rID8CZyj5hLvPxrq4
	 60cOlhVCocNwQlQmVcDPdm6dV7VaQzdl9AHkdmMP/yjtuelqN9Hg/MVCuEYzZoxkb3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793275153;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QI8so9qSxJrsx2RpsUT04KCWtAzJ8OHxf+R852NEJxE=;
	b=KPAHRR13Iy0khSLqIoyFExtftE3GlD227Tkzsri4xXNM5H4Ve+Lui8q2vN0a8Zdi04xt
	 pesktaGvCwRtUvMF8PY9+hYgdZ6k46nZSkN1V5r0uFAVHIFXMAWvnaAGOYfo7V3ifuJ63
	 DpPa14DC3Mvtl8hl6okNX5OSoGFdpcmRACBa9+EFEGxLMGoprtY6yiM2s3rEtKR2P+Bhm
	 6o3SCyqSdizpZ9YvNMKMdC73jzAfVQwQCdbrAb+gDd1jVL9Io4kbQ2ntBmmlisJMumdUE
	 XpPIAEo0xuyibjiv4P4qUvcUxUutfGIdP2Do0Cys/QXXOIT1lu6BYWi3KUT4+JEGLGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eheNR+Ys;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0496606A31C
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 11:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eheNR+Ys
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23BD81F01825;
	Thu, 29 Oct 2026 11:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793275152;
	bh=QI8so9qSxJrsx2RpsUT04KCWtAzJ8OHxf+R852NEJxE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eheNR+YsfUYzOiAw6Sa1vEkdRnRVtA0FE6DrD8atcNiQb6ukqTJe/MmEW0M3mdleN
	 GVuBgKjmpAr3ahTkgFdTEjLD/7gpDdKEqxQZ1ZEjIgK0yXg8QXrX+WGtWEJcc1Dyr2
	 fFxyv4kHTW77PXVG9djepqw0s/YW3Ant6yfrmpcVeXlD9hVct18yPWlD3mQsggUurz
	 0Ga8OcOl08yWovH5Sh8GWFheeH5mCSJM2raxnpDqzWwd5Hd36JzTm8Neu/S4sCSy8N
	 ClxIQvaG7HHYMUotDuwKaBuvVeepEQl3+a3V0wypTNAXgvkOzWFIgh/kmFUw2TW2Ss
	 8DShRzl9gEhqg==
Message-ID: <sashiko-outbox-189226@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 06/11] riscv: enable NMI-safe lockdep irqflags
 tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261029074853.35467-7-zhangzhanpeng.jasper@bytedance.com>
References: <20261029074853.35467-1-zhangzhanpeng.jasper@bytedance.com>
 <20261029074853.35467-7-zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 11:59:11 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029074853.3546=
7-1-zhangzhanpeng.jasper@bytedance.com?part=3D6

