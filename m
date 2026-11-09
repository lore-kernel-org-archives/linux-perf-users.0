Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794219454;
	b=u5JUpr5EeUJr1GC7ujdl2vcuD0/wofM3ApMjVJkB8ZsbFT6mEY/6LrFONUrS8RrObvFV
	 NBgK1M6ap0Evk6gjHZOYfTG2MsFieZzb4NwEJkyWKS7yZu9/Rcspfg/BU8OArcTOk5A1J
	 aXt4kigxB6n7uNknajem9DQqiWVcJmCdepNymV2HBPtUsL2jy7TdTdmQZh0Z+mJNFuqUU
	 cGL04VQf8lA/aUxXdZdJJ2lFL5wXOX2c7q2O4vbl+petaBxfV95Wnx8D3im3V14wZRVox
	 J28Bi/m6qdjd0BzVjRZ2rIdZqPcyvJAnFRrBZZXpmkB75YsVKpZS3DuJHQRzZNygf1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794219454;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=bvVa3bulUsYqSwCXV6o2ClwLUYzLh1XdnIqlWVEHka4=;
	b=vhF/gKakJ9epjuGzhwry8TO4f7IQjM2dhG+GSOJrL+chQNvaqylo/b5Ox4fgLPimCf30
	 VMm2mrXFMlwFRt6QEnlpzJFwqGIbul/b6k2BzaeeaeKwYh+qaQOn95biwnGhNy0GLqFvC
	 vae/GuBX3edIWM6SYEAju07twybM1fN9bP5yxKWwijx1nqgY8BObk98rTR5nXmiP6Rnw5
	 GdrilO5l7rO+/SbdC5cIH0Yb8jwe1a18d31jnYOrpLfATKk9q7UX5vIzO1WSvU52zP0+Y
	 7v4YRokiwxrqY1JhFNBkJlFK812NTHoZqJceo7T9mdcNlUPWeHZ2x8YyVKvevyySXkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rOzYBPZx;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18466606D812
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 10:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18466606D812
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rOzYBPZx
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso4766295e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Nov 2026 02:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794219451; x=1794824251; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bvVa3bulUsYqSwCXV6o2ClwLUYzLh1XdnIqlWVEHka4=;
        b=rOzYBPZxig3Ym+XAUmIMsKUL32rQc4RdRGlBogmtC23StL5mgnjoxBpMSqzXdyMhtV
         0sTiAS/sh1n8Ds2oCB8n1GnJhXyktaULTHyLBrvU7S1bT/HmUoF9IrzvadW0LWlsbXDe
         cBARwf1d+f1bIxwLEd0BTyHpMCk/6wLRgRNvZPOO2BxrhbY1vU7HJfghqpYDDLfnlZJ3
         66jkoNUZB2agOPbDKx/CIDUkNHBH5ubBKW+ICH5/Todpv8hJpuxBQ6KyCQe4kTKxRu0K
         JunTFxwVctZzF6dkYFTgsPRkNK5eTVjqe06y2Y3googRp6KBO0Kxg+H+K5miSNFloo9G
         JwEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794219451; x=1794824251;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bvVa3bulUsYqSwCXV6o2ClwLUYzLh1XdnIqlWVEHka4=;
        b=UrV0P+MSlMUr+djoxhxGiPK1Ne9lb5hSyskC414eDzyY4qiY9sXSEmWNQDDEp1xo9Z
         kkMWTNw+/yyqecRztdNcdo8vwQOT3HGgMI4xmzkUTbW4WoM/QAyT/B9d033maW4Bex3m
         c6WMpg6vM9+4pbwfArwdTpqR/r9kaoZZWiNrduG5omtjMlbOgZqX0tlve81wd2QukPpu
         6EpfR8bpUAoGOjh7CxQhFxyVRJqqK+DzUiPIhItFhMROeWWdF1gun+l9yWPu9mOlEogi
         10Zx4J4yEqClPWSAGo3rSN9ZyqyRxTIYgFZlaCv0HsNVhe2tIDr1wfGQk2PAVCjkHRSg
         OJVA==
