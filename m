Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E977F151CCE
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Feb 2024 22:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709071328; cv=none; b=eGdw0/ffg7vQ6wU4ygr/NfLeGI+J6mW9ANgL1zmQ7cawYMSbZm0VguM411+Dmbidi4F3XXz3X0QTBeNeoKmwEPjGui7P0ATrulzWb0UlHB2IHHdWoaSIsLJj6uZhfmM8POfYFfsIbvtURq2j/P8ZIKzJF373TwkuhmVCklt+Fcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709071328; c=relaxed/simple;
	bh=louA5ITf0PB9gTEbmjxtVgELJEkk9dAW1fzHeRrbwTQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=J3nS7AHnbYs4nGVEwpuFL/5+ViUMdl8/tMuy1L6A3Zxf3yTY7KVAT29AJ0KAhwDzB6SyPqMxgAypU6ZYn0ebEtaeywfohUHEM/Q1Icoy5FESoQcdQqtv06i36ZGh+iRN6wAJow3d0CcrB8J7oqCy2PGZS4wLwNeaKosKecEdY68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2+ezsV03; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2+ezsV03"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60925cacbb7so23486317b3.2
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Feb 2024 14:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709071326; x=1709676126; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/FMLMbsrzbdkn9O9XsKWx3S12UuVwdsAjVLGeB/eBZI=;
        b=2+ezsV035YYGdi1fQZHX7QXaKBcwAriZoTOm1Sw5aUUGe11VbnONJEpYnrxzRBBpMI
         7XnFs5/BAIKzXCWsVn0eGJd+XMsXToE666mzs7qrh2LvC75PUwEqEDOschKvFabrIwVw
         jxEXQe/4v763Le9x3rOLQirCC1CZzYKcYNum2o0SOEYRo77jGnEAMHGhP3dETMKEeifx
         wgXhasDLkcqJde9u5QKillgECiqwXCsabDYG/3BoETwLijhHQvLL2A6g9g8tsGZA8ciV
         I5JLi8SAN25d9vBP/m+kQh/+XxV+Vm66FEslpn8lo/GQJcm0iih/jKtsAhnIMbs5Dgkr
         0W4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709071326; x=1709676126;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/FMLMbsrzbdkn9O9XsKWx3S12UuVwdsAjVLGeB/eBZI=;
        b=IEm04IebC7brys/kkXPpv3pLjKZWATosyTkP8ymzFwX1pjp9M2WdKB2O06CTbB7aWi
         HV+Ev5Yy+Ec9v6yo6R/pxCb5SUN/D21NEbprGSD2za12dBCsHx2JNwjGgmz/Fa1MvLTp
         SQjHB5BzcEYMUelbCgM+TZtL3q6NPwwGJKPVzlUXArhqYBzcaB/y7b15J5NSOdNi0VjL
         zfiqZyg6KtZqwoctXE8GXw10tWu8Q40CsPOsoGC8bAf2gwIut8iEaOApt4KB6Uc5aAOT
         QY6rkDnObuQEVe5iUm+cdkQmI/0SHExRc2G1ysKWgJyfp4ngKXfeGRpuWzBkFXupRB2P
         da8w==
X-Forwarded-Encrypted: i=1; AJvYcCUQtvPQDfsntvEo3fOaGtbxhwmSuGgLNz6Z2FS/+em+w+S19p3V56ct4aC4+cDd19aX/833KJtDGIR6JVvLh6Vq9ga46UYpScbwgUg0a6QIgg==
X-Gm-Message-State: AOJu0YwkHlCNQ7nMpshgP4hkHD+hiZEy/hbVFu6f79VZiIqiCxFPSyUP
	GoKRuTCBJqpW6c77usmEKgFA94T6AkzGrmntV8nSn3HhqDZ3bN1h68nRlWWPMX41DjXxsC6uUJ7
	600PxQw==
X-Google-Smtp-Source: AGHT+IGtgwaXt2Ye5Ot4T80iOqTZS9VHVj3XpgeYVsVpc6gFFqbM+RpqUmaenndL8w6+NNw6P+6xudzHiI8e
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4ff1:8af6:9e1a:6382])
 (user=irogers job=sendgmr) by 2002:a05:6902:150a:b0:dc6:d9eb:6422 with SMTP
 id q10-20020a056902150a00b00dc6d9eb6422mr32279ybu.10.1709071326081; Tue, 27
 Feb 2024 14:02:06 -0800 (PST)
Date: Tue, 27 Feb 2024 14:01:46 -0800
In-Reply-To: <20240227220150.3876198-1-irogers@google.com>
Message-Id: <20240227220150.3876198-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227220150.3876198-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Subject: [PATCH v2 2/6] perf trace: Ignore thread hashing in summary
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
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
2.44.0.rc1.240.g4c46232300-goog

