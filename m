Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A811B405C1
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 22:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XtlLXByk"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A625A2D72
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:25:35 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7cf717bacso67706627b3.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186334; x=1698791134; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nzIlX+P2Xnb51CqannJImstzqGSg/CO4GFxV9EhldOc=;
        b=XtlLXBykJVKWfk5yCU+rQn2Ll3gCSIsu1hHyuLDQqWdexiEcx0cDqPhM0Z1y+cxDP8
         FCTxk5T2UFFxH52Wv8sLC5OtK45tol1MiXEuh4hecOSn95JZ1b/wpyGgr2hSBg+6t6/a
         e1Rt7+mLp+K7PMssJ8Aczt3mAMc6qWvofhfNCpjdXmb6WxHdsd6nhaTDZ+vgmB6dSMyn
         v3sLqdx7GtzSUtYarXbyZnXzkOBcdM8la3spVgZqMSNMd8U5mPz9F6iM40I33lw6c/AR
         X9nYb0oNOr+D5GIxoYY4NXtY/y96qK75aXcLWf/rArqs7r8cNUAYbzmJIl8c82kNCYyv
         LlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186334; x=1698791134;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nzIlX+P2Xnb51CqannJImstzqGSg/CO4GFxV9EhldOc=;
        b=MrVwDFgX/pz8K3iwfBay/vyoEn0GXfOgck2mOc8+bLVd9j555J8nMJoLihBJkvQPLu
         5x6G2F6YaZRP3YjX9jtU7/5joZiPonOgoKCoATzyMLToPSg68pP6lXuXvw/XaKm4OdEz
         gJl1waxHjwVqodaNDZDaVKNlIIkoyEH+ANUYOLRLCFKHCtKCy+kC7p06y+2140fBUG6Z
         q9jfMj7QlBYRpkDDy5FRmkmSGaMbDyxFhM6RwvFcV4xVI2HZF4VtSdhl2YlH1PPvkQLo
         q8+KwprzOfghyJZfrTRko2fa/qD4krtCLxGQGGLlPRy93PVaWplY81DhghLssQQCYPPQ
         Fv5g==
X-Gm-Message-State: AOJu0YwqMTaN4qLWbsKlzZ6SnVr4jRAvHwP1CVxQf77kIGfVxG4J/HfH
	cgyknHwLdyXBg+7aYT77ud/aVIQ2JMaG
X-Google-Smtp-Source: AGHT+IG8FPY+Ogk4FsuhljaKZCeaOvPfVDckGfcLgfkV20JexqX0pZ9Dav8nr0jJMm9f0W29T3x30fmqQh9i
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a0d:ca8b:0:b0:589:a855:7af with SMTP id
 m133-20020a0dca8b000000b00589a85507afmr268615ywd.7.1698186333865; Tue, 24 Oct
 2023 15:25:33 -0700 (PDT)
Date: Tue, 24 Oct 2023 15:23:39 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-37-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 36/50] perf maps: Reduce scope of map_rb_node and maps internals
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
2.42.0.758.gaed0368e0e-goog

