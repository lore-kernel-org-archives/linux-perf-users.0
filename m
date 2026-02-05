Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABD22C11E7;
	Thu,  5 Feb 2026 18:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770315895; cv=none; b=mAQbh5qfTwW33j6Bs8BqRRO6DZiDOgAYnGau1Cd1EPPqyGlR8DtjOvLj0i8dsf2fy5EJN2CgE3sUvZn+ba+FlkydGxbVezWWoMELf0WZdFd6C9uJx5gWiY3GZCJwiOx8UtHtoi98kbcZfe5rkRVrRwgWZG4GsNj50G4uMrQiEqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770315895; c=relaxed/simple;
	bh=YZdRm6j/1RjK92bL0k3iE9k5fnW/KimFREVqtvMe0ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZ6UjuDE3A4PDdebDLsmihLHKATMyO3wduc8jzGWuVGWgy8au7VAwT4RoCrupWWmRxuYzjfwfqe/jNStAJ8fE2vgJKCsCQrpFEG+AT44Kvb67obghJ4/Zrgg1y0PShJ7uuOdDfD3Zu4Ohwy/KKnXykfaETgdE3duC6BS9Eu4ZfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2uYPBCc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2uYPBCc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4B5C4CEF7;
	Thu,  5 Feb 2026 18:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770315895;
	bh=YZdRm6j/1RjK92bL0k3iE9k5fnW/KimFREVqtvMe0ms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c2uYPBCcO6b275QVJPFhVdQk1xJY4UZ+W/oDdPgeutXljSp97OgSOFT0T8G0qmWEy
	 aMa1yKdYBFi6Rt8PBsYoHCylvaHJy/Q8AhTcoXnMV9k4/y1X5l2qwsDkCwLmmyfZ3L
	 9fzrEd8MFuenABxvkd4oOarbqE2ZKnm8zXymdXLbxX3LCSd4/zrV+fWVTrB/WmWh3l
	 RyobmoPK6HIb/5C377l6jYNtviWnnqyqY+YD53ovh4nQ5kjDziU7/yte+t2RCCcqpq
	 KmDNM8r1DJ3YLsK1gNybCsyZ+Fr4TTZ9l/DGW7l/8zfm3AzanLoMDS2m/D2ZpmyLNp
	 9hDGa0WxO+ROQ==
Date: Thu, 5 Feb 2026 18:24:49 +0000
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
Subject: Re: [PATCH v3 4/8] dt-bindings: iommu: Add spacemit/t100 features
Message-ID: <20260205-attitude-customer-129fe2bd5dc7@spud>
References: <cover.1769562575.git.lv.zheng@spacemit.com>
 <cover.1770195980.git.lv.zheng@linux.spacemit.com>
 <A0E91F323138E92F+a27d73b00f3324f0d3885128f5596230b3f1370b.1770195980.git.lv.zheng@linux.spacemit.com>
 <20260204-primer-wrought-6f64b14bf152@spud>
 <53171BEB06F43599+7c1f54bc-e72d-4cbd-9d10-194ae6b13744@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7ooHQUgLkDlcZ8EA"
Content-Disposition: inline
In-Reply-To: <53171BEB06F43599+7c1f54bc-e72d-4cbd-9d10-194ae6b13744@linux.spacemit.com>


--7ooHQUgLkDlcZ8EA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 05, 2026 at 11:11:51AM +0800, Lv Zheng wrote:
> On 2/5/2026 1:37 AM, Conor Dooley wrote:
> > On Wed, Feb 04, 2026 at 05:09:12PM +0800, Lv Zheng wrote:
> > > Adds device tree bindings for SpacemiT T100 specific features by
> > > introducing spacemit,100 compatible. T100 contains distributed IOATCs,
> > > each of which exposes pmiv interrupt.
> > >=20
> > > Signed-off-by: Lv Zheng <lv.zheng@linux.spacemit.com>
> > > Signed-off-by: Jingyu Li <joey.li@spacemit.com>
> > > ---
> > >   .../bindings/iommu/riscv,iommu.yaml           | 37 ++++++++++++++++=
+++
> > >   1 file changed, 37 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml=
 b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> > > index d4838c3b3741..2da3456e7402 100644
> > > --- a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> > > +++ b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> > > @@ -32,6 +32,12 @@ properties:
> > >     # should be specified along with 'reg' property providing MMIO lo=
cation.
> > >     compatible:
> > >       oneOf:
> > > +      - description: SpacemiT distributed IOMMUs
> > > +        items:
> > > +          - enum:
> > > +              - spacemit,t100
> > > +          - const: spacemit,riscv-iommu
> >=20
> > What actually is the t100? Is it an SoC or is it the name of the core
> > complex IP that spacemit is using in multiple SoCs?
>=20
> T100 is the name of the IOMMU IP developed by SpacemiT, announced in RISC=
-V
> 2024 China Summit:
> https://www.bilibili.com/video/BV1DNtCeiEBk/
> It's world first server SPEC IOMMU in RISC-V, supports IOTLB placed in
> adjacent to the DMA masters and supports PCIe ATS and PRI.
> You can find it shipped in the recent publicly purchasable SoC SpacemiT K=
3.

Right, then what you need here is something like:

items:
  - enum:
      - spacemit,k3-iommu
  - spacemit,t100-iommu
  - riscv,iommu

Driver can then match on spacemit,t100-iommu - but you need to have
soc-specific compatibles.
I'm not convinced that riscv,iommu is suitable here though, does the
driver work on your platform without the portions of code that are added
by this series and enabled by your new compatible? If not, the I don't
think the riscv,iommu fallback should be here.

Additionally, please stop sending new versions so frequently and in
response to earlier submissions. I have a v4 in my inbox while we are
still discussing v3.

Cheers,
Conor.

--7ooHQUgLkDlcZ8EA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaYTgbgAKCRB4tDGHoIJi
0ssWAPsF5Rd+jQ7R6SGcIrIBk89+5VCaZ95mGoswvO24RrJzZwEAn8dZ/hbPRkc6
Sf2i1ewjvjvVkP1NrBBbi7NlZH383ws=
=DdGy
-----END PGP SIGNATURE-----

--7ooHQUgLkDlcZ8EA--
