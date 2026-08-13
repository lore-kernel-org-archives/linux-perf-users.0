Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25FE3EBF14
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 17:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786643796; cv=pass; b=DI37clvOlKv8wh78Ak65NbNeuwOxqrwh1xk2cd8UrTbVQHVTbCTPcA4Mw+foR1wqg8Yl+YmFMhCwARAxzuxpTjUcGR+8agNjNH62nZo/et02ze+QbSF7ZHvy3HrKHYrcN4Azc3OtO0dWS1SCZPFxaqVlDffJMn24qUHoXQlk6V0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786643796; c=relaxed/simple;
	bh=oGxJ52G0965+naj8sthJZ/JUdTvHZgUdBTpUQ5K5ulc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e0bs3M/mmX8wVLITTmeH2PXnUX1zIyZfVxa1PxPEsRVi6xjvZtzJe3d0yStJaHXK0wCIPt++zhEn7PXVhospMC7efgBEnyWGlNP4NCeL9BeELgabg5bdvjNk9kvsdECHtDKc/A4YqSDUr9VTiqraUKUzJJJioI350Ly3+GbMsKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G6gaVk6X; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G6gaVk6X"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cab97c86bdso10035ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 10:56:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786643781; cv=none;
        d=google.com; s=arc-20260327;
        b=UaKtbfpae9VxS8yB0Iy5J29uGBUFBgvpsOyQVtPNJmKE4Vz0d9ImP1zKWaAThfgn96
         KkJpGbMXMuhHsadibKUhfzljkPLYnN8Eb2fq1cYjn85WRzBNEtqxvG1w1rHwCRQJmwWw
         JaanrLpe6qQS0UspDoWG328K8syDiqlAhFKX6GGC/tFhiGfL0rv3Vrq/izDwCyygKNWS
         FhJo7z2vGuyWrIIpIWJTC1lfw123BM2hHMdXfiuO0s51RyUBUV8eSTq7bro1+poT2An2
         nRB12xXAzz56G4eak8RJk6/e4V6hYyVvysRzB5kQW3NJTb+LXLA4vf/PtIhH0+EJfgNg
         BL8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oGxJ52G0965+naj8sthJZ/JUdTvHZgUdBTpUQ5K5ulc=;
        fh=VrAcEuDF5Sw05xJzcxz9M8S4yjI48LA3KSEqy8oxTYk=;
        b=YMY8sswHcdWLupb6ibWE5On44M10rYl3BI3FyifGNp2FvJmK24kvrBFhA5J/WwVQnN
         pE/PcDv7wxXFPP9en7To5Ya/SB+cfijPo55CN1rsSRZSZAn9MP6+Iq6Y3ntXwlxBqteq
         zEtPsBiZLQmJvKUO+8gXsoCcUIKPv7QOY/xYSvSu8/zbcARM4i9EaTypvHyqyIa8QXCe
         o33X3S9tr9PXWaiWWepNsghMe7THoBL60QqyxakC7OwQhq5yJKgYRM9oNixiq9rEQo/T
         JH6yPMmiCou/ibL8zT1hXtn9K5zQPqJX5kOfvu4ADCz3BhiSrNSzzJKjfN9DENu0tPK4
         L1tg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786643781; x=1787248581; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oGxJ52G0965+naj8sthJZ/JUdTvHZgUdBTpUQ5K5ulc=;
        b=G6gaVk6XzuDh3RS5e1FSNEtaCCHWh4JwXsnW49AdG1bLw6cJK6vASVdn/zfP+v6FG4
         W9Di6Ed6h1TzW+krUsaGizkgfcavM3e3U9gHiH/iY1U2gtf6gcZHjVZgF2Qu3v3weK92
         Hf14S4Fo4BaatTUdn1AQxNYklPrdrNEkK06vFvZ+UQdVoFUjYDddCu4ag1BBvTXkw6V9
         D3MnzJr2t1O1VKuGcGJMZAdybgXY91YW0u/2Ddvwg20+Z2VgbYrdjp6O2AdgPxbXvO4+
         F8mNudiBX1MlDr866JT1PDNpI7smGUVGComjFvylDVr5jD7j/qA/CTuYYjHWgdFDQOH5
         hgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786643781; x=1787248581;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oGxJ52G0965+naj8sthJZ/JUdTvHZgUdBTpUQ5K5ulc=;
        b=XWEo5miCgU4Y9KuxOXaiPiCU3dwpNdGXjQDdmdrXZXm6epFdghxb6LQfeH1I+kq3mp
         OmGj+CWd60f90iQpIC+SidzRPIeLyhwGfTtu/Sn/PfOrsURfhVVOEdjhYy82F49QB6eC
         rIJMaMk/mdReJ7pevJcgOWKHT2vHn+4T26+5EXt7nyKfbnuHgpX/JIVaY1nA3Qmnm0c6
         86F0fcaFbVQM3bng7NhiktvRapHHyQHsgOSTrq3fAC+6Vo/CcTGuz9/I+wo6LBR7bzp5
         9wvsdwNZRg/CXnbqoj1bSOlsUMiiNxpgEzK4azVan3C49jA/MIdGuNW2FnGRtCHgDP1N
         zU9g==
