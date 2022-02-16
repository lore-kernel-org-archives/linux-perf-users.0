Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42C8C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 16 Feb 2022 22:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbiBPWIS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 16 Feb 2022 17:08:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiBPWIR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 16 Feb 2022 17:08:17 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9BE1FFC8A
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Feb 2022 14:08:03 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id p19so9094058ybc.6
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Feb 2022 14:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=isOeCA/lltI/NtMrPVVj1ziTbz6DfftTb3dxLCJueHE=;
        b=QFTt19Njzzlzy63R6XOWaK+BOF0FOWChqmc/M9e78fPs+omtOYOPssJtA1M1UeMQep
         fM834StWNdigyWFGhvr0R2wQNODg9ecyoiUDm8MUJEonBw5zQLeq7xpWhpCZJdTQ8A9l
         VoJoVbkTk1m7114F/QncmxAnD6e3rNlyXAl/IH59X71wOmKhYj1OfY/j1f8feFgS4rHc
         M5mwG4eFrBr2bsz+BymtZg9vzGToVbefxS9UvQ3A2hn60/xDPSgI5f6fzEKvmABSEe4N
         /hKHGR5ap0mie91vUbyVDpvUtLtFxXMP1mJX7lkNdcbVtRKPlTcOJMz0Os4boLNISOmL
         nKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=isOeCA/lltI/NtMrPVVj1ziTbz6DfftTb3dxLCJueHE=;
        b=VZXvtd15pMoJqucPXwZQ+nWiCWn/R411fumkyZSOxYdvb8eqGjD6YaiZTJwJXZtNX4
         KyDg0L9FhRPmyxmKefiBO/p7o1UTzet9QBTYR2AyMwcCF72/omKH4bevB0iUpH6HB76Q
         FlSH4S+sp1t/Qge4zT9D7S/j8ss0dexbcXRE7QrIFydXCrPFEMfSORdqoAE8THSlNusa
         KF5WrzT8fKfs4oAZ7gG4ugTkxhua2rRb320JmVQaBrOC7Vf9gTIh02ZIAWaY8/0WZwgj
         joLz0o8UA5xacCiZYuFj4+NW1nFSHgu+/3lCwjf3wXDgoYctQsp9YYDREUv7BMJIWqVl
         Hj/w==
X-Gm-Message-State: AOAM531TBpPJQVzxRczvoqri/4pDn55jaQvu5Xu8hX5nT5dN/J5KGKRJ
        KgKLb5kL7ZAAgFjvs3fMYk4uvTMK18T2ret5KHxhJw==
X-Google-Smtp-Source: ABdhPJyYdk7xvOTu1IxnQ2DqJolSl8njTLOssKQ66A00X+WQV5jwJYz8Z70jBI4ZXbtdLyB7B0F/ENZZ1C8sD+Kcl04=
X-Received: by 2002:a25:c794:0:b0:61d:7913:cefb with SMTP id
 w142-20020a25c794000000b0061d7913cefbmr3911838ybe.375.1645049282776; Wed, 16
 Feb 2022 14:08:02 -0800 (PST)
MIME-Version: 1.0
References: <20220211103415.2737789-1-irogers@google.com> <20220211103415.2737789-13-irogers@google.com>
 <Yg0FXbzNVpsIpS45@kernel.org> <CAP-5=fWkF+J30ixh1iDVGhBBASTgLY9nWbd9ibguRYeyLvpsew@mail.gmail.com>
 <Yg1ar4/RCCWwQmJ0@kernel.org>
