Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FAC221F2F
	for <linux-perf-users@vger.kernel.org>; Sat,  2 May 2026 06:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777704526; cv=none; b=Jj9e7ANv6F0OQtMW4bgUFuRa7Ji5y04AkMXeouPTi+Cw1vpovpSgVJDp6pClQAY+DcquOmvKQbvgf7rpwx3OhSc7wabJ5x5IgdEutDgRZ7oD7Yl8i37gDrXmLIRZwhrDsd9Uw9wG62tB8lwx1yj4Ot5e7VkdIeRKtBTfn/ogux8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777704526; c=relaxed/simple;
	bh=BluSYIgKW/eT8ibtQgYA/wGk4TarIoCO7yq0lGm+v1I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nZ4GtslrpqnOVdeMiw4QJBaOws55IR/JfYlwp9L3SbMePeTcsogQkzRU8hLuJTt0vbmz0bd0928BZT6m35ToNpJcnpjzPptjPbMEKO7CVG3aaMT0WhZMRaejUo9JzSryRqbM4/MrgXPuHlZlLvmOfD9SbHi5eOE9Y8I9XFVrF00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QO5FEo2V; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QO5FEo2V"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12dbf4f678eso14453391c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 01 May 2026 23:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777704524; x=1778309324; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FbJ6b1fy73AB3dMnAVmdjFS2ZVdVyrzhxHu4JakLawE=;
        b=QO5FEo2VCYWLQeumTUwuUA89HgnKbhBQQusddLY7lKp5uMGiQLarb/Xtpena9T6EMi
         ciFsm4LEGBTI+1PAhO7UCXLxXWonkLMFgCxoI4lxpSkCjGTLMGmVIBD11GfZW0GvpsvT
         xNhyqY+BqX4rXvvek8D1di17sqzqJJssaKAc1Abw9nhSmG0WpgLdx9d0Ioup5u71gf0b
         u4wdSSbeaFbNlQXhH/NMSOF3fWL1vkrw7SNPh6pP2Gdu1+BhPz7EsVTqGeVlTdM03T++
         1SCgHJjvbPxixeLSikpJEaZF2QtcJSTn+STcIoR0vBvpIuiDzX7EQ4VcdFs7g8gQSDGH
         KLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777704524; x=1778309324;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FbJ6b1fy73AB3dMnAVmdjFS2ZVdVyrzhxHu4JakLawE=;
        b=WT4/CDf9VIahspolHiiLgEY/Uw8K4zxze/ux/2A2fOFKoMef7AHPB2bKICyxsEfxvA
         O6iJkm7XDKG94bRcNJGGrf4OThvLCW5ziMR5yu1oNnbm1H64q/Wgku90yM/byKGOD2EK
         EiXYW9m+qY13N3DCeSMxziuqLwsind2aACJ1588bYMkRtLfMiKH+tZ048FmatmH6kqSc
         /D2Rc30bo12dtcTySJMsgI2TLiGLBobkGhBUodouZ7wHWnlbawEmrAtf+7HlC1YQoZQ3
         y6ovTfn1EI/ASBHw41Uj2h2ToGj3e1S8LSxm5bBNV4Nj2ij/OBr/bptyo6M8oZzATkCM
         V7mg==
X-Forwarded-Encrypted: i=1; AFNElJ+NQkSfhNVj+Rj+CZWmCvhZaWNufa0hpFaHB5FKrQfUjDlXZy2wXgfHBCUcS6Lf3aiDMbBeWGtc0+z2zDmxCEB/@vger.kernel.org
X-Gm-Message-State: AOJu0YxQoLZb4MjJkCfdUWEjpB5Uphz5nqXy/K0oaWHFRq+aEqeXvvvU
	j7aFKYPEZvNackut2gzzjSLP0caqc6VN6L3O1GVpmqbz5he8yxxO/uWf94LSB2ZoC3+nqcLZjV/
	ll5uS3qm8qQ==
X-Received: from dlad13.prod.google.com ([2002:a05:701b:220d:b0:12d:c585:f600])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f404:b0:12d:c730:c7f
 with SMTP id a92af1059eb24-12dfd846da6mr834682c88.33.1777704524181; Fri, 01
 May 2026 23:48:44 -0700 (PDT)
Date: Fri,  1 May 2026 23:48:39 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502064839.282422-1-irogers@google.com>
Subject: [PATCH v1] perf dwarf-aux: Fix libdw segmentation fault in cu_walk_functions_at
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Zecheng Li <zli94@ncsu.edu>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

A segmentation fault was observed in `libdw` when running `perf kmem`
with `--page stat` on some workloads. The crash occurred deep inside
`libdw` (specifically in `dwarf_child` and `dwarf_diename`) when
processing DWARF information.

There were two separate issues contributing to this crash:

1. Dangling pointers from `dwarf_getfuncs`:
`die_find_realfunc` uses `dwarf_getfuncs` to iterate over all functions
in a Compile Unit (CU) to find the one enclosing a given address.
`dwarf_getfuncs` passes temporary `Dwarf_Die` structures to its
callback. Copying these via `memcpy` leads to dangling internal
pointers (such as to `Dwarf_Abbrev` structures) once `dwarf_getfuncs`
returns and cleans up its temporary state. Dereferencing these dangling
pointers in subsequent calls like `dwarf_child` causes a SIGSEGV.

To fix this, use `dwarf_cu_getdwarf(cu_die->cu)` to obtain the `Dwarf`
session pointer, and then use `dwarf_offdie` to securely reconstruct
and cache the `Dwarf_Die` from its offset. This ensures all internal
pointers remain valid and persistent.

