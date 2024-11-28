Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05AC1A29A
	for <linux-perf-users@vger.kernel.org>; Thu, 28 Nov 2024 13:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732800992; cv=none; b=WT852Xjf2lm6M9YNVbc+e9AOjtP0FqrGBPJ7kmO/siR0OAfigR0aHoXlPsQVp8IKchiML5l0xQO7+ILdmmgwXJ/1yGrCenp8cRobPKKHL/jlhfsTBv1mC0/caD/ltYj8woiMNjJt2G+hMSIN7Cp9NyxDzKsfAONOQ/7jZQU4Etg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732800992; c=relaxed/simple;
	bh=ZXjUJiriPjm3Gh10NHh8Xm8mZQJMBBn+GOzohDYSH70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LuwSL5VKAfZKUo1XkRIHbHv1zVSFh+jEjMtaQs4d3wbVZeILQ2AraOhb0dS7/tFr1j9rXVBk+jEuQJXHias1skiXy24xmXXAXbM2Y+hIK6ePKSBYQYM8ERZyzGEd/gVhGqoLo6Rd9x9oIdCc7Hg1psnu6HhL69gf7mT7qErqW2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TXX+ir1x; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TXX+ir1x"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21285c1b196so7807025ad.3
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Nov 2024 05:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1732800990; x=1733405790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58uF5FRygjmcuC+XqZTAPSHae1wNP7Gs/dWvt8/LZsA=;
        b=TXX+ir1xl2vNxBGZ3Vj1q/ZBjBBCgu9rpaC6SQP0OVLmyspwBE+L5pDf4ttvTi8WLI
         u5MmMBUrB9jj1MhIsI7KiNwS6vZ2eYU77CUH717SiBhc0rMqXL59SEaDvxvlgu5dcHFA
         5LpRDN/wb8a8M0kgJjsz6R6eCuzUZjvJMCgq1fYlMlDlFhoOjfK7FT/tVm2JKxbWxxjs
         LJ+z9HHP+AokumiwqLZ0acyZWmRg61MM+vnhmtwiKCiwWDuHEYd7RHQVR98YswUXlSNC
         KEPU0gWgzBiiBubLZ4a9I7vwTkPX0Ydxn4MBDRn7p6fbRAsjHiDILKGi1N15YKxe4+Cg
         NFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732800990; x=1733405790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58uF5FRygjmcuC+XqZTAPSHae1wNP7Gs/dWvt8/LZsA=;
        b=b8/8K+qwt5FslJ7v4VzfQCu3uDZMHkAL4D+YYinzjocAelayZbW6HpcnoP1yiNoqii
         Xd4gvADjjp5Hrb/PKHAsW3dOlRoUKg2THAPn+fsCZTmqGp/7p2JuHYK2TOHepWYVeDvK
         bKb7x8RQUM/IxkskPZAOJzZecHKvRnlZNEQP3MIOGx++LSRuZKCWBbOflksiJn37b+Mg
         FUkkmJuCoNVVAEefwIEviBfRICPb6+0XaOX3o3Q3XAEX6Uxrdi2ke39wJhnCApcacBgM
         6qoZOEYheVxTDIbR5rfpu52WivZpIN1fINBbFTLtX97QlDV+vWMWlVoJM80J/c13CVRf
         zHIg==
X-Forwarded-Encrypted: i=1; AJvYcCUd2ET8sPob0bMR7AnB6O0tQG3DaF4XeOQb5dMJoH32fusHEMS5X0urWlKr+FbHzlULFoksHcZejtPq54H84Bzi@vger.kernel.org
X-Gm-Message-State: AOJu0Yx470Tu1u0qR+ka14vGUF0SaDR2XwUSUSgjF3vHwOxLriO630TB
	ILJHUGA2/Vbhelk6fbgZ9lbKBeIfHfbVbuIljac0+65FJpCfQlW8oecCMruBYcE=
X-Gm-Gg: ASbGncvyuBlTyYx0b12ZWeqKVi4UtCG1fNzhhSsYm1aMhZnjTvq7vgHXvuoRuyHjZKe
	9DAGb7G+PQ91f0op723dscrVFBUnKON5B5jRP1e17n975YnmTQV9L2wtBEMN9xWBMJRH9zV/v2h
	6Ppo+/pAuFVRU4bR22Bvwe2I0J0cjoDV0++PY7M/f7xa3sGMFL38i3p8B5GWWJ0cJodkCj9/2rY
	1ed37Ubeq0Gb0v7/UpNGJQxoP+NqlTV9QKhP04/HxblZv2vgc6EVkzodQ==
X-Google-Smtp-Source: AGHT+IGaa+4siSbSTtBvK2/ptco5CZWZSWnXqlWEx0fjKUf27R0HZxCGvl+sJ2wvI63J9r4eAkvZxQ==
X-Received: by 2002:a17:903:2b0b:b0:211:f8c8:3730 with SMTP id d9443c01a7336-2150147a24bmr89630305ad.26.1732800990199;
        Thu, 28 Nov 2024 05:36:30 -0800 (PST)
Received: from ubuntu20.04 ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521985632sm12952975ad.206.2024.11.28.05.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 05:36:29 -0800 (PST)
From: Yang Jihong <yangjihong@bytedance.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	james.clark@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [RFC 03/12] perf event action: Add parsing const integer expr support
Date: Thu, 28 Nov 2024 21:35:44 +0800
Message-Id: <20241128133553.823722-4-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241128133553.823722-1-yangjihong@bytedance.com>
References: <20241128133553.823722-1-yangjihong@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support parsing of constant integer expression.

Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---
 tools/perf/util/parse-action.c | 52 ++++++++++++++++++++++++++++++++++
 tools/perf/util/parse-action.h |  1 +
 tools/perf/util/parse-action.l | 19 +++++++++++++
 tools/perf/util/parse-action.y | 13 ++++++++-
 4 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-action.c b/tools/perf/util/parse-action.c
