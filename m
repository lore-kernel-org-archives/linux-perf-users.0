Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365031F4198;
	Thu,  1 May 2025 01:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746063302; cv=none; b=A94EWPi3oN4ZX/ytfLGOZEgZaaFv3xezIjctIKOOCskel+KWVaxc20S1Qz1PAuZd7L5mh+KKwPxijTNL8kSmibiL8QKzjssfihzmpWkSbjWE1ABV6VFy3PsGRhMXahlrM5Ag9jf/H2IP2KNjqomn8WD+wIJq7ni+O8DLk2WSVME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746063302; c=relaxed/simple;
	bh=X/vx4KKWuH2bkTg1gjX8otRsxs/yJcM3n5EPW9bZ/+w=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=X04XdJOFO6TwojylLeazKnCKPmfZY9FW1DI/RZHRxdlbPmp6IFI8dHE6rgso4FhlR9R1qRP8S8vvD1odlKYfd54upq/gQ6S4BakLFbnGmfVnkwbjBy2yNM8UBSUqMZubvywyn7AjtwaY9yUI2vxavxJ3VHC6V5LkfZnYsIJmxLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAAD4C4CEE7;
	Thu,  1 May 2025 01:35:01 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uAIpO-00000001omC-2N9A;
	Wed, 30 Apr 2025 21:35:06 -0400
Message-ID: <20250501013506.416759222@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 30 Apr 2025 21:32:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org,
 Mark Brown <broonie@kernel.org>,
 linux-toolchains@vger.kernel.org,
 Jordan Rome <jordalgo@meta.com>,
 Sam James <sam@gentoo.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Florian Weimer <fweimer@redhat.com>,
 Andy Lutomirski <luto@kernel.org>,
 Weinan Liu <wnliu@google.com>,
 Blake Jones <blakejones@google.com>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Alexander Aring <aahringo@redhat.com>
Subject: [PATCH v6 3/5] unwind deferred: Use bitmask to determine which callbacks to call
References: <20250501013202.997535180@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

In order to know which registered callback requested a stacktrace for when
the task goes back to user space, add a bitmask for all registered
tracers. The bitmask is the size of log, which means that on a 32 bit
machine, it can have at most 32 registered tracers, and on 64 bit, it can
have at most 64 registered tracers. This should not be an issue as there
should not be more than 10 (unless BPF can abuse this?).

When a tracer registers with unwind_deferred_init() it will get a bit
number assigned to it. When a tracer requests a stacktrace, it will have
its bit set within the task_struct. When the task returns back to user
space, it will call the callbacks for all the registered tracers where
their bits are set in the task's mask.

When a tracer is removed by the unwind_deferred_cancel() all current tasks
will clear the associated bit, just in case another tracer gets registered
immediately afterward and then gets their callback called unexpectedly.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v5: https://lore.kernel.org/20250424192612.844558089@goodmis.org

