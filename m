Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1729548097F
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 07:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769067117; cv=none; b=ed4VSub3RBmNUIz8opLBNF9fknTEOJk/BeztcNS/22gERR/347gIMJg0jms7BA4ZzGGZpLZPQKFSsmhVL3U+6g8KJrBjGq22WuqsHr3Y5+EwNcscJZxmN1rb39XyrtYEGP/CkEeqcoZNFsZAECqaOvEZHTDE6zWX1LvqgOlArmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769067117; c=relaxed/simple;
	bh=TUqeF98l0qdNQ/Fsz65hPZj73WjRw64r79/KQUgVa4s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=DZmBdHaQhWTrfWBLF9zMoeetcX+sshOgkGDcH+uFpvhqZRy9p2FWjRf4813XYrS85ZprctmqmjqLrXXXWdQD337rnUc7sN/A2CXB/J5umDpnJL820iokCpP60kzW44lZ1wGLcpLd3GR3SlycTDsynflq/5C0Q6z3vqR6xjhkSlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I/n8lgmV; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I/n8lgmV"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b70c92f404so999352eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 23:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769067107; x=1769671907; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PuBIk7tpioVz4MoymkEw/EeeS4pL/7FQwHPBgMFfTyI=;
        b=I/n8lgmVTXTJRbzMLR0PQYU7q4gjWxwSIrzEXl3U/UGQ4CW7P9GUcdZzTBk1Oe6WWW
         RVBYLtP/UBTfXmYFICc/XexLsQp6w/MVMnrsXa+Z8V/GxRpR7OBAI7MhkznKkdZk4UI0
         YnJ3rpOtqlKgRfsO8fjmO/5bWph3y2kjHF/FrDW5x/G/CT95CL06dMMSiQLjyBdyXSUr
         XPSoxQrgun8TM3ZjD4rUXJQzoLEn2P2bLUywupKeiYvT6bHvL7PEs6zCT/yqhya3J+Qm
         grk8FyYXDP/PQEVJdHQ4dO/h+UgtWdyWcE7IqM+fjwYW3JlWrX5GABfNqiq6PfRb2gv+
         bBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769067107; x=1769671907;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PuBIk7tpioVz4MoymkEw/EeeS4pL/7FQwHPBgMFfTyI=;
        b=wGJ8v/cG2totNat5dfJL4CyMzMgF300O/OdFHMjtJdgeRoaqMWA25bEz8bS6girYSR
         JiN+yXlY9EJPL9orGihuiyvFtn0fC5qlwYPLedhpMuqr92UBwTXNawo/qcX5IRrzGzo9
         Y176ODFVnNiBRdQ93Z9LgSy1AqcC95flihyBSVuSzxv+KiMQoxtfBXwU79NEFbyype4u
         YMBRPcfTGCjZK2XvaC5YolCLBFlNMuu63qyJr6Lf1Q5UFp746cFH1YJMd1ljqBFzB7r+
         n1/VlIGP49V0osbxazSVZKOrCX7gp1yN6rU2MZQvdDQ3kFyMPYA5zBOBf4WoB2RbnIEK
         1XXw==
X-Forwarded-Encrypted: i=1; AJvYcCWKKy+niHbz2Qj4htHr26WPRTpoBGYJM5eIRRZBpV8R+PEopRZUBObkPLtVoRnrkmLnD9+qIJjKZJTEgCckNChx@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx7j6c2v8hgv9JITpYEIK/0UzToQlZE5MpKkgX55pMBCkH9pe4
	5KHrTD3qiC1HGEoVKYhuNRCdrRYSo7KDOLwv3Z7k0Fb3H3j5XovzVDzoNi6gl/lOHItyCUgW/dj
	a+7Wl91fLjg==
X-Received: from dycnm24.prod.google.com ([2002:a05:7300:d198:b0:2b0:6a03:e2bb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:100d:b0:2b7:140c:c700
 with SMTP id 5a478bee46e88-2b7140cc765mr2519966eec.20.1769067106894; Wed, 21
 Jan 2026 23:31:46 -0800 (PST)
Date: Wed, 21 Jan 2026 23:31:25 -0800
In-Reply-To: <20260122073127.375139-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260122073127.375139-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260122073127.375139-10-irogers@google.com>
Subject: [PATCH v1 09/11] perf map_symbol: Switch from holding maps to holding thread
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
index b95ae5d6657f..a23744eafd6a 100644
--- a/tools/perf/util/annotate-arch/annotate-loongarch.c
+++ b/tools/perf/util/annotate-arch/annotate-loongarch.c
@@ -11,6 +11,7 @@
 #include "../map.h"
 #include "../maps.h"
 #include "../symbol.h"
+#include "../thread.h"
 
 static int loongarch_call__parse(const struct arch *arch, struct ins_operands *ops,
 				 struct map_symbol *ms,
@@ -48,7 +49,7 @@ static int loongarch_call__parse(const struct arch *arch, struct ins_operands *o
 
 	target.addr = map__objdump_2mem(map, ops->target.addr);
 
-	if (maps__find_ams(ms->maps, &target) == 0 &&
+	if (maps__find_ams(thread__maps(ms->thread), &target) == 0 &&
 	    map__rip_2objdump(target.ms.map, map__map_ip(target.ms.map, target.addr)) == ops->target.addr)
 		ops->target.sym = target.ms.sym;
 
@@ -91,7 +92,7 @@ static int loongarch_jump__parse(const struct arch *arch, struct ins_operands *o
 
 	ops->target.outside = target.addr < start || target.addr > end;
 
-	if (maps__find_ams(ms->maps, &target) == 0 &&
+	if (maps__find_ams(thread__maps(ms->thread), &target) == 0 &&
 	    map__rip_2objdump(target.ms.map, map__map_ip(target.ms.map, target.addr)) == ops->target.addr)
 		ops->target.sym = target.ms.sym;
 
diff --git a/tools/perf/util/annotate-arch/annotate-s390.c b/tools/perf/util/annotate-arch/annotate-s390.c
index 6d1a1da277e2..cb112c1ba090 100644
--- a/tools/perf/util/annotate-arch/annotate-s390.c
+++ b/tools/perf/util/annotate-arch/annotate-s390.c
@@ -6,6 +6,7 @@
 #include "../map.h"
 #include "../maps.h"
 #include "../symbol.h"
+#include "../thread.h"
 #include "../annotate.h"
 #include "../annotate-data.h"
 
@@ -47,7 +48,7 @@ static int s390_call__parse(const struct arch *arch, struct ins_operands *ops,
 		return -1;
 	target.addr = map__objdump_2mem(map, ops->target.addr);
 
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
index bc5323ecb5da..c537c12ff7cd 100644
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
 			.ms = { .map = map, },
 		};
 
-		if (!maps__find_ams(args->ms->maps, &target) &&
+		if (!maps__find_ams(thread__maps(args->ms->thread), &target) &&
 		    target.ms.sym->start == target.al_addr)
 			dl->ops.target.sym = target.ms.sym;
 	}
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 4c92cc1a952c..aa3f8a3a4438 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -646,7 +646,6 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 	struct machine *machine = maps__machine(maps);
 	bool load_map = false;
 
-	maps__zput(al->maps);
 	map__zput(al->map);
 	thread__zput(al->thread);
 	al->thread = thread__get(thread);
@@ -684,7 +683,6 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 
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

