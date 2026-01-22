Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9433C23A3
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 21:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769117756; cv=none; b=QbBreBgq0H8kEpaGgCK8TYLN8spo/BpdoR38qPSHzhwH78dfkQs17usDvZg4wduNWS7o1dCgRYLVKQtg8u0BAxtNS0f7/eLpRMoRwo9RM9aRxB6RwEuvWiajj4uOlug/97COEP/nUTTp3aRRMGBeTe3/dEwRLK8inbk1im/T4h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769117756; c=relaxed/simple;
	bh=Fw5zeAM2zfnnadmaZE6GhH2s1pBqPvkeHIHlR9oq9uk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=coFW65jd6RyAYndmff2PIze8ilyVqLQwyrmRZSZTS9p9MZl2hQmC1sfunQtNepfkZck14Gbkyk8MaFFNeDYIkB6xLgHB5Vy01/PeLWSBQ2rXWkt3WR5nQUpYWsiArZgBEwuj1v5yCIHcBBAt982VV/W5s4pBFDsOg8wHBXMfAYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KnCAdwpL; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KnCAdwpL"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-11b94abc09dso2251356c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 13:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769117743; x=1769722543; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ad2GwIvXnuBM0K5HE3V72oHuf8IYiJKy1/A8wVQtlzk=;
        b=KnCAdwpLsG2dVgnmxZCl6HLcWF2VccllboYK9xHyy9JatP1Qex7zPi0MKNwnt1NEPJ
         lrPZlTwk+GpcmMKp9+8u9USL+FbXCswUrmqBfRYQtdl1fE44aYHazOUU3HkRzm+DLqbW
         zgtkD10KGpJ9C0DzdLG3mxODzNdqFYK1/9Yw5484Mvn3vuVojIuItBAlC4JoSHAG9CfL
         wvifQFwYTE/pl4Bs2zdqzbIP0BobvJWvPuRVenSy6YMui5exXcHhtvTmGy4ZULSYei8q
         0Y0PhzrZYdWlFbYuMtSmaiQXE1bIfJ/ALGeCer6Kvc6z3opvob3yxeJ4htpfCpxmk3Za
         fWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769117743; x=1769722543;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ad2GwIvXnuBM0K5HE3V72oHuf8IYiJKy1/A8wVQtlzk=;
        b=CTMGuQlQ5EulMZml6ircE6N1qAxPVbIkJhdjcfLgmdO1b17Jg++PGaUYhfd8VwI1X5
         ARNWW8C7yquqaPXhCmYjF9LhiS/l31v1yK0VtX3RU7LlfsOoltUdY7szGKOQJwCsMMSj
         dYjE6Jm8G+t6HzCexvDAlgpFhl5wUoc6ot8n43Y/iLBwvHlkOJgqqEpdamNtoZfjBGQY
         tcxDUOyhFtiJZpknR73+FrgUbL1HKdMJoWie+V7BSPIO5wBLBdfdXIN+OReavkB/0AJq
         C5XYLDNmS1ihTzRBbEyzP4OWUrzzBHGsGtzYQEAmeCakTmkmGUi5Q0jFquJm6OMr+yd0
         JTiw==
X-Forwarded-Encrypted: i=1; AJvYcCWHQbcMSyCTIacyWLY+NNWI+NrpK2ibMfczIgu876KcBuiVyV24kdrJNajrF8kyGDNJJhM+NLvjxsvh2CAbOaz+@vger.kernel.org
X-Gm-Message-State: AOJu0YyrXH9RRJzEsANi4tenefJvEY2ne7wIMnjtRBLkZoxagyxhptuF
	5tSDAzQKbCtuRkOban3YMth3+XLGZcOFyKTFnO2fDwld6UmxGJSJ6wksdiUrf9VzzQ3bsBXKb8Q
	3h+gOOpJZYA==
X-Received: from dlbbu7.prod.google.com ([2002:a05:7022:2207:b0:123:2708:9404])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1a84:b0:11b:9b98:aa4b
 with SMTP id a92af1059eb24-1247dba3c37mr405972c88.6.1769117742699; Thu, 22
 Jan 2026 13:35:42 -0800 (PST)
