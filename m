Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9084D1D5AC6
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Jan 2025 09:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737709879; cv=none; b=LoQLcRMx5d9ExYWzrLIbAuFjqtt5Qz1I6LgFm+Ea6ZwRDBAIXqcmyonPWSmVo71ja32dx6BLM6JJMm7IzBY1U45hfwZqbI/U7JEgdpxpzzA32+Zqt/PFfRGV5VhjG0qNG1iVKN7JnaoV+KJrtz8Lz7PfPMAYe0Tzkjnwn0ENA4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737709879; c=relaxed/simple;
	bh=33tInBGJCbrXO9rodU2hIslrpXp3AWvsABZY8OmoTyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3Ed2nLOy+TgJG8iR2mvZe3p5CYGQdfRk7p8rH9g2zuuTw9LjvVjQLiJGsJvctL/c0NRbzNOWM+Z+r9ekRqmvl8FK84b3TSVrSbczIQHKCVbvFkoZ/aQpfkez+0nfhrLnxIVhj+VblR33IgURLdw5ZaAelK42e8BRly/W6/vRMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KjTOQYho; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KjTOQYho"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-29fad34bb62so1001042fac.1
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Jan 2025 01:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1737709876; x=1738314676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MohKCVwaV6eyLihdD2bVSeyaXrhr1TtTgD4wyqMZ7DM=;
        b=KjTOQYhoYMpPzhZk8aSOS5TktXNYj+ENz6gCrxSkE5/MrKWYfGeVJiApvPonc3ylB3
         XwIRQXBYpGVZiJcNAnjTT8Ii1LelDn7GQuY2nkRnivns/f2tH4QJHQ3qQy0r3oP+U9gD
         UnObcEw/PH6iZ9UZySr/Ha09Ojgpw8H5VGk+AW5nKHxTpkqTYpoiF4Tn7sr3yqZWlA+w
         QY+5LdY9zAzcy+3rzAmU4hLJCIlx2JDK0CBNcm/U8jVLXF+l+dbdluML24bL+8TUTqyK
         YfW4Xk0Ath2339QTIA8EaH/uyOcI6+xTh/2dTgQsTWAWs6S6XKSPbpjWIq9e3sa3R9yk
         UsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709876; x=1738314676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MohKCVwaV6eyLihdD2bVSeyaXrhr1TtTgD4wyqMZ7DM=;
        b=hBjwqB+F4stT9ZyqJ6xeZjGZroiWoSfQAFExYLnY02Go1Cob+MPaSZpE6OV+lQSeKV
         p5UCEk53vxysXU8YZOhqaE14p78a8loydT2ggAzvher6bOd3SoL8j+8fEsVrpM/ooQ1s
         RtufSNHTSlhnDgSDT7jCIzh806JXM5EY2/1SGA85ojht3ncxIEXrfRrSjBjhoRjo4qvP
         BOjeNCf6/qRPupGSLy3cxT0HxJjyR13vulUCb2PEZivQKsxoc4A7KfQft/c9qjMSOcyq
         S7jYzaNhE8OXuqs6eCsvwDCyshmBkrEih1F5s/AJ3h6OdoUytql5l15/0/pOcSVHclsz
         iwZA==
X-Forwarded-Encrypted: i=1; AJvYcCW5LfAgAF3iKpTMJCOoXH/IRVsSJYIBRoMsWRCpz+oLVczKFTPRDFGFmez1nEHl/jxT8H46inGdQ+7EGL7R8uDx@vger.kernel.org
X-Gm-Message-State: AOJu0YwnadSMVpFhPEcsFA+nSjPTR21zyqGqVo+D23tAX+h7swsRZNXL
	vv5I5GF9+2DvU/c8EeGVr+R2eBMc0Yywp/oNM2u+y11QuOHrmdWfvL8BcaSz8XyEw3/uT5EjZM4
	CdIr17u9+6tN8vuK9AdZIVoFjiImL43PfZUkKJA==
X-Gm-Gg: ASbGncuMzVeehN3+mW9ee+reRW9n2W3rD9I0z1rABG7AxNrUKc2UR+SB+4dvvqAGlqb
	2SRJXE9f8jdzQOpMb3pnfa/6enQ8jZozrS8JKNFN2XzaUZ0f3bUkdrlfiVZ7GsaU5t5GOPMhVPr
	8=
X-Google-Smtp-Source: AGHT+IHMglpELSThhHo8nROkg3DoafohvFAQ3oJ0ePqP1cakPUnQMtH2cEZnnfZgzU10EslTCXGCEq096KVOEgJPQ4M=
X-Received: by 2002:a05:6871:6181:b0:29e:3c90:148b with SMTP id
 586e51a60fabf-2b1c0bf7b45mr17853494fac.26.1737709876405; Fri, 24 Jan 2025
 01:11:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123074830.90923-1-cuiyunhui@bytedance.com>
 <344c53cd-d856-4c03-9deb-743b65acd8aa@linux.alibaba.com> <CAEEQ3wmDej9bbPUmkx-ZrD4FG9Z7gTHMeCrVszx64g90O0RyiQ@mail.gmail.com>
 <31e00081-8695-4ca6-a1ef-af5a007a7565@linux.alibaba.com>
