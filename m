Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672001;
	b=yILzgRRdbDROCl+q6AP6irkfqkwh4iUk7FDiYXFxiroujIjBuLlNUjGSvH7Vsaf8HCBS
	 mZqz9wBJmNflkIwU4bLYs77lPoRJvIsNo/vbcumiu1Xw40UhcEsuvhcxDZjrsXPsGn2rd
	 magA2QrrzmNoXkwyQNc1dZSaQgwBbLj8NesyiQnvQ4sNeJx/OOa2A76IqDnNIiofGtWhL
	 NheFTdGO0p26q8xwpe+u8+8xlr2ePd8lsGDdOMHbXuzt4bCPSPjgizXgydv2Zf9Rsb4fB
	 GS5UlvmE1Skagxd5i3WJfu+QbkV3yEg23X+4yBCPm6DGpOHxaUh5R84xRKFg56UBTfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672001;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZtSdhFTuTjw24aSCWIGnCCfG0xvtx+UD26snZ+mZ+TE=;
	b=YdU9oGUiVtwm8AseQ2ZKZ4L1mKc2CCWfxHnh3huRjT/ZSZa/wMxNbsy/wnMJaBoYP4/S
	 bmZPdQPvYIwxxhD7CYFKYitfYJDBvoCXMP0/IldHootP+KCcDh+zCJ2pjWyOgxXOub7Tx
	 GDXKZw/Vs9ECaObyxJVmrc625EnW2/DuR72NHciOOZTqvYfAzigHc4wlJUmk5tgshAvjF
	 hCC7TLAdLy2HCaLV8bpw/txQTuAAtfdSR78fOgKn+itWI1zfxLnpXDaVWsvP5NbGkq5qK
	 VorTCRuqka37Q2a8BXYJuzaV3FUHEDz3no4/sVJvBraO6sS/fN7qhBi1o6/lcsNfggQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mIzBfQFk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F62606A324
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 02:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mIzBfQFk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108FA1F000C1;
	Tue,  3 Nov 2026 02:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793672001;
	bh=ZtSdhFTuTjw24aSCWIGnCCfG0xvtx+UD26snZ+mZ+TE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mIzBfQFkhdqXrExMZr8QORTKhSU4nrVhMcSKiKiyo3kalWqK0PPHEjFabOYATIOqD
	 TEA+FzMHaNWFOu+WwUDTlHRL4M0gjFb/La3TthbPH/YR4sE6q8EmePr02HcNrew1EL
	 Zhesgnce4jFyLLqlactmdEjmHoczTfmUMRR6tblvGgB/xnjCjkApxri84bAKByjeZA
	 d3ozyyA27tAW7yvGC6ENGj3g+uwbhjMXwtx/7/07Pb45gcaN9G5EBjPMgcW08ofy3i
	 qE8IpaIuk/IOaVW8gcbGA8+YE94w83UAeOMGSUvqXuRP9+aNqywQDsQOUVrdXe/2+k
	 FhwmDOE/3dNeA==
Message-ID: <sashiko-outbox-194449@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/7] kbuild: factor the userspace ABI flags out into
 KBUILD_USERABI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102021253.2545235-2-sashal@kernel.org>
References: <20261102021253.2545235-1-sashal@kernel.org>
 <20261102021253.2545235-2-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 02:13:20 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> KBUILD_USERCFLAGS and KBUILD_USERLDFLAGS pick up the flags that select
> the target ABI for userspace programs: --target=3D under clang, -m32/-m64,
> or CONFIG_ARCH_USERFLAGS. Collect those in KBUILD_USERABI and export it,
> so programs built outside of kbuild's userprogs can be compiled for the
> same ABI without also inheriting kbuild's warning and language flags.
>=20
> No functional change: KBUILD_USERCFLAGS and KBUILD_USERLDFLAGS keep the
> same value.
>=20
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102021253.2545=
235-1-sashal@kernel.org?part=3D1

