Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A2B32ABCC
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Jan 2026 05:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768627814; cv=none; b=HMlLEpYLzJ+PYl5kz7SXTghf0M8WPN90jQONZdkDHQd1V6WHmgvc7sCWa8FraRhdOgUQyX9kBvlsGftxlErP7POmfeU7FaN/jyn/5MEKxSoGznumlDYyeVwbP7iAlrs1d8CvEPpmCwalZNlHq3QiYx6af7Lv88GQhcTGDnH206c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768627814; c=relaxed/simple;
	bh=gU0n23qpAYe89nfFHwGuwfku8H+eTwshuJOdnRwVnQg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=JwLRyRDuiXBDUE3YT8Dmrfu1dPmO44+HkYsHf87Mp4MdwLkConOcCOWVsbJu7kFMskVQzPCXJ4Xxj/Vn5PWYF83LdDJ1pCCeygGuzUGV4ztN4JuQGwUM+Smxxc/fSFpUOmV10sT3GQ78Gnk8+SJZe7qHw+fk31305MeozjTo5h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uTZZ+9sK; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uTZZ+9sK"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12454b0a1a2so1456710c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Jan 2026 21:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768627803; x=1769232603; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qJFJ/K9bRhHbh9aObqDCWyeE1pcCmkJcXdgq+xqodbk=;
        b=uTZZ+9sKmC9ZxfoZ1Q6d/OtlGlaJmFdzC6h4dHbvyp5rcfnz69IFKKlD5VO6Snaj9E
         h1rE97xqQZK3GuOWBrtI803sqpRY5EK2Wm40jVZWhKaMQLuebw+EWXzzDBpdF3Qfj85i
         qnRwkxcmcz657GHp2LyJV459+yhUg77Lf17L7N8nx3BqkgWGG36L+tt0x0zvblNySyCU
         ZwkOc+zYZTuIJ8y+8yW7shJ+gp26UZgy1pxEdMpHq6DwbCF4t2hppnEtZN9LZ2XCtEL5
         d0tDzEN/TLlE1YIsjQwyl1aFYbQscfEJSOzExWRCs2DiYvDYTiLjI/C1YUa/q1w6PGrf
         pPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768627803; x=1769232603;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qJFJ/K9bRhHbh9aObqDCWyeE1pcCmkJcXdgq+xqodbk=;
        b=hwEcIXyw0ai2czOkJ6pWHT0IiZ7UIyQum0cIF5bf3hp+86KUC/+06Xn4UVGqvhDCbP
         lk8knmbrYJCfCi2514aYb6D7uxM/DpfZO6fI9x2YwPRh5uPEZ+NjPwjJDIF17btvs5Dz
         p79qlfZkg+gZzVkNNNRYgRwWHKHoh0YtPC1PR0AT5igt6+8wel++WTeRM5z2MMjyjtEd
         Me2SY2x4J0iGa0m3KfZ2LSFf0MbEkbxH3Akhjej7FNeHFdmL9PraR9bDtV4qW8KRM0wU
         38svMAFnPAOlBJN5+llx5e6MeHJGrOx+ldQvG56JPQxoVFpyUsRjKx9pcC+VmGDsJ0Ie
         BefA==
X-Forwarded-Encrypted: i=1; AJvYcCVz/Wzugx+ZeWG9ikCDILmW1fkELmN1ywgq8RZVMJxOGPhicD3IzVrIPI/7pNowTIyNM+cgnHgruiYNBgi1xna+@vger.kernel.org
X-Gm-Message-State: AOJu0YxeaR4ViP7R2IHPL3dqbxyyo2ffeKR6KzQOduzC6wQgA0BMiHIg
	WqCU3VL7tfRyiZOYBR8ZedySxU8cajryeZbz/yhfGSu6HytQ476jqjSwtIWwjFu6pNQMzNfic9i
	m2GVk8cYZLQ==
