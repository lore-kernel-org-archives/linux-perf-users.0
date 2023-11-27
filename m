Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1F0Y4RdN"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DDA1FF1
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:10:01 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db3fc4a1254so5501901276.3
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701123001; x=1701727801; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dubn7azNjRzLb/gPhpvhXF4YdgS4DTAmzBs+Pldy+XA=;
        b=1F0Y4RdNqaCYCQTk06YJ6pUPFLkE7uIJ1/Ya10PV8BgKPIRrjQMmXJ82pbYpsttWBT
         SAURZX/TBEpHGC7ZComRk2qzGAtgSPJgUmG3C1ihtma3AIQ5pMZKnNok3r0ElsaG2rlP
         6VZSEtKB5trBSeqnts5YZPydD/hgYXHuG677NWsK7N+aZYMI8hOeEXCMXCn39POryreL
         biP8FrIrTlH6ASc6ZLghFPeXBjDK3y99+/WJfFvyzEwFKVv+lYBbj51CxkTDQ8sUTJQj
         a7zpiozgiA4W5I9Az4aS0CJ8jupsD0Cg2n4cgedFwxB95GOEYEbqCt4QEp/8Hw2zYNJO
         oXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701123001; x=1701727801;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dubn7azNjRzLb/gPhpvhXF4YdgS4DTAmzBs+Pldy+XA=;
        b=wx9RW57EuSYeJR5IqpL2LBUBVgBbYhsu1NmVp25mtZeAUuIMQgTOF0I46clXkKRO0i
         ikG/H2NIDcbmMbmI9rv2tU/Blg5xKBR4FCCAj7IXwbbx3mtU9/vDkH2NdY+YXL6Nz0ru
         xNqaW324+vaYuKz4PAdxiNp4jkwUjm059w+5M/g50IxKh93k85TztQInK6APINIDv4IX
         J27NvrHbMvoDJpB25yVOOlcy6nOi88YUDt8zitOcwqrU3S16wyBZshSTFmwGbzMZoLEk
         qV4TxIMIYGX/mhxL3QdUMRXM2vie/PS/oaSE8HC6IbVvSE+9vkYfVvXpd+2N0oSTxRMP
         bVKA==
X-Gm-Message-State: AOJu0Yw4q854BeZd5T+Dmp0jXEuLdIanfwBzvBx9cR30EpTZa/d7QBst
	FrW/U8jbNKfgTA5vH5+cQp67H7VEnQfU
X-Google-Smtp-Source: AGHT+IEaOCzWw58O6tkRPhmEwrRer+C2IAwifWt4WHXhCTkV1/h3rdF36OO/vwJHAzjbY7qpMjDmoOokUH97
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:829:6e77:9093:f39b])
 (user=irogers job=sendgmr) by 2002:a05:6902:e91:b0:db4:5e66:98fe with SMTP id
 dg17-20020a0569020e9100b00db45e6698femr358446ybb.11.1701123000839; Mon, 27
 Nov 2023 14:10:00 -0800 (PST)
Date: Mon, 27 Nov 2023 14:08:28 -0800
In-Reply-To: <20231127220902.1315692-1-irogers@google.com>
Message-Id: <20231127220902.1315692-17-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v5 16/50] perf maps: Add remove maps function to remove a map
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
2.43.0.rc1.413.gea7ed67945-goog

