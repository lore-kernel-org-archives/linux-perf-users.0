Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C76E1AAE23
	for <linux-perf-users@vger.kernel.org>; Thu, 28 Nov 2024 13:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732801009; cv=none; b=rcbTDA8CqEzGOkbbIgMWXtW4n3Wo9CbfqslRjip9g0ijpOtP+jw7+OYuDRrQ3/u4wYIxrOdXRZeAM+bAi4jQJthczbzMwBd9fuTldRH78QEhD/eOGeV45I8kQVn02L4bs+KKOBQuIMUrxRGKym558E7yDIjvZuHWqrIJH8c6K5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732801009; c=relaxed/simple;
	bh=+LNZpBhiaOxnH+Ezhfur1Zzi2CJqROuf+YAka+RZ568=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YthqeClzcveWFpMmsbdBj+2D/+I1Z8klkgBBidCIUSAsBIDKjbBdYBACfxTTGLOj1Bg5wtC1bBPMgkL/80fett6N7UL/tBMJMlYHlMjkGREWdx2WYBQgQ84T2BSqprCAkUGk/rPtQymg/4fZNJohsBRbLLBu0zIf0uSihW2dV3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VPTI5Pyu; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VPTI5Pyu"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21210eaa803so7289015ad.2
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Nov 2024 05:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1732801007; x=1733405807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqQaIVC+j9LhZ/TRorXPn9tvoBLETViH2KLqmtwG9as=;
        b=VPTI5PyuE73XIkTENBetZEkw5CAs938qyDVUgM49iravWX08cGBA6CUYpDm2M8C6L8
         5YNLb9+h0RPdR4gy9HDN77bvZIw0mPcqRrBEhkf7CsIULMdvtak55RLj0bRXg57j45Yk
         N9uEHqR6xR/l8S/AQgsuO0AhYJwy4ZEsFw1sVnvr6OEBORVmbWWqcXzgD8HLAsgYqUO+
         QiRrtevP8u7Bq9gW1y593BRwzVaLDVABGLky/WdYvVnZcDrPyGqeKgBSq8ZwZluWXDVx
         iYUj36vZaRGsVwO1ve8tFpP+xnu7vA4g+BIGjUy8mC4FZX/4MoYQJdhjD4847Xeii5Un
         cnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732801007; x=1733405807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqQaIVC+j9LhZ/TRorXPn9tvoBLETViH2KLqmtwG9as=;
        b=j2gWSpQT+Pd+5n/qbNVv2M/g3Tr/H+TzGiB3nM6ecU7rGwDutQmc/4itovhxjualVG
         P+aasWkwnRAWfV2Gi3516SGb5JcjXpzWzHFJCHX42b+QZs5saYuA5MiVpoaJRHjwlkvS
         gnDXtUugPCZJZPFOjtPBJRHBETIjxkMWa3OMAE6h5NfAi7GdgwErH1aiK5wZACOaeXnX
         K2aDno90MutC8KDgjAwX8d4/FS51swzR3IUvIGZF7AurCxthgm2soQEEd3WIFLdKgqJm
         fZaczqv6UAnm0U/2bGvAs2NxAp1CDDZmUyh+tolr7afPACrEqgSG82qMtaSQhm+FU7hR
         TRaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSlk2rQlilZyhUEWRnQSf2bCMN/CcnsUSmXx96JxVAPXGtZy/hPvdJY3JgkjpLLcoUObvQKsaq90pQIu0UFDtn@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Kzud5Y2vku/N5CN0VZGL/XACYA1u4wySrrxpMslWs6PGMuTq
	n3s50Ncf0WaImNP2sQGygr7B1zFiak7NZbObZyFXSAd3CyJzAMx+b4zLQ0JP4Yw=
X-Gm-Gg: ASbGncunre+0iC4zZaIRngjjjGfpn2WgNIn/CTatCKb9TnipPmdYb7s3oXLpov+htfN
	e+qEu+XMpB6HwqZkitbI2Eg97iTBQaR/nA6dWI9kS6/uz3YHFZuUblfgR2kCUgeQ1dEhPr6MlgC
	2O6d1HY4pe5mV21wrYp48e/3ZPYpOtm1oIBXn4p/8gnIexAIX3eFyc2Y1AmnrQNBi6bsFSLRPbv
	DoBXQyY27Si+rgECHXnbyfds00u2QcDrb4Lq0nu8Y/sK7p5Bq6bWBsdJA==
X-Google-Smtp-Source: AGHT+IF3rwvUZnobMrf3bzrwFLm6Hr8ohxbpugrVFikYQUJ5h78RZPldvuutj+6JrOe0I8HRAp8V9Q==
X-Received: by 2002:a17:903:1ce:b0:211:18bc:e74b with SMTP id d9443c01a7336-21501083ab6mr108542035ad.1.1732801007302;
        Thu, 28 Nov 2024 05:36:47 -0800 (PST)