- Have unwind_deferred_request() return positive if already queued.

 include/linux/sched.h           |  1 +
 include/linux/unwind_deferred.h |  1 +
 kernel/unwind/deferred.c        | 46 ++++++++++++++++++++++++++++-----
 3 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index a1e1c07cadfb..d3ee0c5405d6 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1649,6 +1649,7 @@ struct task_struct {
 
 #ifdef CONFIG_UNWIND_USER
 	struct unwind_task_info		unwind_info;
+	unsigned long			unwind_mask;
 #endif
 
 	/* CPU-specific state of this task: */
diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index d36784cae658..719a7cfb3164 100644
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -13,6 +13,7 @@ typedef void (*unwind_callback_t)(struct unwind_work *work, struct unwind_stackt
 struct unwind_work {
 	struct list_head		list;
 	unwind_callback_t		func;
+	int				bit;
 };
 
 #ifdef CONFIG_UNWIND_USER
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index d86ea82a8915..716393dff810 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -26,6 +26,7 @@ static DEFINE_PER_CPU(u64, unwind_ctx_ctr);
 /* Guards adding to and reading the list of callbacks */
 static DEFINE_MUTEX(callback_mutex);
 static LIST_HEAD(callbacks);
+static unsigned long unwind_mask;
 
 /*
  * The context cookie is a unique identifier that is assigned to a user
@@ -134,6 +135,7 @@ static void unwind_deferred_task_work(struct callback_head *head)
 	struct unwind_task_info *info = container_of(head, struct unwind_task_info, work);
 	struct unwind_stacktrace trace;
 	struct unwind_work *work;
+	struct task_struct *task = current;
 	u64 cookie;
 
 	if (WARN_ON_ONCE(!info->pending))
@@ -155,7 +157,10 @@ static void unwind_deferred_task_work(struct callback_head *head)
 
 	guard(mutex)(&callback_mutex);
 	list_for_each_entry(work, &callbacks, list) {
-		work->func(work, &trace, cookie);
+		if (task->unwind_mask & (1UL << work->bit)) {
+			work->func(work, &trace, cookie);
+			clear_bit(work->bit, &current->unwind_mask);
+		}
 	}
 	barrier();
 	/* If another task work is pending, reuse the cookie and stack trace */
@@ -193,9 +198,12 @@ static int unwind_deferred_request_nmi(struct unwind_work *work, u64 *cookie)
 		*cookie = info->nmi_cookie;
 	}
 
-	if (info->pending)
+	if (current->unwind_mask & (1UL << work->bit))
 		return 1;
 
+	if (info->pending)
+		goto out;
+
 	ret = task_work_add(current, &info->work, TWA_NMI_CURRENT);
 	if (ret) {
 		if (inited_cookie)
@@ -204,8 +212,8 @@ static int unwind_deferred_request_nmi(struct unwind_work *work, u64 *cookie)
 	}
 
 	info->pending = 1;
-
-	return 0;
+out:
+	return test_and_set_bit(work->bit, &current->unwind_mask);
 }
 
 /*
@@ -245,14 +253,18 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
 
 	*cookie = get_cookie(info);
 
+	/* This is already queued */
+	if (current->unwind_mask & (1UL << work->bit))
+		return 1;
+
 	/* callback already pending? */
 	pending = READ_ONCE(info->pending);
 	if (pending)
-		return 1;
+		goto out;
 
 	/* Claim the work unless an NMI just now swooped in to do so. */
 	if (!try_cmpxchg(&info->pending, &pending, 1))
-		return 1;
+		goto out;
 
 	/* The work has been claimed, now schedule it. */
 	ret = task_work_add(current, &info->work, TWA_RESUME);
@@ -261,16 +273,27 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
 		return ret;
 	}
 
-	return 0;
+ out:
+	return test_and_set_bit(work->bit, &current->unwind_mask);
 }
 
 void unwind_deferred_cancel(struct unwind_work *work)
 {
+	struct task_struct *g, *t;
+
 	if (!work)
 		return;
 
 	guard(mutex)(&callback_mutex);
 	list_del(&work->list);
+
+	clear_bit(work->bit, &unwind_mask);
+
+	guard(rcu)();
+	/* Clear this bit from all threads */
+	for_each_process_thread(g, t) {
+		clear_bit(work->bit, &t->unwind_mask);
+	}
 }
 
 int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
@@ -278,6 +301,14 @@ int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
 	memset(work, 0, sizeof(*work));
 
 	guard(mutex)(&callback_mutex);
+
+	/* See if there's a bit in the mask available */
+	if (unwind_mask == ~0UL)
+		return -EBUSY;
+
+	work->bit = ffz(unwind_mask);
+	unwind_mask |= 1UL << work->bit;
+
 	list_add(&work->list, &callbacks);
 	work->func = func;
 	return 0;
@@ -289,6 +320,7 @@ void unwind_task_init(struct task_struct *task)
 
 	memset(info, 0, sizeof(*info));
 	init_task_work(&info->work, unwind_deferred_task_work);
+	task->unwind_mask = 0;
 }
 
 void unwind_task_free(struct task_struct *task)
-- 
2.47.2


