Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15B1345CA3
	for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 02:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775959781; cv=none; b=H3304LSgQk4h6gryBhvvjysa8rqDIY4Wh7l7/MuwacVlNCcysBfyjo89Y3ZNPtsbq3sEuF2E5Xy/pRxaB3Jxs9nxxBBB08rbJcd3pVyxaUKqLsB3iMWx1Mbawry7pgMDPoGgFz2caSgC2/tx5Z6c90SL9oQdks2E16Q/Y9RHXB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775959781; c=relaxed/simple;
	bh=TORHr2hwj56t1K+9uUsjLQo6KHkuVY+QoSlV3b0luUk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SlOEwcht8Fp9cFsz2oKNZ26ckxvNwRZmCWlzvFVrM7AuLfiYE6x8ggZmhMCDadXzgHYmNOqljPeKgSmLIaoAa0bWdQPxUhh5sK8pJ2ES1AIev7gECy0T+uERUHcAPasJ9qVkkmQK+zMNy115igfv+7hNoSrj8Qa9rHC/zpMLTtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hhbKr+3t; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hhbKr+3t"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c0f6593ef5so4606583eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 19:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775959780; x=1776564580; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hQS4P5hyltqhKwRzLCXyq1MWFkkdWjplTUZAMK0ialE=;
        b=hhbKr+3tp6VvqluKVOqFaaLlgB/j3ST7YpMdlJ8DwbEYN50lUjYLlh32/kYvh+s9jE
         sIyBgjpgrBeoAr6AuO3Xhe30aaYRkmfuCueGzVoMHdCHvkF4LXIW3MiUtAzZRQdB+mCh
         1ZbmkxX2XA8hwiq1JrGynFIqCEZlxie2K5mBZIznIxHCGOtMGyX5O6b+CHxWiqLpTPjS
         YGqMCdUMgISQkIxAflm1yyNvpvoKSiXZzfirDNour5R71S7dVfO3GVqB0EJa/j88Un/h
         0h30tCFLepUqmfLyEw6yv+RoKKpKkH9LowOvi0tPYiK9clmysoUnIIeBr74FQgnDZag0
         XcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775959780; x=1776564580;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hQS4P5hyltqhKwRzLCXyq1MWFkkdWjplTUZAMK0ialE=;
        b=KzPPQvb282fv+RcOs5IM+N089k78QRaPVdrWbyVQWe84GOSXdo9KVwPuTlG8481SM2
         +y6txSRkbI0vkv//X/Efoamwn7WlBzOzkIWsSgjjXeEmJ+3vvfrWVinWTClAvfWVaqV/
         6eCyAYe7xthLoadiHy0qSUYwV3hxDZb98F4CpqWeq33gLW5YGzQ82JpsSQAsysvcmpNh
         raJ5w0LUNTrfWorWlbzWi4OCJm6HxyiXR0Ptvd9/NETVaOTMW20ERpVrKfzX9x4zzyrk
         fnyHkqSwc+aEMosXxaK1ghNCvdscUnIk0LelgZLESnfa9tjHf+7OJ1EVdTWnUUfQ69ma
         uSaw==
X-Forwarded-Encrypted: i=1; AFNElJ9X/Xj3rdsookPWLyrFY1sOYGqRvYxa17OJygaqfA3YDWI1mntS4EREmPNAIaKamULN5NZmbWC7kVT80Y9LuYz0@vger.kernel.org
X-Gm-Message-State: AOJu0YxXiN8U8OzlL/bOkH9S0GQXRhxGo//jwjjAW4knQ6XGllKdg9co
	wrGAMQrH25L0xC1QZDATaEj4tQwGGkZANOxc39mUPh28e2o22V7GvFaRsJ4YkIgZo4aVQewpOSo
	MoHMLUtBAPw==
X-Received: from dybdm8.prod.google.com ([2002:a05:7300:bb08:b0:2d8:5557:aec])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d13:b0:2be:1f58:32a3
 with SMTP id 5a478bee46e88-2d5898a5344mr5065550eec.29.1775959779339; Sat, 11
 Apr 2026 19:09:39 -0700 (PDT)
Date: Sat, 11 Apr 2026 19:08:27 -0700
In-Reply-To: <20260412020833.641177-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260411191710.524998-1-irogers@google.com> <20260412020833.641177-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260412020833.641177-25-irogers@google.com>
Subject: [PATCH v10 24/29] perf kmem: Add bounds checks to tracepoint read values
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

