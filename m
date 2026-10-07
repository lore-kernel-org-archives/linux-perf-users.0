Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F21430CCA
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Oct 2026 17:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791392958; cv=none; b=JGvJzLAnwoaCxnZaAwBonGEH/PAT2rfCpZNiPqMNxY2bWlQn9925k8r6PSdhhB5eHPU2r0i1hVbEPHsp8MpfoRx2uFIJ7zdL/Verw7pLCpKEOKLyqGTzX76j2fGq9UgncgIJer5NVIo71mEm8lMoDFMwxlGs9IttYrDIve69mWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791392958; c=relaxed/simple;
	bh=Up2+48gQIDhv1GVocYfuchoari9m++oMyFYjjhkde6U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=e4ycojtIwiFqCQpccPwgPDjgISrYshtPC4TKsoKZdmeEFA4tlzRijV1wjAjNhpCKBqBEujQea+d/LCbYOl5i92Dp+G8jQZ1tsNoqa/MY4K4P7vvPGYfrPBKqYt7n0FLfKRM16ns41VlN8ow8zK6f4bo2B6K1F7ilJBVvYxAilsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYNE9iht; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYNE9iht"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ca12086c06eso1203743a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Oct 2026 10:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791392955; x=1791997755; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9qisrSG06fr32K9n7D91imi7L0ftpnSuohblQxn5SCk=;
        b=UYNE9ihtzrnEqH2MT40TuX3FpsjYuTaldUCTvtuh+VQJoyw5I7sarb0C8EQnaXRQzM
         o0KqLHkynYsXeiZgXzUA78BN/J5Pp+lECh93bhX/Nxs3Q1ZZBKAic7pX9l9hhqWmQPN3
         48rPT9jYECBcf/YMPz1iht809JykS6IRCNfYQLVYQ+YM/fF15FUZzLDdP3D++o7pTFcf
         3fH2Wg1pcWdrTbQBcPH1AFhO6V5ahFvTPQgkeuYIu302cGn5xFh4XZYhi4+afC1Lw1fO
         bWMcMPYkcuIY7dz7/DJ2dJuWat+agWAHClRt1xgW0t5awOUGRRK4T3zA7szU96zOV0YB
         KMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791392955; x=1791997755;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9qisrSG06fr32K9n7D91imi7L0ftpnSuohblQxn5SCk=;
        b=eIuZto8gWb4/NjQ5pgv0WRlNszrmyZP9WOLbtgXI46EP9uJGm1rEI2pfes2pCX6ecL
         RQz+zKsddFMCg84ErgS6RcJLII2lz074nZ3j97FsqNA0nQEuJvRdfYAVW9EFq81Y3yJD
         vifNpYYN6jhhxnKq/8GLqPYiMa6lo8X7/t/u9N2mgEM0yc9QcVDo7bOJ37o4Fk3Dj5ee
         jVmXBHTp52+b68P/c8NotnjFfwQsOS0gcNFBKvUiyzTaUzaEetE+QovTxJ7ZjpF/eDF/
         93ObGYpmzzl75m3Aj6Sgs01ELR0pMel12BQbI+nKQ0Vr5ztOkHwZkRY+YHCEBvg1m8Ew
         BzFQ==
X-Forwarded-Encrypted: i=1; AKwUvBzNmBEKb+apP7BAgxqL5uBA7VTqLSDW/AI3zKa6kONA48ADUhtfdWpVBhE2nj5DmMEL8zlH4GJ6Tqu7uDefJM4S@vger.kernel.org
X-Gm-Message-State: AFq9FYJboj56mvLkYGRDFovFbpv/5I652ovodqAGnUcIwxWJ6/9w4PpC
	P3FrP0RvO0MHqez1dUhhECEoC0vdRsYItZq65BW2tiQPurPzGkwNWQkk
