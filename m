Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E6220C03C
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Feb 2025 08:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867514; cv=none; b=LBoWigb+XLeD1z16pKmklcLM6p6SGhXpcO3MqwbfbQaqC+wlujIt81atktB39gOIsLkWWG2tBZzphrYE4khoqh/vX0MPMIUwsI71PI5kbNEN65TkbDapvHrWj0eUPXZRZdvr+ICy8kkEEAM9P2k/hxk0rBG/4jBIIYXA4ZFH1vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867514; c=relaxed/simple;
	bh=SsbAnIdLUxCmvoZx0vz9iFZutB0fWqPdzrUOPpXqTJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SNCe9GpV7riqeMiqYURLZIKyIpwXSzfSc28HQ713+oFM7RPX8MMm12nCpfGjrvCIRO/aW2bd+YijH3CKtsjVAgjTrv88U+dyiqG8u8Y7S+BkOQ+lJfFP692GKk8Qbol37zhpzTP2LUa26sxAyBLJDmzGpkEvvkhw9Q5nFJjNNuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=G9Ixn6WA; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="G9Ixn6WA"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2bc52407b78so2072735fac.0
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Feb 2025 00:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1739867511; x=1740472311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgMKlsrMP1eBCbeaAVjxhZXck6mumn4aUs8hwiTVomI=;
        b=G9Ixn6WArpM9qHIJScfIHBYv5Q0u79tZoRzugjjrjAghOXer3nJwvwdGYGQWu/ziJK
         rOKTde9GXEn08c+rFiZj+QY5nf6ba6DOFB0uwbPjSuyCp0MtRM0+EBFaQAjN8G/S83ha
         uqSGqFO7xPqpk+QIrCDKETw+bp+0QAA3pqL/Oq9iwNMS/Q9ttmCrHkjmUsdq3L+fiSIf
         dDtc1yhSQw/SIeolULO7f8XGDZ7crQJsE/C3y0n53jgqexkOUNLOBXBYT82s5lhVLeJs
         0uIZhbjqeBo2FsUlW0JXd2tHJVuClZlhlBfWNVJnI/vGfCvYQ8s6hQN77darTlKTetfp
         6TpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739867511; x=1740472311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgMKlsrMP1eBCbeaAVjxhZXck6mumn4aUs8hwiTVomI=;
        b=t0L0BIW6XVfX7H6vYG67Jjq+9dg4wP480UsBB2pGtzd8TlJ+h4G4WG7qIvj43s8Tbq
         JMNc5r8rs73uQkvt7o/JOZjemFUsFqlxgaSi3eDAooy9hsGTFWQxNAFtTAwTQ79M3D9W
         EsxCav7UWNuBYtDF2YOJRA6mtfycZ982ebLcFYDKI+Ospw5+/mwD0oHEunUZDkle3odg
         T97ogDF+bZ7zBM8YqTeoLkPROdCKyc6Lk3SdlRBAy5eEYyeuMVwO6+jBAPP3S+P3eO5j
         qHaK9TRiHCNY+/90lSDxruS6rpJmIG91g6t0IvGbyIb+78mDi34lij1hMnBPXY4oJlHI
         mX0g==
X-Forwarded-Encrypted: i=1; AJvYcCXrx6Y0qv6d51YYrCygSr54e8sqi9IBwp1g65d5Sfd14sd4OhYvM1zNIKae+zByYlR1hrP0tYnhV53QZcyhzB5O@vger.kernel.org
X-Gm-Message-State: AOJu0Yy44IB3LhIG7H9VJt8xRgOTSOSupSJn4nJDcEgo5P3WJIDu5QxB
	E+tGLVS9QGO2wl30dfQu7SqhBDi7ALsVBHqBk6cW9uOP6sDqzfeV/N3fFhMrW/xNSl4HgqEtrp3
	GWz4ZKmVBdnC0Sk0b1+uB/MlsauEiYWZVQJs/xw==
X-Gm-Gg: ASbGncsNWLAPL3QbL64RgLWFyaEkc82KdWZcRf2Ej0NhAGvRxMsu5S/DhbKG2GuWIiq
	6yMw6e3zZrjTdZ3w9BYIeDMqrND9LrD+Pu3HsTtkKp98wtsjviLbbH/744WB6u9SwcZQENkS26h
	g=
X-Google-Smtp-Source: AGHT+IGHJuM9IfNPGlGcPH7aa44uhxOWYRwrS2rEKmNkeW+giAvfsVbkjj5RarhaVn+9MIgY3oxSFWNSlHJgrM3c2SI=
X-Received: by 2002:a05:6870:be8b:b0:29e:3531:29da with SMTP id
 586e51a60fabf-2bc99a937bdmr9235473fac.9.1739867511250; Tue, 18 Feb 2025
 00:31:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208104002.60332-1-cuiyunhui@bytedance.com>
 <20250208104002.60332-2-cuiyunhui@bytedance.com> <d1db3047-f478-4d8f-b9f6-e7a5820d5a29@linux.alibaba.com>
In-Reply-To: <d1db3047-f478-4d8f-b9f6-e7a5820d5a29@linux.alibaba.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 18 Feb 2025 16:31:40 +0800
X-Gm-Features: AWEUYZkcD7V4dyG01R1nkwYjrYmf-ApvAaWIkuajdXDd_s9zqaV_RoEhFC_HhyY
Message-ID: <CAEEQ3wmaD61DMV0nXrQeVEk6r-J3JYxFceXZmH=t0aQrESqJew@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 1/2] perf/dwc_pcie: fix some unreleased resources
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: renyu.zj@linux.alibaba.com, will@kernel.org, mark.rutland@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuai,

On Tue, Feb 11, 2025 at 4:05=E2=80=AFPM Shuai Xue <xueshuai@linux.alibaba.c=
om> wrote:
>
>
>
> =E5=9C=A8 2025/2/8 18:40, Yunhui Cui =E5=86=99=E9=81=93:
> > Release leaked resources, such as plat_dev and dev_info.
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >   drivers/perf/dwc_pcie_pmu.c | 33 ++++++++++++++++++++++-----------
> >   1 file changed, 22 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> > index cccecae9823f..19fa2ba8dd67 100644
> > --- a/drivers/perf/dwc_pcie_pmu.c
> > +++ b/drivers/perf/dwc_pcie_pmu.c
> > @@ -572,8 +572,10 @@ static int dwc_pcie_register_dev(struct pci_dev *p=
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
> > @@ -730,6 +732,15 @@ static struct platform_driver dwc_pcie_pmu_driver =
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
> > @@ -742,7 +753,7 @@ static int __init dwc_pcie_pmu_init(void)
> >               ret =3D dwc_pcie_register_dev(pdev);
> >               if (ret) {
> >                       pci_dev_put(pdev);
>
> Should we get a reference count of pdev in dwc_pcie_register_dev and put =
it in
> dwc_pcie_unregister_dev?

Personally, it's not an issue because RP devices are generally not unloaded=
.

>
> Thanks.
> Shuai
>

Thanks,
Yunhui
