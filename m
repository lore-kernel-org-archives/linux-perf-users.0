Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD85392C4B
	for <linux-perf-users@vger.kernel.org>; Sun, 11 Oct 2026 23:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791761988; cv=none; b=GNhr9dExCQ7eh4zD3ly2MOvmbRBZ0LkkJYNT/sxASnH0hwaaLIAg3RF2fhPIBi1I9VPoxf5T8UY523l9BpHcEj/YXwW2N6bXkEzZ5IgQjgg/QKhGq6q+2heHYSA6VFveqYknL6fAaALgqxNceWItlvhRC75NhzbpG6G3jlm8H3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791761988; c=relaxed/simple;
	bh=1SWVX731S0ZME3Cx7S+anJL+Ni/3Pb+BUnhmp0pgc9U=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=IF6uXTGffK/o5rwJYogz3HL/VYfmqkJL2XomssI5ErBgHJc1Lzsm+T6GnmKxglpuF6k7+01X6EBCwyrL5JGQOEtpwrVb2ZliGfPJ6Agzf37+SisFJ5NaalRDByH2uJ0AxrRNLWqgu8yPtSxDj4TwaGf+euPK/LfB3Y8NAsfbCkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A55QtlIc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A55QtlIc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40481F0089B;
	Sun, 11 Oct 2026 23:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791761987;
	bh=1SWVX731S0ZME3Cx7S+anJL+Ni/3Pb+BUnhmp0pgc9U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A55QtlIcdhYs0pURtnZlPg2D2XuumnTFfSGdGru+eE3UpEDiSMhaxDWMmav2YIo91
	 nQIpNTI36x81leibP+3Dv/07aZ2lLYWbimnk/LBbdi3ITYq73ISuXij/jahAA3cZqB
	 z6bIFBwxVoeGVikqAtNf66y/xg4kJiBW6i3e6hWbi5F73bITOGyvv4aJrJ1jYn1NGK
	 q5hrnOughcuKcTgSq1hB/2+mDUzFk1UawWQTXCiqDGbtTna5DQ4L3BvS0qrJy3unK+
	 zEQLspRFFJJNtTChO3vqmw9WexovkZ0shdH1SMoqym+brTfMy4YHQKggErDFFmwE3Z
	 VTvfcVUn9sRlw==
Message-ID: <sashiko-outbox-167518@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/6] kbuild: factor the userspace ABI flags out into
 KBUILD_USERABI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261011233647.2454648-2-sashal@kernel.org>
References: <20261011233647.2454648-1-sashal@kernel.org>
 <20261011233647.2454648-2-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 23:39:46 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> KBUILD_USERCFLAGS and KBUILD_USERLDFLAGS pick up the flags that select
> the target ABI for userspace programs: --target=3D under clang, -m32/-m64,
> or CONFIG_ARCH_USERFLAGS. Collect those in KBUILD_USERABI and export it,
> so programs built outside of kbuild's userprogs can be compiled for the
> same ABI without also inheriting kbuild's warning and language flags.
>=20
> No functional change: KBUILD_USERCFLAGS and KBUILD_USERLDFLAGS keep the
> same value.
>=20
> Assisted-by: LLM
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011233647.2454=
648-1-sashal@kernel.org?part=3D1