X-Received: from dlbqc7.prod.google.com ([2002:a05:7023:a87:b0:11d:cfa0:5ddf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6886:b0:11b:9386:a3c3
 with SMTP id a92af1059eb24-1244b395f30mr4327064c88.46.1768627802526; Fri, 16
 Jan 2026 21:30:02 -0800 (PST)
Date: Fri, 16 Jan 2026 21:28:49 -0800
In-Reply-To: <20260117052849.2205545-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260117052849.2205545-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260117052849.2205545-24-irogers@google.com>
Subject: [PATCH v1 23/23] perf machine: Add inline information to frame
 pointer and LBR callchains
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Shimin Guo <shimin.guo@skydio.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Dmitry Vyukov <dvyukov@google.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Chun-Tse Shao <ctshao@google.com>, 
	Aditya Bodkhe <aditya.b1@linux.ibm.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Wielaard <mark@klomp.org>
Content-Type: text/plain; charset="UTF-8"

Use append_inlines in frame pointer and LBR cases. Update the
addr2line test to also test frame pointers. LBR is also updated but
inaccuracy in the branched to IP means the inline information is
missing in the leaf. Leave LBR callchains untested for now.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/addr2line_inlines.sh |  31 +++++-
 tools/perf/util/machine.c                   | 104 +++++++++++---------
 2 files changed, 86 insertions(+), 49 deletions(-)

diff --git a/tools/perf/tests/shell/addr2line_inlines.sh b/tools/perf/tests/shell/addr2line_inlines.sh
index 4a5b6f5be23d..ce30d9c7e0bf 100755
--- a/tools/perf/tests/shell/addr2line_inlines.sh
+++ b/tools/perf/tests/shell/addr2line_inlines.sh
@@ -21,8 +21,28 @@ trap_cleanup() {
 }
 trap trap_cleanup EXIT TERM INT
 
-test_inlinedloop() {
-    echo "Inline unwinding verification test"
+test_fp() {
+    echo "Inline unwinding fp verification test"
+    # Record data. Currently only dwarf callchains support inlined functions.
+    perf record --call-graph fp -e task-clock:u -o "${perf_data}" -- perf test -w inlineloop 1
+
+    # Check output with inline (default) and srcline
+    perf script -i "${perf_data}" --fields +srcline > "${perf_script_txt}"
+
+    # Expect the leaf and middle functions to occur on lines in the 20s, with
+    # the non-inlined parent function on a line in the 30s.
+    if grep -q "inlineloop.c:2. (inlined)" "${perf_script_txt}" &&
+       grep -q "inlineloop.c:3.$" "${perf_script_txt}"
+    then
+        echo "Inline unwinding fp verification test [Success]"
+    else
+        echo "Inline unwinding fp verification test [Failed missing inlined functions]"
+        err=1
+    fi
+}
+
+test_dwarf() {
+    echo "Inline unwinding dwarf verification test"
     # Record data. Currently only dwarf callchains support inlined functions.
     perf record --call-graph dwarf -e task-clock:u -o "${perf_data}" -- perf test -w inlineloop 1
 
@@ -34,14 +54,15 @@ test_inlinedloop() {
     if grep -q "inlineloop.c:2. (inlined)" "${perf_script_txt}" &&
        grep -q "inlineloop.c:3.$" "${perf_script_txt}"
     then
-        echo "Inline unwinding verification test [Success]"
+        echo "Inline unwinding dwarf verification test [Success]"
     else
-        echo "Inline unwinding verification test [Failed missing inlined functions]"
+        echo "Inline unwinding dwarf verification test [Failed missing inlined functions]"
         err=1
     fi
 }
 
-test_inlinedloop
+test_fp
+test_dwarf
 
 cleanup
 exit $err
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 841b711d970e..30d606fbf040 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2090,6 +2090,59 @@ struct iterations {
 	u64 cycles;
 };
 
+static int append_inlines(struct callchain_cursor *cursor, struct map_symbol *ms, u64 ip,
+			bool branch, struct branch_flags *flags, int nr_loop_iter,
+			u64 iter_cycles, u64 branch_from)
+{
+	struct symbol *sym = ms->sym;
+	struct map *map = ms->map;
+	struct inline_node *inline_node;
+	struct inline_list *ilist;
+	struct dso *dso;
+	u64 addr;
+	int ret = 1;
+	struct map_symbol ilist_ms;
+	bool first = true;
+
+	if (!symbol_conf.inline_name || !map || !sym)
+		return ret;
+
+	addr = map__dso_map_ip(map, ip);
+	addr = map__rip_2objdump(map, addr);
+	dso = map__dso(map);
+
+	inline_node = inlines__tree_find(dso__inlined_nodes(dso), addr);
+	if (!inline_node) {
+		inline_node = dso__parse_addr_inlines(dso, addr, sym);
+		if (!inline_node)
+			return ret;
+		inlines__tree_insert(dso__inlined_nodes(dso), inline_node);
+	}
+
+	ilist_ms = (struct map_symbol) {
+		.maps = maps__get(ms->maps),
+		.map = map__get(map),
+	};
+	list_for_each_entry(ilist, &inline_node->val, list) {
+		ilist_ms.sym = ilist->symbol;
+		if (first) {
+			ret = callchain_cursor_append(cursor, ip, &ilist_ms,
+						      branch, flags, nr_loop_iter,
+						      iter_cycles, branch_from, ilist->srcline);
+		} else {
+			ret = callchain_cursor_append(cursor, ip, &ilist_ms, false,
+						      NULL, 0, 0, 0, ilist->srcline);
+		}
+		first = false;
+
+		if (ret != 0)
+			return ret;
+	}
+	map_symbol__exit(&ilist_ms);
+
+	return ret;
+}
+
 static int add_callchain_ip(struct thread *thread,
 			    struct callchain_cursor *cursor,
 			    struct symbol **parent,
@@ -2170,6 +2223,11 @@ static int add_callchain_ip(struct thread *thread,
 	ms.maps = maps__get(al.maps);
 	ms.map = map__get(al.map);
 	ms.sym = al.sym;
+
+	if (append_inlines(cursor, &ms, ip, branch, flags, nr_loop_iter,
+			   iter_cycles, branch_from) == 0)
+		goto out;
+
 	srcline = callchain_srcline(&ms, al.addr);
 	err = callchain_cursor_append(cursor, ip, &ms,
 				      branch, flags, nr_loop_iter,
@@ -2888,49 +2946,6 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 	return 0;
 }
 
-static int append_inlines(struct callchain_cursor *cursor, struct map_symbol *ms, u64 ip)
-{
-	struct symbol *sym = ms->sym;
-	struct map *map = ms->map;
-	struct inline_node *inline_node;
-	struct inline_list *ilist;
-	struct dso *dso;
-	u64 addr;
-	int ret = 1;
-	struct map_symbol ilist_ms;
-
-	if (!symbol_conf.inline_name || !map || !sym)
-		return ret;
-
-	addr = map__dso_map_ip(map, ip);
-	addr = map__rip_2objdump(map, addr);
-	dso = map__dso(map);
-
-	inline_node = inlines__tree_find(dso__inlined_nodes(dso), addr);
-	if (!inline_node) {
-		inline_node = dso__parse_addr_inlines(dso, addr, sym);
-		if (!inline_node)
-			return ret;
-		inlines__tree_insert(dso__inlined_nodes(dso), inline_node);
-	}
-
-	ilist_ms = (struct map_symbol) {
-		.maps = maps__get(ms->maps),
-		.map = map__get(map),
-	};
-	list_for_each_entry(ilist, &inline_node->val, list) {
-		ilist_ms.sym = ilist->symbol;
-		ret = callchain_cursor_append(cursor, ip, &ilist_ms, false,
-					      NULL, 0, 0, 0, ilist->srcline);
-
-		if (ret != 0)
-			return ret;
-	}
-	map_symbol__exit(&ilist_ms);
-
-	return ret;
-}
-
 static int unwind_entry(struct unwind_entry *entry, void *arg)
 {
 	struct callchain_cursor *cursor = arg;
@@ -2940,7 +2955,8 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
 	if (symbol_conf.hide_unresolved && entry->ms.sym == NULL)
 		return 0;
 
-	if (append_inlines(cursor, &entry->ms, entry->ip) == 0)
+	if (append_inlines(cursor, &entry->ms, entry->ip, /*branch=*/false, /*branch_flags=*/NULL,
+			   /*nr_loop_iter=*/0, /*iter_cycles=*/0, /*branch_from=*/0) == 0)
 		return 0;
 
 	/*
-- 
2.52.0.457.g6b5491de43-goog

