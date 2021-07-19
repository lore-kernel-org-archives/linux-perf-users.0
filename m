Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86094C07E95
	for <linux-perf-users@archiver.kernel.org>; Mon, 19 Jul 2021 23:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5005A6113B
	for <linux-perf-users@archiver.kernel.org>; Mon, 19 Jul 2021 23:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242887AbhGSWhx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 19 Jul 2021 18:37:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54827 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1387839AbhGSUgZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 19 Jul 2021 16:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626729376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CZbqAx8RCbkxkOvue3VbFWnAjITofkdFcSi0ebBpg7c=;
        b=LopMR2h4/mKBTIbo5vFuos2vIBXsI137sPQ+oF/lIVKwA6+8Y+OdfdkWAPgl5bZWMdIGFB
        zovyWtaIu4JeUMtHF+COzZ8y+FlqLFUChCDFLgdI8wtNrXvcjtVXfoLs06CyFcFc4nqsia
        mODia137yNLlutyVyX6dUSjMIk+SLiQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-f-gF58wDOiK3B8RD5JJzsw-1; Mon, 19 Jul 2021 17:13:31 -0400
X-MC-Unique: f-gF58wDOiK3B8RD5JJzsw-1
Received: by mail-ej1-f71.google.com with SMTP id t8-20020a1709063e48b0290501cd965554so5970960eji.8
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Jul 2021 14:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CZbqAx8RCbkxkOvue3VbFWnAjITofkdFcSi0ebBpg7c=;
        b=lZ3kE/YAY2m0PvT8V55o83byac7IpElwHCMnczq+bjXaxagauki+CKirAbtWJ/tD/4
         NCQisxFcYIBy/rR8/fu3rbD0rbIDbXH3QV1cus3AliowuF1xLDMs/crlojzuSxynZ7QV
         u1VBTPl1cuz7YVYLenLjG9Nh5iPRU+1qxPRpxDceyPoiv2xvrT5SQckQ8+fakK3KkNU7
         vhu7xlId162Kreu+iLZSVAzoOlVwMinrg42pHnSLXFRzkmcJXliO1qBP1cbfQVlPNdEp
         nNhNDdnS0ZggmM7owrCvaezxCjDtsVcOr/gWTxX4Swg4XctRQKMf700LZe4nE4tYsbhS
         MhKA==
X-Gm-Message-State: AOAM530VLyvVj7WO5mKFU4BJlCMwUFVC98nAjgR5C8mH3/QHL7kWrLW0
        pyy8VgyvrPesgkqVBI1LQhuSskNXsq20z78YLkiBqHECaNRBkOqGLHw8N2+ybTY0HVuRLla3l+Y
        o+y0wmB3bJmdm0NVbIM31D3bYQuwreA==
X-Received: by 2002:a17:907:1c9f:: with SMTP id nb31mr29626540ejc.342.1626729209742;
        Mon, 19 Jul 2021 14:13:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZcbdUplE0ZM5hFo76QHPnaJkulHVLBuERYtpqhzmRgCab8byCiyP4+jrQdhO9FmizVgN1RQ==
X-Received: by 2002:a17:907:1c9f:: with SMTP id nb31mr29626521ejc.342.1626729209530;
        Mon, 19 Jul 2021 14:13:29 -0700 (PDT)
Received: from krava ([83.240.60.59])
        by smtp.gmail.com with ESMTPSA id jw8sm6284226ejc.60.2021.07.19.14.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 14:13:29 -0700 (PDT)
Date:   Mon, 19 Jul 2021 23:13:27 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH 00/10] perf: add workqueue library and use it in
 synthetic-events
