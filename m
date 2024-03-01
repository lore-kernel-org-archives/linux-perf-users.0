Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553D354730
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Mar 2024 05:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709271428; cv=none; b=XeyjPkeYD/efwzHcsOMv3iFm4UtlnmfXAbuMCybNx0ZnzTR+FYCaz4b0n2KGlij0pLxhH1x+dx7ppD9FPahf/zRBQE+zdzyZwXP219vB8IuiIhpIxOxJdKHCenqrnLCyysiQsXOHonfbuPyL9KKdkRAbdF0fJGZPGN6Z0UqX/C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709271428; c=relaxed/simple;
	bh=SCdyCRIW2q68p5P5XIiezVRdNMVzHuD+AJIgIjGCWXw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=FiDmKpcYgUOYVhjPrqdKROaYDT9eI1I0haAH37pf5KGXZlWxxKqdWSjb9Z/r7E7ElvKuPqOQsU7Ig2U/zHvm1pwqZjxfTQQ01lVgDid+xvjMMHhewQA2efTMqYoo/kCuvT7ZeXjqXGO1cmb6XMhGZKSQ20hOrGkbaaN2s0B09jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JsDqkn//; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JsDqkn//"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcd94cc48a1so2828264276.3
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 21:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709271425; x=1709876225; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G4IHp+rWZ6m2tdq1gZNE1l7uOaHQfZu8fsR6pOr+kRs=;
        b=JsDqkn//YlCBTmY+LxfyxyBNgms6u3MC0PQDXERBEVsj08UmXLaTdbQtXUGUmdumo7
         Vg52LO9qSLQoE827beREGu8hvcMA8P1ZwPeETtwK2OQkojV0SWCgTg/5HZk/tOJhnnKt
         Nti+co1hamuw0ZuXhKmW6v7GBL2v8XewKtAugbbqbbDift03Pc0tAbub3FT+ucCgic5J
         71AxLqXFjUFyJkHktTwvPplFw84LtEwKzuAkAceqmPA+V6WfXdhT5YrBBeHYVKlijzHU
         nIj4Kq8cQMpGsFdHtX7E4xzVTQYGx8DyK1s/3m6UVINGmd89OBRSqjyzrlWu1yrVa7aI
         YD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709271425; x=1709876225;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G4IHp+rWZ6m2tdq1gZNE1l7uOaHQfZu8fsR6pOr+kRs=;
        b=KX4OhizqGCTwDxlhpSlW6Bb1K1U6wUtlInW5jpbzcaz+6caUZE7NRjY+NDjD01Wj9p
         JyiNMTGoCmFNTNMT3hdo3ebFypXhwBOaV2n19eTdcM5yLN1+H1e5ZWU1CDmnKt6A9sxw
         8aRvQHdgPFlJPyMtOq95mn2XILdFkZIjNXX6Fc0smV/OVhlQVisng0/UUp+Ma20U2YVx
         eWCKmB5NyWcXfq8c0os8kNoF4GnDE1nM6k2qEdprj1dqg55dKyqam5pCxvAv5NgB37Xd
         A9sE8/KHDsnmG3zGaZ6TylH+XnwITqo10TprwG+G9HLRAbfkqCne4USoV1R0kxDekxkU
         QoBw==
X-Forwarded-Encrypted: i=1; AJvYcCXkD0cHSRT6pcw0kkHzsnoIVr9Vi5bqbryv9F8vojaG121YR8n9yIhsVCamYm51SrbBfzIkW/HB+D1/df7t2uezflULC2se7j5sNnUaVdFwLw==
X-Gm-Message-State: AOJu0YwgpNd+qV8fK+lB1tg5vizjJGozIxSxxFMua79N5bl/PJTboIhp
	/NzCSo5By16tQ3fs+p9TPrGw85S29mSMzTuKy2MdijkESx11W5p9HyIF+aLyBwQBzdJp+cfPj3l
	Bo25DEw==
X-Google-Smtp-Source: AGHT+IHDnJcerb+c7ZPfEF4j9tDeF/0/h6s4fjz+tv+cgtygpZuNEk0geTQ5pUO7WIcjdj5Uc3q5l8xOwCm2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a05:6902:154d:b0:dcf:411d:67b9 with SMTP
 id r13-20020a056902154d00b00dcf411d67b9mr137956ybu.5.1709271425461; Thu, 29
 Feb 2024 21:37:05 -0800 (PST)
Date: Thu, 29 Feb 2024 21:36:44 -0800
In-Reply-To: <20240301053646.1449657-1-irogers@google.com>
Message-Id: <20240301053646.1449657-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301053646.1449657-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v4 6/7] perf threads: Switch from rbtree to hashmap
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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
index db52d233c2de..ff2b169e0085 100644
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
 
@@ -229,12 +171,12 @@ int threads__for_each_thread(struct threads *threads,
 {
 	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
 		struct threads_table_entry *table = &threads->table[i];
-		struct rb_node *nd;
+		struct hashmap_entry *cur;
+		size_t bkt;
 
 		down_read(&table->lock);
-		for (nd = rb_first_cached(&table->entries); nd; nd = rb_next(nd)) {
-			struct thread_rb_node *trb = rb_entry(nd, struct thread_rb_node, rb_node);
-			int rc = fn(trb->thread, data);
+		hashmap__for_each_entry((&table->shard), cur, bkt) {
+			int rc = fn((struct thread *)cur->pvalue, data);
 
 			if (rc != 0) {
 				up_read(&table->lock);
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
2.44.0.278.ge034bb2e1d-goog