X-Gm-Message-State: AOJu0YxHiytBQc5y1y2oVUqfCPs0FjeiRjpMg5U71Kiu1Bnus4Ua7/E+
	Gady+TurOzhZgYtIipgi1ARKXTCkwNSKp074GxYpHWELqL3r0v30534u3sUqj7dE6ZyXsAC5Qkg
	H4wqqNp1//JgXek6yPg/xRhzrSvPkULUZ9MwxN7RLnbpQJTE5MeBNexY6Gp8=
X-Gm-Gg: AR+sD12Uh10ye/PJdCqmLSxWCzh75txV+3/SjzNjNJ0GzNoap7XOraACkMgZjfvuh8T
	TxosYH2h6maZssx/IzBS4cFMXeXK8cfEVT0egQquoixVl8IsJYi2/k2uuj15kmD6PwzVpXQ+n3F
	367bRqOM25YNCFiDoFmLByNQRGSLac5xuBfYUcuR8mI+sCzxsrftUwXzHYP9IVc3UElJZM8g9Cl
	q65OO7jZr0nP8oOImzsWdyj0q/B8SRTr6il18Wsd43AinlQWwRsWgG1exGr+UK/ryIaCoD89BQT
	t8SKtjpj7WRwtEyQ+X+D5Lk/6Z+S4Bdx8nk179Sarbf2WA==
X-Received: by 2002:a17:903:22cb:b0:2c0:defb:557e with SMTP id
 d9443c01a7336-2d3af569557mr618275ad.1.1786643780745; Thu, 13 Aug 2026
 10:56:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812002728.2283079-1-irogers@google.com> <20260812052417.2361040-1-irogers@google.com>
 <anwuYYxLFbtDmmHx@willie-the-truck> <CALeDE9P1xZonVnZDExR_hMafd4mxahkjBVTDLJenQ6DKW5MSHA@mail.gmail.com>
 <CAP-5=fXd2HETe-484Pe5wMTGPiXbLheMaW6ZDpdD+YCtKoBHVg@mail.gmail.com> <4fc52c7d-85eb-40ec-9e90-2a20f194c64f@broadcom.com>
In-Reply-To: <4fc52c7d-85eb-40ec-9e90-2a20f194c64f@broadcom.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 13 Aug 2026 10:56:06 -0700
X-Gm-Features: AUfX_mwatuYIj4f9Cb7rMpohs4H2M2BSR-5YKqD8oWMTtc2hMKt-hXpbQb43pAE
Message-ID: <CAP-5=fU1y=NqqpRWTDyhvr1KEBnGNA8=b9XQvJLVie1AF-Ke0w@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] perf: Add Raspberry Pi AXI PMU driver
To: Florian Fainelli <florian.fainelli@broadcom.com>, Peter Robinson <pbrobinson@gmail.com>
Cc: linux-perf-users@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 9:34=E2=80=AFAM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> On 8/13/26 06:48, Ian Rogers wrote:
> > On Thu, Aug 13, 2026 at 2:08=E2=80=AFAM Peter Robinson <pbrobinson@gmai=
l.com> wrote:
> >>
> >> On Wed, 12 Aug 2026 at 09:28, Will Deacon <will@kernel.org> wrote:
> >>>
> >>> On Tue, Aug 11, 2026 at 10:24:15PM -0700, Ian Rogers wrote:
> >>>> This patch series adds an uncore Performance Monitoring Unit (PMU) d=
river
> >>>> for Broadcom AXI system and VideoCore VPU performance monitors found=
 on
> >>>> Raspberry Pi SoCs (BCM2835 through BCM2712 / Raspberry Pi 1 through =
5).
> >>>
> >>> Why are you sending four versions of this patch series, at -rc7, each=
 in
> >>> reply to the previous one? Nobody is going to review that.
> >>
> >> I'm also wondering why this is called rpi_axi_pmu where it very much
> >> looks like Broadcom IP, and is possibly used in other Broadcom SoCs,
> >> Florian can you confirm what this driver should be called?
> >
> > I'm somewhat agnostic regarding the naming, and having a more general
> > driver strikes me as a good thing. Fwiw, I based the name on a
> > somewhat similarly named non-perf-compliant driver:
> > https://github.com/raspberrypi/linux/blob/rpi-6.18.y/drivers/perf/raspb=
errypi_axi_monitor.c
>
> Given this uses the Raspberry Pi firmware interface, having
> rpi/rasbperrypi in the name is sensible IMHO, but the IP is technically
> from Broadcom AFAICT, so using a bcm2835 prefix wouldn't be far off.
>
> Ian, I am really having a hard time following all of your frequent
> submissions, would you mind waiting for feedback before spinning new
> versions?

