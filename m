Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39147606A69C
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39147606A69C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=B6Gh8MFl
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-154e9d2d94fso3150935c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 14:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795212899; x=1795817699; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E8k+o+ctljOL+bzUAmsIZZdgRgScMxCPCtfkJ2IOmSg=;
        b=B6Gh8MFloYS3OkJ9Xel03+2QP6ydBx6auuTANtYs7U9AL0Gqq0AYHy48Qpx0mJWS0h
         wgrThcW0PC+KpqjcFGK8jU6oupk4wH+AuGMV3GPxSUs9aoQvZwwpkTdLpsfC94Hv5XHL
         dHhCpYnWm6IPY/7/XpS0q7DSGxSGUlbJFbPWolzfEAheuFs037qmlL5eSb/IbvHJXaT+
         be7JK2cvMkrUe+yQL19d7zUzZ3crDwSN+mVUksh/hQjcO/rqYrVY9alHY0NgBktwN4Av
         LiQoYlSYFK1h7FwesvGCl9nHhyB/6OUHTVplIwqxLDCWp7QR2lQAMGPZBM1XdhqV4GcA
         MF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795212899; x=1795817699;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E8k+o+ctljOL+bzUAmsIZZdgRgScMxCPCtfkJ2IOmSg=;
        b=Jb+/lxSXn6IBoHdJXjVG/Lk1pejerdC26yI7jRypUG+2gtekF4aw8Y6MaHoQxbfEWF
         KD6yLiR6v+6uqS1oPpSf3DBU161jp+x2E9Qh1IIfidhqfCiwnF3icGNm3ZniAZgfSJFI
         2EJkR+sH4UO4LodclhPz3Ham+fsV4XuGExOHPUJOlTyXwajLfqS1EiVwEwkzgzxuoahN
         BmZ1Qdrc1TiyUdb3upCFB41xd5xr7dmx0q+2wxWcGMIXEHJf4GMfCiLYNx/ifzh1jLQB
         V3E5WFA+A7Pee2CwHpa2GtaY8+I79zkN3FFl+Lv2PJSpfDYkkXHiENyHkRFqsVAOAr8d
         1big==
X-Gm-Message-State: APuU4Z8LUaH3o1dXO8261yto4tMdEFk7UtyOUwRiumgmeL2ELm/tyi6I
	fTMfdEFgMYjl3nj1SJOayukFREzA4qpyPf/3okh6yXhkkYZ8vSBntG+n3tyD+VZSnuyxE30RPW1
	ZjOa5dJYWuw==
X-Received: from dlam22-n1.prod.google.com ([2002:a05:701b:2096:10b0:1b5:345d:ed30])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4555:20b0:190:8f72:445e
 with SMTP id a92af1059eb24-1b556877915mr4836441c88.11.1795212899053; Fri, 20
 Nov 2026 14:14:59 -0800 (PST)
Date: Fri, 20 Nov 2026 14:13:18 -0800
In-Reply-To: <20261120221332.2245191-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261120221332.2245191-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120221332.2245191-18-irogers@google.com>
Subject: [PATCH v3 17/30] perf dwarf-regs: Add e_machine__same_arch()
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The 32-bit and 64-bit variants of some architectures have different ELF
machines, such as EM_386 and EM_X86_64, while others, such as RISC-V,
MIPS and PA-RISC, use one ELF machine for both. Code wanting to know if
two ELF machines are the same architecture either normalized the ELF
machine itself, as in pmu_events_map__e_machine_matches(), or compared
the strings from perf_env__arch(). perf_env__arch() maps EM_386 and
EM_X86_64 to "x86", but distinguishes "riscv" and "riscv64", "mips" and
"mips64", and "parisc" and "parisc64" by whether the kernel is 64-bit,
and computing it requires string lookups.

