Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8261C4332F
	for <linux-perf-users@archiver.kernel.org>; Fri, 29 Oct 2021 00:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98E48610C7
	for <linux-perf-users@archiver.kernel.org>; Fri, 29 Oct 2021 00:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbhJ2AJe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 28 Oct 2021 20:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhJ2AJd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 28 Oct 2021 20:09:33 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FACC061745
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Oct 2021 17:07:05 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id i5so5444266wrb.2
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Oct 2021 17:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JM9ovXUoMQGYKoaMhT3SRYdxd24hIbjK2ebF0cmxAXY=;
        b=ZuKxTiy+FIXkT3r4QoosEwipVKEPKjVz65mQqrv9DXeFRdrLUGpI2Kx7CpiV1vYZQP
         G1hSiEXVntdl/cYopDkTkhVDyOiw/TBpwm3anuceKfqCzmDWpyi9MrhZz8vyVGDK5dXL
         uTaQ8gU6a6gd8J7agSEI60+jPY8eMHR28xu6L2UtsiPZsXc0QLHC8WTFiKVu33ZPGT+H
         7kvPcLCBRs4RjmfmQ+Jar5fgLOGGlhRXG3nqIRlKh5mmdmCI34GzNSZONWyNSC7gSmz5
         +f4xvWGiODrGTqq3sUB5E7Avtk07HR41a/Q3Tg4J6Wn/qPXSS3YT5WNFF4lohG0Rym26
         BpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JM9ovXUoMQGYKoaMhT3SRYdxd24hIbjK2ebF0cmxAXY=;
        b=4pkU2jl2Onif3ZX5aNMFM6xIHLoqjhSYDAUXsDWVSFEBTdSjRT1NBzw5uHFNTaChVR
         MCKsV4zAuScjXWoPB/qP20avj3B7kgVz8vob0mUeT7Hp9f3sBWH6/gHmuCCtyrKLCuPR
         2irjy8hGpqbCctTm//v3t5CnTzuqkzNzb2d0kEpv9TXpuXdHIP+uWalFZ23+EecKxZGI
         6ZuUWUp+ZiksChyUgNmL/YL+f2YrT+OLLFHwKH6z2dV+YW/xsyMewx0qjDq3nwjY9O4S
         exJI5LrQTUKlHfdeMAFY+W4rnvAfcrADE9Ad8i9qttMcBgtYDqAIFxTTpCLN/YG/0U1S
         DDmg==
X-Gm-Message-State: AOAM531pTT9bhmnnIpHjzBWducf3OI1ZeBLkZxRf4x41VpiaVy18EJhi
        PkoYBJ5tpFIIvlQMRb9KYBHvjg==
X-Google-Smtp-Source: ABdhPJxTZjsXKcFp8GnpfePalwr6klJnooGoh56zJ/LCNGXAeML3ODkDshvA2ZbtNAjmvvc7tNctjg==
X-Received: by 2002:adf:dc43:: with SMTP id m3mr9937982wrj.66.1635466024151;
        Thu, 28 Oct 2021 17:07:04 -0700 (PDT)
Received: from smtpclient.apple (global-5-141.nat-2.net.cam.ac.uk. [131.111.5.141])
        by smtp.gmail.com with ESMTPSA id h14sm8013871wmq.34.2021.10.28.17.07.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Oct 2021 17:07:03 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [v4 10/11] riscv: dts: fu740: Add pmu node
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <CAOnJCULqwZvK52nczp2HNinDCBjThnbGbvJpAvdameny1fK4Vw@mail.gmail.com>
Date:   Fri, 29 Oct 2021 01:07:02 +0100
Cc:     Atish Patra <atish.patra@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Anup Patel <anup.patel@wdc.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        devicetree <devicetree@vger.kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Chen <vincent.chen@sifive.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EDB030D6-D37A-43D6-9027-222794FDA80D@jrtc27.com>
References: <20211025195350.242914-1-atish.patra@wdc.com>
 <20211025195350.242914-11-atish.patra@wdc.com>
 <YXsMtrmuavGAHk8S@Jessicas-MacBook-Pro.local>
 <CAOnJCULqwZvK52nczp2HNinDCBjThnbGbvJpAvdameny1fK4Vw@mail.gmail.com>
