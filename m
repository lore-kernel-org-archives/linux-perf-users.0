Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8DA349AF1;
	Wed,  4 Feb 2026 17:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770226634; cv=none; b=cw7ECi7Z24a5y0aobrpGoNGoAZ8oUTk4p7EaA7NWKawfQQAAsvIowk17kZZaInXME/mstZ3p6VO6b1EtMkXrEFeCmuIk0BeUeGxGrkEtz6vP9wKB+Vr3C47R8kaZ1cGEupN4h+vewdk6iFJhxCdSDhwVHCI7o+YxcnL/FDXYM2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770226634; c=relaxed/simple;
	bh=03TqwxPd0/D2HLyCo+C/tXq5z02Y/CpmCpGRC1475F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CuZiLoIwGeOZ2JcD9qXFh7GZsFhw9DdI66PrrlmUC1VklVuU/TwQ6Yg0RK+EJX/afx/ODkjBgqA/saW4ZjPbSst4vqZds1G/eycZEasRltENgA/8qM8dusPW++rI+SdVbLxSIGgCic++ruK3wHI8VLjwBVfw7NmiOxL3ReeM/eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1Aa1ZKf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1Aa1ZKf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA68C4CEF7;
	Wed,  4 Feb 2026 17:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770226633;
	bh=03TqwxPd0/D2HLyCo+C/tXq5z02Y/CpmCpGRC1475F0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U1Aa1ZKfBj4itv4CbBKvlT9PSiRoIA6z+RZEmQ6EVmIe4tVJXgB+lfAI1O5hAWEyz
	 nKJZQUfVC0uE3+nMso4Td2xmy4fUj6SQXkmBgc55e7gPf0ENyRHq3RR87p4lGF3FXy
	 0NT8jKMqvPB6jFNE6DRjNkBHTgOn6zXM3oV5wBis8Uu9RBUIjN9Qbl19BhtIdI2qdE
	 kNEn0qg4Biu1JMibLR9vrmGQW2M6Wg/zYb5m7lItjCnshzCWE4E3HqZUIfjM+XX95o
	 dCO8/o6mhQarXnPOTyN3MmiX8wpv/sCpmp5tdXQBiu4J3vutzp3g4dNzcw58D9M/gM
	 1lHVeoheWGMug==
Date: Wed, 4 Feb 2026 17:37:08 +0000
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
Message-ID: <20260204-primer-wrought-6f64b14bf152@spud>
References: <cover.1769562575.git.lv.zheng@spacemit.com>
 <cover.1770195980.git.lv.zheng@linux.spacemit.com>
 <A0E91F323138E92F+a27d73b00f3324f0d3885128f5596230b3f1370b.1770195980.git.lv.zheng@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7ntmr8QQRm24MhuR"
Content-Disposition: inline
In-Reply-To: <A0E91F323138E92F+a27d73b00f3324f0d3885128f5596230b3f1370b.1770195980.git.lv.zheng@linux.spacemit.com>


--7ntmr8QQRm24MhuR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 04, 2026 at 05:09:12PM +0800, Lv Zheng wrote:
> Adds device tree bindings for SpacemiT T100 specific features by
> introducing spacemit,100 compatible. T100 contains distributed IOATCs,
> each of which exposes pmiv interrupt.
>=20
> Signed-off-by: Lv Zheng <lv.zheng@linux.spacemit.com>
> Signed-off-by: Jingyu Li <joey.li@spacemit.com>
> ---
>  .../bindings/iommu/riscv,iommu.yaml           | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml b/D=
ocumentation/devicetree/bindings/iommu/riscv,iommu.yaml
> index d4838c3b3741..2da3456e7402 100644
> --- a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> @@ -32,6 +32,12 @@ properties:
>    # should be specified along with 'reg' property providing MMIO locatio=
n.
>    compatible:
>      oneOf:
> +      - description: SpacemiT distributed IOMMUs
> +        items:
> +          - enum:
> +              - spacemit,t100
> +          - const: spacemit,riscv-iommu

What actually is the t100? Is it an SoC or is it the name of the core
complex IP that spacemit is using in multiple SoCs?

> +          - const: riscv,iommu
>        - items:
>            - enum:
>                - qemu,riscv-iommu
> @@ -75,6 +81,23 @@ required:
> =20
>  additionalProperties: false
> =20
> +select: false

Why is this here? It just breaks the whole binding.
pw-bot: changes-requested

> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: spacemit,riscv-iommu
> +    then:
> +      properties:
> +        interrupts:
> +          maxItems: 68

This isn't right. You would need to make the interrupts property itself
have maxItems: 68, then add an else to this conditional that has
maxItems: 4. What you've done just doesn't work, and if you removed the
"select: false: you'd see.

> +          description:
> +            SpacemiT distributed IOMMU includes additional interrupts for
> +            IOATCs. Each IOATC exposes pmiv wired vector as standalone
> +            interrupt and the maximum number of IOATCs can be up to 64.
> +
>  examples:
>    - |+
>      /* Example 1 (IOMMU device with wired interrupts) */
> @@ -145,3 +168,17 @@ examples:
>              };
>          };
>      };
> +
> +  - |+
> +    /* Example 5 (SpacemiT distributed IOMMU) */
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    iommu4: iommu@1bccd000 {

Remove the iommu4 label, there's no references to it.

Cheers,
Conor.

> +        compatible =3D "spacemit,t100", "spacemit,riscv-iommu", "riscv,i=
ommu";
> +        reg =3D <0x1bccd000 0x1000>;
> +        interrupts =3D <58 IRQ_TYPE_LEVEL_HIGH>, <58 IRQ_TYPE_LEVEL_HIGH=
>,
> +                     <58 IRQ_TYPE_LEVEL_HIGH>, <58 IRQ_TYPE_LEVEL_HIGH>,
> +                     <62 IRQ_TYPE_LEVEL_HIGH>, <63 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-parent =3D <&saplic>;
> +        #iommu-cells =3D <0x01>;
> +    };
> --=20
> 2.43.0
>=20

--7ntmr8QQRm24MhuR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaYODxAAKCRB4tDGHoIJi
0q3UAQCg1TsHH+duEmzyrzVzEGU5BoOmSQhJqtrGbl3iYsF2JQD+OrvDaVMRD3l1
6/cgK4rgkqxbBB1b19Zh2zRXlFrIrQc=
=curv
-----END PGP SIGNATURE-----

--7ntmr8QQRm24MhuR--
