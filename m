Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599654;
	b=i1t8VNm01hg2kIo88Uu+XkhrSixZfKZdJOe0K/Qcpn/UI5/g0HY6fmv+AHbamgsUInqh
	 Tli+0pCe2foGGe5LYwM9VzCKdLrf7OWmtVsfay6MDNksEkKWXT1CyJwmBIhnAVYYCRtg1
	 tLAtaJDhFNVNpeppkPdPxt72EF6bLZo/N0AYoIitC/Ml44ePyzmBV0kZz+7x8Y37J/Jnj
	 hNjDsNNtALZVauQunTj+BiUcF3aQ/U3BiaE8XqlvtKjit5FaqRGcJchQIF2oqv9ey9ZyU
	 hDuS8/0zFIQoUS7l6oeZu4G2DQF9Hq8GtCqOII5ftb84cYhi7OK5bdFATv+67zQ8Wzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599654;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=8iLejof9SNYXBBrUZ0jfduIIHzV41IOp5gLZ2nAF0Cw=;
	b=jwV8E0lWOfQ0vNXCYFu2JJ+r775LgFhFTd/hvuATP/NPhDQbTocuCLhFAFWCyF363eL9
	 z1ou8P2Xdf+6y/D49lwKUPfN1SS/ftV9xibuZ0BcX/s9EhA1y6x3X5fxz5FFKlrJ3Etxy
	 IyTaxcfiGmVnhiGhFXbAdR8Bw5yj6JvOsXddoVsea5Mpq4RWnQ6CGpPWe7T0UFAz2RvGH
	 Y55ChnU4H5HYELahe5Yi8Kionj6UW//lbL2aMXXekitv59+0ZmDKU80GrA6Yjq4KJfvMd
	 tbrkV9zcNk6uoj1WkpCkrzLk5iVlfn6OPgoeumZTpB+NU/oelfD0P+zi9+ZwWrgQkHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TguuiWiE;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A6D60A5BC2
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3A6D60A5BC2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TguuiWiE
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-370230d93efso5989663eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 11:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794599653; x=1795204453; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8iLejof9SNYXBBrUZ0jfduIIHzV41IOp5gLZ2nAF0Cw=;
        b=TguuiWiEv2tBB2aShdaTJVVrpqgRILi42Hr3RKubry7naW6ikZtVaDdwQiHcM6FpEy
         RoX4N/LvhrVoe3Bi1bS5nATb1hSsd7pXDdPAxApD/moe4m51bNqRKKO+vKYsUsKwyFZb
         nxcj70/a6Bol71SDVPkiN7fXD6DLCM8uw1rxB0cSWF3lJGmW3wcv3KLjz08jtu3lTONn
         OAASGWZu/S4jiiFB42rpTbX75QU+ZnccZZ15ShtIucXKFzY9O1gdquO9F6yHGK8kZ0D3
         sYsA5dSRcfdniJ+GxLPPUOGQ7BAqPjqvo2rJWJ7qjb0YJBCFCNn5y957Kxsu4n9JiCho
         oBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599653; x=1795204453;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8iLejof9SNYXBBrUZ0jfduIIHzV41IOp5gLZ2nAF0Cw=;
        b=Hyirqbq8wr0r6hbG8wxgN85BsKAOtJTdGGAK/72x8A93K0TEjvpbwQthPYJQHueppi
         g1NILyaxw8XaOYcVaS4YavYCQXnSod9J91wal6q6RNXgL8JBuQUrMVYqRu0h6vKvBNNI
         lGYKvCdJoJgsaJoMZKjTDokn5mQ0WOupWXHq3cVbXialB5HBxDeLpf0piSpz0mlQnKYv
         XTsHhd/IK5iBTllZ+XtZ2sx3uek37waVDW/uxVutxheriIvYZbrJHSVUFqqCFeUk/P0d
         GSY8CtL6GiGcBQlwo3EQ4RWKm12py708J+Mn0IX5hnZkJm79jx5TQD3NRVoXFhLNga8T
         jcHA==
X-Gm-Message-State: APuU4Z+lQE7bOG4P46UKfaMndpJQjtY/2hgEileOoyR9lAx8o1/IGKEv
	0q09u745tqm8z8DPlQEPschdy4jtC5ecsgBBoUmWvI7z6aZNzw4/DDz8WQe1UHkjT6C87UByVTN
	Bxc0wre2xxg==
