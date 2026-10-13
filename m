Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879302DECC2
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 13:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897065; cv=none; b=jQbgvsXuvokGUH+Oi7U3JKPI88rlTxzXP5qxaByTS1lsiqMgAxw+mWUMee+PU8zkm8kZF1+4GTLFlUm7eXvppRrHCu0Yfd7hkwMRBxl/z4y1UhhOBdnrnpslI9DCxcVZ5Oj1yh0o/Rg+0/xe68O1viSeDsq9eTvAurMm1DJgovo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897065; c=relaxed/simple;
	bh=a43nG8pp3Hmg6hzQVlXmM3VA2ljOC30Z8CGBFsaC7jA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=cxElfn+cNXejJU7VMQsZ2JJ9lBxsXxJQMrQU7jRsNYbM1QL0/ZFohTpO/PCIeAr7ST1MUzcU5qFJcx9uvCeCPHmGTB7rUFNeaggSZh7eA1ZiduTflLWCcj9xsdgxIk+TP9iME1x51erNjRxYnJKf49WefetNLJdMJyp95WF+h2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOFxssBl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOFxssBl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190581F00893;
	Tue, 13 Oct 2026 13:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791897064;
	bh=a43nG8pp3Hmg6hzQVlXmM3VA2ljOC30Z8CGBFsaC7jA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bOFxssBlnTNjFylPi5ZbhZkpa6urhfAmpYmOhLT7ePXOZj0714ugXf0d1NPFoQiEN
	 LWtL48kWQT6h0RSlQP4yvcO4FH/cicNxwL8jN0ROzp1Dwg3V/CuJuZsQicW942Fycz
	 7RXGRYyING5fjaFFjgeBsSBVxaX8Xro5Hgk6Ta/KWTGsCZf69eXJx7NYMIKwPfZOJV
	 WnSjefGV5f7J7MYfLJIPZQoTuhPte0getDs7mYmyrp89rjynS0fWU1Hb1pyG2EtI2C
	 iP6UMLSMyEDw0jO+ewFOCkj1SDBBWGiyrBaf3g+OnYWRrSEyfhJ40/8Ms1vO4jxsej
	 PJkM2LG0Quq7w==
Message-ID: <sashiko-outbox-169779@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] arm64: sysreg: Fix three incorrect enum values
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fuad Tabba" <fuad.tabba@linux.dev>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013130247.4135515-2-fuad.tabba@linux.dev>
References: <20261013130247.4135515-1-fuad.tabba@linux.dev>
 <20261013130247.4135515-2-fuad.tabba@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 13:11:03 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Three enum values in the sysreg file don't match DDI0601 2026-09.
> Outer Shareable in VTCR_EL2.SH0 is 0b10, not 0b01, as TCR_EL1.SH0 in
> the same file already has it. Thumb-2 in ID_PFR0_EL1.State1 is 0b0011,
> not 0b0010, and the M-profile model in ID_PFR1_EL1.MProgMod is 0b0010,
> not 0b0001. The spec lists all three old values as reserved.
>=20
> There are currently no users of these values. The VTCR_EL2 one came in
> with commit a035001dea37 ("arm64: Convert VTCR_EL2 to sysreg
> infratructure"), the ID_PFR0_EL1 one with commit fb0b8d1a24d8
> ("arm64/sysreg: Convert ID_PFR0_EL1 to automatic generation") and the
> ID_PFR1_EL1 one with commit 1224308075f1 ("arm64/sysreg: Convert
> ID_PFR1_EL1 to automatic generation").
>=20
> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013130247.4135=
515-1-fuad.tabba@linux.dev?part=3D1

