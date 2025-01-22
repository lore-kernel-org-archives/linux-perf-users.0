Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33601F7577;
	Wed, 22 Jan 2025 02:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737513143; cv=none; b=n5AOIss93CXtXWpywT8BeoSitBZ0wtVEuz5Oniu/LOapukc7KfayahXvAj+LlL3nW5axKBwePtSKFYsNVApUGoW1apbUKGiPi8HI755olC+ALWZWAKep6AxiqrpyHLst6OhlJ+Pb0BtKANCk75xRW/p3M/7LyOsR+kG1oTPihR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737513143; c=relaxed/simple;
	bh=PQu+wKfIIEYE7EgISh+KBFyzxaRDx69Xi4f1BqfJyYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MGlbU/o0Xl5W2ahSXODMrx2MzL/UWWHJwh/GV27aSY0gssnx2g5HkvilZXKYRPYQmQXOeIjBdtExUzE22MuWggZ3UOktsRrq3BsRGDlHt3TZHahfriu2tgc9cgALdQyzYuUdpNCWw/ysjQJsXaPXBrwgBlMr+TcZ/jg4RUQNOF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+qatnsd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+qatnsd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADA7C4CEE4;
	Wed, 22 Jan 2025 02:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737513143;
	bh=PQu+wKfIIEYE7EgISh+KBFyzxaRDx69Xi4f1BqfJyYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r+qatnsddBSQqDToUlQUSWzBO5yXfBN4UPBs0l83zSKm8UiMw8FCVD2bflCzUfddX
	 m97qMEY4elziNFmcU2EVxxBdWGoKX3ibzY8ST4Ks4cMiPPjROFRTsdsVmCckZaHlCd
	 P70iRg2PukQ7Lp1WmzSfKed789yb0WEXDqau0Hs9qYekgsSmUQVWFbHsqdGKao4gyO
	 p4vgabqdo+LwPnOxKm6ExA4nN72/v8rWwR0QTae/c9PG+8dGqInxoINnytUPASad6c
	 Hy3krac//d1ynoMLmDzhhBc84fHdiWlIptq9QVH7l6cZttM5JFx7B59KG/lyxSREQJ
	 bBLNd8MLaTUAg==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
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
	linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: [PATCH v4 30/39] unwind_user/deferred: Make unwind deferral requests NMI-safe
Date: Tue, 21 Jan 2025 18:31:22 -0800
Message-ID: <4ea47a9238cb726614f36a0aad2a545816442e57.1737511963.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1737511963.git.jpoimboe@kernel.org>
References: <cover.1737511963.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make unwind_deferred_request() NMI-safe so tracers in NMI context can
call it to get the cookie immediately rather than have to do the fragile
"schedule irq work and then call unwind_deferred_request()" dance.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/linux/entry-common.h          |   1 +
 include/linux/unwind_deferred.h       |   6 ++
 include/linux/unwind_deferred_types.h |   1 +
 kernel/unwind/deferred.c              | 106 ++++++++++++++++++++++----
 4 files changed, 98 insertions(+), 16 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index fb2b27154fee..e9b8c145f480 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -363,6 +363,7 @@ static __always_inline void exit_to_user_mode(void)
 	lockdep_hardirqs_on_prepare();
 	instrumentation_end();
 
+	unwind_exit_to_user_mode();
 	user_enter_irqoff();
 	arch_exit_to_user_mode();
 	lockdep_hardirqs_on(CALLER_ADDR0);
diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index 741f409f0d1f..22269f4d2392 100644
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -30,6 +30,11 @@ static __always_inline void unwind_enter_from_user_mode(void)
 	current->unwind_info.cookie = 0;
 }
 
+static __always_inline void unwind_exit_to_user_mode(void)
+{
+	current->unwind_info.cookie = 0;
+}
+
 #else /* !CONFIG_UNWIND_USER */
 
 static inline void unwind_task_init(struct task_struct *task) {}
