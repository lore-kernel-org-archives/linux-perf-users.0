Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFAE1DFE21
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Nov 2024 07:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730963778; cv=none; b=lOkGyXQYpT3+FIYLI/A3TxR83btk2OKt7x28OZmnJmx3G2AsCN/ZeiNu9iHXvMA8I1lAUH4UmmJIEUuxg1tMlu+I8lzDmnNDARhkqZD4fKo6ego0FpbOJEmEpIA+JFnfDM7TtplcG9LxVITzqe89481JzPMiyBdCKnFIIUbZEas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730963778; c=relaxed/simple;
	bh=X+YI2RpbJQ4v7aUq3zphx5ptpenpsNaOLiuh9U/NvuE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=AKUG9D0fCTsGUlLzF8Zg0plbQ4NJiar5zU1hc86iLP0ZMoXkHJl43X4nlwPBb1uVuBk9d9Iq+p+6R0PM+f/Pads+mXzbTnRIMOK/72R2IXITl1G797BRZdCDTS5Dyn4SoGYEA1WV7fZ3SQrJ33yVr+7RMVy+sf3FZHNAS3qSFlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KX2lsdq4; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KX2lsdq4"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea86f1df79so12648167b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Nov 2024 23:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730963774; x=1731568574; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xNlMMjciLevQNjZxyRD3U9zk6KPHdhrwCerUrHCtyJU=;
        b=KX2lsdq4dcxVWBQMuQsb5UmULcLpWms/5JY8U/EdCLfJuEjLiP0q3sRujw1vdQjtpb
         tXu1QPKYCdwt8yR+/7M8gpo6q/YSZQo7NyUdQnh3ehuSfjZDfsv3oajVrLNcoI47+08Q
         81/4mbrKLKlYYM6PBQge+HY5UyfRLeS7i/Fhg3hmBQOxoDs7YC558u1giGUvrgLHXn1G
         D2UjMuM5927o3cnD4uPB7q0dwSxH0hmqcarF0sDWLbKv2zjXx4+Y58mOmhbTURgNDYs3
         lUD6NciNqYmgF7fVoHKjc9TRV4iUXNkmFdCh5wKguhtjctchdkKjqK1yLD2erX6u8tOa
         E8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730963774; x=1731568574;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xNlMMjciLevQNjZxyRD3U9zk6KPHdhrwCerUrHCtyJU=;
        b=eYlw99NAwy887SCqoYPJFY+VjM7y5CRL9/833P9CR8bWoZUm7vs+wpe6SH58d8WxWL
         Jy0vzpk1ddtdms88z3qzBELa5ULictnqxc/Q03JXtSYHoklmT78fY8+6lc97UQYH9KMO
         SrCrYpiZQd4OcBjENGRfZVcqyAbGhnqnyazJ/des5gdh71ftnhIMb4Dtj+ZSiofeM/VV
         ibD8eqlGudTsEn/qUqI8icRP053QAhK/595W1aQscpauX6CVCKRQwPImG4Zcm5p5tvCK
         6pM9v/Yl/Vo5nMm0AD6cR42pd2jTXAs1DSc1qkykblbcU9zKVl+p6W3enylhmC6dHd9i
         yKQg==
X-Forwarded-Encrypted: i=1; AJvYcCWPto9PQhXqtfAwc1Z5e6ZQLHucwT/tBo/xRC4AswdeixTiS6KPbiNqOUIhU/sLLqTuRLdXBzsV1IhdQ1UHuU4+@vger.kernel.org
X-Gm-Message-State: AOJu0YxX5VgklVg2PwvlOw1aHEQDRgPUTDv1OX9hMk3EElNwX5UFvbHy
	jmi8egacnggM+yLU5013SjymdbOrtZ3BWuuUYiDKkLrMDUfqvqJq8qgyDkz8Izu8qpXfXuiAiFl
	k5M996g==
