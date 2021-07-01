Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3931C11F64
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Jul 2021 07:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD99461492
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Jul 2021 07:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbhGAH7I (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 1 Jul 2021 03:59:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36355 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234967AbhGAH7H (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 1 Jul 2021 03:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625126197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y9jC4b7qIauKiDKeodtcEhNEX/AsDIdv8KzKy1Dzuxw=;
        b=Ry3iiT/by9i5CzxpeV0fw9SISYR+CYDgnk7tyuBDztzyhRK9i/hcyMaTD0FeSIERAJDOWk
        /EgkPW1uUV3aVMLIpL7GiW7JdtOoFmIJQymXUjysFRw+cju7Ec6BZbcTWeWQiL/o7DXre8
        Qs3mR9/VonMsZgJ4z00n/Cp96DpNmz8=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-KBx0roD1NlO3j4574JIfJA-1; Thu, 01 Jul 2021 03:56:36 -0400
X-MC-Unique: KBx0roD1NlO3j4574JIfJA-1
Received: by mail-yb1-f198.google.com with SMTP id e78-20020a25d3510000b029054f20395eddso7602022ybf.13
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Jul 2021 00:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y9jC4b7qIauKiDKeodtcEhNEX/AsDIdv8KzKy1Dzuxw=;
        b=XyW0mGXMTEzHcVm0Y58hzUYIk/YV8nkV+E+p7VEQMDkGI8wamdcU1eyHqcJJmrzNhD
         Yo4gABQKMV4rHZ8D/kK7T6YbTnlWA90DDoPtQrvgf83PTJxRSRCneg+wq1+ozlL+BYUL
         ItAVXHsIhDMpX9Hrt8XByxms2ozLg4Uocm42kuFhb3vfpXcosBkVszc7pIq7ib0KgLPK
         WOoAGu1Y+3H5wea+XzIgNJ7mW5b3Swi6Bg2BAu/Px3ZWs/cdW3nsDuQlwh8UR/FY3Bo0
         JAv03vXjf0DO+QJAHUQt+d+d1dDsSm0MczMdxk2Si6P7zr70PmE8jEoXzb8oid7WPVwW
         hKLQ==
X-Gm-Message-State: AOAM530cG227sWVc4DdL3w0kOzV9Lw1HcS77OW2ELSwgK3dJdWizFD/2
        SRyYQ68jb28PMWF4w0BZxtXsYDTDNdYZsRpkqOjsCxPvHxMhrhdxzbwMfpTHjoB/VJiDyLVK6u6
        sH05UdkBbEOp3af+tE4tVuxc9/Zp/TUA64rz00rEfBO3Kcg==
X-Received: by 2002:a25:25cd:: with SMTP id l196mr30064770ybl.226.1625126195761;
        Thu, 01 Jul 2021 00:56:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhPXcp42Yx4urqJfd9LZAdGfNWJBwrNYSLZiudcUu4WDls6Vx/hfj0G8n4kD5VMmS7msKxmZOvEyI/CJLBvT8=
X-Received: by 2002:a25:25cd:: with SMTP id l196mr30064748ybl.226.1625126195525;
 Thu, 01 Jul 2021 00:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210630093709.3612997-1-elver@google.com> <CAFqZXNtaHyKjcOmh4_5AUfm0mek6Zx0V1TvN8BwHNK9Q7T3D8w@mail.gmail.com>
 <YNxmyRYcs/R/8zry@elver.google.com>
In-Reply-To: <YNxmyRYcs/R/8zry@elver.google.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 1 Jul 2021 09:56:24 +0200
Message-ID: <CAFqZXNsABvdcR4MPYS+o+SEpqtaU1FrUkmP8bv+1czvcv_3ADQ@mail.gmail.com>
Subject: Re: [PATCH] perf: Require CAP_KILL if sigtrap is requested
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, kasan-dev@googlegroups.com,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jun 30, 2021 at 2:43 PM Marco Elver <elver@google.com> wrote:
> On Wed, Jun 30, 2021 at 01:13PM +0200, Ondrej Mosnacek wrote:
> > On Wed, Jun 30, 2021 at 11:38 AM Marco Elver <elver@google.com> wrote:
> [...]
> > > +static inline bool kill_capable(void)
> > > +{
> > > +       return capable(CAP_KILL) || capable(CAP_SYS_ADMIN);
> >
> > Is it really necessary to fall back to CAP_SYS_ADMIN here? CAP_PERFMON
> > and CAP_BPF have been split off from CAP_SYS_ADMIN recently, so they
> > have it for backwards compatibility. You are adding a new restriction
> > for a very specific action, so I don't think the fallback is needed.
>
> That means someone having CAP_SYS_ADMIN, but not CAP_KILL, can't perform
> the desired action. Is this what you'd like?

AFAIK, such user wouldn't be allowed to directly send a signal to a
different process either. So I think it makes more sense to be
consistent with the existing/main CAP_KILL usage rather than with the
CAP_PERFMON usage (which has its own reason to have that fallback).

I'm not the authority on capabilities nor the perf subsystem, it just
didn't seem quite right to me so I wanted to raise the concern.
Hopefully someone wiser than me will speak up if I talk nonsense :)

> If so, I'll just remove the wrapper, and call capable(CAP_KILL)
> directly.
>
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index fe88d6eea3c2..1ab4bc867531 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -12152,10 +12152,21 @@ SYSCALL_DEFINE5(perf_event_open,
> > >         }
> > >
> > >         if (task) {
> > > +               bool is_capable;
> > > +
> > >                 err = down_read_interruptible(&task->signal->exec_update_lock);
> > >                 if (err)
> > >                         goto err_file;
> > >
> > > +               is_capable = perfmon_capable();
> > > +               if (attr.sigtrap) {
> > > +                       /*
> > > +                        * perf_event_attr::sigtrap sends signals to the other
> > > +                        * task. Require the current task to have CAP_KILL.
> > > +                        */
> > > +                       is_capable &= kill_capable();
> >
> > Is it necessary to do all this dance just to call perfmon_capable()
> > first? Couldn't this be simply:
> >
> > err = -EPERM;
> > if (attr.sigtrap && !capable(CAP_KILL))
> >         goto err_cred;
>
> Not so much about perfmon_capable() but about the ptrace_may_access()
> check. The condition here is supposed to be:
>
>         want CAP_PERFMON and (CAP_KILL if sigtrap)
>                 OR
>         want ptrace access (which includes a check for same thread-group and uid)
>
> If we did what you propose, then the ptrace check is effectively ignored
> if attr.sigtrap, and that's not what we want.
>
> There are lots of other ways of writing the same thing, but it should
> also remain readable and sticking it all into the same condition is not
> readable.

Ah, I see, I missed that semantic difference... So ptrace_may_access()
implies that the process doesn't need CAP_KILL to send a signal to the
task, that makes sense.

In that case I'm fine with this part as it is.

> > Also, looking at kill_ok_by_cred() in kernel/signal.c, would it
> > perhaps be more appropriate to do
> > ns_capable(__task_cred(task)->user_ns, CAP_KILL) instead? (There might
> > also need to be some careful locking around getting the target task's
> > creds - I'm not sure...)
>
> That might make sense. AFAIK, the locking is already in place via
> exec_update_lock. Let me investigate.
>
> > > +               }
> > > +
> > >                 /*
> > >                  * Preserve ptrace permission check for backwards compatibility.
> > >                  *
> > > @@ -12165,7 +12176,7 @@ SYSCALL_DEFINE5(perf_event_open,
> > >                  * perf_event_exit_task() that could imply).
> > >                  */
> > >                 err = -EACCES;
> >
> > BTW, shouldn't this (and several other such cases in this file...)
> > actually be EPERM, as is the norm for capability checks?
>
> I'm not a perf maintainer, so I can't give you a definitive answer.
> But, this would change the ABI, so I don't think it's realistic to
> request this change at this point unfortunately.

Indeed... I worry it will make troubleshooting SELinux/capability
errors more confusing, but I agree it would be a potentially risky
change to fix it :/

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

