Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562B21D516D
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Jan 2025 02:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737687405; cv=none; b=fD3EtvBM112vCui4xtNsq9JP2uYwd8QebND8TPgQoLb6/uJLmJhOFKpGkF84wQSkt0YD4B3xbGL6tmWCbMwSQoBssb/CFI+qdCONxaKT7upmG9q33PXwA+ogrQODJRvfdEVTULM2NL09wjvYoqRZ6z3DqxBajtrqeSr6sdcepwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737687405; c=relaxed/simple;
	bh=PTt9yUYHz1WlqkLajfkpzLukF1LjkiiAoaJjBfIy1Us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mssd7+80RWDhHLKkjFOyagr9kAKpEgcQCQj5njaR8FYaChpK5WMNt2F+Y5GrsJrlOgtlsUx/8BeaNmdlOyi0BA6uWUev8xyV2S0EnKi1ALNX4zZIAT93LMUxofbttHdVgvud05Z1/cphokAosqBwNSBqaQJEVzvrTz0xsN9/qDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=er4SvOJa; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="er4SvOJa"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-29f88004a92so855000fac.1
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Jan 2025 18:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1737687402; x=1738292202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+UEYg8yBcvYvQRoa6Z9nHSLCJyT1DAKK6Q+y1yd4C4=;
        b=er4SvOJabAcohAEGcRT+Fxv60VcB5JWuSEGkyvQ6jdpsAwq4MZhXnyFy+8uYZaJvd/
         2S9XT86oUrjObhQkri6m9GfPTP31PKnHUmiEEXIb/DqzyN3yOJGClK1PMQJRrd7Qxnor
         0f25rh6t4nmD8KToqNUesfWzNMcr2oRPktgBWp3CpOZE6axunq3DQ2grXKLut0tzRjVe
         ONOt6bukBpbtqooPIBBq2S+rrUjz8/AfkLWBl24c9x6GiO/dIzwQdz/jbSr+SdnniXmT
         k6K4pcAdoZhCHcutEqO+fVkZVCM9CM4J9cXt1VpMrgGSgA0m10N4vXLcYzifbGpd4bWD
         YVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737687402; x=1738292202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+UEYg8yBcvYvQRoa6Z9nHSLCJyT1DAKK6Q+y1yd4C4=;
        b=azsyQS71LQFDOTZ3WcLLAw5uWYHnrHBTkfGcI2QofNXaMoyYTZ+iAjIaaVTXOMGxeG
         YBLokVeP7uGPA9rvbr5t/y02L403NqSqx7ilUQ6Kxk19gGGzT/jdZK9kD9RPVJgtYjhP
         m4fBnaXFrC7y7w0nSB9poL6sV5FnCuKEItd5y4CXlCc3DCKc+XGBKwtyLZ1116eDgY1A
         oOFqGaWmR9WqEc6mv2rBAA7vZxAFJAFzo/Ee6pmzYSY3a2lBK/SzjnB/hZ07e4HL/DZI
         o24YqNI0Q0lTVe1P/iXdYaYlYqnXiCuj2nUxFv4WKLUdGnSw+hwlT27TAFdU5JBqphV6
         shwQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/C+NNeVOTum085xjjagfU1QsqVMPNSpPrllrqpi2r8iBq05JWN7SxLTi2j7aDvChnYPpekiVS9x5w//QlMCZW@vger.kernel.org
X-Gm-Message-State: AOJu0YyodfsCvTUXeCMatcJQZls9YdFAx+iY1PT19xsDz9H95r/7XAit
	9QOd0Ku1RcOzYdIYO8hMkJ/+FVTH7RvE1lrBAYIOg/Dj0rDldNrLzPhaiQkovZ4kXNDr9FRHHQX
	dRlsSVNLuNth+Hyx76+nG1UQtyUCsSUeTsftwljMAAQFQtLuGFP8=
X-Gm-Gg: ASbGncs49Sc7FHN/gbkcJ/g4VR+MJsMOE42CRaUR+7Nu9FJQ6M2r0Opv7XbsS7nKlbz
	Rz85n0OmEW6QDpHENDYd6M3AlTs+TrPEdIypMJavkb5qKIkR60UMudsqqldqxYw2QOnBLWbqBvr
	8=
X-Google-Smtp-Source: AGHT+IFvccqYDtTosunleX52S76fRS2nHOiXrmTkjIrWtcBaeAa/R0S2lFwUYOrpQh4wE0C+yQ74/Ca3nlf0RyKXIA4=
X-Received: by 2002:a05:6871:3a88:b0:29e:2422:49f9 with SMTP id
 586e51a60fabf-2b1c0aee5efmr15513286fac.25.1737687402270; Thu, 23 Jan 2025
 18:56:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123074830.90923-1-cuiyunhui@bytedance.com> <344c53cd-d856-4c03-9deb-743b65acd8aa@linux.alibaba.com>
