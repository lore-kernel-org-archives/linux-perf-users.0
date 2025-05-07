Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F4F241673
	for <linux-perf-users@vger.kernel.org>; Wed,  7 May 2025 18:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746641631; cv=none; b=ci7z7GcXsc956Z6DWz38VcXcuhWiIVdepm/DPTcUOjMq7JNk9I0TPexSuy+QBKEG0IyWGgWnelyVodT4xES4LUXG+aozhq6hmzP+iYuQS8zFzvH3O268cGoNPyKPstY4nmP7Wn6UO/ncsQICfCAyuUSIfs/w/ABe+D5jfD7/avc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746641631; c=relaxed/simple;
	bh=3VvSBSZHAcqGL90WW9CUZLTPJaD3rXPiR7KPvcxHITI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rxW+D6GTAF+c18JANUb7xafSTyP+2tdTpm+q6Zz7o1ov/pR7hJm6XE4XsmLqRYwS/n750pY1xVgw/BC0A9PeaoT59V0LfeMZTfRiKUokK0O5bbV12mm8eYBi2MDxzUULjahRsF/2hvaRZHpYA0l3iX5ucpUgs1wA1Yvgte6k7m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lAZrRe9e; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lAZrRe9e"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30ab450d918so209323a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 07 May 2025 11:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746641629; x=1747246429; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ab0z/F9w7QZP+evG5akeK0TKh6nX5z62iRNswb/WdEg=;
        b=lAZrRe9eDHagQ0vkCDItayi1y0CTf9yWVzkE/OFhyc3welcyXXe/bsqDe331Wd1x1x
         3KLRzt0VOSf6580G+17DQInUgVZQ6MjycCLVm9L70UNCVJxSoZ2bk2ylk1g8bg/9XzM+
         Tx0aFDNC9X65z0GUpMvkruF9T4ul+wi0NvLG/XAWJgRVlbTLFXdHu5529CeuLEuKTkyT
         jYjEYKOkigvu548qNe9y3UHXJAM84kmxgDXGie9tFYCY/M0o7PIVXS4h/KGhYC5e/vK6
         nPpVdf/ZVSL4+hjm4RUtrwXTZQqVg9Gs+7dDybi2nUcSIqAfZgjV45IqrUZlV6fSG5oC
         haVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746641629; x=1747246429;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ab0z/F9w7QZP+evG5akeK0TKh6nX5z62iRNswb/WdEg=;
        b=TzZ88uiiii+2x9oTTXYR7TLLSu5aUKLuKBB0ik/RdbGIABdWuQ2zeHGpff1KSE0ok1
         dc7N76JlmahtrQJK7UD3l48S811KOpIxEX02aPrr1qzHz3047uH9g2e147uGxVlsVBM7
         3ukYzLd0CVjEK1Sk9yomIoVWbiGaO45mqIn26ZzjKavrAME5cJG5/ITcKtzbl59Pe8+y
         /+4Pbqhpq5n49Szksujo1TFG4dnMhTEINEy97mFZlpkIYqcIYn1FjzJ6LqNV4XPdW0Wt
         k6wPjYoM//Ci9gR9JHKYsFhIwQuo0Bz0EwpWGW2bCaPcKoDMUn5DMhbob7aSeKeTiLWs
         ExqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlVmNdwmYvpn1EZ6uNIlrDkcynaXO/SMuoQgPtw88GpWxxnKr8tE2Bk303x7AHKUk/3qUW0usnOCmHg9llXf6h@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv22IF9uoo2DsjUo0+nWVM2ZyyGhpxg1frPwqfGne1e65WdVkU
	EA0Js1hRqg5HXeA+Ti+mfMTxe0DblaizRysZuYiVlqFBtMZjg0BRCj6lX1ueQ4uQkU8pbrsEYR+
	d
