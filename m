Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC8EC48BCF
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Jun 2021 22:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24A28613E3
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Jun 2021 22:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhFIW4s (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 9 Jun 2021 18:56:48 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:46791 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhFIW4s (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Jun 2021 18:56:48 -0400
Received: by mail-lj1-f172.google.com with SMTP id e11so1910581ljn.13;
        Wed, 09 Jun 2021 15:54:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8MSqYylR/ClWK2tbw4XHVsBk6QIun8xemFhmgATk+Yg=;
        b=BBQL9gxmTGJqQjKfmTK3PafZOR1HfYIC+x+vOgU2W4/eg8QAQvwD3Dm0GJfb37jcuo
         rpSjFfy55u/KCAJOfNmpryqWnNGptqCVAp/zPTTuXrBJ05uCIdTJZFwN+F/F3jjzSHGE
         ghfxGx9b3dNGzExGReNW6/BiNc0yaAmZK40goT9eg7l+BuQPAi14hvNxDqnszrp1i2JF
         HI7oeOs+pH1tOWp8UWWvS2TDuF3LWQIMYs083nHm90trlCNB8kQPdGiW1Cl561IMD1cQ
         6L5CvYJc68F5pXUC6sNvEOsHq3niZRUv7Di4MiXzZY4PbZkGvd30muf79m9A1tgXUh3e
         lE3g==
X-Gm-Message-State: AOAM530RLvXl6D/AEAcsIFF/692HqcEWlub8h3V4Daa9TPShR5zKW/p5
        lDzuLyCLab7lQNF9a1y/xfxg2wYOI9ZK6kRH8dI=
X-Google-Smtp-Source: ABdhPJwHzWXOfySif2iX8OiOTYOHDkpXBPM3E96KNt+65PBThPRZxhJFHWYfB2+DMgv2KIRUM59Cq4ME1atOu7wMUJk=
X-Received: by 2002:a2e:a795:: with SMTP id c21mr1501932ljf.26.1623279275739;
 Wed, 09 Jun 2021 15:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1622025774.git.alexey.v.bayduraev@linux.intel.com>
 <c5a046f8bed989e4ede98f1fcdaa9d0b6bf78cac.1622025774.git.alexey.v.bayduraev@linux.intel.com>
 <3b297a17f935d2a00bfa74afbbf064b01fe83607.camel@gmail.com>
In-Reply-To: <3b297a17f935d2a00bfa74afbbf064b01fe83607.camel@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 9 Jun 2021 15:54:23 -0700
Message-ID: <CAM9d7cjJKDoMrKTzuCK=zDZivTdT-o30JKPt=97D2JEnXaHr0w@mail.gmail.com>
Subject: Re: [PATCH v6 03/20] perf record: Introduce thread local variable
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Riccardo,

On Thu, Jun 3, 2021 at 3:56 PM Riccardo Mancini <rickyman7@gmail.com> wrote:
>
> Hi,
>
> thank you very much for your work for adding threading capabilites to perf
> record.
> I did some testing on your entire patchset, especially checking for memory
> issues using ASan. This is just the first of a couple of emails to point out
> some issues I found.
> I will also do additional tests in the future.
>
> On Wed, 2021-05-26 at 13:52 +0300, Alexey Bayduraev wrote:
> SNIP
> > @@ -2220,18 +2275,20 @@ static int __cmd_record(struct record *rec, int argc,
> > const char **argv)
> >                 goto out_child;
> >         }
> >
> > -       if (!quiet)
> > -               fprintf(stderr, "[ perf record: Woken up %ld times to write data
> > ]\n", waking);
> > -
> >         if (target__none(&rec->opts.target))
> >                 record__synthesize_workload(rec, true);
> >
> >  out_child:
> > +       record__stop_threads(rec, &waking);
> > +out_free_threads:
> >         record__free_thread_data(rec);
> >         evlist__finalize_ctlfd(rec->evlist);
> >         record__mmap_read_all(rec, true);
> >         record__aio_mmap_read_sync(rec);
>
> record__mmap_read_all should be moved before record__free_thread_data since it
> uses the thread_data that's just been freed.
> Furthermore, record__mmap_read_all should also be moved before the
> out_free_threads label, since it cannot be called unless record__start_threads
> succeeded, otherwise thread would be NULL and will cause a segfault (it happens
> if there is an error somewhere else in perf, for example).
>
> In my tests the following order works, but it should be double checked for
> possible side-effects of this order change.
>
> out_child:
>         record__stop_threads(rec, &waking);
>         record__mmap_read_all(rec, true);
> out_free_threads:
>         record__free_thread_data(rec);
>         evlist__finalize_ctlfd(rec->evlist);
>         record__aio_mmap_read_sync(rec);

I wonder how it worked before.. maybe we should place
record__free_thread_data() far below.

Thanks,
Namhyung
