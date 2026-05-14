Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EDA3AC0C3
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 06:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778741542; cv=pass; b=GP+Rtty90JResQ80dumU19AgiDmHiu/85h/P1CDx6l/KtbMOGqeFwBBpdM75uXgEHm5YBImpXu+A/JsAb63KALAPSly0T5SWLx2ONHZviEWS4FoxA/JYoh4Mhe+9J9I4WaPecVsNBbc7AsKsrWqKslf1xpLREECvhZrUGSwv7o8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778741542; c=relaxed/simple;
	bh=pIqc2MAKBkie5zPZBTM2DbxYyj5h05wLEO9Nr+qGurs=;
	h=From:References:Mime-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G5uR5QHH52DsGd56sNKHO1jdwJbQZ9olqwbjorfEIw7sBrEREPu773FnMw4wiXkZ38Ivx7JpS9mlOiljANEFH2ZnuAeMok+C7jAXk5NkTgTVyAD8q/TLVisQE7E9aSZBkM5ra1fy8xA7ZU43KR2jBhftP+tEXFOIkF0fs3M6H5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KrnEK4qv; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KrnEK4qv"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a4113ab355so7342190e87.1
        for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 23:52:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778741536; cv=none;
        d=google.com; s=arc-20240605;
        b=JS3HOQaAL12+xJpoMrUNJtN6k8KEFvBrgkg1OVWGFHPVdFX/ZbuTapj9R068XTreko
         JVOXtsUTqSQupXTCVJK2FETQzVGOLW7rfu2ahi3PBeucZ7MFbClGNnOIFLjvT0VF95gE
         +VQCFPBGan+FUvppnLkewm7FFmDG9RjN0kzkrnstSZPBt6zj0is62sS5Z4YJfw4YFlgs
         SLNrSLsW5oWSYELS6liTdfyhwZefNa7xaUWcUkmn1qTFe+lH0Yq6zyDJIW20bM1Leya1
         SuQl1ouL+6Ci2iCWxG+cqJXJhaK0bPPm1465ggnStvbfDFXw5DlzqOIG/6jepKGjRFfs
         9h2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:dkim-signature;
        bh=pIqc2MAKBkie5zPZBTM2DbxYyj5h05wLEO9Nr+qGurs=;
        fh=yJ87pyWJuvawVgu9Sl3UUtolF2gL5Ssk0foDCB15s/0=;
        b=XNF3q/Da17ArsIri+ytcYU3YLlnVlo77J8BZKqWXrrckkuI8O7lKhE2Ij0rcvO/BuL
         ZhGQhWwPlwUk8XsEMg6B8GFENlSwNkNhQRcFFI9frFvupI9lIbL24cLMF+JyZJVXf/z8
         WAv1q4N8EuDirKWfTeZCg0yxzeo8EJla4ujPbOuWWe00RZo3NTGFosraVxHULMwCk+JY
         HB9VUJed/c9Amce/6YrXeFm92Cm1mee0N9YxXLqy6WRjEZW7RtUo1KzLZaVZYu2cDEtu
         F3tK+V31JB1TmkeXyZfZLviEMZuDURzxBa1/E8pgGXDwNXEilgjSuIxDCeu+0ccAi8IW
         qOjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778741536; x=1779346336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pIqc2MAKBkie5zPZBTM2DbxYyj5h05wLEO9Nr+qGurs=;
        b=KrnEK4qv55WB/igKemhFyGhvt1zRl/gh7dOvYnscqru7EcvsI8eVeb//4ZB0wJKj0s
         bz88pzV896KJo96BqFs4EA5cnMbdZRuR40YsyotxCXsp4smRnOWAcyUSu73r55N+PO6Z
         L2l7NdxUJ2DavskvGFsz/AxrCdUntaz3Sfx8kDr3Ee8FdqrxXLir/PgSXc/UYqLrGXZf
         L4ykoQep7ta0KFrkZijrFXKKjHdHLuLwZSfMO7MrVsaooXw5R/05ErqgJgtyy1J/Ta50
         h79IiJpPMJtDh6r3jTSfHRQDM0odIsaWlb+qGoywHXj+8Z/AENFTXc/xg51H/QCwTvlz
         RH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778741536; x=1779346336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pIqc2MAKBkie5zPZBTM2DbxYyj5h05wLEO9Nr+qGurs=;
        b=YTQ0fiXVFuH0yynVds/7I2IZd5VzkWgKcIrgshuPOnlJicovNMz5F0CVENCR8PSxlm
         RivTtocTTOUY0EzdO+pYlIumhMxc+cXzQKw5IajMswNmyuvUs1AQFG2TIFWY99YiG3Pi
         AfxdtRDCQRUSNK/nl177TNFaMFa8M7N+TLfsatxVXtkbyNX6lUzPddpDjvFQVzH133xE
         mfjRBarV7XWk3j1hkYc8caxNpAFyco3OLSyGY44dp2gH8AnRLUV+eKt9Nhjm9tnldDSt
         XqjCcY9b6avWV7QN757Ha6JCnyNeUNgGWBxvCXyGi/y6cud3iwBo2dPYJNkrQFiHKxjD
         EcAA==
X-Forwarded-Encrypted: i=1; AFNElJ/LmE6XzIRmYScVPa8a+UEQsh/0zZnXNuHCspFNdQXy/DTnt11wQTydkiG1jCi/WMUBioKlObl38KoziG9+cFUz@vger.kernel.org
X-Gm-Message-State: AOJu0YyxmD5uMM1ocxqOKbvdtUOy6bDrqMIeNAUIg/5CXFpbq/M/CoYF
	1719QKe2h/4Rfn0bTx1H9p0mvLAWhyPF8ahopUu2q5yNSDC8+4cfVMB83OIXgWiYYeGtsj6ZzpG
	xcGqnvJ4fWUWBQ3n4nAn72wMNKS/eBjgGAtsGIRkHVg==
