Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAC7522F
	for <linux-perf-users@vger.kernel.org>; Sat,  8 Feb 2025 02:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738983593; cv=none; b=reTYdB0Csq8NjLQH7fXAyQ7xmlSIYe1Opr8qnyg/PGzjk5qplpUNRV5LIrdZdNrL0iKKSbPkowXp1tB7em5LOgfSO6Lt8EbOji/iCj7NW97x8laNRbPY9ffHQmW2RF32oDHQAZyT7kc3XH06StAzeLDx6gUGqd+D2afWVqvJ2JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738983593; c=relaxed/simple;
	bh=zCLFZrpce0hrEq3NAPLVvaQWe2UmOwpNTZgkvKdcabU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JwFHUjrRrgRhPAE+0z10OoKUJOHXJqVqezDyjKr/QdHgsX7wRubPsNRUUVyaytaegtMO00z2NfDrvptbfrOaFArZRM4lbJcA9/bTcYQMCoQGtkMIF4mnMQLz3fgNKlQW4jgqzMmp2bnC8oq4SvWrh34ycPkJ1EHp0sDNUtYqluA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IKzKNKHn; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IKzKNKHn"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71e1158fe3eso1618276a34.1
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Feb 2025 18:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1738983590; x=1739588390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvHvDYPRlwuJsPWLTplnt5i05PwJjOrBanqn75v6zZE=;
        b=IKzKNKHnPhIXbevVJwCw9B8gwFOwShRUWN+MA9qPsMYkgBhXp8nG+MZipY6DgQfh2e
         r3VXIPhDFalbRDVSrapXjY3NCXO8ScEkOnCBQGhJF6i95lQ+ZSxy82mOxTLbuRsPs2Z2
         B2TwankT88A4LnHD33tUno10J82pEfeY5+KpM3VXAiSUJlldSfX9xW1EBj5hTrNFSZxy
         ML2plqLGO+Yv91hzn1CH71LmCNaS/lHCY5wmnH0l92FXBEmGWmOrkUkxgABbjtTKJKxk
         lTeTEJDQU2FN/LwFqlV9roDqujlCPltKz8hdEK1HS7HC+N9JS+zqO4tNC7sK+1E3wKD1
         dcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738983590; x=1739588390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PvHvDYPRlwuJsPWLTplnt5i05PwJjOrBanqn75v6zZE=;
        b=SFvJt+3rI5Nf0MBxqqoFsOW0OeV7dQZ35cxCyGM6g6/4iNlbPwRPY9mSBm3YWgXUtd
         b0iKf6x9JyqUbttw05tRiVyiE4GA0Fj/3pWuf/Ktn/XZz64JNVjDW6D2R0bZkUdpXZNK
         Ev8kzBOsoRLk+YVT/As731IH7XZ11V/EyZsS7eVryMf3lWRYlZVWbK4d2xQnIBkED7wL
         rCIE0dpbYXgQNba6HUDMwCbSEWVkpF6D9NFNofPgjgB3h3yMiPTaJ4pq1KFN1euG3czO
         zKJM+CpzYH7UdID44FzQ+XAKNxRgfOyJfY8aERu+mk/JqmiFMeo4KtVTiTIsHt91uXWv
         vekA==
X-Forwarded-Encrypted: i=1; AJvYcCXiBXKzs445g7RuGDRap0wgGA9uoZvjK47YRb7IYPT27JkJ2uAvWAHK7Ufmp0rqq2LdVlFVh7f7MBtD3JyibIz7@vger.kernel.org
X-Gm-Message-State: AOJu0YwCwh//slvb5K3Qx1GUd/qYi49SPLhGWCozqjEkxl1+ndc0LW8y
	L/IZHrpU8h1QvE8N2QiZ1S5igvU3L1PF638hwCRStjHdanWacV3w8KcL8ah2kWSmIcHxtnC1fIb
	F0kWx4Yv49NldepUFeT+TlSomJj5NfjD9JLZqAzi/qjlW+XOmtzHoCA==
