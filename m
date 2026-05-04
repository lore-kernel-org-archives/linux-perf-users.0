Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DE43195FA
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 08:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777882369; cv=none; b=GbaD6mGoG0pkoSpws3gfq3jsIRL8YBjobfdYV9qL96EqgM/DP2KC5fS0wv8miT0Hb4rYHpPZrM0tzUHrjqCRSqSsMhuXRIBCvkHDiJedVh4d2hcRiQGNMAwvYBqgDLgitP+q7xfJcIYtDkkDg8P5fQKcM/7rKfWU0NdlPiDUAmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777882369; c=relaxed/simple;
	bh=oielX4PbYhjCmH6smFUC5nve0e/HpaISRO/bEQwq2pU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eNnR0QFVo8n41MmZ4w962FCEvp/VWC6TGQyMkZLkghATcvUwTBBVdEFUTfcLjs5T3ZjfTVg66OXZKpQx6RN8TQwUleFqanhVgWTvaO9m0PnZOBWeLwAkL6qyGj5qesVKuZuhdGRMTkjgFDBXB1SpHQmeApa/GW7qrtiRwL/HLDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RXOF3A5Q; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RXOF3A5Q"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c726f4055so6371192c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 04 May 2026 01:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777882366; x=1778487166; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vCNRFFQ8ERXtj2oynby6LJQXEzZwoPz5UzHeXMMtzhg=;
        b=RXOF3A5QE85tXbooFHKALrqsF8u+QrbuPQICAgQztd8Lei8Z5Ln0h2ni5I9lyPsDuP
         GMvuiaRAr/757AfOUcO8hojbBZpIS6MmatSSALYc019seHqazVGv4Z5at6nGz4aYqaKU
         bvuBm7BGYskS5OvcedjZuCKDm4j4d7NcbewHniUYD/d/God4soTHWnce7PXklqCV5odp
         uD5fzws/1noOi+1/ZGqOy7OyKYg9l7p5EpjCMsGK5gczyekS57ulCkwAJXplo1igsliD
         EsBUzhVvWXsY1CzFTyXD7AvrpVPVxv1X5TE+bzCt7LucB7Pfcxe/R7VmtS/HCRBl/iqw
         hXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777882366; x=1778487166;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vCNRFFQ8ERXtj2oynby6LJQXEzZwoPz5UzHeXMMtzhg=;
        b=BpJ9Z9DSCDHsY27A3vSEIo1unoPkF6W6SLQ9m48KheCPCCMYLforRiFX/KxB3vOCaC
         Z/nCh57tptrtklzOWh6B+/LaeIec0X7tHG7W+Tex6NW/6TaXaIXQB5xkeXu3IL8Np9F7
         MdO1Fb/vnbT8Bs10kboWwl5oGZ9cilrSCjk8DsXrgNweJ2pwRIjg1qBwdjriZXyrcq2G
         Tyhx1lnLQdf9x5r32kuJg/3SV+HXIqulQau0T0WSbHi2I/EcmCwph4t7v16Hjcw+Ny5q
         sFx8KpGmDoURyapnhCaGgN0/KAsjGejxcnZp3lkPptZwDUvyAtndfUGCNzUwS73cRzaz
         lZ5w==
X-Forwarded-Encrypted: i=1; AFNElJ9i0Hpq+0WiKU5u/vGH8aCe+TSEqZ5LdLYOznBxa0xuUAN2816tZS0Khj6DftT9HxllpD1Vqxf4d079pNn66/q/@vger.kernel.org
X-Gm-Message-State: AOJu0YyW9cXzJbdT4PiJegj4hkecFJKdg/KW03xylJIqh3EIWjJRrkP7
	W4YhRdvAsZbHrqX3VAUZFuS37TZ1pKiCvXKIcra4dAcyPlGIIw8cxl44ZxTclnSuIF6K4AYKEwt
	1ClbmLIpN8A==
