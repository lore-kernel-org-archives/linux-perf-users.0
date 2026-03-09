Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB253221F39
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 01:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773018040; cv=none; b=E+kW5VcFtuMuUn8OxZWuzCDfymvWwsphOf2PxeonQexgxQD4WlnlS52rYbOYx6qulrYPN0WuTmbDECFGkaWCU6aM7FjWUG0T9h+81jpqvbjxYXGiQfqCDgQAa+K7R+87t+jeTEcji07X2xQ8kLKtu27HZXnZ8ei1pmGFT54CuLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773018040; c=relaxed/simple;
	bh=XdcNrO1rpl9oROTyNF0DxVnNHOaFtHkMCKTMyUXfRTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6Q9YtvrrylRanDLipSuH2a+6D3xFDDeSgRhMOAGsgT3VafIxJ+rYI61pBxPtMi0Fi0QseRGAiov7KnM9mQsjpHGiHHLHhVIHq7AyZA2bgu3YYkJpEwyN0zExngGPHEBJsBPbTf/FJ0CNCbYj/rR0dSJ6LLOzuW8cUV766PS9Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWb3nNY0; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWb3nNY0"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8297e0b27e5so2509052b3a.1
        for <linux-perf-users@vger.kernel.org>; Sun, 08 Mar 2026 18:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773018039; x=1773622839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w43nXR7xWSoKpck0e6FCmKt3LrGCcnIPN9hu9NiuuQA=;
        b=CWb3nNY0RsoP1INcsOQEwTjAhh2xJXyHuyqbm9e+tJXyT9vqqrs32IWb4/pnsBqNZJ
         L/1IcGpu30VpQ6qfLl0mkBsqM7M+kaDr63SAguf5+am3RY0YUBpOURkzaIxRoYGA6zOM
         4Me5py34qucql3+ueHfs3DW36QHLmqa5tVjeYiPRsYxxyKwv9IOB3yX5hzMu4OugcUk3
         l1D4RViJPCUTqnKYF3Jk90JxpCPCi0rNlyD0gLvO8N6piYRwsZugrQwkG+/O4SDrM4dZ
         0yNMcuAnJQ4pT4gMQYMHN0i3MypPq3G4s7z25BIrIbZUX3AwV+Vp7wmKLMF3uFSd6hQn
         b6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773018039; x=1773622839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w43nXR7xWSoKpck0e6FCmKt3LrGCcnIPN9hu9NiuuQA=;
        b=VIB1VcYz+V0uRf7b8Y7jVQVxCzh+8ZBjEF0GI9Qdoh4kj9+cf3mlbGY9JqSeMj1woK
         7FRO00MBAMBOrbAJRZK2EHoeIbDDrSiGJUsLtGMYCEY3igaqITElHe5MoY6aHlFSEHJG
         jViz7UlO8d2vHqc+T21hOT6Wxq9uyP8B/t2XdEhOOaQ7MwIjxk1A+IXQBhL8W8sq/rex
         Ac7lrawXyT3EiN3yZNci/O7RYhC8yJa5a5uaMwD+JDI3BurzLqJ6vWOJe6vkoRTbl04l
         WTttBplwBEidONsmqAjX1bxILDqrahSYrpnHmGMnGd7QglKJ5Mt1b0oHt3Havc4121RT
         I8dg==
X-Gm-Message-State: AOJu0YzVmo1a90YLHSwrhT+AfDJOsGpYjVGWWPn5O2hDTEmptlAWqm/w
	qVhlXG+md5w0/UZcBeXO4mPyquyaQZyQOAbK8CSHYIqfvAKAIzp+xQgH
X-Gm-Gg: ATEYQzzjoKSgi/aMFRREZh1rApi8z04jv2Ie9FhXpIyjcLYdAkEjNSIDXkSQovalI+k
	lIRqSq9McYdN7dcA3mWH0dCRW3nMqv022HCqt4Cd7N9SBLAH4N3Q5JB6P7GZ10Ti2HJGEkRGeep
	YDSej6aaJdBVVS1aQxQRnwMlp2LKKFSdnvbht+O9oZCy06S6yrUX+fVNTkpKcQihkzSY+wpHnza
	ak46u9MSTX9HdTk+OaLJ26cwenXnJotHHNR/KOWZmFlFk8c/Q38qTJAVcsocq4ZxJPqlSHuUHg0
	4m/mIdSTk5Wpv9w1K2QJTG0YN/jHwgoY5hbSdkMZ3roHwNVYczSP0jbsSKFmPmsjIWdYG8wSttB
	GdNh593hInc6IjhU/A5jVuByHUJNn95YO8fj1hpRVhdaXDVuP4oHTzIP3llWW2lCvaLN1RUh9Fl
	Ddu16PYFw9Td2WCYXvduk/43Tqp0MUbr69Te31Aw==
X-Received: by 2002:a05:6a00:cd0:b0:823:c59:9cb0 with SMTP id d2e1a72fcca58-829a2db98d7mr8752687b3a.1.1773018038895;
        Sun, 08 Mar 2026 18:00:38 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:35e4:35af:8d0d:ad4c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4635d62sm8468794b3a.5.2026.03.08.18.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 18:00:38 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: damon@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org,
	sj@kernel.org,
	akinobu.mita@gmail.com
Subject: [RFC PATCH v2 5/6] mm/damon/paddr: support perf event based access check
Date: Mon,  9 Mar 2026 10:00:08 +0900
Message-ID: <20260309010009.11639-6-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309010009.11639-1-akinobu.mita@gmail.com>
References: <20260309010009.11639-1-akinobu.mita@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds perf event based access checks for physical address spaces monitoring.