To:     Atish Patra <atishp@atishpatra.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 29 Oct 2021, at 00:37, Atish Patra <atishp@atishpatra.org> wrote:
>=20
> On Thu, Oct 28, 2021 at 1:49 PM Jessica Clarke <jrtc27@jrtc27.com> =
wrote:
>>=20
>> On Mon, Oct 25, 2021 at 12:53:49PM -0700, Atish Patra wrote:
>>> HiFive unmatched supports HPMCounters but does not implement =
mcountinhibit
>>> or sscof extension. Thus, perf monitoring can be used on the =
unmatched
>>> board without sampling.
>>>=20
>>> Add the PMU node with compatible string so that Linux perf driver =
can
>>> utilize this to enable PMU.
>>>=20
>>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>>> ---
>>> arch/riscv/boot/dts/sifive/fu740-c000.dtsi | 3 +++
>>> 1 file changed, 3 insertions(+)
>>>=20
>>> diff --git a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi =
b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
>>> index abbb960f90a0..b35b96b58820 100644
>>> --- a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
>>> +++ b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
>>> @@ -140,6 +140,9 @@ soc {
>>>              #size-cells =3D <2>;
>>>              compatible =3D "simple-bus";
>>>              ranges;
>>> +             pmu {
>>> +                     compatible =3D "riscv,pmu";
>>> +             };
>>=20
>> This is a property of the user-replaceable firmware, not a property =
of
>> the hardware,
>=20
> It's a property of hardware that indicates that the hardware supports =
PMU.

All RISC-V hardware provides the CSRs, they=E2=80=99re part of the =
privileged
spec and not marked optional. How many aren=E2=80=99t hard-wired to zero =
is up
to the implementation. But even then you can=E2=80=99t know from the =
hardware
alone what is supported; the firmware has to enable S-mode (and
U-mode)=E2=80=99s ability to read them, so you can=E2=80=99t assume =
anything in a
static device tree hard-coded in Linux about what firmware has done.
Since you currently have to query the firmware to determine what=E2=80=99s=

available to you anyway, I see no benefit from having a node in the
device tree that tells you your firmware *might* have counters you can
use.

> Additionally, the counter overflow interrupt number needs to be
> defined through the DT as well
> so that a clean platform driver can be implemented.

The interrupt number is specified as 13 by the Sscofmpf spec.
But that=E2=80=99s not relevant here, the FU740 predates and doesn=E2=80=99=
t implement
Sscofmpf, meaning there is no interrupt to even define here. And as I
said on the other patch, don=E2=80=99t conflate =E2=80=9CSBI PMU =
firmware interface is
supported=E2=80=9D and =E2=80=9CSscofmpf is implemented in the =
hardware=E2=80=9D; the former
should be discovered by talking to firmware, and the latter should be
discovered like any other extension (however that ends up happening).

>> so having this in the device tree under /soc, let alone
>> hard-coded in Linux, is utterly wrong. Why can this not just be =
probed
>> like any other SBI interface? The "Probe SBI extension" interface is
>> precisely for this kind of thing.
>>=20
> SBI extension is anyways probed to verify if the firmware has PMU
> extension or not.
> However, adding the DT property allows different platforms (with or
> without sscof extension)
> to use the same code path.

You don=E2=80=99t need a device tree for that; that same code path can =
just be
=E2=80=9Cuse the existing standard firmware interface=E2=80=9D. That =
also has the
benefit that it=E2=80=99s not tied to device tree and so works =
identically for
ACPI, rather than needing an ACPI version of it.

I see nothing here that can=E2=80=99t be discovered through pre-existing =
means.
If it can be discovered without use of the device tree then it does not
belong in the device tree; the device tree is purely for things that
cannot otherwise be discovered.

Jess