2. Uninitialized memory access in `cu_walk_functions_at`:
A logic bug in the `for` loop of `cu_walk_functions_at` attempted to
avoid in-place modifications by using a separate `next_die` buffer.
However, it performed a `memcpy(&die_mem, &next_die)` at the end of the
loop body *before* `next_die` was actually initialized by
`die_find_child` in the loop increment step. This resulted in copying
uninitialized memory into `die_mem` on the first iteration, leading to
a crash on the subsequent step.

Rewrite the loop as a standard `while` loop to ensure that
`die_find_child` fills `next_die` *before* any data is copied into
`die_mem` for the next iteration.

Assisted-by: Gemini:gemini-3.1-pro-preview
Fixes: 221d061182b8 ("perf probe: Support inline function call-site tracing")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dwarf-aux.c | 44 +++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 92db2fccc788..52fdf6d49d3b 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -156,22 +156,25 @@ static int __die_find_inline_cb(Dwarf_Die *die_mem, void *data);
 int cu_walk_functions_at(Dwarf_Die *cu_die, Dwarf_Addr addr,
 		    int (*callback)(Dwarf_Die *, void *), void *data)
 {
-	Dwarf_Die die_mem;
+	Dwarf_Die die_mem, next_die;
 	Dwarf_Die *sc_die;
 	int ret = -ENOENT;
 
 	/* Inlined function could be recursive. Trace it until fail */
-	for (sc_die = die_find_realfunc(cu_die, addr, &die_mem);
-	     sc_die != NULL;
-	     sc_die = die_find_child(sc_die, __die_find_inline_cb, &addr,
-				     &die_mem)) {
+	sc_die = die_find_realfunc(cu_die, addr, &die_mem);
+	while (sc_die != NULL) {
 		ret = callback(sc_die, data);
 		if (ret)
 			break;
+
+		sc_die = die_find_child(sc_die, __die_find_inline_cb, &addr, &next_die);
+		if (sc_die) {
+			memcpy(&die_mem, &next_die, sizeof(Dwarf_Die));
+			sc_die = &die_mem;
+		}
 	}
 
 	return ret;
-
 }
 
 /**
@@ -561,7 +564,7 @@ Dwarf_Die *die_find_child(Dwarf_Die *rt_die,
 			  int (*callback)(Dwarf_Die *, void *),
 			  void *data, Dwarf_Die *die_mem)
 {
-	Dwarf_Die child_die;
+	Dwarf_Die child_die, sibling_die;
 	int ret;
 
 	ret = dwarf_child(rt_die, die_mem);
@@ -579,7 +582,8 @@ Dwarf_Die *die_find_child(Dwarf_Die *rt_die,
 			return die_mem;
 		}
 	} while ((ret & DIE_FIND_CB_SIBLING) &&
-		 dwarf_siblingof(die_mem, die_mem) == 0);
+		 dwarf_siblingof(die_mem, &sibling_die) == 0 &&
+		 (memcpy(die_mem, &sibling_die, sizeof(Dwarf_Die)), 1));
 
 	return NULL;
 }
@@ -622,10 +626,14 @@ Dwarf_Die *die_find_tailfunc(Dwarf_Die *cu_die, Dwarf_Addr addr,
 	/* dwarf_getscopes can't find subprogram. */
 	if (!dwarf_getfuncs(cu_die, __die_search_func_tail_cb, &ad, 0))
 		return NULL;
-	else
-		return die_mem;
+
+	if (dwarf_offdie(dwarf_cu_getdwarf(cu_die->cu), dwarf_dieoffset(die_mem), die_mem) == NULL)
+		return NULL;
+
+	return die_mem;
 }
 
+
 /* die_find callback for non-inlined function search */
 static int __die_search_func_cb(Dwarf_Die *fn_die, void *data)
 {
@@ -647,6 +655,7 @@ static int __die_search_func_cb(Dwarf_Die *fn_die, void *data)
  * die_find_realfunc - Search a non-inlined function at given address
  * @cu_die: a CU DIE which including @addr
  * @addr: target address
+ * @dbg: Dwarf session
  * @die_mem: a buffer for result DIE
  *
  * Search a non-inlined function DIE which includes @addr. Stores the
@@ -661,8 +670,11 @@ Dwarf_Die *die_find_realfunc(Dwarf_Die *cu_die, Dwarf_Addr addr,
 	/* dwarf_getscopes can't find subprogram. */
 	if (!dwarf_getfuncs(cu_die, __die_search_func_cb, &ad, 0))
 		return NULL;
-	else
-		return die_mem;
+
+	if (dwarf_offdie(dwarf_cu_getdwarf(cu_die->cu), dwarf_dieoffset(die_mem), die_mem) == NULL)
+		return NULL;
+
+	return die_mem;
 }
 
 /* die_find callback for inline function search */
@@ -710,15 +722,15 @@ Dwarf_Die *die_find_inlinefunc(Dwarf_Die *sp_die, Dwarf_Addr addr,
 {
 	Dwarf_Die tmp_die;
 
-	sp_die = die_find_child(sp_die, __die_find_inline_cb, &addr, &tmp_die);
+	sp_die = die_find_child(sp_die, __die_find_inline_cb, &addr, die_mem);
 	if (!sp_die)
 		return NULL;
 
 	/* Inlined function could be recursive. Trace it until fail */
 	while (sp_die) {
-		memcpy(die_mem, sp_die, sizeof(Dwarf_Die));
-		sp_die = die_find_child(sp_die, __die_find_inline_cb, &addr,
-					&tmp_die);
+		sp_die = die_find_child(die_mem, __die_find_inline_cb, &addr, &tmp_die);
+		if (sp_die)
+			memcpy(die_mem, &tmp_die, sizeof(Dwarf_Die));
 	}
 
 	return die_mem;
-- 
2.54.0.545.g6539524ca2-goog

