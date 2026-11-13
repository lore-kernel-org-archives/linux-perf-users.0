Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599666;
	b=C3oxuiTYCkS+226cGJechaewNk2UzN97ged1SZcrr9OinTN+LrCrMrrbbfFVOm5EJ1t7
	 ZZeHyTsaityIEzsFpbG53DBVYGvXsHNhmWaBq0pjLqhABrcSo6RPSdl6Izs7Md2HuhW7Y
	 aW6+M9TM/zBHszJDQgxlZ3SG9qn1scELyABRQLJiRRhrw+al/2Uxgj7PqGI+h4m6Qhm6z
	 Qww2ZWh3P1mxlPp80JyDBHZT1uuPErkxCkGXFlVw9AgMx1fOFWXBUfOteYGmAe/3pE/CF
	 9rTGAo1EEp0GGVyNY6Vc0qAUAaqO2ex84ks/rGj0Y/3c7MRA2LtdzwkbNJupw5/b8IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599666;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=xcB4UWhwl3Su1rBSkybUP2clSl1iIAbqP7WKXSblOFI=;
	b=y2sYAmWo9CSP/7ki/CGSbWiAJZWDZhkgQObEidIFtkreGsnvH5kUQXoK9u/UEjuLBUZ7
	 XJ41+xAj9OeaL4vz39uj4TkeHV+RXEDHFk+BjPjSCyYDXO7UCRHsnDQ2HTX9+rDLq7WVV
	 OVQaDYCqhqmlt77JBEi8TJLk3zYeEYM/svIpG2uQKslhZti5DO8tjSZzWjqc9QnWj2+xc
	 YYeit78QUbOzUpTMNiSwa6fmLTHOL/y5PSlJZGVZvp43yWbejGzV0wcTGTETtva10Pamy
	 Ks7G80Pd7tPAXHqZUd/b86TB5RnwmDbrA7otlrRaX7D+NJijcy9vDXYYp/qcJrn9eYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gs6qNmjb;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D7C60A2618
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:54:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21D7C60A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gs6qNmjb
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33713e5e6daso1252960eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 11:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794599664; x=1795204464; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xcB4UWhwl3Su1rBSkybUP2clSl1iIAbqP7WKXSblOFI=;
        b=gs6qNmjbOQu/aeFE1hz2g12hmDiORlVs1UdeABMH2bZ7Vgc3kDzoVjCBXhWHzG9irT
         HsS+dPqc/RUDtumVrio9FhzlNe9VQmwJzfLJ+lWBXjG6XKCVQd2Y/TIyYAql1s758syo
         zUsyyyT1RNDsUIseHpgce/lCK9PnlUszVhQsloMHU2XHrMWwbvN/u6gXjieChLu/2UX9
         Ti0TmT4/pHwBAKxuBmCxIWO0lMDSM/mvmBdYP+46MiqRcOb+AmwOUmaowkU6/gGxSf/G
         Gpit4ICsFf34IEASTUQxPyXbjQiOJIAIwZBLYjq+TMKg+6xHWhR9sLBaBV8Hf1N+LFEJ
         v7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599664; x=1795204464;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xcB4UWhwl3Su1rBSkybUP2clSl1iIAbqP7WKXSblOFI=;
        b=n9j/lKVN8RFb9RAkcx5nMXPlWPfklGDWy6Au5KU0hdkd4dIp6oZOcwcld2Ajvs/pxo
         46vq/4HRHBevwWGEMVfOU7s4v3aOSIKzXq8BO9rGM2vRiClq1jyJ4JJ/B9L/LHym7sPO
         dceARVm5GP5YJ9/pb6ZmeDdOSRXpiIUP18TLz7utId+4PmyTHz4O/blRAD5SEkJBPpLo
         Fp9wxkWw1xIsaK3zfehgwhAVF6mG5t1ZxeLTGZm7t053UjhMq4xdJwyRvx6uKvUDgvHW
         b4ROgs8JK4j/QZrArzk8J+zrS5VmWSoCgUFJhHDhwYxakOlQJqJZ3k0YKYYmRPktkE4U
         9lSg==
X-Gm-Message-State: APuU4Z9/F+5zuMu4aE/hAH4OcGoq0qXpPiZ4OWbKo3zI+HKvTbyTU64p
	gbdV9fX0mHYq2FIujKdzZlYZY8CeDtqf3kOHplNF7Ka0omxflwRHN45JdWCf15ImB9TNpk1shBm
	kgZ2/DCdrpQ==
X-Received: from dycmp17.prod.google.com ([2002:a05:7301:711:b0:369:7ef0:57a8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:69cf:b0:37a:6e3e:a651
 with SMTP id 5a478bee46e88-37a6e4debbdmr938143eec.21.1794599663762; Fri, 13
 Nov 2026 11:54:23 -0800 (PST)
Date: Fri, 13 Nov 2026 11:53:22 -0800
In-Reply-To: <20261113195335.2865725-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113195335.2865725-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113195335.2865725-18-irogers@google.com>
Subject: [PATCH v2 17/30] perf dwarf-regs: Add e_machine__same_arch()
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
index 06c4912d2f65..d5384c074265 100644
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
@@ -2092,7 +2094,8 @@ bool is_pmu_core_len(struct perf_env *env, const char *name, size_t len)
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
2.56.1.703.gf848ed807c-goog

