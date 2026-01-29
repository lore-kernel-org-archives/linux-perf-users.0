Received: from sg-1-30.ptr.blmpb.com (sg-1-30.ptr.blmpb.com [118.26.132.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD62D350295
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Jan 2026 10:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769683509; cv=none; b=OrkcalcZu9hM5W4mg/bsnXFL5Z5s5CWmOat2wi4JTEq5yEjKbh3dL5B+Yys8In7NvqMxWutycDzhw9CVb/31KdFF76+Ob4CzCjRC6+2gdLk+r1K6/vIweNts/n/H5jGby154ECelq598SR90qxEj1HW6to8skUhvT7zPGgqbgoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769683509; c=relaxed/simple;
	bh=Bsmu0ZtyxwBm7VmwVjV8hDfhurU6a3XA7N+L0IEyAyU=;
	h=Mime-Version:References:In-Reply-To:Content-Type:To:Cc:Subject:
	 From:Date:Message-Id; b=GKDLVULxJyTPki+sG343OwEzH5hUjcQ9JsGfpXnJDdLY0z9s3sQVeHrzCbipVFTYK0ux85ZxKWZGbZo0mik5lcx0CVNlOFsSxeiy9fiG8QjqVvL6DPzOTT8TsJnRXgB9X+g+tFY1hu2ArChrCi6u34up+CKWvVOnkd8MT1liRRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=spacemit.com; spf=pass smtp.mailfrom=spacemit.com; dkim=pass (2048-bit key) header.d=spacemit.com header.i=@spacemit.com header.b=LbIVunH/; arc=none smtp.client-ip=118.26.132.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spacemit.com header.i=@spacemit.com header.b="LbIVunH/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303021642; d=spacemit.com; t=1769683386; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Bsmu0ZtyxwBm7VmwVjV8hDfhurU6a3XA7N+L0IEyAyU=;
 b=LbIVunH/EWD6EEA8W1O9RP6prp21kCg2APU8mmVKAkS3X3eTEDAgTJnp1jJAOM3zPUKz/p
 uz2w9b90V8j89CySAX5jnUIjZbsefN+1ks5BXwnn+qxJ6p9ZPN6RTFVGfeeqsgVhFGpm4Z
 4kPxluxvQCJux+BQtDkucSudM+JNnzAVhXZi4wAEDELfXkkgU7Vx1WnCV5RP3Q1lsLSOJz
 aAfY4PRQBAVoBCiYS9rdd5PWhEtMZ4KC1RXPNhF8x6bSL/NzOkl8Tp5XqDTDJ9qafM7qj1
 JmkjzDnMZqtde1loEDYeVwBXIgWW9BKjANqSN7120owKEroVFPi5PrtWs5jZIQ==
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1769562575.git.lv.zheng@spacemit.com> <cover.1769666438.git.lv.zheng@spacemit.com> <15209d7b8c5a5055f8944ab7261e440d70a18a03.1769666438.git.lv.zheng@spacemit.com>
	<20260129-evolution-femur-84eb5668f4a7@spud>
In-Reply-To: <20260129-evolution-femur-84eb5668f4a7@spud>
Content-Type: text/plain; charset=UTF-8
To: "Conor Dooley" <conor@kernel.org>
Cc: "Tomasz Jeznach" <tjeznach@rivosinc.com>, 
	"Joerg Roedel" <joro@8bytes.org>, "Will Deacon" <will@kernel.org>, 
	"Robin Murphy" <robin.murphy@arm.com>, "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Conor Dooley" <conor+dt@kernel.org>, "Paul Walmsley" <pjw@kernel.org>, 
	"Palmer Dabbelt" <palmer@dabbelt.com>, 
	"Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>, 
	"Jingyu Li" <joey.li@spacemit.com>, "iommu" <iommu@lists.linux.dev>, 
	"linux-perf-users" <linux-perf-users@vger.kernel.org>, 
	"linux-riscv" <linux-riscv@lists.infradead.org>, 
	"spacemit" <spacemit@lists.linux.dev>, 
	"devicetree" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v1.1 4/7] dt-bindings: iommu: Add spacemit/t100 features
From: =?utf-8?q?=E9=83=91=E5=BE=8B?= <lv.zheng@spacemit.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Jan 2026 18:43:03 +0800
Message-Id: <a4684b7f094a6a5ee87d9db722b75594f851b9fb.d4fb292a.1570.47af.8025.bf9af089dc8a@feishu.cn>
X-Lms-Return-Path: <lba+1697b39b8+961d53+vger.kernel.org+lv.zheng@spacemit.com>

> From: "Conor Dooley"<conor@kernel.org>
> Date:=C2=A0 Thu, Jan 29, 2026, 18:08
> Subject:=C2=A0 Re: [PATCH v1.1 4/7] dt-bindings: iommu: Add spacemit/t100=
 features
> To: "Lv Zheng"<lv.zheng@spacemit.com>
> Cc: "Tomasz Jeznach"<tjeznach@rivosinc.com>, "Joerg Roedel"<joro@8bytes.o=
rg>, "Will Deacon"<will@kernel.org>, "Robin Murphy"<robin.murphy@arm.com>, =
"Rob Herring"<robh@kernel.org>, "Krzysztof Kozlowski"<krzk+dt@kernel.org>, =
"Conor Dooley"<conor+dt@kernel.org>, "Paul Walmsley"<pjw@kernel.org>, "Palm=
er Dabbelt"<palmer@dabbelt.com>, "Albert Ou"<aou@eecs.berkeley.edu>, "Alexa=
ndre Ghiti"<alex@ghiti.fr>, "Jingyu Li"<joey.li@spacemit.com>, "Zhijian Che=
n"<zhijian@spacemit.com>, <iommu@lists.linux.dev>, <linux-perf-users@vger.k=
ernel.org>, <linux-riscv@lists.infradead.org>, <spacemit@lists.linux.dev>, =
<devicetree@vger.kernel.org>
> On Thu, Jan 29, 2026 at 02:09:13PM +0800, Lv Zheng wrote:
> > Adds device tree bindings for SpacemiT T100 specific features.
> >=C2=A0
> > vendor-hpm-events: Allow vendor events to be customized in the device
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tr=
ee.
> > global-filter: The feature saves silicon area by reducing filters to
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0one and use it a=
s a global filter across all events.
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This usually is =
sufficient for real applications.
>=C2=A0
> Why can these not be determined from a device specific compatible?

The specification only defines less than 10 standard event types while the
real silicons should have implemented many other event types based on
their micro-architecture. I tried to provide a common mechanism for all
vendor specific event types across different vendors.

It is similar for the global filter, the global filter mechanism actually
complies to the IOMMU specification, users can alter the iohpmevt
registers as is what is specified in the IOMMU specification. It only
provides slight application difference between the final effection. Thus
this could also be a non-device specific option.

>=C2=A0
> > Signed-off-by: Lv Zheng <lv.zheng@spacemit.com>
> > Signed-off-by: Jingyu Li <joey.li@spacemit.com>
> > ---
> > =C2=A0.../bindings/iommu/riscv,iommu.yaml =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 60 ++++++++++++++++++-
> > =C2=A01 file changed, 59 insertions(+), 1 deletion(-)
> >=C2=A0
> > diff --git a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml b=
/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> > index d4838c3b3741..0378eef1f34e 100644
> > --- a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> > +++ b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> > @@ -57,17 +57,42 @@ properties:
> > =C2=A0
> > =C2=A0 =C2=A0interrupts:
> > =C2=A0 =C2=A0 =C2=A0minItems: 1
> > - =C2=A0 =C2=A0maxItems: 4
> > + =C2=A0 =C2=A0maxItems: 68
> > =C2=A0 =C2=A0 =C2=A0description:
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0Wired interrupt vectors available for RISC-V=
 IOMMU to notify the
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0RISC-V HARTS. The cause to interrupt vector =
is software defined
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0using IVEC IOMMU register.
> > + =C2=A0 =C2=A0 =C2=A0Normally the number of interrupt vectors availabl=
e is 4 for IOATS
> > + =C2=A0 =C2=A0 =C2=A0civ/fiv/pmiv/piv interrupts. But for SpacemiT dis=
tributed IOMMU,
> > + =C2=A0 =C2=A0 =C2=A0the number of interrupt vectors includes IOATC pm=
iv wired
> > + =C2=A0 =C2=A0 =C2=A0interrupts and the maximum number of IOATCs can b=
e up to 64.
>=C2=A0
> The extension to 68 should only be permitted for a soc-specific
> compatible.

Sure.

>=C2=A0
> > +
> > + =C2=A0interrupt-names:
> > + =C2=A0 =C2=A0minItems: 1
> > + =C2=A0 =C2=A0maxItems: 68
> > =C2=A0
> > =C2=A0 =C2=A0msi-parent: true
> > =C2=A0
> > =C2=A0 =C2=A0power-domains:
> > =C2=A0 =C2=A0 =C2=A0maxItems: 1
> > =C2=A0
> > + =C2=A0vendor-hpm-events:
> > + =C2=A0 =C2=A0minItems: 1
> > + =C2=A0 =C2=A0maxItems: 120
> > + =C2=A0 =C2=A0description:
> > + =C2=A0 =C2=A0 =C2=A0Each item defines a vendor specific event using t=
he format of
> > + =C2=A0 =C2=A0 =C2=A0"eventId[:eventName]", where the eventId is an in=
teger filling the
> > + =C2=A0 =C2=A0 =C2=A0eventID field of the iohpmevt register and the ev=
entName is an
> > + =C2=A0 =C2=A0 =C2=A0optional string used as the annotation of the eve=
nt instead of the
> > + =C2=A0 =C2=A0 =C2=A0default name "eventId".
> > + =C2=A0 =C2=A0$ref: /schemas/types.yaml#/definitions/string-array
> > +
> > + =C2=A0global-filter:
> > + =C2=A0 =C2=A0type: boolean
> > + =C2=A0 =C2=A0description:
> > + =C2=A0 =C2=A0 =C2=A0Indicate the filters programmed across iohpmevt r=
egisters are wired
> > + =C2=A0 =C2=A0 =C2=A0together in hardware as a global filter applied t=
o all HPM events.
> > +
> > =C2=A0required:
> > =C2=A0 =C2=A0- compatible
> > =C2=A0 =C2=A0- reg
> > @@ -145,3 +170,36 @@ examples:
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};
> > =C2=A0 =C2=A0 =C2=A0};
> > +
> > + =C2=A0- |+
> > + =C2=A0 =C2=A0/* Example 5 (SpacemiT distributed IOMMU) */
> > + =C2=A0 =C2=A0#include <dt-bindings/interrupt-controller/irq.h>
> > +
> > + =C2=A0 =C2=A0iommu4: iommu@1bccd000 {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0compatible =3D "qemu,riscv-iommu", "riscv,=
iommu";
>=C2=A0
> You cannot use the qemu compatible for your device, you must use a
> specific one for the spacemit k3.

Sure.

>=C2=A0
> Also, why is your version "v1.1"? That should just be "v1", and your
> next version "v2" etc.

I'm still using an old fashioned upstream rule, thanks for the reminder.

>=C2=A0
> pw-bot: changes-requested

OK. Will send a revised patchset later.

Cheers,
Lv

>=C2=A0
> Cheers,
> Conor.
>=C2=A0
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D <0x1bccd000 0x1000>;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0interrupts =3D <58 IRQ_TYPE_LEVEL_HIGH>, <=
58 IRQ_TYPE_LEVEL_HIGH>,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 <58 IRQ_TYPE_LEVEL_HIGH>, <58 IRQ_TYPE_LEVEL_HIGH>,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 <62 IRQ_TYPE_LEVEL_HIGH>, <63 IRQ_TYPE_LEVEL_HIGH>;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0interrupt-names =3D "civ", "fiv", "ioats-p=
miv", "piv",
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0"ioatc0-pmiv", "ioatc1-pmiv";
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0interrupt-parent =3D <&saplic>;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0#iommu-cells =3D <0x01>;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0/* SpacemiT T100 features */
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0global-filter;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0vendor-hpm-events =3D "0x10:pri_page_reqs"=
,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0"0x11:ptw_cache_reqs",
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0"0x12:dtw_cache_reqs",
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0"0x15:all_trans_reqs",
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0"0x20:dtw_cache_lkps",
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0"0x28:s1l0_ptw_cache_lkps",
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0"0x2A:s1l1_ptw_cache_lkps",
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0"0x2C:s1l2_ptw_cache_lkps",
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0"0x2E:s1l3_ptw_cache_lkps",
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0"0x30:s2l0_ptw_cache_lkps",
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0"0x32:s2l1_ptw_cache_lkps",
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0"0x34:s2l2_ptw_cache_lkps",
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0"0x36:s2l3_ptw_cache_lkps",
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0"0x38:mtlb_lkps",
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0"0x3A:utlb_lkps";
> > + =C2=A0 =C2=A0};
> > --=C2=A0
> > 2.43.0
> >=C2=A0