@@ -40,6 +45,7 @@ static inline int unwind_deferred_request(struct task_struct *task, struct unwin
 static inline bool unwind_deferred_cancel(struct task_struct *task, struct unwind_work *work) { return false; }
 
 static inline void unwind_enter_from_user_mode(void) {}
+static inline void unwind_exit_to_user_mode(void) {}
 
 #endif /* !CONFIG_UNWIND_USER */
 
diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
index 6f71a06329fb..c535cca6534b 100644
--- a/include/linux/unwind_deferred_types.h
+++ b/include/linux/unwind_deferred_types.h
@@ -11,6 +11,7 @@ struct unwind_cache {
 struct unwind_task_info {
 	struct unwind_cache	cache;
 	u64			cookie;
+	u64			nmi_cookie;
 };
 
 #endif /* _LINUX_UNWIND_USER_DEFERRED_TYPES_H */
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index 2f38055cce48..939c94abaa50 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -29,27 +29,49 @@ static u64 ctx_to_cookie(u64 cpu, u64 ctx)
 
 /*
  * Read the task context cookie, first initializing it if this is the first
- * call to get_cookie() since the most recent entry from user.
+ * call to get_cookie() since the most recent entry from user.  This has to be
+ * done carefully to coordinate with unwind_deferred_request_nmi().
  */
 static u64 get_cookie(struct unwind_task_info *info)
 {
 	u64 ctx_ctr;
 	u64 cookie;
-	u64 cpu;
 
 	guard(irqsave)();
 
-	cookie = info->cookie;
+	cookie = READ_ONCE(info->cookie);
 	if (cookie)
 		return cookie;
 
+	ctx_ctr = __this_cpu_read(unwind_ctx_ctr);
 
-	cpu = raw_smp_processor_id();
-	ctx_ctr = __this_cpu_inc_return(unwind_ctx_ctr);
-	info->cookie = ctx_to_cookie(cpu, ctx_ctr);
+	/* Read ctx_ctr before info->nmi_cookie */
+	barrier();
+
+	cookie = READ_ONCE(info->nmi_cookie);
+	if (cookie) {
+		/*
+		 * This is the first call to get_cookie() since an NMI handler
+		 * first wrote it to info->nmi_cookie.  Sync it.
+		 */
+		WRITE_ONCE(info->cookie, cookie);
+		WRITE_ONCE(info->nmi_cookie, 0);
+		return cookie;
+	}
+
+	/*
+	 * Write info->cookie.  It's ok to race with an NMI here.  The value of
+	 * the cookie is based on ctx_ctr from before the NMI could have
+	 * incremented it.  The result will be the same even if cookie or
+	 * ctx_ctr end up getting written twice.
+	 */
+	cookie = ctx_to_cookie(raw_smp_processor_id(), ctx_ctr + 1);
+	WRITE_ONCE(info->cookie, cookie);
+	WRITE_ONCE(info->nmi_cookie, 0);
+	barrier();
+	__this_cpu_write(unwind_ctx_ctr, ctx_ctr + 1);
 
 	return cookie;
-
 }
 
 static void unwind_deferred_task_work(struct callback_head *head)
@@ -100,7 +122,52 @@ static void unwind_deferred_task_work(struct callback_head *head)
 
 do_callback:
 	work->func(work, &trace, cookie);
-	work->pending = 0;
+	WRITE_ONCE(work->pending, 0);
+}
+
+static int unwind_deferred_request_nmi(struct unwind_work *work, u64 *cookie)
+{
+	struct unwind_task_info *info = &current->unwind_info;
+	bool inited_cookie = false;
+	int ret;
+
+	*cookie = info->cookie;
+	if (!*cookie) {
+		/*
+		 * This is the first unwind request since the most recent entry
+		 * from user.  Initialize the task cookie.
+		 *
+		 * Don't write to info->cookie directly, otherwise it may get
+		 * cleared if the NMI occurred in the kernel during early entry
+		 * or late exit before the task work gets to run.  Instead, use
+		 * info->nmi_cookie which gets synced later by get_cookie().
+		 */
+		if (!info->nmi_cookie) {
+			u64 cpu = raw_smp_processor_id();
+			u64 ctx_ctr;
+
+			ctx_ctr = __this_cpu_inc_return(unwind_ctx_ctr);
+			info->nmi_cookie = ctx_to_cookie(cpu, ctx_ctr);
+
+			inited_cookie = true;
+		}
+
+		*cookie = info->nmi_cookie;
+
+	} else if (work->pending) {
+		return -EEXIST;
+	}
+
+	ret = task_work_add(current, &work->work, TWA_NMI_CURRENT);
+	if (ret) {
+		if (inited_cookie)
+			info->nmi_cookie = 0;
+		return ret;
+	}
+
+	work->pending = 1;
+
+	return 0;
 }
 
 /*
@@ -131,29 +198,36 @@ static void unwind_deferred_task_work(struct callback_head *head)
 int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
 {
 	struct unwind_task_info *info = &current->unwind_info;
+	int pending;
 	int ret;
 
 	*cookie = 0;
 
-	if (WARN_ON_ONCE(in_nmi()))
-		return -EINVAL;
-
 	if (!current->mm || !user_mode(task_pt_regs(current)))
 		return -EINVAL;
 
+	if (in_nmi())
+		return unwind_deferred_request_nmi(work, cookie);
+
 	guard(irqsave)();
 
 	*cookie = get_cookie(info);
 
 	/* callback already pending? */
-	if (work->pending)
+	pending = READ_ONCE(work->pending);
+	if (pending)
 		return -EEXIST;
 
-	ret = task_work_add(current, &work->work, TWA_RESUME);
-	if (WARN_ON_ONCE(ret))
-		return ret;
+	/* Claim the work unless an NMI just now swooped in to do so. */
+	if (!try_cmpxchg(&work->pending, &pending, 1))
+		return -EEXIST;
 
-	work->pending = 1;
+	/* The work has been claimed, now schedule it. */
+	ret = task_work_add(current, &work->work, TWA_RESUME);
+	if (WARN_ON_ONCE(ret)) {
+		WRITE_ONCE(work->pending, 0);
+		return ret;
+	}
 
 	return 0;
 }
-- 
2.48.1

