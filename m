Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C32216E1B
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Apr 2025 21:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745962298; cv=none; b=PhMkxHVxJ5wuOYvqu9sL1EOTmbc1AY20/EkO1qCHntlTLzxbLPLueTY1SDcITWRqTf3GWflU/yy5lTVWJ8mTs5hgN2k9usnT7ziH4oU1xixle0yOclHqqnz9HdxeYaA0pZuYxVW48PHOY30KM9n+0JudSj6AwTNTpEtY6Te9/z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745962298; c=relaxed/simple;
	bh=+slmZ6DP/zYpqPwTzVLaOZOby+gRYjBSqcQUOTFlYWs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bevvV2ArZywkw63W6bQKm4qNL470CojyU5dKP/IIYtzHV2KdUZUAtfSogq6LZbfGft/uuVpvsqjZc/UViroANG7ibLx4R6iStcyTk2dOPmFcl5Etf5KQcVR2JrgiI2pibNtzr5Ctvk15S6G/0mDrIf+kkoUpiLHxqQKcd/oyTlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2ognFsgr; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2ognFsgr"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b1f71ae2181so544926a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Apr 2025 14:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745962296; x=1746567096; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SSyPGzRmH+p29W/zOgc1ak7tYCQVhV0niieNsI3F3T0=;
        b=2ognFsgrow0FZiUTv7Xf+YK4YpsewJLsOgPeIxr/aRw+23QG6Aq5p0UfQaIBSCbrsV
         szmXhtwzNTVwWLSNlaWxW/ehhwQv2XpG1rZPVap5t1jNXJltrqC3WHBjvlYPxuKyzMC3
         i+8YyYN/XpWYefnK69eS+Q677iX39Ky+fTvCxgUb4xTupDdc1nesnT1c7qv88CPLU3fQ
         JU6TOHKIvaZOwMVxyeF/PV/IEiT+2GjOMPwLC1R2O8IfwGpezPZe4x3yWtiOoPSQcZaB
         ytskRJCXyNzNR4wYphfZuJ/g7qmdZQ1IjFeKSeWq7rSBnrRabYCl5Zdj+kalHaTz13o0
         pHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745962296; x=1746567096;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SSyPGzRmH+p29W/zOgc1ak7tYCQVhV0niieNsI3F3T0=;
        b=IoIRVNtF7Hkm6Wd3bborlcox48PWqD3RAIikyCScItP3J50AdgTVXk6VM+jq3n6NDF
         JuMCAkIqSgiUsRpnYp5nVMCBQhniL4gRTOtaxge5aOt3sqSJnzUZoDc8/fNhXbUkaQ9J
         6Zk+sxGgkQ0k26Fnldngu8xMaoGh/tFLjKyhq2DIA99Gldf7ufROyzI3+P/5ONu0E5Ds
         DgBEm/ya2FqHVKA24MSmqTBrtk5q3QmsssCdB2lbn0le02aXOJ41Y/qlX7iuzwRVSEGW
         sP6QBamwBTa9VvS9k46g3k5pZ5pzWpWgdyv55VBuA+kJpVSL3BtVztYh5CIsu4c7BOch
         0x2A==
X-Forwarded-Encrypted: i=1; AJvYcCVeKsZRMCQx+bWAA4DOn/0Dk5tV22lP7ncEMQsdtAWoQCwLGMvTVqghDckFpVcSBjNPe/jyhl4sWRyN1z+NJs7P@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm4Hj4NEkfQDwA3KAkFKzKSQcY6g+POO96X6RBFHk+Kw3VoA4o
	P1JvYAfZAHmJJ+ReTLUzitz8TH2Bspitj4wea51D9Adda0FCzO7Esfyz0ylWy92s+S/wwYO9Kup
	b