In-Reply-To: <Yg1ar4/RCCWwQmJ0@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 16 Feb 2022 14:07:49 -0800
Message-ID: <CAP-5=fXOXkxvPHAYz3xv23FTtJ8gtZ5b7AoGevQVK8k=yKRzFw@mail.gmail.com>
Subject: Re: [PATCH v3 12/22] perf maps: Remove rb_node from struct map
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hao Luo <haoluo@google.com>, eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Feb 16, 2022 at 12:12 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Feb 16, 2022 at 09:36:20AM -0800, Ian Rogers escreveu:
> > On Wed, Feb 16, 2022 at 6:08 AM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > Em Fri, Feb 11, 2022 at 02:34:05AM -0800, Ian Rogers escreveu:
> > > > struct map is reference counted, having it also be a node in an
> > > > red-black tree complicates the reference counting.
> > >
> > > In what way?
> > >
> > > If I have some refcounted data structure and I want to add it to some
> > > container (an rb_tree, a list, etc) all I have to do is to grab a
> > > refcount when adding and dropping it after removing it from the list.
> > >
> > > IOW, in other words it is refcounted so that we can add it to a
> > > red-black tree, amongst other uses.
> >
> > Thanks Arnaldo. So I'm not disputing that you can make reference
> > counted collections. With reference counting every reference should
> > have a count associated with it. So when symbol.c is using the list, a
> > node may be referenced from a prev and a next pointer, so being in the
> > list requires a reference count of 2. When you find something in the
>
> Humm, just one reference is needed for being in a list, removing from
> the list needs locking the access to the list, removing the object,
> unlocking the list and then dropping the access for the then out of the
> list refcounted object, no?

Just one reference count is needed but if we were looking to automate
reference counting then we'd associate one reference count with every
pointer to the object. So with the invasive doubly linked list that we
know as list, there are two pointers to a node and so the reference
count should really be two. Using just 1 as the reference count is
really an optimization.

> > list which reference count is that associated with? It doesn't matter
> > normally as you'd increment the reference count again and return that.
> > In the perf code find doesn't increment a reference count so I want to
>
> I'd say point that out and fix the bug, if you will return an object
> from a list that is refcounted, grab the refcount before dropping the
> list lock and then return it, knowing the lookup user will have a
> refcount that will keep that object alive.

I agree, but in doing that you need to make every user do a put and
the problem snow balls.

> > return the "get" that belongs to the list. That's "get" singular,
> > hence wanting to add in the pointer indirection that incurs cost. To
> > make insertion and deletion work properly on list with a reference
> > count means reworking list.h.
> >
> > The rbtree is the same problem only more-so, as you need pointers for
> > parent, left and right child.
> >
> > > > Switch to having a map_rb_node which is a red-block tree node but
> > > > points at the reference counted struct map. This reference is
> > > > responsible for a single reference count.
> > >
> > > This makes every insertion incur in an allocation that has to be
> > > checked, etc, when we know that maps will live in rb_trees, so having
> > > the node structure allocated at the same time as the map is
> > > advantageous.
>
> perf tries to mimic kernel code, but multithreading didn't come at the
> very beginning, so, yeah, there are bugs and inconsistencies, which we
> should fix.
>
> This discussion is how to do it, attempts like Masami's years ago
> uncovered problems that got fixed, your current attempt is also
> uncovering bugs and those are getting fixed, which is super cool.

Thanks. The approach I'm doing is dumb, it is a poor man's smart
pointer by way of memory allocations and sanitizers. My hope from the
beginning was that this is something lightweight enough that we can
get it merged given that sanitizers alone weren't going to save us.

> > So this pattern is common in other languages, the default kernel style
> > is what at Google gets called invasive - you put the storage for list
> > nodes, reference counts, etc. into the referenced object itself. This
> > lowers the overhead within the struct, and I don't disagree it adds a
> > cost to insertion, unless maps are shared which isn't a use-case we
> > have at the moment. So this change is backing out an optimization, but
> > frankly fixing this properly is a much bigger overhaul than this
> > already big overhaul and I don't think losing the optimization is
> > really costing that much performance - a memory allocation costs in
> > the region of 40 cycles with an optimized implementation like
> > tcmalloc. We also don't use the invasive style for maps_by_name, it is
> > just a sorted array.
> >
> > A side note, I see a lot of overhead in symbol allocation and part of
> > that is the size of the two invasive rbtree nodes (2 * 3 * 8 bytes =
> > 48bytes). Were the symbols just referenced by a sorted array, like
> > maps_by_name, insertion and sorting would still be O(n*log(n)) but
> > we'd reduce the memory usage to a third. rbtree is a cool data
> > structure, but I think we could be over using it.
>
> Right, numbers talk, so it would be really nice to use, humm, perf to
> measure these changes, to help assess the impact and sometimes accept
> things at first "ugly" versus performance improvements.

