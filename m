Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBE7C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 19 Nov 2021 17:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D83C961A53
	for <linux-perf-users@archiver.kernel.org>; Fri, 19 Nov 2021 17:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236488AbhKSRO6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 19 Nov 2021 12:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236484AbhKSRO5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 19 Nov 2021 12:14:57 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8ADEC06173E
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Nov 2021 09:11:55 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id f9so13507284ioo.11
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Nov 2021 09:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6UtAEF3RMoWxvdmenr7jJlhUUM9QJZdlurbD3JlhdrA=;
        b=TLwLw5txAQexwrNw1GXupt21MSixRkrPoci4c9arHuo6rEbq5YdRs3Dn3WlhaySF8t
         XgGVqLkwjt2jNsb/uHuHelfU+iOYnupAb20l3vZ4e1r0Iy6HuQ8x5cVvxX15kroPNNH9
         V87+AEv0RUUOXYhkc7hj5nrxdi/Z5/FSmqfqjpbDomwmYOY2IfxoYDd4KYDudmADT0Pe
         L2OcNcUAa545JhSOF1DJZEdJEbEXEG8jpFefn35Jao7qvvMkRMp/2XlxgoE1sGFjLpCO
         kXD+Ln5OokQA0ujzE3Edqkno/vQj4XMW1qnsJCqzdMzPZVW8OFQVxVyDwJL9l6vpY7Gd
         DxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6UtAEF3RMoWxvdmenr7jJlhUUM9QJZdlurbD3JlhdrA=;
        b=w0lO1eJ64yd4J9qEkFDF3/O/XTIN+mT4CtSOpjdER1/f197iD4TeQoZMYT0efvWWNj
         wlil4qfrpcHA+MdjcTxtU77BubsSb452CZ3m9Lj9otYfvBSAXuHlz9gfPq4fNJntCqgq
         ENk2pczaTjDAc0bOyEe+yQ7QYXSJpEyJFSOlhKZWar5wYo0/umlznpHdCl99WAE8i57N
         Mub7Ph8XtJivmmUBTs75qng204+orA9mN5phtKl1KF3k9nyq5uNuG/rzNVKInmsYCfbO
         jhmrgexJkK6DbQz2ukG831L8rLS3QaGT1B8/bVVBOigorzmoRRNuuqvJLgLssv4U+AS2
         mJkw==
X-Gm-Message-State: AOAM530E7OONMq9cxvnXUt8Fm6V4WwUUwx9D84Ngt6usQWgB8NNIITP8
        hEwnVhNJKV1FAi6Ol4LwJfErJFUu0nOnCXL8CWkrFA==
X-Google-Smtp-Source: ABdhPJyta5sVRoXfrWoMVVk96IobRSjnNcryB8JFyy5Hg55pKd9es/dKLbW1z4SgwB0UW0rnJnJE7hfx+rDlEJy1cRg=
X-Received: by 2002:a05:6638:144f:: with SMTP id l15mr28892479jad.21.1637341914947;
 Fri, 19 Nov 2021 09:11:54 -0800 (PST)
MIME-Version: 1.0
References: <20211118220647.2355999-1-irogers@google.com> <20211118220647.2355999-2-irogers@google.com>
 <17f31c73-052d-ef15-879a-c6a224977e8d@huawei.com>
In-Reply-To: <17f31c73-052d-ef15-879a-c6a224977e8d@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 19 Nov 2021 09:11:43 -0800
Message-ID: <CAP-5=fWh6bQ1vgzk-kK1Q0rcysXPHtbagBASgcQQ2dVgANG8Mw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf parse-events: Architecture specific leader override
To:     John Garry <john.garry@huawei.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>, eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Nov 19, 2021 at 6:47 AM John Garry <john.garry@huawei.com> wrote:
>
> On 18/11/2021 22:06, Ian Rogers wrote:
> > Currently topdown events must appear after a slots event:
> >
> > $ perf stat -e '{slots,topdown-fe-bound}' /bin/true
> >
> >   Performance counter stats for '/bin/true':
> >
> >           3,183,090      slots
> >             986,133      topdown-fe-bound
> >
> > Reversing the events yields:
> >
> > $ perf stat -e '{topdown-fe-bound,slots}' /bin/true
> > Error:
> > The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (topdown-fe-bound).
> >
> > For metrics the order of events is determined by iterating over a
> > hashmap, and so slots isn't guaranteed to be first which can yield this
> > error.
> >
> > Change the set_leader in parse-events, called when a group is closed, so
> > that rather than always making the first event the leader, if the slots
> > event exists then it is made the leader. It is then moved to the head of
> > the evlist otherwise it won't be opened in the correct order.
> >
> > The result is:
> >
> > $ perf stat -e '{topdown-fe-bound,slots}' /bin/true
>
> Just curious - does this just affect topdown events? I think x86 is the
> only arch which has them.

The change is specific to x86 as the weak symbol override only happens
on x86. For x86 it only applies if the cpu/slots/ event exists. In the
future it may be used for more than just this - Kajol Jain mentioned a
similar problem for powerpc:
https://lore.kernel.org/lkml/6d1fcb97-223d-7d8e-b5cb-0f10dbc62880@linux.ibm.com/

Thanks,
Ian

> Thanks,
> John
