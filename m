Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3802F46
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Feb 2025 01:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738719954; cv=none; b=IdMXiEtyNAN0OZ+n57rKjJMAgIpO8q2Yu1KPzTOZDuOcFDIhkDh2cqZPqd+q/gW0U+b46iwxc1/HHk7z0HoqJvGV6PqRsvFrMS1aP8F0TBPeX27SH9vbhA9gKA0co1UgVl5DMr33i8XNkXdFod5btjM3CEg436L5KVjLGln9NSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738719954; c=relaxed/simple;
	bh=ZoEiT11FirZk0Rvcwi7FZfncpwTglMOW6FlwroEyjeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Miq2PFxELRFA8BzbgkKm03TEajFHN4o34SJnG8JtrmMIz1ZQdxiaRaOQYEI19ft2/RtpKN42eJCtPB4Lg4U2WNVHgKmjBi90cysi8tU2ez9zuFoczMvAnPNl2xLe1v0QSABLlqse4+4rEbOYk9L0e9mXLIom2YkSnmO0bWoudRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=iuR7fZN7; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="iuR7fZN7"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2a3939a758dso1983187fac.1
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Feb 2025 17:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1738719952; x=1739324752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7IAX40SIwOCKUJKjDGDjSIt4+fAEfgGp/BRmQSe+AM=;
        b=iuR7fZN7j0Lt4NNcHjIOO2D4xR9jI9bmGUmUqJQ6GW/YfIh0wLx9aVhD3ecOkRzmCr
         ZXooSd1Lq/+J1YihsGrJn/XXhtPtIkJlkHxUns5I6xC5WhzNnEtjQkGU5WOd+PfPbIIO
         0HnvKcolaKHXuqDXpKyyoXLWu5kTcblKnPihrnVubzRmydN1Y+Ph7XCyQZRDrp8lZ7NB
         2Yg5R5sCCOwHyR1XDAeNXlvQQksmDCsekBo5Jw++EvYVshIP9MaNbyiYbXLYYfdL1sWE
         v9WQK2o5Vqz/99+hlCt4GoxZeuxVt4Gpsg+MiO+RrRIW8iH0wK+diVOF072Wx16Qugd0
         lCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738719952; x=1739324752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7IAX40SIwOCKUJKjDGDjSIt4+fAEfgGp/BRmQSe+AM=;
        b=PA7DNzy8hluchmdGaHTg05+G729nv6Dq4dKQ4oxpqtXLHt94Pnz855Riv+AWo1S4fx
         HVuOROa3mEKsNsWPobxLEaHU1hKru5s/r/6ODC/yiQM4Z0rAdZ615t/aiZzhyYRKyYk8
         4bsKkaFkGw5XkQPlnnF8r+P+ZNHRH2XnNCj/mWRD4a27uJBTG5YEQvyGp7U55z9Viahk
         XzFnn5b+M5PFNIsQu2gq4bAYjN4GcRWQWl3vORLDauNhfVd2T1iEKgMbSURfohqORIvZ
         PY9xW5USnei5Jk+Q+myzuKBJj0Mf5DKyeXtNyZtkjiqGnvdHsQOgLTLcgk1doxMLhxhc
         tifQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZdzq3BfvWwVsnO8G8+4rIT/PDxOyXISyWppNQ7gf0g+dwZgcJa735pbvjXXItK0MCJZ+hi/wGP6eJSI864hSJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0gt+SaUe/hcG2PqAIEnk8JdhCH4zSWByuyEOWHgkcacGlrhGR
	by7iAXAie0cpvsq9RKhunD+wD/geVi6qRvYyqxU9pgmoH9SmssUmLSxGY2tnjoZqeL9DvTMEl/y
	yrccWwjbiyoOWoJpPH0pmElGczgjh1aVkdKYxNQ==
X-Gm-Gg: ASbGncsujX+YAdEC17AAwcYQI5zshWJpnznrgii3gd6DfSFMdgRatWmygyJueQNz43K
	ze7UzjPWuFldmmIF5Xb+RnuzjqWGttjo20+1d4pXFykFZJu9EHQwBuiYpV/mSSCh/4uaU0s+2mY
	A=