Add e_machine__64bit(), giving the ELF machine of the 64-bit variant of
an architecture, and e_machine__same_arch() next to EM_HOST. EM_ARM and
EM_AARCH64 remain distinct architectures. Use them when matching
pmu-events tables and in is_pmu_core_len(), which compares a perf_env's
architecture with the host's.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/empty-pmu-events.c |  6 +---
 tools/perf/pmu-events/jevents.py         |  6 +---
 tools/perf/util/include/dwarf-regs.h     | 37 ++++++++++++++++++++++++
 tools/perf/util/pmu.c                    |  5 +++-
 4 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index 872c6ca6e817..3870356485ef 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -5783,11 +5783,7 @@ int pmu_metrics_table__find_metric(const struct pmu_metrics_table *table,
 static bool pmu_events_map__e_machine_matches(const struct pmu_events_map *map,
 					      uint16_t e_machine)
 {
-	if (e_machine == EM_386)
-		e_machine = EM_X86_64;
-	else if (e_machine == EM_PPC)
-		e_machine = EM_PPC64;
-	return map->e_machine == e_machine;
+	return e_machine__same_arch(map->e_machine, e_machine);
 }
 
 static const struct pmu_events_map *map_for_cpu(struct perf_cpu cpu)
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 802ae2ad4405..6adb385b38e5 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -1201,11 +1201,7 @@ int pmu_metrics_table__find_metric(const struct pmu_metrics_table *table,
 static bool pmu_events_map__e_machine_matches(const struct pmu_events_map *map,
 \t\t\t\t\t      uint16_t e_machine)
 {
-\tif (e_machine == EM_386)
-\t\te_machine = EM_X86_64;
-\telse if (e_machine == EM_PPC)
-\t\te_machine = EM_PPC64;
-\treturn map->e_machine == e_machine;
+\treturn e_machine__same_arch(map->e_machine, e_machine);
 }
 
 static const struct pmu_events_map *map_for_cpu(struct perf_cpu cpu)
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index 1da915c2683a..07f285a94e03 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -85,6 +85,43 @@
   #define EF_HOST 0
 #endif
 
+/**
+ * e_machine__64bit() - The ELF machine of the 64-bit variant of an architecture.
+ * @e_machine: An ELF machine, such as EM_386.
+ *
+ * The 32-bit and 64-bit variants of some architectures have different ELF
+ * machines, for example EM_386 and EM_X86_64, whereas others, like RISC-V,
+ * MIPS and PA-RISC, use the same ELF machine for both. EM_ARM and EM_AARCH64
+ * are considered distinct architectures.
+ *
+ * Return: The 64-bit ELF machine, or @e_machine if there isn't one.
+ */
+static inline uint16_t e_machine__64bit(uint16_t e_machine)
+{
+	switch (e_machine) {
+	case EM_386:
+		return EM_X86_64;
+	case EM_PPC:
+		return EM_PPC64;
+	case EM_SPARC:
+	case EM_SPARC32PLUS:
+		return EM_SPARCV9;
+	default:
+		return e_machine;
+	}
+}
+
+/**
+ * e_machine__same_arch() - Are two ELF machines the same architecture,
+ *                          ignoring differences in word size?
+ * @a: An ELF machine.
+ * @b: Another ELF machine.
+ */
+static inline bool e_machine__same_arch(uint16_t a, uint16_t b)
+{
+	return e_machine__64bit(a) == e_machine__64bit(b);
+}
+
 #define DWARF_REG_PC  0xd3af9c /* random number */
 #define DWARF_REG_FB  0xd3affb /* random number */
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index fc4fa34fcb0d..d319ef8ffbb8 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -34,6 +34,8 @@
 #include "print-events.h"
 #include "hashmap.h"
 #include "header.h"
+#include "dwarf-regs.h"
+#include "env.h"
 #include "string2.h"
 #include "strbuf.h"
 #include "fncache.h"
@@ -2101,7 +2103,8 @@ bool is_pmu_core_len(struct perf_env *env, const char *name, size_t len)
 	 * isn't portable, for example, big.LITTLE ARM and Apple core PMUs are
 	 * named after their CPU rather than "cpu_core" and "cpu_atom".
 	 */
-	if (env && strcmp(perf_env__arch(env), perf_env__arch(/*env=*/NULL))) {
+	if (env && !e_machine__same_arch(perf_env__e_machine(env, /*e_flags=*/NULL),
+					 perf_env__e_machine(host_env(), /*e_flags=*/NULL))) {
 		pr_debug("Can't identify core PMUs of a %s perf.data file recorded without hybrid topology\n",
 			 perf_env__arch(env));
 		return false;
-- 
2.56.1.750.gf70dc682cf-goog