X-Received: from dlbuu10.prod.google.com ([2002:a05:7022:7e8a:b0:12c:87ba:191d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6187:b0:12d:f0b1:75de
 with SMTP id a92af1059eb24-12dfd843065mr3830682c88.22.1777882366190; Mon, 04
 May 2026 01:12:46 -0700 (PDT)
Date: Mon,  4 May 2026 01:12:25 -0700
In-Reply-To: <20260504081227.2203848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503171032.1559338-1-irogers@google.com> <20260504081227.2203848-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504081227.2203848-8-irogers@google.com>
Subject: [PATCH v5 7/9] perf probe-finder: Fix libdw API contract violations
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

Additionally:
 - Avoid vfprintf undefined behavior with NULL strings by using the
   `die_name()` helper for `dwarf_diename()` in `pr_*` calls,
   including when warning about tail calls.
 - Prevent NULL pointer dereference in `convert_variable_fields()`
   when processing array elements for variables in registers.
 - Fallback to offset 0 in `line_range_search_cb()` instead of
   skipping functions without `DW_AT_decl_line`.
 - Relax `dwarf_getfuncs` error checking in
   `find_probe_point_by_func()` and `find_line_range_by_func()` to
   prevent premature CU search aborts, ensuring robustness against
   corrupted CUs.

Fixes: 66f69b219716 ("perf probe: Support DW_AT_const_value constant value")
Fixes: 3d918a12a1b3 ("perf probe: Find fentry mcount fuzzed parameter location")
Fixes: bcfc082150c6 ("perf probe: Remove redundant dwarf functions")
Fixes: 221d061182b8 ("perf probe: Fix to search local variables in appropriate scope")
Fixes: b55a87ade383 ("perf probe: Remove die() from probe-finder code")
Fixes: 4c859351226c ("perf probe: Support glob wildcards for function name")
Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
v5:
 - Safe DWARF name printing using die_name().
 - Corrected CU DIE propagation.
 - Standardized comment style to /* ... */.
v4:
 - Safe DWARF name printing with die_name() to avoid NULL formatting crashes.
 - Fix NULL dereference in register variable array lookups.
 - Fix robust CU search loops by continuing on getfuncs errors.
---
 tools/perf/util/probe-finder.c | 102 +++++++++++++++++++++------------
 1 file changed, 65 insertions(+), 37 deletions(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 64328abeef8b..f3f9a1573502 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -79,7 +79,7 @@ static int convert_variable_location(Dwarf_Die *vr_die, Dwarf_Addr addr,
 	unsigned int regn;
 	Dwarf_Word offs = 0;
 	bool ref = false;
-	const char *regs;
+	const char *regs, *name;
 	int ret, ret2 = 0;
 
 	if (dwarf_attr(vr_die, DW_AT_external, &attr) != NULL)
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
@@ -138,12 +137,16 @@ static int convert_variable_location(Dwarf_Die *vr_die, Dwarf_Addr addr,
 static_var:
 		if (!tvar)
 			return ret2;
+
 		/* Static variables on memory (not stack), make @varname */
-		ret = strlen(dwarf_diename(vr_die));
+		name = dwarf_diename(vr_die);
+		if (!name)
+			return -ENOENT;
+		ret = strlen(name);
 		tvar->value = zalloc(ret + 2);
 		if (tvar->value == NULL)
 			return -ENOMEM;
-		snprintf(tvar->value, ret + 2, "@%s", dwarf_diename(vr_die));
+		snprintf(tvar->value, ret + 2, "@%s", name);
 		tvar->ref = alloc_trace_arg_ref((long)offs);
 		if (tvar->ref == NULL)
 			return -ENOMEM;
@@ -234,13 +237,14 @@ static int convert_variable_type(Dwarf_Die *vr_die,
 	}
 
 	if (die_get_real_type(vr_die, &type) == NULL) {
-		pr_warning("Failed to get a type information of %s.\n",
-			   dwarf_diename(vr_die));
+		const char *name = dwarf_diename(vr_die);
+
+		pr_warning("Failed to get a type information of %s.\n", name ?: "<unknown>");
 		return -ENOENT;
 	}
 
 	pr_debug("%s type is %s.\n",
-		 dwarf_diename(vr_die), dwarf_diename(&type));
+		 die_name(vr_die), die_name(&type));
 
 	if (cast && (!strcmp(cast, "string") || !strcmp(cast, "ustring"))) {
 		/* String type */
@@ -249,7 +253,7 @@ static int convert_variable_type(Dwarf_Die *vr_die,
 		    ret != DW_TAG_array_type) {
 			pr_warning("Failed to cast into string: "
 				   "%s(%s) is not a pointer nor array.\n",
-				   dwarf_diename(vr_die), dwarf_diename(&type));
+				   die_name(vr_die), die_name(&type));
 			return -EINVAL;
 		}
 		if (die_get_real_type(&type, &type) == NULL) {
@@ -272,7 +276,7 @@ static int convert_variable_type(Dwarf_Die *vr_die,
 		    !die_compare_name(&type, "unsigned char")) {
 			pr_warning("Failed to cast into string: "
 				   "%s is not (unsigned) char *.\n",
-				   dwarf_diename(vr_die));
+				   die_name(vr_die));
 			return -EINVAL;
 		}
 		tvar->type = strdup(cast);
@@ -299,7 +303,7 @@ static int convert_variable_type(Dwarf_Die *vr_die,
 	/* Check the bitwidth */
 	if (ret > MAX_BASIC_TYPE_BITS) {
 		pr_info("%s exceeds max-bitwidth. Cut down to %d bits.\n",
-			dwarf_diename(&type), MAX_BASIC_TYPE_BITS);
+			die_name(&type), MAX_BASIC_TYPE_BITS);
 		ret = MAX_BASIC_TYPE_BITS;
 	}
 	ret = snprintf(buf, 16, "%c%d", prefix, ret);
@@ -333,12 +337,14 @@ static int convert_variable_fields(Dwarf_Die *vr_die, const char *varname,
 		pr_warning("Failed to get the type of %s.\n", varname);
 		return -ENOENT;
 	}
-	pr_debug2("Var real type: %s (%x)\n", dwarf_diename(&type),
+	pr_debug2("Var real type: %s (%x)\n", die_name(&type),
 		  (unsigned)dwarf_dieoffset(&type));
 	tag = dwarf_tag(&type);
 
 	if (field->name[0] == '[' &&
 	    (tag == DW_TAG_array_type || tag == DW_TAG_pointer_type)) {
+		int bsize;
+
 		/* Save original type for next field or type */
 		memcpy(die_mem, &type, sizeof(*die_mem));
 		/* Get the type of this array */
@@ -346,7 +352,7 @@ static int convert_variable_fields(Dwarf_Die *vr_die, const char *varname,
 			pr_warning("Failed to get the type of %s.\n", varname);
 			return -ENOENT;
 		}
-		pr_debug2("Array real type: %s (%x)\n", dwarf_diename(&type),
+		pr_debug2("Array real type: %s (%x)\n", die_name(&type),
 			 (unsigned)dwarf_dieoffset(&type));
 		if (tag == DW_TAG_pointer_type) {
 			ref = zalloc(sizeof(struct probe_trace_arg_ref));
@@ -357,7 +363,15 @@ static int convert_variable_fields(Dwarf_Die *vr_die, const char *varname,
 			else
 				*ref_ptr = ref;
 		}
-		ref->offset += dwarf_bytesize(&type) * field->index;
+		bsize = dwarf_bytesize(&type);
+
+		if (bsize < 0)
+			return -EINVAL;
+		if (!ref) {
+			pr_warning("Array indexing not supported for variables in registers.\n");
+			return -ENOTSUP;
+		}
+		ref->offset += bsize * field->index;
 		ref->user_access = user_access;
 		goto next;
 	} else if (tag == DW_TAG_pointer_type) {
@@ -414,7 +428,7 @@ static int convert_variable_fields(Dwarf_Die *vr_die, const char *varname,
 
 	if (die_find_member(&type, field->name, die_mem) == NULL) {
 		pr_warning("%s(type:%s) has no member %s.\n", varname,
-			   dwarf_diename(&type), field->name);
+			   die_name(&type), field->name);
 		return -EINVAL;
 	}
 
@@ -461,7 +475,7 @@ static int convert_variable(Dwarf_Die *vr_die, struct probe_finder *pf)
 	int ret;
 
 	pr_debug("Converting variable %s into trace event.\n",
-		 dwarf_diename(vr_die));
+		 die_name(vr_die));
 
 	ret = convert_variable_location(vr_die, pf->addr, pf->fb_ops,
 					&pf->sp_die, pf, pf->tvar);
@@ -542,7 +556,7 @@ static int convert_to_trace_point(Dwarf_Die *sp_die, Dwfl_Module *mod,
 	/* Verify the address is correct */
 	if (!dwarf_haspc(sp_die, paddr)) {
 		pr_warning("Specified offset is out of %s\n",
-			   dwarf_diename(sp_die));
+			   die_name(sp_die));
 		return -EINVAL;
 	}
 
@@ -599,7 +613,7 @@ static int call_probe_finder(Dwarf_Die *sc_die, struct probe_finder *pf)
 		if (!die_find_realfunc(&pf->cu_die, pf->addr, &pf->sp_die)) {
 			if (die_find_tailfunc(&pf->cu_die, pf->addr, &pf->sp_die)) {
 				pr_warning("Ignoring tail call from %s\n",
-						dwarf_diename(&pf->sp_die));
+						die_name(&pf->sp_die));
 				return 0;
 			} else {
 				pr_warning("Failed to find probe point in any "
@@ -611,10 +625,16 @@ static int call_probe_finder(Dwarf_Die *sc_die, struct probe_finder *pf)
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
@@ -667,8 +687,8 @@ static int find_best_scope_cb(Dwarf_Die *fn_die, void *data)
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
@@ -924,12 +944,12 @@ static int probe_point_inline_cb(Dwarf_Die *in_die, void *data)
 		/* Get probe address */
 		if (die_entrypc(in_die, &addr) != 0) {
 			pr_warning("Failed to get entry address of %s.\n",
-				   dwarf_diename(in_die));
+				   die_name(in_die));
 			return -ENOENT;
 		}
 		if (addr == 0) {
 			pr_debug("%s has no valid entry address. skipped.\n",
-				 dwarf_diename(in_die));
+				 die_name(in_die));
 			return -ENOENT;
 		}
 		pf->addr = addr;
@@ -971,12 +991,13 @@ static int probe_point_search_cb(Dwarf_Die *sp_die, void *data)
 	if (pp->file && fname && strtailcmp(pp->file, fname))
 		return DWARF_CB_OK;
 
-	pr_debug("Matched function: %s [%lx]\n", dwarf_diename(sp_die),
+	pr_debug("Matched function: %s [%lx]\n", die_name(sp_die),
 		 (unsigned long)dwarf_dieoffset(sp_die));
 	pf->fname = fname;
 	pf->abstrace_dieoffset = dwarf_dieoffset(sp_die);
 	if (pp->line) { /* Function relative line */
-		dwarf_decl_line(sp_die, &pf->lno);
+		if (dwarf_decl_line(sp_die, &pf->lno) != 0)
+			return DWARF_CB_OK;
 		pf->lno += pp->line;
 		param->retval = find_probe_point_by_line(pf);
 	} else if (die_is_func_instance(sp_die)) {
@@ -985,7 +1006,7 @@ static int probe_point_search_cb(Dwarf_Die *sp_die, void *data)
 		/* But in some case the entry address is 0 */
 		if (pf->addr == 0) {
 			pr_debug("%s has no entry PC. Skipped\n",
-				 dwarf_diename(sp_die));
+				 die_name(sp_die));
 			param->retval = 0;
 		/* Real function */
 		} else if (pp->lazy_line)
@@ -1018,7 +1039,8 @@ static int find_probe_point_by_func(struct probe_finder *pf)
 {
 	struct dwarf_callback_param _param = {.data = (void *)pf,
 					      .retval = 0};
-	dwarf_getfuncs(&pf->cu_die, probe_point_search_cb, &_param, 0);
+	if (dwarf_getfuncs(&pf->cu_die, probe_point_search_cb, &_param, 0) < 0)
+		pr_debug("Failed to get functions from CU\n");
 	return _param.retval;
 }
 
@@ -1207,7 +1229,8 @@ static int copy_variables_cb(Dwarf_Die *die_mem, void *data)
 		 * points to correct die.
 		 */
 		if (dwarf_attr(die_mem, DW_AT_abstract_origin, &attr)) {
-			dwarf_formref_die(&attr, &var_die);
+			if (dwarf_formref_die(&attr, &var_die) == NULL)
+				goto out;
 			if (pf->abstrace_dieoffset != dwarf_dieoffset(&var_die))
 				goto out;
 		}
@@ -1293,13 +1316,16 @@ static int add_probe_trace_event(Dwarf_Die *sc_die, struct probe_finder *pf)
 	if (ret < 0)
 		goto end;
 
-	tev->point.realname = strdup(dwarf_diename(sc_die));
+	tev->point.realname = strdup(die_name(sc_die));
 	if (!tev->point.realname) {
 		ret = -ENOMEM;
 		goto end;
 	}
 
-	tev->lang = dwarf_srclang(dwarf_diecu(sc_die, &pf->cu_die, NULL, NULL));
+	if (dwarf_diecu(sc_die, &pf->cu_die, NULL, NULL) != NULL)
+		tev->lang = dwarf_srclang(&pf->cu_die);
+	else
+		tev->lang = DW_LANG_C; /* Fallback */
 
 	pr_debug("Probe point found: %s+%lu\n", tev->point.symbol,
 		 tev->point.offset);
@@ -1794,7 +1820,8 @@ static int line_range_search_cb(Dwarf_Die *sp_die, void *data)
 
 	if (die_match_name(sp_die, lr->function) && die_is_func_def(sp_die)) {
 		lf->fname = die_get_decl_file(sp_die);
-		dwarf_decl_line(sp_die, &lr->offset);
+		if (dwarf_decl_line(sp_die, &lr->offset) != 0)
+			lr->offset = 0; /* Fallback if no line info */
 		pr_debug("fname: %s, lineno:%d\n", lf->fname, lr->offset);
 		lf->lno_s = lr->offset + lr->start;
 		if (lf->lno_s < 0)	/* Overflow */
@@ -1818,7 +1845,8 @@ static int line_range_search_cb(Dwarf_Die *sp_die, void *data)
 static int find_line_range_by_func(struct line_finder *lf)
 {
 	struct dwarf_callback_param param = {.data = (void *)lf, .retval = 0};
-	dwarf_getfuncs(&lf->cu_die, line_range_search_cb, &param, 0);
+	if (dwarf_getfuncs(&lf->cu_die, line_range_search_cb, &param, 0) < 0)
+		pr_debug("Failed to get functions from CU\n");
 	return param.retval;
 }
 
-- 
2.54.0.545.g6539524ca2-goog

