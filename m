Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1978EC7EE23
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Jun 2023 21:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjFAVqw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 1 Jun 2023 17:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjFAVqv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 1 Jun 2023 17:46:51 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E322180
        for <linux-perf-users@vger.kernel.org>; Thu,  1 Jun 2023 14:46:49 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-77489b6f68cso15518639f.1
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Jun 2023 14:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685656007; x=1688248007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLtvBlY/v8HYwh0Fbm6omkkXXBfFwuezcGJpiAwvtOM=;
        b=QtnSCxHxagh4VQ3GovimdDSMwUFqPZpIKpoLHSHYNCP9nEGGM0Do53iy3ASp3tFkZ+
         6HUikCVHT+D4et2Zb92mv75et+TGku4fDTKu6vJijABaCquUcHthcN6EmMbxr/dSdxOF
         +wWlwGxavTXq6WKpLSqHOkwjEfiE6ceoDHdzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685656007; x=1688248007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NLtvBlY/v8HYwh0Fbm6omkkXXBfFwuezcGJpiAwvtOM=;
        b=CBWm2NCRqVsCG7LQ0wljWZIZOD/0R3ZAfkTjkVRHbuvKiCbKGw3W1UvAL1jFZ11Efi
         6pdyusZmLdGeoOGcN/B9ZLVz7XZMdsDy0i7XfXgkT+8Q4ezVGzZFaGfFhxkqFs/QR3os
         N8TiR6kdTgE0f3cXb1n9yPaTIm1BA8m81nOf021CEfIszXyH5baxAZ/7p6cuNj2iratm
         lDOrg/+dltLxOGZ6MrBUmns9r4OTjPiQIMsL94DAK8R0q96Cx7xuOhmq8zaipWSI3UKT
         zlUT5lQs2TnMAaE5ymz+CrhuinboAIyAyqrTXB+vkmJuDevC3kDvqPPxn8cfPp6lbWqI
         +6IA==
X-Gm-Message-State: AC+VfDzGkkGVdQQdKZNVJbOf7yAFttLEUnAdYjwWB/lsGHjqwaR/IfSU
        bw/dqi2h3EquRPt5pVKNayBS9vwXLsIbpYbLYX8=
X-Google-Smtp-Source: ACHHUZ5nLpRa6ckvR8SHx1n8GKGXbbrNFdft2YygK9XALCGkS6CCsiRcgROBoQz3XcV1X5EVic4UAw==
X-Received: by 2002:a5d:8d06:0:b0:776:fce3:4769 with SMTP id p6-20020a5d8d06000000b00776fce34769mr467169ioj.20.1685656006714;
        Thu, 01 Jun 2023 14:46:46 -0700 (PDT)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com. [209.85.166.172])
        by smtp.gmail.com with ESMTPSA id w13-20020a022a0d000000b0041669a9fb62sm2380016jaw.131.2023.06.01.14.46.43
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 14:46:44 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-33bf12b5fb5so11305ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Jun 2023 14:46:43 -0700 (PDT)
X-Received: by 2002:a05:6e02:17c7:b0:33b:7a45:a950 with SMTP id
 z7-20020a056e0217c700b0033b7a45a950mr70308ilu.18.1685656003076; Thu, 01 Jun
 2023 14:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230419225604.21204-1-dianders@chromium.org> <CAD=FV=Wny=iFQf2GGuC2qP9hy4FHzpiRpV=ZvxEW77DX02XGzQ@mail.gmail.com>
 <ZFvGqD//pm/lZb+p@FVFF77S0Q05N.cambridge.arm.com> <CAD=FV=WjX-XD6tX3hZq0GOh9e+Pc1jMMYP8DCc=u1YWQ2E5hYw@mail.gmail.com>
In-Reply-To: <CAD=FV=WjX-XD6tX3hZq0GOh9e+Pc1jMMYP8DCc=u1YWQ2E5hYw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 1 Jun 2023 14:46:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vx=64ZYqNvOBRHu-+yFWtxkzCyjAxZED2xEFqoMKvAqQ@mail.gmail.com>
Message-ID: <CAD=FV=Vx=64ZYqNvOBRHu-+yFWtxkzCyjAxZED2xEFqoMKvAqQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/10] arm64: Add framework to turn an IPI as NMI
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>, ito-yuichi@fujitsu.com,
        kgdb-bugreport@lists.sourceforge.net, Chen-Yu Tsai <wens@csie.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-perf-users@vger.kernel.org,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Borislav Petkov <bp@alien8.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jinyang He <hejinyang@loongson.cn>,
        Joey Gouly <joey.gouly@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Qing Zhang <zhangqing@loongson.cn>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        loongarch@lists.linux.dev, sparclinux@vger.kernel.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On Wed, May 10, 2023 at 9:42=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Wed, May 10, 2023 at 9:30=E2=80=AFAM Mark Rutland <mark.rutland@arm.co=
