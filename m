Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA192FC86B
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Sep 2025 11:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900603; cv=none; b=Vfc+U+6+39AHRZuz7uAl5tNEbpIzdE6m7sYb0Fl3jjKM11xjaGzt5FYSvh5J0BCgFZutcWoxwjZT6qguFLuK1kMwgI8M2dXQQ0hM0gJ7TWmsv3Pl908+USXtljnXLAJXmJ1IqL7njr3QfeO2UyAKvyOA3F1I/PB7MzxoB2wdcsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900603; c=relaxed/simple;
	bh=QhtuA5fceXCkweMbThx5ayqE1iE7t/8jfmLDQDkaoMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bfpN1QqzfSESlHCb/hlNEOvJHsZu8xsf91sQ+wG1HrzWgDEfubYfqnvRh5up+E+PpAXYWmPs1nxF+hAfLUsK34UB81CPio2QXS9PDuNstR/lMTE/+XstbcAVqcqlbbLod8MNeNXLeuYNVmTDqH8YlG3P4bffvqF5m9C0nT7ovPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BHMuVxse; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BHMuVxse"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-30ccec928f6so3050410fac.3
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 04:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756900600; x=1757505400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APKSuSS/fVxVxNIRz7xmQz/WCEFPilAmQiDv33UmZds=;
        b=BHMuVxseSQ1RlceO1M/8Pl/Sjh85pCTxqfGII7rCkcoPYGbNLeeKZe7yHEgA5u8dQQ
         iE0+YtM3iin2bZocN6UxoqArShW0lxf5R1E1fkcEb+l0qKg/2HmzxK6hLKIppCnrBrLe
         DUnsE3nqnXmgekXPqIJqCA2JTpEhU9bmN8gM9BBz0UFwETiOynawJPt0zF6gl6ug8kxZ
         MbgX8AMZOOYDNN7vKsZEcYw67mh37qd2jlt4K8aj3ZpYsX2pLO310qI3hHU8OoYyD9J9
         y2wkMsQ+5PXDHktbnIfzxEjgd892HfE4Yyn1pG8l1WKSjKd/5BtQ4cQ9kwRjPrfRPDWR
         aHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756900600; x=1757505400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=APKSuSS/fVxVxNIRz7xmQz/WCEFPilAmQiDv33UmZds=;
        b=UEIwPFfoFbo9Wqz8nJFTp20j9W4eZcImPkhrdDsneNDZi1A/P0giEs3T6QyyB/4K+O
         YxDHgpWz3nYKUZ04kfsmBn/MsmlG3q3gpw1eDzq5sGRK2QOVierFych1XN0TdlL/eZ9J
         /B0VHQGbaPu8fD6HcFndkFbLiu0m7iI+BblCd4q3tWBry1izuPi8l+vNuK7gYZ6x1/NO
         5oCu5veIXHTVIJiF5Rjhvl0+vKVVeFGI+jmcb2QMqJYif/PvQ8SdccmnfLD9hcBm6ZEF
         a2QL9ftDyucYrnrDWnXKGG1QKEh0yRPNDFzi6Ys0mvGG5MtwAaUCIBZ7Qg6N3826SSEq
         sGOw==
X-Forwarded-Encrypted: i=1; AJvYcCV4dAVKhCyUdqCehn/VaSvejjNGc4N11XRaRTF9yTU9dvLZx9UpyLNCGaU1cLl++8IaJcFVN01DSCwuvXtSDTrE@vger.kernel.org
X-Gm-Message-State: AOJu0YxH18hNx4H4XxSvCnjfCN648nFzhqKYiXb0yNx7MvW9teDjMPEI
	NDcI7CvmbQ/pG5UdJhkwtWJg6FAUOmu35OMxd96gJ+Ks8m1cOm+IUePxhD/r0nYS/K34MFmzVdu
	IHFPe1Bo1ocw2yoM5gBWujtvLLEtNucltJriYoNPWmw==
X-Gm-Gg: ASbGncuX6hyi2f3FAsGtVffLxwfcpHMQaNKrDxd8hlVYRLb2qol33TT8nXt06skT1vz
	tPMYMS1OiZ1IICRMM8XXnxKGeLK26921qEB43T5kK0atZFhrDR0MbUX56Uzwhmbc41KdEPW8q9N
	n2GEjFT2FflZ82sIKw6uUt1jwqfVEq3f7j+maUdIw5G8+4Nk7gSX4PNKLqulAbvHcVbA8YuqDuN
	Vbnzw38HrwV+xDwq7g3Vi2WoM8vdmA=
