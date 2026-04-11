Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9683CBE8D
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 19:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775935092; cv=none; b=VNJyt4hPhcfzlmnuKDA7s28YgDdKWednzkgdASJck8p38SJLA78+9ZqDjqr6UVNUuEI8Hsy8oH1Xm4A9wk8RurM6mdh6Kiam1VVBDNm5EY5umuGuOBWd1dRLO3KYDVlk72rJOcFQYQt9hhqiVHzwtpmDWVd83US7TbP1PNRPc44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775935092; c=relaxed/simple;
	bh=TORHr2hwj56t1K+9uUsjLQo6KHkuVY+QoSlV3b0luUk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HeDJAW9pbFvPBgccjV5uHkrUX9eIQwW8ol+NO4j1pqMcNG3smlx+GVpINHXO7+uPZ2aqvo6Ixl/Hq4g0AF5fQm3xMJpK5y36q8L7di75EWClkmtFPi+iq1OFaBUOnglw1C03vKzPWqgcT0fyrpKHvnN48dVtoYw02GIFX2YeIwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bjhfv6bf; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bjhfv6bf"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c0ba59a830so4310248eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 12:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775935091; x=1776539891; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hQS4P5hyltqhKwRzLCXyq1MWFkkdWjplTUZAMK0ialE=;
        b=Bjhfv6bfCF2JEt7F4z9jrZBdTq+aJC7ruU0/Rfu0HOyUuRm4aXz5ECrxR1uvOyBuph
         6ftrVTVE3sDcgXKj/+eZ7sQGdtKNPVIxTYx4kNy/ZWOu1pU8sDJJMY+Wqd+fKzjrUq7G
         +oehOtdJL9vPN77C0/bI6mri0uQJKZrozWbT3pVKQnr7KHIi7M5H64cVrudvCxRmIWjt
         SXIcimQsMbV0ezGVW9wsCBQvVWXYzanifssYmsO/IluwAxqkd86/pHYIzsBAzLi54r4Q
         LClKQI91TkLbMcPa9zE2vV6tYVNfdIBqmfSqDudDcfRAqkcxazpKBnP7LN4gerBFpyMM
         ohig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775935091; x=1776539891;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hQS4P5hyltqhKwRzLCXyq1MWFkkdWjplTUZAMK0ialE=;
        b=s4PF90ekJpMCVUBH5WevnwC0Y/CXX5kZlA9cTDWOAhGRg9PTEK9XJk7rhGniU6qD3F
         5veXeceDtwWjAsOBZ9vpyg8VwSyd5KB1M+fwUhtkvM5c/i6djprsrz6PTRUtoC7GwVWo
         Yc/rUZ9IiYOsHafXXR90oErXhPsmnNqq3OqupSwhFbk6Df6CUrN5LX5Xz0ERm/MDShbF
         B7Pmhgw/rRCwcBVRRxpkP4UjVWTbgwEWC1lSPDU/Rsq21/Ig9yrWNKRcoWDgrxzR9fUf
         H2rQUATMtz5BDSJlDP9AAqN4f+CJbIKCbcUfd7X05Byw0HKrlgUVqqdKFM7gQZTtznCs
         qM6w==
X-Forwarded-Encrypted: i=1; AFNElJ8aYYycYyVh7iAfouBAyab2+OcWK3s3krAtP/B0w+3AYRY67gPl8t7LFl+Iixm++o2otFIY4PeAU8hBeyq9dg9a@vger.kernel.org
X-Gm-Message-State: AOJu0YxSZsDb8b/Y6C4FlCCN7nMYc+haCzvGjxniyTcsJvKlTJmeOT9k
	7JrNLUlPuH8SmvTO/eGpAQ+lbO2rZY1psB2GeijNJj3DMCCo8jy1cWHxNpP7POh1ELdiglzC7Fx
	OnYrPYkOSQw==
X-Received: from dycmm14.prod.google.com ([2002:a05:693c:260e:b0:2d1:6536:ac9e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e2cc:b0:2c1:7793:7bbb
 with SMTP id 5a478bee46e88-2d5898a59fdmr4772124eec.27.1775935090639; Sat, 11
 Apr 2026 12:18:10 -0700 (PDT)
Date: Sat, 11 Apr 2026 12:17:05 -0700
In-Reply-To: <20260411191710.524998-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260411065718.372240-1-irogers@google.com> <20260411191710.524998-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411191710.524998-25-irogers@google.com>
Subject: [PATCH v9 24/29] perf kmem: Add bounds checks to tracepoint read values
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ajones@ventanamicro.com, ak@linux.intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

Avoid out-of-bound memory accesses by bound checking order and
migrate_type when coming from page_alloc_event and page_free_event.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kmem.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index daf2272c7337..33585e353efe 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -826,6 +826,16 @@ static int evsel__process_page_alloc_event(struct perf_sample *sample)
 		.migrate_type = migrate_type,
 	};
 
+	if (order >= MAX_PAGE_ORDER) {
+		pr_debug("Out-of-bounds order %u\n", order);
+		return -1;
+	}
+
+	if (migrate_type >= MAX_MIGRATE_TYPES) {
+		pr_debug("Out-of-bounds migratetype %u\n", migrate_type);
+		return -1;
+	}
+
 	if (use_pfn)
 		page = perf_sample__intval(sample, "pfn");
 	else
@@ -892,6 +902,11 @@ static int evsel__process_page_free_event(struct perf_sample *sample)
 		.order = order,
 	};
 
+	if (order >= MAX_PAGE_ORDER) {
+		pr_debug("Out-of-bounds order %u\n", order);
+		return -1;
+	}
+
 	if (use_pfn)
 		page = perf_sample__intval(sample, "pfn");
 	else
-- 
2.53.0.1213.gd9a14994de-goog