Sure. Do you have a benchmark in mind? For cpumap, nsinfo and maps
there is no overhead when the checking isn't enabled. For map, the
refactoring of the list and rbtree add an indirection and a memory
allocation.

> > > We don't have to check if adding a data structure to a rbtree works, as
> > > all that is needed is already preallocated.
> >
> > The issue here is that a find, or similar, wants to pass around
> > something that is owned by a list or an rbtree. We can have the idea
> > of ownership by adding a token/cookie and passing that around
> > everywhere, it gets problematic then to spot use after put and I think
> > that approach is overall more invasive to the APIs than what is in
> > these changes.
>
> > A better solution can be to keep the rbtree being invasive and at all
> > the find and similar routines, make sure a getted version is returned
> > - so the code outside of maps is never working with the rbtree's
> > reference counted version. The problem with this is that it is an
> > overhaul to all the uses of map. The reference count checker would
> > find misuse but again it'd be a far large patch series than what is
> > here - that is trying to fix the code base as it is.
>
> I've been trailing on the discussion with Masami, so what you want is to
> somehow match a get with a put by passing a token returned by a get to
> the put?

Yes, and that's the approach in ref tracker too:
https://lwn.net/Articles/877603/

> Wrt patch queue size, we can try to reduce it to series of at most 10
> patches, that do leg work, rinse, repeat, I recently saw a discussion on
> netdev, with Jakub Kicinski asking for patchsets to be limited to under
> 10 patches for this exact same reason.
>
> I usually try to cherry pick as much as possible from a series, while it
> being discussed, so that the patch submitter don't have to suffer too
> much with keeping a long series building.
>
> I'm now willing and able to process things faster, that should help too,
> I hope.

It does, thanks! The small patch set size causes me a lot of work as I
have to go and move things into constituent parts. For example:
https://lore.kernel.org/linux-perf-users/YgaeAAKkdVBNbErT@kernel.org/
I guess I should have done it from the outset.

> > I think the having our cake and eating solution (best performance +
> > checking) is that approach, but we need to get to a point where
> > checking is working. So if we focus on (1) checking and fixing those
> > bugs (the changes here), then (2) change the APIs so that everything
> > is getted and fix the leaks that introduces, then (3) go back to being
> > invasive I think we get to that solution. I like step (2) from a
> > cleanliness point-of-view, I'm fine with (3) I'm just not sure anybody
> > would notice the performance difference.
>
> I'll continue looking at what you guys did to try to get up to speed and
> contribute more to this effort, please bear with me a bit more.
>
> - Arnaldo

Np, tbh I didn't have some big agenda with this work. I was thinking
through how I could solve the problem of:
https://lore.kernel.org/linux-perf-users/20211118193714.2293728-1-irogers@google.com/
Dmitry Vyukov suggested Eric Dumazet's ref tracker work but in looking
at ref tracker I was concerned about needing a pair of values for
every reference counted thing. It would add a lot to the API. The ref
tracker work allocates a token/cookie for a get and that's where the
idea of allocating an indirection comes from. It has worked remarkably
well in combination with address and leak sanitizer, fixing the nsinfo
issue which actually turned out to be a data race. There weren't any
known issues with cpumap and maps, but it is good to have the
reference count checking confirming this. map is a rats nest and I
purposefully went after it as the worst case of what we could look to
fix with the approach. I expected it to cause controversy, in
particular the rbtree and list refactors - but heck, I'd throw away 1%
performance for something like perf top not consuming gigabytes of RAM
(not that I have any privilege to throw away performance :-) ).

Anyway, I keep pushing along with the tidy up to the patches as a
background job. I hope I can get v4 out this week.

Another issue nagging at me from the pre-5.16 reverts is:
https://lore.kernel.org/lkml/CAP-5=fX4-kmkm+qn9m22O_4A2_8j=uAm=vcXh9x2RqqDKEdnBg@mail.gmail.com/
This requires a lot of Makefile cleanup. It'd be great if someone
could take a look. There's also Debian builds being in a mess, I guess
it is good to be busy.

Thanks,
Ian
