Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79ABC432BE
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 16:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA14F610C9
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 16:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239909AbhHaQY2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 12:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239733AbhHaQY1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 Aug 2021 12:24:27 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F724C061575;
        Tue, 31 Aug 2021 09:23:32 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q14so28678199wrp.3;
        Tue, 31 Aug 2021 09:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=1RiskkQMXgkNjj9qnTOmRZ7i2Te6zUGCcdIS5eV1pqQ=;
        b=K/pdV8J7p+jVC2uXnM86MCl4umcFXSa+nle4dZA+4QDSJzZbq9KFtE2xtHGbrGnWKw
         g2xCSFQ5NIepQujFmeVFTQp1uq9QUeVaINpvSmoiNPP8mXHIG4wZNr+og7iHv5N9bS8v
         XnUBp/WEnx30Xrizf8Lv+dsp4gkBnNa2FGlXVuPvd9okm0MrbVxieDxwWV4MSQmzl+c8
         d2qLZCbQOaJSr1N7IFrWy5nwvx8FdvsX2T/ALKF3LqxgshI0sserhxK3oVpqUkmOb8VD
         0PYZ4j0t0NZr537vAnDS/9DNoaaDUoJsD17cuZqB4lw6ABX/erGveA/Hz/KPOXk7l5NR
         jbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=1RiskkQMXgkNjj9qnTOmRZ7i2Te6zUGCcdIS5eV1pqQ=;
        b=qO+HiCABaOqkNRGU3MDLzT6TSpv9SnrMdCm+1B5Wb0MaDHgSmsqYl4YpZJkKov3QbE
         zm8A5RU3SK6M3IPEnG0WypER0yokQFo/Juc2Mj4yjSd9Kt+4siKI/O/51Cm3H7yMJ6/X
         OVVSG3aNs7rqdvXRmqBB9Y9N6o9XNZewZ1E4ofFUmDxCra9UAnML/uBi1cRvi4Jhws9O
         R/aaTpI13dp322123dwF1CWZqclVwHXtAxwCttZq0R+IemFWWCz3K0GygEnlhfC/t8lo
         cG/CgtktPQqohPR2yF/cDW9N5tY7zl6rJLBd6jhs0oNdYFcYRzBew2xoq4COeLxiNw9r
         PlTw==
X-Gm-Message-State: AOAM532SdmVnrR88AXiln9JUb5YcP9bD/uTwrXieXkBlVQ0X5Dkbm6Ry
        aPEmq8Sgels9DvI2+agXfGo=
X-Google-Smtp-Source: ABdhPJx5esIkMyVbxjI4d57GWpsFXpmybpNjNAKdqs3koekJQUQkt+kthxm+UN5HeTAal6rZWrxlfw==
X-Received: by 2002:adf:fec5:: with SMTP id q5mr5106097wrs.153.1630427010574;
        Tue, 31 Aug 2021 09:23:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6456:fd99:ced0:db1c:53e1:191e? ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.gmail.com with ESMTPSA id n1sm18406916wrp.49.2021.08.31.09.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 09:23:29 -0700 (PDT)
Message-ID: <0952ba94284218e3ac43c2bdf416866fc3dc0700.camel@gmail.com>
Subject: Re: [RFC PATCH v3 08/15] perf workqueue: add queue_work and
 flush_workqueue functions
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Date:   Tue, 31 Aug 2021 18:23:27 +0200
In-Reply-To: <CAM9d7ch4RM5rKrYLKrny3yt3ciK87aqzJ8Wt3ze87u9KBHjyXg@mail.gmail.com>
References: <cover.1629454773.git.rickyman7@gmail.com>
         <f9100c6e428eafe1b9761f947550e45ccc9e8849.1629454773.git.rickyman7@gmail.com>
         <CAM9d7ch4RM5rKrYLKrny3yt3ciK87aqzJ8Wt3ze87u9KBHjyXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On Tue, 2021-08-24 at 12:40 -0700, Namhyung Kim wrote:
> On Fri, Aug 20, 2021 at 3:54 AM Riccardo Mancini <rickyman7@gmail.com> wrote:
> > 
> > This patch adds functions to queue and wait work_structs, and
> > related tests.
> > 
> > When a new work item is added, the workqueue first checks if there
> > are threads to wake up. If so, it wakes it up with the given work item,
> > otherwise it will pick the next round-robin thread and queue the work
> > item to its queue. A thread which completes its queue will go to sleep.
> > 
> > The round-robin mechanism is implemented through the next_worker
> > attibute which will point to the next worker to be chosen for queueing.
> > When work is assigned to that worker or when the worker goes to sleep,
> > the pointer is moved to the next worker in the busy_list, if any.
> > When a worker is woken up, it is added in the busy list just before the
> > next_worker, so that it will be chosen as last (it's just been assigned
> > a work item).
> 
> Do we really need this?  I think some of the complexity comes
> because of this.  Can we simply put the works in a list in wq
> and workers take it out with a lock?  Then the kernel will
> distribute the works among the threads for us.
> 
> Maybe we can get rid of worker->lock too..

Having a per-thread queue has some benefits which are very useful in our case:
 - it should be able to scale to bigger machines than a shared queue (looking at
both tests from jiri, it looks like this version is somewhat better than v2, but
they're done in different conditions, so some other tests comparing the two
versions on big machines would be useful).
 - it is possible to choose the worker to execute work on, which is used in the
evlist patchset (where threads can be pinned to a cpu and evlist operations can
be done on them).

Of course, it adds some complexity over the shared queue, for example:
 - the next_worker pointer to implement the round-robin policy, for which maybe
there's a cleaner way to do it.
 - the thread "self-registration", which I think can be dropped in favor of an
array inside the workqueue (the max number of threads is limited, so having a
self-registration does not really add much flexibility and it adds contention on
the workqueue lock when threads are spun-up). Getting rid of it could reduce
workqueue spinup and stop time.

Thanks,
Riccardo

> 
> Thanks,
> Namhyung