X-Gm-Gg: ASbGncsj9mbfDkIQdoOQpHNRxXTNlwHqZOswxbbKfI6IwaiaRxl+gnUNxJF4zPf4xS2
	fslc/j+26GFmdR7Xo3K0NX2+8frlPp0BRc4ct5CarG4RUzKEM2fkWrRM+5UUw2v6GilKw/08EbV
	0=
X-Google-Smtp-Source: AGHT+IFfCgmR8iwTSKqI7U2HdoYDqvph6iBamD8uzFVFSvAH4DmSsPQRkRlpYANAxnvRjFuZETIUtoRlunikEsWu7t8=
X-Received: by 2002:a05:6830:6383:b0:71d:548d:6f76 with SMTP id
 46e09a7af769-726b88ad8dfmr3715898a34.26.1738983590587; Fri, 07 Feb 2025
 18:59:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205031425.67265-1-cuiyunhui@bytedance.com>
 <20250205031425.67265-3-cuiyunhui@bytedance.com> <0961be9f-87be-4ecc-9e60-faa78119affc@linux.alibaba.com>
In-Reply-To: <0961be9f-87be-4ecc-9e60-faa78119affc@linux.alibaba.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Sat, 8 Feb 2025 10:59:39 +0800
X-Gm-Features: AWEUYZnr_NMxngTAzPNVuIY-6PvoCxF0axRwCuZj-ABVShCDvBpbuzCDyPoFijY
Message-ID: <CAEEQ3wnJ1ihu62JDwEhVRBjddQpm4xC-CYhj2QTa4P6EbO_hcg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 2/2] perf/dwc_pcie: fix duplicate
 pci_dev devices
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: renyu.zj@linux.alibaba.com, will@kernel.org, mark.rutland@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuai,

On Fri, Feb 7, 2025 at 10:36=E2=80=AFAM Shuai Xue <xueshuai@linux.alibaba.c=
om> wrote:
>
>
>
> =E5=9C=A8 2025/2/5 11:14, Yunhui Cui =E5=86=99=E9=81=93:
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
> > index 4ac53167d7ab..fd9d87b4f201 100644
> > --- a/drivers/perf/dwc_pcie_pmu.c
> > +++ b/drivers/perf/dwc_pcie_pmu.c
> > @@ -566,9 +566,7 @@ static int dwc_pcie_register_dev(struct pci_dev *pd=
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
> > @@ -620,18 +618,26 @@ static struct notifier_block dwc_pcie_pmu_nb =3D =
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
> > +             pr_err("No pdev found for the sbdf");
>
> How about also adding the sbdf to print?
OK, I'll update to v3.

>
> > +             return -ENODEV;
> > +     }
> > +
> >       vsec =3D dwc_pcie_des_cap(pdev);
> >       if (!vsec)
> >               return -ENODEV;
> >
> > -     sbdf =3D plat_dev->id;
> > +     pci_dev_put(pdev);
> >       name =3D devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_rootport=
_%x", sbdf);
> >       if (!name)
> >               return -ENOMEM;
> > @@ -646,7 +652,7 @@ static int dwc_pcie_pmu_probe(struct platform_devic=
e *plat_dev)
> >       pcie_pmu->on_cpu =3D -1;
> >       pcie_pmu->pmu =3D (struct pmu){
> >               .name           =3D name,
> > -             .parent         =3D &pdev->dev,
> > +             .parent         =3D &plat_dev->dev,
> >               .module         =3D THIS_MODULE,
> >               .attr_groups    =3D dwc_pcie_attr_groups,
> >               .capabilities   =3D PERF_PMU_CAP_NO_EXCLUDE,
> > @@ -733,7 +739,7 @@ static int dwc_pcie_pmu_offline_cpu(unsigned int cp=
u, struct hlist_node *cpuhp_n
> >
> >   static struct platform_driver dwc_pcie_pmu_driver =3D {
> >       .probe =3D dwc_pcie_pmu_probe,
> > -     .driver =3D {.name =3D "dwc_pcie_pmu",},
> > +     .driver =3D {.name =3D "platform_dwc_pcie",},
> >   };
> >
> >   static void dwc_pcie_cleanup_devices(void)
>

Thanks,
Yunhui