Date: Thu, 22 Jan 2026 13:35:14 -0800
In-Reply-To: <20260122213516.671089-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260122213516.671089-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260122213516.671089-11-irogers@google.com>
Subject: [PATCH v3 10/12] perf map_symbol: Switch from holding maps to holding thread
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Zecheng Li <zecheng@google.com>, 
	Tianyou Li <tianyou.li@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Suchit Karunakaran <suchitkarunakaran@gmail.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Aditya Bodkhe <aditya.b1@linux.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Shimin Guo <shimin.guo@skydio.com>, 
	Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

maps may belong to >1 thread. In contexts like symbolization
information from the thread may be useful, such as the ELF machine. As
the maps can be gained from the thread switch from holding maps in
struct map_symbol to holding the thread. Holding the maps in
addr_location is also redundant, switch this to using thread__maps.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/annotate.c              |  2 +-
 tools/perf/ui/browsers/hists.c                 |  3 ++-
 tools/perf/util/addr_location.c                |  4 ----
 tools/perf/util/addr_location.h                |  1 -
 .../util/annotate-arch/annotate-loongarch.c    |  5 +++--
 tools/perf/util/annotate-arch/annotate-s390.c  |  3 ++-
 tools/perf/util/callchain.c                    | 12 +++++++-----
 tools/perf/util/capstone.c                     |  6 ++++--
 tools/perf/util/db-export.c                    |  1 -
 tools/perf/util/disasm.c                       |  7 ++++---
 tools/perf/util/event.c                        |  2 --
 tools/perf/util/hist.c                         | 18 +++++++++---------
 tools/perf/util/machine.c                      | 13 +++++++------
 tools/perf/util/map_symbol.c                   |  5 +++--
 tools/perf/util/map_symbol.h                   |  3 ++-
 tools/perf/util/sort.c                         |  2 +-
 tools/perf/util/unwind-libdw.c                 |  2 +-
 tools/perf/util/unwind-libunwind-local.c       |  2 +-
 18 files changed, 47 insertions(+), 44 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 3df61cd46652..91ded9c271ee 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -601,7 +601,7 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
 		return true;
 	}
 
-	target_ms.maps = ms->maps;
+	target_ms.thread = ms->thread;
 	target_ms.map = ms->map;
 	target_ms.sym = dl->ops.target.sym;
 	annotation__unlock(notes);
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 08fecbe28a52..cfa6386e6e1d 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3189,7 +3189,8 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 		case 'k':
 			if (browser->selection != NULL)
 				hists_browser__zoom_map(browser,
-					      maps__machine(browser->selection->maps)->vmlinux_map);
+					maps__machine(thread__maps(browser->selection->thread)
+						     )->vmlinux_map);
 			continue;
 		case 'V':
 			verbose = (verbose + 1) % 4;