index 391546bf3d73..3b10cf9f99b3 100644
--- a/tools/perf/util/parse-action.c
+++ b/tools/perf/util/parse-action.c
@@ -7,6 +7,7 @@
  *
  * Supported expressions:
  *   - constant:
+ *     - integer
  */
 
 #include "util/debug.h"
@@ -118,7 +119,58 @@ void event_actions__free(void)
 	(void)event_actions__for_each_expr_safe(do_action_free, NULL, false);
 }
 
+static int expr_const_int_new(struct evtact_expr *expr, void *data, int size)
+{
+	if (data == NULL ||
+	    (size != sizeof(int)
+	     && size != sizeof(long) && size != sizeof(long long))) {
+		pr_err("expr_const_int size invalid: %d\n", size);
+		return -EINVAL;
+	}
+
+	expr->priv = malloc(sizeof(long long));
+	if (expr->priv == NULL) {
+		pr_err("exp_ const_int malloc failed\n");
+		return -ENOMEM;
+	}
+
+	if (size == sizeof(int))
+		*(unsigned long long *)(expr->priv) = *(unsigned int *)data;
+	else if (size == sizeof(long))
+		*(unsigned long long *)(expr->priv) = *(unsigned long *)data;
+	else if (size == sizeof(long long))
+		*(unsigned long long *)(expr->priv) = *(unsigned long long *)data;
+
+	INIT_LIST_HEAD(&expr->opnds);
+	return 0;
+}
+
+static void expr_const_int_free(struct evtact_expr *expr)
+{
+	zfree(&expr->priv);
+}
+
+static int expr_const_int_eval(struct evtact_expr *expr,
+			       void *in __maybe_unused, int in_size __maybe_unused,
+			       void **out, int *out_size)
+{
+	if (out != NULL)
+		*out = expr->priv;
+
+	if (out_size != NULL)
+		*out_size = sizeof(long long);
+
+	return 0;
+}
+
+static struct evtact_expr_ops expr_const_int_ops = {
+	.new  = expr_const_int_new,
+	.free = expr_const_int_free,
+	.eval = expr_const_int_eval,
+};
+
 static struct evtact_expr_ops *expr_const_ops_list[EVTACT_EXPR_CONST_TYPE_MAX] = {
+	[EVTACT_EXPR_CONST_TYPE_INT] = &expr_const_int_ops,
 };
 
 static int expr_const_set_ops(struct evtact_expr *expr, u32 opcode)
diff --git a/tools/perf/util/parse-action.h b/tools/perf/util/parse-action.h
index 47bd75264dee..ac81278c590e 100644
--- a/tools/perf/util/parse-action.h
+++ b/tools/perf/util/parse-action.h
@@ -14,6 +14,7 @@ enum evtact_expr_type {
 };
 
 enum evtact_expr_const_type {
+	EVTACT_EXPR_CONST_TYPE_INT,
 	EVTACT_EXPR_CONST_TYPE_MAX,
 };
 
diff --git a/tools/perf/util/parse-action.l b/tools/perf/util/parse-action.l
index 3cb72de50372..9237399a11ac 100644
--- a/tools/perf/util/parse-action.l
+++ b/tools/perf/util/parse-action.l
@@ -13,13 +13,32 @@
 #include "parse-action.h"
 #include "parse-action-bison.h"
 
+static int value(int base)
+{
+	unsigned long long num;
+
+	errno = 0;
+	num = strtoul(parse_action_text, NULL, base);
+	if (errno) {
+		pr_err("parse_action malloc number failed\n");
+		return ERROR;
+	}
+
+	parse_action_lval.num = num;
+	return NUMBER;
+}
+
 %}
 
+num_dec		[0-9]+
+num_hex		0[xX][0-9a-fA-F]+
 space		[ \t]
 ident		[_a-zA-Z][_a-zA-Z0-9]*
 
 %%
 
+{num_dec}	{ return value(10); }
+{num_hex}	{ return value(16); }
 {space}		{ }
 
 ";"		{ return SEMI; }
diff --git a/tools/perf/util/parse-action.y b/tools/perf/util/parse-action.y
index fade9d093d4a..51e77e54f157 100644
--- a/tools/perf/util/parse-action.y
+++ b/tools/perf/util/parse-action.y
@@ -17,6 +17,8 @@
 #include "util/debug.h"
 #include "util/parse-action.h"
 
+#define expr_id(t, o) evtact_expr_id_encode(EVTACT_EXPR_TYPE_##t, EVTACT_EXPR_##t##_TYPE_##o)
+
 int parse_action_lex(void);
 
 static void parse_action_error(struct list_head *expr __maybe_unused,
@@ -32,13 +34,15 @@ static void parse_action_error(struct list_head *expr __maybe_unused,
 	char *str;
 	struct evtact_expr *expr;
 	struct list_head *list;
+	unsigned long long num;
 }
 
-%token IDENT ERROR
+%token IDENT ERROR NUMBER
 %token SEMI
 %type <expr> action_term expr_term
 %destructor { parse_action_expr__free($$); } <expr>
 %type <str> IDENT
+%type <num> NUMBER
 
 %%
 
@@ -65,6 +69,13 @@ expr_term
 }
 
 expr_term:
+NUMBER
+{
+	$$ = parse_action_expr__new(expr_id(CONST, INT), NULL, (void *)&$1, sizeof($1));
+	if ($$ == NULL)
+		YYERROR;
+}
+|
 IDENT
 {
 	$$ = NULL;
-- 
2.25.1