X-Google-Smtp-Source: AGHT+IGpLtQq0H5iCUdoOPsdCAt5VRS4YQpvIHWiOc6SQmamTL+NGw8aOW9RqwiZ2NDkrnrpMD7IjSLJbok=
X-Received: from pjbpv17.prod.google.com ([2002:a17:90b:3c91:b0:301:2679:9aa])
 (user=yabinc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e7c8:b0:2f4:432d:250d
 with SMTP id 98e67ed59e1d1-30b3a6715b7mr207404a91.21.1746641629056; Wed, 07
 May 2025 11:13:49 -0700 (PDT)
Date: Wed,  7 May 2025 11:13:46 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250507181346.1892103-1-yabinc@google.com>
Subject: [PATCH v4] perf: Allocate non-contiguous AUX pages by default
From: Yabin Cui <yabinc@google.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@linaro.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Liang Kan <kan.liang@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Anshuman Khandual <anshuman.khandual@arm.com>
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

This patch modifies the perf driver to be memory-friendly by default,
by allocating non-contiguous AUX pages. For PMUs requiring contiguous
pages (Intel BTS and some Intel PT), the existing
PERF_PMU_CAP_AUX_NO_SG capability can be used. For PMUs that don't
require but can benefit from contiguous pages (some Intel PT), a new
capability, PERF_PMU_CAP_AUX_PREFER_LARGE, is added to maintain their
existing behavior.

Signed-off-by: Yabin Cui <yabinc@google.com>
---
Changes since v3:
Add comments and a local variable to explain max_order value
changes in rb_alloc_aux().

Changes since v2:
Let NO_SG imply PREFER_LARGE. So PMUs don't need to set both flags.
Then the only place needing PREFER_LARGE is intel/pt.c.

Changes since v1:
In v1, default is preferring contiguous pages, and add a flag to
allocate non-contiguous pages. In v2, default is allocating
non-contiguous pages, and add a flag to prefer contiguous pages.

v1 patchset:
perf,coresight: Reduce fragmentation with non-contiguous AUX pages for
cs_etm

 arch/x86/events/intel/pt.c  |  2 ++
 include/linux/perf_event.h  |  1 +
 kernel/events/ring_buffer.c | 33 ++++++++++++++++++++++++---------
 3 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index fa37565f6418..25ead919fc48 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1863,6 +1863,8 @@ static __init int pt_init(void)
 
 	if (!intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries))
 		pt_pmu.pmu.capabilities = PERF_PMU_CAP_AUX_NO_SG;
+	else
+		pt_pmu.pmu.capabilities = PERF_PMU_CAP_AUX_PREFER_LARGE;
 
 	pt_pmu.pmu.capabilities		|= PERF_PMU_CAP_EXCLUSIVE |
 					   PERF_PMU_CAP_ITRACE |
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
index 5130b119d0ae..69c90ea1b79a 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -679,7 +679,19 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
 {
 	bool overwrite = !(flags & RING_BUFFER_WRITABLE);
 	int node = (event->cpu == -1) ? -1 : cpu_to_node(event->cpu);
-	int ret = -ENOMEM, max_order;
+	/*
+	 * True if the PMU needs a contiguous AUX buffer (CAP_AUX_NO_SG) or
+	 * prefers large contiguous pages (CAP_AUX_PREFER_LARGE).
+	 */
+	bool use_contiguous_pages = event->pmu->capabilities & (
+		PERF_PMU_CAP_AUX_NO_SG | PERF_PMU_CAP_AUX_PREFER_LARGE);
+	/*
+	 * Initialize max_order to 0 for page allocation. This allocates single
+	 * pages to minimize memory fragmentation. This is overriden if
+	 * use_contiguous_pages is true.
+	 */
+	int max_order = 0;
+	int ret = -ENOMEM;
 
 	if (!has_aux(event))
 		return -EOPNOTSUPP;
@@ -689,8 +701,8 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
 
 	if (!overwrite) {
 		/*
-		 * Watermark defaults to half the buffer, and so does the
-		 * max_order, to aid PMU drivers in double buffering.
+		 * Watermark defaults to half the buffer, to aid PMU drivers
+		 * in double buffering.
 		 */
 		if (!watermark)
 			watermark = min_t(unsigned long,
@@ -698,16 +710,19 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
 					  (unsigned long)nr_pages << (PAGE_SHIFT - 1));
 
 		/*
-		 * Use aux_watermark as the basis for chunking to
-		 * help PMU drivers honor the watermark.
+		 * If using contiguous pages, use aux_watermark as the basis
+		 * for chunking to help PMU drivers honor the watermark.
 		 */
-		max_order = get_order(watermark);
+		if (use_contiguous_pages)
+			max_order = get_order(watermark);
 	} else {
 		/*
-		 * We need to start with the max_order that fits in nr_pages,
-		 * not the other way around, hence ilog2() and not get_order.
+		 * If using contiguous pages, we need to start with the
+		 * max_order that fits in nr_pages, not the other way around,
+		 * hence ilog2() and not get_order.
 		 */
-		max_order = ilog2(nr_pages);
+		if (use_contiguous_pages)
+			max_order = ilog2(nr_pages);
 		watermark = 0;
 	}
 
-- 
2.49.0.1045.g170613ef41-goog

