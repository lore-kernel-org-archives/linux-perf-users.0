Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C844D2BE035
	for <linux-perf-users@vger.kernel.org>; Sat,  3 Oct 2026 20:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791058568; cv=none; b=HAavBTL5/A1jvxwL13AW8aDyAIrXszpEdygdg+v8QpB/Yf27f9gNX44cNNrKnE+IMjap/xiqZkZn6xGZ33vsEKxRqLMDaQQ6FIRcIItIwPfN2urk8knOUEtagPTEXHJlImDRRYcIYgvLzlYWpubejj8XgexYaYL9iA5Fynu1hDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791058568; c=relaxed/simple;
	bh=zARzY+mbFkmmVJGEXnywWuZe7acGYOvz22lzyFcBH68=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aE8+zTzUy4O2yzmUz2vpr9QrR9I9u+FT33c8cLOl2l0r2AAmnoweznMPa4ZxCqiwtvoJL3PnEGZInjy+gz8C/nKfSAQBjWpCCasXu3b+qciO0n+/jgN5A3+mWR0dTPXoUP+TnOqHel+UuBEdHiTPocBMzCwTYdymtH9sw6P1TnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8bLtjIW; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8bLtjIW"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34c0b552ccfso284220eec.3
        for <linux-perf-users@vger.kernel.org>; Sat, 03 Oct 2026 13:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791058566; x=1791663366; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4GI2M8fx0qQ8NKt5KTWS/sQmhJi4Cfn2gB3eMUOApzA=;
        b=l8bLtjIWyawWJLp4Zfi9Frazf4UL7NgQfvlQXw9Nox0cw9DngVbjpOVZKAxn8jRcpn
         i7/azNCdXjMc1o85j32jT1NRuv8GWujDGe24XWMGe1SXLDaG0dWaNZp1FizqTNKQQ/mv
         l/tiQteeosZjteBqM2TieopQVxVZU37Q6H4F3ZYp9YSN40QUglljziSjo6TGa4np374h
         zJCfxFu3t/Yqs/c6EltlT1+H4BmHR3HRqZjRy52EknaIcQVaOK6ktjk0FgLarYq3s7F1
         U5goNIVljeAXH/a1U5N7l7FisqZKu7H4XihR1yXktpG+zgKe3FRxS39RwKVozydodXTZ
         SIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791058566; x=1791663366;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4GI2M8fx0qQ8NKt5KTWS/sQmhJi4Cfn2gB3eMUOApzA=;
        b=cYa7hA5Rur/Ag+aoUC74gjVLhEuDFclwS0iOfCmaQ6szUuNCZ1upEqyZLfbitRGkv1
         4RU/1reCT8OA2DK0poker73ltuw30Os263+o1f0KwxZyryO7cgRvQ452saUJBTYZMKK0
         89IvcNCSOI822EzBLmG5hbqz5OjNukHQiDoSFLW+LZwNy3U7bmbkB98v43G/6bEoXPZt
         O2V5pt2C4T1Q1NMGx5nXH/r4H1kBaR70Uv40xSIyuH4QvGlWrTPUMNzjxIplQlnA/0LX
         B8vTLocmiw7t5jm/lPcUnU9U9Q7lPg3lfxQ18i77GDeBrK2KpRUsn4eDUpJkrgtgZ7mQ
         JDwg==
X-Forwarded-Encrypted: i=1; AKwUvBxCYjzVy10fDmxZkuabxO9euDoa7YH7FD0BDB01EQdPCN4/a+GCL/Q8y0OPaOrWm7H8zUlPt6GPHm1SHyb+tZ0E@vger.kernel.org
X-Gm-Message-State: AFq9FYI7GFRSCjOxjLGEUwMe+trEhSzrykA5Bl0EahB8PoWua6rype0x
	Dg6uHDiIP8BCvf/AZ+cKehGEB1B58VGkYFL75+lvPmRB5+dx8ZNHpkSO
