Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A771A9B52
	for <linux-perf-users@vger.kernel.org>; Thu, 28 Nov 2024 13:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732800986; cv=none; b=Uf2RmjP8AVIwAVlLWcgsdjeXJEuUnbjpBtKC/DbF94BMKhjsrDdgcpfvduBIA/s52RrSq9pltgP+DTrzmrvfvxi5AItmK1h3Hk3xmRtjmJrJCxcJryG5f6LEWYtLorxpGef6kW+d6M+VOX5g9iX7CIwEtzrsi/zdJiEsrUo+82A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732800986; c=relaxed/simple;
	bh=6ThYDcVZyhY//Fe+U3aUG3hZA7Q+8SD/azeS/VR6mWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CkUkf6zcmLmImBHFEaTJdDgqLOaaUbe4wwmYDI6ShJsccTL9b5CTqllfjFk9FYzF1wId7CosOG/4JocnJtCzROQ0nQJfi+pRkaFHNuOuyIXRNTrs7l+2kBcjVKghUNJRwkskjxByL+r7o8/iwHDIH0NTihdQQx9GJHj6FnFL314=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GAF4kq84; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GAF4kq84"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-215348d1977so1998405ad.3
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Nov 2024 05:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1732800984; x=1733405784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYHGwytb9blVTqG0sujztYOJv09yetn3wc+93NLrAqc=;
        b=GAF4kq84hXqUkeXOFGS4csKZCo6myvBXcbo9zStRgw6zuFcRhk2JXDIfBfnzaJj139
         /S/E5as7csUoSzIzWJ0Tm5fx+7Gh7RLlubehKeUTALmqEfVNHnro8IyPh73umCYCxBnx
         Z6m+pqa0TD7tA7fOP76Vjx/GPg2pBbDThrOO+/0aPHUfnIdHkoPNr9JMIFyEizLZ2o51
         cbpNsWeFevsXjOOFSqMk0C+6DccXATwx+b8Zg8MbPEqx/7/4DNRnVZ6Yuzox4s+HwS3d
         ypgR6P5i7H/ZXvaa8+nKgqMDtyXSMtrP+8CShAU7I6xIqTXc4UqlghtNoAPWKRZPx5Ci
         An9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732800984; x=1733405784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYHGwytb9blVTqG0sujztYOJv09yetn3wc+93NLrAqc=;
        b=FcxzwQbXen6PITCZCRLVby66xvcg/OuGz7HoDIKuDOo8XA99ywDAIDd30W0D4m0j88
         RhQTw+4ulENH2J6PQGUwcYp3RgJYFYsgcNkR0EWATyJZOMFNZ+7icWRv+NUYPZwHC3aI
         flDrlJwejIwSTIA3fhO6Qk6I2rEuK5xvZ6H45p75BKN/Ydwr2AhS7xbgqqPO6tM8T/aY
         aFRm/y9amrF03h3sgDRcNzJTi+2tomi1Isr0ZNSLm1ptElgO7zdnCmPIkOSBgDzaaZUh
         KCe3rQgmQy0qNlpQZ1aoojgVqLkBUMbnX5z4tnCMq4cMnaF7Z8uNtLBOuZE9mnittRs3
         WcGg==
X-Forwarded-Encrypted: i=1; AJvYcCWtNVpFhVSCCIAtXRRr/JnstH5dpLRnuTg4ICLhmaEvmkug+YcRnxGQ9FFvVFgFj1IGzKP97yPbnhRAizGFOD4b@vger.kernel.org
X-Gm-Message-State: AOJu0YxF8oZKRxMkcz0948Q3zbdNHx4r6ZGnpl1+qBmHbjSYUMlRExG0
	7TbqFLNxM+XBvjk4adqAG6X7AMPqDsW27ePHi2gmgUYLk7DkLWR1ZN/BozD1ZwU=
