Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B68C38145
	for <linux-perf-users@archiver.kernel.org>; Thu,  8 Sep 2022 07:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiIHH7a (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 8 Sep 2022 03:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiIHH72 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 8 Sep 2022 03:59:28 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE427C7BAD
        for <linux-perf-users@vger.kernel.org>; Thu,  8 Sep 2022 00:59:19 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-3454b0b1b6dso98889047b3.4
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Sep 2022 00:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=AED3bGnj1lFXZEETrGBbS5jh6P5l9CcrTpBF9lOrNE0=;
        b=HkUFRA8CPFJAvpaFZE0A48bh8ebNvRB0c9TxZNw2wdVrMoeLJdR4QnLUPPcniJEcKY
         VNaFMEeLnmR7AJ9Lbgz25CYZ94/GBFshTL5meP9gXvTjKp6JSXBNwu1vmE3RdSN+oxET
         0pKAeWTyTxvf9nXIJYIVEG7+0eeGUB3FAh/IYdLo1NfWohokuzLXDvbWU6mF9v+UKcUd
         pVlXqPU7xT9Zm+riPxfay1Dr8EHuoKrj2TOgjNijoKvfzP+kMXfiQje1gC3rVWy4ZtDs
         YAA/J1b5zmDei7hTit3O4zQ+eNvcbntqnMQB2lnuY+1qegnjgPbTWdVMZTw1i1yH2GDj
         +RRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=AED3bGnj1lFXZEETrGBbS5jh6P5l9CcrTpBF9lOrNE0=;
        b=5CkJ3rgNRCXZd/0mooNoV+FtLkvIY6zT6h5awI2wtznyHJ5zCRNWOtmSepHIZRCYBA
         L7UMGErJvaqQhWfiyLGdXPFrbWjjmFAgTw4Ko9HU1ViujHNAXK2jmRtPqmgNPcINzss2
         bmEUEji8VfdX7KrVg3o7S9p108vBoUzdNftNPGKKEbxhkjLKeKwd3qn245EqclEiVpgG
         xGwUdsMA+X2HF3MPaVehNcMg6Z7PpHvaRJeYnvcUcXTvR291dZa7aNcKwM0AUZ8tsZfc
         ucoBF/G2HBdca7XkWDX5qqIxJv7RlvZjkGGRFKHzumzGD+Nqgl4ZHa5jvJbOdrSKefGZ
         dMOw==
X-Gm-Message-State: ACgBeo1HqOiPKCS8Bvsr7CDVvDhSpPrzYEkGj0NmCk2dD47kUZQYGe8F
        KyCNsRqP6/Cj8z9H0/ZrRjJI7OUFY+GGFgSe6iPMvg==
X-Google-Smtp-Source: AA6agR4X0jTEHkYV5U40zvcN89k17FaKDFHNabGZ3PT+KFUU19cT6H4djk8nh2JaC2JxqJ8Gtff8FgF8cCPzupgqq20=
X-Received: by 2002:a81:a16:0:b0:345:afa:5961 with SMTP id 22-20020a810a16000000b003450afa5961mr6297647ywk.11.1662623958715;
 Thu, 08 Sep 2022 00:59:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220902100057.404817-1-elver@google.com> <YxiQ87X1eUB2rrtF@hirez.programming.kicks-ass.net>
In-Reply-To: <YxiQ87X1eUB2rrtF@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Thu, 8 Sep 2022 09:58:42 +0200
Message-ID: <CANpmjNPwtmRbj3zRTWS9hL0wawuSQV_2SL0fvnb5e0J43MaNag@mail.gmail.com>
Subject: Re: [PATCH] perf: Allow restricted kernel breakpoints on user addresses
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, 7 Sept 2022 at 14:39, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Sep 02, 2022 at 12:00:57PM +0200, Marco Elver wrote:
>
> > +/*
> > + * Check if unprivileged users are allowed to set up breakpoints on user
> > + * addresses that also count when the kernel accesses them.
> > + */
> > +static bool perf_allow_kernel_breakpoint(struct perf_event_attr *attr)
> > +{
> > +     if (attr->type != PERF_TYPE_BREAKPOINT)
> > +             return false;
> > +
> > +     /*
> > +      * The sample may contain IPs, registers, or other information that may
> > +      * disclose kernel addresses or timing information. Disallow any kind of
> > +      * additional sample information.
> > +      */
> > +     if (attr->sample_type)
> > +             return false;
>
> This feels a bit weird; should that perhaps be is_sampling_event()?

is_sampling_event() just checks for sample_period. In fact, we still
want to set sample_period to get overflow events. That in itself is
not dangerous.

What's problematic is if the samples contain additional information,
which can be specified in sample_type. For example if PERF_SAMPLE_IP
is set, it might leak kernel IPs, and that's bad. Since it's safest to
disallow any kind of extra information, we just check if sample_type
is zero.

> > +
> > +     /*
> > +      * Only allow kernel breakpoints on user addresses.
> > +      */
> > +     return access_ok((void __user *)(unsigned long)attr->bp_addr, attr->bp_len);
> > +}
> > +
> > +int perf_allow_kernel(struct perf_event_attr *attr)
> > +{
> > +     if (sysctl_perf_event_paranoid > 1 && !perfmon_capable() &&
> > +         !perf_allow_kernel_breakpoint(attr))
>
> I'm on the fence about this; one the one hand it feels weird to have a
> breakpoint exception here and not a pmu specific callback for instance;
> OTOH, leaving security policy like that up to pmu drivers sounds like a
> really bad idea too.
>
> Keep it as is I suppose, just me thinking out loud or so.

Ack. I also think this should stay in core, as it's also easier to audit.
