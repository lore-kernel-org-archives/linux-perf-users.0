Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291C943BDC7
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Sep 2026 06:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789108938; cv=none; b=YutsKc4OWAAvY/HRHmSbT8G69Hw70B8lPq3HX7cvYSvviCZTRw4wvgLVLOB0gfYv2GQPH5Ai7QRGnmucpnz/0pPh0dMNpAzPRXF5uqHM00O1J3rnx8OC0v34D68JQYtVIPovaWW+XVC5/uk/QBB7AN5pyRwueGiW1X9o4WZyTYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789108938; c=relaxed/simple;
	bh=izLJmroObfnxC+r476UuyrG4n3BfJ7KVzdfGaix58Us=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BaNQhQAyxD9vQqqDFJa8gXQldTLn4s9cAalH+XRUSBDqisVtSXgnteqWElNOO4rZ0QvAmvwdXxJwKgL4zhesrRY11NMhpNay1S7wbA8VDtUrC1HBId1HpeefcTZZc2qbcSloh+oUovOeW7Do1tymUbUZWhE4OcO5QBhF2CLtWsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azJc5Ptl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azJc5Ptl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99ED61F000FF;
	Fri, 11 Sep 2026 06:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789108929;
	bh=izLJmroObfnxC+r476UuyrG4n3BfJ7KVzdfGaix58Us=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=azJc5Ptl6Wvy5ufEvt59Ko4AxISQlB7XSRwM64Jg10piYuQskq5bCBUIKlHhUnuUm
	 ROBn8doISxrHdHs3fBZGa2qm8TrtKfDZnRG9L41rn22L3hmvu64sGxSscF6O/VRmHM
	 PueO6XsarnT7afUNinw6CETYYna80bOaAJMJwjPqjNeL92fBe3DWTGibvPUUBhm2yp
	 NQS14b09VQTsIIMTC17Hl5FEEVO698s8nFtaIvTHCgQRxkQslq+Bhg2nLBxpBS0MN0
	 3xTvFRkVCDumlC5C/EjmTQc5aKw3Dq3xvrI0vmX+ZIG/ZLpbmjKjYht5YiVk/uCdqu
	 s1n6+2CiyImBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 2/2] iommu/riscv: create a auxiliary device for HPM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zong Li" <zong.li@sifive.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260911063043.916844-3-zong.li@sifive.com>
References: <20260911063043.916844-1-zong.li@sifive.com>
 <20260911063043.916844-3-zong.li@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 06:42:09 +0000
Message-Id: <20260911064209.99ED61F000FF@smtp.kernel.org>
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
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> Reviewed-by: Yicong Yang <yang.yicong@picoheart.com>
> Suggested-by: Samuel Holland <samuel.holland@sifive.com>
> Signed-off-by: Zong Li <zong.li@sifive.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911063043.9168=
44-1-zong.li@sifive.com?part=3D2