X-Gm-Gg: Acq92OGkAOOCHgFBnM2OWWOPzA01WmXtcSXYHqvP4Wt1at4hmHzeBZfZNL5bTX8NkeP
	cYCzmiR95XZ8RIJ91AP8WGMVdNEw7T8C6lx7QsZtpCKOSGR9DUGl9EXLiPJdlWH5KqhJn4uOUj7
	vftOU+95ywasv5mE7HTyyMsHY59GEGJDl+SrAIaOA+sggWSep5XNRnZa7yiY7h2UbW+pAIiRHno
	xzR29DCxwuaDGhKuW0n1ntkJHTAm3bxOfqw1F4QAYSFUVrAryR/R6bZYty2PdwImEQoRXYvovhx
	e9ZGIDk=
X-Received: by 2002:a05:6512:ac7:b0:5a2:bedb:2119 with SMTP id
 2adb3069b0e04-5a8ef9a8ffemr2132509e87.26.1778741536115; Wed, 13 May 2026
 23:52:16 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 13 May 2026 23:52:14 -0700
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 13 May 2026 23:52:14 -0700
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
References: <cover.1778331862.git.zhangzhanpeng.jasper@bytedance.com>
 <7d86cbd47688700fbdfc27e530e824a6bec0548c.1778331862.3.git.zhangzhanpeng.jasper@bytedance.com>
 <CA+Ht8=bxZicrzVCrHREQubx8DprS69j_Qdv9tpJ0SNNzMpbV7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <CA+Ht8=bxZicrzVCrHREQubx8DprS69j_Qdv9tpJ0SNNzMpbV7g@mail.gmail.com>
Date: Wed, 13 May 2026 23:52:14 -0700
X-Gm-Features: AVHnY4JW-tN77iFx5LP6umOmauR_k-bCEoPLmk9A563zD0dMkfT4iTOfrPjsruM
Message-ID: <CACnXVndQ6b_W31s0AuCBGw25prbGLYcmZrkTLwaX78vdyCGxJA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v9 3/5] drivers: firmware: add riscv SSE support
To: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Conor Dooley <conor@kernel.org>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Himanshu Chauhan <himanshu@thechauhan.dev>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Atish Patra <atish.patra@linux.dev>, 
	Anup Patel <anup@brainfault.org>, Shuah Khan <shuah@kernel.org>, 
	Yunhui Cui <cuiyunhui@bytedance.com>, Zhu Yuan <yuanzhu@bytedance.com>, 
	Himanshu Chauhan <hchauhan@ventanamicro.com>, Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Himanshu,

Yes, absolutely.

Thanks for offering to help maintain the SSE implementation. I will update
the MAINTAINERS entry in the next revision and list you as co-maintainer
instead of reviewer.

Your RISC-V RAS series is an important real user of SSE, so let's keep
both series aligned as they move forward.

Regards,
Zhanpeng

> From: "Himanshu Chauhan"<himanshu.chauhan@oss.qualcomm.com>
> Date:=C2=A0 Wed, May 13, 2026, 15:49
> Subject:=C2=A0 [External] Re: [PATCH v9 3/5] drivers: firmware: add riscv=
 SSE support