X-Google-Smtp-Source: AGHT+IG/7XhxHMGfAm7DZPUmoPIpXEULkLsWBXpgZNT6RrqUGymhXMvB92mJcPp186PEHd4y9zeHZVV5R7g4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc7:bda:7167:18d8])
 (user=irogers job=sendgmr) by 2002:a05:690c:4484:b0:6dd:bf69:7e06 with SMTP
 id 00721157ae682-6e9d8b2173amr9142837b3.7.1730963774596; Wed, 06 Nov 2024
 23:16:14 -0800 (PST)
Date: Wed,  6 Nov 2024 23:15:58 -0800
In-Reply-To: <20241107071600.9082-1-irogers@google.com>
Message-Id: <20241107071600.9082-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107071600.9082-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v1 5/7] perf header: Pass a perf_cpu rather than a PMU to get_cpuid_str
From: Ian Rogers <irogers@google.com>
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Ben Zong-You Xie <ben717@andestech.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, 
	"=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=" <clement.legoffic@foss.st.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Dima Kogan <dima@secretsauce.net>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On ARM the cpuid is dependent on the core type of the CPU in
question. The PMU was passed for the sake of the CPU map but this
means in places a temporary PMU is created just to pass a CPU
value. Just pass the CPU and fix up the callers.

As there are no longer PMU users in header.h, shuffle forward
declarations earlier to work around build failures.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm64/util/arm-spe.c     | 14 ++------------
 tools/perf/arch/arm64/util/header.c      | 12 ++++--------
 tools/perf/arch/loongarch/util/header.c  |  2 +-
 tools/perf/arch/powerpc/util/header.c    |  2 +-
 tools/perf/arch/riscv/util/header.c      |  2 +-
 tools/perf/arch/s390/util/header.c       |  4 ++--
 tools/perf/arch/x86/util/header.c        |  3 +--
 tools/perf/pmu-events/empty-pmu-events.c |  5 ++++-
 tools/perf/pmu-events/jevents.py         |  5 ++++-
 tools/perf/tests/expr.c                  |  7 +++----
 tools/perf/util/expr.c                   |  6 +++---
 tools/perf/util/header.c                 | 22 +++++++++++++++++++++-
 tools/perf/util/header.h                 | 19 ++++++++++---------
 tools/perf/util/pmu.c                    | 20 --------------------
 tools/perf/util/pmu.h                    |  1 -
 15 files changed, 57 insertions(+), 67 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 7ccdea3cd461..22b19dcc6beb 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -23,6 +23,7 @@
 #include "../../../util/debug.h"
 #include "../../../util/auxtrace.h"
 #include "../../../util/record.h"
+#include "../../../util/header.h"
 #include "../../../util/arm-spe.h"
 #include <tools/libc_compat.h> // reallocarray
 
@@ -85,22 +86,11 @@ static int arm_spe_save_cpu_header(struct auxtrace_record *itr,
 	struct arm_spe_recording *sper =
 			container_of(itr, struct arm_spe_recording, itr);
 	struct perf_pmu *pmu = NULL;
-	struct perf_pmu tmp_pmu;
-	char cpu_id_str[16];
 	char *cpuid = NULL;
 	u64 val;
 
-	snprintf(cpu_id_str, sizeof(cpu_id_str), "%d", cpu.cpu);
-	tmp_pmu.cpus = perf_cpu_map__new(cpu_id_str);
-	if (!tmp_pmu.cpus)
-		return -ENOMEM;
-
 	/* Read CPU MIDR */
-	cpuid = perf_pmu__getcpuid(&tmp_pmu);
-
-	/* The CPU map will not be used anymore, release it */
-	perf_cpu_map__put(tmp_pmu.cpus);
-
+	cpuid = get_cpuid_allow_env_override(cpu);
 	if (!cpuid)
 		return -ENOMEM;
 	val = strtol(cpuid, NULL, 16);
diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/util/header.c
index f0907daad3ae..f445a2dd6293 100644
--- a/tools/perf/arch/arm64/util/header.c
+++ b/tools/perf/arch/arm64/util/header.c
@@ -62,22 +62,18 @@ int get_cpuid(char *buf, size_t sz, struct perf_cpu cpu)
 	return EINVAL;
 }
 
