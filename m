Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1AsNmPLU"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2281705
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Dec 2023 17:18:49 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d3a1f612b3so1813407b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Dec 2023 17:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911926; x=1702516726; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6XPMhFguJKdevNq0BuX1K2WwqiJa4TUi6+5+KYe90vk=;
        b=1AsNmPLUXOofU2Wxuz+AOnUqK7U/HfidLzh/fB9mQeywYV2VMn+sp4TNrktTA2S7Cb
         oUZgvFxb4WeFf+LQSnW4TLDM068AiRfLpBsslbF1kkm6zUnUWbuphqcKC/S+FZc5DJb6
         H5VbEwCy4NKmd6/SJsgcevK8h+CKRHCCZU6wPnd6P6uoW8WzHGrAqUElQCM1Aze6GerP
         Q/FPdhvMP9XItFSHKT3Z0AQhkbh2+llRh3bJIfAPyXri48XzdqQas2Srvjds0dty8GrZ
         2dUdhaNTe0jqn7hlDoMdxI3FJ2L9ifDtR7I5YblVznlw5tju70cKboNXr9vk9XalZnRW
         8hNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911926; x=1702516726;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6XPMhFguJKdevNq0BuX1K2WwqiJa4TUi6+5+KYe90vk=;
        b=lE3Mgs65hP6/90t7UWSxPvaV6nnDo9O/A8dtMtVMqAJNKnMYOsCA0o8sy/0c7dgUR0
         mewoutXP1+UOsGB7E3TwCbZNiSogI+QgecuNzzcg4Qv/ukSjorwIrXCGx1bBEhgIIXTh
         MJCyn/2QYyhb8XiDSrjgGaCE94nAXqvxbFBV8xhNk6YJLDQPzZFkwa0abHFqYPlL14rj
         YWiFIFrSjfSdRNp7c9qdvClw8orkhY1LFvFvpVpOBld6qp2nAEg0T+ZaEDhmmrURpFHQ
         e7Wg7LQtNKsipgnLqFpS6h+hk1O6RrPlvSVfuGpPB1/0lS2DImwUMzmKNbaXzn9geGc0
         BKHQ==
X-Gm-Message-State: AOJu0Yzv62327RevUTK1Bztt7+CPHGPuFtV+heDxFE82cJYK2etOEzoZ
	z+XWwXrG767L2MM4mmPKkHCA+xlyiN1V
X-Google-Smtp-Source: AGHT+IHtzyDgCIoSiT5QPfJq/U0p8BSnE+mgom7BB2eq9AVSb4MCaSVAoBzHfJG44lKPYqHBcIgG0PHuh31v
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a81:be18:0:b0:5d4:27ab:83c with SMTP id
 i24-20020a81be18000000b005d427ab083cmr30007ywn.1.1701911926598; Wed, 06 Dec
 2023 17:18:46 -0800 (PST)
Date: Wed,  6 Dec 2023 17:17:08 -0800
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
Message-Id: <20231207011722.1220634-35-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 34/47] perf threads: Switch from rbtree to hashmap
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

The rbtree provides a sorting on entries but this is unused. Switch to
using hashmap for O(1) rather than O(log n) find/insert/remove
complexity.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/threads.c | 146 ++++++++++++--------------------------
 tools/perf/util/threads.h |   6 +-
 2 files changed, 47 insertions(+), 105 deletions(-)

diff --git a/tools/perf/util/threads.c b/tools/perf/util/threads.c
index d984ec939c7b..55923be53180 100644
--- a/tools/perf/util/threads.c
+++ b/tools/perf/util/threads.c
@@ -3,25 +3,30 @@
 #include "machine.h"
 #include "thread.h"
 
-struct thread_rb_node {
-	struct rb_node rb_node;
-	struct thread *thread;
-};
-
 static struct threads_table_entry *threads__table(struct threads *threads, pid_t tid)
 {
 	/* Cast it to handle tid == -1 */
 	return &threads->table[(unsigned int)tid % THREADS__TABLE_SIZE];
 }
 
