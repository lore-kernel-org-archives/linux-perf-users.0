Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090201B6D11
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Feb 2025 08:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739868382; cv=none; b=BzO5796EsEvsvY/uBy1lgHXdILNzI1D3Ws72RhjVn/7bseGSu5+h4M/HbDAJBLUajXE1da3OMz1lnbjhLaALcPSC5j8f5DGAkNrXQNcC7R3hMJMjPB2j0fiY/aqkJvFQCai47+kAiPGRKgZ0kXFxNZJSSYrGnhyQFx6Z0Ty0skg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739868382; c=relaxed/simple;
	bh=yDSnXVIa40AnZA99OPBLMMAd5wSVjLokTovYdqQrcNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hbcLWag1fLjfOEx5eTwx6dJp2Efdugltqs17YJI/cNSEfc+kNqgKuSGwnHnwoZvMRQt4y2JhEgNlWYSvhSfh1kppOHYSmlWvzL6CkMK8y71hxmBNaqnk51NiQ20dQNt29b+0IREnFqxSiwMHt8CvvIBS+wa8+W402LXAYqBR5sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UllbpAq9; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UllbpAq9"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2addd5053c0so2994678fac.1
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Feb 2025 00:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1739868380; x=1740473180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJd7nq6QzBYjb9npIZDy/jgRU4O0VseneW2dwq1EDmY=;
        b=UllbpAq9qJZRClX+hvn7DP1YB6SxCXtO4R04MByNwwdUZm2TsT4+bAhnvUKtJ+I76s
         Cs0ZNpEAAqTI7P/QsVZanVjWKmcM2+E7tpavfmTf83Lk7NWlPfzGx8si8hYznoCgpFg/
         kFvnm/It3cuyQeAbTqrJBI8J/t5m1mvexXGRdYTCTpm6wgxLC1jY4JVL/D3+leoue9W6
         L6VPDwuS3kwxfUOz49KTSSeFEi3QIyRvwbVwPCBPmP5W6hmQILtBFXFeHu2gQ02EeR6k
         1p76zquMMbDBNU7YkuVaXIJf4S/6381qplAClMIEtHH8TFe3FquGLlMgntZcxC0QrLbz
         t6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739868380; x=1740473180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJd7nq6QzBYjb9npIZDy/jgRU4O0VseneW2dwq1EDmY=;
        b=Hiwt23JohYF0zeWbWW/dgBdKIuApPFX/QEB2gjRn5VVwsGeSpibEYCLszNP+P9ktBx
         nqlo1UT7Uw71yn9f6EB4u0S+fTNZm4nVbG2A7aA9CFUT+CkJ+YmI64+p/4AcaVRfaP35
         0Mvoi/5fTQrMTFKRw99VPKEbv1SEpTedxriek7tHyExP5xS39kC+QjA7yRmHW/W+cvfZ
         2WJmtbYJEOXK7DEHETFBr0W0gWMYn/BSbfAWH2+/oRuM4nnMlpoKYDChjL6+eOjSslzC
         S1ua53ymXPfrasbH46/4aXDhukLBzch3ydvgy0O5pu+KBkh6tEZj68KfcDTbFWSroCGL
         EmFw==
X-Forwarded-Encrypted: i=1; AJvYcCXTJ7eeeu8UjZSaihHM/DR4AwxqqfLY8c0p3/gbXy6aQGh3O3J+1VZ7heH780CdtGKQXQl0ABWzUMzgNSTCSvNC@vger.kernel.org
X-Gm-Message-State: AOJu0YzTuq6aS21JQtyApDqHHWal0HJYrcvGGkxqgfCvfZabvo1dKGk2
	8cXPt+5ywAlldo/tIa46zXcD+kdX6/LKIrBrJmPJ3GYDXd3UXEdm+IcqHTiYpNO/2u9uNGlIYpI
	A+60KMk2yB4DdCqWXAH2H4dm5FB/sZmImhlFD5w==
X-Gm-Gg: ASbGncvif/0cialoUJZnWzYBrqVUD001NRc/TP3XpW6lrGxXvpqqfJlBdZj/TvFxpWD
	zg+h5pEUSobyg8wtvDVI/Yrm2ShJhTuIoyWnwfgypBq+ZEQbTOl3WgRfPmlDGB3Dq4fPbC3gTwb
	g=
