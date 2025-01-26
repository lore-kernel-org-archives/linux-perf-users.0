Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3118225A626
	for <linux-perf-users@vger.kernel.org>; Sun, 26 Jan 2025 01:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737856489; cv=none; b=q88vByn9WHtXLiFNgfF7lF0FmaByZ4uFLyBYumOt/uQ+jNv6y38sAS5tS9VXc0yjfxqiqRyUkCzVdUWxKrl5k0Ry/0Up2rlR2DtSGc85mAjJCrntdIpieSmDGVEUK9hHowMEqPeLz5Tw7Rd+dJGw388kuYMaUfsshFGzuhU77FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737856489; c=relaxed/simple;
	bh=zHegwg6oCHtJ1V4r2psTH4fYZFbKQuA2ZT27s9iCqsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NAJrWt9GXAJ5ooslvLKMsiJOtacvVKpEJ+bW6uGgm20BYBW48Xwu4Yc16yvo4yfODMtrNWLjuyBeQsCt2QQmRut4IMD1x+ZppjKLWn6WuqaHDCPCWygpYrolFevNPsNTkD50YtCxwrutg7ZMu0wy/hSh/cWsBOVw1Evit+Ua5es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YOGKfKCa; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YOGKfKCa"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-29fc424237bso2379102fac.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Jan 2025 17:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1737856487; x=1738461287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rlwAWxWxHq9jBioa+OPFge+D1FchZhTsMwVSUxdLRyw=;
        b=YOGKfKCaE+aJXAKJIXtvql8L5nF4XTFxs8ddcp45+QEwAj06y4dw3liIy705cAp3mg
         XB44ZjOkYDOPeqEYNiuMb3f+wrpJBAJWyZo8sEnk3ulVeaCQxzF9T1oNgKzdd7nvrVLK
         ngfNMsRKP9eJh2USPP2aNX0QB9ZS2VEsDSn77wodKTY/4HVMa4A7FUJZD0Ytm5c6OauA
         wQFWqulA7dvjbaNUn5gaDAbHEzZpRH2Ks90ozSiAVaUT1ZEB62FXNlsO4h657pqAUauI
         Ykwkr2oWfMFdV2NRZ+N1DIzjf9Jb1Y8uTA36JuY927ehccUVuVcZlcn/vdYyku31arxF
         rR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737856487; x=1738461287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rlwAWxWxHq9jBioa+OPFge+D1FchZhTsMwVSUxdLRyw=;
        b=TScFi5ncA3yY/OxoPd6s9DDUgHGwStp23j5Tz/ybZC/NdgvXi/Ahdag/yEW8qKGmkP
         FcBWQu8PM3bsTO2m7Wn/vSjXnkwwG6Sele+at/0ZRc9F7LsiiHxAj/bjPf1a8E9u32xF
         mbtmKyMY2X8fdjyCmW6/xKsjanuD/vDsaecCEtZkRGkSsuuDHBGQWg1ENK1HUuW69t26
         35lk6dy4uZLvrHDVuJNI11nuLGD+DOXLIYfwdaQDBe8qWoHRomMJOGwpcbP8uTJKrqoH
         Y/6YUdsdEU/kd82GJ2SQqsSMW1OAsiS/bAiXVb0AXq/+RyVsX7583rgaKKDguWTkeHHV
         ZkSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZG098NKjgGzHyALrpfgdiXv08pkI9GKEbabtLZ6YdqFqpz9VVe3MNI8T+pQ3qah5azbvl8ev4y7oAOz6wD+8W@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9o+g+BOEq/XHCd2+ctbaxCzIFfE0WBe55XhdBUJmA55ro4WOO
	XBsyq8hvMV0/+uYYAvVvdfQVEbEPqcxlh2fkWx0UglA9nnbKEH9J0kFtXeVU383lnjCthJxl+cH
	NKhq78ob/VlXZgIBfrQXy1BCNVNvR8C+huq1Abg==
X-Gm-Gg: ASbGncutWrj2B3BetA41GHQO5fs7B6oEpM2ZGQs68mq8lMxYN8CgK6Zz9kSbG+Srq1f
	SXlNldwwbriQ40I2YA9O23bsB8R4WCAAm+I1jzxjeWYUmXGmLSeak7VMUrOSx80/9
X-Google-Smtp-Source: AGHT+IEXOf1ihKfapU13xYBIhLv4gy8wQGEe7hCvBOcSSCO0IvhngnY90gf7S+TP4D+yRKoMLT+l8Ks62C3W/Etv9bk=
X-Received: by 2002:a05:6871:630e:b0:2a0:1162:425a with SMTP id
 586e51a60fabf-2b1c0c55429mr19339653fac.26.1737856487102; Sat, 25 Jan 2025
 17:54:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123074830.90923-1-cuiyunhui@bytedance.com>
 <344c53cd-d856-4c03-9deb-743b65acd8aa@linux.alibaba.com> <CAEEQ3wmDej9bbPUmkx-ZrD4FG9Z7gTHMeCrVszx64g90O0RyiQ@mail.gmail.com>
 <31e00081-8695-4ca6-a1ef-af5a007a7565@linux.alibaba.com> <CAEEQ3wm+f_SM7evwL=YrGy8gPLS5YdJm=qhJNT8bbMH7QBOzEA@mail.gmail.com>
 <20250124122952.GB23438@willie-the-truck>
In-Reply-To: <20250124122952.GB23438@willie-the-truck>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Sun, 26 Jan 2025 09:54:35 +0800
X-Gm-Features: AWEUYZnjTNudJLKYBjStW-XVXHtOfqxKQ5nXUCNPH1jPKAdahkJrAo65xHG4-aw
Message-ID: <CAEEQ3wnTMfWSZRhTax3N60W=m3a=zxnJF6dOfiGnqJzBQs8WEg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] perf/dwc_pcie: fix duplicate pci_dev devices
To: Will Deacon <will@kernel.org>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>, renyu.zj@linux.alibaba.com, 
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Will,

On Fri, Jan 24, 2025 at 8:30=E2=80=AFPM Will Deacon <will@kernel.org> wrote=
:
>
> On Fri, Jan 24, 2025 at 05:11:05PM +0800, yunhui cui wrote:
> > > >>>        vsec =3D dwc_pcie_des_cap(pdev);
> > > >>>        if (!vsec)
> > > >>>                return -ENODEV;
> > > >>>
> > > >>>        sbdf =3D plat_dev->id;
> > > >>> -     name =3D devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_ro=
otport_%x", sbdf);
> > > >>> +     name =3D devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_ro=
otport_%d_pmu", sbdf);
> > > >>
> > > >> A new name will break previous user tools.
> > > > This name isn't suitable. It can't clearly show which is the PMU
> > > > device. Userspace tools don't have binding relationships, like perf=
.
> > > > Tools must traverse PMU devices before use.
> > >
> > > The device is under /sys/bus/event_source/ which indates it is PMU de=
vice.
> > > As far as I know, most of PMU devices do not endup with a '_pmu' pref=
ix.
> >
> > The point is the name "dwc_rootport_" is misleading, suggesting an
> > extra PCIE RP in the system. Best to change the name to intuitive
> > "xx_pmu".
>
> As pointed out above, changing the name will break userspace. So it's
> simply not an option, sorry.

Could you specify what in the userspace is broken and give an example?

>
> Will

Thanks,
Yunhui
