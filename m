Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA8C3CCFC0
	for <linux-perf-users@vger.kernel.org>; Sun,  3 May 2026 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777828255; cv=none; b=s0kSo4SvU1hulkNI0LSk3o1hOr2ezXESqi9AJJr2ZKLApD0kZXdGz7X19SI1dZn2mQW62bttTwFKjphFAK3SRN/1r3Kf6J+/1VkXLIeoRAsl0CLi2sVJvciV37uHyb8T9wfxHw4K4OEcYf40Oq7QdfzGO2FKHzHugVv4ScZwF88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777828255; c=relaxed/simple;
	bh=5ANgtqZcdHupGEjzhsCuRbNnzfgu2X6dZdqc5Q0ebrI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lpZqakICLNFaZpZHH1LvsBtvTCWBMIgNpMiWXb//63nfJ/BEglEM4WoIc7CwSyi3YcvcBM2C/5xLjNhBcCxUzJcumedU4B3b1ShFKnmsBf/g54GuiZCu438MFyOr5lH+Lw5pXqb+/OepYmfaLdBwmsa8ewA6qsV6K17pY3a7A0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FZvcuPAQ; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FZvcuPAQ"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ee1da7a13fso3039909eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 03 May 2026 10:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777828253; x=1778433053; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5/EJWbfv09KofvOl4dto1edm7VYIyTldbr310LMAAT0=;
        b=FZvcuPAQzD7yCxR2DLHiOFnYny5ezWsy48ZAsyS5kaL4UD9Tno4JzJ7ajen+s/7y0n
         vEmvuDaWx3bZEwvnbK9B7DrBwoghka9XO1LKaTEwHbxLYKHWYH3k6SDk+AgUaWp3oTMP
         nWGrIkKsnI5VrXMSNJo+roVidBA/H4AR7NE4/U/2fsQFMG4daolPiO54cf2t9MfGMV0W
         WQNS8bG9AlfXk13DHQYahOIx4+LBgHwX1i94eZcF7VQEb98SVm/BrEqxvHZMy//AOHvb
         mYdF+EgIad1Idbe29FQaERjucUMd8CmiWuGS41LS/oCAYvdsrafsuioQLLYRrOe0yRgx
         jRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777828253; x=1778433053;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5/EJWbfv09KofvOl4dto1edm7VYIyTldbr310LMAAT0=;
        b=H9J1Ff8M8Yu666juFddtmApeOllTEqhan0bRMPitctaRBozZOvo4MgovJ6ZU+KhkmN
         SU1mtP5dgMrH9kys/KmWVICaJr2e8YUcjCCTJDBSNiUxupRZHdXNzUDvSSXUSzYkKYyi
         ZB+TEQqB8yL21san1elOaIPph7S/z7vrxLLTkunJBkauPIGzugwVMWacJOy/o2gu9UIa
         5ah56tpdQI1ZEowD/QXUbit/IRQtoR7wE0MXcy2CzNh4QKen6WjtXRDW2DBeU6tPucrN
         hcH5jkNcALTJUED3vjx2zrkTObUx3TwhaH6n1CgOclKTljjzIuWRLK0s52IdOWF5CLT/
         xq0w==
X-Forwarded-Encrypted: i=1; AFNElJ9uqrP9K97jEmh7O1+fbvYGfieW0uBwBEV/9SF2ArcYo5aOd2eSjZ/wWp83BsLqa4usYTpwMZLJarYBAifgEBz/@vger.kernel.org
X-Gm-Message-State: AOJu0YwMkJz5T8o2OquhFxCsVjrLg09ZPPr99l0zSDrz7iFqq+A1LV7a
	VECLlDNR1LVR6N4UObtR8VpzPptLRSyvbbDDetJWXxto0roJBIbmpOsmcA49t3vQ6I8WPXP1q93
	DhWoxzbyWwQ==
