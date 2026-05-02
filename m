Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6464C3859D2
	for <linux-perf-users@vger.kernel.org>; Sat,  2 May 2026 15:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777737449; cv=none; b=FGHaS9YYVZkxfeIpdNnn3+4IkVSBahQ+zOHeAwCkSc5B8TjB8ezzK+heKB0sx/m4VjY9DTDgSRuVs2rScOCBdQSOpbnonTja2tYVVYYcjn3EwI3zqAuJ7IrKYG2w5cEfxwhtRFMIBtD3zMXJwUvTiFxziaMJx9A59G2WYNsnugk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777737449; c=relaxed/simple;
	bh=vKFHrCjlKGhKq21Pd2ks1LeyB99UP6QRapSzP1imIIo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qTb2iBIYZOGLsoaMLsg2GZ63JC8Nz22qgTKHsqaK5VA19g2ReQ8VefY1PG/yb88kMh/pVPhDpOXMEaRAa9r2JIIqY5xtewXDPc6xLA1GyMyIMSXjWYXLwdKOWpmbpcF7AuZqGa1vdV0XyzXI9QmMqOycMfhfAR22+GhDun58eGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UpdintwA; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UpdintwA"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so4547749eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 02 May 2026 08:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777737447; x=1778342247; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tbPVPyvaI7+J7NjdbYB4bFnyac0UwqZDPlHHgX6Sb0k=;
        b=UpdintwAAEwELjWYGa15h/CrBm/hT01wVe0O+LZIIyrwIlOa3pcN5BJVqIqEjpv5H8
         nge7VGLmWAVOtpc/g0FA1xp7LZ4/Pa3MJeggh3latZxVcb302TeWP21bB30SP4oylZDa
         UL6RDMbhIPTR+bjGQvsgDH3q4hwXQgHGD8cTT8RXFQ8XedN8yISLEssAjJ7pR3nI0LF5
         TMM6XS9ndTv/5QcctPk5v3uHAmv6CIea0mIkZMQ0+iqKdByfEgiyDY2GRPTeWLvXcJbS
         ZGQ5XD96vqTL2V4H6RaSlHsRHdkvCA0YytXHhg0kusP75lJSqE189kI+3hPi3n6gzY1z
         phBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777737447; x=1778342247;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tbPVPyvaI7+J7NjdbYB4bFnyac0UwqZDPlHHgX6Sb0k=;
        b=mafHEc6jBtDMCicboU+fvpiitgg06+YmoDiL4IDVwb6IqbQ73k3UBXQD/+LkNep4r7
         yP7/iztpKJn7y8cLzjC0ymt1RaaGE+ff4LA9aGRQoXGvjBZQlEUAWCDiaKDQ2LsQBZyt
         N3Fz8VG5afAkvsvhUd4AE+SIh/AG6eWnIzsxuk01s71n2DQl4ynqsT9jpQKyyZi8KumP
         FmS6QRu8QfvQByaMxTBQPBSSKWIn/+M0gQwy6jHbGM2gsH8scbNqcTJmA71e4WDqjahI
         yqAI/HKnLs+I1P9V5bNV9/AKPt8XVf+cvGwGHhmgJfrnc+C+4XHxB6dd9ePupI1SsYBA
         wd7A==
X-Forwarded-Encrypted: i=1; AFNElJ8AktmXJb4IcM8mhkOlhr30FZ2/JQ4t5OfWOn5rA/oy40rGaPLDRJLinPNSJUWFfHFDb6Dyy1ijzR++bMiuV32e@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp9obgmOBgf8+7Ltu89KcTt2XiqeUIhKyhlUIJ23iSezDTmkf7
	I5eCa4dBAevrdhlCT3XL9ZzCsgUn0bf/EiKCn5S+b+uNPv8IeYlzFhJtxRxjJMbmg1Z0TlwZOsz
	dDnZAeK4yuQ==
X-Received: from dlbeb4.prod.google.com ([2002:a05:7022:d44:b0:12d:bc1d:8783])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2391:b0:12d:de3e:be8d
 with SMTP id a92af1059eb24-12dfd856e08mr1606645c88.41.1777737447314; Sat, 02
 May 2026 08:57:27 -0700 (PDT)
Date: Sat,  2 May 2026 08:56:54 -0700
In-Reply-To: <20260502155656.478642-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502064839.282422-1-irogers@google.com> <20260502155656.478642-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502155656.478642-5-irogers@google.com>
Subject: [PATCH v2 4/6] perf probe-finder: Fix libdw API contract violations
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Zecheng Li <zli94@ncsu.edu>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Check return values of `dwarf_formsdata`, `dwarf_entrypc`,
`dwarf_highpc`, `dwarf_bytesize`, `dwarf_attr`, `dwarf_decl_line`,
`dwarf_getfuncs`, and `dwarf_formref_die`. Validate `dwarf_diename` and
`dwarf_diecu` results to prevent potential crashes. Fix C90 mixed
declarations.

