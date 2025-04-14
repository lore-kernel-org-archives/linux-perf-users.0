Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6909A289374
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Apr 2025 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744652519; cv=none; b=YbC3bXdT4FBwbl9iMlt/UlQdvLG/VqVkT54xvJB63oPd2+GrEQoWrueNArak4eAe50A1gCNGBrMRnUoV7j5AY72rvBLj0solPQkj8fSsGHSuF3CHwEjCYST3QkFF0hXBM8EBtu0kWpxfvx3ZbUutlAU/fIODDFcqnGfjIvmZRao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744652519; c=relaxed/simple;
	bh=slHe5WC35Qo1w8hHbLkGv/83Qna2F02lahPNQerHbw8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=dXf3G587rdb3dTefJYzMhZCeKZBsesleCjLXYuSpfJtKvH8i2rdr++s2OA1nvjQEXXqkY1DR/XEx0daHoFArm0m11V4nwDlQ/JWDPmIYEcEnJyFi1FLV72A+Myau6eMivq5qLYbHoN81gX1AmvKNrRW9F08jz76xEcMtHWvIxws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I0TQkECW; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I0TQkECW"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3054210ce06so6123726a91.2
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Apr 2025 10:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744652517; x=1745257317; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zlPSRtvb4/+TTghxrsueo1A3tWRb8o4F7DCTI51/qHU=;
        b=I0TQkECWxjPav8Enyn6SYKgmiZPcbhR8KsVmlwKtnZ1IQRVJ7kV8sdPgZEvhdHXwZJ
         BDVQbgC07kDmr2PTenKAi58lc3cgcfTJLg7Bcc/P0n5j7qvOrVFmaBdJ8iIKPzC/Oy+I
         z1HGLQ5hB+GWLlJwudWR98a/WI8vHYYu8ZhRPaD4Vfmnkwpqc1YG8345pUzDZZ7GcPIo
         t/GZZDaJ0uTFPf8h+dE12LUiL9VaSUiUPh/sXbVJ6maWZ125SvGeiW30ZrCOswNmqxiD
         c9Xt7t63AZr7H+6gxGPOjejDygzKE1V/KOvncgOrL2jXBv5ipvxwSi8cS7cWoXbMj0GB
         HHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744652517; x=1745257317;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zlPSRtvb4/+TTghxrsueo1A3tWRb8o4F7DCTI51/qHU=;
        b=Sz5ty3Ybnqqm13LbuhgggQq6/Ue7192OpYRSXWQr4WGvPKi2vMYUw7h/uSk40JiJ1a
         b3XvRX/JhOyd68YVzsjCvjzpK5lwrrw56Gd6cUxYeGSEvR9az+Hvv5qMTDuV1OmhOaQH
         Ky8TAhRNVv5yXI8Ap5Yzmi7RLmI2Z0Na+azSGFmdzB6kC1Ms4BuADoftSk5ybkvpkOxr
         rPOuY/xIwboEtgV5bvXxC7VazyfnE7SnBNewMrhTYiMWs66cL7mA29aMLF1Gk0eSghTQ
         sRph1xk+L/+3Im66q+q/+dDCKk/fgvxgtbl7KzdRIkwZJliKgOX9l5UHaDoXEKLlnEWa
         AGzQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6gS86uYFQ3G1NweowcfB4rgaLqLqzSckVbFTjlRWPlraiyHn/9KFGeBxI/gdsgZA1WND8QhlnSEM3YGRfyfd+@vger.kernel.org
X-Gm-Message-State: AOJu0YxXmEOA703VQhNEZkUDF3EXEBEqGYSsCtprlXiK8a6ths6EMvBG
	ZayWkOsHzF41eH4/CdhbvQhZhbHfcts2cmQdbfADBJ+e5QU/CZcDPsIBlLAvJo14XG7ssHoLMOJ
	77xrTTw==
X-Google-Smtp-Source: AGHT+IH9rV1O8BX4TziERNYAHUqTWDiePpMXRosCaFe8xB6DJ3X2Nfbl3Vec8TG/UcvWizJkMElzLTcdYlym
X-Received: from pjbpl17.prod.google.com ([2002:a17:90b:2691:b0:2f7:d453:e587])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:dfc4:b0:306:b593:4557
 with SMTP id 98e67ed59e1d1-30823633eb7mr16671483a91.4.1744652517625; Mon, 14
 Apr 2025 10:41:57 -0700 (PDT)
Date: Mon, 14 Apr 2025 10:41:19 -0700
In-Reply-To: <20250414174134.3095492-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414174134.3095492-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250414174134.3095492-2-irogers@google.com>
Subject: [PATCH v5 01/16] perf intel-tpebs: Cleanup header
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

Remove arch conditional compilation. Arch conditional compilation
belongs in the arch/ directory.

Tidy header guards to match other files. Remove unneeded includes and
switch to forward declarations when necesary.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Weilin Wang <weilin.wang@intel.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
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
2.49.0.604.gff1f9ca942-goog