X-Forwarded-Encrypted: i=1; AL+hErHFdEa/+XeVVZzxFRe9HCMwO4iIUo9fQXtzuK/SkQm+Kc6s4dslkc7OZ/xLqnCpY2ppinX/0Qzfs2aWKHOhGTna@vger.kernel.org
X-Gm-Message-State: APuU4Z8gk1LdvVL9Hds6YCcOWcKHsOOen3HokoLJY49PnSgF2+ISyrdZ
	DMJbE49lWfxxLo2I8z5FcDa6Fe3crwvYm87hZ6O0hRSnx7GlVLsy+o9hjiuib2BqJJ0=
X-Gm-Gg: AYBFou1oCjkMQSIPZYc4GBqMWAbxTKRlEYipG+cwnyZLWm7cFZS5hjMMpfciPdK8ecS
	P5KKvg89Y1zHUKMEdafjhl7bSN8US+7+kUodHuXVBNHUHeZpZImADZtdh9tdC0bGkvOYQc1Ys8T
	lMDNQdWHM81+qXiSq9H6DUvyPfSIJgNF2Gf6ijYpLG7CbCgHVQeRgU0ljhzz2J52GT+VRnZ8vqm
	XjlWJSY+yV6GzFnOy79YAjd34Ev78lIoqY/Vo9d6opRLyTvq4zbNzw3JuLXj0MY/jG86WP0l3Uh
	6cZFMcUnkY40W/PpkdOqslgeDyInk/UUfwDJKmen1WjD8MEI9AGi2v9yKz8I8SaSzz4/XcjPaA4
	Ci3KW5IgSKr6OPXJJK+ucvN3U6e4GCjvtt6lhgoMdiO7Dz2n8DaQceUjm92dwP7IYCkiYTONAZk
	nFmlr1W2sZWuHGuZK8RZIL3QRjcdzT1Y76NS16BCqIHHtqMRtZAlK0CgrfBKnQscRZumOOE++Dd
	1WZ/6ckaWVrGlvvJtEv1+CGQ9Ucw2djA+bn8cUu7AjK0Yebx6K8ZZTRBBSpBY6GPKynznIHugqn
	xDfDNip5JBj+RjLvVQuR8DCSVQ47qCKv
X-Received: by 2002:a05:600c:314f:b0:4a4:fc8c:cfd9 with SMTP id 5b1f17b1804b1-4b963c73aa2mr70024315e9.25.1794219451235;
        Mon, 09 Nov 2026 02:17:31 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b90ee1de2esm121575795e9.5.2026.11.09.02.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 02:17:30 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 09 Nov 2026 10:17:02 +0000
Subject: [PATCH v3 2/4] perf dwarf-aux: Support DW_OP_addrx locations for
 global variables
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-james-perf-test-fixes-v3-2-e8d0a65e618a@linaro.org>
References: <20261109-james-perf-test-fixes-v3-0-e8d0a65e618a@linaro.org>
In-Reply-To: <20261109-james-perf-test-fixes-v3-0-e8d0a65e618a@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Jakub Brnak <jbrnak@redhat.com>, 
 Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

die_find_variable_by_addr() and die_collect_global_vars() only accept
global variables with a DW_OP_addr location. DWARF 5 producers like
clang use DW_OP_addrx instead, which is an index into .debug_addr, so
global variables are never found when Perf is built with LLVM=1.

Add a helper that also resolves DW_OP_addrx and DW_OP_GNU_addr_index
through dwarf_getlocation_attr() and dwarf_formaddr(), and use it in
both places. This fixes the "perf data type profiling tests" test:

  $ perf test -vvv "perf data type profiling tests"
  ...
  Basic C perf annotate test
  Basic annotate [Failed: missing target data type]
  ...
  Pipe C perf annotate test
  Pipe annotate [Failed: missing target data type]
  ...
  Basic FS perf annotate test
  Basic annotate [Failed: missing target data type]
  ...
  Pipe FS perf annotate test
  Pipe annotate [Failed: missing target data type]
  ---- end(-1) ----
   88: perf data type profiling tests : FAILED!

