Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6573F4D9
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 22:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ID9QBfXd"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CF326B6
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:25:20 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a818c1d2c7so67910377b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186318; x=1698791118; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pZmLuOzKOZWnfcppPkzxkV5fHZsLOBY0ABvxWYK/enc=;
        b=ID9QBfXdKzQpRhPP1pLBWsBqXDwvD4tx5lGwebDU+tMCIdIec9UizeDmQVVi7Lj6T7
         kTZCgylWzQWvQ+/0jyAFYrou+h05rcoG4IYZEEZzkP1S23FixAPK7SffQbeICeX91ifl
         tabqnjxixZu4V0JrSGuh/u0QIaI1funTcwQv9h6CYEDCYHohDWCnK+ZwOU8EdfdumYsC
         hGGbuaWdWer42j30Vg9Bfr5yHaQazN5nK5XIW9NVN7DdEY0MrA633MU3gXYvOZLW5WoP
         ULEjC/szs8H7+A+IbXehdDY+Pz3aiT418JdiCFZVbGwDTwjzmBm6KqhUlk0fPvYM1jrX
         CJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186318; x=1698791118;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pZmLuOzKOZWnfcppPkzxkV5fHZsLOBY0ABvxWYK/enc=;
        b=bVXVuFZkj7ReGyhgvIKU1JxXkgFVz683T7DqAmusyEvtxwpQRmDG/LNzaabDeQsHnk
         VPhCuYV7JcmH0LV0obwyntUaWPgYu4Ckk45r2CZUhJ8BdPRfNQZh/eVz4+XXP88+0jzB
         jYBlsI08GeGsWZwe/8kAsbXgp9tU7v1B1Rpwu9+MrGymSiRnx9v5Utnt7qsbtAOsk9EU
         sdfl7PVqjCOBUgMPTUon0kXT1iAsSWKkMdyjoXW4eNvH3Yng0QmFglxMqAZEsurCVarD
         +OOtLXYkFl4t1UbMf8ydEHKpMtFMMwsGS1MMX6EP1BLVQkQQ5MBR/ycDdtMv/+hQXcjI
         +Gyw==
X-Gm-Message-State: AOJu0YzYPxnGSM3ARuPNo3U3Y1ekma1oBBo6jU5Bt9NVjLyAiATn55Aq
	eoQ6y7vbdmYM9PRlfAPFvwEJQsWIIB4o
X-Google-Smtp-Source: AGHT+IHyzctCClnCKKRiBfWMxj+KXkNvs+dEJRni839bJcbmNMvWz4cQmRuKwnepiXHcCccKeecGHb4nDbRA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a0d:ca8b:0:b0:589:a855:7af with SMTP id
 m133-20020a0dca8b000000b00589a85507afmr268607ywd.7.1698186318505; Tue, 24 Oct
 2023 15:25:18 -0700 (PDT)
Date: Tue, 24 Oct 2023 15:23:32 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-30-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 29/50] perf maps: Add remove maps function to remove a map
 based on callback
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

Removing maps wasn't being done under the write lock. Similar to
maps__for_each_map, iterate the entries but in this case remove the
entry based on the result of the callback. If an entry was removed
then maps_by_name also needs updating, so add missed flush.

In dso__load_kcore, the test of map to save would always be false with
REFCNT_CHECKING because of a missing RC_CHK_ACCESS.

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
index 72f03b875478..30da8a405d11 100644
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
+	return RC_CHK_ACCESS(map) != RC_CHK_ACCESS(map_to_save) && !__map__is_bpf_prog(map);
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
2.42.0.758.gaed0368e0e-goog