+static size_t key_hash(long key, void *ctx __maybe_unused)
+{
+	/* The table lookup removes low bit entropy, but this is just ignored here. */
+	return key;
+}
+
+static bool key_equal(long key1, long key2, void *ctx __maybe_unused)
+{
+	return key1 == key2;
+}
+
 void threads__init(struct threads *threads)
 {
 	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
 		struct threads_table_entry *table = &threads->table[i];
 
-		table->entries = RB_ROOT_CACHED;
+		hashmap__init(&table->shard, key_hash, key_equal, NULL);
 		init_rwsem(&table->lock);
-		table->nr = 0;
 		table->last_match = NULL;
 	}
 }
@@ -32,6 +37,7 @@ void threads__exit(struct threads *threads)
 	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
 		struct threads_table_entry *table = &threads->table[i];
 
+		hashmap__clear(&table->shard);
 		exit_rwsem(&table->lock);
 	}
 }
@@ -44,7 +50,7 @@ size_t threads__nr(struct threads *threads)
 		struct threads_table_entry *table = &threads->table[i];
 
 		down_read(&table->lock);
-		nr += table->nr;
+		nr += hashmap__size(&table->shard);
 		up_read(&table->lock);
 	}
 	return nr;
@@ -86,28 +92,13 @@ static void threads_table_entry__set_last_match(struct threads_table_entry *tabl
 struct thread *threads__find(struct threads *threads, pid_t tid)
 {
 	struct threads_table_entry *table  = threads__table(threads, tid);
-	struct rb_node **p;
-	struct thread *res = NULL;
+	struct thread *res;
 
 	down_read(&table->lock);
 	res = __threads_table_entry__get_last_match(table, tid);
-	if (res)
-		return res;
-
-	p = &table->entries.rb_root.rb_node;
-	while (*p != NULL) {
-		struct rb_node *parent = *p;
-		struct thread *th = rb_entry(parent, struct thread_rb_node, rb_node)->thread;
-
-		if (thread__tid(th) == tid) {
-			res = thread__get(th);
-			break;
-		}
-
-		if (tid < thread__tid(th))
-			p = &(*p)->rb_left;
-		else
-			p = &(*p)->rb_right;
+	if (!res) {
+		if (hashmap__find(&table->shard, tid, &res))
+			res = thread__get(res);
 	}
 	up_read(&table->lock);
 	if (res)
@@ -118,49 +109,25 @@ struct thread *threads__find(struct threads *threads, pid_t tid)
 struct thread *threads__findnew(struct threads *threads, pid_t pid, pid_t tid, bool *created)
 {
 	struct threads_table_entry *table  = threads__table(threads, tid);
-	struct rb_node **p;
-	struct rb_node *parent = NULL;
 	struct thread *res = NULL;
-	struct thread_rb_node *nd;
-	bool leftmost = true;
 
 	*created = false;
 	down_write(&table->lock);
-	p = &table->entries.rb_root.rb_node;
-	while (*p != NULL) {
-		struct thread *th;
-
-		parent = *p;
-		th = rb_entry(parent, struct thread_rb_node, rb_node)->thread;
-
-		if (thread__tid(th) == tid) {
-			__threads_table_entry__set_last_match(table, th);
-			res = thread__get(th);
-			goto out_unlock;
-		}
-
-		if (tid < thread__tid(th))
-			p = &(*p)->rb_left;
-		else {
-			leftmost = false;
-			p = &(*p)->rb_right;
-		}
-	}
-	nd = malloc(sizeof(*nd));
-	if (nd == NULL)
-		goto out_unlock;
 	res = thread__new(pid, tid);
-	if (!res)
-		free(nd);
-	else {
-		*created = true;
-		nd->thread = thread__get(res);
-		rb_link_node(&nd->rb_node, parent, p);
-		rb_insert_color_cached(&nd->rb_node, &table->entries, leftmost);
-		++table->nr;
-		__threads_table_entry__set_last_match(table, res);
+	if (res) {
+		if (hashmap__add(&table->shard, tid, res)) {
+			/* Add failed. Assume a race so find other entry. */
+			thread__put(res);
+			res = NULL;
+			if (hashmap__find(&table->shard, tid, &res))
+				res = thread__get(res);
+		} else {
+			res = thread__get(res);
+			*created = true;
+		}
+		if (res)
+			__threads_table_entry__set_last_match(table, res);
 	}
-out_unlock:
 	up_write(&table->lock);
 	return res;
 }
@@ -169,57 +136,32 @@ void threads__remove_all_threads(struct threads *threads)
 {
 	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
 		struct threads_table_entry *table = &threads->table[i];
-		struct rb_node *nd;
+		struct hashmap_entry *cur, *tmp;
+		size_t bkt;
 
 		down_write(&table->lock);
 		__threads_table_entry__set_last_match(table, NULL);
-		nd = rb_first_cached(&table->entries);
-		while (nd) {
-			struct thread_rb_node *trb = rb_entry(nd, struct thread_rb_node, rb_node);
-
-			nd = rb_next(nd);
-			thread__put(trb->thread);
-			rb_erase_cached(&trb->rb_node, &table->entries);
-			RB_CLEAR_NODE(&trb->rb_node);
-			--table->nr;
+		hashmap__for_each_entry_safe((&table->shard), cur, tmp, bkt) {
+			struct thread *old_value;
 
-			free(trb);
+			hashmap__delete(&table->shard, cur->key, /*old_key=*/NULL, &old_value);
+			thread__put(old_value);
 		}
-		assert(table->nr == 0);
 		up_write(&table->lock);
 	}
 }
 
 void threads__remove(struct threads *threads, struct thread *thread)
 {
-	struct rb_node **p;
 	struct threads_table_entry *table  = threads__table(threads, thread__tid(thread));
-	pid_t tid = thread__tid(thread);
+	struct thread *old_value;
 
 	down_write(&table->lock);
 	if (table->last_match && RC_CHK_EQUAL(table->last_match, thread))
 		__threads_table_entry__set_last_match(table, NULL);
 
-	p = &table->entries.rb_root.rb_node;
-	while (*p != NULL) {
-		struct rb_node *parent = *p;
-		struct thread_rb_node *nd = rb_entry(parent, struct thread_rb_node, rb_node);
-		struct thread *th = nd->thread;
-
-		if (RC_CHK_EQUAL(th, thread)) {
-			thread__put(nd->thread);
-			rb_erase_cached(&nd->rb_node, &table->entries);
-			RB_CLEAR_NODE(&nd->rb_node);
-			--table->nr;
-			free(nd);
-			break;
-		}
-
-		if (tid < thread__tid(th))
-			p = &(*p)->rb_left;
-		else
-			p = &(*p)->rb_right;
-	}
+	hashmap__delete(&table->shard, thread__tid(thread), /*old_key=*/NULL, &old_value);
+	thread__put(old_value);
 	up_write(&table->lock);
 }
 
@@ -229,11 +171,11 @@ int threads__for_each_thread(struct threads *threads,
 {
 	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
 		struct threads_table_entry *table = &threads->table[i];
-		struct rb_node *nd;
+		struct hashmap_entry *cur;
+		size_t bkt;
 
-		for (nd = rb_first_cached(&table->entries); nd; nd = rb_next(nd)) {
-			struct thread_rb_node *trb = rb_entry(nd, struct thread_rb_node, rb_node);
-			int rc = fn(trb->thread, data);
+		hashmap__for_each_entry((&table->shard), cur, bkt) {
+			int rc = fn((struct thread *)cur->pvalue, data);
 
 			if (rc != 0)
 				return rc;
diff --git a/tools/perf/util/threads.h b/tools/perf/util/threads.h
index ed67de627578..d03bd91a7769 100644
--- a/tools/perf/util/threads.h
+++ b/tools/perf/util/threads.h
@@ -2,7 +2,7 @@
 #ifndef __PERF_THREADS_H
 #define __PERF_THREADS_H
 
-#include <linux/rbtree.h>
+#include "hashmap.h"
 #include "rwsem.h"
 
 struct thread;
@@ -11,9 +11,9 @@ struct thread;
 #define THREADS__TABLE_SIZE	(1 << THREADS__TABLE_BITS)
 
 struct threads_table_entry {
-	struct rb_root_cached  entries;
+	/* Key is tid, value is struct thread. */
+	struct hashmap	       shard;
 	struct rw_semaphore    lock;
-	unsigned int	       nr;
 	struct thread	       *last_match;
 };
 
-- 
2.43.0.rc2.451.g8631bc7472-goog

