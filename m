Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082FAC4320A
	for <linux-perf-users@archiver.kernel.org>; Fri, 27 Aug 2021 21:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA83960EBD
	for <linux-perf-users@archiver.kernel.org>; Fri, 27 Aug 2021 21:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbhH0VL5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 27 Aug 2021 17:11:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231570AbhH0VL4 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 27 Aug 2021 17:11:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3821B60E78;
        Fri, 27 Aug 2021 21:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630098667;
        bh=0J24TIWf8un+7BNgVI6ycuS4d2s9YAG3kZ6HY1i/HO0=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=Um3Zag09FUrqeeBy8h8bw/Dq9pfj83Oac5gjtk2iNXPqrbZRBiHAzbJb6Ne+f9mKF
         dxwifgj7U1VMFioh1/McZPcjNt/H08BTn5z0UGYzJv70mhfjeQ2qvNQoup2k6dBmmb
         nEvxJCfcWDQwMYszsMOyv3EwycPOruIhvFILTselPDsguTo956zceTgD5/ac8VzrBv
         hM75CBvFavx+J1j/gcIwvaFNYmWoKJ1ZzdPCdCa2CUG19Q5MyAVQA4Fuy+EwcsOqUS
         b9qwAChEu3uLyyUYCgMfP0w0xISCnwPx6KnxRfrgFcPhI+/XMlp/WSw8fkhBIVieNK
         3RXhLEbuenPSA==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 5560927C0054;
        Fri, 27 Aug 2021 17:11:05 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute6.internal (MEProxy); Fri, 27 Aug 2021 17:11:05 -0400
X-ME-Sender: <xms:51QpYSOvkzC3y8P2Oa9yoZBPh34Vg5W_CdmhzjqOedvLTMePf8evyQ>
    <xme:51QpYQ8gdXSppk5nkco8dlBhM-Lh8DktuirAOSY3J2aj0WsdmdJRgsqRZ31Cq8j9r
    DE2PPBfbF3McxtuFME>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddufedgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeefheekleetudffieethedtkeegfeevjefgvedugeevgefhtdek
    jeevhfdutedugfenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdroh
    hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegr
    nhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedukeehieefvd
    dqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinhhugidrlhhu
    thhordhush
X-ME-Proxy: <xmx:51QpYZR44FeWE4zFCjnX2BuNYRwwk6WYni5WIDNLgPMe7fJiQDeKwQ>
    <xmx:51QpYSu7O9wIsvP6qkcxwxNgNXXUYHKjJqraqGnnrKH3eJ2kYlreqQ>
    <xmx:51QpYacXf4F-fD_eZ6rg7CcWXFqJXWaVrdhIoG5SKxmE84sVPsbLIQ>
    <xmx:6VQpYV3LBRZ9QVC2-ieZi_Y7JTuc_OtcKILAVABxXW5ee_cCBIp7IXjIubc>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2F5CAA0378F; Fri, 27 Aug 2021 17:11:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1125-g685cec594c-fm-20210825.001-g685cec59
Mime-Version: 1.0
Message-Id: <43b3a838-da8a-4733-9832-f3d5f990ec13@www.fastmail.com>
In-Reply-To: <CAL_JsqKpT93W6nBj68DykEJzjFYOPG=8PGShsh2QZVzHq5N3fQ@mail.gmail.com>
References: <20210728230230.1911468-1-robh@kernel.org>
 <20210728230230.1911468-3-robh@kernel.org>
 <d720903c-926e-f57a-0862-4e5d76db763a@kernel.org>
 <CAL_JsqLRv9ugKJcn4dq_ps0JMt74Y7PKA=5yySYxvftdQWzzPA@mail.gmail.com>
 <de97454b-9b4d-492f-a435-6a5e33889219@www.fastmail.com>
 <CAL_JsqKpT93W6nBj68DykEJzjFYOPG=8PGShsh2QZVzHq5N3fQ@mail.gmail.com>
Date:   Fri, 27 Aug 2021 14:10:42 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Rob Herring" <robh@kernel.org>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Kan Liang" <kan.liang@linux.intel.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        "Jiri Olsa" <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Borislav Petkov" <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [RFC 2/3] perf/x86: Control RDPMC access from .enable() hook
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On Thu, Aug 26, 2021, at 12:09 PM, Rob Herring wrote:
> On Thu, Aug 26, 2021 at 1:13 PM Andy Lutomirski <luto@kernel.org> wrot=
e:
> >
> >
> >
> > On Thu, Aug 12, 2021, at 11:16 AM, Rob Herring wrote:
> > > On Thu, Aug 12, 2021 at 11:50 AM Andy Lutomirski <luto@kernel.org>=
 wrote:
> > > >
> > > > On 7/28/21 4:02 PM, Rob Herring wrote:
> > > > > Rather than controlling RDPMC access behind the scenes from sw=
itch_mm(),
> > > > > move RDPMC access controls to the PMU .enable() hook. The .ena=
ble() hook
> > > > > is called whenever the perf CPU or task context changes which =
is when
> > > > > the RDPMC access may need to change.
> > > > >
> > > > > This is the first step in moving the RDPMC state tracking out =
of the mm
> > > > > context to the perf context.
> > > >
> > > > Is this series supposed to be a user-visible change or not?  I'm=
 confused.
> > >
> > > It should not be user-visible. Or at least not user-visible for wh=
at
> > > any user would notice. If an event is not part of the perf context=
 on
> > > another thread sharing the mm, does that thread need rdpmc access?=
 No
> > > access would be a user-visible change, but I struggle with how tha=
t's
> > > a useful scenario?
> > >
> >
> > This is what I mean by user-visible -- it changes semantics in a way=
 that a user program could detect.  I'm not saying it's a problem, but I=
 do think you need to document the new semantics.
>=20
> After testing some scenarios and finding perf_event_tests[1], this
> series isn't going to work for x86 unless rdpmc is restricted to task
> events only or allowed to segfault on CPU events when read on the
> wrong CPU rather than just returning garbage. It's been discussed
> before here[2].
>=20
> Ultimately, I'm just trying to define the behavior for arm64 where we
> don't have an existing ABI to maintain and don't have to recreate the
> mistakes of x86 rdpmc ABI. Tying the access to mmap is messy. As we
> explicitly request user access on perf_event_open(), I think it may be
> better to just enable access when the event's context is active and
> ignore mmap(). Maybe you have an opinion there since you added the
> mmap() part?

That makes sense to me. The mmap() part was always a giant kludge.

There is fundamentally a race, at least if rseq isn=E2=80=99t used: if y=
ou check that you=E2=80=99re on the right CPU, do RDPMC, and throw out t=
he result if you were on the wrong CPU (determined by looking at the mma=
p), you still would very much prefer not to fault.

Maybe rseq or a vDSO helper is the right solution for ARM.

>=20
> Rob
>=20
> [1] https://github.com/deater/perf_event_tests
> [2] https://lore.kernel.org/lkml/alpine.DEB.2.21.1901101229010.3358@ma=
cbook-air/
>=20