In-Reply-To: <344c53cd-d856-4c03-9deb-743b65acd8aa@linux.alibaba.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 24 Jan 2025 10:56:31 +0800
X-Gm-Features: AWEUYZl4Lf_RFEPxQH5F4xNkyRUuNIZoJ2aW5YdkMvz7JRVMtXEGdp033WP-qYk
Message-ID: <CAEEQ3wmDej9bbPUmkx-ZrD4FG9Z7gTHMeCrVszx64g90O0RyiQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] perf/dwc_pcie: fix duplicate pci_dev devices
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: renyu.zj@linux.alibaba.com, will@kernel.org, mark.rutland@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuai,

On Thu, Jan 23, 2025 at 5:50=E2=80=AFPM Shuai Xue <xueshuai@linux.alibaba.c=
om> wrote:
>
>
>
> =E5=9C=A8 2025/1/23 15:48, Yunhui Cui =E5=86=99=E9=81=93:
> > During platform_device_register, wrongly using struct device
> > pci_dev as platform_data caused a kmemdup copy of pci_dev. Worse
> > still, accessing the duplicated device leads to list corruption as its
> > mutex content (e.g., list, magic) remains the same as the original.
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >   drivers/perf/dwc_pcie_pmu.c | 25 ++++++++++++++++++-------
> >   1 file changed, 18 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> > index cccecae9823f..8b208f287a1f 100644
> > --- a/drivers/perf/dwc_pcie_pmu.c
> > +++ b/drivers/perf/dwc_pcie_pmu.c
> > @@ -565,9 +565,7 @@ static int dwc_pcie_register_dev(struct pci_dev *pd=
ev)
> >       u32 sbdf;
> >
> >       sbdf =3D (pci_domain_nr(pdev->bus) << 16) | PCI_DEVID(pdev->bus->=
number, pdev->devfn);
> > -     plat_dev =3D platform_device_register_data(NULL, "dwc_pcie_pmu", =
sbdf,
> > -                                              pdev, sizeof(*pdev));
> > -
> > +     plat_dev =3D platform_device_register_simple("platform_dwc_pcie",=
 sbdf, NULL, 0);
> >       if (IS_ERR(plat_dev))
> >               return PTR_ERR(plat_dev);
> >
> > @@ -614,19 +612,32 @@ static struct notifier_block dwc_pcie_pmu_nb =3D =
{
> >
> >   static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
> >   {
> > -     struct pci_dev *pdev =3D plat_dev->dev.platform_data;
> > +     struct pci_dev *pdev =3D NULL;
> >       struct dwc_pcie_pmu *pcie_pmu;
> > +     bool found =3D false;
> >       char *name;
> >       u32 sbdf;
> >       u16 vsec;
> >       int ret;
> >
> > +     for_each_pci_dev(pdev) {
> > +             sbdf =3D (pci_domain_nr(pdev->bus) << 16) | PCI_DEVID(pde=
v->bus->number, pdev->devfn);
> > +             if (sbdf =3D=3D plat_dev->id) {
> > +                     found =3D true;
> > +                     break;
> > +             }
> > +     }
> > +     if (!found) {
> > +             pr_err("The plat_dev->id does not match the sbdf");
> > +             return -ENODEV;
> > +     }
> > +
>
> How about using pci_get_domain_bus_and_slot() to find pci_dev?
It's not necessary. pci_get_domain_bus_and_slot also invokes
for_each_pci_dev, and it further requires splitting the sbdf.

>
> >       vsec =3D dwc_pcie_des_cap(pdev);
> >       if (!vsec)
> >               return -ENODEV;
> >
> >       sbdf =3D plat_dev->id;
> > -     name =3D devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_rootport=
_%x", sbdf);
> > +     name =3D devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_rootport=
_%d_pmu", sbdf);
>
> A new name will break previous user tools.
This name isn't suitable. It can't clearly show which is the PMU
device. Userspace tools don't have binding relationships, like perf.
Tools must traverse PMU devices before use.

>
> >       if (!name)
> >               return -ENOMEM;
> >
> > @@ -640,7 +651,7 @@ static int dwc_pcie_pmu_probe(struct platform_devic=
e *plat_dev)
> >       pcie_pmu->on_cpu =3D -1;
> >       pcie_pmu->pmu =3D (struct pmu){
> >               .name           =3D name,
> > -             .parent         =3D &pdev->dev,
> > +             .parent         =3D &plat_dev->dev,
> >               .module         =3D THIS_MODULE,
> >               .attr_groups    =3D dwc_pcie_attr_groups,
> >               .capabilities   =3D PERF_PMU_CAP_NO_EXCLUDE,
> > @@ -727,7 +738,7 @@ static int dwc_pcie_pmu_offline_cpu(unsigned int cp=
u, struct hlist_node *cpuhp_n
> >
> >   static struct platform_driver dwc_pcie_pmu_driver =3D {
> >       .probe =3D dwc_pcie_pmu_probe,
> > -     .driver =3D {.name =3D "dwc_pcie_pmu",},
> > +     .driver =3D {.name =3D "platform_dwc_pcie",},
> >   };
> >
> >   static int __init dwc_pcie_pmu_init(void)
>
> Thanks.
>
> Best Regards,
> Shuai
>

Thanks,
Yunhui