Fixes: 66f69b219716 ("perf probe: Support DW_AT_const_value constant value")
Fixes: 3d918a12a1b3 ("perf probe: Find fentry mcount fuzzed parameter location")
Fixes: bcfc082150c6 ("perf probe: Remove redundant dwarf functions")
Fixes: 221d061182b8 ("perf probe: Fix to search local variables in appropriate scope")
Fixes: b55a87ade383 ("perf probe: Remove die() from probe-finder code")
Fixes: 4c859351226c ("perf probe: Support glob wildcards for function name")
Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/probe-finder.c | 84 ++++++++++++++++++++++------------
 1 file changed, 56 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 64328abeef8b..069f0d83d0b7 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -93,7 +93,8 @@ static int convert_variable_location(Dwarf_Die *vr_die, Dwarf_Addr addr,
 		if (!tvar)
 			return 0;
 
-		dwarf_formsdata(&attr, &snum);
+		if (dwarf_formsdata(&attr, &snum) != 0)
+			return -ENOENT;
 		ret = asprintf(&tvar->value, "\\%ld", (long)snum);
 
 		return ret < 0 ? -ENOMEM : 0;
@@ -103,8 +104,7 @@ static int convert_variable_location(Dwarf_Die *vr_die, Dwarf_Addr addr,
 	if (dwarf_attr(vr_die, DW_AT_location, &attr) == NULL)
 		return -EINVAL;	/* Broken DIE ? */
 	if (dwarf_getlocation_addr(&attr, addr, &op, &nops, 1) <= 0) {
-		ret = dwarf_entrypc(sp_die, &tmp);
-		if (ret)
+		if (dwarf_entrypc(sp_die, &tmp) != 0)
 			return -ENOENT;
 
 		if (probe_conf.show_location_range &&
@@ -115,8 +115,7 @@ static int convert_variable_location(Dwarf_Die *vr_die, Dwarf_Addr addr,
 			return -ENOENT;
 		}
 
-		ret = dwarf_highpc(sp_die, &tmp);
-		if (ret)
+		if (dwarf_highpc(sp_die, &tmp) != 0)
 			return -ENOENT;
 		/*
 		 * This is fuzzed by fentry mcount. We try to find the
@@ -138,15 +137,21 @@ static int convert_variable_location(Dwarf_Die *vr_die, Dwarf_Addr addr,
 static_var:
 		if (!tvar)
 			return ret2;
-		/* Static variables on memory (not stack), make @varname */
-		ret = strlen(dwarf_diename(vr_die));
-		tvar->value = zalloc(ret + 2);
-		if (tvar->value == NULL)
-			return -ENOMEM;
-		snprintf(tvar->value, ret + 2, "@%s", dwarf_diename(vr_die));
-		tvar->ref = alloc_trace_arg_ref((long)offs);
-		if (tvar->ref == NULL)
-			return -ENOMEM;
+		{
+			/* Static variables on memory (not stack), make @varname */
+			const char *name = dwarf_diename(vr_die);
+
+			if (!name)
+				return -ENOENT;
+			ret = strlen(name);
+			tvar->value = zalloc(ret + 2);
+			if (tvar->value == NULL)
+				return -ENOMEM;
+			snprintf(tvar->value, ret + 2, "@%s", name);
+			tvar->ref = alloc_trace_arg_ref((long)offs);
+			if (tvar->ref == NULL)
+				return -ENOMEM;
+		}
 		return ret2;
 	}
 
@@ -234,8 +239,9 @@ static int convert_variable_type(Dwarf_Die *vr_die,
 	}
 
 	if (die_get_real_type(vr_die, &type) == NULL) {
+		const char *name = dwarf_diename(vr_die);
 		pr_warning("Failed to get a type information of %s.\n",
-			   dwarf_diename(vr_die));
+			   name ? name : "<unknown>");
 		return -ENOENT;
 	}
 
@@ -291,7 +297,7 @@ static int convert_variable_type(Dwarf_Die *vr_die,
 			 probe_type_is_available(PROBE_TYPE_X) ? 'x' : 'u';
 
 	ret = dwarf_bytesize(&type);
-	if (ret <= 0)
+	if (ret < 0)
 		/* No size ... try to use default type */
 		return 0;
 	ret = BYTES_TO_BITS(ret);
@@ -357,7 +363,13 @@ static int convert_variable_fields(Dwarf_Die *vr_die, const char *varname,
 			else
 				*ref_ptr = ref;
 		}
-		ref->offset += dwarf_bytesize(&type) * field->index;
+		{
+			int bsize = dwarf_bytesize(&type);
+
+			if (bsize < 0)
+				return -EINVAL;
+			ref->offset += bsize * field->index;
+		}
 		ref->user_access = user_access;
 		goto next;
 	} else if (tag == DW_TAG_pointer_type) {
@@ -611,10 +623,16 @@ static int call_probe_finder(Dwarf_Die *sc_die, struct probe_finder *pf)
 		memcpy(&pf->sp_die, sc_die, sizeof(Dwarf_Die));
 
 	/* Get the frame base attribute/ops from subprogram */
-	dwarf_attr(&pf->sp_die, DW_AT_frame_base, &fb_attr);
-	ret = dwarf_getlocation_addr(&fb_attr, pf->addr, &pf->fb_ops, &nops, 1);
-	if (ret <= 0 || nops == 0) {
+	if (dwarf_attr(&pf->sp_die, DW_AT_frame_base, &fb_attr) == NULL) {
 		pf->fb_ops = NULL;
+	} else {
+		ret = dwarf_getlocation_addr(&fb_attr, pf->addr, &pf->fb_ops, &nops, 1);
+		if (ret <= 0 || nops == 0)
+			pf->fb_ops = NULL;
+	}
+
+	if (pf->fb_ops == NULL) {
+		/* Not supported */
 	} else if (nops == 1 && pf->fb_ops[0].atom == DW_OP_call_frame_cfa &&
 		   (pf->cfi_eh != NULL || pf->cfi_dbg != NULL)) {
 		if ((dwarf_cfi_addrframe(pf->cfi_eh, pf->addr, &frame) != 0 &&
@@ -667,8 +685,8 @@ static int find_best_scope_cb(Dwarf_Die *fn_die, void *data)
 		}
 	} else {
 		/* With the line number, find the nearest declared DIE */
-		dwarf_decl_line(fn_die, &lno);
-		if (lno < fsp->line && fsp->diff > fsp->line - lno) {
+		if (dwarf_decl_line(fn_die, &lno) == 0 &&
+		    lno < fsp->line && fsp->diff > fsp->line - lno) {
 			/* Keep a candidate and continue */
 			fsp->diff = fsp->line - lno;
 			memcpy(fsp->die_mem, fn_die, sizeof(Dwarf_Die));
@@ -1018,7 +1036,8 @@ static int find_probe_point_by_func(struct probe_finder *pf)
 {
 	struct dwarf_callback_param _param = {.data = (void *)pf,
 					      .retval = 0};
-	dwarf_getfuncs(&pf->cu_die, probe_point_search_cb, &_param, 0);
+	if (dwarf_getfuncs(&pf->cu_die, probe_point_search_cb, &_param, 0) < 0)
+		return -ENOENT;
 	return _param.retval;
 }
 
@@ -1207,7 +1226,8 @@ static int copy_variables_cb(Dwarf_Die *die_mem, void *data)
 		 * points to correct die.
 		 */
 		if (dwarf_attr(die_mem, DW_AT_abstract_origin, &attr)) {
-			dwarf_formref_die(&attr, &var_die);
+			if (dwarf_formref_die(&attr, &var_die) == NULL)
+				goto out;
 			if (pf->abstrace_dieoffset != dwarf_dieoffset(&var_die))
 				goto out;
 		}
@@ -1270,6 +1290,8 @@ static int add_probe_trace_event(Dwarf_Die *sc_die, struct probe_finder *pf)
 	struct probe_trace_event *tev;
 	struct perf_probe_arg *args = NULL;
 	int ret, i;
+	const char *realname;
+	Dwarf_Die cu_die_mem;
 
 	/*
 	 * For some reason (e.g. different column assigned to same address)
@@ -1293,13 +1315,17 @@ static int add_probe_trace_event(Dwarf_Die *sc_die, struct probe_finder *pf)
 	if (ret < 0)
 		goto end;
 
-	tev->point.realname = strdup(dwarf_diename(sc_die));
+	realname = dwarf_diename(sc_die);
+	tev->point.realname = strdup(realname ?: "unknown");
 	if (!tev->point.realname) {
 		ret = -ENOMEM;
 		goto end;
 	}
 
-	tev->lang = dwarf_srclang(dwarf_diecu(sc_die, &pf->cu_die, NULL, NULL));
+	if (dwarf_diecu(sc_die, &cu_die_mem, NULL, NULL) != NULL)
+		tev->lang = dwarf_srclang(&cu_die_mem);
+	else
+		tev->lang = DW_LANG_C; // Fallback
 
 	pr_debug("Probe point found: %s+%lu\n", tev->point.symbol,
 		 tev->point.offset);
@@ -1794,7 +1820,8 @@ static int line_range_search_cb(Dwarf_Die *sp_die, void *data)
 
 	if (die_match_name(sp_die, lr->function) && die_is_func_def(sp_die)) {
 		lf->fname = die_get_decl_file(sp_die);
-		dwarf_decl_line(sp_die, &lr->offset);
+		if (dwarf_decl_line(sp_die, &lr->offset) != 0)
+			return DWARF_CB_OK; // Skip if no line info
 		pr_debug("fname: %s, lineno:%d\n", lf->fname, lr->offset);
 		lf->lno_s = lr->offset + lr->start;
 		if (lf->lno_s < 0)	/* Overflow */
@@ -1818,7 +1845,8 @@ static int line_range_search_cb(Dwarf_Die *sp_die, void *data)
 static int find_line_range_by_func(struct line_finder *lf)
 {
 	struct dwarf_callback_param param = {.data = (void *)lf, .retval = 0};
-	dwarf_getfuncs(&lf->cu_die, line_range_search_cb, &param, 0);
+	if (dwarf_getfuncs(&lf->cu_die, line_range_search_cb, &param, 0) < 0)
+		return -ENOENT;
 	return param.retval;
 }
 
-- 
2.54.0.545.g6539524ca2-goog

