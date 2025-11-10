Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD2722C32D
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Nov 2025 01:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762738405; cv=none; b=DXj0V2xvgBGOSPEJGLlCVmn6HfCYBG2TiWqEmnI0ixIcsy18Lz/T+hfInGlbDvOJ7qPSYEtW+9ZV7X+G/hWT9VoJ1IpR1U6uUk7qXcqSiOzCPdBAVnfI7CWEddMgaYb1prHoMC1ebQBL4VwhGNv0cYlfYRoozE2RDYvftTi3duA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762738405; c=relaxed/simple;
	bh=okLVEx2Z0nDoWuy9Rr2c630PhagrswsITGTgjHOW3K4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Lp4xKn9hrLdnPQruduhKegyuxRkzJ8KnhRR+/YBjE1k1wHHMNcGePzMztlWExgj0EOeX1As1rrOwPJr2yHZd9j4NWSlMrzlw8+BZFPoeccTzerYRO/KWRCuVumw7rqlb+b0jAKatnpGkb5lHx4ZErQFYLiDbEJ9oCt8RHc3I6us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BSk5508t; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BSk5508t"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2955555f73dso25033555ad.0
        for <linux-perf-users@vger.kernel.org>; Sun, 09 Nov 2025 17:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762738402; x=1763343202; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=myu3L4iks2Z/QSz7cXwMd07OMbyenZ2wKrFbuRIGMWY=;
        b=BSk5508tGOh9qftsBHK6D6RLl8eTF5SbrZmklXNlKPckeGQvG6HMcw2dr8wculifcQ
         NId944ItZVOJkKjc+RhCqJ5rO4HRkxnSOklEBl/TNvELALoyE7fc681hFZGmc+qnqiGr
         tYK/Uuxh5Q79quX2VGlJxIcb5EJk7IoVIH6msdGZOVQktdO4CKFjUM2L+WxQ8geh1n/L
         8xpF9dA/pZqowkiraZjLMxHnNGL1wI1Ptvyn6ADQBnJSLFdVRqCDRXJoL9Wxof7EO1qM
         VVIe/lyMkGSz2SpPUGt/FUdKXRbXQ5eBdaV/SQCuKUbw7mP3CdtixNOFl7LD7lXpNuQo
         52iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762738402; x=1763343202;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=myu3L4iks2Z/QSz7cXwMd07OMbyenZ2wKrFbuRIGMWY=;
        b=ckRZmVJd3+d5yuxaKNLZbPWTNmzqdsXplNwM9EPhrWgk1PpPOIjmdAEHPrO81nlNg2
         LwMnaCqe6CgD19k1Pjgcl3RXZOlAh9YPmM70wAsAd+ijakQ4wWnF3GYMYFqXU1yHRNER
         LOPeQpVzO6TAnJqaM/TwqnVSTo/rfZ7hwAeHpcBCKxZzybkVnsPmvECYhnVcNN0Y/fLX
         l/ca5mhwCng8XuWynfyHn/JnOA53UWKLcR+iRCf+Fa3BCpmCwW0Jlcyc9P6xHtcySTZR
         CAfUv0BIrKYRHsZRnN6ccjtBrHravy5sbj6Nu8IEItWImzrLh43D8xauAQyLrmF5Wb8W
         u5cA==
X-Forwarded-Encrypted: i=1; AJvYcCXNHJf4BtaEYiNgy9HLs71MI2IuB5Td9JZgoSQ+x+9WOeMilTQwkma3iBpcKE7bBJg9r89D0fSBJiomPr2KumQD@vger.kernel.org
X-Gm-Message-State: AOJu0YxExNjRxDbdojm7yR/2qhzhfw591wnh83Y99DBFcku3hX3AqqKs
	BDXwlA4NOKVpgDGJBHmpx+3948eYOk7VJB1sfLmz7mF4qCRJr3S/p7QeU0ehJeNF8n8JI3+LtyF
	GgDRGSwzc+A==
