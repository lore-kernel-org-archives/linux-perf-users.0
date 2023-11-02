Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA1520B28
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 17:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PiJ9YCaT"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE831735
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 10:58:45 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5afbcffe454so25382387b3.3
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Nov 2023 10:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947924; x=1699552724; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5jQubpFxVympzrNhfbd67emKxgsvnRdgi7XbNym7SkQ=;
        b=PiJ9YCaTy7qZAZM4R7B5ef+vNqEekvkb0PV+/Zonba/2GeU/eC5XYED6Uwp0rGcspH
         CkZxHb2k+qVkMglWdOTjVho7KZmerCTmiea6k9ulrd7LI/79YOWz0KdyT5JtSHwLP7Go
         dKUpcDGkE9ye+Rg70ItVUsW6m0FhW6qTPe1dYYMcPXRR8ucqvfe3DoJYzgkIKiYGmp1H
         0qgiIpdvY06IMH8mD3vEeaKxDSaiqUaBnUmPkXnAXsvx6kDe2hrnVWy43TD7FG57yDi9
         tFj6D7wxRDuS4zFC31dRBepJ8sO11fJlgs50IdM1L0FadSRL4veY4bpqA4LvV6MkVFZs
         Z2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947924; x=1699552724;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5jQubpFxVympzrNhfbd67emKxgsvnRdgi7XbNym7SkQ=;
        b=ZouAmQrVk4AcurRQPlvrs0zloXqcy4GuiBpYREw5lAKnfWBvb/zJwKYzaBwFU3S7zo
         DIDX14Dl6iV14/MT+SOBtDlN65ZXAJAZ/kh4bXHKOZcsd3jtNoQgv6yZzWllUXuLsY2B
         rB3bbw7277kIxVCwaDrn00YvxDmeJAJrbSwmE1dUV1WXqDKnMDI+0wESDPHBXp94qRY3
         /XHnrd1Eg2CbM+ZY6x52yB2kuckQFy1quQFCGPFbZiOBMWnzDc7oBzxwJR4fhJ2L9uVW
         kIy63Dqyz2es8NCtryUuC9XkpFwZCgb+hpdiQ0ZdS2/xiJnTYde0Ojs48kcE36SZzVbm
         wdbA==
X-Gm-Message-State: AOJu0YzNt4y6fApq1Tp1kOfW5pHC9WwESlxWpS8/BB43oo1ZXwWCbk4l
	LpTISNk53unY2czLX2IV0PLdhjZgg/2m
X-Google-Smtp-Source: AGHT+IGiJq5l+L4xve8xg3Po/mADejecbmG3Cugk8Sm33aN6i10Jl9Un7u+qmqiyKlSJhaTZJP++zV/tkJRt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a25:ade4:0:b0:d9a:ff08:e090 with SMTP id
 d36-20020a25ade4000000b00d9aff08e090mr346879ybe.5.1698947924611; Thu, 02 Nov
 2023 10:58:44 -0700 (PDT)
Date: Thu,  2 Nov 2023 10:57:03 -0700
In-Reply-To: <20231102175735.2272696-1-irogers@google.com>
Message-Id: <20231102175735.2272696-22-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 21/53] perf maps: Refactor maps__fixup_overlappings
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

Rename to maps__fixup_overlap_and_insert as the given mapping is
always inserted. Factor out first_ending_after as a utility
function. Minor variable name changes. Switch to using debug_file()
rather than passing a debug FILE*.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c   | 62 ++++++++++++++++++++++++----------------
 tools/perf/util/maps.h   |  2 +-
 tools/perf/util/thread.c |  3 +-
 3 files changed, 39 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index f13fd3a9686b..40df08dd9bf3 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -334,20 +334,16 @@ size_t maps__fprintf(struct maps *maps, FILE *fp)
 	return args.printed;
 }
 
-int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
+/*
+ * Find first map where end > new->start.
+ * Same as find_vma() in kernel.
+ */
+static struct rb_node *first_ending_after(struct maps *maps, const struct map *map)
 {
 	struct rb_root *root;
 	struct rb_node *next, *first;
-	int err = 0;
-
-	down_write(maps__lock(maps));
 
 	root = maps__entries(maps);
-
-	/*
-	 * Find first map where end > map->start.
-	 * Same as find_vma() in kernel.
-	 */
 	next = root->rb_node;
 	first = NULL;
 	while (next) {
@@ -361,8 +357,22 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 		} else
 			next = next->rb_right;
 	}
