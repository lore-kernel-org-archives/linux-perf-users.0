Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5BA13D28F;
	Thu, 30 Jan 2025 03:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738206328; cv=none; b=BMZQI/+bcHvsSrmAfXGKAEf8TJgsGED+uyfOCU/h9+AMtA3atzfbUCu2u1xo8fjoa/xi5RVV4imM6sUNzcS97Vyr4yxkNqKjjplJ3Hvlk4hmRf76JpIhYUyKMn3Aq6F6fdcq0R3QaI70TOTt+5Kd9RTMt4iMFLPBIE9CvRXsZKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738206328; c=relaxed/simple;
	bh=4NYr1/szl5X5kPM8KWdP0HWnkuF/JjvH/op5FqDfAho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=adh7tkAwAsgq9SQbJJKWDPT7QBIbqKDwm4FZMG3GH2BMVZCS9KNzKhV3Updt+0vgCQx6DUJ09/cIa9pjEf+UJKFhQ9AwSJMIXBofHILisXmW7T+iuv+R5CxW80SgoXihSxDzG9tu9WXT6DhqMg+bFDyE32uGmoZJKc7W92/pyGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mq4lezGB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mq4lezGB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6CAC4CED1;
	Thu, 30 Jan 2025 03:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738206327;
	bh=4NYr1/szl5X5kPM8KWdP0HWnkuF/JjvH/op5FqDfAho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mq4lezGBa3KNcoRb23LQcbajj1QloNWhD8Mt2nMA9yqaeAZnVn4j6c8a5KICFr5JG
	 eY/SUO5LzaaVbw80P+gUZZgZ9bWhFqn20XbHFzKwgqONZa58Pp85t3aIg5cDte63lS
	 0atVktWcOEdxRlJmcPcDasqyNQT5uloREFzTq2wVjtD9mi4P/+kqxGFfwVNB3Uc59V
	 yKComjVHrhSPn7XHx39hcCXRHxyu7iCQZuFtchqERO+QjIdHk2U5+086npyRrXkzAN
	 HVjtdztl4iyzV4YEpV6m/17FcfxH5/ILsjNu6PeY8xYHS0cQF8R1goyiXOj5Jc27uX
	 ppvw3DDSPnNWw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v2 3/4] perf tools: Get rid of now-unused rb_resort.h
Date: Wed, 29 Jan 2025 19:05:24 -0800
Message-ID: <20250130030525.1482498-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
In-Reply-To: <20250130030525.1482498-1-namhyung@kernel.org>
References: <20250130030525.1482498-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was only used in perf trace and it switched to use hashmap instead.
Let's delete the code.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/rb_resort.h | 146 ------------------------------------
 1 file changed, 146 deletions(-)
 delete mode 100644 tools/perf/util/rb_resort.h

