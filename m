Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HtMZ9Zvg"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C787E269D
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:10:17 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5ca61d84dc3so57564697b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701123017; x=1701727817; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jKzr4H8qcCWkzlhhc5mjc/fFOHye0m+UsUUrI2SedSA=;
        b=HtMZ9Zvgj5ZtK5nQb4syb6X+0JZdUGOwgIzsY+sCZ1WxNSPpPwsApBt9NqmLb1e/aO
         CEiqc8oDdKctNCYZ77cT9ofL4vl7cMntVok3wrFX0Ak1UJbZFqGqJLP2FF+7mDXw8yqX
         CYP+yThPsFQeE6L5/BRZyDgrKoM2bC+6hKrQYsmSvo05WcRw5ko70cVV/FFIsjOU6svv
         k07yV1EVhcs2Ma7Nxlgo4KtjjIfUKl4TFsUoByCRX6WUwrrG9gZr1zoxiQ4jACOsqUYb
         GgyRvCsOwf8Z69zbjp4ryYCnZREHaqeojUszYwH1Czbl/cGbnxvI1iqOmQy/ZfS1zb/5
         5vbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701123017; x=1701727817;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jKzr4H8qcCWkzlhhc5mjc/fFOHye0m+UsUUrI2SedSA=;
        b=PlZdRR9bbsMM4xmSOqFeIC+BPlFja9Otx9ZPSo9dzVXB1d6YSsHQaxCRACO346tGrR
         CP7y5cYSvmzVwc934RsPrSOgEATjB24MBy7Qn2p9IoCjyKNBQNWQ8N5lhjjlNMN/O8ry
         dnbLt3CTrkFB3Mq/6R6r2kURSIe1qRPIBNJXp9vNRTS4QI6n1pLQ4AIeqqrlHTJaV1xi
         As0Z5sp9Vg9Vu3f0eygDjuD12fykV9mVym6ZLEmHR5L2iCY6V+QkZakUvp/fCIkcm88A
         /jKsxp3Xy77xVR4ZmTn0uS1mPYhd2vBskcQ0th6kbq/wtWQuL9htdOwwfPiQYHCxHe1I
         SbQg==
X-Gm-Message-State: AOJu0Yw7Oi+BhVNMqwFYgBo4InTwSdt9Q7r+HN54sUC591o8S68oek/M
	nyu6LfSENB8ClqUNgEjORfxj866vPPdV
X-Google-Smtp-Source: AGHT+IFJle4INsVGPSDBR1xRQd8J7thNGlnSrJnGQPECathmKLurp7jYbvbJe+Y8Yr2fTDevXLkgMuHftixt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:829:6e77:9093:f39b])
 (user=irogers job=sendgmr) by 2002:a05:690c:480d:b0:5ce:a88:8436 with SMTP id
 hc13-20020a05690c480d00b005ce0a888436mr379574ywb.10.1701123016797; Mon, 27
 Nov 2023 14:10:16 -0800 (PST)
Date: Mon, 27 Nov 2023 14:08:35 -0800
In-Reply-To: <20231127220902.1315692-1-irogers@google.com>
Message-Id: <20231127220902.1315692-24-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v5 23/50] perf maps: Reduce scope of map_rb_node and maps internals
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

Avoid exposing the implementation of maps so that the internals can be
refactored.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c | 90 ++++++++++++++++++++++++++----------------
 tools/perf/util/maps.h | 23 -----------
 2 files changed, 55 insertions(+), 58 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 38d56709bd5e..01c15d0b300a 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -10,6 +10,11 @@
 #include "ui/ui.h"
 #include "unwind.h"
 
+struct map_rb_node {
+	struct rb_node rb_node;
+	struct map *map;
+};
+
 #define maps__for_each_entry(maps, map) \
 	for (map = maps__first(maps); map; map = map_rb_node__next(map))
 
@@ -17,6 +22,56 @@
 	for (map = maps__first(maps), next = map_rb_node__next(map); map; \
 	     map = next, next = map_rb_node__next(map))
 
