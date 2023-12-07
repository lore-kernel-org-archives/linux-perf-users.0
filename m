Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MyCF4wh1"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECD21BCB
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Dec 2023 17:18:02 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d8da78a5fbso1680317b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Dec 2023 17:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911880; x=1702516680; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ozafK+YxnV8oHaLDKY1idAuezimM/K5JtLiBl1FMWy4=;
        b=MyCF4wh1Q3febjw4LwmXl9bao3ZdbKX8Rzsvgng5/kl+IvjKT3ddVR8g4vC7nBGIdq
         95Ire528ngTWyB0iz3iWLtYo0TY/2HdD0bmNh7vo94TJ6EKC5SJwzXCFMBj2tuF2bPaG
         ypVBi7qC+uwiieUkidJ6UZAm8gVB0P2wiFF3XkMj4lIguVHcE2SKJebJWPb1zByDrETT
         pBakj177G+jSGcWuPrJLjyS2BiUShxDshzuJGYrDtOlXJqwlDxPO3HuQam0zQ+C0X4jO
         DcePsqT4LUR+ZtuZcyfx1gNR8VNXZz7G2PtWNUSm+vbpDjpubYkiDVY8OJDSfmUpGX6T
         TqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911880; x=1702516680;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ozafK+YxnV8oHaLDKY1idAuezimM/K5JtLiBl1FMWy4=;
        b=O3pv19DbOe5d3Wv4GjwZhBSOh+j+7KLSAj2SQ+ag5mXq0qoXjlpZMTtVGsNCELw4XR
         RwHGbdR0t2iPaLxgL8L1WSN6gR2YEP5zLjyzfFO5NBsXMYAeVfzFslVxKD9b3RQ2So4a
         NlZw194KW2vVjG3ZjXwctp+ooFPxcLW8PZ73hDmKLrpwhYT4c02I4TF7CdYDAXxDyiKY
         pNbXIKqzNCmBsH+xv+uJNoAivjEgqZWVJLrc9pSF8vsMbJo4AO08RS/0sQ5mAeC+pwhb
         2+wd7fTmiXZbjmm1ciZKiiWRgIvdmMp5rYlVKaxS/c05J8InR/f6SWQf9T7f0M8OEael
         hPwQ==
X-Gm-Message-State: AOJu0YzuLa3VXaJ0tY0GCxwkVwUAQxKJH3KePzdTOTgKCJiMHeASbrdJ
	70SjGLbuMBGrk7mzPn4UMRp9DDN3wfnd
X-Google-Smtp-Source: AGHT+IHYqtg3wYZ6Cj08Ag7z/4V1Ij15UrdLWEAPGm8HG4oMYnwYyjGXa+uN2xWtnqN6l8o3Gje33p48Xtgx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a05:690c:98b:b0:5d4:2ff3:d280 with SMTP id
 ce11-20020a05690c098b00b005d42ff3d280mr27363ywb.7.1701911879847; Wed, 06 Dec
 2023 17:17:59 -0800 (PST)
Date: Wed,  6 Dec 2023 17:16:48 -0800
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
Message-Id: <20231207011722.1220634-15-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 14/47] perf maps: Add remove maps function to remove a map
 based on callback
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

Removing maps wasn't being done under the write lock. Similar to
maps__for_each_map, iterate the entries but in this case remove the
entry based on the result of the callback. If an entry was removed
then maps_by_name also needs updating, so add missed flush.

In dso__load_kcore, the test of map to save would always be false with
REFCNT_CHECKING because of a missing RC_CHK_ACCESS/RC_CHK_EQUAL.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c   | 24 ++++++++++++++++++++++++
 tools/perf/util/maps.h   |  6 ++----
 tools/perf/util/symbol.c | 24 ++++++++++++------------
 3 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 00e6589bba10..f13fd3a9686b 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -13,6 +13,10 @@
 #define maps__for_each_entry(maps, map) \
 	for (map = maps__first(maps); map; map = map_rb_node__next(map))
 
