Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68E0C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 16 Nov 2021 04:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B426561A07
	for <linux-perf-users@archiver.kernel.org>; Tue, 16 Nov 2021 04:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbhKPEMY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 15 Nov 2021 23:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbhKPEMA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 15 Nov 2021 23:12:00 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C248C07E456
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Nov 2021 17:01:55 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id i12so14621106wmq.4
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Nov 2021 17:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3IsMMFTy4UmwEq9GMGKIyKs8DntXlqJM8USlfRw44Yc=;
        b=VhYuIlnwo+hPNpMeUbWeCC9GFZNq1NHrAX9VC0LyvT496pvS7nw9MkQlN+2C1JugkJ
         1SuuGzHn3LEvY6Ukal7A3fzZvqSwpWejj8Afdvm3J5Hxkysi79IT4T3JJudVg9Lc+WEJ
         lc7iY1Q1PVmNo/p5vroJsEOvQK3ED/y1Z8bLapJgNCIUQKBvdjvdjg9Vo+3tV15rbnOF
         HbN7JM+SN7f4c9U9/PNw8xp/M7nHWOtp5a2IE8ZP/zet3KLFzRXhFjAsY3ZNdTORNpe8
         wSFYQXE4tfzo1E42eKxS0kCFAgKCdiQGFtWn0BrLl/TNqo5N1g0Ifb12BEuokb6H4EFq
         IBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3IsMMFTy4UmwEq9GMGKIyKs8DntXlqJM8USlfRw44Yc=;
        b=ltW6hx/9pHKpGlWtW2/AMAI4BvJ6df4/oABAijvxjSzu03AOzJ85Rw8tz4YLauaBTg
         HKh99Q1EggBMy4SELdxzR0yLuHBSlOAwlVl2w5I0U9iKGaESE2qhi7dAt6VEYJ39yEOb
         Yszluw+9npc5FjUErTtsAxXydl6GiMrVGpyZmFJ9X2pb3rfvEqGgpjcxaTXjR3HEI4o5
         JTI/Bg7KbMv3r9G2UzP0LkUvyxDm6LEQ/oJmrLY8OdjbjvEpRfmqNXYuNS/apK4A8tfJ
         sqs4l3X4Qtdc/L/ROu0Z90WOpiy6+nlJKfCrxwg+W0sOuXSA0CVLoPrO/d7SqU8zFolW
         PObA==
X-Gm-Message-State: AOAM531h24Mrnl/jRE0+/pbVICBo5mmVEc7n3hdP3F2o/G8G/hOW2Ipc
        XZnG9Z9CURxQZ13ziID+uRBqW+ooI/fSJQJjFfcGgw==
X-Google-Smtp-Source: ABdhPJzErI4qOUtsPLAlm8cMU8RU69Cu8TaHNKnp878pSu/QDWiysZcmI9VSEeY5j38PC+vPjRyVpxNGRGekxJ11v88=
X-Received: by 2002:a1c:4d13:: with SMTP id o19mr3115830wmh.164.1637024513634;
 Mon, 15 Nov 2021 17:01:53 -0800 (PST)
MIME-Version: 1.0
References: <20211113071548.372572-1-irogers@google.com> <20211113071548.372572-2-irogers@google.com>
 <YZFBDI6oPMidX0KO@krava> <CAP-5=fWzzggdSv7bUm-+Ed6LfoUa1ce02n-bEOCqWWip4L8TLg@mail.gmail.com>
In-Reply-To: <CAP-5=fWzzggdSv7bUm-+Ed6LfoUa1ce02n-bEOCqWWip4L8TLg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 15 Nov 2021 17:01:40 -0800
Message-ID: <CAP-5=fWSHDS3GQorpYEK3qhWSCJE-KJdOK36c0OznZQT88C3YQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf parse-events: Architecture specific leader override
To:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        eranian@google.com, Kan Liang <kan.liang@linux.intel.com>
Cc:     John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, Nov 14, 2021 at 10:17 AM Ian Rogers <irogers@google.com> wrote:
>
> On Sun, Nov 14, 2021 at 9:02 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Fri, Nov 12, 2021 at 11:15:48PM -0800, Ian Rogers wrote:
> > > Currently topdown events must appear after a slots event:
> > >
> > > $ perf stat -e '{slots,topdown-fe-bound}' /bin/true
> > >
> > >  Performance counter stats for '/bin/true':
> > >
> > >          3,183,090      slots
> > >            986,133      topdown-fe-bound
> > >
> > > Reversing the events yields:
> > >
> > > $ perf stat -e '{topdown-fe-bound,slots}' /bin/true
> > > Error:
> > > The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (topdown-fe-bound).
> >
> > why is this actually failing?
> >
> > >
> > > For metrics the order of events is determined by iterating over a
> > > hashmap, and so slots isn't guaranteed to be first which can yield this
> > > error.
> > >
> > > Change the set_leader in parse-events, called when a group is closed, so
> > > that rather than always making the first event the leader, if the slots
> > > event exists then it is made the leader. It is then moved to the head of
> > > the evlist otherwise it won't be opened in the correct order.
> > >
> > > The result is:
> > >
> > > $ perf stat -e '{topdown-fe-bound,slots}' /bin/true
> > >
> > >  Performance counter stats for '/bin/true':
> > >
> > >          3,274,795      slots
> > >          1,001,702      topdown-fe-bound
> > >
> > > A problem with this approach is the slots event is identified by name,
> > > names can be overwritten like 'cpu/slots,name=foo/' and this causes the
> > > leader change to fail.
> >
> > would it be better then to move this shuffle to the metric code directly,
> > and make sure it only spits 'good' order of events?
> >
> > and keep "-e '{topdown-fe-bound,slots}'" to fail if user specifies that on
> > the command line
>
> It's an alternative to do that, but the people I spoke to preferred
> having parse-events do this. I'm not sure what Andi's opinion is.
> There is a general frustration about how brittle the slots event is,
> and so this does make it less brittle.

