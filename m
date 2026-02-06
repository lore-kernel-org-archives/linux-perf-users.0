Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F053009F6;
	Fri,  6 Feb 2026 10:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770373498; cv=none; b=LmnIrIC/ptT0O5g/hcpf4Wjq7PKtnyowwJxgMKgCCI6o9gVMDF18+2AVk0228Q4vU324gIC9aZX+/n2UC5X664zvQgfpECfsnY0YJkgQrTtaM8bmMmXgADdmeq5ItygFTFzwrRBtKMbn1HQfqxTuNraqgrOOY9rTna/fqN0loTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770373498; c=relaxed/simple;
	bh=nSlDqHzMQr152avoDT8llEAGQVSmXKKZSUd4Xq6kY2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=im+n260P8UVmwcpBa7po/JabDZVTkDOOA5Z39fSEy1LU18CtPpSo75CAKbkX4eQWlNIrNyNOk0LssJS29JwBwdnQ5IrSZFsZOYHW1QsmwPT9ApcKu8AVZsw6AYQWAxetFjqbMy9u7FhgHimooyiv9znmrAR7cgNUFqXCVWIM6wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qd6XDHLl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qd6XDHLl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C47FC116C6;
	Fri,  6 Feb 2026 10:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770373497;
	bh=nSlDqHzMQr152avoDT8llEAGQVSmXKKZSUd4Xq6kY2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qd6XDHLl3otd4l7745FgtPHKCh+28ET+4Gh4od6CGkx9KS7Rmrnkuzrnifg94r/rN
	 OLjfInm8mgJh7ONidOWK8Gh54/rKF5snHY8nmT4Q4rMwo4SMe0HxDvtC4zbTBBC+e4
	 zsyr/lwEOHpNtwSNo56ArmBaMDE4QvCgrJqonWp4CUmMGXLAeJUaMUe9VxH0u/xiYT
	 dy/j+hH186tZh0Y5Ys1YxM8w8QfAoSSH3ZITUu59upINGLkB1Aze4mRHoP1RhTTyWL
	 SP+MmDr0FSVqiQj0GIN3bxtbFhxX7Q2wVHBlvgqfRPoInqSTYpWc1ytvp+bh9ts4Eo
	 ueh0byIlBA+0A==
Date: Fri, 6 Feb 2026 10:24:52 +0000
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
Message-ID: <20260206-buffed-scrubbed-36fc49ada496@spud>
References: <cover.1769562575.git.lv.zheng@spacemit.com>
 <cover.1770195980.git.lv.zheng@linux.spacemit.com>
 <A0E91F323138E92F+a27d73b00f3324f0d3885128f5596230b3f1370b.1770195980.git.lv.zheng@linux.spacemit.com>
 <20260204-primer-wrought-6f64b14bf152@spud>
 <53171BEB06F43599+7c1f54bc-e72d-4cbd-9d10-194ae6b13744@linux.spacemit.com>
 <20260205-attitude-customer-129fe2bd5dc7@spud>
 <B8005DB6301AACB4+374512e1-f561-4d2f-afd6-7a4b51012501@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8z5ZdYiefbay1YtF"
Content-Disposition: inline
In-Reply-To: <B8005DB6301AACB4+374512e1-f561-4d2f-afd6-7a4b51012501@linux.spacemit.com>