-char *get_cpuid_str(struct perf_pmu *pmu)
+char *get_cpuid_str(struct perf_cpu cpu)
 {
-	char *buf = NULL;
+	char *buf = malloc(MIDR_SIZE);
 	int res;
 
-	if (!pmu || !pmu->cpus)
-		return NULL;
-
-	buf = malloc(MIDR_SIZE);
 	if (!buf)
 		return NULL;
 
 	/* read midr from list of cpus mapped to this pmu */
-	res = get_cpuid(buf, MIDR_SIZE, perf_cpu_map__min(pmu->cpus));
+	res = get_cpuid(buf, MIDR_SIZE, cpu);
 	if (res) {
-		pr_err("failed to get cpuid string for PMU %s\n", pmu->name);
+		pr_err("failed to get cpuid string for CPU %d\n", cpu.cpu);
 		free(buf);
 		buf = NULL;
 	}
diff --git a/tools/perf/arch/loongarch/util/header.c b/tools/perf/arch/loongarch/util/header.c
index f1f0b116962d..0c6d823334a2 100644
--- a/tools/perf/arch/loongarch/util/header.c
+++ b/tools/perf/arch/loongarch/util/header.c
@@ -90,7 +90,7 @@ int get_cpuid(char *buffer, size_t sz, struct perf_cpu cpu __maybe_unused)
 	return ret;
 }
 
-char *get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
+char *get_cpuid_str(struct perf_cpu cpu __maybe_unused)
 {
 	return _get_cpuid();
 }
diff --git a/tools/perf/arch/powerpc/util/header.c b/tools/perf/arch/powerpc/util/header.c
index 6d1a63a2922f..c7df534dbf8f 100644
--- a/tools/perf/arch/powerpc/util/header.c
+++ b/tools/perf/arch/powerpc/util/header.c
@@ -42,7 +42,7 @@ get_cpuid(char *buffer, size_t sz, struct perf_cpu cpu __maybe_unused)
 }
 
 char *
-get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
+get_cpuid_str(struct perf_cpu cpu __maybe_unused)
 {
 	char *bufp;
 	unsigned long pvr;
diff --git a/tools/perf/arch/riscv/util/header.c b/tools/perf/arch/riscv/util/header.c
index ebac294c877f..4b839203d4a5 100644
--- a/tools/perf/arch/riscv/util/header.c
+++ b/tools/perf/arch/riscv/util/header.c
@@ -98,7 +98,7 @@ int get_cpuid(char *buffer, size_t sz, struct perf_cpu cpu __maybe_unused)
 }
 
 char *
-get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
+get_cpuid_str(struct perf_cpu cpu __maybe_unused)
 {
 	return _get_cpuid();
 }
diff --git a/tools/perf/arch/s390/util/header.c b/tools/perf/arch/s390/util/header.c
index 2add1a561242..db54677a17d2 100644
--- a/tools/perf/arch/s390/util/header.c
+++ b/tools/perf/arch/s390/util/header.c
@@ -137,11 +137,11 @@ int get_cpuid(char *buffer, size_t sz, struct perf_cpu cpu __maybe_unused)
 	return (nbytes >= sz) ? ENOBUFS : 0;
 }
 
-char *get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
+char *get_cpuid_str(struct perf_cpu cpu)
 {
 	char *buf = malloc(128);
 
-	if (buf && get_cpuid(buf, 128))
+	if (buf && get_cpuid(buf, 128, cpu))
 		zfree(&buf);
 	return buf;
 }
diff --git a/tools/perf/arch/x86/util/header.c b/tools/perf/arch/x86/util/header.c
index 690f86cbbb1c..412977f8aa83 100644
--- a/tools/perf/arch/x86/util/header.c
+++ b/tools/perf/arch/x86/util/header.c
@@ -63,8 +63,7 @@ get_cpuid(char *buffer, size_t sz, struct perf_cpu cpu __maybe_unused)
 	return __get_cpuid(buffer, sz, "%s,%u,%u,%u$");
 }
 