X-Google-Smtp-Source: AGHT+IEEJSiApgxtxkGvC1xkEun8OovYoTlWGkz+UQfZ8HucQFQwWaCsmxUZdvb+jMWhRMNgUFoinaHR5BnA3MfwaiE=
X-Received: by 2002:a05:6870:5491:b0:29e:43ce:a172 with SMTP id
 586e51a60fabf-2b805126ddbmr804659fac.28.1738719951653; Tue, 04 Feb 2025
 17:45:51 -0800 (PST)
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
 <20250127165156.GE25757@willie-the-truck> <CAEEQ3wkj=6WPNFpet=A9JppiO52agw6HZArwhfWsWS9JOY6Dng@mail.gmail.com>
 <20250204123111.GC1063@willie-the-truck>
In-Reply-To: <20250204123111.GC1063@willie-the-truck>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 5 Feb 2025 09:45:40 +0800
X-Gm-Features: AWEUYZllMpq2zJ1npesrHO1aKImtAqIVbLmJaSG6r67qE0xNiTPEAJWsfWgmnw4
Message-ID: <CAEEQ3wm4_oeBbVqsVrZ373j1SFBo6-DegL6ojH-ZCMwcw_-jVg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] perf/dwc_pcie: fix duplicate pci_dev devices
To: Will Deacon <will@kernel.org>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>, renyu.zj@linux.alibaba.com, 
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Will,

On Tue, Feb 4, 2025 at 8:31=E2=80=AFPM Will Deacon <will@kernel.org> wrote:
>
> On Sat, Feb 01, 2025 at 05:51:21PM +0800, yunhui cui wrote:
> > On Tue, Jan 28, 2025 at 12:52=E2=80=AFAM Will Deacon <will@kernel.org> =
wrote:
> > > On Sun, Jan 26, 2025 at 09:54:35AM +0800, yunhui cui wrote:
> > > > On Fri, Jan 24, 2025 at 8:30=E2=80=AFPM Will Deacon <will@kernel.or=
g> wrote:
> > > > >
> > > > > On Fri, Jan 24, 2025 at 05:11:05PM +0800, yunhui cui wrote:
> > > > > > > >>>        vsec =3D dwc_pcie_des_cap(pdev);
> > > > > > > >>>        if (!vsec)
> > > > > > > >>>                return -ENODEV;
> > > > > > > >>>
> > > > > > > >>>        sbdf =3D plat_dev->id;
> > > > > > > >>> -     name =3D devm_kasprintf(&plat_dev->dev, GFP_KERNEL,=
 "dwc_rootport_%x", sbdf);
> > > > > > > >>> +     name =3D devm_kasprintf(&plat_dev->dev, GFP_KERNEL,=
 "dwc_rootport_%d_pmu", sbdf);
> > > > > > > >>
> > > > > > > >> A new name will break previous user tools.
> > > > > > > > This name isn't suitable. It can't clearly show which is th=
e PMU
> > > > > > > > device. Userspace tools don't have binding relationships, l=
ike perf.
> > > > > > > > Tools must traverse PMU devices before use.
> > > > > > >
> > > > > > > The device is under /sys/bus/event_source/ which indates it i=
s PMU device.
> > > > > > > As far as I know, most of PMU devices do not endup with a '_p=
mu' prefix.
> > > > > >
> > > > > > The point is the name "dwc_rootport_" is misleading, suggesting=
 an
> > > > > > extra PCIE RP in the system. Best to change the name to intuiti=
ve
> > > > > > "xx_pmu".
> > > > >
> > > > > As pointed out above, changing the name will break userspace. So =
it's
> > > > > simply not an option, sorry.
> > > >
> > > > Could you specify what in the userspace is broken and give an examp=
le?
> > >
> > > Can't I just take the documented example from dwc_pcie_pmu.rst:
> > >
> > > $# perf stat -a -e dwc_rootport_13018/Rx_PCIe_TLP_Data_Payload/
> > >
> > > If I have a script that uses that command on a machine today, then
> > > applying your kernel patch will break the script, no?
> >
> > Well, this is just a usage guide for the PCIe PMU and has no binding
> > with perf. In user space, the existing PCIe PMUs in the system should
> > be traversed first, and then perf stat/record ... can be executed.
>
> "should be". ha! You know we can't rely on userspace doing whatever we
> think it "should" do.
>
> > It's okay not to change the name, but it's better to change
> > dwc_rootport_%x to dwc_rootport_%d to correspond with
> > platform_device_register_data(NULL, "dwc_pcie_pmu", ...). It'll be
> > more intuitive. What do you think?
>
> No, as I said earlier, we cannot break userspace like this. Please stop
> trying to rename things that cannot be changed.
>

All right, I'll update it to v2.

> Will

Thanks,
Yunhui