X-Gm-Gg: ASbGncsjpyRb3rnr2gl+PaO0gZeFi4GHyOKMd+DpbzsFQAHlKLqKV3WbE+5gsynrHXo
	SHemzCKCJ4nG8QexDkPKAH+2BguHqqYXwxEua+t8vTjOzGg8tsURJafF4TH3bP6bfWcf7T2wXGZ
	iW+Vfv8c2alZSWPMsi76lbr0lmm30kIkLfxZdmw8J1yZQzb32mP5x7zs4SinpskGKa5BVC8dHxg
	WUNQ6UQ4Be7dfw8HesNlqeWBHYJ/fOtk3cpn/KUEZ5oO9yVWUmy06U8EA==
X-Google-Smtp-Source: AGHT+IHwW1lu2icW5S94cwvi35KNqg+f7Y0zASnP7MGOuqwai4HXVUNxxnO6Ug/jGgQJijx2DPpjYw==
X-Received: by 2002:a17:902:e747:b0:20c:ab33:f8b8 with SMTP id d9443c01a7336-21501381499mr100226835ad.15.1732800984649;
        Thu, 28 Nov 2024 05:36:24 -0800 (PST)
Received: from ubuntu20.04 ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521985632sm12952975ad.206.2024.11.28.05.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 05:36:24 -0800 (PST)
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
Subject: [RFC 02/12] perf event action: Add parsing const expr support
Date: Thu, 28 Nov 2024 21:35:43 +0800
Message-Id: <20241128133553.823722-3-yangjihong@bytedance.com>
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

Event action requires constant expression parsing support,
which include constant integer and constant string.

Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---
 tools/perf/util/parse-action.c | 27 +++++++++++++++++++++++++++
 tools/perf/util/parse-action.h |  5 +++++
 2 files changed, 32 insertions(+)

diff --git a/tools/perf/util/parse-action.c b/tools/perf/util/parse-action.c
index 01c8c7fdea59..391546bf3d73 100644
--- a/tools/perf/util/parse-action.c
+++ b/tools/perf/util/parse-action.c
@@ -4,6 +4,9 @@
  * Actions are the programs that run when the sampling event is triggered.
  * The action is a list of expressions separated by semicolons (;).
  * Each action is an expression, added to actions_head node as list_head node.
+ *
+ * Supported expressions:
+ *   - constant:
  */
 
 #include "util/debug.h"
@@ -115,7 +118,31 @@ void event_actions__free(void)
 	(void)event_actions__for_each_expr_safe(do_action_free, NULL, false);
 }
 
+static struct evtact_expr_ops *expr_const_ops_list[EVTACT_EXPR_CONST_TYPE_MAX] = {
+};
+
+static int expr_const_set_ops(struct evtact_expr *expr, u32 opcode)
+{
+	if (opcode >= EVTACT_EXPR_CONST_TYPE_MAX) {
+		pr_err("expr_const opcode invalid: %u\n", opcode);
+		return -EINVAL;
+	}
+
+	if (expr_const_ops_list[opcode] == NULL) {
+		pr_err("expr_const opcode not supported: %u\n", opcode);
+		return -ENOTSUP;
+	}
+
+	expr->ops = expr_const_ops_list[opcode];
+	return 0;
+}
+
+static struct evtact_expr_class expr_const = {
+	.set_ops = expr_const_set_ops,
+};
+
 static struct evtact_expr_class *expr_class_list[EVTACT_EXPR_TYPE_MAX] = {
+	[EVTACT_EXPR_TYPE_CONST]   = &expr_const,
 };
 
 int parse_action_expr__set_class(enum evtact_expr_type type,
diff --git a/tools/perf/util/parse-action.h b/tools/perf/util/parse-action.h
index 71a0a166959e..47bd75264dee 100644
--- a/tools/perf/util/parse-action.h
+++ b/tools/perf/util/parse-action.h
@@ -9,9 +9,14 @@
 #include "evlist.h"
 
 enum evtact_expr_type {
+	EVTACT_EXPR_TYPE_CONST,
 	EVTACT_EXPR_TYPE_MAX,
 };
 
+enum evtact_expr_const_type {
+	EVTACT_EXPR_CONST_TYPE_MAX,
+};
+
 struct evtact_expr;
 struct evtact_expr_ops {
 	int (*new)(struct evtact_expr *expr, void *data, int size);
-- 
2.25.1

