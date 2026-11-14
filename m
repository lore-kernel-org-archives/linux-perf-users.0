Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794700766;
	b=jJM7L0pMuwqdM4MESkEefNeSVE9i5mgA2wXYhPzH/zHON9qfE4LV+Wdtk0aTFvKkZGCT
	 ijJ9ed0WgXh+xObF3t3TQoPmivi+/+otfTHe+LR2MdENGP7JZjXeMuUJ5ypG3wUtre7DN
	 u1zW+kxgw6PBVRTofEVnnkcnhqeTD22sowZg44yxMLtwR0XgW0ZDIFoJ3PpJC7fGPII5p
	 wkA1eCKGo/j26bH7OufpwKm/1pYSWJ4ih4/qbwbUZV7mDu5DGpyGBIi1hNjnMd23ynt0/
	 SwfR1/JfzWURCZLfhX9KnyZyM1/9lwDsZTXHGoL3E5x9sA5CalC2zUq3WJfkUodqX7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794700766;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uErNuEp55qP6iAnBseZUuLnDcMhxncFdeUHbuml302k=;
	b=Pv0QUkZeL1gklx8msSYYp+RClOBYunHPYL41Lk1Ji6WGI4w7pd3nu2d6aJBM+lHQHf+L
	 3Wggt5tBniQc/kNE8mEJ3ioQUmsr9HKs2ME0fumidlyW0MsfJTWdy7xW0McAMSsFKHedY
	 xcSg4XIPqUF0qRYRLVd0DXtKEraaxJHYL4ufeEw6A8jSEWQwflJdIgol+hl72KqtNScLO
	 AMCNVZcZ+o51YBFu/2IRXCjQCql6CJGwzUMdSJgsdsS7rZKUP+wQSHNVr0WeO7xrc4U+M
	 jbiOuUbhQCUQbXkPfirlF/9V24A5ubY1Rn+kBodZs2QJ3Sq3b2/8iU7i2XTFsyT9lpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MvAQuE+P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C38606A339
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Nov 2026 23:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MvAQuE+P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71161F000C5;
	Sat, 14 Nov 2026 23:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794700766;
	bh=uErNuEp55qP6iAnBseZUuLnDcMhxncFdeUHbuml302k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MvAQuE+PSShpFH6XqE8/ZArwazNrI43OrI85KoEYtP3plBCGTv/T3r37ShQeY2Idb
	 Yoof+cIY/ZwwPjoALsVzzGoVd7CTIpXuUWGr3GLSKuIWb/Q5DPxhntniHigNZefA/g
	 apkmRJF7+zIXNYEFcAL2YUDBhhmOVAL5BSAGOxetakNN9EaeOq+aWGBCysxI739n1L
	 IR2vVnpyRXPjkrIxgSb+SME69Sqzwb1bkg/v/RQEyiz9FPJqAPHsq9XBhBkSIcZYX4
	 ruuiyh3bcPPnf8eRG/vbXDXy56i8ffo3Aq84L6kFTxpCYRtB2J9fC3jJpQe90Kd8L8
	 RTch6VmSDdykA==
Message-ID: <sashiko-outbox-215137@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] MIPS: perf: look up the PMU interrupt when it is
 requested
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261114233718.86520-2-rosenp@gmail.com>
References: <20261114233718.86520-1-rosenp@gmail.com>
 <20261114233718.86520-2-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 23:59:25 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> init_hw_perf_events() is an early_initcall and asks the platform for
> the counter overflow interrupt through get_c0_perfcount_int(). On
> ath79, that interrupt goes through the MISC interrupt controller, so
> the controller has to be initialized from IRQCHIP_DECLARE before the
> early initcalls, even though nothing else needs it that early.
>=20
> The interrupt is only requested when the first event is created. Look
> it up then, so that it can come from an interrupt controller probed as
> a platform driver. The boot message no longer prints the interrupt.
>=20
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114233718.8652=
0-1-rosenp@gmail.com?part=3D1

