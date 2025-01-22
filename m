Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B9E1EEA3C;
	Wed, 22 Jan 2025 02:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737513142; cv=none; b=VSeqn8A0clec+LDHFQHVeyydCNknn9cch/uQGwuAUb6b6/YkRmye5Esczu7SNoo7u6ALZHy3PMDK5jbRS6kYipT+VRenYE60ywaYGGdFgzkjynrudYBlFHp7yN0fijcqNYlGJvityGqkfR16YV3SxgUi1ALODczxW3IzlnC/x9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737513142; c=relaxed/simple;
	bh=GD6lqqKJhzejsQBKB5JdzkZAwfNOtyH5yqbgfZgTnVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RWlAhiOGvVB+4Yq67pgU1emMMxhV66JKkyKBWozUN8EIdFqjmVEwz02nYmfA9FahdQCSPl8ScCaCJp+Zc68hLCc/GMpyQsrr2kigt2OtqNe0EgxQPenOKgtQ8P5M0MKCZ8M0PKZDATuOWGmPK1qR9cYAVfwuZ755lhxRlTeECCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byQelMJ8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byQelMJ8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE48C4CEE5;
	Wed, 22 Jan 2025 02:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737513142;
	bh=GD6lqqKJhzejsQBKB5JdzkZAwfNOtyH5yqbgfZgTnVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=byQelMJ8J6c1cMq41ntcn63Eir36brW/eyI4TAb+TjIH6oLbgnflsZTs/60GXulKs
	 5yarE7zAP/sHT8J/MjdtdTFyrIR1Vw5/BusCBQE3RV6ePLTbkhd6TVDF6wUMNR2JkA
	 4R2xn/0/vyxpY09EJfy1I7Cj8kPYjsaCRbHiBTnGUIj6cJHMWjC2az2SDrZv0xa7zI
	 bKCbwjMqMGgqUMpRVuhtH7rp/vSOBvcAhgltuR3WhdSea042vvJGHN31AyrAWBGBFd
	 +NiXA+RjK+tSlxHBIx/eN+UfjkKjVpBZblHYfAYQGWPhPsbKT/fAW/aV7w7P/xsZMG
	 9X3/grvMFDIBg==
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
Subject: [PATCH v4 29/39] unwind_user/deferred: Add unwind cache
Date: Tue, 21 Jan 2025 18:31:21 -0800
Message-ID: <51855c0902486060cd6e1ccc6b22fd092a2e676d.1737511963.git.jpoimboe@kernel.org>
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

Cache the results of the unwind to ensure the unwind is only performed
once, even when called by multiple tracers.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/linux/unwind_deferred_types.h |  8 +++++++-
 kernel/unwind/deferred.c              | 26 ++++++++++++++++++++------
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
index 9749824aea09..6f71a06329fb 100644
--- a/include/linux/unwind_deferred_types.h
+++ b/include/linux/unwind_deferred_types.h
@@ -2,8 +2,14 @@
 #ifndef _LINUX_UNWIND_USER_DEFERRED_TYPES_H
 #define _LINUX_UNWIND_USER_DEFERRED_TYPES_H
 
-struct unwind_task_info {
+struct unwind_cache {
 	unsigned long		*entries;
+	unsigned int		nr_entries;
+	u64			cookie;
+};
+
+struct unwind_task_info {
+	struct unwind_cache	cache;
 	u64			cookie;
 };
 
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index f0dbe4069247..2f38055cce48 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -56,6 +56,7 @@ static void unwind_deferred_task_work(struct callback_head *head)
 {
 	struct unwind_work *work = container_of(head, struct unwind_work, work);
 	struct unwind_task_info *info = &current->unwind_info;
+	struct unwind_cache *cache = &info->cache;
 	struct unwind_stacktrace trace;
 	u64 cookie;
 
@@ -73,17 +74,30 @@ static void unwind_deferred_task_work(struct callback_head *head)
 	if (!current->mm)
 		goto do_callback;
 
-	if (!info->entries) {
-		info->entries = kmalloc(UNWIND_MAX_ENTRIES * sizeof(long),
-					GFP_KERNEL);
-		if (!info->entries)
+	if (!cache->entries) {
+		cache->entries = kmalloc(UNWIND_MAX_ENTRIES * sizeof(long),
+					 GFP_KERNEL);
+		if (!cache->entries)
 			goto do_callback;
 	}
 
-	trace.entries = info->entries;
+	trace.entries = cache->entries;
+
+	if (cookie == cache->cookie) {
+		/*
+		 * The user stack has already been previously unwound in this
+		 * entry context.  Skip the unwind and use the cache.
+		 */
+		trace.nr = cache->nr_entries;
+		goto do_callback;
+	}
+
 	trace.nr = 0;
 	unwind_user(&trace, UNWIND_MAX_ENTRIES);
 
+	cache->cookie = cookie;
+	cache->nr_entries = trace.nr;
+
 do_callback:
 	work->func(work, &trace, cookie);
 	work->pending = 0;
@@ -174,5 +188,5 @@ void unwind_task_free(struct task_struct *task)
 {
 	struct unwind_task_info *info = &task->unwind_info;
 
-	kfree(info->entries);
+	kfree(info->cache.entries);
 }
-- 
2.48.1

