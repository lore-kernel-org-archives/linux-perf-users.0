Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1D01FE47B
	for <linux-perf-users@vger.kernel.org>; Sun,  3 May 2026 00:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777768564; cv=none; b=GKWLmf3lu6ipRTkgkGKmzNzjq0XcpZY9JYhLXPqeR5vPMDNxGT43ZNeKFLSnA92LrSSDVyWSiWPp/qVeWmVz8He5xu+LfodgwOkAsCejz8xgeXxubZ0n5djWDFC4A5olii9KPoaTHaxKy7pwsDB8KbywczFV9qHdu9gopZQf3eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777768564; c=relaxed/simple;
	bh=bcwWM4oAyHctxhNnyNPL9T001VW9Tcv3kAMmr4OqRsE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CmN7EuCd/4+RhPQoSwk1BYOG8Dx1qgZlbf9jIqe03P0jgmUVmgzH05eXSqimOk0GTovHVe9gXm4NhLM6XOFXSUfe1bhrqtZG2b7740kqByTowABhjgRoqVYp6OL12dptRH2Z9X2Ss7Gc1533loxqATqAh2b1n8WgOcKF9QbJchU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FqIRcv7W; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FqIRcv7W"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35d9e67f6dcso7377954a91.1
        for <linux-perf-users@vger.kernel.org>; Sat, 02 May 2026 17:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777768563; x=1778373363; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YPd2uZcGUUWJNN1IIJhqH/dm1zq9pHxS4EWiNfzZKto=;
        b=FqIRcv7WIPWZycqhFFYuT1fMtC5whLTqkdIQOov++yIgNM1ru8r3T7+GD4j0xukD05
         alYccCk2b77XMElBNrfeF05PP0yzLOsgCvZKXl4PN5I9zD6SszqX1W1p5XDQhfBB5xjX
         XrWbtVj5SlfkxBRA0fbQX4qend+eC140srrcN0ecFKbzqlFZfjpi9in53BUmm0O9h7jw
         JpAW9gi8YSOxZD2FplDB9QxD+YhnP3vG6MklLPRiB3PZfAVe9xZpnUFvVLTqzQkwLv+M
         qBgCdP6mJ1nyJjoIf89pYuKl23cmcxGBB4Xg4upZfrQndZmengc6fYR5w/B1JQZL5U9c
         Op/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777768563; x=1778373363;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YPd2uZcGUUWJNN1IIJhqH/dm1zq9pHxS4EWiNfzZKto=;
        b=CxiU4d5mrbPj9J4+irU+TtyCDw0AWUqzgg/bHwckqp3EZK6BSryALT0tm1UtUvvN2O
         f+GPlBPKLR7/9/r96lP4WahhVPtR75epJjFBeyHTCd+lyzFTdMI7HJ3cPLXpHGGDU7DA
         N0I4T6PBq/pa6yWsmZY/XEtvXJX4Jcwr8E2ATMuBqnAC7JyIyrf8S74C9U8L+vd0oQ0i
         OhYKdhW8Beum1HN7AW92gWVgvSEbXohE7Ugk4EhZBhg7uNOCBtciLUarZ5dGI8kAJdYa
         IpGqSprcHM8orDq+FQkrvJVOJeE+YjppLiwFDCJK8is+/2J97hNIQG4vaOVU9TRFaJWt
         lCJg==
X-Forwarded-Encrypted: i=1; AFNElJ+2FMKjimXHFr7g2hwAXlJIBxcpSWbsgcqlo0EQeh9+RDkuQ3m22E9KSs4szoHkJCCAwbZrer7Wfz2aY85oLiTV@vger.kernel.org
X-Gm-Message-State: AOJu0YxKpjLQXnn8O8pq92t7f89poAaiNoc68Hk3vz+13mEMbz7N2+hb
	wYIuM1RgyvQXHp3hK1BqZOFlz+YRrLoCvX7EOcudhI+Quu82NgXPSBVGkrTdU40+xobxClAH12V
	djp0I5S3hXQ==
X-Received: from pghp4.prod.google.com ([2002:a63:fe04:0:b0:c74:390e:55b3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:158b:b0:398:4a1f:8a54
 with SMTP id adf61e73a8af0-3a7f1c24b44mr4804121637.2.1777768562487; Sat, 02
 May 2026 17:36:02 -0700 (PDT)
Date: Sat,  2 May 2026 17:35:49 -0700
In-Reply-To: <20260503003552.1063540-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503003552.1063540-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503003552.1063540-4-irogers@google.com>
Subject: [PATCH v3 3/6] perf libdw: Fix libdw API contract violations
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Zecheng Li <zli94@ncsu.edu>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Check return values of `dwfl_report_end` and `dwfl_module_addrdie`.
Validate `dwarf_diename` result before passing to `new_inline_sym` (avoid
potential `strdup(NULL)` crash) and check `die_get_call_lineno` for
errors.

Fixes: b7a2b011e962 ("perf powerpc: Unify the skip-callchain-idx libdw with that for addr2line")
Fixes: 88c51002d06f ("perf addr2line: Add a libdw implementation")
Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/libdw.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/libdw.c b/tools/perf/util/libdw.c
index 216977884103..e37f3b22699d 100644
--- a/tools/perf/util/libdw.c
+++ b/tools/perf/util/libdw.c
@@ -60,7 +60,11 @@ struct Dwfl *dso__libdw_dwfl(struct dso *dso)
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
@@ -72,22 +76,27 @@ struct libdw_a2l_cb_args {
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
 	struct inline_list *ilist;
 
-	if (!inline_sym)
-		return -ENOMEM;
+	if (!inline_sym) {
+		args->err = -ENOMEM;
+		return DWARF_CB_ABORT;
+	}
 
 	/* Assign caller information to the parent. */
-	if (call_fname)
-		call_srcline = srcline_from_fileline(call_fname, die_get_call_lineno(die));
+	if (call_fname && call_lineno > 0)
+		call_srcline = srcline_from_fileline(call_fname, call_lineno);
 
 	list_for_each_entry(ilist, &args->node->val, list) {
 		if (args->leaf_srcline == ilist->srcline)
@@ -163,7 +172,8 @@ int libdw__addr2line(u64 addr, char **file, unsigned int *line_nr,
 		};
 
 		/* Walk from the parent down to the leaf. */
-		cu_walk_functions_at(cudie, addr, libdw_a2l_cb, &args);
+		if (cudie)
+			cu_walk_functions_at(cudie, addr, libdw_a2l_cb, &args);
 
 		if (!args.leaf_srcline_used)
 			free(args.leaf_srcline);
-- 
2.54.0.545.g6539524ca2-goog

