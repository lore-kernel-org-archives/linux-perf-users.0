Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C726DC432BE
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 Aug 2021 18:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC70E60FC0
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 Aug 2021 18:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243265AbhHZSOZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 26 Aug 2021 14:14:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232729AbhHZSOY (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 26 Aug 2021 14:14:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2BEDD60F6F;
        Thu, 26 Aug 2021 18:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630001617;
        bh=GvW56A0ZymucrY95tyZXDlzIi82R/2MAGmWEC9QRdAo=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=W0Hd9XkSSc6vmGqZ8tWTeocudyEtjLr/ApmiemqwEmFooZXvQKPP1wTkrkheEld12
         obpEGAO75IC7VGvhNz0Z2O1wKcpuk2jH6Owkvmse2DrDTc8ajHYLAPy2C7BEp4Xa0P
         7o+ket8yNl5w0bLFuCP4RrkIlsFi6YZQb2feFg1eodG93JzTZmDOTnjxzQtiBI8f5r
         i1v2dZIkTR5sukjPsReS6FALTthMn9Wb3Yvi0xKN3KDj1nMvrFYuwFRcGSFBvTnw4S
         DE3/F6Q6HFVzRqqaadVg83tOBVUmQafavZb7u9mh8XKygi/p5Yvl8fw4Da2FMFQtgH
         cVXxsWrZNKeAA==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 49DC127C0054;
        Thu, 26 Aug 2021 14:13:35 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute6.internal (MEProxy); Thu, 26 Aug 2021 14:13:35 -0400
X-ME-Sender: <xms:zdknYVNbLZlfAP2WyB9UTKjQHO1gFvJFvYafSjswJrzIHOq-cDbfrw>
    <xme:zdknYX-Q1mqdXL2EkVoiqMSrr0VNpicJnZuoZy2m34jw-an4LlqvbtJFkV28IgmKc
    UjL93rr7oNJxblLqX4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudduuddguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnheptdfhheettddvtedvtedugfeuuefhtddugedvleevleefvdetleff
    gfefvdekgeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:zdknYUT4oZFrL7HdTHpTDlhJF_cgDdmi-BqZLdxv_n0p0zoHhIkKDQ>
    <xmx:zdknYRs5l6JDgd-s5vg27MXp5O2XtdVGHQZR_Jdps6AeXKilbiM9FA>
    <xmx:zdknYddW2WL-BA1ZXN8cNU4NSKxxav3EX_ZAxYoZrXdj-inD_R04Wg>
    <xmx:z9knYY25u0JnFFkPEsINotX9N8hOr4i4HmILYE-9lgoZyccj7cXdkq-AIBE>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2A5E7A03DA1; Thu, 26 Aug 2021 14:13:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1125-g685cec594c-fm-20210825.001-g685cec59
Mime-Version: 1.0
Message-Id: <de97454b-9b4d-492f-a435-6a5e33889219@www.fastmail.com>
In-Reply-To: <CAL_JsqLRv9ugKJcn4dq_ps0JMt74Y7PKA=5yySYxvftdQWzzPA@mail.gmail.com>
References: <20210728230230.1911468-1-robh@kernel.org>
 <20210728230230.1911468-3-robh@kernel.org>
 <d720903c-926e-f57a-0862-4e5d76db763a@kernel.org>
 <CAL_JsqLRv9ugKJcn4dq_ps0JMt74Y7PKA=5yySYxvftdQWzzPA@mail.gmail.com>
Date:   Thu, 26 Aug 2021 11:13:10 -0700
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
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On Thu, Aug 12, 2021, at 11:16 AM, Rob Herring wrote:
> On Thu, Aug 12, 2021 at 11:50 AM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On 7/28/21 4:02 PM, Rob Herring wrote:
> > > Rather than controlling RDPMC access behind the scenes from switch_mm(),
> > > move RDPMC access controls to the PMU .enable() hook. The .enable() hook
> > > is called whenever the perf CPU or task context changes which is when
> > > the RDPMC access may need to change.
> > >
> > > This is the first step in moving the RDPMC state tracking out of the mm
> > > context to the perf context.
> >
> > Is this series supposed to be a user-visible change or not?  I'm confused.
> 
> It should not be user-visible. Or at least not user-visible for what
> any user would notice. If an event is not part of the perf context on
> another thread sharing the mm, does that thread need rdpmc access? No
> access would be a user-visible change, but I struggle with how that's
> a useful scenario?
> 

This is what I mean by user-visible -- it changes semantics in a way that a user program could detect.  I'm not saying it's a problem, but I do think you need to document the new semantics.

> > If you intend to have an entire mm have access to RDPMC if an event is
> > mapped, then surely access needs to be context switched for the whole
> > mm.  If you intend to only have the thread to which the event is bound
> > have access, then the only reason I see to use IPIs is to revoke access
> > on munmap from the wrong thread.  But even that latter case could be
> > handled with a more targeted approach, not a broadcast to all of mm_cpumask.
> 
> Right, that's what patch 3 does. When we mmap/munmap an event, then
> the perf core invokes the callback only on the active contexts in
> which the event resides.
> 
> > Can you clarify what the overall intent is and what this particular
> > patch is trying to do?
> >
> > >
> > >       if (atomic_dec_and_test(&mm->context.perf_rdpmc_allowed))
> > > -             on_each_cpu_mask(mm_cpumask(mm), cr4_update_pce, NULL, 1);
> > > +             on_each_cpu_mask(mm_cpumask(mm), x86_pmu_set_user_access_ipi, NULL, 1);
> >
> > Here you do something for the whole mm.
> 
> It's just a rename of the callback though.
> 
> >
> > > -             on_each_cpu(cr4_update_pce, NULL, 1);
> > > +             on_each_cpu(x86_pmu_set_user_access_ipi, NULL, 1);
> >
> > Here too.
> 
> It's not just the whole mm here as changing sysfs rdpmc permission is
> a global state.

Whoops, missed that.

> 
> > >  void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
> > >                       struct task_struct *tsk)
> > >  {
> > > @@ -581,10 +556,8 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
> > >       this_cpu_write(cpu_tlbstate.loaded_mm, next);
> > >       this_cpu_write(cpu_tlbstate.loaded_mm_asid, new_asid);
> > >
> > > -     if (next != real_prev) {
> > > -             cr4_update_pce_mm(next);
> > > +     if (next != real_prev)
> > >               switch_ldt(real_prev, next);
> > > -     }
> > >  }
> >
> > But if you remove this, then what handles context switching?
> 
> perf. On a context switch, perf is going to context switch the events
> and set the access based on an event in the context being mmapped.
> Though I guess if rdpmc needs to be enabled without any events opened,
> this is not going to work. So maybe I need to keep the
> rdpmc_always_available_key and rdpmc_never_available_key cases here.

You seem to have a weird combination of per-thread and per-mm stuff going on in this patch, though.  Maybe it's all reasonable after patch 3 is applied, but this patch is very hard to review in its current state.