This message and any attachment are confidential and may be privileged or o=
therwise protected from disclosure. If you are not an intended recipient of=
 this message, please delete it and any attachment from your system and not=
ify the sender immediately by reply e-mail. Unintended recipients should no=
t use, copy, disclose or take any action based on this message or any infor=
mation contained in this message. Emails cannot be guaranteed to be secure =
or error free as they can be intercepted, amended, lost or destroyed, and y=
ou should take full responsibility for security checking.=20
=20
=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E4=BB=BB=E4=BD=95=E9=99=84=E4=
=BB=B6=E5=85=B7=E6=9C=89=E4=BF=9D=E5=AF=86=E6=80=A7=E8=B4=A8=EF=BC=8C=E5=B9=
=B6=E5=8F=AF=E8=83=BD=E5=8F=97=E5=85=B6=E4=BB=96=E4=BF=9D=E6=8A=A4=E6=88=96=
=E4=B8=8D=E5=85=81=E8=AE=B8=E8=A2=AB=E6=8A=AB=E9=9C=B2=E7=BB=99=E7=AC=AC=E4=
=B8=89=E6=96=B9=E3=80=82=E5=A6=82=E9=98=81=E4=B8=8B=E8=AF=AF=E6=94=B6=E5=88=
=B0=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E6=95=AC=E8=AF=B7=E7=AB=8B=E5=8D=B3=
=E4=BB=A5=E5=9B=9E=E5=A4=8D=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E7=9A=84=E6=
=96=B9=E5=BC=8F=E9=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=8C=E5=B9=
=B6=E5=B0=86=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E4=BB=BB=E4=BD=95=
=E9=99=84=E4=BB=B6=E4=BB=8E=E9=98=81=E4=B8=8B=E7=B3=BB=E7=BB=9F=E4=B8=AD=E4=
=BA=88=E4=BB=A5=E5=88=A0=E9=99=A4=E3=80=82=E5=A6=82=E9=98=81=E4=B8=8B=E5=B9=
=B6=E9=9D=9E=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=86=99=E6=98=8E=E4=B9=8B=E6=94=B6=
=E4=BB=B6=E4=BA=BA=EF=BC=8C=E6=95=AC=E8=AF=B7=E5=88=87=E5=8B=BF=E4=BD=BF=E7=
=94=A8=E3=80=81=E5=A4=8D=E5=88=B6=E3=80=81=E6=8A=AB=E9=9C=B2=E6=9C=AC=E9=82=
=AE=E4=BB=B6=E6=88=96=E5=85=B6=E4=BB=BB=E4=BD=95=E5=86=85=E5=AE=B9=EF=BC=8C=
=E4=BA=A6=E8=AF=B7=E5=88=87=E5=8B=BF=E4=BE=9D=E6=9C=AC=E9=82=AE=E4=BB=B6=E6=
=88=96=E5=85=B6=E4=BB=BB=E4=BD=95=E5=86=85=E5=AE=B9=E8=80=8C=E9=87=87=E5=8F=
=96=E4=BB=BB=E4=BD=95=E8=A1=8C=E5=8A=A8=E3=80=82=E7=94=B5=E5=AD=90=E9=82=AE=
=E4=BB=B6=E6=97=A0=E6=B3=95=E4=BF=9D=E8=AF=81=E6=98=AF=E4=B8=80=E7=A7=8D=E5=
=AE=89=E5=85=A8=E5=92=8C=E4=B8=8D=E4=BC=9A=E5=87=BA=E7=8E=B0=E4=BB=BB=E4=BD=
=95=E5=B7=AE=E9=94=99=E7=9A=84=E9=80=9A=E4=BF=A1=E6=96=B9=E5=BC=8F=EF=BC=8C=
=E5=8F=AF=E8=83=BD=E4=BC=9A=E8=A2=AB=E6=8B=A6=E6=88=AA=E3=80=81=E4=BF=AE=E6=
=94=B9=E3=80=81=E4=B8=A2=E5=A4=B1=E6=88=96=E6=8D=9F=E5=9D=8F=EF=BC=8C=E6=94=
=B6=E4=BB=B6=E4=BA=BA=E9=9C=80=E8=87=AA=E8=A1=8C=E8=B4=9F=E8=B4=A3=E5=81=9A=
=E5=A5=BD=E5=AE=89=E5=85=A8=E6=A3=80=E6=9F=A5=E3=80=82
