Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5787F372EF5
	for <linux-perf-users@vger.kernel.org>; Sun,  3 May 2026 17:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777828251; cv=none; b=Eq/rF/i0oZFWhLA2ZQhmmZHJbUnMHcxW0oUmavsWZT0iBXKCtWLsUnAMHcfIuLUadEhjRC6uUDPC5uvGBUjCHLdMbMzBFR2OTAmkgwUXg6NVnj0wkmpY3dDzfvm2o99DD+1dH3f6TSraNJQbEivKC8llmRbFveOEnLHki1TrYWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777828251; c=relaxed/simple;
	bh=twLN1Z1yGMGWkKYCQ23p7Txv1I+kqyjqk5QXs5o7OfA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BeJB0CzQIzjxaNyJIcL7vU75Cdkt2yz6Z3herx1IsTU2CtKBmo0L3zFs5NGDwytLnfhMai6bYQH4rVERMOMFwnsmLz0C7YUhbUugoPyNhDNuhyQQ5p2dCikhYw/Scjo/u+rx/DDfOQSq66xq4ljFSblql3+0OsDaipYXwhU6Gh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SksZGP3N; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SksZGP3N"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12dfdde7ce7so8027344c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 03 May 2026 10:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777828249; x=1778433049; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ve6SWXuI0g3UIJWrk0QyWnJcnIHFUm99czrE0ptbwhQ=;
        b=SksZGP3NignalvcOCP7DegrTg6zdRAaxoZCPAOU2Av6E6kAKG0WwLH5USLQv7x609L
         JjrxX3PiW7EXoDhWPzN+UCDvPTJPSW4/sFF75/QxPZ7SjGKYkcw/oNbnIgNLsMjBy6uw
         VxIUzdMsg9h2zwtcuCqnR8yplQ3a4CfF317S/GAe0Iyrr43U5nYV4/aqf1ISDmxOaKwK
         x0L1whnKgK6bJ3NhFsKeSshdjAXOJu77DMPBG50lDsZdUERdpA2w1THuIrRKBnAYRpaW
         syKuhkm7FEM4+QfOAaA5jMIW4yQbC7EWFtetr7zRuAm+cXhIizuruuflbqk8GcwW71Zy
         BwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777828249; x=1778433049;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ve6SWXuI0g3UIJWrk0QyWnJcnIHFUm99czrE0ptbwhQ=;
        b=ZZJwoaVC0kpo58jxomonlKG++3aXxmXMqvwIujV/wWnHtjkxBOoVbLa7c6pvvNsyBr
         g+icThHTjVTwxcwOvlk3TUIwXPNbjdlUSAAiYg0vaMrCO/u/qHjfaHxypqBuY4THGJhi
         xfuhpJgWD32s8cw3/v6Tc2PWQjhCogabJ/kMoVuP2f30TsxpAeQImnLLoRlijPBMIWiC
         Y8yaZHwDCE9zpJ0OOs1G+In9nLyieaWNEnFK8Go3acnBtUheEA7NS8EVQ60dsf4L7GD3
         7DVSqES0OYTAv/X2B9nZk364fji8EqN3IRJkWFidv8alEvZdyX1QVS9uvew2c3TPfbmT
         fFRw==
X-Forwarded-Encrypted: i=1; AFNElJ93zIJ01qHzkOvL9FE6c5EyqI8i7YHbJzU42RgSkpfB5sqlWCPHLWgxiwAm4uFyUaePJCoR5uU55M18lBNyk593@vger.kernel.org
X-Gm-Message-State: AOJu0YwbdlNCp4f0sNp7rKov/6DwxUhltTHCXZqL0Z84tP9fsqxDd9VE
	t4HJpspFJXFFOetMTrK7GJi6Us72qw7xih95su/z3mcg8zi2hIV2HR+uGpA10wqoD4kl5irTNJz
	fxht33iT44g==
X-Received: from dlea6-n1.prod.google.com ([2002:a05:701b:4206:10b0:12d:e33d:70da])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:271a:b0:130:68a1:a235
 with SMTP id a92af1059eb24-13068a1a485mr294901c88.27.1777828249197; Sun, 03
 May 2026 10:10:49 -0700 (PDT)
