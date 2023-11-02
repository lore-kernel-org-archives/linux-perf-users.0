Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C2120B18
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 17:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m6p/FKrA"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2701BB
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 10:58:33 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da2b8af7e89so1501424276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Nov 2023 10:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947913; x=1699552713; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ZkyCJgzPNyfKDuplflbsfuPI9MNl3HtBu+wDsWrFoA=;
        b=m6p/FKrAd0Y7RwcE9bcWTc/wGJ1j3hQy6ZB0Os533XcmDIC9D+6uFfAdX2LJbaCKuQ
         6711X0hREa1Sz2VNjvirYYjYu7nHUdX8nfBH10mvmXO8m/TJhqO9mFfaCrl52VPiqsll
         dK+rulF+fbAZszrE6TGiFkI+Ct1ZyA7tmQVkfFBAUllb+4IEQh37E8QTz/IRbYwycM2p
         TYvMj6T2wnWO+U795kfb8BGlsZbWvOPNnxxkajqkvU0WfCFbRpGmZ89HdeTxId/5wchS
         9vRf8FusCYEjsYzcYzarka+OzjosP2XRhcbCnccPY2uteLNr7HCeSnQjDXEm0Qdn8LsM
         t0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947913; x=1699552713;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ZkyCJgzPNyfKDuplflbsfuPI9MNl3HtBu+wDsWrFoA=;
        b=qxP/z81njKl1S+gJlG/qysMkpLZFTbSZwdeJbrxxsMpmJ/WSi3S3wu6BQbjWfYZ+fQ
         X8Oaj9n04zvJnup3cZp3rHt1b3KcQp9hCWraRDF/ClrhlUM8dEmDa1MUICYUvJq4BVzb
         isz2/bUyeNTsPq/QNQTYv1r8KpAT9fPxJboQ5xAUDgbwJ0lZI0jE/8P6zOHidlc9F3ZN
         9HwF5jtmmFX/9C3al/KvPU43uVaIbl1IZAvVUq/Ouw8ZnxjTQPyTYJ/4svjzLJ/s9j8v
         89Fz71MIQlV4NyQRnXMVeXA6BGL650Tl7OMNF66VRI4KhFZhlf5Ik6JMWVi8jjIPVo4q
         8a+w==
X-Gm-Message-State: AOJu0Yw1QmbH213VRVLXFsqOFHojgM8a7ZNuA01AtLv6qubkCzZ4bLGf
	cQCGR6Th+CA+tjG03DqMi6/ypUSv+QUI
X-Google-Smtp-Source: AGHT+IGfjfKSEV5zApeoa2AMkuh3o2Ld2yOLdFF+fJDVTRs5fmTC4pU8c4kdpHPd+Gao5MA4rtUYCwCFw19L
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a25:aa47:0:b0:d9a:d272:ee58 with SMTP id
 s65-20020a25aa47000000b00d9ad272ee58mr355099ybi.9.1698947912940; Thu, 02 Nov
 2023 10:58:32 -0700 (PDT)
Date: Thu,  2 Nov 2023 10:56:58 -0700
In-Reply-To: <20231102175735.2272696-1-irogers@google.com>
Message-Id: <20231102175735.2272696-17-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 16/53] perf maps: Move symbol maps functions to maps.c
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
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Move the find and certain other symbol maps__* functions to maps.c for
better abstraction.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c   | 238 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/maps.h   |  12 ++
 tools/perf/util/symbol.c | 248 ---------------------------------------
 tools/perf/util/symbol.h |   1 -
 4 files changed, 250 insertions(+), 249 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 233438c95b53..9a011aed4b75 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -475,3 +475,241 @@ struct map_rb_node *map_rb_node__next(struct map_rb_node *node)
 
 	return rb_entry(next, struct map_rb_node, rb_node);
 }
