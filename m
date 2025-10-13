Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C6D2D5C9E
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Oct 2025 18:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379386; cv=none; b=Xk835TKxrfIM/thYiD2qeX2BNG89HSUotOBxvhl91dAEgPnMpW7Jmw2iy7ftU/l76c/dW/iEZA+fKIkKhI+Shr9k+Xiqbdwm0CGrLuQUs3vSjsIeqQU/JrPovS0s+XfFo4LblnTMu4gwCmeeDyzUI5GUj5UyRt2YT/OSplqTcdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379386; c=relaxed/simple;
	bh=WCMovf1Hp3z/2wqmOlu9KCY6h/OjWugr9o717BGY0T8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R2uMqBI5cNo05VxP1L13Fu8xlAdvAGh/hsv5Tm8FJ7Avbem4tllOBGgxE89d0FRbZDYOJ1sKEQ8FtA5W5xoAaWSH8n46pD6CrLXkHvWYhnsOADYxjJKs77TPNL7uthSVQdROfKaa3O1+KVAaGo7OFKOpCSl89tGN+Q3VNYul+CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tlafQ1as; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tlafQ1as"
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8635d475527so3090947685a.0
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Oct 2025 11:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760379384; x=1760984184; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9/Q4qrmylQ0ZahaRzO6Ct5R5403rZDLx7xSWotYEXoA=;
        b=tlafQ1asDhcMrC6zMHnbGppdhxT/Gmo/LasMRUcofEiwXC9VC5YUOn+IDhfiunGKT6
         l3ADpX5hJ6P3hRau4oNH3iQNBugUFCU9KGhYF4b/wamZYvB19tBxnfaB/J/hSmld2MiA
         +VDZlRT1tc4Mzp8lMLYkOWR8RFxSnyi3PCBAcN6gQyUTTakssy4UY/phfXBS0TR8+3ty
         2L+8tqs7ZMZq8teO3Hv2JYzlcLOc/MgX/kFzxIscnbQHdCgFscNdbTRePhOBAvRtXdJL
         4RucPnyFxPWDC6oWRFTFTeA1gaL3yWJFrRDcyDxWjGxnYY0bmPj/0RibtfJN5UqIFQ68
         LGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760379384; x=1760984184;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9/Q4qrmylQ0ZahaRzO6Ct5R5403rZDLx7xSWotYEXoA=;
        b=kNLRhCSsoySDuHvMMovYi+8eS451XVPizaQXTyCiQJ0DLvtKmG9k28Jvj0hR1z9/1a
         y0srw+JPHHCgj0ddegZsGtrchzNVqSVjrEVuKQqYt/OvrrO++x1LHkFA8GzRFmKhnuAt
         WaejYBdioHp2e9Ac/+9CySToQDlnJgSLm9lofFzVHGYZ1TPwxOYzeNQojph/jtiFynyj
         mBwPSj3aS+qZoGcwLgsBG+tgRS2pBS1KzDR2/ckrY5hbWAnEuwOPOBqzSrGqA50//vxK
         WES33IJnKPc0i5EZAvLb6t8qawwUcWaPphTvkAJvBPLaAo6Yswbg8BPcydT1jOHs5Jte
         IK9g==
X-Forwarded-Encrypted: i=1; AJvYcCWjXaB9FzHyAZHR6f8nMPFc+xbdUWofWS1JsUo3P67gV6qojV9UGo3Ko30fo/HwIGMU2kgqbdpWjgak0MP/QAYw@vger.kernel.org
X-Gm-Message-State: AOJu0YyjSY5VzjcBex0TMwKFvNhpNcWQueq5baDtpqbwFjV13F26ZIMN
	LEYwnhqzYGhklpyAQn+YR4qXlJMFHkadKS9xTrdF+8tsNZOuSv47LfaaqusOOvCkkmr5N6B8hxN
	T8KG23CduSQ==
X-Google-Smtp-Source: AGHT+IGM2AoaSd3nDrndaQjFdiYhooI9Py/X2tre2/qsfMZIxxhQcfC3sDhJx0tB1eNWuUGf+Ey469hBnirw
X-Received: from qkox14.prod.google.com ([2002:a05:620a:258e:b0:845:8e5b:c8a4])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:458c:b0:868:54ba:7c42
 with SMTP id af79cd13be357-88352f83d61mr3042209185a.25.1760379383634; Mon, 13
 Oct 2025 11:16:23 -0700 (PDT)
Date: Mon, 13 Oct 2025 18:16:03 +0000
In-Reply-To: <20251013181607.2745653-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013181607.2745653-1-zecheng@google.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251013181607.2745653-7-zecheng@google.com>
Subject: [PATCH v4 6/9] perf dwarf-aux: Skip check_variable for die_find_variable_by_reg
From: Zecheng Li <zecheng@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zecheng Li <zecheng@google.com>
Content-Type: text/plain; charset="UTF-8"