+	return first;
+}
+
+/*
+ * Adds new to maps, if new overlaps existing entries then the existing maps are
+ * adjusted or removed so that new fits without overlapping any entries.
+ */
+int maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
+{
+
+	struct rb_node *next;
+	int err = 0;
+
+	down_write(maps__lock(maps));
 
-	next = first;
+	next = first_ending_after(maps, new);
 	while (next && !err) {
 		struct map_rb_node *pos = rb_entry(next, struct map_rb_node, rb_node);
 		next = rb_next(&pos->rb_node);
@@ -371,27 +381,27 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 		 * Stop if current map starts after map->end.
 		 * Maps are ordered by start: next will not overlap for sure.
 		 */
-		if (map__start(pos->map) >= map__end(map))
+		if (map__start(pos->map) >= map__end(new))
 			break;
 
 		if (verbose >= 2) {
 
 			if (use_browser) {
 				pr_debug("overlapping maps in %s (disable tui for more info)\n",
-					 map__dso(map)->name);
+					 map__dso(new)->name);
 			} else {
-				fputs("overlapping maps:\n", fp);
-				map__fprintf(map, fp);
-				map__fprintf(pos->map, fp);
+				pr_debug("overlapping maps:\n");
+				map__fprintf(new, debug_file());
+				map__fprintf(pos->map, debug_file());
 			}
 		}
 
-		rb_erase_init(&pos->rb_node, root);
+		rb_erase_init(&pos->rb_node, maps__entries(maps));
 		/*
 		 * Now check if we need to create new maps for areas not
 		 * overlapped by the new map:
 		 */
-		if (map__start(map) > map__start(pos->map)) {
+		if (map__start(new) > map__start(pos->map)) {
 			struct map *before = map__clone(pos->map);
 
 			if (before == NULL) {
@@ -399,7 +409,7 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 				goto put_map;
 			}
 
-			map__set_end(before, map__start(map));
+			map__set_end(before, map__start(new));
 			err = __maps__insert(maps, before);
 			if (err) {
 				map__put(before);
@@ -407,11 +417,11 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 			}
 
 			if (verbose >= 2 && !use_browser)
-				map__fprintf(before, fp);
+				map__fprintf(before, debug_file());
 			map__put(before);
 		}
 
-		if (map__end(map) < map__end(pos->map)) {
+		if (map__end(new) < map__end(pos->map)) {
 			struct map *after = map__clone(pos->map);
 
 			if (after == NULL) {
@@ -419,23 +429,25 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 				goto put_map;
 			}
 
-			map__set_start(after, map__end(map));
-			map__add_pgoff(after, map__end(map) - map__start(pos->map));
-			assert(map__map_ip(pos->map, map__end(map)) ==
-				map__map_ip(after, map__end(map)));
+			map__set_start(after, map__end(new));
+			map__add_pgoff(after, map__end(new) - map__start(pos->map));
+			assert(map__map_ip(pos->map, map__end(new)) ==
+				map__map_ip(after, map__end(new)));
 			err = __maps__insert(maps, after);
 			if (err) {
 				map__put(after);
 				goto put_map;
 			}
 			if (verbose >= 2 && !use_browser)
-				map__fprintf(after, fp);
+				map__fprintf(after, debug_file());
 			map__put(after);
 		}
 put_map:
 		map__put(pos->map);
 		free(pos);
 	}
+	/* Add the map. */
+	err = __maps__insert(maps, new);
 	up_write(maps__lock(maps));
 	return err;
 }
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index b94ad5c8fea7..62e94d443c02 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -133,7 +133,7 @@ struct addr_map_symbol;
 
 int maps__find_ams(struct maps *maps, struct addr_map_symbol *ams);
 
-int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp);
+int maps__fixup_overlap_and_insert(struct maps *maps, struct map *new);
 
 struct map *maps__find_by_name(struct maps *maps, const char *name);
 
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index b6986a81aa6d..3d47b5c5528b 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -345,8 +345,7 @@ int thread__insert_map(struct thread *thread, struct map *map)
 	if (ret)
 		return ret;
 
-	maps__fixup_overlappings(thread__maps(thread), map, stderr);
-	return maps__insert(thread__maps(thread), map);
+	return maps__fixup_overlap_and_insert(thread__maps(thread), map);
 }
 
 struct thread__prepare_access_maps_cb_args {
-- 
2.42.0.869.gea05f2083d-goog

