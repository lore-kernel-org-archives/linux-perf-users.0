Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5407D4028C8
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 19:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779304001; cv=none; b=ALALLu0Egm4y30NQto7/wXDD+Eh3ExQX1geEw7e3uzw0v3wl0hexKw4gDrogEm9FAG/YQRujRvp205sm4Vh5ZvKuPeX7IdFQEQEuB7d+Ag0T5RQS1sM3AySpF1FPlsPQMCBFr4Cto2vXJVAPl9z/TJkkudtJjGwYnfU3SohW9P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779304001; c=relaxed/simple;
	bh=mP4IXUpll1oLEeWOuAg5hgv4bMn+TRY3Y3NbqGKaXtE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L5u+dv0YuhPVhG8TKsE97uMl4vRjAvb4JnTthn/YbNBtbsDAiEQVxretP3+NRktvlPtSKS81kK+q76xkxzLZKk9ubvEwvaQF3kqgh+INfdY5eo7SjDcQzieg1Go/SV9MpSwDHlDM5eRbSbwHCnKq/s3gwkgnd/sdPnzL/JZIhHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BTbMw85M; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BTbMw85M"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2fe1cf409a1so9112325eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 12:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779303999; x=1779908799; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ynO0Ho3lfsOZ7Xjk65C9AavCo8ZdkdCs3DnIRo2m5uI=;
        b=BTbMw85M22d0kvkZu0X+f1yWJx8ebCSimsqdYBZIJGGy8usjRDlbRu5VybwOwVy/MK
         OHhH53vhCMZu5gbhFZE+0T+hFfD4Gp8SiqRiziKptA+tFPBasGxdKyev5KTde0VZWomL
         L79Lb1ok4jMU/8gb/ndyagF4/P97kGUJFr5y7uBPS+MkF4nc3/MYDvvTdxwIC4oBrV2C
         9Aj0bbVWbGqzbN6ScAz/LkuvZkWtzI+V/VJev3V4HeLG5mhDU71k5oU+i3dD16K7JU/Y
         YViX96cRt+nCgO7VQcVPUbe5tES4Za8k1ePb4npXmEkNFNdoP2dzyAgG4d+OAZhcb/KR
         i2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779303999; x=1779908799;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ynO0Ho3lfsOZ7Xjk65C9AavCo8ZdkdCs3DnIRo2m5uI=;
        b=R75LbMvfM+rXIXofSDCXeeuKupVZI4JBYl49uMcEBJPEP1AnaErXqhKJoJRCN1l0Mg
         CrpG9olJGHrgR9KW9aRGCOmQrLEZhRmuxFiBPb2SWeMsB2CHMZfiXW7Cl8E4VymJRex6
         dVoYWYUNui17wM7gYlMWZBl15TpckI8Uze7fit02krn1Sq7um+CBSGUXYebCGGLjnEfb
         cpq4Yk2ndCvLrYlBeexphUg605xSBb4TD+6jz0qhMZlRrCkLJlMBmxcR/HadXgnoBlZH
         tdFCrRV8+qBN1cJ1fg2tSG+VzZIcZgLgW3O27tOmohxXydyIF1KW9I1GlUq7yFBpkA1Z
         I2SA==
X-Forwarded-Encrypted: i=1; AFNElJ8pSJna01jcsN+bBQzon4wzzqyGG4o01uYibL1134RygQ/HhLCT18Ytwb9up8KHOKRs6kLRIeuANWyqGiVqgoH2@vger.kernel.org
X-Gm-Message-State: AOJu0YxFtOXLNLiPJc2tzESEu+79X6rjtjnwTE/AwmbFUVdqVfczG2ZL
	ou4W6TChLnqSWjCoXu5tA0vrPS/pnblXaWH3UNkwIKcGNW4TVyHFYJLa+h/vlSS/bSDwUu84a22
	mXD5/INxXRQ==
X-Received: from dyau11.prod.google.com ([2002:a05:7300:600b:b0:303:2247:382])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:fb83:b0:2de:cc07:e8b
 with SMTP id 5a478bee46e88-3039818afa7mr12954480eec.1.1779303999273; Wed, 20
 May 2026 12:06:39 -0700 (PDT)
Date: Wed, 20 May 2026 12:05:33 -0700
In-Reply-To: <20260520190538.142018-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512223001.2952848-1-irogers@google.com> <20260520190538.142018-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260520190538.142018-28-irogers@google.com>
Subject: [PATCH v14 27/32] perf kmem: Add bounds checks to tracepoint read values
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
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

Sanitize order and migrate_type values from tracepoint payloads before using
them as array indexes.

When processing page_alloc_event and page_free_event, verify that 'order' is less
than MAX_PAGE_ORDER and 'migrate_type' is less than MAX_MIGRATE_TYPES. This
guarantees that indexing into order_stats[MAX_PAGE_ORDER][MAX_MIGRATE_TYPES] remains
strictly within bounds, avoiding out-of-bound heap or static segment accesses.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
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
2.54.0.746.g67dd491aae-goog