X-Google-Smtp-Source: AGHT+IHL3gZbw6A3j8P4KaKK3OWtqFFb+mIJclikOrQBB+uCPq+icWqCkdpk4pMnmUjkwkO6qL5pm6frwPwo
X-Received: from pjbso2.prod.google.com ([2002:a17:90b:1f82:b0:33b:ab61:4f71])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:dace:b0:295:28a4:f0aa
 with SMTP id d9443c01a7336-297e56cfa6emr79657575ad.43.1762738402046; Sun, 09
 Nov 2025 17:33:22 -0800 (PST)
Date: Sun,  9 Nov 2025 17:31:52 -0800
In-Reply-To: <20251110013152.3099080-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110013152.3099080-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251110013152.3099080-6-irogers@google.com>
Subject: [PATCH v1 5/5] perf auxtrace: Remove errno.h from auxtrace.h and fix
 transitive dependencies
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Tomas Glozar <tglozar@redhat.com>, 
	Quentin Monnet <qmo@kernel.org>, Yuzhuo Jing <yuzhuo@google.com>, Blake Jones <blakejones@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Yeoreum Yun <yeoreum.yun@arm.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Collin Funk <collin.funk1@gmail.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Zecheng Li <zecheng@google.com>, tanze <tanze@kylinos.cn>, 
	Gabriele Monaco <gmonaco@redhat.com>, GuoHan Zhao <zhaoguohan@kylinos.cn>, 
	Markus Elfring <Markus.Elfring@web.de>, Colin Ian King <colin.i.king@gmail.com>, 
	Kan Liang <kan.liang@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

errno.h isn't used in auxtrace.h so remove it and fix build failures
caused by transitive dependencies through auxtrace.h on errno.h.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm/annotate/instructions.c   | 1 +
 tools/perf/arch/arm/util/auxtrace.c           | 1 +
 tools/perf/arch/arm64/annotate/instructions.c | 1 +
 tools/perf/arch/arm64/util/arm-spe.c          | 1 +
 tools/perf/arch/arm64/util/hisi-ptt.c         | 1 +
 tools/perf/arch/powerpc/util/auxtrace.c       | 2 +-
 tools/perf/arch/s390/util/auxtrace.c          | 1 +
 tools/perf/arch/x86/tests/topdown.c           | 1 +
 tools/perf/arch/x86/util/topdown.c            | 1 +
 tools/perf/bench/evlist-open-close.c          | 1 +
 tools/perf/bench/futex.c                      | 1 +
 tools/perf/bench/pmu-scan.c                   | 1 +
 tools/perf/bench/synthesize.c                 | 1 +
 tools/perf/builtin-mem.c                      | 1 +
 tools/perf/tests/hwmon_pmu.c                  | 1 +
 tools/perf/tests/parse-metric.c               | 1 +
 tools/perf/tests/pfm.c                        | 1 +
 tools/perf/ui/hist.c                          | 1 +
 tools/perf/util/annotate-data.c               | 2 +-
 tools/perf/util/auxtrace.h                    | 1 -
 tools/perf/util/bpf-filter.h                  | 2 ++
 tools/perf/util/bpf-trace-summary.c           | 1 +
 tools/perf/util/bpf_counter_cgroup.c          | 1 +
 tools/perf/util/bpf_ftrace.c                  | 3 ++-
 tools/perf/util/bpf_map.c                     | 1 +
 tools/perf/util/cgroup.c                      | 1 +
 tools/perf/util/drm_pmu.c                     | 1 +
 tools/perf/util/evswitch.c                    | 1 +
 tools/perf/util/intel-tpebs.c                 | 1 +
 tools/perf/util/kvm-stat.h                    | 1 +
 tools/perf/util/mmap.c                        | 1 +
 tools/perf/util/pfm.c                         | 1 +
 tools/perf/util/powerpc-vpadtl.c              | 1 +
 tools/perf/util/stat-shadow.c                 | 1 +
 34 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/tools/perf/arch/arm/annotate/instructions.c b/tools/perf/arch/arm/annotate/instructions.c
index cf91a43362b0..5e667b0f5512 100644
--- a/tools/perf/arch/arm/annotate/instructions.c
+++ b/tools/perf/arch/arm/annotate/instructions.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/compiler.h>
 #include <linux/zalloc.h>
