Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676E52B9A9
	for <linux-perf-users@vger.kernel.org>; Sat,  1 Feb 2025 09:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738403497; cv=none; b=mpMcWnt4B13JIdKjMj8jTdBYDRwURGCEHnr80FkRzeypXRnm3fCWtdQSkfhD6PEJyVhVE2TerR11jaAgloGVA0sn8YHjzUjWmMepx7IS3psLMwRuLid/I8FQM3h+D5KUp++YiDICBHJScHCTVrh08Ubjfhypod9rWsNl7pFP8Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738403497; c=relaxed/simple;
	bh=/Lc2YIVYZMDWtzJOASQ91vr/NwUHANkE56YZql48Cvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iApKPOsUIK2q2/SRC+gkC63Jp2+Ev0FK1UT4letxQejul9w01Ro3u6HxUQwYDAE0HJDlKxYIrnf4E2gRh12ASNzeJENP80wlw11fRCI3e0CV9XUoFlizmWNUpuL41j91/nChr0fP1LxWynQnDsXZezVFM4ZIR8IpbL3M+CXQkNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=aSuHUaOF; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="aSuHUaOF"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-29e5aedbebdso1362483fac.0
        for <linux-perf-users@vger.kernel.org>; Sat, 01 Feb 2025 01:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1738403494; x=1739008294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+AAdkcmZc4lSXsMOcapYBhFqOepj7d/gBINmIU6crc=;
        b=aSuHUaOFXwEysvdBDhkbIgOaX3w9jq2YJXpGwp5NDFUGaJdHGwmegwYf2Le7mriryp
         yJ1mFWUsbATOmqc2hhqOqBXr/UuA/+5AL6eoUdS3bNAAmMJ6Ivr4iZVvvNkpLlEKCoob
         sEu6WXMU4SX14crbAaRlabpcIuZHHL6+W5L8CftEwH0iCfx745vigOr47KzUaLlTUMSX
         bdZUcRVEt3Xg3j7o0QgiLgyrCsj4YhosbCCzAvULQKSgatXOfNyFbG3G3DftTsDTJMAd
         Yg5Osq1CavgDheMIz52+7Egyqo/4jZ4MBxnulDi6bcEX5iVJkfYNq2cz7YtvfS6Ww3ib
         dSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738403494; x=1739008294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+AAdkcmZc4lSXsMOcapYBhFqOepj7d/gBINmIU6crc=;
        b=WJvIJPGVNv6OYKG9R0WxQrscmYs6D4KMIZnuUMCwzBGb8LyoNpQABYUBaR5FADFYs0
         Pr1mOg69VyL7ZiBRw2y6F87IsI6fClEwAUI59dROa8Mvu6cOdPIoMcfDjGe0s3NBuf0h
         7o1pCxKyFW/gPTW0yGm71mUV/zcqJW5ol1WhtnyyQ5YVSUthgTz9W2sUrd8TQGis7+7/
         hxMP1yZ3Gs4oomZDUGWfrAxT+PyUiFWC9p5Jx2Wjb8+QvU9AGyOBQCVX6vLjijF+5K9z
         MWR48d8ICZAG5yilXpv13Yl0xs3Q41LZ/hLw9+SKMmL2jY4XToILee2iLzdytrTc8AwD
         Pxwg==
X-Forwarded-Encrypted: i=1; AJvYcCV1Ssp9wRyKpdNIoS+c28OIZrtTGUs5eweiRIxd9EjnG6vZ/E+LvYpjUWHw9yRh0BXaYOZErezWdlnFmbbqA29X@vger.kernel.org
X-Gm-Message-State: AOJu0YzaU5+4O4nRTxbsRT0JQ9fyDqj9m23pWO8sA3h+OLC82Y9UpHqx
	69bQs4gShHCGOldz5OVPbhvC2qbXTksNPZwMBVpm26hJvbQCr6FSGmv7TzRbQmYSfRqdHaR1rza
	dxtWzkQVIg3V6qPGvAud2Ub32/ycTAEs3FAtW2w==
X-Gm-Gg: ASbGncsBcDDIa/qM0rg5Ju92jthEdW145KVnc0UTwLE3/OyVNrPUFxP8oMxD33EpJQs
	PnCOzqzhLLJGjFpbXZNPGriRNS3H+3dA938ayJWSyOExHtOwoDYCbx7leJX4BY/uZzehpy2uErh
	U=