Fixes: d60469d7c0e5 ("perf dwarf-aux: Add die_find_variable_by_addr()")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/dwarf-aux.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 4cc231ffcb2a..d972c121171f 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1666,6 +1666,27 @@ Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die, Dwarf_Addr pc, int reg,
 	return result;
 }
 
+/*
+ * Get the absolute address of a location op. DWARF 5 producers like clang use
+ * DW_OP_addrx, which is an index into .debug_addr, instead of DW_OP_addr.
+ */
+static bool die_get_op_addr(Dwarf_Attribute *attr, Dwarf_Op *op, Dwarf_Addr *addr)
+{
+	Dwarf_Attribute addr_attr;
+
+	switch (op->atom) {
+	case DW_OP_addr:
+		*addr = op->number;
+		return true;
+	case DW_OP_addrx:
+	case DW_OP_GNU_addr_index:
+		return dwarf_getlocation_attr(attr, op, &addr_attr) == 0 &&
+		       dwarf_formaddr(&addr_attr, addr) == 0;
+	default:
+		return false;
+	}
+}
+
 /* Only checks direct child DIEs in the given scope */
 static int __die_find_var_addr_cb(Dwarf_Die *die_mem, void *arg)
 {
@@ -1673,7 +1694,7 @@ static int __die_find_var_addr_cb(Dwarf_Die *die_mem, void *arg)
 	int tag = dwarf_tag(die_mem);
 	ptrdiff_t off = 0;
 	Dwarf_Attribute attr;
-	Dwarf_Addr base, start, end;
+	Dwarf_Addr base, start, end, addr;
 	Dwarf_Op *ops;
 	size_t nops;
 
@@ -1684,11 +1705,11 @@ static int __die_find_var_addr_cb(Dwarf_Die *die_mem, void *arg)
 		return DIE_FIND_CB_SIBLING;
 
 	while ((off = dwarf_getlocations(&attr, off, &base, &start, &end, &ops, &nops)) > 0) {
-		if (ops->atom != DW_OP_addr)
+		if (!die_get_op_addr(&attr, ops, &addr))
 			continue;
 
 		if (check_allowed_ops(ops, nops) &&
-		    match_var_offset(die_mem, data, data->addr, ops->number,
+		    match_var_offset(die_mem, data, data->addr, addr,
 				     /*is_pointer=*/false))
 			return DIE_FIND_CB_END;
 	}
@@ -1814,7 +1835,7 @@ static int __die_collect_global_vars_cb(Dwarf_Die *die_mem, void *arg)
 	Dwarf_Die type_die;
 	int tag = dwarf_tag(die_mem);
 	Dwarf_Attribute attr;
-	Dwarf_Addr base, start, end;
+	Dwarf_Addr base, start, end, addr;
 	Dwarf_Op *ops;
 	size_t nops;
 	struct die_var_type *vt;
@@ -1829,7 +1850,7 @@ static int __die_collect_global_vars_cb(Dwarf_Die *die_mem, void *arg)
 	if (dwarf_getlocations(&attr, 0, &base, &start, &end, &ops, &nops) <= 0)
 		return DIE_FIND_CB_SIBLING;
 
-	if (ops->atom != DW_OP_addr)
+	if (!die_get_op_addr(&attr, ops, &addr))
 		return DIE_FIND_CB_SIBLING;
 
 	if (!check_allowed_ops(ops, nops))
@@ -1845,7 +1866,7 @@ static int __die_collect_global_vars_cb(Dwarf_Die *die_mem, void *arg)
 	vt->die_off = dwarf_dieoffset(&type_die);
 	vt->die_tag = dwarf_tag(&type_die);
 	vt->from_alt = !die_same_file(die_mem, &type_die);
-	vt->addr = ops->number;
+	vt->addr = addr;
 	vt->end = 0;
 	vt->has_range = false;
 	vt->reg = -1;

-- 
2.43.0