+
+static int map__strcmp(const void *a, const void *b)
+{
+	const struct map *map_a = *(const struct map **)a;
+	const struct map *map_b = *(const struct map **)b;
+	const struct dso *dso_a = map__dso(map_a);
+	const struct dso *dso_b = map__dso(map_b);
+	int ret = strcmp(dso_a->short_name, dso_b->short_name);
+
+	if (ret == 0 && map_a != map_b) {
+		/*
+		 * Ensure distinct but name equal maps have an order in part to
+		 * aid reference counting.
+		 */
+		ret = (int)map__start(map_a) - (int)map__start(map_b);
+		if (ret == 0)
+			ret = (int)((intptr_t)map_a - (intptr_t)map_b);
+	}
+
+	return ret;
+}
+
+static int map__strcmp_name(const void *name, const void *b)
+{
+	const struct dso *dso = map__dso(*(const struct map **)b);
+
+	return strcmp(name, dso->short_name);
+}
+
+void __maps__sort_by_name(struct maps *maps)
+{
+	qsort(maps__maps_by_name(maps), maps__nr_maps(maps), sizeof(struct map *), map__strcmp);
+}
+
+static int map__groups__sort_by_name_from_rbtree(struct maps *maps)
+{
+	struct map_rb_node *rb_node;
+	struct map **maps_by_name = realloc(maps__maps_by_name(maps),
+					    maps__nr_maps(maps) * sizeof(struct map *));
+	int i = 0;
+
+	if (maps_by_name == NULL)
+		return -1;
+
+	up_read(maps__lock(maps));
+	down_write(maps__lock(maps));
+
+	RC_CHK_ACCESS(maps)->maps_by_name = maps_by_name;
+	RC_CHK_ACCESS(maps)->nr_maps_allocated = maps__nr_maps(maps);
+
+	maps__for_each_entry(maps, rb_node)
+		maps_by_name[i++] = map__get(rb_node->map);
+
+	__maps__sort_by_name(maps);
+
+	up_write(maps__lock(maps));
+	down_read(maps__lock(maps));
+
+	return 0;
+}
+
+static struct map *__maps__find_by_name(struct maps *maps, const char *name)
+{
+	struct map **mapp;
+
+	if (maps__maps_by_name(maps) == NULL &&
+	    map__groups__sort_by_name_from_rbtree(maps))
+		return NULL;
+
+	mapp = bsearch(name, maps__maps_by_name(maps), maps__nr_maps(maps),
+		       sizeof(*mapp), map__strcmp_name);
+	if (mapp)
+		return *mapp;
+	return NULL;
+}
+
+struct map *maps__find_by_name(struct maps *maps, const char *name)
+{
+	struct map_rb_node *rb_node;
+	struct map *map;
+
+	down_read(maps__lock(maps));
+
+
+	if (RC_CHK_ACCESS(maps)->last_search_by_name) {
+		const struct dso *dso = map__dso(RC_CHK_ACCESS(maps)->last_search_by_name);
+
+		if (strcmp(dso->short_name, name) == 0) {
+			map = RC_CHK_ACCESS(maps)->last_search_by_name;
+			goto out_unlock;
+		}
+	}
+	/*
+	 * If we have maps->maps_by_name, then the name isn't in the rbtree,
+	 * as maps->maps_by_name mirrors the rbtree when lookups by name are
+	 * made.
+	 */
+	map = __maps__find_by_name(maps, name);
+	if (map || maps__maps_by_name(maps) != NULL)
+		goto out_unlock;
+
+	/* Fallback to traversing the rbtree... */
+	maps__for_each_entry(maps, rb_node) {
+		struct dso *dso;
+
+		map = rb_node->map;
+		dso = map__dso(map);
+		if (strcmp(dso->short_name, name) == 0) {
+			RC_CHK_ACCESS(maps)->last_search_by_name = map;
+			goto out_unlock;
+		}
+	}
+	map = NULL;
+
+out_unlock:
+	up_read(maps__lock(maps));
+	return map;
+}
+
+void maps__fixup_end(struct maps *maps)
+{
+	struct map_rb_node *prev = NULL, *curr;
+
+	down_write(maps__lock(maps));
+
+	maps__for_each_entry(maps, curr) {
+		if (prev != NULL && !map__end(prev->map))
+			map__set_end(prev->map, map__start(curr->map));
+
+		prev = curr;
+	}
+
+	/*
+	 * We still haven't the actual symbols, so guess the
+	 * last map final address.
+	 */
+	if (curr && !map__end(curr->map))
+		map__set_end(curr->map, ~0ULL);
+
+	up_write(maps__lock(maps));
+}
+
+/*
+ * Merges map into maps by splitting the new map within the existing map
+ * regions.
+ */
+int maps__merge_in(struct maps *kmaps, struct map *new_map)
+{
+	struct map_rb_node *rb_node;
+	LIST_HEAD(merged);
+	int err = 0;
+
+	maps__for_each_entry(kmaps, rb_node) {
+		struct map *old_map = rb_node->map;
+
+		/* no overload with this one */
+		if (map__end(new_map) < map__start(old_map) ||
+		    map__start(new_map) >= map__end(old_map))
+			continue;
+
+		if (map__start(new_map) < map__start(old_map)) {
+			/*
+			 * |new......
+			 *       |old....
+			 */
+			if (map__end(new_map) < map__end(old_map)) {
+				/*
+				 * |new......|     -> |new..|
+				 *       |old....| ->       |old....|
+				 */
+				map__set_end(new_map, map__start(old_map));
+			} else {
+				/*
+				 * |new.............| -> |new..|       |new..|
+				 *       |old....|    ->       |old....|
+				 */
+				struct map_list_node *m = map_list_node__new();
+
+				if (!m) {
+					err = -ENOMEM;
+					goto out;
+				}
+
+				m->map = map__clone(new_map);
+				if (!m->map) {
+					free(m);
+					err = -ENOMEM;
+					goto out;
+				}
+
+				map__set_end(m->map, map__start(old_map));
+				list_add_tail(&m->node, &merged);
+				map__add_pgoff(new_map, map__end(old_map) - map__start(new_map));
+				map__set_start(new_map, map__end(old_map));
+			}
+		} else {
+			/*
+			 *      |new......
+			 * |old....
+			 */
+			if (map__end(new_map) < map__end(old_map)) {
+				/*
+				 *      |new..|   -> x
+				 * |old.........| -> |old.........|
+				 */
+				map__put(new_map);
+				new_map = NULL;
+				break;
+			} else {
+				/*
+				 *      |new......| ->         |new...|
+				 * |old....|        -> |old....|
+				 */
+				map__add_pgoff(new_map, map__end(old_map) - map__start(new_map));
+				map__set_start(new_map, map__end(old_map));
+			}
+		}
+	}
+
+out:
+	while (!list_empty(&merged)) {
+		struct map_list_node *old_node;
+
+		old_node = list_entry(merged.next, struct map_list_node, node);
+		list_del_init(&old_node->node);
+		if (!err)
+			err = maps__insert(kmaps, old_node->map);
+		map__put(old_node->map);
+		free(old_node);
+	}
+
+	if (new_map) {
+		if (!err)
+			err = maps__insert(kmaps, new_map);
+		map__put(new_map);
+	}
+	return err;
+}
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index 83144e0645ed..a689149be8c4 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -21,6 +21,16 @@ struct map_rb_node {
 	struct map *map;
 };
 
