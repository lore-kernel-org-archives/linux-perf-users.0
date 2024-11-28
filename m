Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D381D1B393F
	for <linux-perf-users@vger.kernel.org>; Thu, 28 Nov 2024 13:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732800998; cv=none; b=fTuV+iFNHhORSqhMAYD498xLP+mcKAMFaseik/FxqF39fhPZo5GDurCXrRGpNty+T3b5Gs9HFyac7PVnd5nIG34mmVFUsVtz9BnAA9a8J+7pFdEGO1voXuslzB/fY/4xrdJ3o/ixmnYjoU12w6pN9t+ZTmS2aKg5EVp0PD3n3FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732800998; c=relaxed/simple;
	bh=UF8YKzahIh+PwN3AwO6NZv3Y89s7Ox98ADCP/IHgSL4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FeHsaU9VVNn6FrraVhdTGcGZ/9SvfgXzy17ZOZf/D1GkDmPc34Ttt9jRET0rVHKuDzShRMONz1wTPbbV/Y2kC+grdBd5yyNZl5FNz7iukSWMtQTCq+yBlsFZIV2IvyLquzrWlyDU8RXN3xo+QL4B6pMQRjw12uocCPUF0VTIFEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gKDL0JUj; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gKDL0JUj"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-724f41d520cso559748b3a.1
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Nov 2024 05:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1732800996; x=1733405796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQ0MaacFYTQJTLNs968qndbUwHA1XnYLHyx9b8Hlr5k=;
        b=gKDL0JUjy/aOnvu/4+hmQ1AjfQYQF448GRvFWaiLl+hQEY3i8363TBEbg9xyl46Kl3
         GuzsdTtzwKQmhjgpxScG8FEoNTBMpfjmvx9jR8O5nA3vIWxP7GyNpy3f4TmwtFhjHf8r
         gDmNAtDpYY6s5/x7ZFLP0rhIbBNgptiETQ+qntWZtl/gFCTNTmscAzQ177qNU+lppDOD
         GXlA2j05Yu+6mLOr/4E/3DVUkjTBOpEjPSt5FULeRkxojpa3p+axI4b7J4rtrq3J88nI
         FIk/1h4UnUKtYyt2674VVSLFEbBh5JWNBR9AVWMbKveqcXxEHe1KB5xqjMeI44ruorJk
         Aj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732800996; x=1733405796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQ0MaacFYTQJTLNs968qndbUwHA1XnYLHyx9b8Hlr5k=;
        b=vhzJMtp8BDetN2JW2uCZWB1Quij1o9tXAZE3VNtvyDHKAGmXt/Zmf0e+fAdQzNmGeg
         ozsnDir5vMUBIoB5cfxLuzemh3/aduZTihu5BWdqIu+0RBPEqg68mfupmASrEHK6WMMB
         SYrQw1UIL3CM/yyHN0N9ZUq7iaZWObIuFWaMiPh8h/DusEqwar773kieRgsH+cJKfpFn
         aism00/jGRrY4SUkQ5dE/Gj/MjPRjUaM+GbpAbUrAyrWxtOnc8gB4dcWfEVIlm4b1vZK
         DzDnnRvG+hpVgJ+3MsEgnekPt7dDvAQPhp2oucHRSodYk26qM+Vvagf0mk3LOBz77n1C
         rEsA==
X-Forwarded-Encrypted: i=1; AJvYcCXIG5jt8BN6ni3fe/FQUvvYqqdUsvzUkxlbHk5dE7mk5FfvfT2Xi2PgA9R95PnAr1bMXNo1vYXy7zs1G2WNqz+h@vger.kernel.org
X-Gm-Message-State: AOJu0YzEr/Ype/Z1A6Y2iizamMuKrFdXyXosEV8Gok8fiJaxqL0aFDVZ
	eoJ6gGA98V0hrNB80aM4C8p4j9iQEZcO6MWh2a9gc3yGf7wJH4lM8l6LfsJ1yfo=
X-Gm-Gg: ASbGnctKZ6gCqI/B1TU7VqEiOsbBLVSTApY0sRqzhWbg80xvcIWQLHx5PQlTt1EBKw8
	qIFhHcyB07zBgGcXvic2TNGH8ObP2lXybfAlr1AFAQiYd6vtzGkrNqrMySmLODj8MHHvYVSyJFq
	tSyymhtUd8ErSwFL+KK+Sl/DT7LAisH8UD5apf3s2FfAlv6blnO+O6tiqe2lnfV3VmRPCQ7N4D5
	2lcsHfadvX0OYrf4hOKvkvDtCSAJZgE7LBMisctvOq87nk3Bsa8fYL8FA==
