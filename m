Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48663859D2
	for <linux-perf-users@vger.kernel.org>; Sat,  2 May 2026 15:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777737447; cv=none; b=FIAbyxTq5UNG75VXt5VV18F63fGGM2kT506xIUsXUfwUuMwnG7CowqjYJrdj1TR9L0dizWCDxa2Orlzcc7sHElgSUQWXNffcoQBOHpO9GS4pfJMQUtllC/5iEFvsDYY4D2k2flpYTbSxSCTV+v2iZIQRxROC+wFzoUhRdaeBFd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777737447; c=relaxed/simple;
	bh=bcwWM4oAyHctxhNnyNPL9T001VW9Tcv3kAMmr4OqRsE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZnLPgVrpuZS/Di4I3C/wWe9/mvvPs8LIWYJeAZU92bEeIJAQLffTpLjWFTiajwapesJOQhtJfPhDFGI6nef+CcnYPGqpdM3iG7k5mleoWDAzyqCIuodboPVE93Au8tPFPE3/GKVPX9j79KXyIs4sgVWUb7vqgx301i/2ANJcCDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N1u52Mnd; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N1u52Mnd"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12dba1e866dso2828369c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 02 May 2026 08:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777737446; x=1778342246; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YPd2uZcGUUWJNN1IIJhqH/dm1zq9pHxS4EWiNfzZKto=;
        b=N1u52MndtIU2kLhUjOXtgizbKxMkAnk6jtDAw2iu40qsQ5ayof9Xk+Ux/fGiFMqD5r
         2/zShUZwbhI7GDaie8XlesgNaqlZCYzLZQ3XzZk8A4v//l7iz2ypv5oAr7/EdfY+7X5K
         2MIwWFJrJiBVv5ybPtdDpMoNIuxaGAmZPrEewh9QLqKFsTmaRLLuT2QvCp6RCbzZJdRw
         vlRtRMG18xqqGkYz32U3lhXehiQOiO7lhND+dIkA7JnnoSu2Z1jqHPdhpeeum0F6OUNI
         CVoKzb59V/cUfeY/rLe3axHGbXqibxdu/dA4Ry3rvZslsTL7Ep8T14u06k89icHDxvcf
         gkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777737446; x=1778342246;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YPd2uZcGUUWJNN1IIJhqH/dm1zq9pHxS4EWiNfzZKto=;
        b=cmCNMdDgSq3ldc9ZosI8KoBKanEb3f6mlfBD2gpvORCcZpDGP56J+h4vcjYCdmFNkU
         TTH/g26SVjZ6XUH/vwLdYLmyMHGwCnIncb8HY8hWWYF2SqhCSxj6feDVrgbYq+fm92z3
         gjm/srP5qUa7WLar2h5xKPXhsXacqUKHsWMRUxjhZWUzkLkTFsNIYShRzTMURGbYT2wW
         vXr/es4qUCfs3EsaV4fHwr7A1YLnzT7ekqWCHRH2OXu9g9kcZ+56W+usBUdz09la/PMK
         FXE8Tn7y1Wja4nUSM/jyRJu3zuvRRuAVff2dP97VwUdOmoXnhZp7wZST/oQxClB0tzT1
         qxhA==
X-Forwarded-Encrypted: i=1; AFNElJ8ZNr1WnCp4/21+NmW4gJbWn46/jUUF/e+bbvtrWxzS0eG5lTWqO8oAiaRIfthjr1YBPeGJOlMp+LcF3wJBTclG@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3zStptIO2vFUgvuC+x4DyLy/TtJp1gD3++qnd4dFmqqzDg4GD
	u3cC8GZ9znWJ1bPihPK//Fghl/E0uZV36LCoeYPbIxbu4kCcnJ5VSZwhNK2Z7RH44L33q6AI2Bp
	HU8SNRCXNkQ==
X-Received: from dleb6-n1.prod.google.com ([2002:a05:701b:4246:10b0:12a:9ef0:93ed])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:693:b0:12a:8122:24a9
 with SMTP id a92af1059eb24-12dece338bcmr4012923c88.22.1777737445602; Sat, 02
 May 2026 08:57:25 -0700 (PDT)
Date: Sat,  2 May 2026 08:56:53 -0700
In-Reply-To: <20260502155656.478642-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502064839.282422-1-irogers@google.com> <20260502155656.478642-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502155656.478642-4-irogers@google.com>
Subject: [PATCH v2 3/6] perf libdw: Fix libdw API contract violations
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