+static struct rb_root *maps__entries(struct maps *maps)
+{
+	return &RC_CHK_ACCESS(maps)->entries;
+}
+
+static struct rw_semaphore *maps__lock(struct maps *maps)
+{
+	return &RC_CHK_ACCESS(maps)->lock;
+}
+
+static struct map **maps__maps_by_name(struct maps *maps)
+{
+	return RC_CHK_ACCESS(maps)->maps_by_name;
+}
+
+static struct map_rb_node *maps__first(struct maps *maps)
+{
+	struct rb_node *first = rb_first(maps__entries(maps));
+
+	if (first)
+		return rb_entry(first, struct map_rb_node, rb_node);
+	return NULL;
+}
+
+static struct map_rb_node *map_rb_node__next(struct map_rb_node *node)
+{
+	struct rb_node *next;
+
+	if (!node)
+		return NULL;
+
+	next = rb_next(&node->rb_node);
+
+	if (!next)
+		return NULL;
+
+	return rb_entry(next, struct map_rb_node, rb_node);
+}
+
+static struct map_rb_node *maps__find_node(struct maps *maps, struct map *map)
+{
+	struct map_rb_node *rb_node;
+
+	maps__for_each_entry(maps, rb_node) {
+		if (rb_node->RC_CHK_ACCESS(map) == RC_CHK_ACCESS(map))
+			return rb_node;
+	}
+	return NULL;
+}
+
 static void maps__init(struct maps *maps, struct machine *machine)
 {
 	refcount_set(maps__refcnt(maps), 1);
@@ -484,17 +539,6 @@ int maps__copy_from(struct maps *maps, struct maps *parent)
 	return err;
 }
 
-struct map_rb_node *maps__find_node(struct maps *maps, struct map *map)
-{
-	struct map_rb_node *rb_node;
-
-	maps__for_each_entry(maps, rb_node) {
-		if (rb_node->RC_CHK_ACCESS(map) == RC_CHK_ACCESS(map))
-			return rb_node;
-	}
-	return NULL;
-}
-
 struct map *maps__find(struct maps *maps, u64 ip)
 {
 	struct rb_node *p;
@@ -520,30 +564,6 @@ struct map *maps__find(struct maps *maps, u64 ip)
 	return m ? m->map : NULL;
 }
 
-struct map_rb_node *maps__first(struct maps *maps)
-{
-	struct rb_node *first = rb_first(maps__entries(maps));
-
-	if (first)
-		return rb_entry(first, struct map_rb_node, rb_node);
-	return NULL;
-}
-
-struct map_rb_node *map_rb_node__next(struct map_rb_node *node)
-{
-	struct rb_node *next;
-
-	if (!node)
-		return NULL;
-
-	next = rb_next(&node->rb_node);
-
-	if (!next)
-		return NULL;
-
-	return rb_entry(next, struct map_rb_node, rb_node);
-}
-
 static int map__strcmp(const void *a, const void *b)
 {
 	const struct map *map_a = *(const struct map **)a;
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index 84b42c8456e8..d836d04c9402 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -15,11 +15,6 @@ struct machine;
 struct map;
 struct maps;
 
-struct map_rb_node {
-	struct rb_node rb_node;
-	struct map *map;
-};
-
 struct map_list_node {
 	struct list_head node;
 	struct map *map;
@@ -30,9 +25,6 @@ static inline struct map_list_node *map_list_node__new(void)
 	return malloc(sizeof(struct map_list_node));
 }
 
-struct map_rb_node *maps__first(struct maps *maps);
-struct map_rb_node *map_rb_node__next(struct map_rb_node *node);
-struct map_rb_node *maps__find_node(struct maps *maps, struct map *map);
 struct map *maps__find(struct maps *maps, u64 addr);
 
 DECLARE_RC_STRUCT(maps) {
@@ -78,26 +70,11 @@ int maps__for_each_map(struct maps *maps, int (*cb)(struct map *map, void *data)
 /* Iterate over map removing an entry if cb returns true. */
 void maps__remove_maps(struct maps *maps, bool (*cb)(struct map *map, void *data), void *data);
 
-static inline struct rb_root *maps__entries(struct maps *maps)
-{
-	return &RC_CHK_ACCESS(maps)->entries;
-}
-
 static inline struct machine *maps__machine(struct maps *maps)
 {
 	return RC_CHK_ACCESS(maps)->machine;
 }
 
-static inline struct rw_semaphore *maps__lock(struct maps *maps)
-{
-	return &RC_CHK_ACCESS(maps)->lock;
-}
-
-static inline struct map **maps__maps_by_name(struct maps *maps)
-{
-	return RC_CHK_ACCESS(maps)->maps_by_name;
-}
-
 static inline unsigned int maps__nr_maps(const struct maps *maps)
 {
 	return RC_CHK_ACCESS(maps)->nr_maps;
-- 
2.43.0.rc1.413.gea7ed67945-goog