The implementation is very similar to that described in perf event based access check
for virtual address space monitoring.

However, for perf events that can be specified with physical address spaces monitoring,
the data source address corresponding to the sample must be obtainable as a physical address.
In other words, PERF_SAMPLE_DATA_SRC and PERF_SAMPLE_PHYS_ADDR must be specifiable
in perf_event_attr.sample_type.
---
 mm/damon/paddr.c | 102 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 96 insertions(+), 6 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 68dcde5d423f..a5293af870fd 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -48,7 +48,7 @@ static void damon_pa_mkold(phys_addr_t paddr)
 	folio_put(folio);
 }
 
-static void __damon_pa_prepare_access_check(struct damon_region *r,
+static void __damon_pa_basic_prepare_access_check(struct damon_region *r,
 		unsigned long addr_unit)
 {
 	r->sampling_addr = damon_rand(r->ar.start, r->ar.end);
@@ -56,14 +56,14 @@ static void __damon_pa_prepare_access_check(struct damon_region *r,
 	damon_pa_mkold(damon_pa_phys_addr(r->sampling_addr, addr_unit));
 }
 
-static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
+static void damon_pa_basic_prepare_access_checks(struct damon_ctx *ctx)
 {
 	struct damon_target *t;
 	struct damon_region *r;
 
 	damon_for_each_target(t, ctx) {
 		damon_for_each_region(r, t)
-			__damon_pa_prepare_access_check(r, ctx->addr_unit);
+			__damon_pa_basic_prepare_access_check(r, ctx->addr_unit);
 	}
 }
 
@@ -81,7 +81,7 @@ static bool damon_pa_young(phys_addr_t paddr, unsigned long *folio_sz)
 	return accessed;
 }
 
-static void __damon_pa_check_access(struct damon_region *r,
+static void __damon_pa_basic_check_access(struct damon_region *r,
 		struct damon_attrs *attrs, unsigned long addr_unit)
 {
 	static phys_addr_t last_addr;
@@ -103,7 +103,7 @@ static void __damon_pa_check_access(struct damon_region *r,
 	last_addr = sampling_addr;
 }
 
-static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
+static unsigned int damon_pa_basic_check_accesses(struct damon_ctx *ctx)
 {
 	struct damon_target *t;
 	struct damon_region *r;
@@ -111,7 +111,7 @@ static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
 
 	damon_for_each_target(t, ctx) {
 		damon_for_each_region(r, t) {
-			__damon_pa_check_access(
+			__damon_pa_basic_check_access(
 					r, &ctx->attrs, ctx->addr_unit);
 			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
 		}
@@ -364,6 +364,96 @@ static int damon_pa_scheme_score(struct damon_ctx *context,
 	return DAMOS_MAX_SCORE;
 }
 
+#ifdef CONFIG_PERF_EVENTS
+
+static void damon_pa_perf_check_accesses(struct damon_ctx *ctx, struct damon_perf_event *event)
+{
+	struct damon_perf *perf = event->priv;
+	struct damon_target *t;
+	unsigned int tidx = 0;
+
+	if (!perf)
+		return;
+
+	damon_paddr_histogram_init(&perf->paddr_histogram);
+
+	damon_perf_populate_paddr_histogram(ctx, event);
+
+	damon_for_each_target(t, ctx) {
+		struct damon_region *r;
+		unsigned int nr_accessed = 0;
+
+		damon_for_each_region(r, t) {
+			unsigned long addr;
+
+			if (r->accessed)
+				continue;
+
+			for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
+				if (damon_paddr_histogram_count(&perf->paddr_histogram,
+									addr & PAGE_MASK)) {
+					r->accessed = true;
+					nr_accessed++;
+					break;
+				}
+			}
+		}
+		tidx++;
+	}
+
+	damon_paddr_histogram_destroy(&perf->paddr_histogram);
+}
+
+#else /* CONFIG_PERF_EVENTS */
+
+static void damon_pa_perf_check_accesses(struct damon_ctx *ctx, struct damon_perf_event *event)
+{
+}
+
+#endif /* CONFIG_PERF_EVENTS */
+
+static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
+{
+	struct damon_perf_event *event;
+
+	if (list_empty(&ctx->perf_events))
+		return damon_pa_basic_prepare_access_checks(ctx);
+
+	list_for_each_entry(event, &ctx->perf_events, list)
+		damon_perf_prepare_access_checks(ctx, event);
+}
+
+static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
+{
+	struct damon_target *t;
+	struct damon_perf_event *event;
+	unsigned int max_nr_accesses = 0;
+
+	if (list_empty(&ctx->perf_events))
+		return damon_pa_basic_check_accesses(ctx);
+
+	damon_for_each_target(t, ctx) {
+		struct damon_region *r;
+
+		damon_for_each_region(r, t)
+			r->accessed = false;
+	}
+
+	list_for_each_entry(event, &ctx->perf_events, list)
+		damon_pa_perf_check_accesses(ctx, event);
+
+	damon_for_each_target(t, ctx) {
+		struct damon_region *r;
+
+		damon_for_each_region(r, t) {
+			damon_update_region_access_rate(r, r->accessed, &ctx->attrs);
+			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
+		}
+	}
+
+	return max_nr_accesses;
+}
+
 static int __init damon_pa_initcall(void)
 {
 	struct damon_operations ops = {
-- 
2.43.0

