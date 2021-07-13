Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574A8C07E95
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 19:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 302F061380
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 19:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbhGMTRJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jul 2021 15:17:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:39432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhGMTRI (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jul 2021 15:17:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 048AD61154;
        Tue, 13 Jul 2021 19:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626203658;
        bh=/A28ytl7Glg4j6xHPrW4hXaLaer9R4bAx56RHj0Avuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TOBM+UvtFJgSCWP5XB85U8dG/gCQeOfKM3jUIk6eFGWrnL2TK/G8m7EB3dwBw2aXj
         Cfbrm1Vgl/7xWaJSHtmjCB8gplQLXZWjoxsARyNrm6/ME5cLa/E+F6d7SvGMSDkrYk
         Qa2uYNbvIRpUy4NlRopD5wSHn5nt8C643Ay5auemkq9xmDiUXaZ6vk9/3CBY/Ll1O9
         EXT8drjJ/CdivvOo6i7Iv9OR7i3E45OvGVedcJ4vuvkHqvqQJxZc0p1O6WOAlhfG7g
         o+olDlctw7SIE84KveZT4W7c5AsFWJhXN0QlOfln7BBnep8E9cN7SxwgSyeetsTEjG
         fsCpvoNGGuuZw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4F38C403F2; Tue, 13 Jul 2021 16:14:15 -0300 (-03)
Date:   Tue, 13 Jul 2021 16:14:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH 00/10] perf: add workqueue library and use it in
 synthetic-events
Message-ID: <YO3mB0pzaxJ/4c58@kernel.org>
References: <cover.1626177381.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1626177381.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Jul 13, 2021 at 02:11:11PM +0200, Riccardo Mancini escreveu:
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

You did the right thing, that is how we do with other kernel APIs, we
use list_add(), rb_first(), bitmap_weight(), hash_del(),  etc.

- Arnaldo
 
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

-- 

- Arnaldo