X-Received: from dybme45.prod.google.com ([2002:a05:7301:18ad:b0:36a:10f5:840])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:2717:b0:36d:394d:e696
 with SMTP id 5a478bee46e88-379679e33b8mr2990935eec.29.1794599652579; Fri, 13
 Nov 2026 11:54:12 -0800 (PST)
Date: Fri, 13 Nov 2026 11:53:18 -0800
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
Message-ID: <20261113195335.2865725-14-irogers@google.com>
Subject: [PATCH v2 13/30] perf header: Pass e_machine to strcmp_cpuid_str()
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The format of a CPUID depends on its architecture, but
strcmp_cpuid_str() is only given the two CPUID strings and its
architecture specific implementations assume the CPUIDs are for the
architecture perf was built for.

Pass the ELF machine of the CPUIDs' architecture to strcmp_cpuid_str()
so that CPUIDs can be compared according to their architecture rather
than the host's. The pmu-events tables pass their e_machine, comparisons
with the host's CPUID pass EM_HOST and the arm64 CPUID matching test
passes EM_AARCH64. The architecture specific implementations don't yet
use the argument.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm64/tests/cpuid-match.c | 17 +++++++++--------
 tools/perf/arch/arm64/util/header.c       |  2 +-
 tools/perf/arch/x86/util/header.c         |  2 +-
 tools/perf/arch/x86/util/pmu.c            | 10 ++++++----
 tools/perf/pmu-events/empty-pmu-events.c  |  6 +++---
 tools/perf/pmu-events/jevents.py          |  6 +++---
 tools/perf/util/expr.c                    |  3 ++-
 tools/perf/util/header.c                  |  3 ++-
 tools/perf/util/header.h                  |  6 +++++-
 9 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/tools/perf/arch/arm64/tests/cpuid-match.c b/tools/perf/arch/arm64/tests/cpuid-match.c
index e8e3947cca18..b073ac33ea9b 100644
--- a/tools/perf/arch/arm64/tests/cpuid-match.c
+++ b/tools/perf/arch/arm64/tests/cpuid-match.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/compiler.h>
+#include <elf.h>
 
 #include "arch-tests.h"
 #include "tests/tests.h"
