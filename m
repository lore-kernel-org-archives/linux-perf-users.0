Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14ACDC433FE
	for <linux-perf-users@archiver.kernel.org>; Fri, 29 Oct 2021 12:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF677610C7
	for <linux-perf-users@archiver.kernel.org>; Fri, 29 Oct 2021 12:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhJ2M1j (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 29 Oct 2021 08:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbhJ2M1h (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 29 Oct 2021 08:27:37 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2935FC061714
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Oct 2021 05:25:08 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v17so15874856wrv.9
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Oct 2021 05:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=w7ERDMxld9y+CPUnX75l8Ta0sFWie18coBUraZlyenY=;
        b=KoIfAALYtn/x4ST7dyMPyMUL21tc/UEqneS4L9orO2RmQSLOPMraMaM4Ive3ZB47Pr
         FQOEDMWe5ToTjOF9mXQxjNDlm5DgRpxW4+cjydO3mYptYWMFTNX8tFPkJnjTCRb6dZR5
         hAyT9b84MLVMwGmdhg76Q7PBjSnEo6i6l0WNxM1/7J2lLGER4dS/xPBKXrRZ5xzHIR/z
         SZDVFpxyqxwRvYiydNNBgRMgef8PsCLY8rPTm9uNOYFUZG16hba7AEO4NWcAwRICLoZR
         +WcUysteLWWPWxshpXd0fTpMRLUgn2pikWxycci1yv+hht3zQVYCCRlc7jJrKCBuhwql
         yfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=w7ERDMxld9y+CPUnX75l8Ta0sFWie18coBUraZlyenY=;
        b=GusIpNsDtI3vt+mj+RTcfh2SdGD55doCEnhj1xnqb7zWzbdO21o9fygqJUcL5z1boh
         b1QaqhIMIB9+h62P/8ukbvoELJUMXZu8lVwN8F3GSba6/JkjSgW2EVplBIsVr+UU/eom
         0fz4u0uAGZoJ/purZP8leZSg6SQMJ5ynxHbIO+aArxYbi2Pfwp8JeQpI0An5szO/AJpD
         004+sx+lwMhd6qksrosABg4ScMdBvqlcc8+ntcgrYZ9uPmK2nSZ07sprg/Tm5lcDLdtU
         4nCi1LrAiLsjEflCAjzk/uw0M2VyVZGBeJdRSlAWk3DwKEzjBNYIUwxUst0p+r4o0zId
         lfJA==
X-Gm-Message-State: AOAM530s3VDTmEv7q+dqVUWFFj+vNI1JzIKVGRfYEoZFdxFcYNCOAbtz
        Ux3Y7RjIfpjgVaGr1KEL5B4hwuyLGHtfQOzi
X-Google-Smtp-Source: ABdhPJzNeOWy0F/lHFywLb8P0P+Btkiv6onzYuaN22VjLXYuj/K536/O12T/6Kdme13KBlIKknwohA==
X-Received: by 2002:adf:e992:: with SMTP id h18mr13746461wrm.21.1635510306627;
        Fri, 29 Oct 2021 05:25:06 -0700 (PDT)
Received: from smtpclient.apple (global-5-141.nat-2.net.cam.ac.uk. [131.111.5.141])
        by smtp.gmail.com with ESMTPSA id q18sm8807724wmc.7.2021.10.29.05.25.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Oct 2021 05:25:05 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [v4 10/11] riscv: dts: fu740: Add pmu node
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <CAOnJCUJjzmW=QobLPKAWYGppFeoJXjT2Ee6eG2-H=s2mnei=RQ@mail.gmail.com>
Date:   Fri, 29 Oct 2021 13:25:04 +0100
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
Message-Id: <FE94A3CF-44B9-442A-B985-4ED86BF039EE@jrtc27.com>
References: <20211025195350.242914-1-atish.patra@wdc.com>
 <20211025195350.242914-11-atish.patra@wdc.com>
 <YXsMtrmuavGAHk8S@Jessicas-MacBook-Pro.local>
 <CAOnJCULqwZvK52nczp2HNinDCBjThnbGbvJpAvdameny1fK4Vw@mail.gmail.com>
 <EDB030D6-D37A-43D6-9027-222794FDA80D@jrtc27.com>
 <CAOnJCUJjzmW=QobLPKAWYGppFeoJXjT2Ee6eG2-H=s2mnei=RQ@mail.gmail.com>
To:     Atish Patra <atishp@atishpatra.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 29 Oct 2021, at 07:05, Atish Patra <atishp@atishpatra.org> wrote:
>=20
> On Thu, Oct 28, 2021 at 5:07 PM Jessica Clarke <jrtc27@jrtc27.com> =
wrote:
>>=20
>> On 29 Oct 2021, at 00:37, Atish Patra <atishp@atishpatra.org> wrote:
>>>=20
>>> On Thu, Oct 28, 2021 at 1:49 PM Jessica Clarke <jrtc27@jrtc27.com> =
wrote:
>>>>=20
>>>> On Mon, Oct 25, 2021 at 12:53:49PM -0700, Atish Patra wrote:
>>>>> HiFive unmatched supports HPMCounters but does not implement =
mcountinhibit
>>>>> or sscof extension. Thus, perf monitoring can be used on the =
unmatched
>>>>> board without sampling.
>>>>>=20
>>>>> Add the PMU node with compatible string so that Linux perf driver =
can
>>>>> utilize this to enable PMU.
>>>>>=20
>>>>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>>>>> ---
>>>>> arch/riscv/boot/dts/sifive/fu740-c000.dtsi | 3 +++
>>>>> 1 file changed, 3 insertions(+)
>>>>>=20
>>>>> diff --git a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi =
b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
>>>>> index abbb960f90a0..b35b96b58820 100644
>>>>> --- a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
>>>>> +++ b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
>>>>> @@ -140,6 +140,9 @@ soc {
>>>>>             #size-cells =3D <2>;
>>>>>             compatible =3D "simple-bus";
>>>>>             ranges;
>>>>> +             pmu {
>>>>> +                     compatible =3D "riscv,pmu";
>>>>> +             };
>>>>=20
>>>> This is a property of the user-replaceable firmware, not a property =
of
>>>> the hardware,
>>>=20
>>> It's a property of hardware that indicates that the hardware =
supports PMU.
>>=20
>> All RISC-V hardware provides the CSRs, they=E2=80=99re part of the =
privileged
>> spec and not marked optional. How many aren=E2=80=99t hard-wired to =
zero is up
>> to the implementation. But even then you can=E2=80=99t know from the =
hardware
>> alone what is supported; the firmware has to enable S-mode (and
>> U-mode)=E2=80=99s ability to read them, so you can=E2=80=99t assume =
anything in a
>> static device tree hard-coded in Linux about what firmware has done.
>> Since you currently have to query the firmware to determine what=E2=80=99=
s
>> available to you anyway, I see no benefit from having a node in the
>> device tree that tells you your firmware *might* have counters you =
can
>> use.
>>=20
>>> Additionally, the counter overflow interrupt number needs to be
>>> defined through the DT as well
>>> so that a clean platform driver can be implemented.
>>=20
>> The interrupt number is specified as 13 by the Sscofmpf spec.
>> But that=E2=80=99s not relevant here, the FU740 predates and =
doesn=E2=80=99t implement
>> Sscofmpf, meaning there is no interrupt to even define here. And as I
>> said on the other patch, don=E2=80=99t conflate =E2=80=9CSBI PMU =
firmware interface is
>> supported=E2=80=9D and =E2=80=9CSscofmpf is implemented in the =
hardware=E2=80=9D; the former
>> should be discovered by talking to firmware, and the latter should be
>> discovered like any other extension (however that ends up happening).
>=20
> Presence of sscof extension can be discovered through general =
extension
> discovery mechanism (probably a separate DT node..that's a separate =
discussion).
>=20
> However, the interrupt number discovery has to be through DT so the
> platform driver
> can probe the DT to figure out that.

No, you=E2=80=99re not reading what I said. It=E2=80=99s specified to be =
13 in the
Sscofmpf spec, there is zero need to encode information in the device
tree that is already mandated by a specification. We don=E2=80=99t put =
that
supervisor software interrupts are 1 nor that supervisor timer
interrupts are 5 in the device tree, so we also don=E2=80=99t need to =
put that
supervisor counter overflow interrupts are 13 in it. We *do* currently
put machine timer interrupt information from the CLINT in the device
tree, and both supervisor and machine external interrupt information
from the PLIC, but that is not to tell you what=E2=80=99s already =
specified
(that they=E2=80=99re interrupts 7, 11 and 9 respectively), it=E2=80=99s =
to tell you
which order the per-hart registers are in in the CLINT, and which order
the contexts are in in the PLIC. If it were up to me that would=E2=80=99ve=
 been
expressed a different way as it=E2=80=99s an ugly encoding, rather =
redundant
and not the nicest to decode in software, but it=E2=80=99s too late for =
that.
Though with the ACLINT, APLIC and other AIA parts on the horizon I hope
we can get saner bindings for those that don=E2=80=99t repeat those =
mistakes.
But the point is, if it=E2=80=99s specified by the spec, it doesn=E2=80=99=
t need to go
in the device tree, the device tree is for telling you all the things
you don=E2=80=99t, and can=E2=80=99t, already know.

>>>> so having this in the device tree under /soc, let alone
>>>> hard-coded in Linux, is utterly wrong. Why can this not just be =
probed
>>>> like any other SBI interface? The "Probe SBI extension" interface =
is
>>>> precisely for this kind of thing.
>>>>=20
>>> SBI extension is anyways probed to verify if the firmware has PMU
>>> extension or not.
>>> However, adding the DT property allows different platforms (with or
>>> without sscof extension)
>>> to use the same code path.
>>=20
>> You don=E2=80=99t need a device tree for that; that same code path =
can just be
>> =E2=80=9Cuse the existing standard firmware interface=E2=80=9D. That =
also has the
>> benefit that it=E2=80=99s not tied to device tree and so works =
identically for
>> ACPI, rather than needing an ACPI version of it.
>>=20
>=20
> I don't disagree with that argument. However, we need a DT node for
> interrupt number as explained in the above.
> A DT based platform driver allows us to provide a unified code path
> which can handle both kinds of platforms described below.
>=20
> 1. Platforms without sscof extension
> 2. Platforms with sscof extension that requires a DT node for =
interrupt number
>=20
> Otherwise, the driver has to do the following things in order.
>=20
> 1. Probe PMU extension
> 2. first check if sscof extension is present in the special RISC-V ISA
> extension DT node (which is yet to finalize)
> 3. If sscof extension is present then register for a DT based platform =
driver.
> 4. Otherwise, register a simple platform driver.
>=20
> I am not completely opposed to doing that if there is a strong
> technical issue with the current approach.

Nope, it=E2=80=99s:

1. Probe PMU SBI extension
2. Register a driver
3. If Sscofmpf is present, register for interrupt 13

Or perhaps with 2 and 3 swapped.

You=E2=80=99re making this far too complicated by being fixated on =
needing
device tree in there somewhere. You don=E2=80=99t need it at all except
possibly to tell you that Sscofmpf is supported, which should be done
the same as any other supervisor extension like Svnapot or Svpbmt.

Jess

>> I see nothing here that can=E2=80=99t be discovered through =
pre-existing means.
>> If it can be discovered without use of the device tree then it does =
not
>> belong in the device tree; the device tree is purely for things that
>> cannot otherwise be discovered.
>>=20
>> Jess
>>=20
>=20
>=20
> --=20
> Regards,
> Atish

