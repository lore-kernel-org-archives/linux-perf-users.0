Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8422363C50
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Oct 2026 06:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791182404; cv=none; b=LCwLz8UGB3W+LdZk+stUwd0/mmDBW0/2x0dqCOHhl1ssR9St4Yqpd4Z6NIKcdBU88OrPfOFPPnyMcEK266qnt1njaZMwzha5qtYwLpdlG8+akxRBwoazxQ5kYlRXfgRlXe87bfMR/1Xr53TSOuU87WEkG6gi2OMb5Jmc6efhI9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791182404; c=relaxed/simple;
	bh=gUGUbcSNx0Qt+V5OcpCQlPLrHbpgpf1e+O3D9Ut+/SU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VD7EdmB/DXZbnpK1JYeb8JGXtUiDHBvZPZ/SbPHZ28dxhtnmn1jKfiISmp/vuoPUEB98blmCOyfshBR1Iufr2oblZ2zHFQjaiRXjSWm2yVEJFXEGTmGiAMrcPXWftqriRUOVQRsrT4A08H4E23Y3LTkigpwGcLPMG/Y/MRgCG30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WT7OlPrK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WT7OlPrK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361121F000FF;
	Mon,  5 Oct 2026 06:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791182403;
	bh=jWrZe85dJ4UKllcJCDilah5MN8ZbFQNUIA/t/r8KwjE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WT7OlPrK0D+ZM1Dt9w98CbxanpArUQoA9dWzAs8PYZ352Y9j3K3SG2XZ87sFZBRPf
	 UOzj1IOUptU5+Jbb19LV50h+kLGq8oRYNbeDXyxe2Y3tDsNO/EWQZ94Si2QEEDSHFX
	 Eln/zVSzBbvbhqEorL2T29wuVkoo0ACzuVtgQxdRYy9b0dw2IyPez7mN8McTgLDy/C
	 HWp4HVPgR1kCDHLEjmi2MzMk7KWobGsryHM5vN8O+Hk9dUBdf56/rMa0lvt6/cv7B5
	 MdggBjWmB2/BhBvRucyrBZnnZi9JhOaqZMcnHe9A5P2DrwhkZQv/JmpbtcYtekDv/Z
	 UIG791E4xdj/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/7] perf symbol: Update symtab type of vmlinux from
 build-id cache
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261005063411.114244-4-namhyung@kernel.org>
References: <20261005063411.114244-1-namhyung@kernel.org>
 <20261005063411.114244-4-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 06:40:02 +0000
Message-Id: <20261005064003.361121F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Currently dso__load_vmlinux() sets both binary type and symtab type to
> VMLINUX.  To precisely track the symtab type of the kernel dso, update
> the type to build-id cache if it's loaded from there.  It won't have
> any functional difference though.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005063411.1142=
44-1-namhyung@kernel.org?part=3D3