diff --git a/tools/perf/util/addr_location.c b/tools/perf/util/addr_location.c
index 81a0b79c5e10..57e8217a00f9 100644
--- a/tools/perf/util/addr_location.c
+++ b/tools/perf/util/addr_location.c
@@ -7,7 +7,6 @@
 void addr_location__init(struct addr_location *al)
 {
 	al->thread = NULL;
-	al->maps = NULL;
 	al->map = NULL;
 	al->sym = NULL;
 	al->srcline = NULL;
@@ -30,16 +29,13 @@ void addr_location__exit(struct addr_location *al)
 {
 	map__zput(al->map);
 	thread__zput(al->thread);
-	maps__zput(al->maps);
 }
 
 void addr_location__copy(struct addr_location *dst, struct addr_location *src)
 {
 	thread__put(dst->thread);
-	maps__put(dst->maps);
 	map__put(dst->map);
 	*dst = *src;
 	dst->thread = thread__get(src->thread);
-	dst->maps = maps__get(src->maps);
 	dst->map = map__get(src->map);
 }
diff --git a/tools/perf/util/addr_location.h b/tools/perf/util/addr_location.h
index 64b551025216..fdc4d3f3a68b 100644
--- a/tools/perf/util/addr_location.h
+++ b/tools/perf/util/addr_location.h
@@ -11,7 +11,6 @@ struct symbol;
 
 struct addr_location {
 	struct thread *thread;
-	struct maps   *maps;
 	struct map    *map;
 	struct symbol *sym;
 	const char    *srcline;
diff --git a/tools/perf/util/annotate-arch/annotate-loongarch.c b/tools/perf/util/annotate-arch/annotate-loongarch.c
index 79dc116ade2f..6c94cb98a104 100644
--- a/tools/perf/util/annotate-arch/annotate-loongarch.c
+++ b/tools/perf/util/annotate-arch/annotate-loongarch.c
@@ -11,6 +11,7 @@
 #include "../map.h"
 #include "../maps.h"
 #include "../symbol.h"
+#include "../thread.h"
 
 static int loongarch_call__parse(const struct arch *arch, struct ins_operands *ops,
 				 struct map_symbol *ms,
@@ -49,7 +50,7 @@ static int loongarch_call__parse(const struct arch *arch, struct ins_operands *o
 		.addr = map__objdump_2mem(map, ops->target.addr),
 	};
 
-	if (maps__find_ams(ms->maps, &target) == 0 &&
+	if (maps__find_ams(thread__maps(ms->thread), &target) == 0 &&
 	    map__rip_2objdump(target.ms.map, map__map_ip(target.ms.map, target.addr)) == ops->target.addr)
 		ops->target.sym = target.ms.sym;
 
@@ -93,7 +94,7 @@ static int loongarch_jump__parse(const struct arch *arch, struct ins_operands *o
 
 	ops->target.outside = target.addr < start || target.addr > end;
 
-	if (maps__find_ams(ms->maps, &target) == 0 &&
+	if (maps__find_ams(thread__maps(ms->thread), &target) == 0 &&
 	    map__rip_2objdump(target.ms.map, map__map_ip(target.ms.map, target.addr)) == ops->target.addr)
 		ops->target.sym = target.ms.sym;
 
diff --git a/tools/perf/util/annotate-arch/annotate-s390.c b/tools/perf/util/annotate-arch/annotate-s390.c
index 7b2d27b62e6b..47573f0310c1 100644
--- a/tools/perf/util/annotate-arch/annotate-s390.c
+++ b/tools/perf/util/annotate-arch/annotate-s390.c
@@ -6,6 +6,7 @@
 #include "../map.h"
 #include "../maps.h"
 #include "../symbol.h"
+#include "../thread.h"
 #include "../annotate.h"
 #include "../annotate-data.h"
 
@@ -49,7 +50,7 @@ static int s390_call__parse(const struct arch *arch, struct ins_operands *ops,
 		.addr = map__objdump_2mem(map, ops->target.addr),
 	};
 
-	if (maps__find_ams(ms->maps, &target) == 0 &&
+	if (maps__find_ams(thread__maps(ms->thread), &target) == 0 &&
 	    map__rip_2objdump(target.ms.map, map__map_ip(target.ms.map, target.addr)) == ops->target.addr)
 		ops->target.sym = target.ms.sym;
 
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 428e5350d7a2..515bb8b5da01 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -31,6 +31,7 @@
 #include "callchain.h"
 #include "branch.h"
 #include "symbol.h"
+#include "thread.h"
 #include "util.h"
 #include "../perf.h"
 
@@ -1042,7 +1043,7 @@ merge_chain_branch(struct callchain_cursor *cursor,
 
 	list_for_each_entry_safe(list, next_list, &src->val, list) {
 		struct map_symbol ms = {
-			.maps = maps__get(list->ms.maps),
+			.thread = thread__get(list->ms.thread),
 			.map = map__get(list->ms.map),
 		};
 		callchain_cursor_append(cursor, list->ip, &ms, false, NULL, 0, 0, 0, list->srcline);
@@ -1147,10 +1148,11 @@ int hist_entry__append_callchain(struct hist_entry *he, struct perf_sample *samp
 int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *node,
 			bool hide_unresolved)
 {
-	struct machine *machine = node->ms.maps ? maps__machine(node->ms.maps) : NULL;
+	struct machine *machine = NULL;
+
+	if (node->ms.thread)
+		machine = maps__machine(thread__maps(node->ms.thread));
 
-	maps__put(al->maps);
-	al->maps = maps__get(node->ms.maps);
 	map__put(al->map);
 	al->map = map__get(node->ms.map);
 	al->sym = node->ms.sym;
@@ -1163,7 +1165,7 @@ int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *
 		if (al->map == NULL)
 			goto out;
 	}
-	if (maps__equal(al->maps, machine__kernel_maps(machine))) {
+	if (maps__equal(thread__maps(al->thread), machine__kernel_maps(machine))) {
 		if (machine__is_host(machine)) {
 			al->cpumode = PERF_RECORD_MISC_KERNEL;
 			al->level = 'k';
diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
index ce06cfd253ef..9216916f848f 100644
--- a/tools/perf/util/capstone.c
+++ b/tools/perf/util/capstone.c
@@ -268,7 +268,8 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 	    !strcmp(args->options->disassembler_style, "att"))
 		disassembler_style = true;
 
-	if (capstone_init(maps__machine(args->ms->maps), &handle, is_64bit, disassembler_style) < 0)
+	if (capstone_init(maps__machine(thread__maps(args->ms->thread)), &handle, is_64bit,
+			  disassembler_style) < 0)
 		goto err;
 
 	needs_cs_close = true;
@@ -382,7 +383,8 @@ int symbol__disassemble_capstone_powerpc(const char *filename __maybe_unused,
 	    !strcmp(args->options->disassembler_style, "att"))
 		disassembler_style = true;
 
-	if (capstone_init(maps__machine(args->ms->maps), &handle, is_64bit, disassembler_style) < 0)
+	if (capstone_init(maps__machine(thread__maps(args->ms->thread)), &handle, is_64bit,
+			  disassembler_style) < 0)
 		goto err;
 
 	needs_cs_close = true;
diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 8f52e8cefcf3..ae9a9065aab7 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -254,7 +254,6 @@ static struct call_path *call_path_from_sample(struct db_export *dbe,
 		addr_location__init(&al);
 		al.sym = node->ms.sym;
 		al.map = map__get(node->ms.map);
-		al.maps = maps__get(thread__maps(thread));
 		al.addr = node->ip;
 		al.thread = thread__get(thread);
 
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 8c3e9094600a..d81469db0aac 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -28,6 +28,7 @@
 #include "namespaces.h"
 #include "srcline.h"
 #include "symbol.h"
+#include "thread.h"
 #include "util.h"
 
 static regex_t	 file_lineno;
@@ -277,7 +278,7 @@ static int call__parse(const struct arch *arch, struct ins_operands *ops, struct
 		.addr = map__objdump_2mem(map, ops->target.addr),
 	};
 
-	if (maps__find_ams(ms->maps, &target) == 0 &&
+	if (maps__find_ams(thread__maps(ms->thread), &target) == 0 &&
 	    map__rip_2objdump(target.ms.map, map__map_ip(target.ms.map, target.addr)) == ops->target.addr)
 		ops->target.sym = target.ms.sym;
 
@@ -411,7 +412,7 @@ static int jump__parse(const struct arch *arch, struct ins_operands *ops, struct
 	 * Actual navigation will come next, with further understanding of how
 	 * the symbol searching and disassembly should be done.
 	 */
-	if (maps__find_ams(ms->maps, &target) == 0 &&
+	if (maps__find_ams(thread__maps(ms->thread), &target) == 0 &&
 	    map__rip_2objdump(target.ms.map, map__map_ip(target.ms.map, target.addr)) == ops->target.addr)
 		ops->target.sym = target.ms.sym;
 
@@ -1074,7 +1075,7 @@ static int symbol__parse_objdump_line(struct symbol *sym,
 			.ms = { .map = map__get(map), },
 		};
 
-		if (!maps__find_ams(args->ms->maps, &target) &&
+		if (!maps__find_ams(thread__maps(args->ms->thread), &target) &&
 		    target.ms.sym->start == target.al_addr)
 			dl->ops.target.sym = target.ms.sym;
 
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 2dde1044b5a7..bc045fddf7d5 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -698,7 +698,6 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 	struct machine *machine = maps__machine(maps);
 	bool load_map = false;
 
-	maps__zput(al->maps);
 	map__zput(al->map);
 	thread__zput(al->thread);
 	al->thread = thread__get(thread);
@@ -736,7 +735,6 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 
 		return NULL;
 	}
-	al->maps = maps__get(maps);
 	al->map = maps__find(maps, al->addr);
 	if (al->map != NULL) {
 		/*
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index ef4b569f7df4..7ffaa3d9851b 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -251,7 +251,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 
 	if (h->cgroup) {
 		const char *cgrp_name = "unknown";
-		struct cgroup *cgrp = cgroup__find(maps__machine(h->ms.maps)->env,
+		struct cgroup *cgrp = cgroup__find(maps__machine(thread__maps(h->ms.thread))->env,
 						   h->cgroup);
 		if (cgrp != NULL)
 			cgrp_name = cgrp->name;
@@ -536,7 +536,7 @@ static int hist_entry__init(struct hist_entry *he,
 			memset(&he->stat, 0, sizeof(he->stat));
 	}
 
-	he->ms.maps = maps__get(he->ms.maps);
+	he->ms.thread = thread__get(he->ms.thread);
 	he->ms.map = map__get(he->ms.map);
 
 	if (he->branch_info) {
@@ -552,9 +552,9 @@ static int hist_entry__init(struct hist_entry *he,
 		memcpy(he->branch_info, template->branch_info,
 		       sizeof(*he->branch_info));
 
-		he->branch_info->from.ms.maps = maps__get(he->branch_info->from.ms.maps);
+		he->branch_info->from.ms.thread = thread__get(he->branch_info->from.ms.thread);
 		he->branch_info->from.ms.map = map__get(he->branch_info->from.ms.map);
-		he->branch_info->to.ms.maps = maps__get(he->branch_info->to.ms.maps);
+		he->branch_info->to.ms.thread = thread__get(he->branch_info->to.ms.thread);
 		he->branch_info->to.ms.map = map__get(he->branch_info->to.ms.map);
 	}
 
@@ -810,7 +810,7 @@ __hists__add_entry(struct hists *hists,
 		},
 		.cgroup = sample->cgroup,
 		.ms = {
-			.maps	= al->maps,
+			.thread	= al->thread,
 			.map	= al->map,
 			.sym	= al->sym,
 		},
@@ -890,7 +890,7 @@ struct hist_entry *hists__add_entry_block(struct hists *hists,
 		.block_info = block_info,
 		.hists = hists,
 		.ms = {
-			.maps = al->maps,
+			.thread = al->thread,
 			.map = al->map,
 			.sym = al->sym,
 		},
@@ -1020,8 +1020,8 @@ iter_next_branch_entry(struct hist_entry_iter *iter, struct addr_location *al)
 	if (iter->curr >= iter->total)
 		return 0;
 
-	maps__put(al->maps);
-	al->maps = maps__get(bi[i].to.ms.maps);
+	thread__put(al->thread);
+	al->thread = thread__get(bi[i].to.ms.thread);
 	map__put(al->map);
 	al->map = map__get(bi[i].to.ms.map);
 	al->sym = bi[i].to.ms.sym;
@@ -1232,7 +1232,7 @@ iter_add_next_cumulative_entry(struct hist_entry_iter *iter,
 		.comm = thread__comm(al->thread),
 		.ip = al->addr,
 		.ms = {
-			.maps = al->maps,
+			.thread = al->thread,
 			.map = al->map,
 			.sym = al->sym,
 		},
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 30d606fbf040..5b0f5a48ffd4 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2016,7 +2016,7 @@ static void ip__resolve_ams(struct thread *thread,
 	ams->addr = ip;
 	ams->al_addr = al.addr;
 	ams->al_level = al.level;
-	ams->ms.maps = maps__get(al.maps);
+	ams->ms.thread = thread__get(al.thread);
 	ams->ms.sym = al.sym;
 	ams->ms.map = map__get(al.map);
 	ams->phys_addr = 0;
@@ -2037,7 +2037,7 @@ static void ip__resolve_data(struct thread *thread,
 	ams->addr = addr;
 	ams->al_addr = al.addr;
 	ams->al_level = al.level;
-	ams->ms.maps = maps__get(al.maps);
+	ams->ms.thread = thread__get(al.thread);
 	ams->ms.sym = al.sym;
 	ams->ms.map = map__get(al.map);
 	ams->phys_addr = phys_addr;
@@ -2120,7 +2120,7 @@ static int append_inlines(struct callchain_cursor *cursor, struct map_symbol *ms
 	}
 
 	ilist_ms = (struct map_symbol) {
-		.maps = maps__get(ms->maps),
+		.thread = thread__get(ms->thread),
 		.map = map__get(map),
 	};
 	list_for_each_entry(ilist, &inline_node->val, list) {
@@ -2220,7 +2220,7 @@ static int add_callchain_ip(struct thread *thread,
 		iter_cycles = iter->cycles;
 	}
 
-	ms.maps = maps__get(al.maps);
+	ms.thread = thread__get(al.thread);
 	ms.map = map__get(al.map);
 	ms.sym = al.sym;
 
@@ -2383,7 +2383,7 @@ static void save_lbr_cursor_node(struct thread *thread,
 	map_symbol__exit(&lbr_stitch->prev_lbr_cursor[idx].ms);
 	memcpy(&lbr_stitch->prev_lbr_cursor[idx], cursor->curr,
 	       sizeof(struct callchain_cursor_node));
-	lbr_stitch->prev_lbr_cursor[idx].ms.maps = maps__get(cursor->curr->ms.maps);
+	lbr_stitch->prev_lbr_cursor[idx].ms.thread = thread__get(cursor->curr->ms.thread);
 	lbr_stitch->prev_lbr_cursor[idx].ms.map = map__get(cursor->curr->ms.map);
 
 	lbr_stitch->prev_lbr_cursor[idx].valid = true;
@@ -2596,7 +2596,8 @@ static bool has_stitched_lbr(struct thread *thread,
 		memcpy(&stitch_node->cursor, &lbr_stitch->prev_lbr_cursor[i],
 		       sizeof(struct callchain_cursor_node));
 
-		stitch_node->cursor.ms.maps = maps__get(lbr_stitch->prev_lbr_cursor[i].ms.maps);
+		stitch_node->cursor.ms.thread =
+			thread__get(lbr_stitch->prev_lbr_cursor[i].ms.thread);
 		stitch_node->cursor.ms.map = map__get(lbr_stitch->prev_lbr_cursor[i].ms.map);
 
 		if (callee)
diff --git a/tools/perf/util/map_symbol.c b/tools/perf/util/map_symbol.c
index 6ad2960bc289..11bc0a7f704c 100644
--- a/tools/perf/util/map_symbol.c
+++ b/tools/perf/util/map_symbol.c
@@ -2,10 +2,11 @@
 #include "map_symbol.h"
 #include "maps.h"
 #include "map.h"
+#include "thread.h"
 
 void map_symbol__exit(struct map_symbol *ms)
 {
-	maps__zput(ms->maps);
+	thread__zput(ms->thread);
 	map__zput(ms->map);
 }
 
@@ -16,7 +17,7 @@ void addr_map_symbol__exit(struct addr_map_symbol *ams)
 
 void map_symbol__copy(struct map_symbol *dst, struct map_symbol *src)
 {
-	dst->maps = maps__get(src->maps);
+	dst->thread = thread__get(src->thread);
 	dst->map = map__get(src->map);
 	dst->sym = src->sym;
 }
diff --git a/tools/perf/util/map_symbol.h b/tools/perf/util/map_symbol.h
index e370bb32ed47..7437e319f4a3 100644
--- a/tools/perf/util/map_symbol.h
+++ b/tools/perf/util/map_symbol.h
@@ -4,12 +4,13 @@
 
 #include <linux/types.h>
 
+struct thread;
 struct maps;
 struct map;
 struct symbol;
 
 struct map_symbol {
-	struct maps   *maps;
+	struct thread *thread;
 	struct map    *map;
 	struct symbol *sym;
 };
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index f963d61ac166..01a9d73ae348 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -1016,7 +1016,7 @@ static int hist_entry__cgroup_snprintf(struct hist_entry *he,
 	const char *cgrp_name = "N/A";
 
 	if (he->cgroup) {
-		struct cgroup *cgrp = cgroup__find(maps__machine(he->ms.maps)->env,
+		struct cgroup *cgrp = cgroup__find(maps__machine(thread__maps(he->ms.thread))->env,
 						   he->cgroup);
 		if (cgrp != NULL)
 			cgrp_name = cgrp->name;
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index c1646ef5f971..9cb0960ef905 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -161,7 +161,7 @@ static int entry(u64 ip, struct unwind_info *ui)
 	}
 
 	e->ip	  = ip;
-	e->ms.maps = maps__get(al.maps);
+	e->ms.thread = thread__get(al.thread);
 	e->ms.map = map__get(al.map);
 	e->ms.sym = al.sym;
 
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index a24b45106acd..ecf0c01fe51f 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -666,7 +666,7 @@ static int entry(u64 ip, struct thread *thread,
 	e.ms.sym = thread__find_symbol(thread, PERF_RECORD_MISC_USER, ip, &al);
 	e.ip     = ip;
 	e.ms.map = al.map;
-	e.ms.maps = al.maps;
+	e.ms.thread = thread__get(al.thread);
 
 	pr_debug("unwind: %s:ip = 0x%" PRIx64 " (0x%" PRIx64 ")\n",
 		 al.sym ? al.sym->name : "''",
-- 
2.52.0.457.g6b5491de43-goog