X-Google-Smtp-Source: AGHT+IHOSDOIqpZpmYQaY3Yz/7hu12LY8GBmRluDIfh5RN3+pVvh6Z7iPpXYxLligqfOYM9sLtdxd65Na1g=
X-Received: from pfble20.prod.google.com ([2002:a05:6a00:4fd4:b0:73d:65cb:b18b])
 (user=yabinc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3e03:b0:73d:fa54:afb9
 with SMTP id d2e1a72fcca58-7403899f538mr1059841b3a.7.1745962296306; Tue, 29
 Apr 2025 14:31:36 -0700 (PDT)
Date: Tue, 29 Apr 2025 14:31:33 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <20250429213133.922495-1-yabinc@google.com>
Subject: [PATCH v2] perf: Allocate non-contiguous AUX pages by default
From: Yabin Cui <yabinc@google.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@linaro.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Liang Kan <kan.liang@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"

perf always allocates contiguous AUX pages based on aux_watermark.
However, this contiguous allocation doesn't benefit all PMUs. For
instance, ARM SPE and TRBE operate with virtual pages, and Coresight
ETR allocates a separate buffer. For these PMUs, allocating contiguous
AUX pages unnecessarily exacerbates memory fragmentation. This
fragmentation can prevent their use on long-running devices.

This patch modifies the perf driver to allocate non-contiguous AUX
pages by default. For PMUs that can benefit from contiguous pages (
Intel PT and BTS), a new PMU capability, PERF_PMU_CAP_AUX_PREFER_LARGE
is introduced to maintain their existing behavior.

Signed-off-by: Yabin Cui <yabinc@google.com>
---
Changes since v1:
In v1, default is preferring contiguous pages, and add a flag to
allocate non-contiguous pages. In v2, default is allocating
non-contiguous pages, and add a flag to prefer contiguous pages.

v1 patchset:
perf,coresight: Reduce fragmentation with non-contiguous AUX pages for
cs_etm

 arch/x86/events/intel/bts.c |  3 ++-
 arch/x86/events/intel/pt.c  |  3 ++-
 include/linux/perf_event.h  |  1 +
 kernel/events/ring_buffer.c | 18 +++++++++++-------
 4 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index a95e6c91c4d7..9129f00e4b9f 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -625,7 +625,8 @@ static __init int bts_init(void)
 		return -ENOMEM;
 
 	bts_pmu.capabilities	= PERF_PMU_CAP_AUX_NO_SG | PERF_PMU_CAP_ITRACE |
-				  PERF_PMU_CAP_EXCLUSIVE;
+				  PERF_PMU_CAP_EXCLUSIVE |
+				  PERF_PMU_CAP_AUX_PREFER_LARGE;
 	bts_pmu.task_ctx_nr	= perf_sw_context;
 	bts_pmu.event_init	= bts_event_init;
 	bts_pmu.add		= bts_event_add;
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index fa37565f6418..37179e813b8c 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1866,7 +1866,8 @@ static __init int pt_init(void)
 
 	pt_pmu.pmu.capabilities		|= PERF_PMU_CAP_EXCLUSIVE |
 					   PERF_PMU_CAP_ITRACE |
-					   PERF_PMU_CAP_AUX_PAUSE;
+					   PERF_PMU_CAP_AUX_PAUSE |
+					   PERF_PMU_CAP_AUX_PREFER_LARGE;
 	pt_pmu.pmu.attr_groups		 = pt_attr_groups;
 	pt_pmu.pmu.task_ctx_nr		 = perf_sw_context;
 	pt_pmu.pmu.event_init		 = pt_event_init;
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 0069ba6866a4..56d77348c511 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -301,6 +301,7 @@ struct perf_event_pmu_context;
 #define PERF_PMU_CAP_AUX_OUTPUT			0x0080
 #define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0100
 #define PERF_PMU_CAP_AUX_PAUSE			0x0200
+#define PERF_PMU_CAP_AUX_PREFER_LARGE		0x0400
 
 /**
  * pmu::scope
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 5130b119d0ae..d76249ce4f17 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -679,7 +679,7 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
 {
 	bool overwrite = !(flags & RING_BUFFER_WRITABLE);
 	int node = (event->cpu == -1) ? -1 : cpu_to_node(event->cpu);
-	int ret = -ENOMEM, max_order;
+	int ret = -ENOMEM, max_order = 0;
 
 	if (!has_aux(event))
 		return -EOPNOTSUPP;
@@ -689,8 +689,8 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
 
 	if (!overwrite) {
 		/*
-		 * Watermark defaults to half the buffer, and so does the
-		 * max_order, to aid PMU drivers in double buffering.
+		 * Watermark defaults to half the buffer, to aid PMU drivers
+		 * in double buffering.
 		 */
 		if (!watermark)
 			watermark = min_t(unsigned long,
@@ -698,16 +698,20 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
 					  (unsigned long)nr_pages << (PAGE_SHIFT - 1));
 
 		/*
-		 * Use aux_watermark as the basis for chunking to
+		 * For PMUs that prefer large contiguous buffers,
+		 * use aux_watermark as the basis for chunking to
 		 * help PMU drivers honor the watermark.
 		 */
-		max_order = get_order(watermark);
+		if (event->pmu->capabilities & PERF_PMU_CAP_AUX_PREFER_LARGE)
+			max_order = get_order(watermark);
 	} else {
 		/*
-		 * We need to start with the max_order that fits in nr_pages,
+		 * For PMUs that prefer large contiguous buffers,
+		 * we need to start with the max_order that fits in nr_pages,
 		 * not the other way around, hence ilog2() and not get_order.
 		 */
-		max_order = ilog2(nr_pages);
+		if (event->pmu->capabilities & PERF_PMU_CAP_AUX_PREFER_LARGE)
+			max_order = ilog2(nr_pages);
 		watermark = 0;
 	}
 
-- 
2.49.0.967.g6a0df3ecc3-goog

