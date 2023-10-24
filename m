Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A6C4292E
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 22:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RV9yKrDE"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F285430F8
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:25:57 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9cfec5e73dso4929887276.2
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186356; x=1698791156; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zfK3LtQ16zflZ7X6ZyHLcdZIKlRk/T+4AhzfwFPXJCs=;
        b=RV9yKrDEYbXWbK14zY0h2vfn3sAT9COKGFiwGstrJyhnFT52zdLDk7d1OIuh8fQ09r
         4iTla9UXEXP8WZcemGiFT5IVEyE7UIQDEZ9mT5KZoHs0Q3fASFL4HGkNvp9S8C6eHHmQ
         PufFX1ZstrOYfV/QK9EA02rpS8MwRMOeIUv+DoiOcNiNUihkchVYsOBz4LyKjBB8ouHj
         XcMB11cZNS8OaDVyfhSaWTUXd9oxowEAHsYZX7358tk93oaIQArrGpjiBKrgg38khrXo
         zhmXsgpBpwUHfNTt7ldI/ftSZ14RdPB49xp45OcO0BPOW2izuoPeed5re4146xn7IVK4
         4Bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186356; x=1698791156;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zfK3LtQ16zflZ7X6ZyHLcdZIKlRk/T+4AhzfwFPXJCs=;
        b=JfaOM2wMqcnAOJw/zCdL7G9EHMgmUSvnG/HX+B7Yssg/7xGs5jvuNSqX3JiRRRwuik
         OTtoXJOzNSd24ih7NG6TWJazpGXzOnvCwGpEQZDjYUhRhx/1a9dfnspqsNuRrHryvPVt
         TYrKY+DIIPvb8Jkojd8Y+KOrvPplAJC0eJDG7eE5iois9Vo3X5m5j0FRdbLRwsntGYay
         67gpqVyf4LEhZnWvGe5GXh+mUPu6qQkOQpge3t1dJ2vs6Lv0Ecmo6rKMmkYupqIbQ4kc
         oWhVNj7g7kCUHNiN7pGZlUnGMMLkJbLLw7FZM7u4SZV2TUnHHCAsT9YHN6I/agffD7TM
         Ac0w==
X-Gm-Message-State: AOJu0Yx34Mc4CxeV0nuuaaA59nnD+ddhM1tilwoTrdrMaZPV/ywLjXSd
	peNDZIrqobWEjhfwcDa+MGKwgLY+ybtH
X-Google-Smtp-Source: AGHT+IHGXje9BDeZPOvd5i71tq0IbrD/zV6Ek3mx4AYL0h8PkBRbfQumtNUsi3WNuJ8dWenMdnfvd0U1Gz9e
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a05:6902:1083:b0:d9a:47ea:69a5 with SMTP
 id v3-20020a056902108300b00d9a47ea69a5mr366432ybu.1.1698186356515; Tue, 24
 Oct 2023 15:25:56 -0700 (PDT)
Date: Tue, 24 Oct 2023 15:23:49 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-47-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 46/50] perf trace: Ignore thread hashing in summary
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

Commit 91e467bc568f ("perf machine: Use hashtable for machine
threads") made the iteration of thread tids unordered. The perf trace
--summary output sorts and prints each hash bucket, rather than all
threads globally. Change this behavior by turn all threads into a
list, sort the list by number of trace events then by tids, finally
print the list. This also allows the rbtree in threads to be not
accessed outside of machine.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c  | 41 +++++++++++++++++++++----------------
 tools/perf/util/rb_resort.h |  5 -----
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e541d0e2777a..e9ff78b331fe 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -74,6 +74,7 @@
 #include <linux/err.h>
 #include <linux/filter.h>
 #include <linux/kernel.h>
+#include <linux/list_sort.h>
 #include <linux/random.h>
 #include <linux/stringify.h>
 #include <linux/time64.h>
@@ -4314,34 +4315,38 @@ static unsigned long thread__nr_events(struct thread_trace *ttrace)
 	return ttrace ? ttrace->nr_events : 0;
 }
 
-DEFINE_RESORT_RB(threads,
-		(thread__nr_events(thread__priv(a->thread)) <
-		 thread__nr_events(thread__priv(b->thread))),
-	struct thread *thread;
-)
+static int trace_nr_events_cmp(void *priv __maybe_unused,
+			       const struct list_head *la,
+			       const struct list_head *lb)
 {
-	entry->thread = rb_entry(nd, struct thread_rb_node, rb_node)->thread;
+	struct thread_list *a = list_entry(la, struct thread_list, list);
+	struct thread_list *b = list_entry(lb, struct thread_list, list);
+	unsigned long a_nr_events = thread__nr_events(thread__priv(a->thread));
+	unsigned long b_nr_events = thread__nr_events(thread__priv(b->thread));
+
+	if (a_nr_events != b_nr_events)
+		return a_nr_events < b_nr_events ? -1 : 1;
+
+	/* Identical number of threads, place smaller tids first. */
+	return thread__tid(a->thread) < thread__tid(b->thread)
+		? -1
+		: (thread__tid(a->thread) > thread__tid(b->thread) ? 1 : 0);
 }
 
 static size_t trace__fprintf_thread_summary(struct trace *trace, FILE *fp)
 {
 	size_t printed = trace__fprintf_threads_header(fp);
-	struct rb_node *nd;
-	int i;
-
-	for (i = 0; i < THREADS__TABLE_SIZE; i++) {
-		DECLARE_RESORT_RB_MACHINE_THREADS(threads, trace->host, i);
+	LIST_HEAD(threads);
 
-		if (threads == NULL) {
-			fprintf(fp, "%s", "Error sorting output by nr_events!\n");
-			return 0;
-		}
+	if (machine__thread_list(trace->host, &threads) == 0) {
+		struct thread_list *pos;
 
-		resort_rb__for_each_entry(nd, threads)
-			printed += trace__fprintf_thread(fp, threads_entry->thread, trace);
+		list_sort(NULL, &threads, trace_nr_events_cmp);
 
-		resort_rb__delete(threads);
+		list_for_each_entry(pos, &threads, list)
+			printed += trace__fprintf_thread(fp, pos->thread, trace);
 	}
+	thread_list__delete(&threads);
 	return printed;
 }
 
diff --git a/tools/perf/util/rb_resort.h b/tools/perf/util/rb_resort.h
index 376e86cb4c3c..d927a0d25052 100644
--- a/tools/perf/util/rb_resort.h
+++ b/tools/perf/util/rb_resort.h
@@ -143,9 +143,4 @@ struct __name##_sorted *__name = __name##_sorted__new
 	DECLARE_RESORT_RB(__name)(&__ilist->rblist.entries.rb_root,		\
 				  __ilist->rblist.nr_entries)
 
-/* For 'struct machine->threads' */
-#define DECLARE_RESORT_RB_MACHINE_THREADS(__name, __machine, hash_bucket)    \
- DECLARE_RESORT_RB(__name)(&__machine->threads[hash_bucket].entries.rb_root, \
-			   __machine->threads[hash_bucket].nr)
-
 #endif /* _PERF_RESORT_RB_H_ */
-- 
2.42.0.758.gaed0368e0e-goog

