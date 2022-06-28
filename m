Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA21C43334
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Jun 2022 09:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344636AbiF1J7s (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Jun 2022 05:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344201AbiF1J7Z (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Jun 2022 05:59:25 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7904D2DD45
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Jun 2022 02:59:18 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id qk8-20020a1709077f8800b00722fcbfdcf7so3408237ejc.2
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Jun 2022 02:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/0VhMmtwvDisaf1/VFeOhEr7O2fqwRDhX2jxpYNVTBM=;
        b=A0dgUThUsxPUPonRuJ44vJy//juG7PWAxTRrAzXc+IibEPgCLMqm1ff+TIXJBEZ4np
         urC1WuFUcZd3YkbyJmudQfO5F/PQRUiveUt4UNIP8Khq54xdHp/Y51ymcnAwQah0iSnL
         4gjDKUi5LDExHQwQ1kV6g+MXeoLaXkjz9ZIeNSPE0jMkI0CnECpGUS+SZ2rCZxsPQlvG
         CNqasN6Q9R1G2i73lTKeBDXyTFojyY2SfCeyEBazvTR7ehqVzJTf9PjergX/M/J/RQla
         xFtnhK8Rg1MDjdK7+eJSMNx78aoMhZTqLZ/u+soOR1ylLyZPRjgsQg5Xhdx8XG5W/gdl
         5UMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/0VhMmtwvDisaf1/VFeOhEr7O2fqwRDhX2jxpYNVTBM=;
        b=s65Eylf4dk6tefIzV/4m9G7F5uNDTevIz0JHA8OnX76B3lyVLGeK6QQtx1vazqf5ap
         +T8FRVhb0C1Lt44dR2MQE745FTCv8zakZeJnauPVYgv8v+875g7dtdNFFQTm5S7ZKRmT
         ew40TY7c/AyOxmVw0aquZzdaAQjrJ0X8Chq/n8EvUwadAH3R421ZACy4rmT3VR6axHTp
         WQ9PuegbxiVXK+IFPkeLjGpnYuwirnRF7uGIx8CeggESouM54E6HbZwTy/u06RUOF76W
         e4ns5WUJaqKL7+VjAUqXH6CcMse9eRqKfFKIrLpHT+iNjdRQiGykvJYbXb2JYT11/osD
         u/Hw==
X-Gm-Message-State: AJIora+I365BfbASBtoeh/GGlmclwk2mbKOqJhk+KKVxdqPmFgvDlfYp
        WxtCJE64h54ceM1TjZYisTawnjVJ4g==
X-Google-Smtp-Source: AGRyM1s3wSZD386YJd1I3q4SwD0OlcR9IoNthKEblJrheRGJiJSpbwnIbtVCz4d8AphovvEqixF3HDIPKg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:3496:744e:315a:b41b])
 (user=elver job=sendgmr) by 2002:a17:906:e4c:b0:726:94a0:2701 with SMTP id
 q12-20020a1709060e4c00b0072694a02701mr12840911eji.360.1656410357809; Tue, 28
 Jun 2022 02:59:17 -0700 (PDT)
Date:   Tue, 28 Jun 2022 11:58:27 +0200
In-Reply-To: <20220628095833.2579903-1-elver@google.com>
Message-Id: <20220628095833.2579903-8-elver@google.com>
Mime-Version: 1.0
References: <20220628095833.2579903-1-elver@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v2 07/13] perf/hw_breakpoint: Remove useless code related to
 flexible breakpoints
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Flexible breakpoints have never been implemented, with
bp_cpuinfo::flexible always being 0. Unfortunately, they still occupy 4
bytes in each bp_cpuinfo and bp_busy_slots, as well as computing the max
flexible count in fetch_bp_busy_slots().

This again causes suboptimal code generation, when we always know that
`!!slots.flexible` will be 0.

Just get rid of the flexible "placeholder" and remove all real code
related to it. Make a note in the comment related to the constraints
algorithm but don't remove them from the algorithm, so that if in future
flexible breakpoints need supporting, it should be trivial to revive
them (along with reverting this change).

Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Also remove struct bp_busy_slots, and simplify functions.
---
 kernel/events/hw_breakpoint.c | 57 +++++++++++------------------------
 1 file changed, 17 insertions(+), 40 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index a124786e3ade..63e39dc836bd 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -45,8 +45,6 @@ struct bp_cpuinfo {
 #else
 	unsigned int	*tsk_pinned;
 #endif
-	/* Number of non-pinned cpu/task breakpoints in a cpu */
-	unsigned int	flexible; /* XXX: placeholder, see fetch_this_slot() */
 };
 
 static DEFINE_PER_CPU(struct bp_cpuinfo, bp_cpuinfo[TYPE_MAX]);
