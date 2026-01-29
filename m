Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34D71A267;
	Thu, 29 Jan 2026 10:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769681293; cv=none; b=Z3thXp1h574oAwe7R8AHFuEPZJUGl/tMCtJ4FwU4er6Un68h4cIaeDHPVQ2LIDGB737pOlz3wihi+2ctW9DvcKftU2IoU9KdZitPVvX6PJDMaMXMuM/IGoOwutSO6O222WypxWmjocbc1ovjZXfq97T5lAKJGj+MAaP9bad3tVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769681293; c=relaxed/simple;
	bh=uXkHfa4+z35FpyAOBy2hWJiL6ObVI+X2uHGvORyAOns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYu0EsccI0Z1xBLihQe8/ez3ve4Tyg+LtUZg2WA4TkAyaVuvpEaUauH8QyacDkMB0CqJNqBMy4Z1OxkLeB5f4mP1sg5KLLP/lixeIMxhfuwf+xMj5xJyDAv4c6cJm+EiPRSJIXnGs7KnGpjvj4H8uvx+/kheRfEegB2f1BFEqrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tc1tAGQ/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tc1tAGQ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D21C4CEF7;
	Thu, 29 Jan 2026 10:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769681292;
	bh=uXkHfa4+z35FpyAOBy2hWJiL6ObVI+X2uHGvORyAOns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tc1tAGQ/6vfMu7sM22oHX6v3VDfEjDyXxw3TVfSNBOXxobmkDsAnRKu91mwZB0I3D
	 QTS5PRrAsEqPyd77oww6qarDGCnKMSj6MYK9wyMPIQhKo3XTwJWrMh7nDG+iihi8zb
	 YejnXaKZzUTeNHgNjUouhsgk1nL0r91mz8zDkrSKboNgpHXzmhx9AGcoAeRtv7ZvLm
	 8zxXCt95tDItdbr7GTC0lvgm4rEMkQwtOuW2KZ34xfk2UwuKVLaTeN3xGFU+YoM4bQ
	 KtOo89SrtCO0CIJOR7cRnZsgEEp2ZPJ9IifHa2RhcxRl48uZhiWOZ0gyOOZG562MeD
	 UieC9UBi2JAMg==
Date: Thu, 29 Jan 2026 10:08:06 +0000
From: Conor Dooley <conor@kernel.org>
To: Lv Zheng <lv.zheng@spacemit.com>
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
Subject: Re: [PATCH v1.1 4/7] dt-bindings: iommu: Add spacemit/t100 features
Message-ID: <20260129-evolution-femur-84eb5668f4a7@spud>
References: <cover.1769562575.git.lv.zheng@spacemit.com>
 <cover.1769666438.git.lv.zheng@spacemit.com>
 <15209d7b8c5a5055f8944ab7261e440d70a18a03.1769666438.git.lv.zheng@spacemit.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g3pOpkxmTCGkgspJ"
Content-Disposition: inline
In-Reply-To: <15209d7b8c5a5055f8944ab7261e440d70a18a03.1769666438.git.lv.zheng@spacemit.com>


--g3pOpkxmTCGkgspJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 02:09:13PM +0800, Lv Zheng wrote:
> Adds device tree bindings for SpacemiT T100 specific features.
>=20
> vendor-hpm-events: Allow vendor events to be customized in the device
>                    tree.
> global-filter: The feature saves silicon area by reducing filters to
>                one and use it as a global filter across all events.
>                This usually is sufficient for real applications.

Why can these not be determined from a device specific compatible?

> Signed-off-by: Lv Zheng <lv.zheng@spacemit.com>
> Signed-off-by: Jingyu Li <joey.li@spacemit.com>
> ---
>  .../bindings/iommu/riscv,iommu.yaml           | 60 ++++++++++++++++++-
>  1 file changed, 59 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml b/D=
ocumentation/devicetree/bindings/iommu/riscv,iommu.yaml
> index d4838c3b3741..0378eef1f34e 100644
> --- a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> @@ -57,17 +57,42 @@ properties:
> =20
>    interrupts:
>      minItems: 1
> -    maxItems: 4
> +    maxItems: 68
>      description:
>        Wired interrupt vectors available for RISC-V IOMMU to notify the
>        RISC-V HARTS. The cause to interrupt vector is software defined
>        using IVEC IOMMU register.
> +      Normally the number of interrupt vectors available is 4 for IOATS
> +      civ/fiv/pmiv/piv interrupts. But for SpacemiT distributed IOMMU,
> +      the number of interrupt vectors includes IOATC pmiv wired
> +      interrupts and the maximum number of IOATCs can be up to 64.

