Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808481DE3DB;
	Sat,  7 Feb 2026 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770476122; cv=none; b=jFW9lR63wJfbth44iYi+/5z8opP7xWkYWJfXnKdO2SCyF4BqOxCRyycNgq3a1iSp6V1NVeSlleVJh+B7DHHWRmG7XAjM6Mu1+Rvx3xhPj1sFG0yPVHPjLw4doBEceiIJX1f2yoITW0hiuDRNn+E+HsHSwvgkUxDNLeRHd/Ic1jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770476122; c=relaxed/simple;
	bh=/Vn1e2hoVlCMMBL+WFkQl4UcnH2Hfa5hsCRlW3VBLWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZ3GCp+H1CTOhQsSRVBFzCjN9boyWOacmMlJYm0CVm5OpV1s59zPtYWwoEvlvawnUUMzvtRznNNvFSUlOP6ms9KqwQOyUq30kihgxgikDvJLDUOLUqfBvPy05TAxt6uXbGsS0UGFlSKHJaim570XA79FB2YQbkhmAMqtg/JOzYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rei9Oyl4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rei9Oyl4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3EDC116D0;
	Sat,  7 Feb 2026 14:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770476122;
	bh=/Vn1e2hoVlCMMBL+WFkQl4UcnH2Hfa5hsCRlW3VBLWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rei9Oyl4Wxf2xzDBJ9LwHboVDd0CBlU2GARJoyFyj1VldpMGSmc/r1sHbhjwVzbFQ
	 jA5mH24TAFNtiLcE22pTKmo/kg/qFkk1I1ONJWyKeRTvlpF5jKV/CsQhwW+MvgxXCU
	 PlHwaWzAjcYXzlIQt+CVOqXycKWu5encomi/wDThmt9jgL9dK1eY2hi6e1Jb1Vzgfp
	 nJDulxCwkAYxInL0vypevNk8UyeGxW3zwq/oUUuKUpevEmZB6s3+QL2h+Qtz3IYU63
	 NUv1zUKNkOhvQMpAIyBP+9BKM0hbwNCl4wvkiDRxWzngc0/B5Ycuja/ckHK+SqrnsO
	 xGt0RX3aqKNog==
Date: Sat, 7 Feb 2026 14:55:16 +0000
From: Conor Dooley <conor@kernel.org>
To: Lv Zheng <lv.zheng@linux.spacemit.com>
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Jingyu Li <joey.li@spacemit.com>, iommu@lists.linux.dev,
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/8] dt-bindings: iommu: Add spacemit/t100 features
Message-ID: <20260207-gap-taekwondo-40c0661eaa08@spud>
References: <cover.1769562575.git.lv.zheng@spacemit.com>
 <cover.1770195980.git.lv.zheng@linux.spacemit.com>
 <A0E91F323138E92F+a27d73b00f3324f0d3885128f5596230b3f1370b.1770195980.git.lv.zheng@linux.spacemit.com>
 <20260204-primer-wrought-6f64b14bf152@spud>
 <53171BEB06F43599+7c1f54bc-e72d-4cbd-9d10-194ae6b13744@linux.spacemit.com>
 <20260205-attitude-customer-129fe2bd5dc7@spud>
 <B8005DB6301AACB4+374512e1-f561-4d2f-afd6-7a4b51012501@linux.spacemit.com>
 <20260206-buffed-scrubbed-36fc49ada496@spud>
 <7433DA16B96EE987+9b6398e6-edad-4a2e-814d-921483e5f1da@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mN4chUiAHJni2zvS"
Content-Disposition: inline
In-Reply-To: <7433DA16B96EE987+9b6398e6-edad-4a2e-814d-921483e5f1da@linux.spacemit.com>


--mN4chUiAHJni2zvS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 07, 2026 at 12:24:30PM +0800, Lv Zheng wrote:
>=20
> >=20
> > Also, I don't see an answer to my question about whether the hardware
> > will work without the driver changes this series introduces and enables
> > with the new compatible?
>=20
> Basically, T100 is riscv,iommu compatible, its IOATS part should be able
> to work using standard HPM events with standard riscv,iommu HPM
> compatible driver.

That's fine, that's all I wanted to know. The riscv,iommu compatible can
stay :)

--mN4chUiAHJni2zvS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaYdSVAAKCRB4tDGHoIJi
0n51AP4035S/CKCxinCsG9YuPN4rFYU+scihXululGWkNe1FfwEAi9PnqZh5dPw+
dqNXvYjrQVtAVZ215qZDKcazpcqFHAI=
=pm4A
-----END PGP SIGNATURE-----

--mN4chUiAHJni2zvS--