m> wrote:
> >
> > On Wed, May 10, 2023 at 08:28:17AM -0700, Doug Anderson wrote:
> > > Hi,
> >
> > Hi Doug,
> >
> > > On Wed, Apr 19, 2023 at 3:57=E2=80=AFPM Douglas Anderson <dianders@ch=
romium.org> wrote:
> > > > This is an attempt to resurrect Sumit's old patch series [1] that
> > > > allowed us to use the arm64 pseudo-NMI to get backtraces of CPUs an=
d
> > > > also to round up CPUs in kdb/kgdb. The last post from Sumit that I
> > > > could find was v7, so I called this series v8. I haven't copied all=
 of
> > > > his old changelongs here, but you can find them from the link.
> > > >
> > > > Since v7, I have:
> > > > * Addressed the small amount of feedback that was there for v7.
> > > > * Rebased.
> > > > * Added a new patch that prevents us from spamming the logs with id=
le
> > > >   tasks.
> > > > * Added an extra patch to gracefully fall back to regular IPIs if
> > > >   pseudo-NMIs aren't there.
> > > >
> > > > Since there appear to be a few different patches series related to
> > > > being able to use NMIs to get stack traces of crashed systems, let =
me
> > > > try to organize them to the best of my understanding:
> > > >
> > > > a) This series. On its own, a) will (among other things) enable sta=
ck
> > > >    traces of all running processes with the soft lockup detector if
> > > >    you've enabled the sysctl "kernel.softlockup_all_cpu_backtrace".=
 On
> > > >    its own, a) doesn't give a hard lockup detector.
> > > >
> > > > b) A different recently-posted series [2] that adds a hard lockup
> > > >    detector based on perf. On its own, b) gives a stack crawl of th=
e
> > > >    locked up CPU but no stack crawls of other CPUs (even if they're
> > > >    locked too). Together with a) + b) we get everything (full locku=
p
> > > >    detect, full ability to get stack crawls).
> > > >
> > > > c) The old Android "buddy" hard lockup detector [3] that I'm
> > > >    considering trying to upstream. If b) lands then I believe c) wo=
uld
> > > >    be redundant (at least for arm64). c) on its own is really only
> > > >    useful on arm64 for platforms that can print CPU_DBGPCSR somehow
> > > >    (see [4]). a) + c) is roughly as good as a) + b).
> >
> > > It's been 3 weeks and I haven't heard a peep on this series. That
> > > means nobody has any objections and it's all good to land, right?
> > > Right? :-P
> >
> > FWIW, there are still longstanding soundness issues in the arm64 pseudo=
-NMI
> > support (and fixing that requires an overhaul of our DAIF / IRQ flag
> > management, which I've been chipping away at for a number of releases),=
 so I
> > hadn't looked at this in detail yet because the foundations are still s=
omewhat
> > dodgy.
> >
> > I appreciate that this has been around for a while, and it's on my queu=
e to
> > look at.
>
> Ah, thanks for the heads up! We've been thinking about turning this on
> in production in ChromeOS because it will help us track down a whole
> class of field-generated crash reports that are otherwise opaque to
> us. It sounds as if maybe that's not a good idea quite yet? Do you
> have any idea of how much farther along this needs to go?

I'm still very interested in this topic. Do you have anything concrete
that is broken? Your reply gives me the vibe that there have been a
bunch of bugs found recently and, while there are no known issues,
you're worried that there might be something lingering still. Is that
correct, or do you have something concrete that's broken? Is this
anything others could help with? I could make an attempt, or we might
be able to rope some of the others interested in this topic and more
GIC-knowledgeable to help?

I still have a goal for turning this on for production but obviously
don't want to make the device crashier because of it.

Also: if this really has known bugs, should we put a big WARN_ON splat
if anyone tries to turn on pseudo NMIs? Without that, it feels like
it's a bit of a footgun.


> ...of
> course, we've also run into issues with Mediatek devices because they
> don't save/restore GICR registers properly [1]. In theory, we might be
> able to work around that in the kernel.

To followup with this, we've formulated a plan for dealing with
Mediatek Chromebooks. I doubt anyone is truly interested, but if
anyone is the details are in the public Google bug tracker [1]. None
of that should block lading the NMI backtrace series.


> In any case, even if there are bugs that would prevent turning this on
> for production, it still seems like we could still land this series.
> It simply wouldn't do anything until someone turned on pseudo NMIs,
> which wouldn't happen till the kinks are worked out.
>
> ...actually, I guess I should say that if all the patches of the
> current series do land then it actually _would_ still do something,
> even without pseudo-NMI. Assuming the last patch looks OK, it would at
> least start falling back to using regular IPIs to do backtraces. That
> wouldn't get backtraces on hard locked up CPUs but it would be better
> than what we have today where we don't get any backtraces. This would
> get arm64 on par with arm32...

The more I thought about it, the more I liked the idea of going full
hog on the idea in patch #10. I've posted v9 [2] where I've really
embraced the idea of falling back to a regular IPI if NMI isn't
available. Hopefully it looks keen.

[1] https://issuetracker.google.com/281831288
[2] https://lore.kernel.org/r/20230601213440.2488667-1-dianders@chromium.or=
g

-Doug
