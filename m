Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F4B20B3C
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 17:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JeNdZ1Jd"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51CBD69
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 10:58:56 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7cf717bacso17912047b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Nov 2023 10:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947936; x=1699552736; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RHdMaVmD9Twdp4Gp2dcs3TPKRQRPhfQvajrZyFSG8h0=;
        b=JeNdZ1JdhX1qIyfk7MwDxG9f7XXX469Gy6XK4R1J+/QzC3Mt/qomWv53Tht3/xr6b+
         1984/w8OpqokJu/BVb7SOMc0PzYJON0S+RGvyHhYVBnKlIDIN/uNttVkWW4d/BF/eNQb
         jNDPZLZjPa2/X7MD2rQ5RETaiCfcNhMRLcgF2fIGDRfL/wCLF3FCYB6YH+vlMTPF6BcL
         HiylBoBWMp+ry9uNtsjEAi04tQ/3X47w1cgkE7nRnabH/i/IU7vRdCAzr+gX/mjA+J04
         34a6VFrXjxK9lNMUJLQ6Wo0xgUdLXvVHIp9hunYo6BThGYMx5cHk7sWvCpx9g/0bYlhf
         7NGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947936; x=1699552736;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RHdMaVmD9Twdp4Gp2dcs3TPKRQRPhfQvajrZyFSG8h0=;
        b=Qfscu6m7owC8k05PJsWG35a8mST0aVuOybpQhpMty9/BG7GUjS2tdvWvUWDRSxRoDV
         5sLD9oqGj6mjbRLvtxbwMvgR2bt16TLJP4f7TtLrBSQr2vaLxWHfpK/dQVd1L3rBq8qp
         b1HQADDfTwy74XLO3GsomAQqiMdcechnqLIuXT8T5+xlGEMeTfRrbligPCq2lJcAiZ/m
         /5RxUJ3junNFVKIroUHCVPJZEyYhnnLOov7MUwAw0VE2W4HWpZ1Rk+u3lgyPThg9iilH
         TWYd8KcKOxkxD7nhQj3f2kiES/X8SQqoyC1wVd9t7hpiKri+cJve7ReUJqTVsQyfjY8T
         eN9w==
X-Gm-Message-State: AOJu0YwH2gYCOsF2PZ7VzeONdUXkBWfAMEfj6iFnKgGBoFwsN37vUKcR
	urH5B8F7UDE2xJr3J7+N8ThY3PSSUX+P
X-Google-Smtp-Source: AGHT+IE/5SncuHboetfX9h9c0PAA7PcTKU9uOn+5WvB559DiYaCCGE9A5q422sPRRlNm51aRIHKdn7UNWxA1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a0d:d5d2:0:b0:5a7:ad67:b4b6 with SMTP id
 x201-20020a0dd5d2000000b005a7ad67b4b6mr9215ywd.2.1698947935866; Thu, 02 Nov
 2023 10:58:55 -0700 (PDT)
Date: Thu,  2 Nov 2023 10:57:08 -0700
In-Reply-To: <20231102175735.2272696-1-irogers@google.com>
Message-Id: <20231102175735.2272696-27-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 26/53] perf maps: Reduce scope of map_rb_node and maps internals
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
2.42.0.869.gea05f2083d-goog