@@ -9,28 +10,28 @@ int test__cpuid_match(struct test_suite *test __maybe_unused,
 			     int subtest __maybe_unused)
 {
 	/* midr with no leading zeros matches */
-	if (strcmp_cpuid_str("0x410fd0c0", "0x00000000410fd0c0"))
+	if (strcmp_cpuid_str(EM_AARCH64, "0x410fd0c0", "0x00000000410fd0c0"))
 		return -1;
 	/* Upper case matches */
-	if (strcmp_cpuid_str("0x410fd0c0", "0x00000000410FD0C0"))
+	if (strcmp_cpuid_str(EM_AARCH64, "0x410fd0c0", "0x00000000410FD0C0"))
 		return -1;
 	/* r0p0 = r0p0 matches */
-	if (strcmp_cpuid_str("0x00000000410fd480", "0x00000000410fd480"))
+	if (strcmp_cpuid_str(EM_AARCH64, "0x00000000410fd480", "0x00000000410fd480"))
 		return -1;
 	/* r0p1 > r0p0 matches */
-	if (strcmp_cpuid_str("0x00000000410fd480", "0x00000000410fd481"))
+	if (strcmp_cpuid_str(EM_AARCH64, "0x00000000410fd480", "0x00000000410fd481"))
 		return -1;
 	/* r1p0 > r0p0 matches*/
-	if (strcmp_cpuid_str("0x00000000410fd480", "0x00000000411fd480"))
+	if (strcmp_cpuid_str(EM_AARCH64, "0x00000000410fd480", "0x00000000411fd480"))
 		return -1;
 	/* r0p0 < r0p1 doesn't match */
-	if (!strcmp_cpuid_str("0x00000000410fd481", "0x00000000410fd480"))
+	if (!strcmp_cpuid_str(EM_AARCH64, "0x00000000410fd481", "0x00000000410fd480"))
 		return -1;
 	/* r0p0 < r1p0 doesn't match */
-	if (!strcmp_cpuid_str("0x00000000411fd480", "0x00000000410fd480"))
+	if (!strcmp_cpuid_str(EM_AARCH64, "0x00000000411fd480", "0x00000000410fd480"))
 		return -1;
 	/* Different CPU doesn't match */
-	if (!strcmp_cpuid_str("0x00000000410fd4c0", "0x00000000430f0af0"))
+	if (!strcmp_cpuid_str(EM_AARCH64, "0x00000000410fd4c0", "0x00000000430f0af0"))
 		return -1;
 
 	return 0;
diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/util/header.c
index 95e71c4f6c78..ee28add836b5 100644
--- a/tools/perf/arch/arm64/util/header.c
+++ b/tools/perf/arch/arm64/util/header.c
@@ -87,7 +87,7 @@ char *get_cpuid_str(struct perf_cpu cpu)
  *
  * Return 1 if the CPU type is different or the version of idstr is lower.
  */
-int strcmp_cpuid_str(const char *mapcpuid, const char *idstr)
+int strcmp_cpuid_str(uint16_t e_machine __maybe_unused, const char *mapcpuid, const char *idstr)
 {
 	u64 map_id = strtoull(mapcpuid, NULL, 16);
 	char map_id_variant = FIELD_GET(MIDR_VARIANT_MASK, map_id);
diff --git a/tools/perf/arch/x86/util/header.c b/tools/perf/arch/x86/util/header.c
index 412977f8aa83..b65856f3b846 100644
--- a/tools/perf/arch/x86/util/header.c
+++ b/tools/perf/arch/x86/util/header.c
@@ -91,7 +91,7 @@ static bool is_full_cpuid(const char *id)
 	return false;
 }
 
-int strcmp_cpuid_str(const char *mapcpuid, const char *id)
+int strcmp_cpuid_str(uint16_t e_machine __maybe_unused, const char *mapcpuid, const char *id)
 {
 	regex_t re;
 	regmatch_t pmatch[1];
diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index fd4491fda117..37269154e5e7 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -22,6 +22,7 @@
 #include "util/debug.h"
 #include "util/env.h"
 #include "util/header.h"
+#include "dwarf-regs.h"
 
 #define GENUINE_INTEL_SPR "GenuineIntel-6-8F"
 #define GENUINE_INTEL_EMR "GenuineIntel-6-CF"
@@ -41,7 +42,8 @@ static void init_snc_support(void)
 	char *cpuid = get_cpuid_str((struct perf_cpu){0});
 
 	for (size_t i = 0; i < ARRAY_SIZE(supported_cpuids); i++) {
-		cached_snc_supported = cpuid && strcmp_cpuid_str(supported_cpuids[i], cpuid) == 0;
+		cached_snc_supported = cpuid &&
+			strcmp_cpuid_str(EM_HOST, supported_cpuids[i], cpuid) == 0;
 		if (cached_snc_supported)
 			break;
 	}
@@ -173,11 +175,11 @@ static void init_snc_map(void)
 	case 2:
 		cpuid = get_cpuid_str((struct perf_cpu){ 0 });
 		if (cpuid) {
-			if (strcmp_cpuid_str(GENUINE_INTEL_SPR, cpuid) == 0 ||
-			    strcmp_cpuid_str(GENUINE_INTEL_EMR, cpuid) == 0) {
+			if (strcmp_cpuid_str(EM_HOST, GENUINE_INTEL_SPR, cpuid) == 0 ||
+			    strcmp_cpuid_str(EM_HOST, GENUINE_INTEL_EMR, cpuid) == 0) {
 				cached_imc_snc_map = spr_emr_snc2_map;
 				cached_imc_snc_map_len = ARRAY_SIZE(spr_emr_snc2_map);
-			} else if (strcmp_cpuid_str(GENUINE_INTEL_GNR, cpuid) == 0) {
+			} else if (strcmp_cpuid_str(EM_HOST, GENUINE_INTEL_GNR, cpuid) == 0) {
 				cached_imc_snc_map = gnr_snc2_map;
 				cached_imc_snc_map_len = ARRAY_SIZE(gnr_snc2_map);
 			}
diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index eba5446520c4..872c6ca6e817 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -5831,7 +5831,7 @@ static const struct pmu_events_map *map_for_cpu(struct perf_cpu cpu)
 			}
 
 			if (pmu_events_map__e_machine_matches(map, EM_HOST) &&
-			    !strcmp_cpuid_str(map->cpuid, cpuid))
+			    !strcmp_cpuid_str(map->e_machine, map->cpuid, cpuid))
 				break;
 		}
 		free(last_map_search.cpuid);
@@ -5933,7 +5933,7 @@ const struct pmu_events_table *find_core_events_table(uint16_t e_machine, const
 	     tables->arch;
 	     tables++) {
 		if (pmu_events_map__e_machine_matches(tables, e_machine) &&
-		    !strcmp_cpuid_str(tables->cpuid, cpuid))
+		    !strcmp_cpuid_str(tables->e_machine, tables->cpuid, cpuid))
 			return &tables->event_table;
 	}
 	return NULL;
