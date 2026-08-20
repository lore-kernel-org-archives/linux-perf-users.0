Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C664B469859
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Aug 2026 14:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787234588; cv=none; b=myzlk2u4I6Wct67uphC6vRAqIxqbYmG4GB94U+SUuKQpnOG46A1vs/8HnSy3eP1lSkHkgoC/LwB/TMQoqikhP3f+lvNJq2H6ti9IQMEPg+cFMVkcLtQM0+qHLEXzCojK/4wW+wPbYdBlUAT0YLLlK/7knMZdz+Yss598ZRX8enI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787234588; c=relaxed/simple;
	bh=qwSy4FM140u5uSANkazwL8aPQD/6i2bcoqgSRC4BBcs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kEcUmlHsO7tGAAlTm0bRAtkiEnlA1XAupxivMlhMjLl9MT/rdeCvVMNpHFaUegklZGHRAGlAoNvbacy7YzdNC1S0If7A/jXCrk5vUrBp6mvLsYFYYMHsNxSvX8ps3WizlPvNHOCTF5pGBXkIOgoEBLYmJiDYzI20AMqfpW2SayQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kICAW6H/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kICAW6H/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8F01F00A3D;
	Thu, 20 Aug 2026 14:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787234587;
	bh=qwSy4FM140u5uSANkazwL8aPQD/6i2bcoqgSRC4BBcs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kICAW6H/xABNubNoylyrByeoHZFqW80zs+5CSkkAYPB4bOIDRC2Y6DEm2fblqldsy
	 Lr3Yog34TYOUUV1OfXRTgy7iYFdjhYRcY2p3b1Got7pZM6xNsiBLDXZFOAw7vPQJEb
	 v/9xea+K2Q7qvx0mcxn2OZ40merRJ6Wz3drFV/gZzIizSfmsoEUTSBOu81O+uv6H+a
	 8960SLewtMeR21Psx08I5T3vPGaRfW7y1fGqvqj3bYvTvnvVSqXMiSyWvvmSqteYrA
	 vKr4j08HbkjctW9B9kim9t+mPhWs1UDvJNlIs0nB72sfnwYUOBYLNfD0ncS2joNsEO
	 vfX2Q6AfOzmqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf/dwc_pcie: Fix PCI device reference leak in
 probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ruoyu Wang" <ruoyuw560@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260820135611.3901886-1-ruoyuw560@gmail.com>
References: <20260820135611.3901886-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 14:03:07 +0000
Message-Id: <20260820140307.8C8F01F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> pci_get_domain_bus_and_slot() returns a referenced PCI device. When the
> subsequent RAS DES capability lookup fails, dwc_pcie_pmu_probe() returns
> -ENODEV without releasing that reference. Repeated failed probes can
> therefore keep the PCI device allocated after removal.
>=20
> Declare the looked-up device with __free(pci_dev_put), so the temporary
> reference is released on every return path. Keeping the reference scoped
> to the whole probe also covers all later uses of the device during
> initialization.
>=20
> This issue was found by a static analysis checker and confirmed by manual
> source review.
>=20
> Fixes: 7f35b429802a ("perf/dwc_pcie: fix duplicate pci_dev devices")
> Suggested-by: Markus Elfring <Markus.Elfring@web.de>
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820135611.3901=
886-1-ruoyuw560@gmail.com?part=3D1

