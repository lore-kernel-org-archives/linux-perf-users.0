Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nu6hgpd5"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA40173B
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Dec 2023 17:18:40 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d1ed4b268dso1953547b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Dec 2023 17:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911919; x=1702516719; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1eb9Sth/5ufQgSBSs/vYHmQiQlg9BE62KSRUCpFldRs=;
        b=nu6hgpd5NgOIEfOSzyx3pVPozmpAahYzTrR0+WrVIXYkJxpHmoNDpqRjjISQeFZGFV
         wdE8BbpVKFyluSOpEQLKLsFzjRCfR2e0scbZqxuRE799kU3Ue/tu0o+t5iiMLbaOOhlX
         59VUW5LhzjHAkjCDCxa0GaIbSe2w4PLHGgZ0nDeUgd/0m1FDw6dv92iM2cZKwUpMrSBd
         +7mc8GaEqYzuS/R+RMVcboAoael2/4llX4cuHSLrwI+iSLE9iQ/lxMQdgIfuHrgsxXr2
         bXsu0VUbA9nFbudFJPPmyHKxv8fbPBIywTcQNE9PV7i2+lm1AhtRgU1hoJpm01ARu2ux
         8I6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911919; x=1702516719;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1eb9Sth/5ufQgSBSs/vYHmQiQlg9BE62KSRUCpFldRs=;
        b=D3dWJjcYWaPkGvI6IiEP3EtOuRJIHeloJ7ZeMxbnnFAZ6ssVmZKb0Ys9G+BpuHTDn9
         Zq3rWtwMF1C1MWg7p1z25us22dFqGhBtyFJQlPDYhW9Prd8V3V6wnjRs4SV7fe4KYF9D
         VdzwoNe/ztsAiJaZi5PZmZe8OJHi9oW5QMpqKQiVg+pS+BxmZ5PCu6dpsiI7jcCTj4+l
         0TefAjD01zTG0zFRfA/uFjGtn5Irz5cYQNYGaRG9/YzkS+eKnJ3zfE5qw9N8q4S5ntdx
         KNs2/z0qlP3oFMJ7C/B7qZ8fh3s26nJglvUmyBmK+bXDuqLs736l+xfh0xQ+Ju+jOsDN
         39nQ==
X-Gm-Message-State: AOJu0YxIxnH7ieRi/0wwshEUMKmyWpLf84zmX/vf6ZCjOepPIs6yfjt5
	tmazTBxwLDk6YkvYjHrbO9w37a4BkvNm
X-Google-Smtp-Source: AGHT+IGexOjopviNliPOT4Ea4L6autmd7fAGL7K+v0N7p4uTDj8P9jUmPmA5ZjffiGiLLbQe9NZ/l/u2oKfd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a25:ca94:0:b0:db5:3b4b:ad1e with SMTP id
 a142-20020a25ca94000000b00db53b4bad1emr29235ybg.10.1701911919286; Wed, 06 Dec
 2023 17:18:39 -0800 (PST)
Date: Wed,  6 Dec 2023 17:17:05 -0800
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
Message-Id: <20231207011722.1220634-32-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 31/47] perf trace: Ignore thread hashing in summary
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Ming Wang <wangming01@loongson.cn>, 
	James Clark <james.clark@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, liuwenyu <liuwenyu7@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Guilherme Amadio <amadio@gentoo.org>
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
index 109b8e64fe69..90eaff8c0f6e 100644
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
@@ -4312,34 +4313,38 @@ static unsigned long thread__nr_events(struct thread_trace *ttrace)
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
2.43.0.rc2.451.g8631bc7472-goog