X-Gm-Gg: AYBFou0AgKIqCFrh84Q4s9VmffuEnrHfbNtEsbyS6CfZNaIFcWrNQH95mFlrKVGhaUx
	GC93NTrIvexdsH/q3Cw2kaWv7KC0eINxeDjACbNqrBpeoWRyreyPxfXDmDtW+PnFWotiHpiyuOC
	OtC40+HwNFqFsQ/kM1B9e7YLy4EfcQQr37mLc247+cS6gckkohHxfLCw0sgDOVJaYeWb44uSEsJ
	mvVliY7qfxuVIOF06AJmY5wIPADKuofBkEKtLBGUtCwj2l9OqEcwIddTZ8XVWkMNf5QBRE5eZ47
	kELsQEsAVC8b5zMk6Qdf0tCRs7ark2yzCfGujYb3NgMVb3Usw3sRuYfNZPYcjhuTQiBR8smcRSh
	Fmql3qJK2jqeXyaqMvwzplJE0HdiZMxluclVP694DuX8DQQBDGvYmT3U+3MEQ1p3FFclJoD7EGA
	t/jcYmtHK+rRHIE7e9IxNRQo5E8gSoxG95qVMrsqad9nkzM6vGwVurkMzPoCH1JdIj1PB1Z5Lya
	Q==
X-Received: by 2002:a17:90b:5903:b0:3a6:d851:21e5 with SMTP id 98e67ed59e1d1-3a89f64976dmr2348538a91.4.1791392954916;
        Wed, 07 Oct 2026 10:09:14 -0700 (PDT)