Message-ID: <YPXq95yUYo+cH740@krava>
References: <cover.1626177381.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1626177381.git.rickyman7@gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jul 13, 2021 at 02:11:11PM +0200, Riccardo Mancini wrote:
> This patchset introduces a new utility library inside perf/util, which
> provides a work queue abstraction, which loosely follows the Kernel
> workqueue API.
> 
> The workqueue abstraction is made up by two components:
>  - threadpool: which takes care of managing a pool of threads. It is
>    inspired by the prototype for threaded trace in perf-record from Alexey:
>    https://lore.kernel.org/lkml/cover.1625227739.git.alexey.v.bayduraev@linux.intel.com/
>  - workqueue: manages a shared queue and provides the workers implementation.
> 
> On top of the workqueue, a simple parallel-for utility is implemented
> which is then showcased in synthetic-events.c, replacing the previous
> manual pthread-created threads.
> 
> Through some experiments with perf bench, I can see how the new 
> workqueue has a higher overhead compared to manual creation of threads, 
> but is able to more effectively partition work among threads, yielding 
> a better result with more threads.
> Furthermore, the overhead could be configured by changing the
> `work_size` (currently 1), aka the number of dirents that are 
> processed by a thread before grabbing a lock to get the new work item.
> I experimented with different sizes but, while bigger sizes reduce overhead
> as expected, they do not scale as well to more threads.
> 
> I tried to keep the patchset as simple as possible, deferring possible
> improvements and features to future work.
> Naming a few:
>  - in order to achieve a better performance, we could consider using 
>    work-stealing instead of a common queue.
>  - affinities in the thread pool, as in Alexey prototype for
>    perf-record. Doing so would enable reusing the same threadpool for
>    different purposes (evlist open, threaded trace, synthetic threads),
>    avoiding having to spin up threads multiple times.
>  - resizable threadpool, e.g. for lazy spawining of threads.
> 
> @Arnaldo
> Since I wanted the workqueue to provide a similar API to the Kernel's
> workqueue, I followed the naming style I found there, instead of the
> usual object__method style that is typically found in perf. 
> Let me know if you'd like me to follow perf style instead.
> 
> Thanks,
> Riccardo
> 
> Riccardo Mancini (10):
>   perf workqueue: threadpool creation and destruction
>   perf tests: add test for workqueue
>   perf workqueue: add threadpool start and stop functions
>   perf workqueue: add threadpool execute and wait functions
>   perf workqueue: add sparse annotation header
>   perf workqueue: introduce workqueue struct
>   perf workqueue: implement worker thread and management
>   perf workqueue: add queue_work and flush_workqueue functions
>   perf workqueue: add utility to execute a for loop in parallel
>   perf synthetic-events: use workqueue parallel_for

looks great, would it make sense to put this to libperf?

jirka

> 
>  tools/perf/tests/Build                 |   1 +
>  tools/perf/tests/builtin-test.c        |   9 +
>  tools/perf/tests/tests.h               |   3 +
>  tools/perf/tests/workqueue.c           | 453 +++++++++++++++++
>  tools/perf/util/Build                  |   1 +
>  tools/perf/util/synthetic-events.c     | 131 +++--
>  tools/perf/util/workqueue/Build        |   2 +
>  tools/perf/util/workqueue/sparse.h     |  21 +
>  tools/perf/util/workqueue/threadpool.c | 516 ++++++++++++++++++++
>  tools/perf/util/workqueue/threadpool.h |  29 ++
>  tools/perf/util/workqueue/workqueue.c  | 642 +++++++++++++++++++++++++
>  tools/perf/util/workqueue/workqueue.h  |  38 ++
>  12 files changed, 1771 insertions(+), 75 deletions(-)
>  create mode 100644 tools/perf/tests/workqueue.c
>  create mode 100644 tools/perf/util/workqueue/Build
>  create mode 100644 tools/perf/util/workqueue/sparse.h
>  create mode 100644 tools/perf/util/workqueue/threadpool.c
>  create mode 100644 tools/perf/util/workqueue/threadpool.h
>  create mode 100644 tools/perf/util/workqueue/workqueue.c
>  create mode 100644 tools/perf/util/workqueue/workqueue.h
> 
> -- 
> 2.31.1
> 