X-Received: from dlec12-n2.prod.google.com ([2002:a05:701b:428c:20b0:12b:fba9:5eb0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6628:b0:122:33e:6d41
 with SMTP id a92af1059eb24-12dfd84327fmr3007412c88.23.1777828252768; Sun, 03
 May 2026 10:10:52 -0700 (PDT)
Date: Sun,  3 May 2026 10:10:31 -0700
In-Reply-To: <20260503171032.1559338-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503003552.1063540-1-irogers@google.com> <20260503171032.1559338-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503171032.1559338-6-irogers@google.com>
Subject: [PATCH v4 5/6] perf annotate-data: Fix libdw API contract violations
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Zecheng Li <zli94@ncsu.edu>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Check return values of `dwarf_aggregate_size` and `dwarf_formudata`.

Additionally:
 - Avoid `vfprintf` undefined behavior with `NULL` strings by using
   the `die_name()` helper for `dwarf_diename()` in `pr_*` calls.
 - Use `die_get_data_member_location()` (updated to use
   `dwarf_attr_integrate`) to correctly parse location expressions
   for inherited member locations in the fallback path when
   `dwarf_formudata()` fails.

Fixes: 2bc3cf575a16 ("perf annotate-data: Improve debug message with location info")
Fixes: 4a111cadac85 ("perf annotate-data: Add member field in the data type")
Fixes: 8b1042c425f6 ("perf annotate-data: Set bitfield member offset and size properly")
Fixes: fc044c53b99f ("perf annotate-data: Add dso->data_types tree")
Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
v4:
 - Safe DWARF name printing in annotate-data.
 - Fix fallback location expression parsing for inherited data members.
---
 tools/perf/util/annotate-data.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 1eff0a27237d..2eacbba51f32 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -74,7 +74,8 @@ void pr_debug_type_name(Dwarf_Die *die, enum type_state_kind kind)
 		break;
 	}
 
-	dwarf_aggregate_size(die, &size);
+	if (dwarf_aggregate_size(die, &size) != 0)
+		size = 0;
 
 	strbuf_init(&sb, 32);
 	die_get_typename_from_type(die, &sb);
@@ -146,9 +147,9 @@ static void pr_debug_scope(Dwarf_Die *scope_die)
 
 	tag = dwarf_tag(scope_die);
 	if (tag == DW_TAG_subprogram)
-		pr_info("[function] %s\n", dwarf_diename(scope_die));
+		pr_info("[function] %s\n", die_name(scope_die));
 	else if (tag == DW_TAG_inlined_subroutine)
-		pr_info("[inlined] %s\n", dwarf_diename(scope_die));
+		pr_info("[inlined] %s\n", die_name(scope_die));
 	else if (tag == DW_TAG_lexical_block)
 		pr_info("[block]\n");
 	else
@@ -250,9 +251,12 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
 	if (dwarf_aggregate_size(&die_mem, &size) < 0)
 		size = 0;
 
-	if (dwarf_attr_integrate(die, DW_AT_data_member_location, &attr))
-		dwarf_formudata(&attr, &loc);
-	else {
+	if (dwarf_attr_integrate(die, DW_AT_data_member_location, &attr)) {
+		if (dwarf_formudata(&attr, &loc) != 0) {
+			if (die_get_data_member_location(die, &loc) != 0)
+				loc = 0;
+		}
+	} else {
 		/* bitfield member */
 		if (dwarf_attr_integrate(die, DW_AT_data_bit_offset, &attr) &&
 		    dwarf_formudata(&attr, &loc) == 0)
@@ -273,7 +277,9 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
 				     dwarf_diename(die), (long)bit_size) < 0)
 				member->var_name = NULL;
 		} else {
-			member->var_name = strdup(dwarf_diename(die));
+			const char *name = dwarf_diename(die);
+
+			member->var_name = strdup(name);
 		}
 
 		if (member->var_name == NULL) {
@@ -370,7 +376,8 @@ static struct annotated_data_type *dso__findnew_data_type(struct dso *dso,
 	if (dwarf_tag(type_die) == DW_TAG_typedef)
 		die_get_real_type(type_die, type_die);
 
-	dwarf_aggregate_size(type_die, &size);
+	if (dwarf_aggregate_size(type_die, &size) != 0)
+		size = 0;
 
 	/* Check existing nodes in dso->data_types tree */
 	key.self.type_name = type_name;
@@ -1569,7 +1576,7 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 	offset = loc->offset;
 
 	pr_debug_dtp("CU for %s (die:%#lx)\n",
-		     dwarf_diename(&cu_die), (long)dwarf_dieoffset(&cu_die));
+		     die_name(&cu_die), (long)dwarf_dieoffset(&cu_die));
 
 	if (reg == DWARF_REG_PC) {
 		if (get_global_var_type(&cu_die, dloc, dloc->ip, dloc->var_addr,
@@ -1636,7 +1643,7 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 		}
 
 		pr_debug_dtp("found \"%s\" (die: %#lx) in scope=%d/%d (die: %#lx) ",
-			     dwarf_diename(&var_die), (long)dwarf_dieoffset(&var_die),
+			     die_name(&var_die), (long)dwarf_dieoffset(&var_die),
 			     i+1, nr_scopes, (long)dwarf_dieoffset(&scopes[i]));
 
 		if (reg == DWARF_REG_PC) {
-- 
2.54.0.545.g6539524ca2-goog

