Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3CB1EFFA1
	for <linux-perf-users@vger.kernel.org>; Sun,  3 May 2026 00:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777768566; cv=none; b=cL+ii/WqEJSLXrK+VVXJ2puniZE2HGr/YTmfh7hu6tZEcfEIMxZbvePrXmkXhZAEf4tbvP2rKzfAi/Wdb3eLJKI4NocUTyuCO9msxl1+7K5AE1C32zYy8UYbyC1r2kGZJILGM5KJsQyF7DjMnIGKg1FqQYEMNzzQVWbka6TmDow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777768566; c=relaxed/simple;
	bh=o3pB6PDIQhOyfFxGHonM+bQw+A9rxf92ICetrnjBAhE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nb7gVydXBubJdL29v4wQI+dCQHLysYCX6+tsrhdcRJngo4/wUlmPHSGd5S50Nf2qdMU5LWeoASv/YRlnCXfTWjL+smnX72aReeW+k9n5u7dnsxYmkTg8G54yTC6wjrI8hBgVS+2HBE73aslOKatFzCCwpcgRSdAl+kmO3LaLrUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B2pvAIn6; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B2pvAIn6"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bda35eab74so2625598eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 02 May 2026 17:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777768565; x=1778373365; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uwNWY0ThrQQAxOv5nkaOloT61+s2PBWnuWqOepPBaLw=;
        b=B2pvAIn6COmGq5SpvTbZ2fg+asjK1PTzf5fUDV+QSMScgqPrkgrUj2N4Wl8VrDOwRf
         WlxlkIOC+M5zrwTL1ceRPw2w51Z93nlM+/7qBcdznS1dO0i6EQr5aM45Cq5YkJSA27Zz
         uQV6yKGTRCmZiRyH3/Qed5iwqRda8kMyhk4xKuLpF/XPMc9XxBmDRUE1Zc7FQsi+9E7J
         u8hVqpb5k9k2IEYOTvY4XAAWSxh80XE3ATvItLv/pO+X67JQ4E1RS7nXVl15Yg38s4LC
         HZtKb255l20mvw0gAyXsbEcxhBemZ3TB3TNgHBFFwtlrxuRg0fu9SfjBkWI0Xg8GLPy8
         iDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777768565; x=1778373365;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uwNWY0ThrQQAxOv5nkaOloT61+s2PBWnuWqOepPBaLw=;
        b=eOC++keuJCj+/9tH8AXEybDTeKO85H+E1UMzfugYfmp94lNJkxr7rYci400Hk69q6M
         zpa8Il2d/6mxXQ0AhaNurNm5opMQLJEfrctSjuTIQ5HSi1PTxpZTUON1Sn9Y3xYXeWOf
         xct06I5b8zjkXBOzfeayAc+g4+imuZSjjeTiHqZvbs3Y104+PHkcw4wB0UBoKTaZgWs8
         CIPDdFu/mRohNM666+L8g0czKlLxxRUdLbmroBpiQVEM33JKso3aotJJgGJhTweITDkE
         dLSSoOc5bRC1KiJvlZy6p2fGtWp+kI6ipGsqTYVEDPuGpvOAcO8nrs6auOBjTdS9xzWa
         Incw==
X-Forwarded-Encrypted: i=1; AFNElJ9RHuB0rnphaItDFHZKggm4+YRhITL8EML9MOn5XWlgUoPfibskV5Uuqq/sJTdmbRSVhNGCtkHrCWWb+DIEcG5/@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7aCB7waQR06+AEVY5TECSkyQ9MLkfmD6u6x/oEgfY/W4RE2py
	EVTOX3DY6rg8va0yZAQKl3vNU1C/wRkKmZORUolYm55/1B8GnrG226vbqUKuGeEAQwj7fHV9tsr
	To/KAO7KTGw==
