Received: from sg-1-31.ptr.blmpb.com (sg-1-31.ptr.blmpb.com [118.26.132.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707B1330D22
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Jan 2026 01:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769737195; cv=none; b=QvGyLy+UmCj6iqG+gDBXVhC0XxzYs6sRwofb8dt+xBTpsHvnNFnlTK/vryIt94K5IjeZmYz+IwiwsHAThjEDR1Es7m46LrXx3jAVZeZT9PuiuaPBiRbu9bJ3u9ymdVpVOQET6JOT2VoylB6dTb80fe8Lz0gA7UqbqTrBA86a9bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769737195; c=relaxed/simple;
	bh=/1CUBsDJd927BySIY8L9Fe7Z6JCInyOrDcCzO6bWOZ0=;
	h=Message-Id:References:In-Reply-To:Content-Type:Date:To:Cc:Subject:
	 From:Mime-Version; b=NIqA4RUNVmrt1WEY47QPc/S1/u8Zq2go7q2ObjLnk173yQWDEJKZ/u4up1ywltlYSTOnGs6cQ71ZQmtPaQkNdUnpsmlYeKDP2EbiUaDzo7N6CGB4di5he00QUyKzhLlUHsSVJTZu+mJWbvUePioL1gUqcv0flkHZeJZzvlqaZ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=spacemit.com; spf=pass smtp.mailfrom=spacemit.com; dkim=pass (2048-bit key) header.d=spacemit.com header.i=@spacemit.com header.b=CMsIf+xE; arc=none smtp.client-ip=118.26.132.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spacemit.com header.i=@spacemit.com header.b="CMsIf+xE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303021642; d=spacemit.com; t=1769737181; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=/1CUBsDJd927BySIY8L9Fe7Z6JCInyOrDcCzO6bWOZ0=;
 b=CMsIf+xE0H3KAtdj7fBL2J7G+2JI8x66aUS39iii9gbWdlgd+D9ixTNjtalZQkfeGSreKs
 wwDz76b2zWVUsGpyeHz5s5MLRs/1ztgYuxNCjrqvqc7Wc/tyNTK1rHeUrfsvrww/VjZHsa
 OfMOGkT00g8r4kAmVnGVn2V4DrHVozImQIQLIpnPB6zsf+UztpOyO+trpa/g+ZMuHumf2D
 835xIOFZ+6xDkTj/m3+0SwNBKb4uElN/FvkW4m7vSDgFgPw8XeJ3W06cnYPgiToPcNVGcM
 URT/da8lluctXwamy1RpIU3vclARIe6xQFRToU3Hzpr/j/FFkMLOYAmv+8Vg6A==
Message-Id: <a4684b7f094a6a5ee87d9db722b75594f851b9fb.f8d0aa16.da0e.4b42.9f4d.e17634051da8@feishu.cn>
References: <cover.1769562575.git.lv.zheng@spacemit.com> <cover.1769666438.git.lv.zheng@spacemit.com> <15209d7b8c5a5055f8944ab7261e440d70a18a03.1769666438.git.lv.zheng@spacemit.com> <20260129-evolution-femur-84eb5668f4a7@spud> <a4684b7f094a6a5ee87d9db722b75594f851b9fb.d4fb292a.1570.47af.8025.bf9af089dc8a@feishu.cn>
	<20260129-grandly-compare-e8e3a105f690@spud>
In-Reply-To: <20260129-grandly-compare-e8e3a105f690@spud>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 30 Jan 2026 09:39:38 +0800
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
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+1697c0bdb+2f6400+vger.kernel.org+lv.zheng@spacemit.com>
Content-Transfer-Encoding: quoted-printable

> From: "Conor Dooley"<conor@kernel.org>
> Date:=C2=A0 Fri, Jan 30, 2026, 00:42
> Subject:=C2=A0 Re: [PATCH v1.1 4/7] dt-bindings: iommu: Add spacemit/t100=
 features
> To: "=E9=83=91=E5=BE=8B"<lv.zheng@spacemit.com>
> Cc: "Tomasz Jeznach"<tjeznach@rivosinc.com>, "Joerg Roedel"<joro@8bytes.o=
rg>, "Will Deacon"<will@kernel.org>, "Robin Murphy"<robin.murphy@arm.com>, =
"Rob Herring"<robh@kernel.org>, "Krzysztof Kozlowski"<krzk+dt@kernel.org>, =
"Conor Dooley"<conor+dt@kernel.org>, "Paul Walmsley"<pjw@kernel.org>, "Palm=
er Dabbelt"<palmer@dabbelt.com>, "Albert Ou"<aou@eecs.berkeley.edu>, "Alexa=
ndre Ghiti"<alex@ghiti.fr>, "Jingyu Li"<joey.li@spacemit.com>, "iommu"<iomm=
u@lists.linux.dev>, "linux-perf-users"<linux-perf-users@vger.kernel.org>, "=
linux-riscv"<linux-riscv@lists.infradead.org>, "spacemit"<spacemit@lists.li=
nux.dev>, "devicetree"<devicetree@vger.kernel.org>
> On Thu, Jan 29, 2026 at 06:43:03PM +0800, =E9=83=91=E5=BE=8B wrote:
> > > From: "Conor Dooley"<conor@kernel.org>
> > > Date:=C2=A0 Thu, Jan 29, 2026, 18:08
> > > Subject:=C2=A0 Re: [PATCH v1.1 4/7] dt-bindings: iommu: Add spacemit/=
t100 features
> > > To: "Lv Zheng"<lv.zheng@spacemit.com>
> > > Cc: "Tomasz Jeznach"<tjeznach@rivosinc.com>, "Joerg Roedel"<joro@8byt=
es.org>, "Will Deacon"<will@kernel.org>, "Robin Murphy"<robin.murphy@arm.co=
m>, "Rob Herring"<robh@kernel.org>, "Krzysztof Kozlowski"<krzk+dt@kernel.or=
g>, "Conor Dooley"<conor+dt@kernel.org>, "Paul Walmsley"<pjw@kernel.org>, "=
Palmer Dabbelt"<palmer@dabbelt.com>, "Albert Ou"<aou@eecs.berkeley.edu>, "A=
lexandre Ghiti"<alex@ghiti.fr>, "Jingyu Li"<joey.li@spacemit.com>, "Zhijian=
 Chen"<zhijian@spacemit.com>, <iommu@lists.linux.dev>, <linux-perf-users@vg=
er.kernel.org>, <linux-riscv@lists.infradead.org>, <spacemit@lists.linux.de=
v>, <devicetree@vger.kernel.org>
> > > On Thu, Jan 29, 2026 at 02:09:13PM +0800, Lv Zheng wrote:
> > > > Adds device tree bindings for SpacemiT T100 specific features.
> > > >=C2=A0
> > > > vendor-hpm-events: Allow vendor events to be customized in the devi=
ce
> > > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0tree.
> > > > global-filter: The feature saves silicon area by reducing filters t=
o
> > > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0one and use =
it as a global filter across all events.
> > > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This usually=
 is sufficient for real applications.
> > >=C2=A0
> > > Why can these not be determined from a device specific compatible?
> >=C2=A0
> > The specification only defines less than 10 standard event types while =
the
> > real silicons should have implemented many other event types based on
> > their micro-architecture. I tried to provide a common mechanism for all
> > vendor specific event types across different vendors.
>=C2=A0
> Given that the variance is based on uarch, it sounds like it can be
> determined from the compatible.

I'll give Robin's suggestion a try.

> > It is similar for the global filter, the global filter mechanism actual=
ly
> > complies to the IOMMU specification, users can alter the iohpmevt
> > registers as is what is specified in the IOMMU specification. It only
> > provides slight application difference between the final effection. Thu=
s
> > this could also be a non-device specific option.
>=C2=A0
> What is a "user" in this context? Given you're talking about reducing
> silicon area, it sounds like this will be set in stone for each SoC, and
> therefore can be determined by compatible. If other devices do this,
> they can also determine it from their compatible.
>=C2=A0
> Properties for things that can be determined based on compatible are
> generally not permitted, so you'll need to provide a compelling
> rationale. Common mechanism isn't one, since determining based on
> compatible would be a common mechanism based on match data that people
> can tack onto for their devices.

I see. This sounds like a reasonable rule of DT attributes. I'll do similar
stuffs based on compatible.

Thanks and best regards,
Lv


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
