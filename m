Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576CC37AA7A
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 20:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788206954; cv=none; b=BOLeyeAZuKcg3RdB3MjycUSGL8oyJewRy+6hxYBp2ojXSymW3Hm+92iF/MYSomgCyPn35AzvUJjKHTbtE/6CMugWgMhWypyV7FaCCBPJEPVXtTrKDx2eyMd1PYvCkBL9HJ7QRKeSHCAiSlEK5UjDb9gNN2Ek1e7TMedmH4bxD30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788206954; c=relaxed/simple;
	bh=eikBBtbPdlkyOoA9DaEyw+xwsEv/sOxLDQtaA9oPf7w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KIxLpL9mP3Koal0BX5pVlKOInFymt6vGTE8aO4VIzepwPCvgMea+8A16D05YrT2eCpX+0ytEDti5g8W0e9wCgEyfOffgSFZd6iTqk4t9V4DxkK5bIi96YfUPTWga6jW4REKLi5scgC0bEGQ0LbuJSru8DRbJQy7l8MwzudKVykc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KA7aIcyr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KA7aIcyr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBCD91F00A3E;
	Mon, 31 Aug 2026 20:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788206952;
	bh=eikBBtbPdlkyOoA9DaEyw+xwsEv/sOxLDQtaA9oPf7w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KA7aIcyrmUkYhRCkUzlY9obzVe6DhtgqWKalxkJp/gI5+cTm5WW2PapdPugnBS95Q
	 iL+rNnhxeIzGV4IncHsy5hBmcXIcVQeeNb0Y65qMOdNfZP00/JqNJvCnAhS3Oq+Nsc
	 PH6NWbeIv9t86VYyRecFsF1R/7U2cCEuOvdl+ho4CTon3YnCWxckaWmM0qRfnov7Kg
	 MhbFJkyVouoGFD+Expd+lf/LN4lSqa61d0oNiPiaFST6UiFWysgOfXwtNs6mPr0+TR
	 FVMpADdS98e0G3gEnbd0hk6/R3vImzX0JHNjtfKW5onFMG+5Jvg8wbi38x+km3KnBw
	 mMKr4P2CfrmZw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC v1 11/19] ptwrite uprobes: Add multinop support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831150651.1134594-12-ak@kernel.org>
References: <20260831150651.1134594-1-ak@kernel.org>
 <20260831150651.1134594-12-ak@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 20:09:12 +0000
Message-Id: <20260831200912.BBCD91F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> GCC's -fpatchable-function-entry=3D5 may emit five one-byte NOPs. Normally
> that's not safe to patch because some might jump into a later nop.
> But for the gcc case it's safe because nobody jumps into the nops.
> Add a %multinop that allows the user opting into patching these sites.
> This way patching for the gcc instrumentation works.
>=20
> Assisted-by: omp:gpt-5.6-luna
> Signed-off-by: Andi Kleen <ak@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831150651.1134=
594-1-ak@kernel.org?part=3D11