Hi Florian,

I'm very happy someone from Broadcom is engaging with my driver :-) So
on linux-perf-users the norm is to address Sashiko's feedback, and
once that is down to an effective zero for humans to come in. For the
majority of the patches what Sashiko is complaining about are races
during teardown, potential hot plugging races, etc. Note that this
driver is more advanced than ARM's main PMU driver because it supports
hot plugging, thereby not breaking the perf tool were someone to hot
plug a CPU. Anyway, between versions, things are about 98% the same
and I explain the differences in the cover letter. For the v11 patches
Sashiko has 1 medium issue left regarding hot plugging:
https://sashiko.dev/#/patchset/20260813142608.2954099-1-irogers%40google.co=
m
This is a substantial reduction from the v1 patch that had 13 issues
with 1 being critical:
https://sashiko.dev/#/patchset/20260811083828.2057695-1-irogers%40google.co=
m
For the v11 review, since the boot CPU and the CPU hosting the PMU are
both CPU 0 and I don't believe it is hot-pluggable, this issue doesn't
really matter. However, having a robust driver in all respects is
still desirable, and I plan to address the feedback. I need to spend
most of today not having fun at the hospital, so I can hold off fixing
this and sending out a v12. My point is that v11 and v12 would be 98%
the same but v12 would likely include an "if" statement to address
Sashiko's feedback: "Does this early return leave the PMU permanently
bound to an offline CPU if a hotplug event occurs during probe?". I
suspect your review wouldn't focus on hot plugging races, I am much
more concerned that the counter reading logic is valid.

I'm on some sick leave and this work isn't part of my job. I am trying
to finish it before someone might misconstrue my sending Raspberry Pi
patches as me thinking this is a part of my job. While the mailing
list you are coming from may experience low volume, it is much more
the norm on linux-perf-users
(https://lore.kernel.org/linux-perf-users/), where I am a significant
contributor and Linux MAINTAINERS file reviewer. I do my best to avoid
Sashiko catching issues (bisect builds, hardware testing, scrutinizing
code, Chris Mason's review prompt analysis and local Sashiko runs) but
I think with the way models are the churn is something of a feature of
the moment. I expect that when the next level of AI agents (which I'm
using to assist in writing the code) emerges, the number of versions
and churn will reduce dramatically. I don't think we should ignore
Sashiko's points, and my own time constraints mean I want to send
things out ASAP in order for there to be the best driver I can see to
on the mailing list. Suggesting a week-long reply delay is so silly
that I was amazed it was made in this thread. I can only apologize for
the distress receiving an email is causing people. Please print out my
picture and abuse it. Come to Linux Plumbers in Prague and use one of
the 3 talks I'm giving as an opportunity to throw a microphone at the
back of my head and never issue an apology (fwiw, this happened to me
while hosting a perf related mini conference at LPC in Vienna and so
the abuse isn't just verbal).

Wrt will the code be merged, etc. You can bring a horse to water but
you can't make it drink. I believe there is significant enthusiasm for
the driver:
https://www.phoronix.com/news/Raspberry-Pi-AXI-PMU-Linux
But the number 1 refurbished laptop is a MacBook M1, which one would
think is an excellent candidate to run Linux, yet its PMU driver
appears to have little maintainer effort applied to help it land:
https://lore.kernel.org/linux-perf-users/20260101-apple-cpmu-v10-0-48812c52=
9ffc@gmail.com/
Everyone is busy and I hope to be respectful of that, but this is work
I'm giving away for free that I genuinely think will improve things.
If you want to read the patch or email tomorrow I don't mind, it is
just an email. If you hate me and want all my emails in /dev/null,
that's your choice. Maybe the patch only ever ends up in the Raspberry
Pi's flavor of Linux, that's fine with me. Maybe it is just a driver
people have to pull from an email thread like for the Apple M1. I'm
genuinely trying to be helpful while doing my best to smile at the
"you don't know how to use email" and whitespace vigilantes*. I do try
to privately escalate issues with more senior members of the Linux
community when I think the goodness of Linux for users is being
impacted, such as drivers for popular hardware being ignored. I can
only do my best, but people I work with avoid engaging with LKML and
the "reviews" so far on this patch series are a good example of why.

Thanks,
Ian

* If you are upset by whitespace, why not add it to the Chris Mason
review prompts that Sashiko builds from and automate the process (you
can see my PRs doing similar things for things like musl libc):
https://github.com/masoncl/review-prompts/tree/main/kernel

> Thanks!

> --
> Florian