> To: "Zhanpeng Zhang"<zhangzhanpeng.jasper@bytedance.com>
> Cc: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>, <l=
inux-perf-users@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, <kvm@v=
ger.kernel.org>, <kvm-riscv@lists.infradead.org>, "Paul Walmsley"<pjw@kerne=
l.org>, "Palmer Dabbelt"<palmer@dabbelt.com>, "Albert Ou"<aou@eecs.berkeley=
.edu>, "Alexandre Ghiti"<alex@ghiti.fr>, "Conor Dooley"<conor@kernel.org>, =
"Cl=C3=A9ment L=C3=A9ger"<cleger@rivosinc.com>, "Himanshu Chauhan"<himanshu=
@thechauhan.dev>, "Will Deacon"<will@kernel.org>, "Mark Rutland"<mark.rutla=
nd@arm.com>, "Atish Patra"<atish.patra@linux.dev>, "Anup Patel"<anup@brainf=
ault.org>, "Shuah Khan"<shuah@kernel.org>, "Yunhui Cui"<cuiyunhui@bytedance=
.com>, "Zhu Yuan"<yuanzhu@bytedance.com>, "Himanshu Chauhan"<hchauhan@venta=
namicro.com>, "Conor Dooley"<conor.dooley@microchip.com>
> Hi Zhanpeng,
>
> On Sat, May 9, 2026 at 6:41=E2=80=AFPM Zhanpeng Zhang
> <zhangzhanpeng.jasper@bytedance.com> wrote:
> >
> > From: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> >
> > Add a driver-level interface for RISC-V SSE support. =C2=A0The interfac=
e lets
> > Linux clients register handlers and enable, disable and complete SSE
> > events. =C2=A0It will be used by PMU and GHES drivers.
> >
> > Co-developed-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
> > Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
> > Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> > Co-developed-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
> > Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> > =C2=A0MAINTAINERS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A016 +
> > =C2=A0drivers/firmware/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 1 +
> > =C2=A0drivers/firmware/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| =C2=A0 1 +
> > =C2=A0drivers/firmware/riscv/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=
=A015 +
> > =C2=A0drivers/firmware/riscv/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=
=A0 3 +
> > =C2=A0drivers/firmware/riscv/riscv_sbi_sse.c | 694 ++++++++++++++++++++=
+++++
> > =C2=A0include/linux/riscv_sbi_sse.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 =C2=A057 ++
> > =C2=A07 files changed, 787 insertions(+)
> > =C2=A0create mode 100644 drivers/firmware/riscv/Kconfig
> > =C2=A0create mode 100644 drivers/firmware/riscv/Makefile
> > =C2=A0create mode 100644 drivers/firmware/riscv/riscv_sbi_sse.c
> > =C2=A0create mode 100644 include/linux/riscv_sbi_sse.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 2fb1c75afd16..c247acc56d1c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -22914,6 +22914,13 @@ T: =C2=A0 =C2=A0 git git://git.kernel.org/pub/=
scm/linux/kernel/git/iommu/linux.git
> > =C2=A0F: =C2=A0 =C2=A0 Documentation/devicetree/bindings/iommu/riscv,io=
mmu.yaml
> > =C2=A0F: =C2=A0 =C2=A0 drivers/iommu/riscv/
> >
> > +RISC-V FIRMWARE DRIVERS
> > +M: =C2=A0 =C2=A0 Conor Dooley <conor@kernel.org>
> > +L: =C2=A0 =C2=A0 linux-riscv@lists.infradead.org
> > +S: =C2=A0 =C2=A0 Maintained
> > +T: =C2=A0 =C2=A0 git git://git.kernel.org/pub/scm/linux/kernel/git/con=
or/linux.git
> > +F: =C2=A0 =C2=A0 drivers/firmware/riscv/
> > +
> > =C2=A0RISC-V MICROCHIP SUPPORT
> > =C2=A0M: =C2=A0 =C2=A0 Conor Dooley <conor.dooley@microchip.com>
> > =C2=A0M: =C2=A0 =C2=A0 Daire McNamara <daire.mcnamara@microchip.com>
> > @@ -22999,6 +23006,15 @@ F: =C2=A0 =C2=A0 arch/riscv/boot/dts/spacemit/
> > =C2=A0N: =C2=A0 =C2=A0 spacemit
> > =C2=A0K: =C2=A0 =C2=A0 spacemit
> >
> > +RISC-V SSE DRIVER
> > +M: =C2=A0 =C2=A0 Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
> > +R: =C2=A0 =C2=A0 Himanshu Chauhan <himanshu@thechauhan.dev>
>
> If Clement is not interested in maintaining the SSE implementation,
> please add me as the co-maintainer not just reviewer for SSE.
>
> Regards
> Himanshu
>
> > +R: =C2=A0 =C2=A0 Yunhui Cui <cuiyunhui@bytedance.com>
> > +L: =C2=A0 =C2=A0 linux-riscv@lists.infradead.org
> > +S: =C2=A0 =C2=A0 Maintained
> > +F: =C2=A0 =C2=A0 drivers/firmware/riscv/riscv_sbi_sse.c
> > +F: =C2=A0 =C2=A0 include/linux/riscv_sbi_sse.h
> > +
> > =C2=A0RISC-V TENSTORRENT SoC SUPPORT
> > =C2=A0M: =C2=A0 =C2=A0 Drew Fustini <dfustini@oss.tenstorrent.com>
> > =C2=A0M: =C2=A0 =C2=A0 Joel Stanley <jms@oss.tenstorrent.com>
> > diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> > index bbd2155d8483..1894df87b08e 100644
> > --- a/drivers/firmware/Kconfig
> > +++ b/drivers/firmware/Kconfig
> > @@ -294,6 +294,7 @@ source "drivers/firmware/meson/Kconfig"
> > =C2=A0source "drivers/firmware/microchip/Kconfig"
> > =C2=A0source "drivers/firmware/psci/Kconfig"
> > =C2=A0source "drivers/firmware/qcom/Kconfig"
> > +source "drivers/firmware/riscv/Kconfig"
> > =C2=A0source "drivers/firmware/samsung/Kconfig"
> > =C2=A0source "drivers/firmware/smccc/Kconfig"
> > =C2=A0source "drivers/firmware/tegra/Kconfig"
> > diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
> > index 4ddec2820c96..6cdd84570ea7 100644
> > --- a/drivers/firmware/Makefile
> > +++ b/drivers/firmware/Makefile
> > @@ -34,6 +34,7 @@ obj-y =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +=3D efi/
> > =C2=A0obj-y =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=3D imx/
> > =C2=A0obj-y =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=3D psci/
> > =C2=A0obj-y =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=3D qcom/
> > +obj-y =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0+=3D riscv/
> > =C2=A0obj-y =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=3D samsung/
> > =C2=A0obj-y =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=3D smccc/
> > =C2=A0obj-y =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=3D tegra/
> > diff --git a/drivers/firmware/riscv/Kconfig b/drivers/firmware/riscv/Kc=
onfig
> > new file mode 100644
> > index 000000000000..ed5b663ac5f9
> > --- /dev/null
> > +++ b/drivers/firmware/riscv/Kconfig
> > @@ -0,0 +1,15 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +menu "Risc-V Specific firmware drivers"
> > +depends on RISCV
> > +
> > +config RISCV_SBI_SSE
> > + =C2=A0 =C2=A0 =C2=A0 bool "Enable SBI Supervisor Software Events supp=
ort"
> > + =C2=A0 =C2=A0 =C2=A0 depends on RISCV_SBI
> > + =C2=A0 =C2=A0 =C2=A0 default y
> > + =C2=A0 =C2=A0 =C2=A0 help
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 The Supervisor Software Events support al=
lows the SBI to deliver
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 NMI-like notifications to the supervisor =
mode software. When enabled,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 this option provides support to register =
callbacks on specific SSE
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 events.
> > +
> > +endmenu
> > diff --git a/drivers/firmware/riscv/Makefile b/drivers/firmware/riscv/M=
akefile
> > new file mode 100644
> > index 000000000000..c8795d4bbb2e
> > --- /dev/null
> > +++ b/drivers/firmware/riscv/Makefile
> > @@ -0,0 +1,3 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +obj-$(CONFIG_RISCV_SBI_SSE) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=
=3D riscv_sbi_sse.o
> > diff --git a/drivers/firmware/riscv/riscv_sbi_sse.c b/drivers/firmware/=
riscv/riscv_sbi_sse.c
> > new file mode 100644
> > index 000000000000..830011ddd33f
> > --- /dev/null
> > +++ b/drivers/firmware/riscv/riscv_sbi_sse.c
> > @@ -0,0 +1,694 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (C) 2025 Rivos Inc.
> > + */
> > +
> > +#define pr_fmt(fmt) "sse: " fmt
> > +
> > +#include <linux/cpu.h>
> > +#include <linux/cpuhotplug.h>
> > +#include <linux/cpu_pm.h>
> > +#include <linux/hardirq.h>
> > +#include <linux/list.h>
> > +#include <linux/percpu-defs.h>
> > +#include <linux/reboot.h>
> > +#include <linux/riscv_sbi_sse.h>
> > +#include <linux/slab.h>
> > +
> > +#include <asm/sbi.h>
> > +#include <asm/sse.h>
> > +
> > +struct sse_event {
> > + =C2=A0 =C2=A0 =C2=A0 struct list_head list;
> > + =C2=A0 =C2=A0 =C2=A0 u32 evt_id;
> > + =C2=A0 =C2=A0 =C2=A0 u32 priority;
> > + =C2=A0 =C2=A0 =C2=A0 sse_event_handler_fn *handler;
> > + =C2=A0 =C2=A0 =C2=A0 void *handler_arg;
> > + =C2=A0 =C2=A0 =C2=A0 /* Only valid for global events */
> > + =C2=A0 =C2=A0 =C2=A0 unsigned int cpu;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 union {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct sse_registere=
d_event *global;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct sse_registere=
d_event __percpu *local;
> > + =C2=A0 =C2=A0 =C2=A0 };
> > +};
> > +
> > +static int sse_hp_state;
> > +static bool sse_available __ro_after_init;
> > +static DEFINE_SPINLOCK(events_list_lock);
> > +static LIST_HEAD(events);
> > +static DEFINE_MUTEX(sse_mutex);
> > +
> > +struct sse_registered_event {
> > + =C2=A0 =C2=A0 =C2=A0 struct sse_event_arch_data arch;
> > + =C2=A0 =C2=A0 =C2=A0 struct sse_event *event;
> > + =C2=A0 =C2=A0 =C2=A0 unsigned long attr;
> > + =C2=A0 =C2=A0 =C2=A0 bool is_enabled;
> > +};
> > +
> > +void sse_handle_event(struct sse_event_arch_data *arch_event,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 struct pt_regs *regs)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 int ret;
> > + =C2=A0 =C2=A0 =C2=A0 struct sse_registered_event *reg_evt =3D
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 container_of(arch_ev=
ent, struct sse_registered_event, arch);
> > + =C2=A0 =C2=A0 =C2=A0 struct sse_event *evt =3D reg_evt->event;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 ret =3D evt->handler(evt->evt_id, evt->handler_a=
rg, regs);
> > + =C2=A0 =C2=A0 =C2=A0 if (ret)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_warn("event %x ha=
ndler failed with error %d\n", evt->evt_id, ret);
> > +}
> > +
> > +static struct sse_event *sse_event_get(u32 evt)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 struct sse_event *event =3D NULL;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 scoped_guard(spinlock, &events_list_lock) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list_for_each_entry(=
event, &events, list) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (event->evt_id =3D=3D evt)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return event;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> > + =C2=A0 =C2=A0 =C2=A0 }
> > +
> > + =C2=A0 =C2=A0 =C2=A0 return NULL;
> > +}
> > +
> > +static phys_addr_t sse_event_get_attr_phys(struct sse_registered_event=
 *reg_evt)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 phys_addr_t phys;