-char *
-get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
+char *get_cpuid_str(struct perf_cpu cpu __maybe_unused)
 {
 	char *buf = malloc(128);
 
diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index 2b7516946ded..1f7f39a89ffd 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -515,13 +515,16 @@ static const struct pmu_events_map *map_for_pmu(struct perf_pmu *pmu)
         } last_map_search;
         static bool has_last_result, has_last_map_search;
         const struct pmu_events_map *map = NULL;
+        struct perf_cpu cpu = {-1};
         char *cpuid = NULL;
         size_t i;
 
         if (has_last_result && last_result.pmu == pmu)
                 return last_result.map;
 
-        cpuid = perf_pmu__getcpuid(pmu);
+        if (pmu)
+                cpu = perf_cpu_map__min(pmu->cpus);
+        cpuid = get_cpuid_allow_env_override(cpu);
 
         /*
          * On some platforms which uses cpus map, cpuid can be NULL for
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 6e71b09dbc2a..17cd1b1c6b66 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -1031,13 +1031,16 @@ static const struct pmu_events_map *map_for_pmu(struct perf_pmu *pmu)
         } last_map_search;
         static bool has_last_result, has_last_map_search;
         const struct pmu_events_map *map = NULL;
+        struct perf_cpu cpu = {-1};
         char *cpuid = NULL;
         size_t i;
 
         if (has_last_result && last_result.pmu == pmu)
                 return last_result.map;
 
-        cpuid = perf_pmu__getcpuid(pmu);
+        if (pmu)
+                cpu = perf_cpu_map__min(pmu->cpus);
+        cpuid = get_cpuid_allow_env_override(cpu);
 
         /*
          * On some platforms which uses cpus map, cpuid can be NULL for
diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index d60f1ac1d720..41ff1affdfcd 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -4,10 +4,9 @@
 #include "util/expr.h"
 #include "util/hashmap.h"
 #include "util/header.h"
-#include "util/pmu.h"
-#include "util/pmus.h"
 #include "util/smt.h"
 #include "tests.h"
+#include <perf/cpumap.h>
 #include <math.h>
 #include <stdlib.h>
 #include <string.h>
@@ -78,8 +77,8 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 	struct expr_parse_ctx *ctx;
 	bool is_intel = false;
 	char strcmp_cpuid_buf[256];
-	struct perf_pmu *pmu = perf_pmus__find_core_pmu();
-	char *cpuid = perf_pmu__getcpuid(pmu);
+	struct perf_cpu cpu = {-1};
+	char *cpuid = get_cpuid_allow_env_override(cpu);
 	char *escaped_cpuid1, *escaped_cpuid2;
 
 	TEST_ASSERT_VAL("get_cpuid", cpuid);
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 5e3732bc2fa5..f289044a1f7c 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -8,7 +8,6 @@
 #include "debug.h"
 #include "evlist.h"
 #include "expr.h"
-#include "pmu.h"
 #include "smt.h"
 #include "tool_pmu.h"
 #include <util/expr-bison.h>
@@ -16,6 +15,7 @@
 #include "util/hashmap.h"
 #include "util/header.h"
 #include "util/pmu.h"
+#include <perf/cpumap.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
@@ -456,8 +456,8 @@ double expr__strcmp_cpuid_str(const struct expr_parse_ctx *ctx __maybe_unused,
 		       bool compute_ids __maybe_unused, const char *test_id)
 {
 	double ret;
-	struct perf_pmu *pmu = perf_pmus__find_core_pmu();
-	char *cpuid = perf_pmu__getcpuid(pmu);
+	struct perf_cpu cpu = {-1};
+	char *cpuid = get_cpuid_allow_env_override(cpu);
 
 	if (!cpuid)
 		return NAN;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 60b42ddc3dac..06ca5762f61f 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -819,11 +819,31 @@ static int write_group_desc(struct feat_fd *ff,
  * Each architecture should provide a more precise id string that
  * can be use to match the architecture's "mapfile".
  */