Received: from [127.0.1.1] ([2602:ffe4:407:394:fbc8:92d6:904c:5de9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9ff7ab32bsm297405a91.3.2026.10.07.10.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 10:09:14 -0700 (PDT)
From: vineash <vineash30640@gmail.com>
To:
 peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org
Cc: kan.liang@linux.intel.com, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, james.clark@linaro.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf/core: Fix double put of the system-wide perf_ctx_data
 reference
Date: Thu, 08 Oct 2026 01:08:32 +0800
Message-ID: <179139291278.1120510.13167877618594247003@gmail.com>
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

attach_global_ctx_data() checks PF_EXITING without anything that keeps
the task from exiting right after the check. If perf_event_exit_task()
then looks at cd->global before the attach side sets it, nobody puts the
global reference and the perf_ctx_data leaks once the task is gone. The
reuse path in attach_task_ctx_data() has the same problem. Set ->global
with xchg() in both places and check PF_EXITING again afterwards; if the
task is exiting, claim ->global back and put the reference. The exit
path sets PF_EXITING before its xchg(), and both xchg() calls are fully
ordered, so at least one side sees the other and exactly one of them
puts the reference.

perf_event_exit_task() no longer puts the reference of a non-global
perf_ctx_data. That reference belongs to the per-task events, and they
put it when they are freed.

Fixes: 506e64e710ff ("perf: attach/detach PMU specific data")
Assisted-by: Claude:claude-opus-5-5 syzkaller
Signed-off-by: vineash <vineash30640@gmail.com>
---
Changes in v2:
- Close the race between attach_global_ctx_data() and an exiting task
  that the Sashiko review pointed out. The new helper
  attach_task_global_ctx_data() sets ->global with xchg() and checks
  PF_EXITING again; the reuse path in attach_task_ctx_data() had the
  same problem and now uses it too.
- Read cd->global with READ_ONCE() in attach_global_ctx_data(); the
  stores now go through xchg(), so they no longer race with the exit
  path as plain accesses.
- perf_event_alloc_task_data() is unchanged. It runs from
  perf_event_fork() before wake_up_new_task(), so the child cannot be in
  perf_event_exit_task() yet, and it holds global_ctx_data_rwsem for
  read, which keeps __detach_global_ctx_data() and
  attach_global_ctx_data() away from that child's cd->global.

v1: https://lore.kernel.org/all/179105852659.1844849.16381123619267169417@gmail.com/

Tested on next-20261002 (x86_64, KASAN and kmemleak) with the syzkaller
reproducer (15 minutes, about 63k programs) and the unprivileged one
(15 minutes, about 185k rejected perf_event_open() calls racing with
fork and exit): no warnings, and kmemleak finds nothing.

The race fixed in v2 is too narrow to hit in a plain run, so I also
tested it with an mdelay(50) added right after the PF_EXITING check in
attach_global_ctx_data() (debug only). The test keeps a child's
perf_ctx_data alive with a per-task event, opens a CPU-wide event, and
lets the child exit while the attach is in that window; 100 rounds, with
the exit timing swept so that about 80 rounds land in the window:

  v1 + delay: 49 perf_ctx_data leaked (kmemleak)
  v2 + delay:  0 leaked, no warnings

This only covers attach_global_ctx_data(); the reuse path in
attach_task_ctx_data() gets the same helper but is not exercised here.

 kernel/events/core.c | 66 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 15 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index a34ff4cb4..cc187cf9b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5422,6 +5422,27 @@ static inline void perf_free_ctx_data_rcu(struct perf_ctx_data *cd)
 	call_rcu(&cd->rcu_head, __free_perf_ctx_data_rcu);
 }
 
+static void detach_task_global_ctx_data(struct task_struct *p);
+
+/*
+ * Hand a reference on @cd, which the caller already holds, to the
+ * system-wide events.
+ *
+ * perf_event_exit_task() drops that reference only if it finds ->global set,
+ * and it does not take global_ctx_data_rwsem. If @p started exiting after
+ * the caller checked PF_EXITING, the exit path may already have looked at
+ * ->global. Both xchg() calls are fully ordered, so either the exit path
+ * sees ->global set or we see PF_EXITING here; whoever clears ->global then
+ * puts the reference.
+ */
+static void attach_task_global_ctx_data(struct task_struct *p,
+					struct perf_ctx_data *cd)
+{
+	xchg(&cd->global, 1);
+	if (READ_ONCE(p->flags) & PF_EXITING)
+		detach_task_global_ctx_data(p);
+}
+
 static int
 attach_task_ctx_data(struct task_struct *task, struct kmem_cache *ctx_cache,
 		     bool global, gfp_t gfp_flags)
@@ -5459,9 +5480,9 @@ attach_task_ctx_data(struct task_struct *task, struct kmem_cache *ctx_cache,
 		}
 
 		if (refcount_inc_not_zero(&old->refcount)) {
-			if (global)
-				old->global = true;
 			free_perf_ctx_data(cd); /* unused */
+			if (global)
+				attach_task_global_ctx_data(task, old);
 			return 0;
 		}
 
@@ -5497,9 +5518,10 @@ attach_global_ctx_data(struct kmem_cache *ctx_cache)
 			if (p->flags & PF_EXITING)
 				continue;
 			cd = rcu_dereference(p->perf_ctx_data);
-			if (cd && !cd->global) {
-				cd->global = 1;
-				if (!refcount_inc_not_zero(&cd->refcount))
+			if (cd && !READ_ONCE(cd->global)) {
+				if (refcount_inc_not_zero(&cd->refcount))
+					attach_task_global_ctx_data(p, cd);
+				else
 					cd = NULL;
 			}
 			if (!cd) {
@@ -5569,19 +5591,33 @@ detach_task_ctx_data(struct task_struct *p)
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
 
@@ -9459,8 +9495,8 @@ perf_event_alloc_task_data(struct task_struct *child,
 		}
 
 		if (!cd->global) {
-			cd->global = 1;
 			refcount_inc(&cd->refcount);
+			cd->global = 1;
 		}
 	}
 
@@ -14901,7 +14937,7 @@ void perf_event_exit_task(struct task_struct *task)
 	 * attach_global_ctx_data() will skip over this task, but otherwise
 	 * attach_task_ctx_data() will observe PF_EXITING.
 	 */
-	detach_task_ctx_data(task);
+	detach_task_global_ctx_data(task);
 }
 
 /*
-- 
2.25.1