--8z5ZdYiefbay1YtF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 06, 2026 at 09:33:09AM +0800, Lv Zheng wrote:
> On 2/6/2026 2:24 AM, Conor Dooley wrote:
> > On Thu, Feb 05, 2026 at 11:11:51AM +0800, Lv Zheng wrote:
> > > On 2/5/2026 1:37 AM, Conor Dooley wrote:
> > > > On Wed, Feb 04, 2026 at 05:09:12PM +0800, Lv Zheng wrote:
> > > > > Adds device tree bindings for SpacemiT T100 specific features by
> > > > > introducing spacemit,100 compatible. T100 contains distributed IO=
ATCs,
> > > > > each of which exposes pmiv interrupt.
> > > > >=20
> > > > > Signed-off-by: Lv Zheng <lv.zheng@linux.spacemit.com>
> > > > > Signed-off-by: Jingyu Li <joey.li@spacemit.com>
> > > > > ---
> > > > >    .../bindings/iommu/riscv,iommu.yaml           | 37 +++++++++++=
++++++++
> > > > >    1 file changed, 37 insertions(+)
> > > > >=20
> > > > > diff --git a/Documentation/devicetree/bindings/iommu/riscv,iommu.=
yaml b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> > > > > index d4838c3b3741..2da3456e7402 100644
> > > > > --- a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> > > > > +++ b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> > > > > @@ -32,6 +32,12 @@ properties:
> > > > >      # should be specified along with 'reg' property providing MM=
IO location.
> > > > >      compatible:
> > > > >        oneOf:
> > > > > +      - description: SpacemiT distributed IOMMUs
> > > > > +        items:
> > > > > +          - enum:
> > > > > +              - spacemit,t100
> > > > > +          - const: spacemit,riscv-iommu
> > > >=20
> > > > What actually is the t100? Is it an SoC or is it the name of the co=
re
> > > > complex IP that spacemit is using in multiple SoCs?
> > >=20
> > > T100 is the name of the IOMMU IP developed by SpacemiT, announced in =
RISC-V
> > > 2024 China Summit:
> > > https://www.bilibili.com/video/BV1DNtCeiEBk/
> > > It's world first server SPEC IOMMU in RISC-V, supports IOTLB placed in
> > > adjacent to the DMA masters and supports PCIe ATS and PRI.
> > > You can find it shipped in the recent publicly purchasable SoC Spacem=
iT K3.
> >=20
> > Right, then what you need here is something like:
> >=20
> > items:
> >    - enum:
> >        - spacemit,k3-iommu
> >    - spacemit,t100-iommu
> >    - riscv,iommu
> >=20
> > Driver can then match on spacemit,t100-iommu - but you need to have
> > soc-specific compatibles.
> > I'm not convinced that riscv,iommu is suitable here though, does the
> > driver work on your platform without the portions of code that are added
> > by this series and enabled by your new compatible? If not, the I don't
> > think the riscv,iommu fallback should be here.
> >=20
> > Additionally, please stop sending new versions so frequently and in
> > response to earlier submissions. I have a v4 in my inbox while we are
> > still discussing v3.
>=20
> SpacemiT provides RISC-V IOMMU implementation, T100 is the first
> generation of the this IP product line, we have plan to develop T200,
> T300, etc., with more features introduced to be adoptive to new
> RISC-V IOMMU specifications.
> Besides, T100 is not only shipped in K3, but also shipped in V100 and
> the follow-up SoCs, like Kn, Vn00, they will likely use the same
> synthesis result of T100 RTLs.
>=20
> From SpacemiT's point of view, we need a common sense of this IP
> series for something like IOATCs, that's why spacemit,riscv-iommu
> (this is same like qemu,riscv-iommu) is introduced. And a common sense

No, it's not the same as qemu,riscv-iommu. That exists to avoid
riscv,iommu being allowed in isolation and as a "SoC"/integration
specific compatible. The driver matches against riscv,iommu not
qemu,riscv-iommu and has no qemu,riscv-iommu specific behaviours.
It is akin to having spacemit,k3-iommu.

> of T100 for all SoCs shipped T100 (like global filters, vendor events
> and etc.,).
>=20
> IMO, the current compatible is proper to reflect these concerns.
> What do you think?

I pretty much already told you what I think, that you need SoC-specific
compatibles for SoCs that integrate this IP and that the you should drop
the spacemit,riscv-iommu compatible. The spacemit,riscv-iommu compatible
doesn't provide any additional value over spacemit,t100-iommu, and has
the downside of maybe being confusing in the future if spacemit
produces a iommu that doesn't have the IOATC behaviour.

Also, I don't see an answer to my question about whether the hardware
will work without the driver changes this series introduces and enables
with the new compatible?

Cheers,
Conor.

--8z5ZdYiefbay1YtF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaYXBcwAKCRB4tDGHoIJi
0jyPAP9isV7zyFlG71V/A10awaNoOnM6vetdkFyMEwJt5Yj2ZgD/U8AKoodPKvnt
PY1aMEIn8pr+p3KARKfZhb9DFBcT2w0=
=XWl+
-----END PGP SIGNATURE-----

--8z5ZdYiefbay1YtF--