X-Google-Smtp-Source: AGHT+IEIIfBdNVn8LDpeA6rFY2D9do+Hyc1wDJ+qpODyAMtmiFvSiXtuvbFiuEmS1fHjZJ/7xlgvm9YLi2f51OwMYUg=
X-Received: by 2002:a05:6871:8802:b0:29e:563c:2dbf with SMTP id
 586e51a60fabf-2b32f286144mr9462267fac.26.1738403494288; Sat, 01 Feb 2025
 01:51:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123074830.90923-1-cuiyunhui@bytedance.com>
 <344c53cd-d856-4c03-9deb-743b65acd8aa@linux.alibaba.com> <CAEEQ3wmDej9bbPUmkx-ZrD4FG9Z7gTHMeCrVszx64g90O0RyiQ@mail.gmail.com>
 <31e00081-8695-4ca6-a1ef-af5a007a7565@linux.alibaba.com> <CAEEQ3wm+f_SM7evwL=YrGy8gPLS5YdJm=qhJNT8bbMH7QBOzEA@mail.gmail.com>
 <20250124122952.GB23438@willie-the-truck> <CAEEQ3wnTMfWSZRhTax3N60W=m3a=zxnJF6dOfiGnqJzBQs8WEg@mail.gmail.com>
 <20250127165156.GE25757@willie-the-truck>
In-Reply-To: <20250127165156.GE25757@willie-the-truck>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Sat, 1 Feb 2025 17:51:21 +0800
X-Gm-Features: AWEUYZmAdXUmi37d66_VLF0H-K_x7oGaiWsf00mIojMN1X-oiLjeCpkGsMu0T7E
Message-ID: <CAEEQ3wkj=6WPNFpet=A9JppiO52agw6HZArwhfWsWS9JOY6Dng@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] perf/dwc_pcie: fix duplicate pci_dev devices
To: Will Deacon <will@kernel.org>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>, renyu.zj@linux.alibaba.com, 
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Will,

On Tue, Jan 28, 2025 at 12:52=E2=80=AFAM Will Deacon <will@kernel.org> wrot=
e:
>
> On Sun, Jan 26, 2025 at 09:54:35AM +0800, yunhui cui wrote:
> > Hi Will,
> >
> > On Fri, Jan 24, 2025 at 8:30=E2=80=AFPM Will Deacon <will@kernel.org> w=
rote:
> > >
> > > On Fri, Jan 24, 2025 at 05:11:05PM +0800, yunhui cui wrote:
> > > > > >>>        vsec =3D dwc_pcie_des_cap(pdev);
> > > > > >>>        if (!vsec)
> > > > > >>>                return -ENODEV;
> > > > > >>>
> > > > > >>>        sbdf =3D plat_dev->id;
> > > > > >>> -     name =3D devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dw=
c_rootport_%x", sbdf);
> > > > > >>> +     name =3D devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dw=
c_rootport_%d_pmu", sbdf);
> > > > > >>
> > > > > >> A new name will break previous user tools.
> > > > > > This name isn't suitable. It can't clearly show which is the PM=
U
> > > > > > device. Userspace tools don't have binding relationships, like =
perf.
> > > > > > Tools must traverse PMU devices before use.
> > > > >
> > > > > The device is under /sys/bus/event_source/ which indates it is PM=
U device.
> > > > > As far as I know, most of PMU devices do not endup with a '_pmu' =
prefix.
> > > >
> > > > The point is the name "dwc_rootport_" is misleading, suggesting an
> > > > extra PCIE RP in the system. Best to change the name to intuitive
> > > > "xx_pmu".
> > >
> > > As pointed out above, changing the name will break userspace. So it's
> > > simply not an option, sorry.
> >
> > Could you specify what in the userspace is broken and give an example?
>
> Can't I just take the documented example from dwc_pcie_pmu.rst:
>
> $# perf stat -a -e dwc_rootport_13018/Rx_PCIe_TLP_Data_Payload/
>
> If I have a script that uses that command on a machine today, then
> applying your kernel patch will break the script, no?

Well, this is just a usage guide for the PCIe PMU and has no binding
with perf. In user space, the existing PCIe PMUs in the system should
be traversed first, and then perf stat/record ... can be executed.

It's okay not to change the name, but it's better to change
dwc_rootport_%x to dwc_rootport_%d to correspond with
platform_device_register_data(NULL, "dwc_pcie_pmu", ...). It'll be
more intuitive. What do you think?

>
> Will

Thanks,
Yunhui
