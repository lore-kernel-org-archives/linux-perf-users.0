Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CF529D0E
	for <linux-perf-users@vger.kernel.org>; Sat,  8 Feb 2025 02:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738983448; cv=none; b=B65qGyiWWnqx3+AE86VRLMxRv504fi0wtiDkQnKLJFMc2RHwEh52JKJPklyHvvrq5ossP1Vu25n6ojvcfvHA2ogy2MLlJKLprx8NhBA4+R5sUX/WdiPAQS+/NtrE1TbqFoD7q133qkuE+QewNvrSgtpShsd7cqn11tsPviOgX0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738983448; c=relaxed/simple;
	bh=8DccWs6wCWskvLVN7E1jd8TFfEajJ4du6tb7En40r3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hzqJnZNeQllmzq0AvEbBYVUIMEWrRTe9ACAHBQ+OQojeNqMy+JeyR8teiCHo0WMG3bfGapgnmomloG+30c0hMCjGyEygO41zfx7mqsiJUAcAPqEIzU+GyTBJHNm4B3w/Yz2dfgWXqubuyNJH9qRT9yyYydtZ8CUu1QRH7nq0Mqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IgFZZIR+; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IgFZZIR+"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-71e22b2387cso2115745a34.3
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Feb 2025 18:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1738983444; x=1739588244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxLH/0mNKOA9oAdJlhcouBluEGl2xAARBS6OeCkhtnM=;
        b=IgFZZIR+6/4mAxAgsxAcuoUOZlthhplQqPimAk0goPhPCVIpAYvM5t0jH3p3BAls19
         IGqnuT+9BMN4HbUi0zPP66uCZr69e4jFJVvbEAMbx/B53xFh2j4V933nJz8BpoyW5R7k
         7ZgV5j2CVZmanHUAIrv8lVlS3MDarm1VwU+JoEIyTJIrl6D3CwPt5ese4BOOm7MX3csC
         uF8Zdbyl0gKmax3iIK4OHdPFYB/MdjYlLeY9rdUcoogSgj29QRsvZxw7L4aygOml0vcB
         8o7oRoH/aZXf+7i8xARXkdvQZjIt6xyDno1S78nc3hVHg4PNtoC5ec1yV6K4n9CSZEyP
         C9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738983444; x=1739588244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YxLH/0mNKOA9oAdJlhcouBluEGl2xAARBS6OeCkhtnM=;
        b=lnnOstnqx7jz7XycLxi7rg4bkGiYJ5bTkrkXsGU0EyajzCNPNotySVa9xUxNcO++ng
         B3QCzs0oTsPmFYqFOTMPRjO1oO1AXCfvrBZP+oXynZYgib+pVuxcxd8z7E2dFy8wdn3x
         CrYyGBGO5HKGE52WKcaVuo7WUXkx7K+1v1veQPJ/gf42iBwqYLOUFHmHHuSKjA/dg+/C
         XI5zdb7Zj3GG9QlwC2AIg8GwTsgS/Ak2jCBkDCOCLIPbrwzc7XxgbPfOsNKb49zc3/zJ
         DzoRoNEkWz0kzQQU5/OIbEKxaoozMDp0LQrwA98aFB+5nBwXiYoeMEwblvZ/C5ngqnrU
         20iA==
X-Forwarded-Encrypted: i=1; AJvYcCV53vSnBbvUm/Js6P4UxxF2hWQbCTgj/jtKrOdzyC5fr/8W9S4+JbeppQVvORoUyHQUVaog4CEToeO3rD2fU+uC@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3/6Z6adUTNTBGIWvVJe1vZoCQBZTa/glSJk0hSgZWFzgutvUS
	A6y30zOf6lNM2X9TikqwQq24AgmJI+DbB6wh673D9K1MwYFpqpunVOgZHC53gk/yTMH5VZJKnJu
	NgpubIOlpQ6GMY+8cELWRad6JoPYsRQLnT+9xqQ==
X-Gm-Gg: ASbGncuOIMeKA1yzBIQ/wTbb4wJ7NpYggy4gbbnzl/ZvyonmjnL8rSBmWaNa8ajOp3/
	Slx48fWqai2PoTHPRGSc0YpW5g4SKuSbZrJE9jN51IWFuGZnLGENAzmV2LR/YO0wCdQsz4AcOMy
	w=
X-Google-Smtp-Source: AGHT+IFzDA994qoj0pOD1pwjZKhnb3ZJW/yjhXcqLQK+e3oqjqOgw2RnWRlREyQPjPL3pbFYTWLXVADhEyqMHUGwews=
X-Received: by 2002:a05:6830:7001:b0:71d:de27:8d32 with SMTP id
 46e09a7af769-726b87b457bmr3893379a34.2.1738983444393; Fri, 07 Feb 2025
 18:57:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205031425.67265-1-cuiyunhui@bytedance.com>
 <20250205031425.67265-2-cuiyunhui@bytedance.com> <76dad20a-0180-46a0-9840-6d8444d1749a@linux.alibaba.com>