Date: Sun,  3 May 2026 10:10:29 -0700
In-Reply-To: <20260503171032.1559338-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503003552.1063540-1-irogers@google.com> <20260503171032.1559338-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503171032.1559338-4-irogers@google.com>
Subject: [PATCH v4 3/6] perf libdw: Fix libdw API contract violations
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Zecheng Li <zli94@ncsu.edu>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Check return values of `dwfl_report_end` and `dwfl_module_addrdie`.
Check `die_get_call_lineno` for errors.

Additionally:
 - Introduce `inline_node__clear_frames()` to clean up partial
   allocations.
 - Ensure `*file` is freed and inline frames are cleared on error in
   `libdw__addr2line()` to prevent memory leaks and duplicated
   callchains when falling back to other unwinders.
 - Allow DWARF line 0 in `libdw_a2l_cb()`, as it is a valid
   reference for compiler-generated code.
 - Fix the parent srcline lookup in `libdw_a2l_cb()` to target the
   correct parent node depending on the callchain order
   (ORDER_CALLER/ORDER_CALLEE).

Fixes: b7a2b011e962 ("perf powerpc: Unify the skip-callchain-idx libdw with that for addr2line")
Fixes: 88c51002d06f ("perf addr2line: Add a libdw implementation")
Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
v4:
 - Fix memory leaks and duplicated callchains on unwinding errors.
 - Support DWARF line 0 in inline list.
 - Fix callchain parent update in ORDER_CALLER mode.
---
 tools/perf/util/libdw.c   | 84 +++++++++++++++++++++++++++++++--------
 tools/perf/util/srcline.c |  9 ++++-
 tools/perf/util/srcline.h |  1 +
 3 files changed, 77 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/libdw.c b/tools/perf/util/libdw.c
index 216977884103..e69ff4cea856 100644
--- a/tools/perf/util/libdw.c
+++ b/tools/perf/util/libdw.c
@@ -4,6 +4,7 @@
 #include "srcline.h"
 #include "symbol.h"
 #include "dwarf-aux.h"
+#include "callchain.h"
 #include <fcntl.h>
 #include <unistd.h>
 #include <elfutils/libdwfl.h>
@@ -60,7 +61,11 @@ struct Dwfl *dso__libdw_dwfl(struct dso *dso)
 		return NULL;
 	}
 
-	dwfl_report_end(dwfl, /*removed=*/NULL, /*arg=*/NULL);
+	if (dwfl_report_end(dwfl, NULL, NULL) != 0) {
+		dwfl_end(dwfl);
+		return NULL;
+	}
+
 	dso__set_libdw(dso, dwfl);
 
 	return dwfl;
