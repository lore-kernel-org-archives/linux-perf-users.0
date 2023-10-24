Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6143E48D
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 22:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WwiL0kET"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF31819B0
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:25:12 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da033914f7cso1624926276.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186311; x=1698791111; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7vTFa96ZEcmOMRrSkowrskUF+opgcolRiQV7lf4w06o=;
        b=WwiL0kET0a95L0luaxOKtH4R3VPSPwxnyqOk+vFT+lD/MzeCiYgObQYh729/vSSpGv
         l8dW9g0lS5N0Is1ijZzluZcmh5aykHF9Da8/sTNGfuZ/vZ6cBayNjPsDX/PNZCKWrbDi
         PkAwiSBTIjir6zl+hYw5UCD6R+Krwkgnaapfc+rQxhRONPnWe71PXeRjTSbept7lKEp7
         WRoHna46e1UPiNYnTkEMggPbHLnTDHDsfgA0Mu/rJBIv3iVhmO+1fg4k7ZbAVwQAngFM
         nuM/AdNCt9uo/KnF1ObboCZPgrzn4ru7CHoekodr5CQl0B8aFI6d9dXhLzy75ir0qtqc
         Vw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186311; x=1698791111;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7vTFa96ZEcmOMRrSkowrskUF+opgcolRiQV7lf4w06o=;
        b=XkmUoUenDcO5sZ3vemMed5cKEQkUcErrmrytinNKJhb/5ESb63kJufBx4uNciNq79W
         rWk/GciwPq7OGKTZLKjLbI0YIFipUmGoPcmLe+V8HPO35SEmRhqYBD5RRKQGA4eTlX80
         CDYU7KXRw+V4Kl0B5QiQbXZVDHF3Bxz0szXBozWx7fWqvjbVhrzu1byjKaBhmNXikPPk
         +Ivt1wc/FalSmoHG62W4xTOLd73TOL8+bU4qNQpj/Mq2bU9LQF6QBd/Mfy1GQOY8CWJq
         ojRWRyZaw79EccPN6leEdw8yVbL/lbs+CtKLStEAilLkpxtdsAE+/bCXYTn+lkVFTHzm
         Gupg==
X-Gm-Message-State: AOJu0YwQll2/+GVq5N5Ia6AgZWKX4EjxKOE2ZWq/OCklIO+tcFDzyu00
	Y29+X2l0DCban587fbpktEPYKJ+SOAOj
X-Google-Smtp-Source: AGHT+IGXXGc5DKusMxBPUMDaTFA+8Fb3jL2JT1jtI+8spbEXNI8FwyqOUjcmvYUrJTwL1FjS4seK1XiRUDbl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a25:aaa9:0:b0:d9a:3a14:a5a2 with SMTP id
 t38-20020a25aaa9000000b00d9a3a14a5a2mr247702ybi.13.1698186311625; Tue, 24 Oct
 2023 15:25:11 -0700 (PDT)
Date: Tue, 24 Oct 2023 15:23:29 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-27-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 26/50] perf maps: Move symbol maps functions to maps.c
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
2.42.0.758.gaed0368e0e-goog