+#include <errno.h>
 #include <sys/types.h>
 #include <regex.h>
 #include <stdlib.h>
diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
index 3b8eca0ffb17..eb6404267f17 100644
--- a/tools/perf/arch/arm/util/auxtrace.c
+++ b/tools/perf/arch/arm/util/auxtrace.c
@@ -5,6 +5,7 @@
  */
 
 #include <dirent.h>
+#include <errno.h>
 #include <stdbool.h>
 #include <linux/coresight-pmu.h>
 #include <linux/zalloc.h>
diff --git a/tools/perf/arch/arm64/annotate/instructions.c b/tools/perf/arch/arm64/annotate/instructions.c
index d465d093e7eb..16cb62d40bd9 100644
--- a/tools/perf/arch/arm64/annotate/instructions.c
+++ b/tools/perf/arch/arm64/annotate/instructions.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/compiler.h>
+#include <errno.h>
 #include <sys/types.h>
 #include <regex.h>
 #include <stdlib.h>
diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index cac43cde7dbe..d5ec1408d0ae 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -10,6 +10,7 @@
 #include <linux/log2.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
+#include <errno.h>
 #include <time.h>
 
 #include "../../../util/cpumap.h"
diff --git a/tools/perf/arch/arm64/util/hisi-ptt.c b/tools/perf/arch/arm64/util/hisi-ptt.c
index eac9739c87e6..fe457fd58c9e 100644
--- a/tools/perf/arch/arm64/util/hisi-ptt.c
+++ b/tools/perf/arch/arm64/util/hisi-ptt.c
@@ -9,6 +9,7 @@
 #include <linux/bitops.h>
 #include <linux/log2.h>
 #include <linux/zalloc.h>
+#include <errno.h>
 #include <time.h>
 
 #include <internal/lib.h> // page_size
diff --git a/tools/perf/arch/powerpc/util/auxtrace.c b/tools/perf/arch/powerpc/util/auxtrace.c
index 62c6f67f1bbe..292ea335e4ff 100644
--- a/tools/perf/arch/powerpc/util/auxtrace.c
+++ b/tools/perf/arch/powerpc/util/auxtrace.c
@@ -2,7 +2,7 @@
 /*
  * VPA support
  */
-
+#include <errno.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/string.h>
diff --git a/tools/perf/arch/s390/util/auxtrace.c b/tools/perf/arch/s390/util/auxtrace.c
index 5068baa3e092..1a3676145066 100644
--- a/tools/perf/arch/s390/util/auxtrace.c
+++ b/tools/perf/arch/s390/util/auxtrace.c
@@ -1,3 +1,4 @@
+#include <errno.h>
 #include <stdbool.h>
 #include <stdlib.h>
 #include <linux/kernel.h>
diff --git a/tools/perf/arch/x86/tests/topdown.c b/tools/perf/arch/x86/tests/topdown.c
index 1eba3b4594ef..3ee4e5e71be3 100644
--- a/tools/perf/arch/x86/tests/topdown.c
+++ b/tools/perf/arch/x86/tests/topdown.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
 #include "arch-tests.h"
 #include "../util/topdown.h"
 #include "debug.h"
diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
index 0d01b662627a..bafd285119d7 100644
--- a/tools/perf/arch/x86/util/topdown.c
+++ b/tools/perf/arch/x86/util/topdown.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
 #include "util/evlist.h"
 #include "util/pmu.h"
 #include "util/pmus.h"
diff --git a/tools/perf/bench/evlist-open-close.c b/tools/perf/bench/evlist-open-close.c
index bfaf50e4e519..faf9c34b4a5d 100644
--- a/tools/perf/bench/evlist-open-close.c
+++ b/tools/perf/bench/evlist-open-close.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
 #include <inttypes.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/tools/perf/bench/futex.c b/tools/perf/bench/futex.c