The extension to 68 should only be permitted for a soc-specific
compatible.

> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 68
> =20
>    msi-parent: true
> =20
>    power-domains:
>      maxItems: 1
> =20
> +  vendor-hpm-events:
> +    minItems: 1
> +    maxItems: 120
> +    description:
> +      Each item defines a vendor specific event using the format of
> +      "eventId[:eventName]", where the eventId is an integer filling the
> +      eventID field of the iohpmevt register and the eventName is an
> +      optional string used as the annotation of the event instead of the
> +      default name "eventId".
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +
> +  global-filter:
> +    type: boolean
> +    description:
> +      Indicate the filters programmed across iohpmevt registers are wired
> +      together in hardware as a global filter applied to all HPM events.
> +
>  required:
>    - compatible
>    - reg
> @@ -145,3 +170,36 @@ examples:
>              };
>          };
>      };
> +
> +  - |+
> +    /* Example 5 (SpacemiT distributed IOMMU) */
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    iommu4: iommu@1bccd000 {
> +        compatible =3D "qemu,riscv-iommu", "riscv,iommu";

You cannot use the qemu compatible for your device, you must use a
specific one for the spacemit k3.

Also, why is your version "v1.1"? That should just be "v1", and your
next version "v2" etc.

pw-bot: changes-requested

Cheers,
Conor.

> +        reg =3D <0x1bccd000 0x1000>;
> +        interrupts =3D <58 IRQ_TYPE_LEVEL_HIGH>, <58 IRQ_TYPE_LEVEL_HIGH=
>,
> +                     <58 IRQ_TYPE_LEVEL_HIGH>, <58 IRQ_TYPE_LEVEL_HIGH>,
> +                     <62 IRQ_TYPE_LEVEL_HIGH>, <63 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names =3D "civ", "fiv", "ioats-pmiv", "piv",
> +                          "ioatc0-pmiv", "ioatc1-pmiv";
> +        interrupt-parent =3D <&saplic>;
> +        #iommu-cells =3D <0x01>;
> +        /* SpacemiT T100 features */
> +        global-filter;
> +        vendor-hpm-events =3D "0x10:pri_page_reqs",
> +                            "0x11:ptw_cache_reqs",
> +                            "0x12:dtw_cache_reqs",
> +                            "0x15:all_trans_reqs",
> +                            "0x20:dtw_cache_lkps",
> +                            "0x28:s1l0_ptw_cache_lkps",
> +                            "0x2A:s1l1_ptw_cache_lkps",
> +                            "0x2C:s1l2_ptw_cache_lkps",
> +                            "0x2E:s1l3_ptw_cache_lkps",
> +                            "0x30:s2l0_ptw_cache_lkps",
> +                            "0x32:s2l1_ptw_cache_lkps",
> +                            "0x34:s2l2_ptw_cache_lkps",
> +                            "0x36:s2l3_ptw_cache_lkps",
> +                            "0x38:mtlb_lkps",
> +                            "0x3A:utlb_lkps";
> +    };
> --=20
> 2.43.0
>=20
> This message and any attachment are confidential and may be privileged or=
 otherwise protected from disclosure. If you are not an intended recipient =
of this message, please delete it and any attachment from your system and n=
otify the sender immediately by reply e-mail. Unintended recipients should =
not use, copy, disclose or take any action based on this message or any inf=
ormation contained in this message. Emails cannot be guaranteed to be secur=
e or error free as they can be intercepted, amended, lost or destroyed, and=
 you should take full responsibility for security checking.=20