-char * __weak get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
+char * __weak get_cpuid_str(struct perf_cpu cpu __maybe_unused)
 {
 	return NULL;
 }
 
+char *get_cpuid_allow_env_override(struct perf_cpu cpu)
+{
+	char *cpuid;
+	static bool printed;
+
+	cpuid = getenv("PERF_CPUID");
+	if (cpuid)
+		cpuid = strdup(cpuid);
+	if (!cpuid)
+		cpuid = get_cpuid_str(cpu);
+	if (!cpuid)
+		return NULL;
+
+	if (!printed) {
+		pr_debug("Using CPUID %s\n", cpuid);
+		printed = true;
+	}
+	return cpuid;
+}
+
 /* Return zero when the cpuid from the mapfile.csv matches the
  * cpuid string generated on this platform.
  * Otherwise return non-zero.
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 3bb768455a60..5201af6305f4 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -10,9 +10,14 @@
 #include <linux/bitmap.h>
 #include <linux/types.h>
 #include "env.h"
-#include "pmu.h"
 #include <perf/cpumap.h>
 
+struct evlist;
+union perf_event;
+struct perf_header;
+struct perf_session;
+struct perf_tool;
+
 enum {
 	HEADER_RESERVED		= 0,	/* always cleared */
 	HEADER_FIRST_FEATURE	= 1,
@@ -92,8 +97,6 @@ struct perf_pipe_file_header {
 	u64				size;
 };
 
-struct perf_header;
-
 int perf_file_header__read(struct perf_file_header *header,
 			   struct perf_header *ph, int fd);
 
@@ -125,11 +128,6 @@ struct perf_header_feature_ops {
 	bool	   synthesize;
 };
 
-struct evlist;
-struct perf_session;
-struct perf_tool;
-union perf_event;
-
 extern const char perf_version_string[];
 
 int perf_session__read_header(struct perf_session *session);
@@ -204,6 +202,9 @@ int build_caches_for_cpu(u32 cpu, struct cpu_cache_level caches[], u32 *cntp);
  */
 int get_cpuid(char *buffer, size_t sz, struct perf_cpu cpu);
 
-char *get_cpuid_str(struct perf_pmu *pmu __maybe_unused);
+char *get_cpuid_str(struct perf_cpu cpu);
+
+char *get_cpuid_allow_env_override(struct perf_cpu cpu);
+
 int strcmp_cpuid_str(const char *s1, const char *s2);
 #endif /* __PERF_HEADER_H */
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 0789758598c0..514cb865f57b 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -818,26 +818,6 @@ static int is_sysfs_pmu_core(const char *name)
 	return file_available(path);
 }
 
-char *perf_pmu__getcpuid(struct perf_pmu *pmu)
-{
-	char *cpuid;
-	static bool printed;
-
-	cpuid = getenv("PERF_CPUID");
-	if (cpuid)
-		cpuid = strdup(cpuid);
-	if (!cpuid)
-		cpuid = get_cpuid_str(pmu);
-	if (!cpuid)
-		return NULL;
-
-	if (!printed) {
-		pr_debug("Using CPUID %s\n", cpuid);
-		printed = true;
-	}
-	return cpuid;
-}
-
 __weak const struct pmu_metrics_table *pmu_metrics_table__find(void)
 {
 	return perf_pmu__find_metrics_table(NULL);
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index b86b3c3685a2..fba3fc608b64 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -260,7 +260,6 @@ void perf_pmu__arch_init(struct perf_pmu *pmu);
 void pmu_add_cpu_aliases_table(struct perf_pmu *pmu,
 			       const struct pmu_events_table *table);
 
-char *perf_pmu__getcpuid(struct perf_pmu *pmu);
 const struct pmu_metrics_table *pmu_metrics_table__find(void);
 bool pmu_uncore_identifier_match(const char *compat, const char *id);
 
-- 
2.47.0.199.ga7371fff76-goog