X-Google-Smtp-Source: AGHT+IFm9vNEQ8X126IwADvLb9rT5XMr1pesOHyHKgcPIaN+xUJPxTGUWHrghfMYHG0o0nWqEBP/oKVjpG31b6OWn1o=
X-Received: by 2002:a05:6870:b623:b0:297:23cf:d3db with SMTP id
 586e51a60fabf-2bc99dcc23fmr8163637fac.37.1739868380048; Tue, 18 Feb 2025
 00:46:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208104002.60332-1-cuiyunhui@bytedance.com>
 <20250208104002.60332-3-cuiyunhui@bytedance.com> <2fedcf43-05f9-40da-a4f7-1b836f30b0df@linux.alibaba.com>
In-Reply-To: <2fedcf43-05f9-40da-a4f7-1b836f30b0df@linux.alibaba.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 18 Feb 2025 16:46:08 +0800
X-Gm-Features: AWEUYZlKaYI0ZGCGtjcpg77WiA6ZuKperDHgxYMipoc-2RT3j86BH0keI_z0DXQ
Message-ID: <CAEEQ3wk5AhHK5cbZ-m1ibz93qqGJ1OPXM_NE_6rWjkuPM=Gw=g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 2/2] perf/dwc_pcie: fix duplicate
 pci_dev devices
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: renyu.zj@linux.alibaba.com, will@kernel.org, mark.rutland@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuai,

On Tue, Feb 11, 2025 at 4:02=E2=80=AFPM Shuai Xue <xueshuai@linux.alibaba.c=
om> wrote:
>
>
>
> =E5=9C=A8 2025/2/8 18:40, Yunhui Cui =E5=86=99=E9=81=93:
> > During platform_device_register, wrongly using struct device
> > pci_dev as platform_data caused a kmemdup copy of pci_dev. Worse
> > still, accessing the duplicated device leads to list corruption as its
> > mutex content (e.g., list, magic) remains the same as the original.
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >   drivers/perf/dwc_pcie_pmu.c | 20 +++++++++++++-------
> >   1 file changed, 13 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> > index 19fa2ba8dd67..4f6599e32bba 100644
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
> > @@ -616,18 +614,26 @@ static struct notifier_block dwc_pcie_pmu_nb =3D =
{
> >
> >   static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
> >   {
> > -     struct pci_dev *pdev =3D plat_dev->dev.platform_data;
> > +     struct pci_dev *pdev;
> >       struct dwc_pcie_pmu *pcie_pmu;
> >       char *name;
> >       u32 sbdf;
> >       u16 vsec;
> >       int ret;
> >
> > +     sbdf =3D plat_dev->id;
> > +     pdev =3D pci_get_domain_bus_and_slot(sbdf >> 16, PCI_BUS_NUM(sbdf=
 & 0xffff),
> > +                                        sbdf & 0xff);
> > +     if (!pdev) {
> > +             pr_err("No pdev found for the sbdf 0x%x\n", sbdf);
> > +             return -ENODEV;
> > +     }
> > +
> >       vsec =3D dwc_pcie_des_cap(pdev);
> >       if (!vsec)
> >               return -ENODEV;
>
> pci_dev_put(pdev) should move ahead to aovid return here.
>
> >
> > -     sbdf =3D plat_dev->id;
> > +     pci_dev_put(pdev);
> >       name =3D devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_rootport=
_%x", sbdf);
> >       if (!name)
> >               return -ENOMEM;
> > @@ -642,7 +648,7 @@ static int dwc_pcie_pmu_probe(struct platform_devic=
e *plat_dev)
> >       pcie_pmu->on_cpu =3D -1;
> >       pcie_pmu->pmu =3D (struct pmu){
> >               .name           =3D name,
> > -             .parent         =3D &pdev->dev,
> > +             .parent         =3D &plat_dev->dev,
> >               .module         =3D THIS_MODULE,
> >               .attr_groups    =3D dwc_pcie_attr_groups,
> >               .capabilities   =3D PERF_PMU_CAP_NO_EXCLUDE,
> > @@ -729,7 +735,7 @@ static int dwc_pcie_pmu_offline_cpu(unsigned int cp=
u, struct hlist_node *cpuhp_n
> >
> >   static struct platform_driver dwc_pcie_pmu_driver =3D {
> >       .probe =3D dwc_pcie_pmu_probe,
> > -     .driver =3D {.name =3D "dwc_pcie_pmu",},
> > +     .driver =3D {.name =3D "platform_dwc_pcie",},
>
> Aha, it is very difficult to come up with a name that satisfies everyone.=
 The
> original name uses the '_pmu' suffix to follow the unwritten convention o=
f
> other PMU drivers.
>
> Personally, I think the original name is more appropriate, but I'll leave=
 the
> decision to @Will.

Since Will hasn't replied, I'll update to the next version to keep the
original name.

>
> Thanks.
> Best Regards.
> Shuai

Thanks,
Yunhui
