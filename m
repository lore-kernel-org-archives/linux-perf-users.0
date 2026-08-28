Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E4B23B63E
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Aug 2026 09:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787908006; cv=none; b=nCs4RSty0LsTBiL5l2VdNWngV+0FXvaDH2sCU8e4odDnPmi2PrHxHKlvyZr6nVB+4CgfmI+6a53j0GlTHGHPIa7H0g2TJimvJajfhwZT2LGKM3fsK0jmi8M6XnR9qzKp7S+/2jaSmbiPkO9qoBVUxsXukf9DhXT/Hht9IUNK4yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787908006; c=relaxed/simple;
	bh=Q7IFohFAUS6v+iBiIGeuqStG+/vaS9MH6YuyJO/pD9M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XqtAbmmszf+/jLS5mEcoXeDfKAYLTPYPNBhis9Vr9m3oXcbaynRDI0fJw5Ylu5NQr1L749Te+JKnwdBISejfDb2+Gv83DMD0l+6JNw3I2TiF8IYGm/qpOyegAKDrLuovIGIfa0X0kzSLSsuFaJ9ZX335r+leeE1qxsR37VPiO5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzGRp3w8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzGRp3w8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F27E1F000E9;
	Fri, 28 Aug 2026 09:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787908004;
	bh=Q7IFohFAUS6v+iBiIGeuqStG+/vaS9MH6YuyJO/pD9M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TzGRp3w8vUVj39CRgkORS1lIJueBG/imUilOBGXN5rgC20MlIEWBGDJvRRabTXN3O
	 V0GIiEj8fk5keZ2K+DVpT0o+VVken9pOtHV27SoKlqDg31PC6fFbicLBsWB1usj9b/
	 /kPmq/cw2e1I/1Cpwq04lqCwXqKNzpLDHHPx1SXNqlCmYXFXNgm6ZA8mt6HDOnmPmw
	 Hatbwl7kfIa7lgYk+okRu/NHLfyH12BUodT1e1WUWljCBG8wSvlr3p1H4yBfGgQsoX
	 n4Z/0kUsTwIUFHD/Gzadso7/EJp7faTx+glwzFkykGfp4SOYkKRlV4yzHK4IJ1/Yo5
	 5dD6XbHK2SYTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v7 2/3] iommu/riscv: create a auxiliary device
 for HPM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zong Li" <zong.li@sifive.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260828085819.4076449-3-zong.li@sifive.com>
References: <20260828085819.4076449-1-zong.li@sifive.com>
 <20260828085819.4076449-3-zong.li@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 09:06:44 +0000
Message-Id: <20260828090644.9F27E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Create an auxiliary device for HPM when the IOMMU supports a
> hardware performance monitor.
>=20
> Tested-by: Chen Pei <cp0613@linux.alibaba.com>
> Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> Reviewed-by: Yicong Yang <yang.yicong@picoheart.com>
> Suggested-by: Samuel Holland <samuel.holland@sifive.com>
> Signed-off-by: Zong Li <zong.li@sifive.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828085819.4076=
449-1-zong.li@sifive.com?part=3D2