X-Gm-Gg: AYBFou2EyERKW7yaI+sHoTHikkuUWyGpgM8qcGYltjgu0cO7soDXPVyicBTMZ+yOyuX
	0fqAJLilbcBYrEM/bOAZH8vNa914g/sDlB7A5XFIrBxk3IK24pD/XJkDwKa24zTSMRgo6K3fblr
	z264vN+3IOE5L8FGosNe+B7b4aqTpI5ZlDriMTCpDv4ulvFErRcKjiWHaMpb/C5/G9+KCONYYUV
	DH2j5gAURAm0c93BZsocrvZSZHYtbpjdtk7wiCCTi4sXCnZ4mMaXrC+l3CI22HMHipTxpLR+G66
	eCcXrxTX+CS20gDzOymRj1gwo8OEkdeSQQFSA1jDn3MPRWtCIEGvHz+3O6ABvOHrFzkHs9Lf98B
	x28+BbWVrR4LNnPJj8vo/0G1GsYdr9ZZP2fLtrezg8r2vX+WsEEpHf5F7cX40gPu5mMFswZo2K2
	N5fpr+iTtEqYY+XriFjFkGTxu/uoxR+2g0ploY/1Fp3VKqJzof2UZoY5Urp0iKoOR93uYmOQub
X-Received: by 2002:a05:693c:20cb:10b0:342:39f5:f9c5 with SMTP id 5a478bee46e88-34f150c0d72mr7165866eec.18.1791058565480;
        Sat, 03 Oct 2026 13:16:05 -0700 (PDT)