+#define maps__for_each_entry_safe(maps, map, next) \
+	for (map = maps__first(maps), next = map_rb_node__next(map); map; \
+	     map = next, next = map_rb_node__next(map))
+
 static void maps__init(struct maps *maps, struct machine *machine)
 {
 	refcount_set(maps__refcnt(maps), 1);
@@ -214,6 +218,26 @@ int maps__for_each_map(struct maps *maps, int (*cb)(struct map *map, void *data)
 	return ret;
 }
 
+void maps__remove_maps(struct maps *maps, bool (*cb)(struct map *map, void *data), void *data)
+{
+	struct map_rb_node *pos, *next;
+	unsigned int start_nr_maps;
+
+	down_write(maps__lock(maps));
+
+	start_nr_maps = maps__nr_maps(maps);
+	maps__for_each_entry_safe(maps, pos, next)	{
+		if (cb(pos->map, data)) {
+			__maps__remove(maps, pos);
+			--RC_CHK_ACCESS(maps)->nr_maps;
+		}
+	}
+	if (maps__maps_by_name(maps) && start_nr_maps != maps__nr_maps(maps))
+		__maps__free_maps_by_name(maps);
+
+	up_write(maps__lock(maps));
+}
+
 struct symbol *maps__find_symbol(struct maps *maps, u64 addr, struct map **mapp)
 {
 	struct map *map = maps__find(maps, addr);
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index 8ac30cdaf5bd..b94ad5c8fea7 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -36,10 +36,6 @@ struct map_rb_node *map_rb_node__next(struct map_rb_node *node);
 struct map_rb_node *maps__find_node(struct maps *maps, struct map *map);
 struct map *maps__find(struct maps *maps, u64 addr);
 
-#define maps__for_each_entry_safe(maps, map, next) \
-	for (map = maps__first(maps), next = map_rb_node__next(map); map; \
-	     map = next, next = map_rb_node__next(map))
-
 DECLARE_RC_STRUCT(maps) {
 	struct rb_root      entries;
 	struct rw_semaphore lock;
@@ -80,6 +76,8 @@ static inline void __maps__zput(struct maps **map)
 
 /* Iterate over map calling cb for each entry. */
 int maps__for_each_map(struct maps *maps, int (*cb)(struct map *map, void *data), void *data);
+/* Iterate over map removing an entry if cb returns true. */
+void maps__remove_maps(struct maps *maps, bool (*cb)(struct map *map, void *data), void *data);
 
 static inline struct rb_root *maps__entries(struct maps *maps)
 {
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 72f03b875478..be212ba157dc 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1239,13 +1239,23 @@ static int kcore_mapfn(u64 start, u64 len, u64 pgoff, void *data)
 	return 0;
 }
 
+static bool remove_old_maps(struct map *map, void *data)
+{
+	const struct map *map_to_save = data;
+
+	/*
+	 * We need to preserve eBPF maps even if they are covered by kcore,
+	 * because we need to access eBPF dso for source data.
+	 */
+	return !RC_CHK_EQUAL(map, map_to_save) && !__map__is_bpf_prog(map);
+}
+
 static int dso__load_kcore(struct dso *dso, struct map *map,
 			   const char *kallsyms_filename)
 {
 	struct maps *kmaps = map__kmaps(map);
 	struct kcore_mapfn_data md;
 	struct map *replacement_map = NULL;
-	struct map_rb_node *old_node, *next;
 	struct machine *machine;
 	bool is_64_bit;
 	int err, fd;
@@ -1292,17 +1302,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 	}
 
 	/* Remove old maps */
-	maps__for_each_entry_safe(kmaps, old_node, next) {
-		struct map *old_map = old_node->map;
-
-		/*
-		 * We need to preserve eBPF maps even if they are
-		 * covered by kcore, because we need to access
-		 * eBPF dso for source data.
-		 */
-		if (old_map != map && !__map__is_bpf_prog(old_map))
-			maps__remove(kmaps, old_map);
-	}
+	maps__remove_maps(kmaps, remove_old_maps, map);
 	machine->trampolines_mapped = false;
 
 	/* Find the kernel map using the '_stext' symbol */
-- 
2.43.0.rc2.451.g8631bc7472-goog

