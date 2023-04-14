Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBCBC77B72
	for <linux-perf-users@archiver.kernel.org>; Fri, 14 Apr 2023 12:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjDNM47 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 14 Apr 2023 08:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjDNM46 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 14 Apr 2023 08:56:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B03A277
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Apr 2023 05:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681476965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YrYqlnliydYiAyvEAuZGBKT9tvoR1n5A0ejNaepolyI=;
        b=MEoYqQu7ntP/3MehFRf7DWKG3DEwzCnPC2Qh8Me8jQHWOP9VFiT4RXpOCISAgUUY0zY6iM
        WM0bS80qqKZmqh3CJE58pTcvPNDhu2WcPYQlkqyrLwuZJTpDDBuGyTz01CrchPNf2GymLY
        MXmGYSl0rGH26Xhzo3VUgqMq6P8OED4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-286-6Oqx-tBnN12S4UgBWipkuQ-1; Fri, 14 Apr 2023 08:55:57 -0400
X-MC-Unique: 6Oqx-tBnN12S4UgBWipkuQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C39D4185A791;
        Fri, 14 Apr 2023 12:55:55 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.9.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4FE9E406AA66;
        Fri, 14 Apr 2023 12:55:49 +0000 (UTC)
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
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrei Vagin <avagin@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS
        SUBSYSTEM)
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v6 1/3] sched/core: warn on call put_task_struct in invalid context
Date:   Fri, 14 Apr 2023 09:55:27 -0300
Message-Id: <20230414125532.14958-2-wander@redhat.com>
In-Reply-To: <20230414125532.14958-1-wander@redhat.com>
References: <20230414125532.14958-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Under PREEMPT_RT, spinlocks become sleepable locks. put_task_struct()
indirectly acquires a spinlock. Therefore, it can't be called in
atomic/interrupt context in RT kernels.

To prevent such conditions, add a check for atomic/interrupt context
before calling put_task_struct().

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/sched/task.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 357e0068497c..b597b97b1f8f 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -113,14 +113,28 @@ static inline struct task_struct *get_task_struct(struct task_struct *t)
 
 extern void __put_task_struct(struct task_struct *t);
 
+#define PUT_TASK_RESCHED_OFFSETS \
+	(rcu_preempt_depth() << MIGHT_RESCHED_RCU_SHIFT)
+
+#define __put_task_might_resched() \
+	__might_resched(__FILE__, __LINE__, PUT_TASK_RESCHED_OFFSETS)
+
+#define put_task_might_resched()			\
+	do {						\
+		if (IS_ENABLED(CONFIG_PREEMPT_RT))	\
+			__put_task_might_resched();	\
+	} while (0)
+
 static inline void put_task_struct(struct task_struct *t)
 {
+	put_task_might_resched();
 	if (refcount_dec_and_test(&t->usage))
 		__put_task_struct(t);
 }
 
 static inline void put_task_struct_many(struct task_struct *t, int nr)
 {
+	put_task_might_resched();
 	if (refcount_sub_and_test(nr, &t->usage))
 		__put_task_struct(t);
 }
-- 
2.39.2