index 1481196a22f0..1968c9d00b5b 100644
--- a/tools/perf/bench/futex.c
+++ b/tools/perf/bench/futex.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <err.h>
+#include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/prctl.h>
diff --git a/tools/perf/bench/pmu-scan.c b/tools/perf/bench/pmu-scan.c
index 9e4d36486f62..14a464ad8cea 100644
--- a/tools/perf/bench/pmu-scan.c
+++ b/tools/perf/bench/pmu-scan.c
@@ -4,6 +4,7 @@
  *
  * Copyright 2023 Google LLC.
  */
+#include <errno.h>
 #include <stdio.h>
 #include "bench.h"
 #include "util/debug.h"
diff --git a/tools/perf/bench/synthesize.c b/tools/perf/bench/synthesize.c
index b3d493697675..265d49a913d9 100644
--- a/tools/perf/bench/synthesize.c
+++ b/tools/perf/bench/synthesize.c
@@ -6,6 +6,7 @@
  *
  * Copyright 2019 Google LLC.
  */
+#include <errno.h>
 #include <stdio.h>
 #include "bench.h"
 #include "../util/debug.h"
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index c6496adff3fe..d43500b92a7b 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
 #include <inttypes.h>
 #include <sys/types.h>
 #include <sys/stat.h>
diff --git a/tools/perf/tests/hwmon_pmu.c b/tools/perf/tests/hwmon_pmu.c
index 151f02701c8c..4aa4aac94f09 100644
--- a/tools/perf/tests/hwmon_pmu.c
+++ b/tools/perf/tests/hwmon_pmu.c
@@ -4,6 +4,7 @@
 #include "hwmon_pmu.h"
 #include "parse-events.h"
 #include "tests.h"
+#include <errno.h>
 #include <fcntl.h>
 #include <sys/stat.h>
 #include <linux/compiler.h>
diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 66a5275917e2..9b1df1eb455a 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/compiler.h>
+#include <errno.h>
 #include <string.h>
 #include <perf/cpumap.h>
 #include <perf/evlist.h>
diff --git a/tools/perf/tests/pfm.c b/tools/perf/tests/pfm.c
index 2e38dfa34b6c..fca4a86452df 100644
--- a/tools/perf/tests/pfm.c
+++ b/tools/perf/tests/pfm.c
@@ -4,6 +4,7 @@
  *
  * Copyright 2020 Google LLC.
  */
+#include <errno.h>
 #include "tests.h"
 #include "util/debug.h"
 #include "util/evlist.h"
diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index b085eb0de849..e58327595d37 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
 #include <inttypes.h>
 #include <math.h>
 #include <stdlib.h>
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index e183c6104d59..07cf9c334be0 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -4,7 +4,7 @@
  *
  * Written by Namhyung Kim <namhyung@kernel.org>
  */
-
+#include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <inttypes.h>
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 59cf72b935ff..eee2c11f7666 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -7,7 +7,6 @@
 #ifndef __PERF_AUXTRACE_H
 #define __PERF_AUXTRACE_H
 
-#include <errno.h>
 #include <stdio.h> // FILE
 #include <linux/perf_event.h>
 #include <linux/types.h>
diff --git a/tools/perf/util/bpf-filter.h b/tools/perf/util/bpf-filter.h
index 122477f2de44..818c554b91b2 100644
--- a/tools/perf/util/bpf-filter.h
+++ b/tools/perf/util/bpf-filter.h
@@ -36,6 +36,8 @@ int perf_bpf_filter__unpin(void);
 
 #else /* !HAVE_BPF_SKEL */
 
