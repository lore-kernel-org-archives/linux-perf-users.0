Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A4FC433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 27 Sep 2021 22:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93A7560F94
	for <linux-perf-users@archiver.kernel.org>; Mon, 27 Sep 2021 22:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237373AbhI0WOs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237237AbhI0WOs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 27 Sep 2021 18:14:48 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366E1C061575;
        Mon, 27 Sep 2021 15:13:10 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id e7so19150321pgk.2;
        Mon, 27 Sep 2021 15:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LQoaNx5tAGjunmfJNoYC07QY3HqXDClsG7X/kjDcaHM=;
        b=qIydS8jNGOHH2PajdpXajC5LXHdZnQ8xaKAsu5QaLok9cHzAxluLivYrnOFLPxqKqE
         0hozzn2PyUhobcE89p9IDM4ALB+FbA8PDIzdVaFl/MLcgShy1gd0BQsHdMLoWCftcDuc
         bv47yDQQN/vgxit8CP6OoqtdTJTI8C+SMjAa++U3PE8pnFQw4eQeccl6osT1TcYoOZCN
         3fiBGdp3grow81cAp1Zzt/hq+QFsZdUB8SwJ/82a1kvIFJx4W0minOMc5N49NILTVn21
         Lzz5aBD0OlupQurKdCrltAVxUBFlcFkCEwSUlhHV/ax6vEB7IgJ5opYdtusS+GwRG4Ot
         trSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LQoaNx5tAGjunmfJNoYC07QY3HqXDClsG7X/kjDcaHM=;
        b=ipuQm1kJzaauJUxvhdeoyBe6iG+hgnEQQAAbO/PYYwYFVFkq6oVb76g5r0urkx79to
         KxVeuf6Ow0hmVRHBreKSaZQOgD7sI15+fuTQiq/I477wglqGOBME3/v01X9JIXi45Da/
         o1f/lWiifX88lew6QU7wDpBG54Lwsh1KZ5bngf/8dSQlBF2CwFH7LwvyyhjIacfpyJeb
         wI0ygp56dh+PfQsluM9lAp+ivJIt5sJqwOuKBvup+bMs9fXA37izDt62jYLhzd0Swu6e
         iwr9pxnXHMIC7Yd2XNsvvxqdWMsCNxa9o2Mn4SL5b7gMiG+faeSSnMK4qY77LIyYNtG+
         PpRQ==
X-Gm-Message-State: AOAM533GqeF6Ni8Ie1DtA3QbMKawgjJcB1OGIHeEffd2ChGfemzOPHOt
        OPHW4fvQ+y9bZUfFbnlnrcx7jhhLb7e7YS2MvDM=
X-Google-Smtp-Source: ABdhPJzOQORKcAXFM5QQCW6Uy4cQVYG5x75c/jCV3lw1160enyL+fOFkGkgsNEJxMOqZauyc+ZWsGdN2WB6M2cJg+iY=
X-Received: by 2002:a62:407:0:b0:447:c104:2529 with SMTP id
 7-20020a620407000000b00447c1042529mr2323985pfe.8.1632780789705; Mon, 27 Sep
 2021 15:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210926023028.2338342-1-jinshan.xiong@gmail.com> <YVBkObnrPfX6KIZM@kernel.org>
In-Reply-To: <YVBkObnrPfX6KIZM@kernel.org>
From:   Jinshan Xiong <jinshan.xiong@gmail.com>
Date:   Mon, 27 Sep 2021 15:12:33 -0700
Message-ID: <CABoqRjsUPhJk6A7QOh_9z6zHLyqX=ZZG7gkcEZeui1uO4m7Bbg@mail.gmail.com>
Subject: Re: [PATCH] tools/lib/perf: make the static libperf complete
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     jolsa@redhat.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Thanks for pointing it out. I will make the static library a separate
target for installation. Patch is coming soon.

Jinshan


