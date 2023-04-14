Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3C8C77B72
	for <linux-perf-users@archiver.kernel.org>; Fri, 14 Apr 2023 12:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjDNM4t (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 14 Apr 2023 08:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjDNM4s (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 14 Apr 2023 08:56:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED93AD24
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Apr 2023 05:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681476951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=T997QlX8ulRak2Xfd7UnKYdetFcqQN7kWdIRh6IkroE=;
        b=Le59vJFeScCLIQ5si5heeVOuSrBFGJc+NUwT9CV6DEjyuUrGE2gQ6tABMRMjDRxfdBdZAl
        Y+2TyVdW1ZouL9VYqxKkShC7GfCEN9fKZnrwD0fmo45at7luXQZQUjrx19mA8mLW1oHYCI
        JcDKHzGRD0ClZ2f+7YGw2z9Fs/+zE8U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-423-WmKRPv8DMrCu00hGWtGdsw-1; Fri, 14 Apr 2023 08:55:49 -0400
X-MC-Unique: WmKRPv8DMrCu00hGWtGdsw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ECF8D88F479;
        Fri, 14 Apr 2023 12:55:45 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.9.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D1793406AA66;
        Fri, 14 Apr 2023 12:55:37 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guo Ren <guoren@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS
        SUBSYSTEM)
Subject: [PATCH v6 0/3] Introduce put_task_struct_atomic_sleep()
Date:   Fri, 14 Apr 2023 09:55:26 -0300
Message-Id: <20230414125532.14958-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The put_task_struct() function reduces a usage counter and invokes
__put_task_struct() when the counter reaches zero.

In the case of __put_task_struct(), it indirectly acquires a spinlock,
which operates as a sleeping lock under the PREEMPT_RT configuration.
As a result, invoking put_task_struct() within an atomic context is
not feasible for real-time (RT) kernels.

To address this issue, this patch series introduces a new function
called put_task_struct_atomic_safe(). When compiled with the
PREEMPT_RT configuration, this function defers the call to
__put_task_struct() to a process context.

Additionally, the patch series rectifies known problematic call sites
to ensure smooth functioning.

Changelog
=========

v1:
* Initial implementation fixing the splat.

v2:
* Isolate the logic in its own function.
* Fix two more cases caught in review.

v3:
* Change __put_task_struct() to handle the issue internally.

v4:
* Explain why call_rcu() is safe to call from interrupt context.

v5:
* Explain why __put_task_struct() doesn't conflict with
  put_task_sruct_rcu_user.

v6:
* As per Sebastian's review, revert back the implementation of v2
  with a distinct function.
* Add a check in put_task_struct() to warning when called from a
  non-sleepable context.
* Address more call sites.

Wander Lairson Costa (3):
  sched/core: warn on call put_task_struct in invalid context
  sched/task: Add the put_task_struct_atomic_safe() function
  treewide: replace put_task_struct() witht the atomic safe version

 include/linux/sched/task.h | 45 ++++++++++++++++++++++++++++++++++++++
 kernel/events/core.c       |  6 ++---
 kernel/fork.c              |  8 +++++++
 kernel/locking/rtmutex.c   | 10 ++++-----
 kernel/sched/core.c        |  6 ++---
 kernel/sched/deadline.c    | 16 +++++++-------
 kernel/sched/rt.c          |  4 ++--
 7 files changed, 74 insertions(+), 21 deletions(-)

-- 
2.39.2