X-Received: from dlbsv4.prod.google.com ([2002:a05:7022:3a04:b0:12d:b86f:f7a6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f102:b0:12c:6ec9:3f1
 with SMTP id a92af1059eb24-12dece2f0c0mr4290294c88.21.1777768564362; Sat, 02
 May 2026 17:36:04 -0700 (PDT)
Date: Sat,  2 May 2026 17:35:50 -0700
In-Reply-To: <20260503003552.1063540-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503003552.1063540-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503003552.1063540-5-irogers@google.com>
Subject: [PATCH v3 4/6] perf probe-finder: Fix libdw API contract violations
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
 tools/perf/util/probe-finder.c | 85 ++++++++++++++++++++++------------
 1 file changed, 56 insertions(+), 29 deletions(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 64328abeef8b..bdef340dfd55 100644
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
 
@@ -234,8 +239,8 @@ static int convert_variable_type(Dwarf_Die *vr_die,
 	}
 
 	if (die_get_real_type(vr_die, &type) == NULL) {
-		pr_warning("Failed to get a type information of %s.\n",
-			   dwarf_diename(vr_die));
+		const char *name = dwarf_diename(vr_die);
+		pr_warning("Failed to get a type information of %s.\n", name ? name : "<unknown>");
 		return -ENOENT;
 	}
 
@@ -291,7 +296,7 @@ static int convert_variable_type(Dwarf_Die *vr_die,
 			 probe_type_is_available(PROBE_TYPE_X) ? 'x' : 'u';
 
 	ret = dwarf_bytesize(&type);
-	if (ret <= 0)
+	if (ret < 0)
 		/* No size ... try to use default type */
 		return 0;
 	ret = BYTES_TO_BITS(ret);
@@ -357,7 +362,13 @@ static int convert_variable_fields(Dwarf_Die *vr_die, const char *varname,
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
@@ -611,10 +622,16 @@ static int call_probe_finder(Dwarf_Die *sc_die, struct probe_finder *pf)
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
@@ -667,8 +684,8 @@ static int find_best_scope_cb(Dwarf_Die *fn_die, void *data)
 		}
 	} else {
 		/* With the line number, find the nearest declared DIE */
-		dwarf_decl_line(fn_die, &lno);
-		if (lno < fsp->line && fsp->diff > fsp->line - lno) {
+		if (dwarf_decl_line(fn_die, &lno) == 0 && lno < fsp->line &&
+		    fsp->diff > fsp->line - lno) {
 			/* Keep a candidate and continue */
 			fsp->diff = fsp->line - lno;
 			memcpy(fsp->die_mem, fn_die, sizeof(Dwarf_Die));
@@ -1018,7 +1035,8 @@ static int find_probe_point_by_func(struct probe_finder *pf)
 {
 	struct dwarf_callback_param _param = {.data = (void *)pf,
 					      .retval = 0};
-	dwarf_getfuncs(&pf->cu_die, probe_point_search_cb, &_param, 0);
+	if (dwarf_getfuncs(&pf->cu_die, probe_point_search_cb, &_param, 0) < 0)
+		return -ENOENT;
 	return _param.retval;
 }
 
@@ -1207,7 +1225,8 @@ static int copy_variables_cb(Dwarf_Die *die_mem, void *data)
 		 * points to correct die.
 		 */
 		if (dwarf_attr(die_mem, DW_AT_abstract_origin, &attr)) {
-			dwarf_formref_die(&attr, &var_die);
+			if (dwarf_formref_die(&attr, &var_die) == NULL)
+				goto out;
 			if (pf->abstrace_dieoffset != dwarf_dieoffset(&var_die))
 				goto out;
 		}
@@ -1270,6 +1289,8 @@ static int add_probe_trace_event(Dwarf_Die *sc_die, struct probe_finder *pf)
 	struct probe_trace_event *tev;
 	struct perf_probe_arg *args = NULL;
 	int ret, i;
+	const char *realname;
+	Dwarf_Die cu_die_mem;
 
 	/*
 	 * For some reason (e.g. different column assigned to same address)
@@ -1293,13 +1314,17 @@ static int add_probe_trace_event(Dwarf_Die *sc_die, struct probe_finder *pf)
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
@@ -1794,7 +1819,8 @@ static int line_range_search_cb(Dwarf_Die *sp_die, void *data)
 
 	if (die_match_name(sp_die, lr->function) && die_is_func_def(sp_die)) {
 		lf->fname = die_get_decl_file(sp_die);
-		dwarf_decl_line(sp_die, &lr->offset);
+		if (dwarf_decl_line(sp_die, &lr->offset) != 0)
+			return DWARF_CB_OK; // Skip if no line info
 		pr_debug("fname: %s, lineno:%d\n", lf->fname, lr->offset);
 		lf->lno_s = lr->offset + lr->start;
 		if (lf->lno_s < 0)	/* Overflow */
@@ -1818,7 +1844,8 @@ static int line_range_search_cb(Dwarf_Die *sp_die, void *data)
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

