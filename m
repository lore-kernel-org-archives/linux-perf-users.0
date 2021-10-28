Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6A0C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Oct 2021 23:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B085610D2
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Oct 2021 23:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhJ1XkX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 28 Oct 2021 19:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhJ1XkW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 28 Oct 2021 19:40:22 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06BCC061570
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Oct 2021 16:37:54 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id v138so14025781ybb.8
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Oct 2021 16:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cheY9bIPEAikUChpUOLiNCBs86TVcB1sR5Shc6iQ+Bg=;
        b=gUq7HVwr4laLdDA+DkVm3Vp/7rVb2c2ngZ2rzoWvp47loWw7K2pDLqjapDGL3+v5aw
         HprDuKOGdqpVnzO9szaYZiRVrP5maXpDrjj/j/I1Ntk17M6LFV5aplDuKHOrnSZ7lNkk
         RmXsndUujojn9L33QYe76+RTpfqhr6xgiBevI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cheY9bIPEAikUChpUOLiNCBs86TVcB1sR5Shc6iQ+Bg=;
        b=l0AO7uL656kBw+hYVsCJ7AiBn7zj0Icvc/MZ+1s5ra6vcgSRndk/p3s9RdCrNN9kXv
         D+U/wdyixv0X3HSY/t3c6wtDc39TLV4RHupraF/mTNenLXk61qm5Nj4QpW6vq4Z2hn2X
         HIITtFzvl6x7ozReulr/PUNYoloeWm9mYJxni47K5pUhvGU2RD7OvxZcURKoakzY50Hx
         emauQC7+4Ae6UgX9HVN5ipXebKQ2eGV6PdV9wdZyBWtRUb60qoTPLKl1baD5O0P4Nnwd
         HqnnyUY0MaXrzountr32HIerWTNfE1B5jmRjpzu8v6rqExJXAY0b0D3/W06m070LtxIh
         +ydQ==
X-Gm-Message-State: AOAM533auJBMHiIDnIcbvreHl6vMfIbXWSBbVl82nAvuKfpCuVssrh2p
        XkV+WhnGZNAql7oQ3pK4+ig63yrGFP/DS1vySziQcx4Fv0WWReU=
X-Google-Smtp-Source: ABdhPJzSzknSU4EdecKlfWAUlLx9gBS4Hx80KVuVfnFb4yRPxWyPTPMNfFBpM+J1dEVoFJPcf22J0CA/PkPEBwzIyAU=
X-Received: by 2002:a25:bf8c:: with SMTP id l12mr7950987ybk.87.1635464273081;
 Thu, 28 Oct 2021 16:37:53 -0700 (PDT)
MIME-Version: 1.0
References: <20211025195350.242914-1-atish.patra@wdc.com> <20211025195350.242914-11-atish.patra@wdc.com>
 <YXsMtrmuavGAHk8S@Jessicas-MacBook-Pro.local>
In-Reply-To: <YXsMtrmuavGAHk8S@Jessicas-MacBook-Pro.local>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 28 Oct 2021 16:37:42 -0700
Message-ID: <CAOnJCULqwZvK52nczp2HNinDCBjThnbGbvJpAvdameny1fK4Vw@mail.gmail.com>
Subject: Re: [v4 10/11] riscv: dts: fu740: Add pmu node
To:     Jessica Clarke <jrtc27@jrtc27.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Oct 28, 2021 at 1:49 PM Jessica Clarke <jrtc27@jrtc27.com> wrote:
>
> On Mon, Oct 25, 2021 at 12:53:49PM -0700, Atish Patra wrote:
> > HiFive unmatched supports HPMCounters but does not implement mcountinhibit
> > or sscof extension. Thus, perf monitoring can be used on the unmatched
> > board without sampling.
> >
> > Add the PMU node with compatible string so that Linux perf driver can
> > utilize this to enable PMU.
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > ---
> >  arch/riscv/boot/dts/sifive/fu740-c000.dtsi | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
> > index abbb960f90a0..b35b96b58820 100644
> > --- a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
> > +++ b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
> > @@ -140,6 +140,9 @@ soc {
> >               #size-cells = <2>;
> >               compatible = "simple-bus";
> >               ranges;
> > +             pmu {
> > +                     compatible = "riscv,pmu";
> > +             };
>
> This is a property of the user-replaceable firmware, not a property of
> the hardware,

It's a property of hardware that indicates that the hardware supports PMU.
Additionally, the counter overflow interrupt number needs to be
defined through the DT as well
so that a clean platform driver can be implemented.


so having this in the device tree under /soc, let alone
> hard-coded in Linux, is utterly wrong. Why can this not just be probed
> like any other SBI interface? The "Probe SBI extension" interface is
> precisely for this kind of thing.
>
SBI extension is anyways probed to verify if the firmware has PMU
extension or not.
However, adding the DT property allows different platforms (with or
without sscof extension)
to use the same code path.

> Jess
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