Received: from ubuntu20.04 ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521985632sm12952975ad.206.2024.11.28.05.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 05:36:46 -0800 (PST)
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
Subject: [RFC 06/12] perf event action: Add parsing print() call expr support
Date: Thu, 28 Nov 2024 21:35:47 +0800
Message-Id: <20241128133553.823722-7-yangjihong@bytedance.com>
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

Add support for parsing print() function calls, the parameter format is
similar to C's printf(), the first parameter is a string format,
and format specifiers support %c, %d, %d, %o, %u, %x, %X, %s.
Currently, it simply checks whether the number of arguments matches
the number of format specifiers.

Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---
 tools/perf/util/parse-action.c | 329 +++++++++++++++++++++++++++++++++
 tools/perf/util/parse-action.h |   1 +
 tools/perf/util/parse-action.l |   9 +
 3 files changed, 339 insertions(+)

diff --git a/tools/perf/util/parse-action.c b/tools/perf/util/parse-action.c
index 40e7c8aad7be..95c06cc071ad 100644
--- a/tools/perf/util/parse-action.c
+++ b/tools/perf/util/parse-action.c
@@ -10,8 +10,11 @@
  *     - integer
  *     - string
  *   - call:
+ *     - print
  */
 
+#include <regex.h>
+
 #include "util/debug.h"
 #include "util/parse-action.h"
 #include "util/parse-action-flex.h"
@@ -171,6 +174,12 @@ static struct evtact_expr_ops expr_const_int_ops = {
 	.eval = expr_const_int_eval,
 };
 