In-Reply-To: <76dad20a-0180-46a0-9840-6d8444d1749a@linux.alibaba.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Sat, 8 Feb 2025 10:57:13 +0800
X-Gm-Features: AWEUYZmxaYnEp0Kg964XX7tTfsxe4wOkRLUxQOmGY9VcBaQMtyFA6anqEU-dkW0
Message-ID: <CAEEQ3wm6vw9AvEtWOaPqLvR3x4vs=KMACN9OQGJ2eAOzuv2GhQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 1/2] perf/dwc_pcie: fix the incorrect
 reference count
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: renyu.zj@linux.alibaba.com, will@kernel.org, mark.rutland@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuai,


On Fri, Feb 7, 2025 at 10:20=E2=80=AFAM Shuai Xue <xueshuai@linux.alibaba.c=
om> wrote:
>
>
>
> =E5=9C=A8 2025/2/5 11:14, Yunhui Cui =E5=86=99=E9=81=93:
> > for_each_pci_dev increments pdev refcount. Call pci_dev_put after acces=
s
> > to decrement it.
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >   drivers/perf/dwc_pcie_pmu.c | 42 ++++++++++++++++++++++++++----------=
-
> >   1 file changed, 30 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> > index cccecae9823f..4ac53167d7ab 100644
> > --- a/drivers/perf/dwc_pcie_pmu.c
> > +++ b/drivers/perf/dwc_pcie_pmu.c
> > @@ -553,6 +553,7 @@ static u16 dwc_pcie_des_cap(struct pci_dev *pdev)
> >
> >   static void dwc_pcie_unregister_dev(struct dwc_pcie_dev_info *dev_inf=
o)
> >   {
> > +     pci_dev_put(dev_info->pdev);
> >       platform_device_unregister(dev_info->plat_dev);
> >       list_del(&dev_info->dev_node);
> >       kfree(dev_info);
> > @@ -572,8 +573,10 @@ static int dwc_pcie_register_dev(struct pci_dev *p=
dev)
> >               return PTR_ERR(plat_dev);
> >
> >       dev_info =3D kzalloc(sizeof(*dev_info), GFP_KERNEL);
> > -     if (!dev_info)
> > +     if (!dev_info) {
> > +             platform_device_unregister(plat_dev);
> >               return -ENOMEM;
> > +     }
> >
> >       /* Cache platform device to handle pci device hotplug */
> >       dev_info->plat_dev =3D plat_dev;
> > @@ -594,8 +597,11 @@ static int dwc_pcie_pmu_notifier(struct notifier_b=
lock *nb,
> >       case BUS_NOTIFY_ADD_DEVICE:
> >               if (!dwc_pcie_des_cap(pdev))
> >                       return NOTIFY_DONE;
> > -             if (dwc_pcie_register_dev(pdev))
> > +             pci_dev_get(pdev);
> > +             if (dwc_pcie_register_dev(pdev)) {
> > +                     pci_dev_put(pdev);
> >                       return NOTIFY_BAD;
> > +             }
> >               break;
> >       case BUS_NOTIFY_DEL_DEVICE:
> >               dev_info =3D dwc_pcie_find_dev_info(pdev);
> > @@ -730,20 +736,29 @@ static struct platform_driver dwc_pcie_pmu_driver=
 =3D {
> >       .driver =3D {.name =3D "dwc_pcie_pmu",},
> >   };
> >
> > +static void dwc_pcie_cleanup_devices(void)
> > +{
> > +     struct dwc_pcie_dev_info *dev_info, *tmp;
> > +
> > +     list_for_each_entry_safe(dev_info, tmp, &dwc_pcie_dev_info_head, =
dev_node) {
> > +             dwc_pcie_unregister_dev(dev_info);
> > +     }
> > +}
> > +
> >   static int __init dwc_pcie_pmu_init(void)
> >   {
> >       struct pci_dev *pdev =3D NULL;
> >       int ret;
> >
> >       for_each_pci_dev(pdev) {
> > -             if (!dwc_pcie_des_cap(pdev))
> > +             if (!dwc_pcie_des_cap(pdev)) {
> > +                     pci_dev_put(pdev);
>
> If the pdev has no RAS cap, we do not need to put the device.
>
> > The reference count for @from is
> > always decremented if it is not %NULL.
>
> Please see comments from pci_get_device() for more details.
Oh, yes. If that's the case, I'll update to v3.


> Shuai
>

Thanks=EF=BC=8C
Yunhui