+struct map_list_node {
+	struct list_head node;
+	struct map *map;
+};
+
+static inline struct map_list_node *map_list_node__new(void)
+{
+	return malloc(sizeof(struct map_list_node));
+}
+
 struct map_rb_node *maps__first(struct maps *maps);
 struct map_rb_node *map_rb_node__next(struct map_rb_node *node);
 struct map_rb_node *maps__find_node(struct maps *maps, struct map *map);
@@ -133,4 +143,6 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map);
 
 void __maps__sort_by_name(struct maps *maps);
 
+void maps__fixup_end(struct maps *maps);
+
 #endif // __PERF_MAPS_H
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 314c0263bf3c..1cc42b8d8afb 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -48,11 +48,6 @@ static bool symbol__is_idle(const char *name);
 int vmlinux_path__nr_entries;
 char **vmlinux_path;
 
-struct map_list_node {
-	struct list_head node;
-	struct map *map;
-};
-
 struct symbol_conf symbol_conf = {
 	.nanosecs		= false,
 	.use_modules		= true,
@@ -90,11 +85,6 @@ static enum dso_binary_type binary_type_symtab[] = {
 
 #define DSO_BINARY_TYPE__SYMTAB_CNT ARRAY_SIZE(binary_type_symtab)
 
-static struct map_list_node *map_list_node__new(void)
-{
-	return malloc(sizeof(struct map_list_node));
-}
-
 static bool symbol_type__filter(char symbol_type)
 {
 	symbol_type = toupper(symbol_type);
@@ -270,29 +260,6 @@ void symbols__fixup_end(struct rb_root_cached *symbols, bool is_kallsyms)
 		curr->end = roundup(curr->start, 4096) + 4096;
 }
 
-void maps__fixup_end(struct maps *maps)
-{
-	struct map_rb_node *prev = NULL, *curr;
-
-	down_write(maps__lock(maps));
-
-	maps__for_each_entry(maps, curr) {
-		if (prev != NULL && !map__end(prev->map))
-			map__set_end(prev->map, map__start(curr->map));
-
-		prev = curr;
-	}
-
-	/*
-	 * We still haven't the actual symbols, so guess the
-	 * last map final address.
-	 */
-	if (curr && !map__end(curr->map))
-		map__set_end(curr->map, ~0ULL);
-
-	up_write(maps__lock(maps));
-}
-
 struct symbol *symbol__new(u64 start, u64 len, u8 binding, u8 type, const char *name)
 {
 	size_t namelen = strlen(name) + 1;
@@ -1270,103 +1237,6 @@ static int kcore_mapfn(u64 start, u64 len, u64 pgoff, void *data)
 	return 0;
 }
 
-/*
- * Merges map into maps by splitting the new map within the existing map
- * regions.
- */
-int maps__merge_in(struct maps *kmaps, struct map *new_map)
-{
-	struct map_rb_node *rb_node;
-	LIST_HEAD(merged);
-	int err = 0;
-
-	maps__for_each_entry(kmaps, rb_node) {
-		struct map *old_map = rb_node->map;
-
-		/* no overload with this one */
-		if (map__end(new_map) < map__start(old_map) ||
-		    map__start(new_map) >= map__end(old_map))
-			continue;
-
-		if (map__start(new_map) < map__start(old_map)) {
-			/*
-			 * |new......
-			 *       |old....
-			 */
-			if (map__end(new_map) < map__end(old_map)) {
-				/*
-				 * |new......|     -> |new..|
-				 *       |old....| ->       |old....|
-				 */
-				map__set_end(new_map, map__start(old_map));
-			} else {
-				/*
-				 * |new.............| -> |new..|       |new..|
-				 *       |old....|    ->       |old....|
-				 */
-				struct map_list_node *m = map_list_node__new();
-
-				if (!m) {
-					err = -ENOMEM;
-					goto out;
-				}
-
-				m->map = map__clone(new_map);
-				if (!m->map) {
-					free(m);
-					err = -ENOMEM;
-					goto out;
-				}
-
-				map__set_end(m->map, map__start(old_map));
-				list_add_tail(&m->node, &merged);
-				map__add_pgoff(new_map, map__end(old_map) - map__start(new_map));
-				map__set_start(new_map, map__end(old_map));
-			}
-		} else {
-			/*
-			 *      |new......
-			 * |old....
-			 */
-			if (map__end(new_map) < map__end(old_map)) {
-				/*
-				 *      |new..|   -> x
-				 * |old.........| -> |old.........|
-				 */
-				map__put(new_map);
-				new_map = NULL;
-				break;
-			} else {
-				/*
-				 *      |new......| ->         |new...|
-				 * |old....|        -> |old....|
-				 */
-				map__add_pgoff(new_map, map__end(old_map) - map__start(new_map));
-				map__set_start(new_map, map__end(old_map));
-			}
-		}
-	}
-
-out:
-	while (!list_empty(&merged)) {
-		struct map_list_node *old_node;
-
-		old_node = list_entry(merged.next, struct map_list_node, node);
-		list_del_init(&old_node->node);
-		if (!err)
-			err = maps__insert(kmaps, old_node->map);
-		map__put(old_node->map);
-		free(old_node);
-	}
-
-	if (new_map) {
-		if (!err)
-			err = maps__insert(kmaps, new_map);
-		map__put(new_map);
-	}
-	return err;
-}
-
 static int dso__load_kcore(struct dso *dso, struct map *map,
 			   const char *kallsyms_filename)
 {
@@ -2065,124 +1935,6 @@ int dso__load(struct dso *dso, struct map *map)
 	return ret;
 }
 
-static int map__strcmp(const void *a, const void *b)
-{
-	const struct map *map_a = *(const struct map **)a;
-	const struct map *map_b = *(const struct map **)b;
-	const struct dso *dso_a = map__dso(map_a);
-	const struct dso *dso_b = map__dso(map_b);
-	int ret = strcmp(dso_a->short_name, dso_b->short_name);
-
-	if (ret == 0 && map_a != map_b) {
-		/*
-		 * Ensure distinct but name equal maps have an order in part to
-		 * aid reference counting.
-		 */
-		ret = (int)map__start(map_a) - (int)map__start(map_b);
-		if (ret == 0)
-			ret = (int)((intptr_t)map_a - (intptr_t)map_b);
-	}
-
-	return ret;
-}
-
-static int map__strcmp_name(const void *name, const void *b)
-{
-	const struct dso *dso = map__dso(*(const struct map **)b);
-
-	return strcmp(name, dso->short_name);
-}
-
-void __maps__sort_by_name(struct maps *maps)
-{
-	qsort(maps__maps_by_name(maps), maps__nr_maps(maps), sizeof(struct map *), map__strcmp);
-}
-
-static int map__groups__sort_by_name_from_rbtree(struct maps *maps)
-{
-	struct map_rb_node *rb_node;
-	struct map **maps_by_name = realloc(maps__maps_by_name(maps),
-					    maps__nr_maps(maps) * sizeof(struct map *));
-	int i = 0;
-
-	if (maps_by_name == NULL)
-		return -1;
-
-	up_read(maps__lock(maps));
-	down_write(maps__lock(maps));
-
-	RC_CHK_ACCESS(maps)->maps_by_name = maps_by_name;
-	RC_CHK_ACCESS(maps)->nr_maps_allocated = maps__nr_maps(maps);
-
-	maps__for_each_entry(maps, rb_node)
-		maps_by_name[i++] = map__get(rb_node->map);
-
-	__maps__sort_by_name(maps);
-
-	up_write(maps__lock(maps));
-	down_read(maps__lock(maps));
-
-	return 0;
-}
-
-static struct map *__maps__find_by_name(struct maps *maps, const char *name)
-{
-	struct map **mapp;
-
-	if (maps__maps_by_name(maps) == NULL &&
-	    map__groups__sort_by_name_from_rbtree(maps))
-		return NULL;
-
-	mapp = bsearch(name, maps__maps_by_name(maps), maps__nr_maps(maps),
-		       sizeof(*mapp), map__strcmp_name);
-	if (mapp)
-		return *mapp;
-	return NULL;
-}
-
-struct map *maps__find_by_name(struct maps *maps, const char *name)
-{
-	struct map_rb_node *rb_node;
-	struct map *map;
-
-	down_read(maps__lock(maps));
-
-
-	if (RC_CHK_ACCESS(maps)->last_search_by_name) {
-		const struct dso *dso = map__dso(RC_CHK_ACCESS(maps)->last_search_by_name);
-
-		if (strcmp(dso->short_name, name) == 0) {
-			map = RC_CHK_ACCESS(maps)->last_search_by_name;
-			goto out_unlock;
-		}
-	}
-	/*
-	 * If we have maps->maps_by_name, then the name isn't in the rbtree,
-	 * as maps->maps_by_name mirrors the rbtree when lookups by name are
-	 * made.
-	 */
-	map = __maps__find_by_name(maps, name);
-	if (map || maps__maps_by_name(maps) != NULL)
-		goto out_unlock;
-
-	/* Fallback to traversing the rbtree... */
-	maps__for_each_entry(maps, rb_node) {
-		struct dso *dso;
-
-		map = rb_node->map;
-		dso = map__dso(map);
-		if (strcmp(dso->short_name, name) == 0) {
-			RC_CHK_ACCESS(maps)->last_search_by_name = map;
-			goto out_unlock;
-		}
-	}
-	map = NULL;
-
-out_unlock:
-	up_read(maps__lock(maps));
-	return map;
-}
-
 int dso__load_vmlinux(struct dso *dso, struct map *map,
 		      const char *vmlinux, bool vmlinux_allocated)
 {
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index af87c46b3f89..071837ddce2a 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -189,7 +189,6 @@ void __symbols__insert(struct rb_root_cached *symbols, struct symbol *sym,
 void symbols__insert(struct rb_root_cached *symbols, struct symbol *sym);
 void symbols__fixup_duplicate(struct rb_root_cached *symbols);
 void symbols__fixup_end(struct rb_root_cached *symbols, bool is_kallsyms);
-void maps__fixup_end(struct maps *maps);
 
 typedef int (*mapfn_t)(u64 start, u64 len, u64 pgoff, void *data);
 int file__read_maps(int fd, bool exe, mapfn_t mapfn, void *data,
-- 
2.42.0.869.gea05f2083d-goog

