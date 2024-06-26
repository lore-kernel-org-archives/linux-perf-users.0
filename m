Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A061946CB
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 20:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434219; cv=none; b=glemYNdJEoBy9HI5XFIBpyrWLjhxftvZXCiGUfHssMQuy1kTiHOCj18w89jXX52grs+JW5nNaR0/KilJaKj1OdldlWQYec9GiwPnzd5LhM/GYRJqhfk/R/ABGBdnrB0sr1/0pu0drMUKc0IEPRVAhXyhndw5lbPt+Uy5197eT+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434219; c=relaxed/simple;
	bh=4f3xu/fTKlsZKLAxp35O5+huY8NAWRnMLMbKlqWg7eI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=U3N5WTMLqL6kzRB5GU/WIkBAsT+3R/TvVwxuC0nZTcHZsjlmCQWCAefPK12PL8JOqAQrVDxXwXlKbhKDtkq60ARsJKKxKex+5VKnvlGFjU6Hr1t0o2qQ58AP7BwYLZBgMmKs2Xc/KMZxZ9FmXR/Vc6ClcfK7Yt46bpsiVH4mqpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D8nQ9t2K; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D8nQ9t2K"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-63548741556so129700547b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 13:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719434217; x=1720039017; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0D3Ll4YJxFSzRg0DxL5KKZwtYxMwAkaxOfW7jAWfCz0=;
        b=D8nQ9t2KlplFxvgJ8GJC/4h+pfRCxk+rOQxuOQ+/3ctJfIocoRLgsq6e3L3jR+cqX9
         HZpuDmwpaDwHAwvbZgfPmo4CANnfihgoRPN0+mL5JVdMq1nJGkjViHvdMM+O4+QPQeld
         Uwvd+pPU8e0rcvaFeDO6EnGS1qYzpnnvMaEMW516KLbozmmOXjwrj4unUqc2Wl9LwoqW
         duLevl4i4NxDmlM1viLqmfuoj+5PDUbpu54rgD9CofkiNnSysPCw7bgfQfUbXEZn/nS6
         NBkvfd9o9PGWtSnLf/PR3SrMBgCitghoEfydEIv+/l+tbdX7JlxtwHH1kBQkLRAOER56
         XLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434217; x=1720039017;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0D3Ll4YJxFSzRg0DxL5KKZwtYxMwAkaxOfW7jAWfCz0=;
        b=dU3TRmYrLNSfvjZPwDt1ORBmCTdPbv6ErBva2ccp1EeKAa3nnKEHDEG+TDDZIMuaOq
         h9k6jEeSh9eAB3/MPdUQbRqzGZudGYwc1+9jfRxxlI+sCtjeT5mpmvJ6bONOTDV3v1uD
         pn2bD/leG9dZD3AwmDNTbgTMRL4A0hRg6p+L3N7SJPcUsl83nSbbpXqw+1XvInmDibOv
         aEWk0V/IZp4DDiE6IVY0UuLrdp3QsvK2kXyQBedwOjdJYEiRnJ/fibonYjKViD+gYons
         YpIIZaPx17RfBlcRTKfcZnaToCN1FE9n4IHaza7im7pd3C5B6G6l5cXLIOKGLUH/VImM
         e/hA==
X-Forwarded-Encrypted: i=1; AJvYcCUNvOH6+Egq8uvf+eoFQ6IA2UxhoxmGJZAss+q3w62qNey3st4A3GEE/kMFkdeslDI6pQIZ3M6P3USdAl4ZgsRNShGenm2AHHO+gb5EhUdBCw==
X-Gm-Message-State: AOJu0YyRxYGLVOXJm6JwYlpBLmfaj8jykE8Wrq/+G2G8owKz1D1uD2pq
	W6nHwhsQXjnGrfvJXTBmkvFdVE1chG/0211XQ+4vLHpSrPpve2MQyN9YM81efV/+kjbtvGadOZR
	3puIQ9w==
X-Google-Smtp-Source: AGHT+IFuUkZI1xUb4dQtuVFreG6sSaXi+9c/mJnE0USxl2dca1+VIZOjUXTn6HLYlU8i1RaN2vfEqGJqEkiE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a05:690c:3602:b0:62d:a29:53a0 with SMTP id
 00721157ae682-6434041982bmr1581297b3.7.1719434217307; Wed, 26 Jun 2024
 13:36:57 -0700 (PDT)
Date: Wed, 26 Jun 2024 13:36:10 -0700
In-Reply-To: <20240626203630.1194748-1-irogers@google.com>
Message-Id: <20240626203630.1194748-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626203630.1194748-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v2 08/27] perf kvm: Use perf_tool__init
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Use perf_tool__init so that more uses of struct perf_tool can be const
and not relying on perf_tool__fill_defaults.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kvm.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index a3b903cf4311..692267b1b7e8 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1603,19 +1603,17 @@ static int read_events(struct perf_kvm_stat *kvm)
 {
 	int ret;
 
-	struct perf_tool eops = {
-		.sample			= process_sample_event,
-		.comm			= perf_event__process_comm,
-		.namespaces		= perf_event__process_namespaces,
-		.ordered_events		= true,
-	};
 	struct perf_data file = {
 		.path  = kvm->file_name,
 		.mode  = PERF_DATA_MODE_READ,
 		.force = kvm->force,
 	};
 
-	kvm->tool = eops;
+	perf_tool__init(&kvm->tool, /*ordered_events=*/true);
+	kvm->tool.sample	= process_sample_event;
+	kvm->tool.comm		= perf_event__process_comm;
+	kvm->tool.namespaces	= perf_event__process_namespaces;
+
 	kvm->session = perf_session__new(&file, &kvm->tool);
 	if (IS_ERR(kvm->session)) {
 		pr_err("Initializing perf session failed\n");
@@ -1919,14 +1917,13 @@ static int kvm_events_live(struct perf_kvm_stat *kvm,
 
 
 	/* event handling */
+	perf_tool__init(&kvm->tool, /*ordered_events=*/true);
 	kvm->tool.sample = process_sample_event;
 	kvm->tool.comm   = perf_event__process_comm;
 	kvm->tool.exit   = perf_event__process_exit;
 	kvm->tool.fork   = perf_event__process_fork;
 	kvm->tool.lost   = process_lost_event;
 	kvm->tool.namespaces  = perf_event__process_namespaces;
-	kvm->tool.ordered_events = true;
-	perf_tool__fill_defaults(&kvm->tool);
 
 	/* set defaults */
 	kvm->display_time = 1;
-- 
2.45.2.741.gdbec12cfda-goog