In-Reply-To: <31e00081-8695-4ca6-a1ef-af5a007a7565@linux.alibaba.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 24 Jan 2025 17:11:05 +0800
X-Gm-Features: AWEUYZmykPrt0I5q4ySCyT3YSRadhZWk3QmMa3gmOm6Vn0EAmAwMUxJ5DzbwMnA
Message-ID: <CAEEQ3wm+f_SM7evwL=YrGy8gPLS5YdJm=qhJNT8bbMH7QBOzEA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] perf/dwc_pcie: fix duplicate pci_dev devices
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: renyu.zj@linux.alibaba.com, will@kernel.org, mark.rutland@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuai,

On Fri, Jan 24, 2025 at 2:48=E2=80=AFPM Shuai Xue <xueshuai@linux.alibaba.c=
om> wrote:
>
>
>
> =E5=9C=A8 2025/1/24 10:56, yunhui cui =E5=86=99=E9=81=93:
> > Hi Shuai,
> >
> > On Thu, Jan 23, 2025 at 5:50=E2=80=AFPM Shuai Xue <xueshuai@linux.aliba=
ba.com> wrote:
> >>
> >>
> >>
> >> =E5=9C=A8 2025/1/23 15:48, Yunhui Cui =E5=86=99=E9=81=93:
> >>> During platform_device_register, wrongly using struct device
> >>> pci_dev as platform_data caused a kmemdup copy of pci_dev. Worse
> >>> still, accessing the duplicated device leads to list corruption as it=
s
> >>> mutex content (e.g., list, magic) remains the same as the original.
> >>>
> >>> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> >>> ---
> >>>    drivers/perf/dwc_pcie_pmu.c | 25 ++++++++++++++++++-------
> >>>    1 file changed, 18 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.=
c
> >>> index cccecae9823f..8b208f287a1f 100644
> >>> --- a/drivers/perf/dwc_pcie_pmu.c
> >>> +++ b/drivers/perf/dwc_pcie_pmu.c
> >>> @@ -565,9 +565,7 @@ static int dwc_pcie_register_dev(struct pci_dev *=
pdev)
> >>>        u32 sbdf;
> >>>
> >>>        sbdf =3D (pci_domain_nr(pdev->bus) << 16) | PCI_DEVID(pdev->bu=
s->number, pdev->devfn);
> >>> -     plat_dev =3D platform_device_register_data(NULL, "dwc_pcie_pmu"=
, sbdf,
> >>> -                                              pdev, sizeof(*pdev));
> >>> -
> >>> +     plat_dev =3D platform_device_register_simple("platform_dwc_pcie=
", sbdf, NULL, 0);
> >>>        if (IS_ERR(plat_dev))
> >>>                return PTR_ERR(plat_dev);
> >>>
> >>> @@ -614,19 +612,32 @@ static struct notifier_block dwc_pcie_pmu_nb =
=3D {
> >>>
> >>>    static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
> >>>    {
> >>> -     struct pci_dev *pdev =3D plat_dev->dev.platform_data;
> >>> +     struct pci_dev *pdev =3D NULL;
> >>>        struct dwc_pcie_pmu *pcie_pmu;
> >>> +     bool found =3D false;
> >>>        char *name;
> >>>        u32 sbdf;
> >>>        u16 vsec;
> >>>        int ret;
> >>>
> >>> +     for_each_pci_dev(pdev) {
> >>> +             sbdf =3D (pci_domain_nr(pdev->bus) << 16) | PCI_DEVID(p=
dev->bus->number, pdev->devfn);
> >>> +             if (sbdf =3D=3D plat_dev->id) {
> >>> +                     found =3D true;
> >>> +                     break;
> >>> +             }
> >>> +     }
> >>> +     if (!found) {
> >>> +             pr_err("The plat_dev->id does not match the sbdf");
> >>> +             return -ENODEV;
> >>> +     }
> >>> +
> >>
> >> How about using pci_get_domain_bus_and_slot() to find pci_dev?
> > It's not necessary. pci_get_domain_bus_and_slot also invokes
> > for_each_pci_dev, and it further requires splitting the sbdf.
>
> Compose sbdf from domain, bus number, and devfn is almost essentially
> corresponding opposite operation. And I think we should grab a reference
> count of pdev and handle it properly.
>
> Personally speaking, I prefer pci_get_domain_bus_and_slot() because it is
> simple and robust.
>
> >
> >>
> >>>        vsec =3D dwc_pcie_des_cap(pdev);
> >>>        if (!vsec)
> >>>                return -ENODEV;
> >>>
> >>>        sbdf =3D plat_dev->id;
> >>> -     name =3D devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_rootpo=
rt_%x", sbdf);
> >>> +     name =3D devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_rootpo=
rt_%d_pmu", sbdf);
> >>
> >> A new name will break previous user tools.
> > This name isn't suitable. It can't clearly show which is the PMU
> > device. Userspace tools don't have binding relationships, like perf.
> > Tools must traverse PMU devices before use.
>
> The device is under /sys/bus/event_source/ which indates it is PMU device=
.
> As far as I know, most of PMU devices do not endup with a '_pmu' prefix.

The point is the name "dwc_rootport_" is misleading, suggesting an
extra PCIE RP in the system. Best to change the name to intuitive
"xx_pmu".

>
> Thanks.
>
> Shuai
>

Thanks,
Yunhui