A different problem this fixes is if you have a group like
'{instructions,slots,topdown-fe-bound}' then slots still has to be the
group leader even though it is appearing before the topdown event. So
before the patch:

$ perf stat -e '{instructions,slots,topdown-fe-bound}' -a -- sleep 2

 Performance counter stats for 'system wide':

     <not counted>      instructions
     <not counted>      slots
   <not supported>      topdown-fe-bound

       2.006410898 seconds time elapsed

After:

$ perf stat -e '{instructions,slots,topdown-fe-bound}' -a -- sleep 2

 Performance counter stats for 'system wide':

        2572632080      slots
         362537420      instructions
         742416906      topdown-fe-bound

       2.005875050 seconds time elapsed

Thanks,
Ian

> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/arch/x86/util/evlist.c | 17 +++++++++++++++++
> > >  tools/perf/util/evlist.h          |  1 +
> > >  tools/perf/util/parse-events.c    | 16 +++++++++++-----
> > >  tools/perf/util/parse-events.h    |  4 ++--
> > >  tools/perf/util/parse-events.y    | 12 ++++++++----
> > >  5 files changed, 39 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
> > > index 0b0951030a2f..1624372b2da2 100644
> > > --- a/tools/perf/arch/x86/util/evlist.c
> > > +++ b/tools/perf/arch/x86/util/evlist.c
> > > @@ -17,3 +17,20 @@ int arch_evlist__add_default_attrs(struct evlist *evlist)
> > >       else
> > >               return parse_events(evlist, TOPDOWN_L1_EVENTS, NULL);
> > >  }
> > > +
> > > +struct evsel *arch_evlist__leader(struct list_head *list)
> > > +{
> > > +     struct evsel *evsel, *first;
> > > +
> > > +     first = list_entry(list->next, struct evsel, core.node);
> > > +
> > > +     if (!pmu_have_event("cpu", "slots"))
> > > +             return first;
> > > +
> > > +     __evlist__for_each_entry(list, evsel) {
> > > +             if (evsel->pmu_name && !strcmp(evsel->pmu_name, "cpu") &&
> > > +                     evsel->name && strstr(evsel->name, "slots"))
> > > +                     return evsel;
> > > +     }
> > > +     return first;
> > > +}
> > > diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> > > index 97bfb8d0be4f..993437ffe429 100644
> > > --- a/tools/perf/util/evlist.h
> > > +++ b/tools/perf/util/evlist.h
> > > @@ -110,6 +110,7 @@ int __evlist__add_default_attrs(struct evlist *evlist,
> > >       __evlist__add_default_attrs(evlist, array, ARRAY_SIZE(array))
> > >
> > >  int arch_evlist__add_default_attrs(struct evlist *evlist);
> > > +struct evsel *arch_evlist__leader(struct list_head *list);
> > >
> > >  int evlist__add_dummy(struct evlist *evlist);
> > >
> > > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > > index 6308ba739d19..a2f4c086986f 100644
> > > --- a/tools/perf/util/parse-events.c
> > > +++ b/tools/perf/util/parse-events.c
> > > @@ -1821,22 +1821,28 @@ parse_events__set_leader_for_uncore_aliase(char *name, struct list_head *list,
> > >       return ret;
> > >  }
> > >
> > > -void parse_events__set_leader(char *name, struct list_head *list,
> > > -                           struct parse_events_state *parse_state)
> > > +__weak struct evsel *arch_evlist__leader(struct list_head *list)
> > > +{
> > > +     return list_entry(list->next, struct evsel, core.node);
> > > +}
> > > +
> > > +struct list_head *parse_events__set_leader(char *name, struct list_head *list,
> > > +                                     struct parse_events_state *parse_state)
> > >  {
> > >       struct evsel *leader;
> > >
> > >       if (list_empty(list)) {
> > >               WARN_ONCE(true, "WARNING: failed to set leader: empty list");
> > > -             return;
> > > +             return NULL;
> > >       }
> > >
> > >       if (parse_events__set_leader_for_uncore_aliase(name, list, parse_state))
> > > -             return;
> > > +             return NULL;
> > >
> > > -     leader = list_entry(list->next, struct evsel, core.node);
> > > +     leader = arch_evlist__leader(list);
> > >       __perf_evlist__set_leader(list, &leader->core);
> > >       leader->group_name = name ? strdup(name) : NULL;
> > > +     return &leader->core.node;
> > >  }
> > >
> > >  /* list_event is assumed to point to malloc'ed memory */
> > > diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> > > index c7fc93f54577..8a6e6b4d5cbe 100644
> > > --- a/tools/perf/util/parse-events.h
> > > +++ b/tools/perf/util/parse-events.h
> > > @@ -211,8 +211,8 @@ int parse_events_copy_term_list(struct list_head *old,
> > >
> > >  enum perf_pmu_event_symbol_type
> > >  perf_pmu__parse_check(const char *name);
> > > -void parse_events__set_leader(char *name, struct list_head *list,
> > > -                           struct parse_events_state *parse_state);
> > > +struct list_head *parse_events__set_leader(char *name, struct list_head *list,
> > > +                                     struct parse_events_state *parse_state);
> > >  void parse_events_update_lists(struct list_head *list_event,
> > >                              struct list_head *list_all);
> > >  void parse_events_evlist_error(struct parse_events_state *parse_state,
> > > diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> > > index 174158982fae..5358c400f938 100644
> > > --- a/tools/perf/util/parse-events.y
> > > +++ b/tools/perf/util/parse-events.y
> > > @@ -199,20 +199,24 @@ group_def
> > >  group_def:
> > >  PE_NAME '{' events '}'
> > >  {
> > > -     struct list_head *list = $3;
> > > +     struct list_head *new_head, *list = $3;
> > >
> > >       inc_group_count(list, _parse_state);
> > > -     parse_events__set_leader($1, list, _parse_state);
> > > +     new_head = parse_events__set_leader($1, list, _parse_state);
> > > +     if (new_head)
> > > +             list_move(new_head, list);
> >
> > why not put these last 2 lines to parse_events__set_leader as well?
>
> I can move that, but I'll try to motivate having it this way. The list
> logic in Linux I find troublesome. In parse-events.y we have a list
> head that is just a next, prev pointer and not full evsel in a list.
> So for {topdown-fe-bound,slots} in parse-events.y we have a list of:
>
> head -next-> evsel("topdown-fe-bound") -next-> evsel("slots")
>
> But in __perf_evlist__set_leader the list doesn't have the head:
>
> evsel("topdown-fe-bound") -next-> evsel("slots")
>
> The list_move is changing the list to:
>
> head -next-> evsel("slots") -next-> evsel("topdown-fe-bound")
>
> which isn't possible in __perf_evlist__set_leader as the head has
> gone. I felt having the list_move in parse_events__set_leader made it
> look like the leader is being placed second rather than at the head.
> So this was an attempt to make the code more intention revealing, but
> that could also be done by some comments, it's just in
> parse_events__set_leader we have the two styles of lists in play.
>
> While I'm complaining, there are many brittle assumptions about evlist
> that it may be worth adding some more assertions for. There is already
> an assertion that the leader was opened before its siblings. There are
> assumptions that the idx given to an evsel are incremental and that
> for the leader 'idx - prev->idx' will yield the number of list
> elements. My concern is for libperf users, it doesn't seem
> unreasonable that they will want to manipulate the evlist but given
> the assumptions they will likely find bugs - such as idx being used to
> index an array and reordering breaking things. The metric code would
> be a customer of reordering were it to need to move slots, but when I
> experimented with this it easily broke things - which motivates doing
> it in parse-events or more likely for the metrics, when generating the
> parse-events string.
>
> Thanks,
> Ian
>
>
>
>
> > >       free($1);
> > >       $$ = list;
> > >  }
> > >  |
> > >  '{' events '}'
> > >  {
> > > -     struct list_head *list = $2;
> > > +     struct list_head *new_head, *list = $2;
> > >
> > >       inc_group_count(list, _parse_state);
> > > -     parse_events__set_leader(NULL, list, _parse_state);
> > > +     new_head = parse_events__set_leader(NULL, list, _parse_state);
> > > +     if (new_head)
> > > +             list_move(new_head, list);
> >
> > same
> >
> > thanks,
> > jirka
> >
