Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A2831F98E
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 08:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777882370; cv=none; b=V8lCbgxVfLBFyTIDhuP2y3oVwhjqtFO+Hn1Rpukz8gK0/xX2ByLzOxvHkuJvzj71JTcTd5CGIaHhhHmhAhT3yPOiV4rv+Ea4Z+zH6NYY/PUb6kax5Cwq0oReN9bYtP5G7djF5hxxvUY0h9Mpvxt9M2LMR5PAUtEUjaefH5XD/Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777882370; c=relaxed/simple;
	bh=fagq5Pyf6RSPqzFK13KNcLSeUW6HQRUiBptJVsrfrGs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=phN3zwexRd1SbfG1tyNQDDlnY8Hr2UYo7vMQW1Bdr2SzFq9WPUZzBZj8kbhzfVzu86smgu/qEkcLPpZwVo7bCOOFeMm1TxtErOKz/aH8S3YN8p5AVmYJSkAdjE6jeLUwRPTI7xXyh0MlFADvjaMIciNK+xWJpXxjgOPzgfl8blo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b2qSs4M0; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b2qSs4M0"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c726f4019so5272218c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 04 May 2026 01:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777882368; x=1778487168; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SicvtagepMuI70fWYyc1s4K5eI0fAPBxQSJZnUvBoVQ=;
        b=b2qSs4M0K+HUHZ4cGmylNCH8ZY221CqfM8d92hzq1HHO66Bi3MzLbhv5CA7uXRX9hC
         53T71h6L+FyAOlNcMrqBD+ap21Ho8jr9ja8lN7voFp0gBS3cseNi3vdfwyAEZyAdKoIs
         ru4IK6zBdFLYHS4jYd+GIn45BzyYr52O220oXz8jHBiksc1mP9ZHQTLWPw4mItCrBzNu
         tcObtVkSeHW2D1vmE7bnZhbWijkyKmmqwfNJ+2DMrXbMQ4wa/ChqLRHcJwFO4KVbaVKb
         TRmeqKLbd0q5aDNS8rR3EqTyfUOesU/PWx49fG93Lm+wzvGX0IRBFTjEW9XHGURhlFaY
         d8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777882368; x=1778487168;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SicvtagepMuI70fWYyc1s4K5eI0fAPBxQSJZnUvBoVQ=;
        b=p/eVk4uRitK0Le/2QvnD3xEa+1rjfNAg5o1TAPvWE6RY11dp4mGtYyu+VEXnwJPQix
         RQLYztlarp8uCPz9wwAJC9ecOlBvPlTd5sVaAhwF4AQJfxedDaxpq0v9dlLBpykLsi25
         Fr4g8FMFJhmIMAYybmwuAl/DZGn3KvhCkQhHUP4nZXFZi36tfA9tVe8c9TT6I4cDP2SR
         B4bx1Kgv5iNz+MAJ9vEE3ggcZsNxAyguDkYV3x3EkC4a0QC3njaRNzDduICM1W1BvK54
         Lj6cchqX6zscrU81hlkOMZef7ygSLzCsJq7wj3WxB8XpkXNiEVaQc5axGEBZaICj1kk+
         4HIA==
X-Forwarded-Encrypted: i=1; AFNElJ/4utNR5Rw9nF/6N6ugA6+PGc/9VuBKvJc0rFKs0yjUsVsAe5rjgB+j2+th/mstYRmPMwQnFOdhNz2ccbiT++h9@vger.kernel.org
X-Gm-Message-State: AOJu0YweVoQHVdpBzEaV3RYx1k0/zWbpKLv+deza2n3pCY3M9rOXXBk2
	oC0Jid77icYk3yAbcwjikSbhzdTIs1XMxp5y6m/dr5tn2ceCkiOquSSuAmaTxQ0WAlSvHx6CKjn
	45bg8qpEn9A==
X-Received: from dlbps8.prod.google.com ([2002:a05:7023:888:b0:12d:b2ba:b551])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e98d:b0:11b:9b98:aa4b
 with SMTP id a92af1059eb24-12dfd7ae4ffmr3815325c88.6.1777882368044; Mon, 04
 May 2026 01:12:48 -0700 (PDT)
Date: Mon,  4 May 2026 01:12:26 -0700
In-Reply-To: <20260504081227.2203848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503171032.1559338-1-irogers@google.com> <20260504081227.2203848-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504081227.2203848-9-irogers@google.com>
Subject: [PATCH v5 8/9] perf annotate-data: Fix libdw API contract violations
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
v5:
 - Safe string duplication for member variable names.
v4:
 - Safe DWARF name printing in annotate-data.
 - Fix fallback location expression parsing for inherited data members.
---
 tools/perf/util/annotate-data.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 1eff0a27237d..63e3c54fab42 100644
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
+			member->var_name = name ? strdup(name) : NULL;
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

