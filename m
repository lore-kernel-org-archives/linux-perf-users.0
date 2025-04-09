Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AC31DDC04
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Apr 2025 06:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744179057; cv=none; b=pv7zVhp3nwTaywpuVWlLWCw8l0+27tACY+LxqG36wFBGVe5qxBki+eUnl5b4nkKq50zn92clSXiw3dNFC6MMtKOKVpSNMDxVaOHlZ6RsaqdJGzFPL60JMz1lUTTkoArdw2HWygtVx4EHB1vRg1d88oG32uMgF62JHI5z/TAa89A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744179057; c=relaxed/simple;
	bh=oTGRBpcL/2sIHNUD+/BM6BV/LmnMI5XK3yo3xDS6KyQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=fMXSHCyzyoOBypaATP8dZXxyTYYL7HPlzTangxzm7rm2uV1n8fnZOsWxDIexIsht7ysekFdtM/ZP7n6Klo4Tvt6qCRVlik/LYbOnyhqteVHGUYIp2X3//HvAO/QZJQeQkH/Nwn5ss0iUdSgMmwYKgr+Meit9krRZoKxq4NoJreo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=utc5F+p5; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="utc5F+p5"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-225429696a9so90813955ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Apr 2025 23:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744179054; x=1744783854; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pClnDyLnT+OkOC5ziZK4pcS5wTXzmuK+3iocOmka5vs=;
        b=utc5F+p5i8vGgDi7rk2VOnkRn2aBXxGKW0y0hlcIOKmS6h9rFaCVAp5mXDPNj4dYy0
         QK+w0IzcgZfmjWjJhn58gozjTMjwtLbUSuWazE2cMhezg57AT5pNiP6vxPAkDMJvFOr8
         dLi60j4BzYhvbk8uUege1ntniM4wSq1Rwqb0OqcMgj3XIgfjgKF4s3kLVPMHRdmGJ7g3
         7B+R04sIgUfNWRbrlLzmc36knsx2QkB5HuYCh7K8EfAz2l7FrXds5r2cGhowwDYT32Zq
         GNpPd+91DsZpK/jYvfa1q5jC7WiPa59v1kvfagiZGdstBVvmlMscl1ouYxcivWH1t8mG
         xhJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744179054; x=1744783854;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pClnDyLnT+OkOC5ziZK4pcS5wTXzmuK+3iocOmka5vs=;
        b=oT9cxhLCHymB4N/ZnbSAGm426c+Nfb1vFhPqBo+528qJnC1AC4G/sqchzZbThQ8ffj
         uRVMhvbcb3J0ZKUA5yXIE2q6Di2VHYiRiEzxLREwTLK8f7rVW31chQXMJoBsqHZ/8saN
         7dmEX2XZ/LlzOmnvaAOZ8VowCGLH/98hrXuLM/12e79Jvd+bXpVy6jKxoaUbyplr+2Gg
         kSZmLDyKZ9W66mlY4UtGvnlx8B8s+kUOdg8Ko/IW1rDaaiQAucUjQrGveFQnLHakTl7z
         3KHoUV0IktsdwO2WDSMNCM1qlVVpiNdTxHydS4HT9Ruezy7Ph76K81UrUuteSkSPoQVU
         fFYA==
X-Forwarded-Encrypted: i=1; AJvYcCVSlGdHBCWrD6pJ/L/pVdpAOm5RsqddgHfhI8wBekKZdvLPH76ktOqn/MHis4ndvHukPh9nrXHm/60e8Uz6Yc9Y@vger.kernel.org
X-Gm-Message-State: AOJu0YybH3NuWZ5cxM3MV4ZTnx5auw8y4x9GKplZIk3b85B5XSFphcod
	fkPJQbVBLCRDXnQKDP7v2Ke6jeUSpBVcMaMnVpJa74rW5myDy79AQyrPAkr7P+/eMrZtaSCWtjE
	9Hi6h/A==
X-Google-Smtp-Source: AGHT+IHJ7OZd30Pwnp9LWB65mMC8ePjlrwbBobAW63Dt1IVdQiKqKLmW2rrxhqIOsCAyzqlVhIjp4+dUdqxj
X-Received: from pjtu11.prod.google.com ([2002:a17:90a:c88b:b0:2f4:4222:ebba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2acd:b0:21f:1202:f2f5
 with SMTP id d9443c01a7336-22ac3f2dd64mr17492915ad.8.1744179054277; Tue, 08
 Apr 2025 23:10:54 -0700 (PDT)
Date: Tue,  8 Apr 2025 23:10:28 -0700
In-Reply-To: <20250409061043.700792-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250409061043.700792-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250409061043.700792-2-irogers@google.com>
Subject: [PATCH v4 01/16] perf intel-tpebs: Cleanup header
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	John Garry <john.g.garry@oracle.com>, Howard Chu <howardchu95@gmail.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Remove arch conditional compilation. Arch conditional compilation
belongs in the arch/ directory.

Tidy header guards to match other files. Remove unneeded includes and
switch to forward declarations when necesary.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build         |  2 +-
 tools/perf/util/intel-tpebs.c |  1 +
 tools/perf/util/intel-tpebs.h | 30 ++++++------------------------
 3 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 946bce6628f3..815274b199fd 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -161,7 +161,7 @@ perf-util-y += clockid.o
 perf-util-y += list_sort.o
 perf-util-y += mutex.o
 perf-util-y += sharded_mutex.o
-perf-util-$(CONFIG_X86_64) += intel-tpebs.o
+perf-util-y += intel-tpebs.o
 
 perf-util-$(CONFIG_LIBBPF) += bpf_map.o
 perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf_counter.o
diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 2c421b475b3b..3503da28a12f 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -19,6 +19,7 @@
 #include "tool.h"
 #include "cpumap.h"
 #include "metricgroup.h"
+#include "stat.h"
 #include <sys/stat.h>
 #include <sys/file.h>
 #include <poll.h>
diff --git a/tools/perf/util/intel-tpebs.h b/tools/perf/util/intel-tpebs.h
index 766b3fbd79f1..63c16e759a71 100644
--- a/tools/perf/util/intel-tpebs.h
+++ b/tools/perf/util/intel-tpebs.h
@@ -2,34 +2,16 @@
 /*
  * intel_tpebs.h: Intel TEPBS support
  */
-#ifndef INCLUDE__PERF_INTEL_TPEBS_H__
-#define INCLUDE__PERF_INTEL_TPEBS_H__
+#ifndef __INTEL_TPEBS_H
+#define __INTEL_TPEBS_H
 
-#include "stat.h"
-#include "evsel.h"
-
-#ifdef HAVE_ARCH_X86_64_SUPPORT
+struct evlist;
+struct evsel;
 
 extern bool tpebs_recording;
+
 int tpebs_start(struct evlist *evsel_list);
 void tpebs_delete(void);
 int tpebs_set_evsel(struct evsel *evsel, int cpu_map_idx, int thread);
 
-#else
-
-static inline int tpebs_start(struct evlist *evsel_list __maybe_unused)
-{
-	return 0;
-}
-
-static inline void tpebs_delete(void) {};
-
-static inline int tpebs_set_evsel(struct evsel *evsel  __maybe_unused,
-				int cpu_map_idx  __maybe_unused,
-				int thread  __maybe_unused)
-{
-	return 0;
-}
-
-#endif
-#endif
+#endif /* __INTEL_TPEBS_H */
-- 
2.49.0.504.g3bcea36a83-goog

