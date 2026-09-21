Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2633C9426
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 11:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789990467; cv=none; b=e6BEFiihpxxPwbLMfdBpXJ5ngZIrd+fLqvWU12z3RqkEw7PiTuqRtNuDlkSPSOy0E2Z5hQnExs2acYifyD7XZM/EVRpq6vdHHto32nEkQ6Pgu8vmPm45q90wF8MwJfnpWwRmbWHx0gZx0cUMe+sU5H+xSvJmLtqBwMDPvHb5Jwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789990467; c=relaxed/simple;
	bh=pDohhZBOdkDuB3SO8uiphChnAypbedYnPuVuCQC/RfM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HEM+FJMziAb3p10m3b7YFCQunq3bj7FljL7GGqDxlwhvuMwtg3sad4dyHP6LlRykujQqGQu3RVaMfUJs8iRjKijstZUHf9MFMv0D7Jmcw75epp5NLXW7YcfqIp1xa19X+ndA2ohR6odyh0lnPRPRMVb49FfN2t8n8L2DeBfcwbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9n6HhGA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9n6HhGA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDEBD1F000FF;
	Mon, 21 Sep 2026 11:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789990466;
	bh=pDohhZBOdkDuB3SO8uiphChnAypbedYnPuVuCQC/RfM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A9n6HhGAVSs+8XTNd85Yh1HEM4L1F1Aua9FNuopU5YZ13/a83oWTSLoPuXHIhWt+W
	 EJD3xxg/NbPxrsBaYTvObEsWdx/09XHvH6Dh/da1T4N5ufs9vaF64gmleWdaP7zJI/
	 TCa/xeaA49L8187L9zxLAIDax6o3rXlpe3nK8cnuU2OuCwf288FKhfiLnnCIrE9s8B
	 OWMbjFj//DL+rUaBwNi0dfx5uOUdBaQzRLGJP80OD4/eTF2qbbDhpVyCckoCwQgyJn
	 3TmYCJHzP+souDDOoMG2uVZy684NRlo8DldfLOrLPxxu+mye7INVvk1DLicFzuYGC1
	 QAceDyovAtiFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 RESEND 4/9] drivers: firmware: add riscv SSE support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <af6bf140f2bf97a85bed00f0cb6603bc220b5b0d.1789974241.git.zhangzhanpeng.jasper@bytedance.com>
References: <cover.1789974241.git.zhangzhanpeng.jasper@bytedance.com>
 <af6bf140f2bf97a85bed00f0cb6603bc220b5b0d.1789974241.git.zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 11:34:25 +0000
Message-Id: <20260921113425.DDEBD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
>=20
> Add a driver-level interface for RISC-V SSE. Linux clients can register
> handlers, select a target CPU for global events, and enable, disable or
> unregister events. The architecture entry wrapper completes an event after
> the registered handler returns. PMU and GHES drivers can use this
> interface.
>=20
> Represent global events with one firmware registration and local events
> with one registration per possible CPU. Keep registration and enable state
> stable across CPU hotplug, and validate firmware-provided hart IDs before
> converting them to Linux CPU IDs. Use phys_addr_t for attribute buffers to
> match the physical addresses passed to firmware. Require MMU support
> because the current event-stack implementation relies on vmapped memory a=
nd
> TLB synchronization.
> [ ... ]
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> Co-developed-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> Co-developed-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789974241.gi=
t.zhangzhanpeng.jasper@bytedance.com?part=3D4

