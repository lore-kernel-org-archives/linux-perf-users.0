Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805E91F758F;
	Thu,  1 May 2025 01:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746063302; cv=none; b=sQHq60rVVi5X815cadhLJz8qYxUNiaDO5+ViWvsn99uW24YLPwJL2gc0IHVSD2WCHZINfx5tGbHSnU78X5WQMptXcUHfhCLu9Z/6p+Lw6XH0rrHrNtH2QGdjjrvJQ/jTFanOOeIAcaaJEmRh2rqBAB+P31UDKz3+/ibTsQFs4EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746063302; c=relaxed/simple;
	bh=g593+XuzQEKQ7TP4igZ61P/wDrXKaJbg8PWTdIUm3W0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=fGSFlfLHEAVLg++9AllZ5to6DX9RD597uzXqA2tUPZ4TrfW+c/OsleqWrc21Bf8HXe7qOZIWJNF32Se1LnIJMtH1P1mr5+YjBplLCZbPu+i4OpTVXptkS94FP/KejeoaQhkz5uvRHOjVuDPlL71ykv265QinJBV46rCOEL/xAMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CBEC4CEF3;
	Thu,  1 May 2025 01:35:01 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uAIpO-00000001omg-33wN;
	Wed, 30 Apr 2025 21:35:06 -0400
Message-ID: <20250501013506.586292205@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 30 Apr 2025 21:32:06 -0400
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
Subject: [PATCH v6 4/5] unwind deferred: Use SRCU unwind_deferred_task_work()
References: <20250501013202.997535180@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Instead of using the callback_mutex to protect the link list of callbacks
in unwind_deferred_task_work(), use SRCU instead. This gets called every
time a task exits that has to record a stack trace that was requested.
This can happen for many tasks on several CPUs at the same time. A mutex
is a bottleneck and can cause a bit of contention and slow down performance.

As the callbacks themselves are allowed to sleep, regular RCU can not be
used to protect the list. Instead use SRCU, as that still allows the
callbacks to sleep and the list can be read without needing to hold the
callback_mutex.

Link: https://lore.kernel.org/all/ca9bd83a-6c80-4ee0-a83c-224b9d60b755@efficios.com/

Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/unwind/deferred.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index 716393dff810..5f98ac5e3a1b 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -23,10 +23,11 @@
  */
 static DEFINE_PER_CPU(u64, unwind_ctx_ctr);
 
-/* Guards adding to and reading the list of callbacks */
+/* Guards adding to or removing from the list of callbacks */
 static DEFINE_MUTEX(callback_mutex);
 static LIST_HEAD(callbacks);
 static unsigned long unwind_mask;
+DEFINE_STATIC_SRCU(unwind_srcu);
 
 /*
  * The context cookie is a unique identifier that is assigned to a user
@@ -137,6 +138,7 @@ static void unwind_deferred_task_work(struct callback_head *head)
 	struct unwind_work *work;
 	struct task_struct *task = current;
 	u64 cookie;
+	int idx;
 
 	if (WARN_ON_ONCE(!info->pending))
 		return;
@@ -155,14 +157,16 @@ static void unwind_deferred_task_work(struct callback_head *head)
 
 	cookie = get_cookie(info);
 
-	guard(mutex)(&callback_mutex);
-	list_for_each_entry(work, &callbacks, list) {
+	idx = srcu_read_lock(&unwind_srcu);
+	list_for_each_entry_srcu(work, &callbacks, list,
+				 srcu_read_lock_held(&unwind_srcu)) {
 		if (task->unwind_mask & (1UL << work->bit)) {
 			work->func(work, &trace, cookie);
 			clear_bit(work->bit, &current->unwind_mask);
 		}
 	}
-	barrier();
+	srcu_read_unlock(&unwind_srcu, idx);
+
 	/* If another task work is pending, reuse the cookie and stack trace */
 	if (!READ_ONCE(info->pending))
 		WRITE_ONCE(info->cookie, 0);
@@ -238,6 +242,7 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
 {
 	struct unwind_task_info *info = &current->unwind_info;
 	int pending;
+	int bit;
 	int ret;
 
 	*cookie = 0;
@@ -249,12 +254,17 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
 	if (in_nmi())
 		return unwind_deferred_request_nmi(work, cookie);
 
+	/* Do not allow cancelled works to request again */
+	bit = READ_ONCE(work->bit);
+	if (WARN_ON_ONCE(bit < 0))
+		return -EINVAL;
+
 	guard(irqsave)();
 
 	*cookie = get_cookie(info);
 
 	/* This is already queued */
-	if (current->unwind_mask & (1UL << work->bit))
+	if (current->unwind_mask & (1UL << bit))
 		return 1;
 
 	/* callback already pending? */
@@ -280,19 +290,26 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
 void unwind_deferred_cancel(struct unwind_work *work)
 {
 	struct task_struct *g, *t;
+	int bit;
 
 	if (!work)
 		return;
 
 	guard(mutex)(&callback_mutex);
-	list_del(&work->list);
+	list_del_rcu(&work->list);
+	bit = work->bit;
+
+	/* Do not allow any more requests and prevent callbacks */
+	work->bit = -1;
+
+	clear_bit(bit, &unwind_mask);
 
-	clear_bit(work->bit, &unwind_mask);
+	synchronize_srcu(&unwind_srcu);
 
 	guard(rcu)();
 	/* Clear this bit from all threads */
 	for_each_process_thread(g, t) {
-		clear_bit(work->bit, &t->unwind_mask);
+		clear_bit(bit, &t->unwind_mask);
 	}
 }
 
@@ -309,7 +326,7 @@ int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
 	work->bit = ffz(unwind_mask);
 	unwind_mask |= 1UL << work->bit;
 
-	list_add(&work->list, &callbacks);
+	list_add_rcu(&work->list, &callbacks);
 	work->func = func;
 	return 0;
 }
-- 
2.47.2