@@ -5945,7 +5945,7 @@ const struct pmu_metrics_table *find_core_metrics_table(uint16_t e_machine, cons
 	     tables->arch;
 	     tables++) {
 		if (pmu_events_map__e_machine_matches(tables, e_machine) &&
-		    !strcmp_cpuid_str(tables->cpuid, cpuid))
+		    !strcmp_cpuid_str(tables->e_machine, tables->cpuid, cpuid))
 			return &tables->metric_table;
 	}
 	return NULL;
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index fc3de5fbda27..802ae2ad4405 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -1249,7 +1249,7 @@ static const struct pmu_events_map *map_for_cpu(struct perf_cpu cpu)
 \t\t\t}
 
 \t\t\tif (pmu_events_map__e_machine_matches(map, EM_HOST) &&
-\t\t\t    !strcmp_cpuid_str(map->cpuid, cpuid))
+\t\t\t    !strcmp_cpuid_str(map->e_machine, map->cpuid, cpuid))
 \t\t\t\tbreak;
 \t\t}
 \t\tfree(last_map_search.cpuid);
@@ -1351,7 +1351,7 @@ const struct pmu_events_table *find_core_events_table(uint16_t e_machine, const
 \t     tables->arch;
 \t     tables++) {
 \t\tif (pmu_events_map__e_machine_matches(tables, e_machine) &&
-\t\t    !strcmp_cpuid_str(tables->cpuid, cpuid))
+\t\t    !strcmp_cpuid_str(tables->e_machine, tables->cpuid, cpuid))
 \t\t\treturn &tables->event_table;
 \t}
 \treturn NULL;
@@ -1363,7 +1363,7 @@ const struct pmu_metrics_table *find_core_metrics_table(uint16_t e_machine, cons
 \t     tables->arch;
 \t     tables++) {
 \t\tif (pmu_events_map__e_machine_matches(tables, e_machine) &&
-\t\t    !strcmp_cpuid_str(tables->cpuid, cpuid))
+\t\t    !strcmp_cpuid_str(tables->e_machine, tables->cpuid, cpuid))
 \t\t\treturn &tables->metric_table;
 \t}
 \treturn NULL;
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index f1164c4666b1..09ced31ef59e 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -14,6 +14,7 @@
 #include <util/expr-flex.h>
 #include "util/hashmap.h"
 #include "util/header.h"
+#include "dwarf-regs.h"
 #include "util/pmu.h"
 #include <perf/cpumap.h>
 #include <linux/err.h>
@@ -485,7 +486,7 @@ double expr__strcmp_cpuid_str(const struct expr_parse_ctx *ctx __maybe_unused,
 	if (!cpuid)
 		return NAN;
 
-	ret = !strcmp_cpuid_str(test_id, cpuid);
+	ret = !strcmp_cpuid_str(EM_HOST, test_id, cpuid);
 
 	free(cpuid);
 	return ret;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 2c686095fe67..38525b17f26d 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -964,7 +964,8 @@ char *get_cpuid_allow_env_override(struct perf_cpu cpu)
  * cpuid string generated on this platform.
  * Otherwise return non-zero.
  */
-int __weak strcmp_cpuid_str(const char *mapcpuid, const char *cpuid)
+int __weak strcmp_cpuid_str(uint16_t e_machine __maybe_unused, const char *mapcpuid,
+			    const char *cpuid)
 {
 	regex_t re;
 	regmatch_t pmatch[1];
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 765037762758..d30fb30a0c92 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -219,7 +219,11 @@ char *get_cpuid_str(struct perf_cpu cpu);
 
 char *get_cpuid_allow_env_override(struct perf_cpu cpu);
 
-int strcmp_cpuid_str(const char *s1, const char *s2);
+/*
+ * Compare a CPUID from a pmu-events mapfile.csv, @mapcpuid, with @cpuid for
+ * the architecture with ELF machine @e_machine. Returns 0 on a match.
+ */
+int strcmp_cpuid_str(uint16_t e_machine, const char *mapcpuid, const char *cpuid);
 
 struct cpu_domain_map **build_cpu_domain_map(u32 *schedstat_version, u32 *max_sched_domains,
 					     u32 nr);
-- 
2.56.1.703.gf848ed807c-goog