In die_find_variable_by_reg, match_var_offset already performs
sufficient checking and type matching. The additional check_variable
call is redundant, and its need_pointer logic is only a heuristic. Since
DWARF encodes accurate type information, which match_var_offset
verifies, skipping check_variable improves both coverage and accuracy.

Return type from die_find_variable_by_reg via a new `type` field in
find_var_data.

Signed-off-by: Zecheng Li <zecheng@google.com>
---
 tools/perf/util/annotate-data.c |  8 +++++---
 tools/perf/util/dwarf-aux.c     | 18 +++++++++++-------
 tools/perf/util/dwarf-aux.h     |  2 +-
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index e183c6104d59..4b08331b9dd3 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -1603,19 +1603,21 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 			if (!die_find_variable_by_addr(&scopes[i], dloc->var_addr,
 						       &var_die, &type_offset))
 				continue;
+			/* Found a variable, see if it's correct */
+			result = check_variable(dloc, &var_die, &mem_die, reg,
+						type_offset, is_fbreg);
 		} else {
 			/* Look up variables/parameters in this scope */
 			if (!die_find_variable_by_reg(&scopes[i], pc, reg,
-						      &type_offset, is_fbreg, &var_die))
+						      &mem_die, &type_offset, is_fbreg, &var_die))
 				continue;
+			result = PERF_TMR_OK;
 		}
 
 		pr_debug_dtp("found \"%s\" (die: %#lx) in scope=%d/%d (die: %#lx) ",
 			     dwarf_diename(&var_die), (long)dwarf_dieoffset(&var_die),
 			     i+1, nr_scopes, (long)dwarf_dieoffset(&scopes[i]));
 
-		/* Found a variable, see if it's correct */
-		result = check_variable(dloc, &var_die, &mem_die, reg, type_offset, is_fbreg);
 		if (result == PERF_TMR_OK) {
 			if (reg == DWARF_REG_PC) {
 				pr_debug_dtp("addr=%#"PRIx64" type_offset=%#x\n",
diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 9267af204c7d..b57cdc8860f0 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1378,6 +1378,8 @@ struct find_var_data {
 	Dwarf_Addr addr;
 	/* Target register */
 	unsigned reg;
+	/* Access data type */
+	Dwarf_Die type;
 	/* Access offset, set for global data */
 	int offset;
 	/* True if the current register is the frame base */
@@ -1390,7 +1392,6 @@ struct find_var_data {
 static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
 			     s64 addr_offset, s64 addr_type, bool is_pointer)
 {
-	Dwarf_Die type_die;
 	Dwarf_Word size;
 	s64 offset = addr_offset - addr_type;
 
@@ -1403,16 +1404,16 @@ static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
 	if (offset < 0)
 		return false;
 
-	if (die_get_real_type(die_mem, &type_die) == NULL)
+	if (die_get_real_type(die_mem, &data->type) == NULL)
 		return false;
 
-	if (is_pointer && dwarf_tag(&type_die) == DW_TAG_pointer_type) {
+	if (is_pointer && dwarf_tag(&data->type) == DW_TAG_pointer_type) {
 		/* Get the target type of the pointer */
-		if (die_get_real_type(&type_die, &type_die) == NULL)
+		if (die_get_real_type(&data->type, &data->type) == NULL)
 			return false;
 	}
 
-	if (dwarf_aggregate_size(&type_die, &size) < 0)
+	if (dwarf_aggregate_size(&data->type, &size) < 0)
 		return false;
 
 	if ((u64)offset >= size)
@@ -1529,7 +1530,7 @@ static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
  * when the variable is in the stack.
  */
 Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die, Dwarf_Addr pc, int reg,
-				    int *poffset, bool is_fbreg,
+				    Dwarf_Die *type_die, int *poffset, bool is_fbreg,
 				    Dwarf_Die *die_mem)
 {
 	struct find_var_data data = {
@@ -1541,8 +1542,11 @@ Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die, Dwarf_Addr pc, int reg,
 	Dwarf_Die *result;
 
 	result = die_find_child(sc_die, __die_find_var_reg_cb, &data, die_mem);
-	if (result)
+	if (result) {
 		*poffset = data.offset;
+		*type_die = data.type;
+	}
+
 	return result;
 }
 
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index cd481ec9c5a1..b3ee5df0b6be 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -163,7 +163,7 @@ int die_get_var_range(Dwarf_Die *sp_die, Dwarf_Die *vr_die, struct strbuf *buf);
 
 /* Find a variable saved in the 'reg' at given address */
 Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die, Dwarf_Addr pc, int reg,
-				    int *poffset, bool is_fbreg,
+				    Dwarf_Die *type_die, int *poffset, bool is_fbreg,
 				    Dwarf_Die *die_mem);
 
 /* Find a (global) variable located in the 'addr' */
-- 
2.51.0.788.g6d19910ace-goog