@@ -67,12 +65,6 @@ static const struct rhashtable_params task_bps_ht_params = {
 
 static bool constraints_initialized __ro_after_init;
 
-/* Gather the number of total pinned and un-pinned bp in a cpuset */
-struct bp_busy_slots {
-	unsigned int pinned;
-	unsigned int flexible;
-};
-
 /* Serialize accesses to the above constraints */
 static DEFINE_MUTEX(nr_bp_mutex);
 
@@ -190,14 +182,14 @@ static const struct cpumask *cpumask_of_bp(struct perf_event *bp)
 }
 
 /*
- * Report the number of pinned/un-pinned breakpoints we have in
- * a given cpu (cpu > -1) or in all of them (cpu = -1).
+ * Returns the max pinned breakpoint slots in a given
+ * CPU (cpu > -1) or across all of them (cpu = -1).
  */
-static void
-fetch_bp_busy_slots(struct bp_busy_slots *slots, struct perf_event *bp,
-		    enum bp_type_idx type)
+static int
+max_bp_pinned_slots(struct perf_event *bp, enum bp_type_idx type)
 {
 	const struct cpumask *cpumask = cpumask_of_bp(bp);
+	int pinned_slots = 0;
 	int cpu;
 
 	for_each_cpu(cpu, cpumask) {
@@ -210,24 +202,10 @@ fetch_bp_busy_slots(struct bp_busy_slots *slots, struct perf_event *bp,
 		else
 			nr += task_bp_pinned(cpu, bp, type);
 
-		if (nr > slots->pinned)
-			slots->pinned = nr;
-
-		nr = info->flexible;
-		if (nr > slots->flexible)
-			slots->flexible = nr;
+		pinned_slots = max(nr, pinned_slots);
 	}
-}
 
-/*
- * For now, continue to consider flexible as pinned, until we can
- * ensure no flexible event can ever be scheduled before a pinned event
- * in a same cpu.
- */
-static void
-fetch_this_slot(struct bp_busy_slots *slots, int weight)
-{
-	slots->pinned += weight;
+	return pinned_slots;
 }
 
 /*
@@ -298,7 +276,12 @@ __weak void arch_unregister_hw_breakpoint(struct perf_event *bp)
 }
 
 /*
- * Constraints to check before allowing this new breakpoint counter:
+ * Constraints to check before allowing this new breakpoint counter.
+ *
+ * Note: Flexible breakpoints are currently unimplemented, but outlined in the
+ * below algorithm for completeness.  The implementation treats flexible as
+ * pinned due to no guarantee that we currently always schedule flexible events
+ * before a pinned event in a same CPU.
  *
  *  == Non-pinned counter == (Considered as pinned for now)
  *
@@ -340,8 +323,8 @@ __weak void arch_unregister_hw_breakpoint(struct perf_event *bp)
  */
 static int __reserve_bp_slot(struct perf_event *bp, u64 bp_type)
 {
-	struct bp_busy_slots slots = {0};
 	enum bp_type_idx type;
+	int max_pinned_slots;
 	int weight;
 	int ret;
 
@@ -357,15 +340,9 @@ static int __reserve_bp_slot(struct perf_event *bp, u64 bp_type)
 	type = find_slot_idx(bp_type);
 	weight = hw_breakpoint_weight(bp);
 
-	fetch_bp_busy_slots(&slots, bp, type);
-	/*
-	 * Simulate the addition of this breakpoint to the constraints
-	 * and see the result.
-	 */
-	fetch_this_slot(&slots, weight);
-
-	/* Flexible counters need to keep at least one slot */
-	if (slots.pinned + (!!slots.flexible) > hw_breakpoint_slots_cached(type))
+	/* Check if this new breakpoint can be satisfied across all CPUs. */
+	max_pinned_slots = max_bp_pinned_slots(bp, type) + weight;
+	if (max_pinned_slots > hw_breakpoint_slots_cached(type))
 		return -ENOSPC;
 
 	ret = arch_reserve_bp_slot(bp);
-- 
2.37.0.rc0.161.g10f37bed90-goog

