Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1A4360ECE
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 02:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787538351; cv=none; b=W7seAAmtp7iEqIOPlJbD6fiHkCJz1iRSc7SeyIRtX2xq5Viathomi4Md+OzM1bZM9ubs3autTmtvDahkX2BOJbcVw/V+3KoGarravNj2d8L+sdXJ6RH2wX79DptpMFmGOFTRXHvR5M5o192YRH8jaObv46vc3ODRX5rrz9Mm6zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787538351; c=relaxed/simple;
	bh=6Oc9VHdDcStnwcfWsUFfyAw4tAuKn14gH1y2OVcSD7c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=prrvZ8HIsAPMTaIO91mPV8opGKSixfx2gboFDGjwPvG1ew3X8C6NW34Kce5qg/rhTIA2f9K10F+ioTb7z0fCssMUuANDmRODzUhg7nDnYfd/BRA6Txuj8h76eg2SZzhWkT1XezvYh07GKiAWYdJ+jeLvH4IOpFySWks+kUfI4xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kc9HG29B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kc9HG29B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775211F000E9;
	Mon, 24 Aug 2026 02:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787538339;
	bh=6Oc9VHdDcStnwcfWsUFfyAw4tAuKn14gH1y2OVcSD7c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kc9HG29Bqb4gLkhk0INwLQfSg7+kDtSEH0OJewtE9W4Evrnxt3tPxtuLUOFoS34BB
	 3vkzpqZGnaFv/Nrn5JQW9lHt3oC9VLA+Wyp3fO67xgJ6ZkyWatrjY3Dv8XEYPALa6w
	 xD0P26p5AvCv5eCiX5I+i+hiXZJJLWP0ievFywjDVGviFuqb7dYjgGyLweuoOxWoHK
	 F+aiv2BtaSkGp5qWpYwEznKQ08swuDi/ZgefMF2vBCFartZWlrLQ4wC3CbnDoexBPG
	 dw73cOUxgu2/OaeUXxpAmA4Yy+QCToVbnmC/w/nuUOoqibaA6BZ0rLgeOTNvH9KBIe
	 kcVc6y8XvSowA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] iommu/riscv: create a auxiliary device for HPM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zong Li" <zong.li@sifive.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260824022034.3916570-3-zong.li@sifive.com>
References: <20260824022034.3916570-1-zong.li@sifive.com>
 <20260824022034.3916570-3-zong.li@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 02:25:39 +0000
Message-Id: <20260824022539.775211F000E9@smtp.kernel.org>
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
> Suggested-by: Samuel Holland <samuel.holland@sifive.com>
> Signed-off-by: Zong Li <zong.li@sifive.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824022034.3916=
570-1-zong.li@sifive.com?part=3D2