Received: from [127.0.1.1] ([2602:ffe4:407:363:fd57:5fed:bd71:7a74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14f660f1sm17968682eec.13.2026.10.03.13.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 13:16:05 -0700 (PDT)
From: vineash <vineash30640@gmail.com>
To:
 peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org
Cc: kan.liang@linux.intel.com, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, james.clark@linaro.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 [PATCH] perf/core: Fix double put of the system-wide perf_ctx_data reference
Date: Sun, 04 Oct 2026 04:15:26 +0800
Message-ID: <179105852659.1844849.16381123619267169417@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

The reference on a task's perf_ctx_data that belongs to the system-wide
events (cd->global) can be put twice. __detach_global_ctx_data() puts it
when the last system-wide event goes away, and perf_event_exit_task()
puts it again when the task exits. perf_event_exit_task() runs without
global_ctx_data_rwsem and never clears cd->global, so nothing stops both
paths from putting the same reference:

  CPU0                               CPU1 (task T exiting)
  __detach_global_ctx_data()
    cd->global = 0;
    detach_task_ctx_data(T)
      refcount_dec_and_test() == true
                                     perf_event_exit_task(T)
                                       detach_task_ctx_data(T)
                                         cd = T->perf_ctx_data;
                                         // still set: underflow
                                         refcount_dec_and_test()
      try_cmpxchg(&T->perf_ctx_data,
                  &cd, NULL)

This shows up as:

  refcount_t: underflow; use-after-free.
  WARNING: lib/refcount.c:28 at refcount_warn_saturate+0xc9/0x120
   detach_task_ctx_data+0x1db/0x4a0
   do_exit+0x6a9/0x2bb0
   do_group_exit+0xd3/0x2a0
   get_signal+0x266a/0x26d0

When the exit path puts first, the warning comes from
__detach_global_ctx_data(), via perf_release() or via the error path of
perf_event_open().

An unprivileged user can open this window with the default
perf_event_paranoid=2. For a CPU-wide event that requests a branch call
stack, perf_event_alloc() calls attach_perf_ctx_data() before
find_get_context() rejects the event with -EACCES, and the error path
then runs detach_global_ctx_data().

Treat the global reference as a one-shot token. Claim cd->global with
xchg() in both __detach_global_ctx_data() and perf_event_exit_task(), and
put the reference only if the claim succeeded. Also take the reference
before setting cd->global in attach_global_ctx_data() and
perf_event_alloc_task_data(). Otherwise the exit path could put a
reference that has not been taken yet.

perf_event_exit_task() no longer puts the reference of a non-global
perf_ctx_data. That reference belongs to the per-task events, and they
put it when they are freed.

Fixes: 506e64e710ff ("perf: attach/detach PMU specific data")
Assisted-by: Claude:claude-opus-5-5 syzkaller
Signed-off-by: vineash <vineash30640@gmail.com>
---
Notes (not for the commit log):

Found with syzkaller in a QEMU/KVM guest with "-cpu host" (Intel Xeon Gold
5118 host). The guest has a vPMU but no LBR. The trigger works without LBR:
for a counting event with PERF_SAMPLE_READ, intel_pmu_hw_config() skips the
LBR setup, but x86_pmu_hw_config() has already set PERF_ATTACH_TASK_DATA
because of PERF_SAMPLE_BRANCH_CALL_STACK.

Tested on next-20261002 (x86_64, syzbot's upstream-apparmor-kasan config):
- without this patch: the syzkaller reproducer (root) hit the underflow
  in 2 of 2 runs (after 103 s and 288 s). A small reproducer running as
  uid 65534 with perf_event_paranoid=2 hit it in 2 of 3 runs (after 333 s
  and 376 s). The third run lasted 900 s and made ~2M perf_event_open()
  calls without a hit.
- with a debug patch that records the last decrement, the second put came
  from do_exit() 0.49 ms after __detach_global_ctx_data() on another
  task had put the same reference (old refcount 1).
- with this patch: no warning in 7 runs per reproducer (3 x 15 min and
  4 x 20 min). The unprivileged runs made 0.84-0.93M rejected
  perf_event_open() calls each, ~6.2M in total.
- not tested: hardware with real LBR call stacks, and kmemleak.

Unrelated to the fix, but this is what opens the window for unprivileged
users: attach_global_ctx_data() takes global_ctx_data_rwsem for write and
allocates perf_ctx_data for every thread in the system before the
perf_allow_cpu() check in find_get_context() rejects the event. It may be
worth doing that check before perf_event_alloc() for CPU-wide events.

A C reproducer is available on request.

 kernel/events/core.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index a34ff4cb4..63122c3b8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5498,8 +5498,9 @@ attach_global_ctx_data(struct kmem_cache *ctx_cache)
 				continue;
 			cd = rcu_dereference(p->perf_ctx_data);
 			if (cd && !cd->global) {
-				cd->global = 1;
-				if (!refcount_inc_not_zero(&cd->refcount))
+				if (refcount_inc_not_zero(&cd->refcount))
+					cd->global = 1;
+				else
 					cd = NULL;
 			}
 			if (!cd) {
@@ -5569,19 +5570,33 @@ detach_task_ctx_data(struct task_struct *p)
 		perf_free_ctx_data_rcu(cd);
 }
 
+/*
+ * Drop the reference owned by the system-wide events, if @p still holds one.
+ *
+ * Both __detach_global_ctx_data() and perf_event_exit_task() may try to drop
+ * it concurrently; claiming ->global with xchg() makes sure only one of them
+ * does, otherwise the refcount is decremented twice.
+ */
+static void detach_task_global_ctx_data(struct task_struct *p)
+{
+	struct perf_ctx_data *cd;
+
+	scoped_guard (rcu) {
+		cd = rcu_dereference(p->perf_ctx_data);
+		if (!cd || !xchg(&cd->global, 0))
+			return;
+	}
+
+	detach_task_ctx_data(p);
+}
+
 static void __detach_global_ctx_data(void)
 {
 	struct task_struct *g, *p;
-	struct perf_ctx_data *cd;
 
 	scoped_guard (rcu) {
-		for_each_process_thread(g, p) {
-			cd = rcu_dereference(p->perf_ctx_data);
-			if (cd && cd->global) {
-				cd->global = 0;
-				detach_task_ctx_data(p);
-			}
-		}
+		for_each_process_thread(g, p)
+			detach_task_global_ctx_data(p);
 	}
 }
 
@@ -9459,8 +9474,8 @@ perf_event_alloc_task_data(struct task_struct *child,
 		}
 
 		if (!cd->global) {
-			cd->global = 1;
 			refcount_inc(&cd->refcount);
+			cd->global = 1;
 		}
 	}
 
@@ -14901,7 +14916,7 @@ void perf_event_exit_task(struct task_struct *task)
 	 * attach_global_ctx_data() will skip over this task, but otherwise
 	 * attach_task_ctx_data() will observe PF_EXITING.
 	 */
-	detach_task_ctx_data(task);
+	detach_task_global_ctx_data(task);
 }
 
 /*
-- 
2.25.1

