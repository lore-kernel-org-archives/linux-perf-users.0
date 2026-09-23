Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC868332909
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 16:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790179778; cv=none; b=UkLfAmVdL86f02p3jgMYfe/Sdf18dXUsQ6GyfjdjsBOIDwscLvX9aft7wsoxX/T8gE4bdA7Iyt8PxEWOL8DVfTJ18XiMb4C4cAIWjeQYKg3R1gFKds4EqUxwUJhzs6qyjF1M7mOpz/K1O7HWIpiigBhw1u+/g5Ll+v+tx+OOkRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790179778; c=relaxed/simple;
	bh=O5ItQFMkBxUBFmaFEAY7EojvELGxaZ7yLmfUTyR0JOk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FUkWFkOyzrNqQdFoifpyWxQExzvZMBjQQFVEj0KPul8BRRiJx8jvrB9JWxTC3+WXMIOm9BKrw32oy0c9mUngOYKCPEAgwDqHZzXDFiJPQ3ms7/ku1T2Wcxro1cxOXJdau5ARCGA5XzBTJcsqXlY5P42zB/y4fNVdzEaI9fYU0h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OziWQBe6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OziWQBe6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2651F000FF;
	Wed, 23 Sep 2026 16:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790179777;
	bh=BvoQ+BpQ6E3ILNAQWplJHdoCzm+srtVyQOEv9eeehMA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OziWQBe6B1+Xki+XqSabBpap+B83dYnEztjVc+Ey6TGvcNTvaVmqeXZgqZavbQ3bm
	 TdixyGosQmg20ThxkdsoZvTFWWyBZYQnXlEuyw2xChPBzYS76Vny1AHw9UBNVb2Yks
	 Vrny7hvXDMUNth/NksP4J4loxdi7Sk9k022jvib2o7gG7zyAwwdusEssCy6k2aUxpV
	 d+E9q8tLHHk6wamTewc/ILwLRpPp6RJ+l279gxYjGNghYzojZs4ymkXZxzYD5133i4
	 Ye9nA3xoHom3AMxTjzDCzypThKNeOO8fzP/7Rj+NSiIs7ImxEx7d7pdW5pbAkRoVuY
	 lJF7yjyioVZIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/14] perf cs-etm: Mark branches that were not taken
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923-perf_cs_etm_fix_non_taken-v2-6-6ab8c07a5455@arm.com>
References: <20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com>
 <20260923-perf_cs_etm_fix_non_taken-v2-6-6ab8c07a5455@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 16:09:36 +0000
Message-Id: <20260923160937.1D2651F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> An exception can transfer execution to the kernel after any instruction.
> When this creates a trace boundary, perf may attribute the trace-end
> sample to the last instruction in the range. If that instruction is an
> untaken branch, reporting only its branch type can make the transfer look
> like a taken branch.
>=20
> Set PERF_IP_FLAG_NOT_TAKEN for branch ranges when
> last_instr_taken_branch is false. This records the decoded branch
> outcome independently of exception entry.
>=20
> For a discontinuity without an exception element, perf script previously
> reported an untaken B.LS as:
>=20
>   tr end  jcc             4000f8 =3D> 0       b.ls #0x400118
>   tr strt jmp                  0 =3D> 4000fc
>=20
> With the not-taken flag set:
>=20
>   tr end  jcc/not_taken/  4000f8 =3D> 0       b.ls #0x400118
>   tr strt jmp                  0 =3D> 4000fc
>=20
> Here, 4000f8 remains the last traced instruction and 4000fc is the trace
> restart address. These boundary samples do not establish an IRQ entry or
> an exception return; the not_taken flag records only the branch outcome.
>=20
> Assisted-by: Codex:gpt-6
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-perf_cs_et=
m_fix_non_taken-v2-0-6ab8c07a5455@arm.com?part=3D6