+#include <errno.h>
+
 static inline int perf_bpf_filter__parse(struct list_head *expr_head __maybe_unused,
 					 const char *str __maybe_unused)
 {
diff --git a/tools/perf/util/bpf-trace-summary.c b/tools/perf/util/bpf-trace-summary.c
index 8dfe7e678941..cf6e1e4402d5 100644
--- a/tools/perf/util/bpf-trace-summary.c
+++ b/tools/perf/util/bpf-trace-summary.c
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#include <errno.h>
 #include <inttypes.h>
 #include <math.h>
 #include <stdio.h>
diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
index 68bd994c8880..17d7196c6589 100644
--- a/tools/perf/util/bpf_counter_cgroup.c
+++ b/tools/perf/util/bpf_counter_cgroup.c
@@ -4,6 +4,7 @@
 /* Copyright (c) 2021 Google */
 
 #include <assert.h>
+#include <errno.h>
 #include <limits.h>
 #include <unistd.h>
 #include <sys/file.h>
diff --git a/tools/perf/util/bpf_ftrace.c b/tools/perf/util/bpf_ftrace.c
index e61a3b20be0a..c456d24efa30 100644
--- a/tools/perf/util/bpf_ftrace.c
+++ b/tools/perf/util/bpf_ftrace.c
@@ -1,6 +1,7 @@
-#include <stdio.h>
+#include <errno.h>
 #include <fcntl.h>
 #include <stdint.h>
+#include <stdio.h>
 #include <stdlib.h>
 
 #include <bpf/bpf.h>
diff --git a/tools/perf/util/bpf_map.c b/tools/perf/util/bpf_map.c
index 578f27d2d6b4..442f91b4e8e1 100644
--- a/tools/perf/util/bpf_map.c
+++ b/tools/perf/util/bpf_map.c
@@ -5,6 +5,7 @@
 #include <bpf/libbpf.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
+#include <errno.h>
 #include <stdbool.h>
 #include <stdlib.h>
 #include <unistd.h>
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 25e2769b5e74..040eb75f0804 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -10,6 +10,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/statfs.h>
+#include <errno.h>
 #include <fcntl.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/tools/perf/util/drm_pmu.c b/tools/perf/util/drm_pmu.c
index 98d4d2b556d4..b3052266d599 100644
--- a/tools/perf/util/drm_pmu.c
+++ b/tools/perf/util/drm_pmu.c
@@ -10,6 +10,7 @@
 #include <api/io.h>
 #include <ctype.h>
 #include <dirent.h>
+#include <errno.h>
 #include <fcntl.h>
 #include <unistd.h>
 #include <linux/unistd.h>
diff --git a/tools/perf/util/evswitch.c b/tools/perf/util/evswitch.c
index 40cb56a9347d..d4c06a3f825a 100644
--- a/tools/perf/util/evswitch.c
+++ b/tools/perf/util/evswitch.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 // Copyright (C) 2019, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
 
+#include <errno.h>
 #include "evswitch.h"
 #include "evlist.h"
 
diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 21359155f2a0..3c958d738ca6 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -25,6 +25,7 @@
 #include "stat.h"
 #include <sys/stat.h>
 #include <sys/file.h>
+#include <errno.h>
 #include <poll.h>
 #include <math.h>
 
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index 53db3d56108b..a356b839c2ee 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -10,6 +10,7 @@
 #include "symbol.h"
 #include "record.h"
 
+#include <errno.h>
 #include <stdlib.h>
 #include <linux/zalloc.h>
 
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index a34726219af3..b69f926d314b 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -7,6 +7,7 @@
  */
 
 #include <sys/mman.h>
+#include <errno.h>
 #include <inttypes.h>
 #include <asm/bug.h>
 #include <linux/zalloc.h>
diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
index e5b3a2a5ddef..d9043f4afbe7 100644
--- a/tools/perf/util/pfm.c
+++ b/tools/perf/util/pfm.c
@@ -15,6 +15,7 @@
 #include "util/strbuf.h"
 #include "util/thread_map.h"
 
+#include <errno.h>
 #include <string.h>
 #include <linux/kernel.h>
 #include <perfmon/pfmlib_perf_event.h>
diff --git a/tools/perf/util/powerpc-vpadtl.c b/tools/perf/util/powerpc-vpadtl.c
index bfa4156d7a97..d1c3396f182f 100644
--- a/tools/perf/util/powerpc-vpadtl.c
+++ b/tools/perf/util/powerpc-vpadtl.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/string.h>
+#include <errno.h>
 #include <inttypes.h>
 #include "color.h"
 #include "evlist.h"
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index abaf6b579bfc..0002e51194c2 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
 #include <math.h>
 #include <stdio.h>
 #include "evsel.h"
-- 
2.51.2.1041.gc1ab5b90ca-goog