+static bool is_const_str_expr(struct evtact_expr *expr)
+{
+	return expr->id == evtact_expr_id_encode(EVTACT_EXPR_TYPE_CONST,
+						 EVTACT_EXPR_CONST_TYPE_STR);
+}
+
 static int expr_const_str_new(struct evtact_expr *expr,
 			      void *data, int size __maybe_unused)
 {
@@ -233,7 +242,327 @@ static struct evtact_expr_class expr_const = {
 	.set_ops = expr_const_set_ops,
 };
 
+enum print_fmt_spec_len {
+	PRINT_FMT_SPEC_LEN_INT,
+	PRINT_FMT_SPEC_LEN_LONG,
+	PRINT_FMT_SPEC_LEN_LONG_LONG,
+};
+
+enum print_fmt_spec_type {
+	PRINT_FMT_SPEC_TYPE_VOID,
+	PRINT_FMT_SPEC_TYPE_INT,
+	PRINT_FMT_SPEC_TYPE_STRING,
+};
+
+struct print_fmt_spec {
+	struct list_head list;
+	enum print_fmt_spec_type type;
+	enum print_fmt_spec_len len;
+	char *str;
+};
+
+#define PRINT_OUT_BUF_DEFAULT_LEN 64
+struct print_expr_priv {
+	struct list_head fmt_specs;
+	int fmt_spec_num;
+	int args_num;
+	char *out;
+	int out_len;
+};
+
+static int print_fmt_add_spec(struct print_expr_priv *priv, char *s,
+			      regoff_t len, enum print_fmt_spec_len spec_len,
+			      enum print_fmt_spec_type spec_type)
+{
+	struct print_fmt_spec *spec;
+
+	spec = malloc(sizeof(*spec));
+	if (spec == NULL) {
+		pr_err("call print fmt spec malloc failed\n");
+		return -ENOMEM;
+	}
+
+	spec->str = strndup(s, len);
+	if (spec->str == NULL) {
+		pr_err("call print fmt spec strndup failed\n");
+		free(spec);
+		return -ENOMEM;
+	}
+
+	spec->len = spec_len;
+	spec->type = spec_type;
+	list_add_tail(&spec->list, &priv->fmt_specs);
+	return 0;
+}
+
+static int print_fmt_spec_get_len(char *s, regoff_t len)
+{
+	if (len == 1 && !strncmp(s, "l", len))
+		return PRINT_FMT_SPEC_LEN_LONG;
+	else if (len == 2 && !strncmp(s, "ll", len))
+		return PRINT_FMT_SPEC_LEN_LONG_LONG;
+
+	return PRINT_FMT_SPEC_LEN_INT;
+}
+
+static int print_fmt_spec_get_type(char *s)
+{
+	switch (s[0]) {
+	case 'c':
+	case 'd':
+	case 'o':
+	case 'u':
+	case 'x':
+	case 'X':
+		return PRINT_FMT_SPEC_TYPE_INT;
+	case 's':
+		return PRINT_FMT_SPEC_TYPE_STRING;
+	default:
+		break;
+	}
+
+	return PRINT_FMT_SPEC_TYPE_VOID;
+}
+
+static int print_fmt_get_string(struct evtact_expr *expr, char **fmt)
+{
+	int ret, fmt_len;
+	struct evtact_expr *fmt_expr;
+
+	fmt_expr = list_first_entry_or_null(&expr->opnds, struct evtact_expr, list);
+	if (fmt_expr == NULL) {
+		pr_err("print() requires at least one argument\n");
+		return -EINVAL;
+	} else if (!is_const_str_expr(fmt_expr)) {
+		pr_err("print() first argument expected to be string\n");
+		return -EINVAL;
+	}
+
+	if (fmt_expr->ops->eval != NULL) {
+		ret = fmt_expr->ops->eval(fmt_expr, NULL, 0, (void **)fmt, &fmt_len);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static void print_fmt_free_specs(struct print_expr_priv *priv)
+{
+	struct print_fmt_spec *spec, *tmp;
+
+	if (priv == NULL)
+		return;
+
+	list_for_each_entry_safe(spec, tmp, &priv->fmt_specs, list) {
+		list_del(&spec->list);
+		free(spec->str);
+		free(spec);
+	}
+}
+
+static int print_fmt_split(struct evtact_expr *expr, struct print_expr_priv *priv)
+{
+	int i, ret;
+	char *s, *fmt;
+	regex_t regex;
+	regmatch_t pmatch[6];
+	int spec_len, spec_type;
+	const char *const re = "%(-?)([0-9]*)(\\.[0-9]+)?(ll|l)?([cdosuxX])";
+
+	ret = print_fmt_get_string(expr, &fmt);
+	if (ret)
+		return ret;
+
+	if (regcomp(&regex, re, REG_EXTENDED)) {
+		pr_err("expr call print fmt regcomp failed\n");
+		return -1;
+	}
+
+	s = fmt;
+	for (i = 0;; i++) {
+		if (regexec(&regex, s, ARRAY_SIZE(pmatch), pmatch, 0))
+			break;
+
+		spec_len = print_fmt_spec_get_len(s + pmatch[4].rm_so,
+						  pmatch[4].rm_eo - pmatch[4].rm_so);
+		spec_type = print_fmt_spec_get_type(s + pmatch[5].rm_so);
+
+		ret = print_fmt_add_spec(priv, s, pmatch[0].rm_eo, spec_len, spec_type);
+		if (ret)
+			goto out_free_specs;
+
+		s += pmatch[0].rm_eo;
+	}
+
+	if ((size_t)(s - fmt) < strlen(fmt)) {
+		ret = print_fmt_add_spec(priv, s, strlen(fmt) - (s - fmt),
+					 PRINT_FMT_SPEC_LEN_INT, PRINT_FMT_SPEC_TYPE_VOID);
+		if (ret)
+			goto out_free_specs;
+	}
+
+	priv->fmt_spec_num = i;
+	return 0;
+
+out_free_specs:
+	print_fmt_free_specs(priv);
+	return ret;
+}
+
+static int print_check_args(struct evtact_expr *expr, struct print_expr_priv *priv)
+{
+	struct evtact_expr *arg;
+
+	priv->args_num = 0;
+	list_for_each_entry(arg, &expr->opnds, list)
+		priv->args_num++;
+
+	/* do not count format string argument */
+	priv->args_num--;
+
+	if (priv->args_num != priv->fmt_spec_num) {
+		pr_err("print() arguments number for format string mismatch: %d expected, %d provided\n",
+		       priv->fmt_spec_num, priv->args_num);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int expr_call_print_new(struct evtact_expr *expr,
+			       void *data __maybe_unused, int size __maybe_unused)
+{
+	int ret;
+	struct print_expr_priv *priv;
+
+	priv = malloc(sizeof(struct print_expr_priv));
+	if (priv == NULL)
+		return -ENOMEM;
+
+	priv->out = malloc(PRINT_OUT_BUF_DEFAULT_LEN);
+	if (priv->out == NULL) {
+		ret = -ENOMEM;
+		goto out_free_priv;
+	}
+	priv->out_len = PRINT_OUT_BUF_DEFAULT_LEN;
+
+	INIT_LIST_HEAD(&priv->fmt_specs);
+	ret = print_fmt_split(expr, priv);
+	if (ret)
+		goto out_free_out_buf;
+
+	ret = print_check_args(expr, priv);
+	if (ret)
+		goto out_free_specs;
+
+	expr->priv = priv;
+	return 0;
+
+out_free_specs:
+	print_fmt_free_specs(priv);
+out_free_out_buf:
+	free(priv->out);
+	priv->out_len = 0;
+out_free_priv:
+	free(priv);
+	return ret;
+}
+
+static void expr_call_print_free(struct evtact_expr *expr)
+{
+	struct print_expr_priv *priv;
+
+	priv = expr->priv;
+	if (priv == NULL)
+		return;
+
+	print_fmt_free_specs(expr->priv);
+	zfree(&priv->out);
+	priv->out_len = 0;
+	zfree(&expr->priv);
+}
+
+static int expr_call_print_eval(struct evtact_expr *expr,
+				void *in, int in_size,
+				void **out __maybe_unused, int *out_size __maybe_unused)
+{
+	int ret, len;
+	char *buf_out;
+	int arg_val_size;
+	unsigned long long *arg_val;
+	struct evtact_expr *arg;
+	struct print_fmt_spec *spec;
+	struct print_expr_priv *priv = expr->priv;
+
+retry:
+	len = 0;
+	priv->out[0] = '\0';
+	arg = list_first_entry(&expr->opnds, struct evtact_expr, list);
+	list_for_each_entry(spec, &priv->fmt_specs, list) {
+		if (spec->type == PRINT_FMT_SPEC_TYPE_VOID) {
+			len += snprintf(priv->out + len, priv->out_len - len, "%s", spec->str);
+		} else {
+			arg = list_next_entry(arg, list);
+			if (arg == NULL) {
+				pr_err("expr call print arguments are empty\n");
+				return -EINVAL;
+			}
+
+			ret = arg->ops->eval(arg, in, in_size, (void **)&arg_val, &arg_val_size);
+			if (ret) {
+				pr_err("expr call print eval argument failed %d\n", ret);
+				return ret;
+			}
+
+			if (spec->type == PRINT_FMT_SPEC_TYPE_STRING) {
+				len += snprintf(priv->out + len, priv->out_len - len,
+						spec->str, arg_val);
+			} else if (spec->type == PRINT_FMT_SPEC_TYPE_INT) {
+				switch (spec->len) {
+				case PRINT_FMT_SPEC_LEN_INT:
+					len += snprintf(priv->out + len, priv->out_len - len,
+							spec->str, *(unsigned int *)arg_val);
+					break;
+				case PRINT_FMT_SPEC_LEN_LONG:
+					len += snprintf(priv->out + len, priv->out_len - len,
+							spec->str, *(unsigned long *)arg_val);
+					break;
+				case PRINT_FMT_SPEC_LEN_LONG_LONG:
+					len += snprintf(priv->out + len, priv->out_len - len,
+							spec->str, *(unsigned long long *)arg_val);
+					break;
+				default:
+					break;
+				}
+			}
+		}
+
+		if (len >= priv->out_len) {
+			buf_out = realloc(priv->out, priv->out_len << 1);
+			if (buf_out != NULL) {
+				priv->out = buf_out;
+				priv->out_len <<= 1;
+				goto retry;
+			}
+		}
+
+		if (len >= priv->out_len)
+			break;
+	}
+
+	printf("%s", priv->out);
+	return 0;
+}
+
+static struct evtact_expr_ops expr_call_print_ops = {
+	.new  = expr_call_print_new,
+	.free = expr_call_print_free,
+	.eval = expr_call_print_eval,
+};
+
 static struct evtact_expr_ops *expr_call_ops_list[EVTACT_EXPR_CALL_TYPE_MAX] = {
+	[EVTACT_EXPR_CALL_TYPE_PRINT] = &expr_call_print_ops,
 };
 
 static int expr_call_set_ops(struct evtact_expr *expr, u32 opcode)
diff --git a/tools/perf/util/parse-action.h b/tools/perf/util/parse-action.h
index 30c2fd6e81d0..f8aece601a84 100644
--- a/tools/perf/util/parse-action.h
+++ b/tools/perf/util/parse-action.h
@@ -21,6 +21,7 @@ enum evtact_expr_const_type {
 };
 
 enum evtact_expr_call_type {
+	EVTACT_EXPR_CALL_TYPE_PRINT,
 	EVTACT_EXPR_CALL_TYPE_MAX,
 };
 
diff --git a/tools/perf/util/parse-action.l b/tools/perf/util/parse-action.l
index 189f73dfc3b1..5e75383ba3e7 100644
--- a/tools/perf/util/parse-action.l
+++ b/tools/perf/util/parse-action.l
@@ -76,6 +76,12 @@ static int str_end(void)
 	return STRING;
 }
 
+static int call(u32 opcode)
+{
+	parse_action_lval.opcode = opcode;
+	return CALL;
+}
+
 %}
 
 num_dec		[0-9]+
@@ -91,6 +97,9 @@ ident		[_a-zA-Z][_a-zA-Z0-9]*
 {num_hex}	{ return value(16); }
 {space}		{ }
 
+
+print		{ return call(EVTACT_EXPR_CALL_TYPE_PRINT); }
+
 ";"		{ return SEMI; }
 "("		{ return LP;   }
 ")"		{ return RP;   }
-- 
2.25.1

