Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7636331E83C
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 08:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777882366; cv=none; b=eLT0WcoJemAmt0rFKUKdiBBju6cDoSyRY66YDd6b81naGfhAomTuaC7lXNJH0h4nBhFWBlfV746NnWTn3MBTRUpqGjzLq8QT4/zKMAg6GFR9bz1n7tgmAFew9Riu/ryA39ylL9DKWoLUM9rleZny3CT+vzQqG6Ej3kWxxeVVLZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777882366; c=relaxed/simple;
	bh=LVk6twmghpuDkUyDpm8DZAKE6+luijBzQniUpl0JTIU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tMmj38E5t3loXVWHdBQAi7uOtT9RJZthyXHb8X92YumGYWXmWS6tx3cS5Wa6sD2jD/MOyc0oxz2TzTPAgx4zHWHUcP2Dm64ULXLQhMadLwgPD3kdHYc5sHi+FLUWU4yadBNntN1dnCcFTjsP/zQu88cHRlta75+JkZAw6QwIGAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A9SO2lyW; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A9SO2lyW"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12dfe06b670so8544392c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 04 May 2026 01:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777882365; x=1778487165; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zG8T7jcDk3Qtd0yaMJTbUTNg1lGwQI504olJ183FCNM=;
        b=A9SO2lyWPaLJrTEIYVYeO6gxAGGApa3wicN56cEcN3Fda1XZ9dxOak2Q4xV+Lio55X
         C+Dj6yCwGiNHZJbO6BzlV7OuwJ1pT/ADxW322X4lcNRnF+yoDfjzFTucIrFxAd/iw+k1
         Zoz8HNGKjo/RrhyIBmkVTs1YMQ8n6h4BoJVVqeS+hmD/tD3fZ/CwWOLrx4WMy+QDmY4U
         MBmhziwvgSTZ03K9LzqRFHIGtOyKGm/QmMnHQVE+UC805yjrCfKmm0KDcZ7w8rmuU99U
         pVkvWvCAjRKXO0yWlMqif9DD5USgFvnRQBfMy53NnWDylLFybOz1iKAH9X7dWBXinlGg
         j1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777882365; x=1778487165;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zG8T7jcDk3Qtd0yaMJTbUTNg1lGwQI504olJ183FCNM=;
        b=jSEt/6/pNKWnvZrZ+Nmu/akbdvJXsfHjqukEx/SnrKVI05BIsrthNTSRi262x9cbOy
         QHHx477BdMH/E9Ncs/d9feIotyZ3qnTjzRFXfMVGBFEIGQ4oaELcLT6AtIWo7+z5G2vh
         y8lhBqa9qfdXymNCAihrdPVR+1f5Q5ec2i4qZDscGPmvWxxuhe+oC7jfu6aP+fV+aNtw
         8n+feUzkTBnCADpb/QqJzgcBf6hxSwCP4T1MPfPmgAnvbsOSm4Wm02BZb4rxynPp95+d
         gw8NrfOc8qiTa7P1xpZrL735RqWYDywRMJC8vw87Y9FFZUxA6J5JiBA9a1HwT76lt1+h
         0yHQ==
X-Forwarded-Encrypted: i=1; AFNElJ++I4dSSIxob+YzH6bzQA6F8HaUOLiBfIzM++ZcI/q5M7W/iX8ra4K82sl32C694OJybR+mVBJgKP7C5FfZprsJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwczVBpdpA3jhWRuJbdDKB1zeRscBnbfErdavrc0F6tKYuIpKH5
	fVQrIsMcA40OaClrUqnzXjqNFXtKoBsFyWDI4bu1gEZIhlvz1PTtHeXUW+h7upKw3Gbw9046BCz
	9XwPkjB2j5g==