X-Google-Smtp-Source: AGHT+IHzNG/bae/flkHEvpbYr0cWRiFGYBcRlfIUCA0hkHWscwORrD9erXClVYnAWO9a+v6BZHjoa+d3ZcNUM1a30FA=
X-Received: by 2002:a05:6871:3686:b0:314:b6a6:68a8 with SMTP id
 586e51a60fabf-31963480bf7mr6232182fac.48.1756900599934; Wed, 03 Sep 2025
 04:56:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827100959.83023-1-cuiyunhui@bytedance.com>
 <20250827100959.83023-2-cuiyunhui@bytedance.com> <CAD=FV=WiZ5=4Ck3G2gme=ey6uYQhi-3Wo32DpLj9P53wxGCojw@mail.gmail.com>
 <CAEEQ3wmBvevbkP8XmwR0_q_1QWQsie5g0UUxTFm6ovS1m41pEQ@mail.gmail.com> <CAD=FV=UzUCPtwuQRFR0SkAkh63MbzMefxNYmiOBxCemL3P_+EQ@mail.gmail.com>
In-Reply-To: <CAD=FV=UzUCPtwuQRFR0SkAkh63MbzMefxNYmiOBxCemL3P_+EQ@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 3 Sep 2025 19:56:28 +0800
X-Gm-Features: Ac12FXxqD3B_4az_DfqpBxwMDURjxHr7LFapX1M6NDjnkBWeIMm-90QquXtdgEE
Message-ID: <CAEEQ3wmLOjZxVh_vBhmctH-u_ZSxnyg0GiN-_e_4v8_pfxcbSw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/2] watchdog: refactor watchdog_hld functionality
To: Doug Anderson <dianders@chromium.org>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, atish.patra@linux.dev, anup@brainfault.org, will@kernel.org, 
	mark.rutland@arm.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, catalin.marinas@arm.com, 
	masahiroy@kernel.org, suzuki.poulose@arm.com, maz@kernel.org, 
	zhanjie9@hisilicon.com, yangyicong@hisilicon.com, mingo@kernel.org, 
	lihuafei1@huawei.com, akpm@linux-foundation.org, jpoimboe@kernel.org, 
	rppt@kernel.org, kees@kernel.org, thomas.weissschuh@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Doug=EF=BC=8C

On Wed, Sep 3, 2025 at 1:04=E2=80=AFAM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Sun, Aug 31, 2025 at 10:57=E2=80=AFPM yunhui cui <cuiyunhui@bytedance.=
com> wrote:
> >
> > Hi Doug,
> >
> > On Sat, Aug 30, 2025 at 5:34=E2=80=AFAM Doug Anderson <dianders@chromiu=
m.org> wrote:
> > >
> > > Hi,
> > >
> > > On Wed, Aug 27, 2025 at 3:10=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedan=
ce.com> wrote:
> > > >
> > > > Move watchdog_hld.c to kernel/, and rename arm_pmu_irq_is_nmi()
> > > > to arch_pmu_irq_is_nmi() for cross-arch reusability.
> > > >
> > > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > > ---
> > > >  arch/arm64/kernel/Makefile                   | 1 -
> > > >  drivers/perf/arm_pmu.c                       | 2 +-
> > > >  include/linux/nmi.h                          | 1 +
> > > >  include/linux/perf/arm_pmu.h                 | 2 --
> > > >  kernel/Makefile                              | 2 +-
> > > >  {arch/arm64/kernel =3D> kernel}/watchdog_hld.c | 8 ++++++--
> > > >  6 files changed, 9 insertions(+), 7 deletions(-)
> > > >  rename {arch/arm64/kernel =3D> kernel}/watchdog_hld.c (97%)
> > >
> > > I'm not a huge fan of the perf hardlockup detector and IMO we should
> > > maybe just delete it. Thus spreading it to support a new architecture
> > > isn't my favorite thing to do. Can't you use the buddy hardlockup
> > > detector?
> >
> > Why is there a plan to remove CONFIG_HARDLOCKUP_DETECTOR_PERF? Could
> > you explain the specific reasons? Is the community's future plan to
> > favor CONFIG_HARDLOCKUP_DETECTOR_BUDDY?
>
> I don't think there are any concrete plans, but there was some discussion=
 here:
>
> https://lore.kernel.org/all/CAD=3DFV=3DWWUiCi6bZCs_gseFpDDWNkuJMoL6XCftEo=
6W7q6jRCkg@mail.gmail.com/
>
> -Doug
>

I=E2=80=99ve read your linked content, which details the pros and cons of p=
erf
watchdog and buddy watchdog.
I think everyone will agree on choosing one as the default.
It seems there=E2=80=99s no kernel/watchdog entry in MAINTAINERS=E2=80=94wh=
at=E2=80=99s next
for these two approaches?

Thanks,
Yunhui
