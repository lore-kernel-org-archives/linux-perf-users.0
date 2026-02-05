Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AD43081A2;
	Thu,  5 Feb 2026 18:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770315995; cv=none; b=SKpitOY5GQA9XnEPQmNe0DcIv/2J+wJtsbRnFBrABZ3r/ff7aGXU2pBE5fB570Pm+g+CZSsMCxbgOVw/cg1Y87A4nG8iAJ/bi7GO+b7W+4iFQFDUIl7it70MAcjHWCRiZORAsDmmzLE5nVO9l20y5hicLWEHnAL+jVkPm6wFxuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770315995; c=relaxed/simple;
	bh=NN1BUnMnduStMQdjhiWVthLf60Zi6vxqqFlWRMKB3tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DoLJXn9CCYbOx1wp9XluY8LB6L9ODo/ZM2mmJ6afTt4ywdt+TQ8y76+vA7pbRj4b5V9uO+uV7R8O8xeGgPATdMzgfWUygaF16VsfCCaBS2OGMEJ3fulHjhkja0AetIUhSWnMPeRlYwrv3jFiLrqliRF9aCFeDxp7WD+Tz1Vd0gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsac3tkQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsac3tkQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53717C4CEF7;
	Thu,  5 Feb 2026 18:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770315994;
	bh=NN1BUnMnduStMQdjhiWVthLf60Zi6vxqqFlWRMKB3tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dsac3tkQQvBRe1vcrzaCV+6mQiPlEiyWMw9mPcRLRHivih1hS0FMHXWTafR1nYyLV
	 7SZuAAhwsJDxLePGS+3jGIQNk4WTFors4R4pcRmZO1BVlgL3ZySLvVkz9YMPptKzgH
	 xHhv3JvWwpezgSsq0cXaDU6uZ9PilVYmk0jNzgt2OgPFt5C9f74w442HfSA/Y2Qc/s
	 wlvbbTUr6hVyNbWa8LVs3OTsCzVvMxFOowPZXbD0wSBzIQIMsUKXYry+j7ei59EY3C
	 mxsH2xV75BgE8l1cUFDlyapVjpGwNqQUvgmwsuaQ3NfGg9ZCKqrRCnE1UvZb9z7iye
	 HC16rG8XKxsxw==
Date: Thu, 5 Feb 2026 18:26:29 +0000
From: Conor Dooley <conor@kernel.org>
To: Lv Zheng <lv.zheng@linux.spacemit.com>
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Jingyu Li <joey.li@spacemit.com>,
	Zhijian Chen <zhijian@spacemit.com>, iommu@lists.linux.dev,
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/7] dt-bindings: iommu: Add spacemit/t100 features
Message-ID: <20260205-presoak-reshape-9465d18bca4a@spud>
References: <cover.1769562575.git.lv.zheng@spacemit.com>
 <cover.1770281596.git.lv.zheng@linux.spacemit.com>
 <B1AEE717CF03B1BB+22fe4be0d3c8d2c6b4c5d3c19736c937cbed3c0d.1770281596.git.lv.zheng@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Wpxlm2V7JNdyFlL0"
Content-Disposition: inline
In-Reply-To: <B1AEE717CF03B1BB+22fe4be0d3c8d2c6b4c5d3c19736c937cbed3c0d.1770281596.git.lv.zheng@linux.spacemit.com>


--Wpxlm2V7JNdyFlL0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 05, 2026 at 05:10:43PM +0800, Lv Zheng wrote:
> Adds device tree bindings for SpacemiT T100 specific features by
> introducing spacemit,100 compatible. T100 contains distributed IOATCs,
> each of which exposes pmiv interrupt.
>=20
> Signed-off-by: Lv Zheng <lv.zheng@linux.spacemit.com>
> Signed-off-by: Jingyu Li <joey.li@spacemit.com>

Please wait until discussion has finished on prior versions before
sending more. The merge window opens next week, so there's absolutely no
rush with this series, there's weeks before anything could happen with
it.

--Wpxlm2V7JNdyFlL0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaYTg1QAKCRB4tDGHoIJi
0vDeAP9r/oVVVhAJWRxgemIGWRfNsY/zaFj7V/mrthly06/WvgEAxJWFOZkvjIPe
TaZIC5+OJVGIHnO5PdrGA73zOoKx+gc=
=unhL
-----END PGP SIGNATURE-----

--Wpxlm2V7JNdyFlL0--
