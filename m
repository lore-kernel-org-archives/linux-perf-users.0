Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFCEC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Jul 2022 15:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239580AbiGTPjp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 20 Jul 2022 11:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbiGTPjo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 20 Jul 2022 11:39:44 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876FE33E27
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Jul 2022 08:39:43 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-31c89653790so177658077b3.13
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Jul 2022 08:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JRcq3vKjIzJm9TVcaSce4sIDa9ZUrBaFgnnM4S7LNls=;
        b=KDo9ERkEPtznpuEHkYtWEOmYc/0qDr8bRu3EUez0IyX5/TKh8u5qZjnFAT2I4QfW9e
         ZMV0w1MMyUxfvRthzXQqkj33GhOJWLpqg7tC5ovWDjXoHPRDKr9EsCtlHlPSOfIpFx3D
         CXME498rdwmBEyTqTDuj2YvpweKS48GnrAqYmWnGH0cec8LzfEml3gIuCufit0mRKQYy
         bhkjqwrGOHKuMDfcfqbKXW1MoRee3DzPTOvyd4fX5Spr0cTN7I+DpvQ8KDEQHuD1KvZf
         okqE4UWVk+RHjtzl+ezoVyGLHMgwAygcaKP5BfZt7hvpynO42mZSfTTK9LYQs8LKGZOO
         R3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JRcq3vKjIzJm9TVcaSce4sIDa9ZUrBaFgnnM4S7LNls=;
        b=1T2MOqKs1EzhHtyzteQvOAXqdY8TS09MszQKBDK66Y68pYEGkEfsL8y17HJ297DZEk
         HzyVGSye7U5QhGsKlM9+t6Ufy+c99vaWEj7HzXZpCRoq392ht5r5EyRQipT5Bhsaa91s
         wPdnRk4MJVdTWW8KIqacJbTnWbRTiKUdemYte7u0iKDeS2Omsdu5tlk2eWIupruVoPQZ
         9x1tobkXlYpjkkwgKPqE8Hz8b6Xm+ZIprm1880wLlqBZNmhSNr1TV3+5GidL9TZNWbyv
         KpynAzHwvuIVa5TMdsW2Y96jUVv82mA6TbjY/ooU4n8zT3NeO1+cj3oCZ5mhP60V2eGj
         iMPA==
X-Gm-Message-State: AJIora+apXMy+ofQpB4LL7eq4m3tIEBNtdyex0t4+Wv/UJGE/9qt71kT
        L3F27kxcOHn3dDKUnhEcXkWeADJ2b5iLtbJM1mok/lZjpgBUjQ==
X-Google-Smtp-Source: AGRyM1vLajKuouK35jbILBRb3Kg0zRLUMXuWQoMOQdNY3/mojOBheS8cAO8ZsFxrXr5sAhOImjaLAsQQKMEv/xrTRkE=
X-Received: by 2002:a81:5794:0:b0:31d:e7b3:b8a3 with SMTP id
 l142-20020a815794000000b0031de7b3b8a3mr32091574ywb.333.1658331582641; Wed, 20
 Jul 2022 08:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220704150514.48816-1-elver@google.com> <20220704150514.48816-5-elver@google.com>
 <CAP-5=fXgi_RUOzSvPZvxNh6A14OY0S_oCHgAD0==nSLXzWqFFQ@mail.gmail.com>
In-Reply-To: <CAP-5=fXgi_RUOzSvPZvxNh6A14OY0S_oCHgAD0==nSLXzWqFFQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 20 Jul 2022 17:39:06 +0200
Message-ID: <CANpmjNOcuacOv7DT4udZwMMuu+7QgaZO7wJ5MReVtC_Vg=ptTQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/14] perf/hw_breakpoint: Optimize list of per-task breakpoints
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, 20 Jul 2022 at 17:29, Ian Rogers <irogers@google.com> wrote:
>
> On Mon, Jul 4, 2022 at 8:06 AM Marco Elver <elver@google.com> wrote:
> >
> > On a machine with 256 CPUs, running the recently added perf breakpoint
> > benchmark results in:
> >
> >  | $> perf bench -r 30 breakpoint thread -b 4 -p 64 -t 64
> >  | # Running 'breakpoint/thread' benchmark:
> >  | # Created/joined 30 threads with 4 breakpoints and 64 parallelism
> >  |      Total time: 236.418 [sec]
> >  |
> >  |   123134.794271 usecs/op
> >  |  7880626.833333 usecs/op/cpu
> >
> > The benchmark tests inherited breakpoint perf events across many
> > threads.
> >
> > Looking at a perf profile, we can see that the majority of the time is
> > spent in various hw_breakpoint.c functions, which execute within the
> > 'nr_bp_mutex' critical sections which then results in contention on that
> > mutex as well:
> >
> >     37.27%  [kernel]       [k] osq_lock
> >     34.92%  [kernel]       [k] mutex_spin_on_owner
> >     12.15%  [kernel]       [k] toggle_bp_slot
> >     11.90%  [kernel]       [k] __reserve_bp_slot
> >
> > The culprit here is task_bp_pinned(), which has a runtime complexity of
> > O(#tasks) due to storing all task breakpoints in the same list and
> > iterating through that list looking for a matching task. Clearly, this
> > does not scale to thousands of tasks.
> >
> > Instead, make use of the "rhashtable" variant "rhltable" which stores
> > multiple items with the same key in a list. This results in average
> > runtime complexity of O(1) for task_bp_pinned().
> >
> > With the optimization, the benchmark shows:
> >
> >  | $> perf bench -r 30 breakpoint thread -b 4 -p 64 -t 64
> >  | # Running 'breakpoint/thread' benchmark:
> >  | # Created/joined 30 threads with 4 breakpoints and 64 parallelism
> >  |      Total time: 0.208 [sec]
> >  |
> >  |      108.422396 usecs/op
> >  |     6939.033333 usecs/op/cpu
> >
> > On this particular setup that's a speedup of ~1135x.
> >
> > While one option would be to make task_struct a breakpoint list node,
> > this would only further bloat task_struct for infrequently used data.
> > Furthermore, after all optimizations in this series, there's no evidence
> > it would result in better performance: later optimizations make the time
> > spent looking up entries in the hash table negligible (we'll reach the
> > theoretical ideal performance i.e. no constraints).
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> > ---
> > v2:
> > * Commit message tweaks.
> > ---
> >  include/linux/perf_event.h    |  3 +-
> >  kernel/events/hw_breakpoint.c | 56 ++++++++++++++++++++++-------------
> >  2 files changed, 37 insertions(+), 22 deletions(-)
> >
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index 01231f1d976c..e27360436dc6 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -36,6 +36,7 @@ struct perf_guest_info_callbacks {
> >  };
> >
> >  #ifdef CONFIG_HAVE_HW_BREAKPOINT
> > +#include <linux/rhashtable-types.h>
> >  #include <asm/hw_breakpoint.h>
> >  #endif
> >
> > @@ -178,7 +179,7 @@ struct hw_perf_event {
> >                          * creation and event initalization.
> >                          */
> >                         struct arch_hw_breakpoint       info;
> > -                       struct list_head                bp_list;
> > +                       struct rhlist_head              bp_list;
>
> nit: perhaps it would be more intention revealing here to rename this
> to bp_hashtable?

The naming convention for uses of rhlist_head appears to be either
'list' or 'node' (also inside lib/rhashtable.c). I think this makes
sense because internally this struct is used to just append to the
bucket's list.

> Acked-by: Ian Rogers <irogers@google.com>

Thanks!
-- Marco