diff --git a/tools/perf/util/rb_resort.h b/tools/perf/util/rb_resort.h
deleted file mode 100644
index d927a0d250528505..0000000000000000
--- a/tools/perf/util/rb_resort.h
+++ /dev/null
@@ -1,146 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _PERF_RESORT_RB_H_
-#define _PERF_RESORT_RB_H_
-/*
- * Template for creating a class to resort an existing rb_tree according to
- * a new sort criteria, that must be present in the entries of the source
- * rb_tree.
- *
- * (c) 2016 Arnaldo Carvalho de Melo <acme@redhat.com>
- *
- * Quick example, resorting threads by its shortname:
- *
- * First define the prefix (threads) to be used for the functions and data
- * structures created, and provide an expression for the sorting, then the
- * fields to be present in each of the entries in the new, sorted, rb_tree.
- *
- * The body of the init function should collect the fields, maybe
- * pre-calculating them from multiple entries in the original 'entry' from
- * the rb_tree used as a source for the entries to be sorted:
-
-DEFINE_RB_RESORT_RB(threads, strcmp(a->thread->shortname,
-				    b->thread->shortname) < 0,
-	struct thread *thread;
-)
-{
-	entry->thread = rb_entry(nd, struct thread, rb_node);
-}
-
- * After this it is just a matter of instantiating it and iterating it,
- * for a few data structures with existing rb_trees, such as 'struct machine',
- * helpers are available to get the rb_root and the nr_entries:
-
-	DECLARE_RESORT_RB_MACHINE_THREADS(threads, machine_ptr);
-
- * This will instantiate the new rb_tree and a cursor for it, that can be used as:
-
-	struct rb_node *nd;
-
-	resort_rb__for_each_entry(nd, threads) {
-		struct thread *t = threads_entry;
-		printf("%s: %d\n", t->shortname, t->tid);
-	}
-
- * Then delete it:
-
-	resort_rb__delete(threads);
-
- * The name of the data structures and functions will have a _sorted suffix
- * right before the method names, i.e. will look like:
- *
- * 	struct threads_sorted_entry {}
- * 	threads_sorted__insert()
- */
-
-#define DEFINE_RESORT_RB(__name, __comp, ...)					\
-struct __name##_sorted_entry {							\
-	struct rb_node	rb_node;						\
-	__VA_ARGS__								\
-};										\
-static void __name##_sorted__init_entry(struct rb_node *nd,			\
-					struct __name##_sorted_entry *entry);	\
-										\
-static int __name##_sorted__cmp(struct rb_node *nda, struct rb_node *ndb)	\
-{										\
-	struct __name##_sorted_entry *a, *b;					\
-	a = rb_entry(nda, struct __name##_sorted_entry, rb_node);		\
-	b = rb_entry(ndb, struct __name##_sorted_entry, rb_node);		\
-	return __comp;								\
-}										\
-										\
-struct __name##_sorted {							\
-       struct rb_root		    entries;					\
-       struct __name##_sorted_entry nd[0];					\
-};										\
-										\
-static void __name##_sorted__insert(struct __name##_sorted *sorted,		\
-				      struct rb_node *sorted_nd)		\
-{										\
-	struct rb_node **p = &sorted->entries.rb_node, *parent = NULL;		\
-	while (*p != NULL) {							\
-		parent = *p;							\
-		if (__name##_sorted__cmp(sorted_nd, parent))			\
-			p = &(*p)->rb_left;					\
-		else								\
-			p = &(*p)->rb_right;					\
-	}									\
-	rb_link_node(sorted_nd, parent, p);					\
-	rb_insert_color(sorted_nd, &sorted->entries);				\
-}										\
-										\
-static void __name##_sorted__sort(struct __name##_sorted *sorted,		\
-				    struct rb_root *entries)			\
-{										\
-	struct rb_node *nd;							\
-	unsigned int i = 0;							\
-	for (nd = rb_first(entries); nd; nd = rb_next(nd)) {			\
-		struct __name##_sorted_entry *snd = &sorted->nd[i++];		\
-		__name##_sorted__init_entry(nd, snd);				\
-		__name##_sorted__insert(sorted, &snd->rb_node);			\
-	}									\
-}										\
-										\
-static struct __name##_sorted *__name##_sorted__new(struct rb_root *entries,	\
-						    int nr_entries)		\
-{										\
-	struct __name##_sorted *sorted;						\
-	sorted = malloc(sizeof(*sorted) + sizeof(sorted->nd[0]) * nr_entries);	\
-	if (sorted) {								\
-		sorted->entries = RB_ROOT;					\
-		__name##_sorted__sort(sorted, entries);				\
-	}									\
-	return sorted;								\
-}										\
-										\
-static void __name##_sorted__delete(struct __name##_sorted *sorted)		\
-{										\
-	free(sorted);								\
-}										\
-										\
-static void __name##_sorted__init_entry(struct rb_node *nd,			\
-					struct __name##_sorted_entry *entry)
-
-#define DECLARE_RESORT_RB(__name)						\
-struct __name##_sorted_entry *__name##_entry;					\
-struct __name##_sorted *__name = __name##_sorted__new
-
-#define resort_rb__for_each_entry(__nd, __name)					\
-	for (__nd = rb_first(&__name->entries);					\
-	     __name##_entry = rb_entry(__nd, struct __name##_sorted_entry,	\
-				       rb_node), __nd;				\
-	     __nd = rb_next(__nd))
-
-#define resort_rb__delete(__name)						\
-	__name##_sorted__delete(__name), __name = NULL
-
-/*
- * Helpers for other classes that contains both an rbtree and the
- * number of entries in it:
- */
-
-/* For 'struct intlist' */
-#define DECLARE_RESORT_RB_INTLIST(__name, __ilist)				\
-	DECLARE_RESORT_RB(__name)(&__ilist->rblist.entries.rb_root,		\
-				  __ilist->rblist.nr_entries)
-
-#endif /* _PERF_RESORT_RB_H_ */
-- 
2.48.1.262.g85cc9f2d1e-goog