@@ -72,41 +77,70 @@ struct libdw_a2l_cb_args {
 	struct inline_node *node;
 	char *leaf_srcline;
 	bool leaf_srcline_used;
+	int err;
 };
 
 static int libdw_a2l_cb(Dwarf_Die *die, void *_args)
 {
 	struct libdw_a2l_cb_args *args  = _args;
-	struct symbol *inline_sym = new_inline_sym(args->dso, args->sym, dwarf_diename(die));
+	const char *name = dwarf_diename(die);
+	struct symbol *inline_sym = new_inline_sym(args->dso, args->sym, name ?: "unknown");
 	const char *call_fname = die_get_call_file(die);
+	int call_lineno = die_get_call_lineno(die);
 	char *call_srcline = srcline__unknown;
-	struct inline_list *ilist;
 
-	if (!inline_sym)
-		return -ENOMEM;
+	if (!inline_sym) {
+		args->err = -ENOMEM;
+		return DWARF_CB_ABORT;
+	}
 
 	/* Assign caller information to the parent. */
-	if (call_fname)
-		call_srcline = srcline_from_fileline(call_fname, die_get_call_lineno(die));
+	if (call_fname && call_lineno >= 0)
+		call_srcline = srcline_from_fileline(call_fname, call_lineno);
 
-	list_for_each_entry(ilist, &args->node->val, list) {
-		if (args->leaf_srcline == ilist->srcline)
+	if (!list_empty(&args->node->val)) {
+		struct inline_list *parent;
+
+		if (callchain_param.order == ORDER_CALLEE)
+			parent = list_first_entry(&args->node->val, struct inline_list, list);
+		else
+			parent = list_last_entry(&args->node->val, struct inline_list, list);
+
+		if (args->leaf_srcline == parent->srcline)
 			args->leaf_srcline_used = false;
-		else if (ilist->srcline != srcline__unknown)
-			free(ilist->srcline);
-		ilist->srcline =  call_srcline;
+		else if (parent->srcline != srcline__unknown)
+			free(parent->srcline);
+		parent->srcline = call_srcline;
 		call_srcline = NULL;
-		break;
 	}
 	if (call_srcline && call_srcline != srcline__unknown)
 		free(call_srcline);
 
 	/* Add this symbol to the chain as the leaf. */
 	if (!args->leaf_srcline_used) {
-		inline_list__append_tail(inline_sym, args->leaf_srcline, args->node);
+		if (inline_list__append_tail(inline_sym, args->leaf_srcline, args->node) != 0) {
+			args->err = -ENOMEM;
+			if (inline_sym->inlined)
+				symbol__delete(inline_sym);
+			return DWARF_CB_ABORT;
+		}
 		args->leaf_srcline_used = true;
 	} else {
-		inline_list__append_tail(inline_sym, strdup(args->leaf_srcline), args->node);
+		char *srcline = strdup(args->leaf_srcline);
+
+		if (!srcline) {
+			args->err = -ENOMEM;
+			if (inline_sym->inlined)
+				symbol__delete(inline_sym);
+			return DWARF_CB_ABORT;
+		}
+		if (inline_list__append_tail(inline_sym, srcline, args->node) != 0) {
+			free(srcline);
+			args->err = -ENOMEM;
+			if (inline_sym->inlined)
+				symbol__delete(inline_sym);
+			return DWARF_CB_ABORT;
+		}
 	}
 	return 0;
 }
@@ -162,11 +196,29 @@ int libdw__addr2line(u64 addr, char **file, unsigned int *line_nr,
 			.leaf_srcline = srcline_from_fileline(src ?: "<unknown>", lineno),
 		};
 
+		if (!args.leaf_srcline) {
+			if (file && *file) {
+				free(*file);
+				*file = NULL;
+			}
+			return 0;
+		}
+
 		/* Walk from the parent down to the leaf. */
-		cu_walk_functions_at(cudie, addr, libdw_a2l_cb, &args);
+		if (cudie)
+			cu_walk_functions_at(cudie, addr, libdw_a2l_cb, &args);
 
 		if (!args.leaf_srcline_used)
 			free(args.leaf_srcline);
+
+		if (args.err) {
+			if (file && *file) {
+				free(*file);
+				*file = NULL;
+			}
+			inline_node__clear_frames(node);
+			return 0;
+		}
 	}
 	return 1;
 }
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index db164d258163..62884428fb5a 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -429,10 +429,13 @@ struct inline_node *dso__parse_addr_inlines(struct dso *dso, u64 addr,
 	return addr2inlines(dso_name, addr, dso, sym);
 }
 
-void inline_node__delete(struct inline_node *node)
+void inline_node__clear_frames(struct inline_node *node)
 {
 	struct inline_list *ilist, *tmp;
 
+	if (node == NULL)
+		return;
+
 	list_for_each_entry_safe(ilist, tmp, &node->val, list) {
 		list_del_init(&ilist->list);
 		zfree_srcline(&ilist->srcline);
@@ -441,7 +444,11 @@ void inline_node__delete(struct inline_node *node)
 			symbol__delete(ilist->symbol);
 		free(ilist);
 	}
+}
 
+void inline_node__delete(struct inline_node *node)
+{
+	inline_node__clear_frames(node);
 	free(node);
 }
 
diff --git a/tools/perf/util/srcline.h b/tools/perf/util/srcline.h
index 7c37b3bf9ce7..1018cbc886d6 100644
--- a/tools/perf/util/srcline.h
+++ b/tools/perf/util/srcline.h
@@ -47,6 +47,7 @@ struct inline_node *dso__parse_addr_inlines(struct dso *dso, u64 addr,
 					    struct symbol *sym);
 /* free resources associated to the inline node list */
 void inline_node__delete(struct inline_node *node);
+void inline_node__clear_frames(struct inline_node *node);
 
 /* insert the inline node list into the DSO, which will take ownership */
 void inlines__tree_insert(struct rb_root_cached *tree,
-- 
2.54.0.545.g6539524ca2-goog