> > + =C2=A0 =C2=A0 =C2=A0 void *addr =3D &reg_evt->attr;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 if (sse_event_is_global(reg_evt->event->evt_id))
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 phys =3D virt_to_phy=
s(addr);
> > + =C2=A0 =C2=A0 =C2=A0 else
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 phys =3D per_cpu_ptr=
_to_phys(addr);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 return phys;
> > +}
> > +
> > +static struct sse_registered_event *sse_get_reg_evt(struct sse_event *=
event)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 if (sse_event_is_global(event->evt_id))
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return event->global=
;
> > + =C2=A0 =C2=A0 =C2=A0 else
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return per_cpu_ptr(e=
vent->local, smp_processor_id());
> > +}
> > +
> > +static int sse_sbi_event_func(struct sse_event *event, unsigned long f=
unc)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 struct sbiret ret;
> > + =C2=A0 =C2=A0 =C2=A0 u32 evt =3D event->evt_id;
> > + =C2=A0 =C2=A0 =C2=A0 struct sse_registered_event *reg_evt =3D sse_get=
_reg_evt(event);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 ret =3D sbi_ecall(SBI_EXT_SSE, func, evt, 0, 0, =
0, 0, 0);
> > + =C2=A0 =C2=A0 =C2=A0 if (ret.error) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_warn("Failed to e=
xecute func %lx, event %x, error %ld\n",
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 func, evt, ret.error);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return sbi_err_map_l=
inux_errno(ret.error);
> > + =C2=A0 =C2=A0 =C2=A0 }
> > +
> > + =C2=A0 =C2=A0 =C2=A0 if (func =3D=3D SBI_SSE_EVENT_DISABLE)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg_evt->is_enabled =
=3D false;
> > + =C2=A0 =C2=A0 =C2=A0 else if (func =3D=3D SBI_SSE_EVENT_ENABLE)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg_evt->is_enabled =
=3D true;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 return 0;
> > +}
> > +
> > +int sse_event_disable_local(struct sse_event *event)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 return sse_sbi_event_func(event, SBI_SSE_EVENT_D=
ISABLE);
> > +}
> > +EXPORT_SYMBOL_GPL(sse_event_disable_local);
> > +
> > +int sse_event_enable_local(struct sse_event *event)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 return sse_sbi_event_func(event, SBI_SSE_EVENT_E=
NABLE);
> > +}
> > +EXPORT_SYMBOL_GPL(sse_event_enable_local);
> > +
> > +static int sse_event_attr_get_no_lock(struct sse_registered_event *reg=
_evt,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long attr=
_id, unsigned long *val)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 struct sbiret sret;
> > + =C2=A0 =C2=A0 =C2=A0 u32 evt =3D reg_evt->event->evt_id;
> > + =C2=A0 =C2=A0 =C2=A0 unsigned long phys;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 phys =3D sse_event_get_attr_phys(reg_evt);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 sret =3D sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_AT=
TR_READ, evt, attr_id, 1,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0phys, 0, 0);
> > + =C2=A0 =C2=A0 =C2=A0 if (sret.error) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_debug("Failed to =
get event %x attr %lx, error %ld\n", evt,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0attr_id, sret.error);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return sbi_err_map_l=
inux_errno(sret.error);
> > + =C2=A0 =C2=A0 =C2=A0 }
> > +
> > + =C2=A0 =C2=A0 =C2=A0 *val =3D reg_evt->attr;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 return 0;
> > +}
> > +
> > +static int sse_event_attr_set_nolock(struct sse_registered_event *reg_=
evt,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long attr_=
id, unsigned long val)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 struct sbiret sret;
> > + =C2=A0 =C2=A0 =C2=A0 u32 evt =3D reg_evt->event->evt_id;
> > + =C2=A0 =C2=A0 =C2=A0 unsigned long phys;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 reg_evt->attr =3D val;
> > + =C2=A0 =C2=A0 =C2=A0 phys =3D sse_event_get_attr_phys(reg_evt);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 sret =3D sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_AT=
TR_WRITE, evt, attr_id, 1,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0phys, 0, 0);
> > + =C2=A0 =C2=A0 =C2=A0 if (sret.error)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_debug("Failed to =
set event %x attr %lx, error %ld\n", evt,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0attr_id, sret.error);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 return sbi_err_map_linux_errno(sret.error);
> > +}
> > +
> > +static void sse_global_event_update_cpu(struct sse_event *event,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned in=
t cpu)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 struct sse_registered_event *reg_evt =3D event->=
global;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 event->cpu =3D cpu;
> > + =C2=A0 =C2=A0 =C2=A0 arch_sse_event_update_cpu(&reg_evt->arch, cpu);
> > +}
> > +
> > +static int sse_event_set_target_cpu_nolock(struct sse_event *event,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0unsigned int cpu)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 unsigned long hart_id =3D cpuid_to_hartid_map(cp=
u);
> > + =C2=A0 =C2=A0 =C2=A0 struct sse_registered_event *reg_evt =3D event->=
global;
> > + =C2=A0 =C2=A0 =C2=A0 u32 evt =3D event->evt_id;
> > + =C2=A0 =C2=A0 =C2=A0 bool was_enabled;
> > + =C2=A0 =C2=A0 =C2=A0 int ret;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 if (!sse_event_is_global(evt))
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 was_enabled =3D reg_evt->is_enabled;
> > + =C2=A0 =C2=A0 =C2=A0 if (was_enabled)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sse_event_disable_lo=
cal(event);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 ret =3D sse_event_attr_set_nolock(reg_evt, SBI_S=
SE_ATTR_PREFERRED_HART,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hart_id);
> > + =C2=A0 =C2=A0 =C2=A0 if (ret =3D=3D 0)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sse_global_event_upd=
ate_cpu(event, cpu);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 if (was_enabled)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sse_event_enable_loc=
al(event);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 return 0;
> > +}
> > +
> > +int sse_event_set_target_cpu(struct sse_event *event, unsigned int cpu=
)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 int ret;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 scoped_guard(mutex, &sse_mutex) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 scoped_guard(cpus_re=
ad_lock) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (!cpu_online(cpu))
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ret =3D sse_event_set_target_cpu_nolock(event, cpu);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> > + =C2=A0 =C2=A0 =C2=A0 }
> > +
> > + =C2=A0 =C2=A0 =C2=A0 return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(sse_event_set_target_cpu);
> > +
> > +static int sse_event_init_registered(unsigned int cpu,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct sse_register=
ed_event *reg_evt,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct sse_event *e=
vent)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 reg_evt->event =3D event;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 return arch_sse_init_event(&reg_evt->arch, event=
->evt_id, cpu);
> > +}
> > +
> > +static void sse_event_free_registered(struct sse_registered_event *reg=
_evt)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 arch_sse_free_event(&reg_evt->arch);
> > +}
> > +
> > +static int sse_event_alloc_global(struct sse_event *event)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 int err;
> > + =C2=A0 =C2=A0 =C2=A0 struct sse_registered_event *reg_evt;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 reg_evt =3D kzalloc_obj(*reg_evt, GFP_KERNEL);
> > + =C2=A0 =C2=A0 =C2=A0 if (!reg_evt)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 event->global =3D reg_evt;
> > + =C2=A0 =C2=A0 =C2=A0 err =3D sse_event_init_registered(smp_processor_=
id(), reg_evt, event);
> > + =C2=A0 =C2=A0 =C2=A0 if (err)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kfree(reg_evt);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 return err;
> > +}
> > +
> > +static int sse_event_alloc_local(struct sse_event *event)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 int err;
> > + =C2=A0 =C2=A0 =C2=A0 unsigned int cpu, err_cpu;
> > + =C2=A0 =C2=A0 =C2=A0 struct sse_registered_event *reg_evt;
> > + =C2=A0 =C2=A0 =C2=A0 struct sse_registered_event __percpu *reg_evts;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 reg_evts =3D alloc_percpu(struct sse_registered_=
event);
> > + =C2=A0 =C2=A0 =C2=A0 if (!reg_evts)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 event->local =3D reg_evts;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 for_each_possible_cpu(cpu) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg_evt =3D per_cpu_=
ptr(reg_evts, cpu);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D sse_event_in=
it_registered(cpu, reg_evt, event);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 err_cpu =3D cpu;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 goto err_free_per_cpu;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> > + =C2=A0 =C2=A0 =C2=A0 }
> > +
> > + =C2=A0 =C2=A0 =C2=A0 return 0;
> > +
> > +err_free_per_cpu:
> > + =C2=A0 =C2=A0 =C2=A0 for_each_possible_cpu(cpu) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cpu =3D=3D err_c=
pu)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 break;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg_evt =3D per_cpu_=
ptr(reg_evts, cpu);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sse_event_free_regis=
tered(reg_evt);
> > + =C2=A0 =C2=A0 =C2=A0 }
> > +
> > + =C2=A0 =C2=A0 =C2=A0 free_percpu(reg_evts);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 return err;
> > +}
> > +
> > +static struct sse_event *sse_event_alloc(u32 evt, u32 priority,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sse_e=
vent_handler_fn *handler,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void =
*arg)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 int err;
> > + =C2=A0 =C2=A0 =C2=A0 struct sse_event *event;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 event =3D kzalloc_obj(*event, GFP_KERNEL);
> > + =C2=A0 =C2=A0 =C2=A0 if (!event)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ERR_PTR(-ENOM=
EM);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 event->evt_id =3D evt;
> > + =C2=A0 =C2=A0 =C2=A0 event->priority =3D priority;
> > + =C2=A0 =C2=A0 =C2=A0 event->handler_arg =3D arg;
> > + =C2=A0 =C2=A0 =C2=A0 event->handler =3D handler;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 if (sse_event_is_global(evt))
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D sse_event_al=
loc_global(event);
> > + =C2=A0 =C2=A0 =C2=A0 else
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D sse_event_al=
loc_local(event);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 if (err) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kfree(event);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ERR_PTR(err);
> > + =C2=A0 =C2=A0 =C2=A0 }
> > +
> > + =C2=A0 =C2=A0 =C2=A0 return event;
> > +}
> > +
> > +static int sse_sbi_register_event(struct sse_event *event,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct sse_registered_event *reg=
_evt)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 int ret;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 ret =3D sse_event_attr_set_nolock(reg_evt, SBI_S=
SE_ATTR_PRIO,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 event->prio=
rity);
> > + =C2=A0 =C2=A0 =C2=A0 if (ret)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 return arch_sse_register_event(&reg_evt->arch);
> > +}
> > +
> > +static int sse_event_register_local(struct sse_event *event)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 int ret;
> > + =C2=A0 =C2=A0 =C2=A0 struct sse_registered_event *reg_evt;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 reg_evt =3D per_cpu_ptr(event->local, smp_proces=
sor_id());
> > + =C2=A0 =C2=A0 =C2=A0 ret =3D sse_sbi_register_event(event, reg_evt);
> > + =C2=A0 =C2=A0 =C2=A0 if (ret)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_debug("Failed to =
register event %x: err %d\n", event->evt_id,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0ret);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 return ret;
> > +}
> > +
> > +static int sse_sbi_unregister_event(struct sse_event *event)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 return sse_sbi_event_func(event, SBI_SSE_EVENT_U=
NREGISTER);
> > +}
> > +
> > +struct sse_per_cpu_evt {
> > + =C2=A0 =C2=A0 =C2=A0 struct sse_event *event;
> > + =C2=A0 =C2=A0 =C2=A0 unsigned long func;
> > + =C2=A0 =C2=A0 =C2=A0 cpumask_t error;
> > +};
> > +
> > +static void sse_event_per_cpu_func(void *info)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 int ret;
> > + =C2=A0 =C2=A0 =C2=A0 struct sse_per_cpu_evt *cpu_evt =3D info;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 if (cpu_evt->func =3D=3D SBI_SSE_EVENT_REGISTER)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D sse_event_re=
gister_local(cpu_evt->event);
> > + =C2=A0 =C2=A0 =C2=A0 else
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D sse_sbi_even=
t_func(cpu_evt->event, cpu_evt->func);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 if (ret)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_set_cpu(smp_=
processor_id(), &cpu_evt->error);
> > +}
> > +
> > +static void sse_event_free(struct sse_event *event)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 unsigned int cpu;
> > + =C2=A0 =C2=A0 =C2=A0 struct sse_registered_event *reg_evt;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 if (sse_event_is_global(event->evt_id)) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sse_event_free_regis=
tered(event->global);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kfree(event->global)=
;
> > + =C2=A0 =C2=A0 =C2=A0 } else {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for_each_possible_cp=
u(cpu) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 reg_evt =3D per_cpu_ptr(event->local, cpu);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 sse_event_free_registered(reg_evt);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free_percpu(event->l=
ocal);
> > + =C2=A0 =C2=A0 =C2=A0 }
> > +
> > + =C2=A0 =C2=A0 =C2=A0 kfree(event);
> > +}
> > +
> > +static int sse_on_each_cpu(struct sse_event *event, unsigned long func=
,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0unsigned long revert_func)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 struct sse_per_cpu_evt cpu_evt;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 cpu_evt.event =3D event;
> > + =C2=A0 =C2=A0 =C2=A0 cpumask_clear(&cpu_evt.error);
> > + =C2=A0 =C2=A0 =C2=A0 cpu_evt.func =3D func;
> > + =C2=A0 =C2=A0 =C2=A0 on_each_cpu(sse_event_per_cpu_func, &cpu_evt, 1)=
;
> > + =C2=A0 =C2=A0 =C2=A0 /*
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* If there are some error reported by CPUs=
, revert event state on the
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* other ones
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> > + =C2=A0 =C2=A0 =C2=A0 if (!cpumask_empty(&cpu_evt.error)) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_t revert;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_andnot(&reve=
rt, cpu_online_mask, &cpu_evt.error);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_evt.func =3D rev=
ert_func;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 on_each_cpu_mask(&re=
vert, sse_event_per_cpu_func, &cpu_evt, 1);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EIO;
> > + =C2=A0 =C2=A0 =C2=A0 }
> > +
> > + =C2=A0 =C2=A0 =C2=A0 return 0;
> > +}
> > +
> > +int sse_event_enable(struct sse_event *event)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 int ret =3D 0;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 scoped_guard(mutex, &sse_mutex) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 scoped_guard(cpus_re=
ad_lock) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (sse_event_is_global(event->evt_id)) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D sse_event_enable_local(event);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 } else {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D sse_on_each_cpu(event,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SBI_SSE_EVENT_ENABLE,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SBI_SSE_EVENT_DISABLE);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 }
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> > + =C2=A0 =C2=A0 =C2=A0 }
> > + =C2=A0 =C2=A0 =C2=A0 return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(sse_event_enable);
> > +
> > +static int sse_events_mask(void)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 struct sbiret ret;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 ret =3D sbi_ecall(SBI_EXT_SSE, SBI_SSE_HART_MASK=
, 0, 0, 0, 0, 0, 0);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 return sbi_err_map_linux_errno(ret.error);
> > +}
> > +
> > +static int sse_events_unmask(void)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 struct sbiret ret;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 ret =3D sbi_ecall(SBI_EXT_SSE, SBI_SSE_HART_UNMA=
SK, 0, 0, 0, 0, 0, 0);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 return sbi_err_map_linux_errno(ret.error);
> > +}
> > +
> > +static void sse_event_disable_nolock(struct sse_event *event)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 struct sse_per_cpu_evt cpu_evt;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 if (sse_event_is_global(event->evt_id)) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sse_event_disable_lo=
cal(event);
> > + =C2=A0 =C2=A0 =C2=A0 } else {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_evt.event =3D ev=
ent;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_evt.func =3D SBI=
_SSE_EVENT_DISABLE;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 on_each_cpu(sse_even=
t_per_cpu_func, &cpu_evt, 1);
> > + =C2=A0 =C2=A0 =C2=A0 }
> > +}
> > +
> > +void sse_event_disable(struct sse_event *event)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 scoped_guard(mutex, &sse_mutex) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 scoped_guard(cpus_re=
ad_lock) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 sse_event_disable_nolock(event);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> > + =C2=A0 =C2=A0 =C2=A0 }
> > +}
> > +EXPORT_SYMBOL_GPL(sse_event_disable);
> > +
> > +struct sse_event *sse_event_register(u32 evt, u32 priority,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sse_event_handler_f=
n *handler, void *arg)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 struct sse_event *event;
> > + =C2=A0 =C2=A0 =C2=A0 int cpu;
> > + =C2=A0 =C2=A0 =C2=A0 int ret =3D 0;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 if (!sse_available)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ERR_PTR(-EOPN=
OTSUPP);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 guard(mutex)(&sse_mutex);
> > + =C2=A0 =C2=A0 =C2=A0 if (sse_event_get(evt))
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ERR_PTR(-EEXI=
ST);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 event =3D sse_event_alloc(evt, priority, handler=
, arg);
> > + =C2=A0 =C2=A0 =C2=A0 if (IS_ERR(event))
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return event;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 scoped_guard(cpus_read_lock) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sse_event_is_glo=
bal(evt)) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 unsigned long preferred_hart;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ret =3D sse_event_attr_get_no_lock(event->global,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SBI_SSE_ATTR_PREFERRED_=
HART,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&preferred_hart);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (ret)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_event_free;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 cpu =3D riscv_hartid_to_cpuid(preferred_hart);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 sse_global_event_update_cpu(event, cpu);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ret =3D sse_sbi_register_event(event, event->global);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (ret)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_event_free;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ret =3D sse_on_each_cpu(event, SBI_SSE_EVENT_REGISTER,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 SBI_SSE_EVENT_DISABLE);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (ret)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_event_free;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> > + =C2=A0 =C2=A0 =C2=A0 }
> > +
> > + =C2=A0 =C2=A0 =C2=A0 scoped_guard(spinlock, &events_list_lock)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list_add(&event->lis=
t, &events);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 return event;
> > +
> > +err_event_free:
> > + =C2=A0 =C2=A0 =C2=A0 sse_event_free(event);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 return ERR_PTR(ret);
> > +}
> > +EXPORT_SYMBOL_GPL(sse_event_register);
> > +
> > +static void sse_event_unregister_nolock(struct sse_event *event)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 struct sse_per_cpu_evt cpu_evt;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 if (sse_event_is_global(event->evt_id)) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sse_sbi_unregister_e=
vent(event);
> > + =C2=A0 =C2=A0 =C2=A0 } else {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_evt.event =3D ev=
ent;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_evt.func =3D SBI=
_SSE_EVENT_UNREGISTER;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 on_each_cpu(sse_even=
t_per_cpu_func, &cpu_evt, 1);
> > + =C2=A0 =C2=A0 =C2=A0 }
> > +}
> > +
> > +void sse_event_unregister(struct sse_event *event)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 scoped_guard(mutex, &sse_mutex) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 scoped_guard(cpus_re=
ad_lock)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 sse_event_unregister_nolock(event);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 scoped_guard(spinloc=
k, &events_list_lock)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 list_del(&event->list);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sse_event_free(event=
);
> > + =C2=A0 =C2=A0 =C2=A0 }
> > +}
> > +EXPORT_SYMBOL_GPL(sse_event_unregister);
> > +
> > +static int sse_cpu_online(unsigned int cpu)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 struct sse_event *event;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 scoped_guard(spinlock, &events_list_lock) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list_for_each_entry(=
event, &events, list) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (sse_event_is_global(event->evt_id))
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 sse_event_register_local(event);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (sse_get_reg_evt(event))
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sse_event_enable_local(event);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> > + =C2=A0 =C2=A0 =C2=A0 }
> > +
> > + =C2=A0 =C2=A0 =C2=A0 /* Ready to handle events. Unmask SSE. */
> > + =C2=A0 =C2=A0 =C2=A0 return sse_events_unmask();
> > +}
> > +
> > +static int sse_cpu_teardown(unsigned int cpu)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 int ret =3D 0;
> > + =C2=A0 =C2=A0 =C2=A0 unsigned int next_cpu;
> > + =C2=A0 =C2=A0 =C2=A0 struct sse_event *event;
> > + =C2=A0 =C2=A0 =C2=A0 struct sse_registered_event *reg_evt;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 /* Mask the sse events */
> > + =C2=A0 =C2=A0 =C2=A0 ret =3D sse_events_mask();
> > + =C2=A0 =C2=A0 =C2=A0 if (ret)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 scoped_guard(spinlock, &events_list_lock) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list_for_each_entry(=
event, &events, list) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 /* Disable local event on current cpu */
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (!sse_event_is_global(event->evt_id)) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg_evt =3D sse_get_reg_evt(event);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (reg_evt->is_enabled)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sse_event_d=
isable_local(event);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sse_sbi_unregister_event(event);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 }
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (event->cpu !=3D smp_processor_id())
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 /* Update destination hart for global event */
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 next_cpu =3D cpumask_any_but(cpu_online_mask, cpu);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ret =3D sse_event_set_target_cpu_nolock(event, next_cpu);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> > + =C2=A0 =C2=A0 =C2=A0 }
> > +
> > + =C2=A0 =C2=A0 =C2=A0 return ret;
> > +}
> > +
> > +static int sse_pm_notifier(struct notifier_block *nb, unsigned long ac=
tion,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0void *data)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 WARN_ON_ONCE(preemptible());
> > +
> > + =C2=A0 =C2=A0 =C2=A0 switch (action) {
> > + =C2=A0 =C2=A0 =C2=A0 case CPU_PM_ENTER:
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sse_events_mask();
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> > + =C2=A0 =C2=A0 =C2=A0 case CPU_PM_EXIT:
> > + =C2=A0 =C2=A0 =C2=A0 case CPU_PM_ENTER_FAILED:
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sse_events_unmask();
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> > + =C2=A0 =C2=A0 =C2=A0 default:
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NOTIFY_DONE;
> > + =C2=A0 =C2=A0 =C2=A0 }
> > +
> > + =C2=A0 =C2=A0 =C2=A0 return NOTIFY_OK;
> > +}
> > +
> > +static struct notifier_block sse_pm_nb =3D {
> > + =C2=A0 =C2=A0 =C2=A0 .notifier_call =3D sse_pm_notifier,
> > +};
> > +
> > +/*
> > + * Mask all CPUs and unregister all events on panic, reboot or kexec.
> > + */
> > +static int sse_reboot_notifier(struct notifier_block *nb, unsigned lon=
g action,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *data)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 cpuhp_remove_state(sse_hp_state);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 return NOTIFY_OK;
> > +}
> > +
> > +static struct notifier_block sse_reboot_nb =3D {
> > + =C2=A0 =C2=A0 =C2=A0 .notifier_call =3D sse_reboot_notifier,
> > +};
> > +
> > +static int __init sse_init(void)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 int ret;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 if (sbi_probe_extension(SBI_EXT_SSE) <=3D 0) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_info("Missing SBI=
 SSE extension\n");
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EOPNOTSUPP;
> > + =C2=A0 =C2=A0 =C2=A0 }
> > + =C2=A0 =C2=A0 =C2=A0 pr_info("SBI SSE extension detected\n");
> > +
> > + =C2=A0 =C2=A0 =C2=A0 ret =3D cpu_pm_register_notifier(&sse_pm_nb);
> > + =C2=A0 =C2=A0 =C2=A0 if (ret) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_warn("Failed to r=
egister CPU PM notifier...\n");
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
> > + =C2=A0 =C2=A0 =C2=A0 }
> > +
> > + =C2=A0 =C2=A0 =C2=A0 ret =3D register_reboot_notifier(&sse_reboot_nb)=
;
> > + =C2=A0 =C2=A0 =C2=A0 if (ret) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_warn("Failed to r=
egister reboot notifier...\n");
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto remove_cpupm;
> > + =C2=A0 =C2=A0 =C2=A0 }
> > +
> > + =C2=A0 =C2=A0 =C2=A0 ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "=
riscv/sse:online",
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sse_cpu_online, sse_cpu_teardown);
> > + =C2=A0 =C2=A0 =C2=A0 if (ret < 0)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto remove_reboot;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 sse_hp_state =3D ret;
> > + =C2=A0 =C2=A0 =C2=A0 sse_available =3D true;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 return 0;
> > +
> > +remove_reboot:
> > + =C2=A0 =C2=A0 =C2=A0 unregister_reboot_notifier(&sse_reboot_nb);
> > +
> > +remove_cpupm:
> > + =C2=A0 =C2=A0 =C2=A0 cpu_pm_unregister_notifier(&sse_pm_nb);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 return ret;
> > +}
> > +arch_initcall(sse_init);
> > diff --git a/include/linux/riscv_sbi_sse.h b/include/linux/riscv_sbi_ss=
e.h
> > new file mode 100644
> > index 000000000000..84165cb5f2d0
> > --- /dev/null
> > +++ b/include/linux/riscv_sbi_sse.h
> > @@ -0,0 +1,57 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * Copyright (C) 2025 Rivos Inc.
> > + */
> > +
> > +#ifndef __LINUX_RISCV_SBI_SSE_H
> > +#define __LINUX_RISCV_SBI_SSE_H
> > +
> > +#include <linux/types.h>
> > +#include <linux/linkage.h>
> > +
> > +struct sse_event;
> > +struct pt_regs;
> > +
> > +typedef int (sse_event_handler_fn)(u32 event_num, void *arg,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct pt_regs *regs);
> > +
> > +#ifdef CONFIG_RISCV_SBI_SSE
> > +
> > +struct sse_event *sse_event_register(u32 event_num, u32 priority,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sse_event_handler_f=
n *handler, void *arg);
> > +
> > +void sse_event_unregister(struct sse_event *evt);
> > +
> > +int sse_event_set_target_cpu(struct sse_event *sse_evt, unsigned int c=
pu);
> > +
> > +int sse_event_enable(struct sse_event *sse_evt);
> > +
> > +void sse_event_disable(struct sse_event *sse_evt);
> > +
> > +int sse_event_enable_local(struct sse_event *sse_evt);
> > +int sse_event_disable_local(struct sse_event *sse_evt);
> > +
> > +#else
> > +static inline struct sse_event *sse_event_register(u32 event_num, u32 =
priority,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sse_event_handler_fn *handler,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *arg)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 return ERR_PTR(-EOPNOTSUPP);
> > +}
> > +
> > +static inline void sse_event_unregister(struct sse_event *evt) {}
> > +
> > +static inline int sse_event_set_target_cpu(struct sse_event *sse_evt,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0unsigned int cpu)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 return -EOPNOTSUPP;
> > +}
> > +
> > +static inline int sse_event_enable(struct sse_event *sse_evt)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 return -EOPNOTSUPP;
> > +}
> > +
> > +static inline void sse_event_disable(struct sse_event *sse_evt) {}
> > +#endif
> > +#endif /* __LINUX_RISCV_SBI_SSE_H */
> > --
> > 2.50.1 (Apple Git-155)
> >
>