X-Google-Smtp-Source: AGHT+IEjDUsjrDGDGc5fQqIO+T+FruzKH27Usz7tqWm1DjvNhvcAFC7JN1TUKGdNBDbfARzHkP8zwQ==
X-Received: by 2002:a17:902:c944:b0:20c:bffe:e1e5 with SMTP id d9443c01a7336-2150109a094mr79756385ad.19.1732800996021;
        Thu, 28 Nov 2024 05:36:36 -0800 (PST)
Received: from ubuntu20.04 ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521985632sm12952975ad.206.2024.11.28.05.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 05:36:35 -0800 (PST)
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
Subject: [RFC 04/12] perf event action: Add parsing const string expr support
Date: Thu, 28 Nov 2024 21:35:45 +0800
Message-Id: <20241128133553.823722-5-yangjihong@bytedance.com>
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

Support parsing of constant string expression.

Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---
 tools/perf/util/parse-action.c |  39 ++++++++++++
 tools/perf/util/parse-action.h |   1 +
 tools/perf/util/parse-action.l | 108 +++++++++++++++++++++++++++++++++
 tools/perf/util/parse-action.y |  10 ++-
 4 files changed, 157 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-action.c b/tools/perf/util/parse-action.c
index 3b10cf9f99b3..7e5ca889d5b9 100644
--- a/tools/perf/util/parse-action.c
+++ b/tools/perf/util/parse-action.c
@@ -8,6 +8,7 @@
  * Supported expressions:
  *   - constant:
  *     - integer
+ *     - string
  */
 
 #include "util/debug.h"
@@ -169,8 +170,46 @@ static struct evtact_expr_ops expr_const_int_ops = {
 	.eval = expr_const_int_eval,
 };
 
+static int expr_const_str_new(struct evtact_expr *expr,
+			      void *data, int size __maybe_unused)
+{
+	if (data == NULL) {
+		pr_err("exper const string is NULL\n");
+		return -EINVAL;
+	}
+
+	expr->priv = data;
+	INIT_LIST_HEAD(&expr->opnds);
+	return 0;
+}
+
+static void expr_const_str_free(struct evtact_expr *expr)
+{
+	zfree(&expr->priv);
+}
+
+static int expr_const_str_eval(struct evtact_expr *expr,
+			       void *in __maybe_unused, int in_size __maybe_unused,
+			       void **out, int *out_size)
+{
+	if (out != NULL)
+		*out = expr->priv;
+
+	if (out_size != NULL)
+		*out_size = strlen(expr->priv);
+
+	return 0;
+}
+
+static struct evtact_expr_ops expr_const_str_ops = {
+	.new  = expr_const_str_new,
+	.free = expr_const_str_free,
+	.eval = expr_const_str_eval,
+};
+
 static struct evtact_expr_ops *expr_const_ops_list[EVTACT_EXPR_CONST_TYPE_MAX] = {
 	[EVTACT_EXPR_CONST_TYPE_INT] = &expr_const_int_ops,
+	[EVTACT_EXPR_CONST_TYPE_STR] = &expr_const_str_ops,
 };
 
 static int expr_const_set_ops(struct evtact_expr *expr, u32 opcode)
diff --git a/tools/perf/util/parse-action.h b/tools/perf/util/parse-action.h
index ac81278c590e..ec422f8a05a7 100644
--- a/tools/perf/util/parse-action.h
+++ b/tools/perf/util/parse-action.h
@@ -15,6 +15,7 @@ enum evtact_expr_type {
 
 enum evtact_expr_const_type {
 	EVTACT_EXPR_CONST_TYPE_INT,
+	EVTACT_EXPR_CONST_TYPE_STR,
 	EVTACT_EXPR_CONST_TYPE_MAX,
 };
 
diff --git a/tools/perf/util/parse-action.l b/tools/perf/util/parse-action.l
index 9237399a11ac..f76240276b61 100644
--- a/tools/perf/util/parse-action.l
+++ b/tools/perf/util/parse-action.l
@@ -28,6 +28,54 @@ static int value(int base)
 	return NUMBER;
 }
 