On Sun, Sep 26, 2021 at 5:14 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Sat, Sep 25, 2021 at 07:30:24PM -0700, Jinshan Xiong escreveu:
> > This patch makes libperf.a complete. Initially it misses the symbols
> > fdarray_* that makes it unusable:
> >    $ nm tools/lib/perf/libperf.a | grep fdarray_
> >                     U fdarray__add
> >    0000000000002b3e t fdarray__available_entries
> >                     U fdarray__exit
> >                     U fdarray__filter
> >                     U fdarray__grow
> >                     U fdarray__init
> >                     U fdarray__poll
> >
> > After this patch is applied:
> >     $ nm tools/lib/perf/libperf.a | grep fdarray_
> >     00000000000063f7 T fdarray__add
> >     ......
> >     00000000000065d4 T fdarray__poll
>
> Have you tried to build tools/perf/ with this?
>
>   LINK    /tmp/build/perf/plugins/plugin_futex.so
>   LINK    /tmp/build/perf/plugins/plugin_jbd2.so
>   INSTALL trace_plugins
> /usr/bin/ld: /tmp/build/perf/libperf.a(libperf-ar.o):/var/home/acme/git/perf/tools/lib/api/debug.c:20: multiple definition of `__pr_debug'; /tmp/build/perf/libapi.a(libapi-in.o):/var/home/acme/git/perf/tools/lib/api/debug.c:20: first defined here
> /usr/bin/ld: /tmp/build/perf/libperf.a(libperf-ar.o): in function `sysfs__read_bool':
> /var/home/acme/git/perf/tools/lib/api/fs/fs.c:505: multiple definition of `sysfs__read_bool'; /tmp/build/perf/libapi.a(libapi-in.o):/var/home/acme/git/perf/tools/lib/api/fs/fs.c:505: first defined here
> /usr/bin/ld: /tmp/build/perf/libperf.a(libperf-ar.o): in function `fdarray__poll':
> /var/home/acme/git/perf/tools/lib/api/fd/array.c:120: multiple definition of `fdarray__poll'; /tmp/build/perf/libapi.a(libapi-in.o):/var/home/acme/git/perf/tools/lib/api/fd/array.c:120: first defined here
> /usr/bin/ld: /tmp/build/perf/libperf.a(libperf-ar.o): in function `tracefs__configured':
> /var/home/acme/git/perf/tools/lib/api/fs/fs.c:316: multiple definition of `tracefs__configured'; /tmp/build/perf/libapi.a(libapi-in.o):/var/home/acme/git/perf/tools/lib/api/fs/fs.c:316: first defined here
> /usr/bin/ld: /tmp/build/perf/libperf.a(libperf-ar.o): in function `sysfs__read_int':
> /var/home/acme/git/perf/tools/lib/api/fs/fs.c:479: multiple definition of `sysfs__read_int'; /tmp/build/perf/libapi.a(libapi-in.o):/var/home/acme/git/perf/tools/lib/api/fs/fs.c:479: first defined here
> /usr/bin/ld: /tmp/build/perf/libperf.a(libperf-ar.o): in function `fdarray__fprintf':
> /var/home/acme/git/perf/tools/lib/api/fd/array.c:125: multiple definition of `fdarray__fprintf'; /tmp/build/perf/libapi.a(libapi-in.o):/var/home/acme/git/perf/tools/lib/api/fd/array.c:125: first defined here
> /usr/bin/ld: /tmp/build/perf/libperf.a(libperf-ar.o): in function `sysfs__write_int':
> /var/home/acme/git/perf/tools/lib/api/fs/fs.c:547: multiple definition of `sysfs__write_int'; /tmp/build/perf/libapi.a(libapi-in.o):/var/home/acme/git/perf/tools/lib/api/fs/fs.c:547: first defined here
> /usr/bin/ld: /tmp/build/perf/libperf.a(libperf-ar.o): in function `filename__read_str':
> /var/home/acme/git/perf/tools/lib/api/fs/fs.c:378: multiple definition of `filename__read_str'; /tmp/build/perf/libapi.a(libapi-in.o):/var/home/acme/git/perf/tools/lib/api/fs/fs.c:378: first defined here
> /usr/bin/ld: /tmp/build/perf/libperf.a(libperf-ar.o): in function `hugetlbfs__mountpoint':
> /var/home/acme/git/perf/tools/lib/api/fs/fs.c:317: multiple definition of `hugetlbfs__mountpoint'; /tmp/build/perf/libapi.a(libapi-in.o):/var/home/acme/git/perf/tools/lib/api/fs/fs.c:317: first defined here
> /usr/bin/ld: /tmp/build/perf/libperf.a(libperf-ar.o): in function `debugfs__mountpoint':
> /var/home/acme/git/perf/tools/lib/api/fs/fs.c:315: multiple definition of `debugfs__mountpoint'; /tmp/build/perf/libapi.a(libapi-in.o):/var/home/acme/git/perf/tools/lib/api/fs/fs.c:315: first defined here
> /usr/bin/ld: /tmp/build/perf/libperf.a(libperf-ar.o): in function `fdarray__delete':
> /var/home/acme/git/perf/tools/lib/api/fd/array.c:71: multiple definition of `fdarray__delete'; /tmp/build/perf/libapi.a(libapi-in.o):/var/home/acme/git/perf/tools/lib/api/fd/array.c:71: first defined here
> /usr/bin/ld: /tmp/build/perf/libperf.a(libperf-ar.o): in function `procfs__mountpoint':
> /var/home/acme/git/perf/tools/lib/api/fs/fs.c:314: multiple definition of `procfs__mountpoint'; /tmp/build/perf/libapi.a(libapi-in.o):/var/home/acme/git/perf/tools/lib/api/fs/fs.c:314: first defined here
> /usr/bin/ld: /tmp/build/perf/libperf.a(libperf-ar.o): in function `get_tracing_file':
> /var/home/acme/git/perf/tools/lib/api/fs/tracing_path.c:74: multiple definition of `get_tracing_file'; /tmp/build/perf/libapi.a(libapi-in.o):/var/home/acme/git/perf/tools/lib/api/fs/tracing_path.c:74: first defined here
>
> You probably need to include libapi.a as well.
>
> - Arnaldo
