Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FD13D386
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 22:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JJ9VzC3b"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8244E1FD4
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:24:51 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9cfec5e73dso4928549276.2
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186286; x=1698791086; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WajoJckjAi5zxZaorb4dU2uWdDAXIk6mTnY41FG9EXU=;
        b=JJ9VzC3bW43Azd5O2n6Of+NyrZ7Bb+RhUyU1rR3kznMY8YaBvpibNk77LFITLir0nC
         QUUq2cHXp5lAVByKtm2FPdnS3H61QBYhW3QyrNJkfdBiQtkEhaXZt63lmkiBGCooeq8i
         o6x1PEmm0/0b9AU/IdeQBlUWbT+WI2JtWKjFME+dKrIbYuKDhct8LlAOxzVF/HXP3gqt
         ucgspgiO9BqrQGG2VNBNd8JBohe3YWiLmHRNj8XwIUZ/RAdLVFVwlOFO7Qw70fUEfDT9
         /fvYK0LHOSC9KgQlxb89RDWK+dSRVhlUnCG3OroUqxmEstbXfjhVjRipx2uVt8VwcKbl
         XtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186286; x=1698791086;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WajoJckjAi5zxZaorb4dU2uWdDAXIk6mTnY41FG9EXU=;
        b=bD2ZVRk9DMhzNc72Q8mULGrHkRgnM3unXSMiMg1ZMLA3ryDsgJplxlk5sn8RcGRwFg
         Gm0lUW7dgFfKABVuujSH3QmV2lxDXWSfSZrg7Kd2aMBeBQIOGnZ295keVx406eoZf1Ql
         dFZNtihTLJBZKQ2RRrzytn7NZpqyvq9tIEorLvq0PqW6cgAYcR5NGzRQefW2hhJl717q
         USD9lbi7ja5Nps9XKl+W1PRPglO5lcC9rk4jJKgKFTIQOVkQLS4m6bm9BHI60QJkwiAF
         hz3BwsA/RBjw5DUKhco+5wsRlOeqb4R+pTwpV2A/IUaQSUvsLJT1EMj2NgF7Ot/uy5zt
         XfOA==
X-Gm-Message-State: AOJu0Yz5v5gRiRPLYVKQwVYUCC2lPZEgsWYG0FUvVeQQU7+FhpoUpc/M
	2eF8yJtcc5cZm9B3H7qBq42mWYd0HdLX
X-Google-Smtp-Source: AGHT+IGdsWaxHw9CjDKm+xTm6UJwh6OhSH7496eT1hX0iNXyq3wv5uZFz5DOt5uWHtv4+jubFfcppt830mx9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a05:6902:1083:b0:d9a:47ea:69a5 with SMTP
 id v3-20020a056902108300b00d9a47ea69a5mr366410ybu.1.1698186286686; Tue, 24
 Oct 2023 15:24:46 -0700 (PDT)
Date: Tue, 24 Oct 2023 15:23:18 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-16-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 15/50] perf machine thread: Remove exited threads by default
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Leo Yan <leo.yan@linaro.org>, Song Liu <song@kernel.org>, 
	Sandipan Das <sandipan.das@amd.com>, James Clark <james.clark@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	German Gomez <german.gomez@arm.com>, Changbin Du <changbin.du@huawei.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

struct thread values hold onto references to mmaps, dsos, etc. When a
thread exits it is necessary to clean all of this memory up by
removing the thread from the machine's threads. Some tools require
this doesn't happen, such as auxtrace events, perf report if offcpu
events exist or if a task list is being generated, so add a
symbol_conf value to make the behavior optional. When an exited thread
is left in the machine's threads, mark it as exited.

This change relates to commit 40826c45eb0b ("perf thread: Remove
notion of dead threads"). Dead threads were removed as they had a
reference count of 0 and were difficult to reason about with the
reference count checker. Here a thread is removed from threads when it
exits, unless via symbol_conf the exited thread isn't remove and is
marked as exited. Reference counting behaves as it normally does.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-report.c   |  7 +++++++
 tools/perf/util/machine.c     | 10 +++++++---
 tools/perf/util/session.c     |  5 +++++
 tools/perf/util/symbol_conf.h |  3 ++-
 tools/perf/util/thread.h      | 14 ++++++++++++++
 5 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index dcedfe00f04d..749246817aed 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1411,6 +1411,13 @@ int cmd_report(int argc, const char **argv)
 	if (ret < 0)
 		goto exit;
 
+	/*
+	 * tasks_mode require access to exited threads to list those that are in
+	 * the data file. Off-cpu events are synthesized after other events and
+	 * reference exited threads.
+	 */
+	symbol_conf.keep_exited_threads = true;
+
 	annotation_options__init(&report.annotation_opts);
 
 	ret = perf_config(report__config, &report);
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 90c750150b19..a985d004aa8d 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2157,9 +2157,13 @@ int machine__process_exit_event(struct machine *machine, union perf_event *event
 	if (dump_trace)
 		perf_event__fprintf_task(event, stdout);
 
-	if (thread != NULL)
-		thread__put(thread);
-
+	if (thread != NULL) {
+		if (symbol_conf.keep_exited_threads)
+			thread__set_exited(thread, /*exited=*/true);
+		else
+			machine__remove_thread(machine, thread);
+	}
+	thread__put(thread);
 	return 0;
 }
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 1e9aa8ed15b6..c6afba7ab1a5 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -115,6 +115,11 @@ static int perf_session__open(struct perf_session *session, int repipe_fd)
 		return -1;
 	}
 
+	if (perf_header__has_feat(&session->header, HEADER_AUXTRACE)) {
+		/* Auxiliary events may reference exited threads, hold onto dead ones. */
+		symbol_conf.keep_exited_threads = true;
+	}
+
 	if (perf_data__is_pipe(data))
 		return 0;
 
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index 2b2fb9e224b0..6040286e07a6 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -43,7 +43,8 @@ struct symbol_conf {
 			disable_add2line_warn,
 			buildid_mmap2,
 			guest_code,
-			lazy_load_kernel_maps;
+			lazy_load_kernel_maps,
+			keep_exited_threads;
 	const char	*vmlinux_name,
 			*kallsyms_name,
 			*source_prefix,
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index e79225a0ea46..0df775b5c110 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -36,13 +36,22 @@ struct thread_rb_node {
 };
 
 DECLARE_RC_STRUCT(thread) {
+	/** @maps: mmaps associated with this thread. */
 	struct maps		*maps;
 	pid_t			pid_; /* Not all tools update this */
+	/** @tid: thread ID number unique to a machine. */
 	pid_t			tid;
+	/** @ppid: parent process of the process this thread belongs to. */
 	pid_t			ppid;
 	int			cpu;
 	int			guest_cpu; /* For QEMU thread */
 	refcount_t		refcnt;
+	/**
+	 * @exited: Has the thread had an exit event. Such threads are usually
+	 * removed from the machine's threads but some events/tools require
+	 * access to dead threads.
+	 */
+	bool			exited;
 	bool			comm_set;
 	int			comm_len;
 	struct list_head	namespaces_list;
@@ -189,6 +198,11 @@ static inline refcount_t *thread__refcnt(struct thread *thread)
 	return &RC_CHK_ACCESS(thread)->refcnt;
 }
 
+static inline void thread__set_exited(struct thread *thread, bool exited)
+{
+	RC_CHK_ACCESS(thread)->exited = exited;
+}
+
 static inline bool thread__comm_set(const struct thread *thread)
 {
 	return RC_CHK_ACCESS(thread)->comm_set;
-- 
2.42.0.758.gaed0368e0e-goog