> =20
> =E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E4=BB=BB=E4=BD=95=E9=99=84=
=E4=BB=B6=E5=85=B7=E6=9C=89=E4=BF=9D=E5=AF=86=E6=80=A7=E8=B4=A8=EF=BC=8C=E5=
=B9=B6=E5=8F=AF=E8=83=BD=E5=8F=97=E5=85=B6=E4=BB=96=E4=BF=9D=E6=8A=A4=E6=88=
=96=E4=B8=8D=E5=85=81=E8=AE=B8=E8=A2=AB=E6=8A=AB=E9=9C=B2=E7=BB=99=E7=AC=AC=
=E4=B8=89=E6=96=B9=E3=80=82=E5=A6=82=E9=98=81=E4=B8=8B=E8=AF=AF=E6=94=B6=E5=
=88=B0=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E6=95=AC=E8=AF=B7=E7=AB=8B=E5=8D=
=B3=E4=BB=A5=E5=9B=9E=E5=A4=8D=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E7=9A=84=
=E6=96=B9=E5=BC=8F=E9=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=8C=E5=
=B9=B6=E5=B0=86=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E4=BB=BB=E4=BD=
=95=E9=99=84=E4=BB=B6=E4=BB=8E=E9=98=81=E4=B8=8B=E7=B3=BB=E7=BB=9F=E4=B8=AD=
=E4=BA=88=E4=BB=A5=E5=88=A0=E9=99=A4=E3=80=82=E5=A6=82=E9=98=81=E4=B8=8B=E5=
=B9=B6=E9=9D=9E=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=86=99=E6=98=8E=E4=B9=8B=E6=94=
=B6=E4=BB=B6=E4=BA=BA=EF=BC=8C=E6=95=AC=E8=AF=B7=E5=88=87=E5=8B=BF=E4=BD=BF=
=E7=94=A8=E3=80=81=E5=A4=8D=E5=88=B6=E3=80=81=E6=8A=AB=E9=9C=B2=E6=9C=AC=E9=
=82=AE=E4=BB=B6=E6=88=96=E5=85=B6=E4=BB=BB=E4=BD=95=E5=86=85=E5=AE=B9=EF=BC=
=8C=E4=BA=A6=E8=AF=B7=E5=88=87=E5=8B=BF=E4=BE=9D=E6=9C=AC=E9=82=AE=E4=BB=B6=
=E6=88=96=E5=85=B6=E4=BB=BB=E4=BD=95=E5=86=85=E5=AE=B9=E8=80=8C=E9=87=87=E5=
=8F=96=E4=BB=BB=E4=BD=95=E8=A1=8C=E5=8A=A8=E3=80=82=E7=94=B5=E5=AD=90=E9=82=
=AE=E4=BB=B6=E6=97=A0=E6=B3=95=E4=BF=9D=E8=AF=81=E6=98=AF=E4=B8=80=E7=A7=8D=
=E5=AE=89=E5=85=A8=E5=92=8C=E4=B8=8D=E4=BC=9A=E5=87=BA=E7=8E=B0=E4=BB=BB=E4=
=BD=95=E5=B7=AE=E9=94=99=E7=9A=84=E9=80=9A=E4=BF=A1=E6=96=B9=E5=BC=8F=EF=BC=
=8C=E5=8F=AF=E8=83=BD=E4=BC=9A=E8=A2=AB=E6=8B=A6=E6=88=AA=E3=80=81=E4=BF=AE=
=E6=94=B9=E3=80=81=E4=B8=A2=E5=A4=B1=E6=88=96=E6=8D=9F=E5=9D=8F=EF=BC=8C=E6=
=94=B6=E4=BB=B6=E4=BA=BA=E9=9C=80=E8=87=AA=E8=A1=8C=E8=B4=9F=E8=B4=A3=E5=81=
=9A=E5=A5=BD=E5=AE=89=E5=85=A8=E6=A3=80=E6=9F=A5=E3=80=82

--g3pOpkxmTCGkgspJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaXsxhgAKCRB4tDGHoIJi
0lrTAQDUeHiDKYJ2pdgF5qBPFTl2MmUS2TDpj5WaIfHu/f1nGQEAz5zTpEBn+UUL
r1iuSjsTGijDHp/qZQHhemZyn6Vj2Qk=
=lo6B
-----END PGP SIGNATURE-----

--g3pOpkxmTCGkgspJ--