+static char *str_buf;
+static unsigned int str_buf_size = 64;
+static int str_begin(void)
+{
+	if (str_buf == NULL) {
+		str_buf = malloc(str_buf_size);
+		if (str_buf == NULL) {
+			pr_err("parse_action malloc string buffer failed\n");
+			return ERROR;
+		}
+	}
+
+	str_buf[0] = '\0';
+	return 0;
+}
+
+static int str_write(const char *s)
+{
+	char *new_buf;
+
+	if (strlen(str_buf) + strlen(s) >= str_buf_size) {
+		str_buf_size = strlen(str_buf) + strlen(s) + 1;
+		new_buf = realloc(str_buf, str_buf_size);
+		if (new_buf == NULL) {
+			free(str_buf);
+			str_buf = NULL;
+			pr_err("parse_action realloc string buffer failed\n");
+			return ERROR;
+                } else {
+			str_buf = new_buf;
+		}
+	}
+
+	strcat(str_buf, s);
+	return 0;
+}
+
+static int str_end(void)
+{
+	parse_action_lval.str = strdup(str_buf);
+	if (parse_action_lval.str == NULL) {
+		pr_err("parse_action strdup string buffer failed\n");
+		return ERROR;
+	}
+
+	return STRING;
+}
+
 %}
 
 num_dec		[0-9]+
@@ -35,6 +83,8 @@ num_hex		0[xX][0-9a-fA-F]+
 space		[ \t]
 ident		[_a-zA-Z][_a-zA-Z0-9]*
 
+%x STR_BEGIN
+
 %%
 
 {num_dec}	{ return value(10); }
@@ -43,6 +93,64 @@ ident		[_a-zA-Z][_a-zA-Z0-9]*
 
 ";"		{ return SEMI; }
 
+\"		{
+			int ret;
+			yy_push_state(STR_BEGIN);
+			ret = str_begin();
+			if (ret) {
+				yy_pop_state();
+				return ret;
+			}
+		}
+<STR_BEGIN>{
+  \"		{
+			yy_pop_state();
+			return str_end();
+		}
+  [^\\\n\"]+	{
+			int ret;
+			ret = str_write((const char *)yytext);
+			if (ret) {
+				yy_pop_state();
+				return ret;
+			}
+		}
+  \\n		{
+			int ret;
+			ret = str_write("\n");
+			if (ret) {
+				yy_pop_state();
+				return ret;
+                        }
+                }
+  \\t           {
+			int ret;
+			ret = str_write("\t");
+			if (ret) {
+				yy_pop_state();
+				return ret;
+			}
+		}
+  \\\\		{
+			int ret;
+			ret = str_write("\\");
+			if (ret) {
+				yy_pop_state();
+				return ret;
+			}
+		}
+  \\.		{
+			yy_pop_state();
+			pr_err("parse_action invalid escape character: '%s'\n", parse_action_text);
+			return ERROR;
+		}
+  .		{
+			yy_pop_state();
+			pr_err("parse_action invalid character: '%s'\n", parse_action_text);
+			return ERROR;
+		}
+}
+
 {ident}		{
 			parse_action_lval.str = strdup(parse_action_text);
 			if (parse_action_lval.str == NULL) {
diff --git a/tools/perf/util/parse-action.y b/tools/perf/util/parse-action.y
index 51e77e54f157..4922b2d94aee 100644
--- a/tools/perf/util/parse-action.y
+++ b/tools/perf/util/parse-action.y
@@ -37,12 +37,13 @@ static void parse_action_error(struct list_head *expr __maybe_unused,
 	unsigned long long num;
 }
 
-%token IDENT ERROR NUMBER
+%token IDENT ERROR NUMBER STRING
 %token SEMI
 %type <expr> action_term expr_term
 %destructor { parse_action_expr__free($$); } <expr>
 %type <str> IDENT
 %type <num> NUMBER
+%type <str> STRING
 
 %%
 
@@ -76,6 +77,13 @@ NUMBER
 		YYERROR;
 }
 |
+STRING
+{
+	$$ = parse_action_expr__new(expr_id(CONST, STR), NULL, (void *)$1, strlen($1));
+	if ($$ == NULL)
+		YYERROR;
+}
+|
 IDENT
 {
 	$$ = NULL;
-- 
2.25.1