X-Received: from dlea9-n1.prod.google.com ([2002:a05:701b:4209:10b0:12d:bcd0:59a4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:b9f:b0:12d:de3f:d840
 with SMTP id a92af1059eb24-12dfd86125dmr3675395c88.35.1777882364250; Mon, 04
 May 2026 01:12:44 -0700 (PDT)
Date: Mon,  4 May 2026 01:12:24 -0700
In-Reply-To: <20260504081227.2203848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503171032.1559338-1-irogers@google.com> <20260504081227.2203848-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504081227.2203848-7-irogers@google.com>
Subject: [PATCH v5 6/9] perf libdw: Fix libdw API contract violations and
 memory leaks
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Zecheng Li <zli94@ncsu.edu>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Check return values of `dwfl_report_end` and `dwfl_module_addrdie`
to prevent using uninitialized stack variables or reporting success on
failure.

Additionally:
 - Ensure `*file` is freed and inline frames are cleared on error in
   `libdw__addr2line()` to prevent memory leaks and duplicated
   callchains when falling back to other unwinders.
 - Use `die_name()` safe wrapper inside the inline function unwinding
   callback (`libdw_a2l_cb`).
 - Refactor `libdw_a2l_cb`'s repeated memory error handling/cleanup
   paths using a cleaner goto control flow.

Fixes: b7a2b011e962 ("perf powerpc: Unify the skip-callchain-idx libdw with that for addr2line")
Fixes: 88c51002d06f ("perf addr2line: Add a libdw implementation")
Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
v5:
 - Split from original Patch 3/6. Refactored libdw_a2l_cb error handling with goto.
---
 tools/perf/util/libdw.c | 49 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/libdw.c b/tools/perf/util/libdw.c
index 196b9cdf51b2..84713b2a7ad5 100644
--- a/tools/perf/util/libdw.c
+++ b/tools/perf/util/libdw.c
@@ -61,7 +61,10 @@ struct Dwfl *dso__libdw_dwfl(struct dso *dso)
 		return NULL;
 	}
 
-	dwfl_report_end(dwfl, /*removed=*/NULL, /*arg=*/NULL);
+	if (dwfl_report_end(dwfl, /*removed=*/NULL, /*arg=*/NULL) != 0) {
+		dwfl_end(dwfl);
+		return NULL;
+	}
 	dso__set_libdw(dso, dwfl);
 
 	return dwfl;
@@ -73,18 +76,19 @@ struct libdw_a2l_cb_args {
 	struct inline_node *node;
 	char *leaf_srcline;
 	bool leaf_srcline_used;
+	int err;
 };
 
 static int libdw_a2l_cb(Dwarf_Die *die, void *_args)
 {
 	struct libdw_a2l_cb_args *args  = _args;
-	struct symbol *inline_sym = new_inline_sym(args->dso, args->sym, dwarf_diename(die));
+	struct symbol *inline_sym = new_inline_sym(args->dso, args->sym, die_name(die));
 	const char *call_fname = die_get_call_file(die);
 	int call_lineno = die_get_call_lineno(die);
 	char *call_srcline = srcline__unknown;
 
 	if (!inline_sym)
-		return -ENOMEM;
+		goto abort_enomem;
 
 	/* Assign caller information to the parent. */
 	if (call_fname)
@@ -110,12 +114,27 @@ static int libdw_a2l_cb(Dwarf_Die *die, void *_args)
 
 	/* Add this symbol to the chain as the leaf. */
 	if (!args->leaf_srcline_used) {
-		inline_list__append_tail(inline_sym, args->leaf_srcline, args->node);
+		if (inline_list__append_tail(inline_sym, args->leaf_srcline, args->node) != 0)
+			goto abort_delete_sym;
 		args->leaf_srcline_used = true;
 	} else {
-		inline_list__append_tail(inline_sym, strdup(args->leaf_srcline), args->node);
+		char *srcline = strdup(args->leaf_srcline);
+
+		if (!srcline)
+			goto abort_delete_sym;
+		if (inline_list__append_tail(inline_sym, srcline, args->node) != 0) {
+			free(srcline);
+			goto abort_delete_sym;
+		}
 	}
 	return 0;
+
+abort_delete_sym:
+	if (inline_sym->inlined)
+		symbol__delete(inline_sym);
+abort_enomem:
+	args->err = -ENOMEM;
+	return DWARF_CB_ABORT;
 }
 
 int libdw__addr2line(u64 addr, char **file, unsigned int *line_nr,
@@ -169,11 +188,29 @@ int libdw__addr2line(u64 addr, char **file, unsigned int *line_nr,
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
-- 
2.54.0.545.g6539524ca2-goog

