Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599657;
	b=5t/nu/5BfSdR2Ld1DfqfbWVrD2LfSu7t68FtxoK+Fne08SVnvqkQSsuhxwaHvqYl8ooK
	 VjQljHIEp6QIPUk9F+ZvUCyzhi3gsoj8qiNYhsSeDCjUUO51qE0r/jnCoAy4LWMEN/hGu
	 /XlKDSUqJR/rSvrv0ZwilGmsofvXdTkyjnO24ltTmMgTw/M+2uYip+QlQbV6R8Nm9/ZjG
	 8oIgDZQMfg/c4p3z0EEIzTzNhkfPThmpmyuH6Cx+7lvir1tB2Avn0AQoJftFCorb8uLlI
	 sCSATqyImS6APewgllI4SEFW6JrVwtoC21c4jGTeohXmGsQ8hIqGXOk8UZW/mD6F+DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=kQluru4zRFHalNJhSPUIt5biMrVvVkeP4kqLXivRmk4=;
	b=NR/5DQcJOU6Q21963egp9THELzvJ0oD7sQ6exxn225Fwow68c0fVeJlaAucNH1MovXAD
	 6FNnsPHhZqt++D799MknUHMeSWi9MZ2UVuuY8r9pY+E2+EbVz9SptcZrIuAgEZ87y+MUO
	 TyLITjMsGvIuJJCmcBuTNS47gC3MOAzcQoXmu911xnqhc9TK7P+Vu26lBendiIKVaWusj
	 jAnqP7TWcVCTJvTz0bxoWOLgnnCrQO5dUIHJKQlKH27Z4JgzZy4EH5f0VCjmn76McRmNm
	 ZKgueCum/pZC12Ue6eTJDt45HX+ZzIgYoxjsuwe8j7VTKPhatJo3S9S8NKt6K80M2Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bMeYIfS0;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE62660A5BDF
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE62660A5BDF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bMeYIfS0
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1a2af4c8cbaso958167c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 11:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794599656; x=1795204456; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kQluru4zRFHalNJhSPUIt5biMrVvVkeP4kqLXivRmk4=;
        b=bMeYIfS0mhqquWoIKiGbjhEFjMMMht2MTqymzC9xTQCaQZTUcl2SvBIJG6pjb2iTHk
         b95GTs+5NXi8Ap1kryS39g4xEwpN7GOjYxpPeWX2wwzDWh2uEzQeDK7JGhdZwrOjaLKc
         xdYSZA0ferJ86fSX3FedbXntA2j0aDA4i6fdVv8EQs8x55khiT7daaiVp2QLNG9DDMSF
         wJaG36RKUcSBTFf4/seIYrOBL2qCQvWc8UuCEtzBrgWZ7Xh4Bmrey8ECP90is9FTRMM1
         YMfkceup653mHhKndoNBa9AQq5IHY/2y5n4B+bSNyYsmSrUpvaa1aMUe1SEK7J7wLeQF
         lEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599656; x=1795204456;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kQluru4zRFHalNJhSPUIt5biMrVvVkeP4kqLXivRmk4=;
        b=vtbK17Mjr8shw30jxN//1TszmrlVVXA7aod7pjIpWvBI8uPZdP2SvF/3VexpB94EcX
         QClawLw4C5PooakXpejCkQp7JxTfN7w5xkWbliXqC2Kf8TRv5hIHM/nKeI1H6PIx9uGF
         mQn8yYJqYmNp11S3mAgoAcLX4PzwdQP7AEomlgw8RCdfjn5S/ulK9jgaddTA2OGH+rL8
         mzL363eeS4DRqhT8YwMAEjkjpcy/ez9ZpEWNFZQj/7LlnCpOiijtY8+wIpKjNWdsN1Xw
         tlgr+98qu2MWUxnQCcq5/aqjWtQeLWgJ5jM6CKPya6CTnk2mPGFAemIH4JLzhBqOd031
         S7Lw==
X-Gm-Message-State: APuU4Z8xqKqoEmRcdRnfXZ+dHsXeLldnFP5rsAQr6JviSJsulOtymIEY
	MEHyF4o3HHlNLOK6VDWMbFCr7YrGAnT8kQj1rX3SRcsJI3FNNq5u47DoGb3Juxdmji3cqeDVu12
	MnxogkmZ9UA==
X-Received: from dluu3.prod.google.com ([2002:a05:7022:2083:b0:158:5d29:90be])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:286:20b0:1b3:ae32:7a57
 with SMTP id a92af1059eb24-1b5031051bbmr3440139c88.47.1794599655097; Fri, 13
 Nov 2026 11:54:15 -0800 (PST)
Date: Fri, 13 Nov 2026 11:53:19 -0800
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
Message-ID: <20261113195335.2865725-15-irogers@google.com>
Subject: [PATCH v2 14/30] perf header: Support CPUID matching across all architectures
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

strcmp_cpuid_str() had architecture specific overrides of a __weak
regular expression matching implementation in arch/x86/util/header.c
and arch/arm64/util/header.c, so a CPUID could only be compared using
the rules of the architecture perf was built for. In addition, the
HEADER_CPUID strings written by get_cpuid() on x86 ("vendor,family,
model,step" in decimal) and PowerPC ("pvr_ver,pvr_rev" in decimal)
differ from the get_cpuid_str() formats ("vendor-family-model-stepping"
in hex and "0x%.8lx") matched against the pmu-events mapfile.csv
tables. As a result, finding the core events or metrics table for the
CPUID of a perf_env, such as from a perf.data file recorded on a
different architecture, failed.

Move the architecture specific comparisons into util/header.c and
select them using the ELF machine of the CPUIDs: EM_NONE for the test
and common tables compares exactly, arm64 compares MIDR part, variant
and revision fields, x86 matches with an optional stepping and other
architectures match a regular expression. Convert x86 and PowerPC
HEADER_CPUID strings before matching.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm64/util/header.c |  48 ---------
 tools/perf/arch/x86/util/header.c   |  64 -----------
 tools/perf/util/header.c            | 161 +++++++++++++++++++++++++++-
 3 files changed, 156 insertions(+), 117 deletions(-)

diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/util/header.c
index ee28add836b5..181836613087 100644
--- a/tools/perf/arch/arm64/util/header.c
+++ b/tools/perf/arch/arm64/util/header.c
@@ -1,5 +1,3 @@
-#include <linux/bits.h>
-#include <linux/bitfield.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <perf/cpumap.h>
@@ -10,8 +8,6 @@
 
 #define MIDR "/regs/identification/midr_el1"
 #define MIDR_SIZE 19
-#define MIDR_REVISION_MASK      GENMASK(3, 0)
-#define MIDR_VARIANT_MASK	GENMASK(23, 20)
 
 static int _get_cpuid(char *buf, size_t sz, struct perf_cpu cpu)
 {
@@ -79,47 +75,3 @@ char *get_cpuid_str(struct perf_cpu cpu)
 
 	return buf;
 }
-
-/*
- * Return 0 if idstr is a higher or equal to version of the same part as
- * mapcpuid. Therefore, if mapcpuid has 0 for revision and variant then any
- * version of idstr will match as long as it's the same CPU type.
- *
- * Return 1 if the CPU type is different or the version of idstr is lower.
- */
-int strcmp_cpuid_str(uint16_t e_machine __maybe_unused, const char *mapcpuid, const char *idstr)
-{
-	u64 map_id = strtoull(mapcpuid, NULL, 16);
-	char map_id_variant = FIELD_GET(MIDR_VARIANT_MASK, map_id);
-	char map_id_revision = FIELD_GET(MIDR_REVISION_MASK, map_id);
-	u64 id = strtoull(idstr, NULL, 16);
-	char id_variant = FIELD_GET(MIDR_VARIANT_MASK, id);
-	char id_revision = FIELD_GET(MIDR_REVISION_MASK, id);
-	u64 id_fields = ~(MIDR_VARIANT_MASK | MIDR_REVISION_MASK);
-
-	/* Compare without version first */
-	if ((map_id & id_fields) != (id & id_fields))
-		return 1;
-
-	/*
-	 * ID matches, now compare version.
-	 *
-	 * Arm revisions (like r0p0) are compared here like two digit semver
-	 * values eg. 1.3 < 2.0 < 2.1 < 2.2.
-	 *
-	 *  r = high value = 'Variant' field in MIDR
-	 *  p = low value  = 'Revision' field in MIDR
-	 *
-	 */
-	if (id_variant > map_id_variant)
-		return 0;
-
-	if (id_variant == map_id_variant && id_revision >= map_id_revision)
-		return 0;
-
-	/*
-	 * variant is less than mapfile variant or variants are the same but
-	 * the revision doesn't match. Return no match.
-	 */
-	return 1;
-}
diff --git a/tools/perf/arch/x86/util/header.c b/tools/perf/arch/x86/util/header.c
index b65856f3b846..5203e5cd151c 100644
--- a/tools/perf/arch/x86/util/header.c
+++ b/tools/perf/arch/x86/util/header.c
@@ -5,7 +5,6 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <regex.h>
 
 #include "../../../util/debug.h"
 #include "../../../util/header.h"
@@ -73,66 +72,3 @@ char *get_cpuid_str(struct perf_cpu cpu __maybe_unused)
 	}
 	return buf;
 }
-
-/* Full CPUID format for x86 is vendor-family-model-stepping */
-static bool is_full_cpuid(const char *id)
-{
-	const char *tmp = id;
-	int count = 0;
-
-	while ((tmp = strchr(tmp, '-')) != NULL) {
-		count++;
-		tmp++;
-	}
-
-	if (count == 3)
-		return true;
-
-	return false;
-}
-
-int strcmp_cpuid_str(uint16_t e_machine __maybe_unused, const char *mapcpuid, const char *id)
-{
-	regex_t re;
-	regmatch_t pmatch[1];
-	int match;
-	bool full_mapcpuid = is_full_cpuid(mapcpuid);
-	bool full_cpuid = is_full_cpuid(id);
-
-	/*
-	 * Full CPUID format is required to identify a platform.
-	 * Error out if the cpuid string is incomplete.
-	 */
-	if (full_mapcpuid && !full_cpuid) {
-		pr_info("Invalid CPUID %s. Full CPUID is required, "
-			"vendor-family-model-stepping\n", id);
-		return 1;
-	}
-
-	if (regcomp(&re, mapcpuid, REG_EXTENDED) != 0) {
-		/* Warn unable to generate match particular string. */
-		pr_info("Invalid regular expression %s\n", mapcpuid);
-		return 1;
-	}
-
-	match = !regexec(&re, id, 1, pmatch, 0);
-	regfree(&re);
-	if (match) {
-		size_t match_len = (pmatch[0].rm_eo - pmatch[0].rm_so);
-		size_t cpuid_len;
-
-		/* If the full CPUID format isn't required,
-		 * ignoring the stepping.
-		 */
-		if (!full_mapcpuid && full_cpuid)
-			cpuid_len = strrchr(id, '-') - id;
-		else
-			cpuid_len = strlen(id);
-
-		/* Verify the entire string matched. */
-		if (match_len == cpuid_len)
-			return 0;
-	}
-
-	return 1;
-}
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 38525b17f26d..a442f2a904a9 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -11,7 +11,10 @@
 
 #include <byteswap.h>
 #include <dirent.h>
+#include <elf.h>
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/bits.h>
 #include <linux/compiler.h>
 #include <linux/ctype.h>
 #include <linux/kernel.h>
@@ -960,12 +963,70 @@ char *get_cpuid_allow_env_override(struct perf_cpu cpu)
 	return cpuid;
 }
 
-/* Return zero when the cpuid from the mapfile.csv matches the
- * cpuid string generated on this platform.
- * Otherwise return non-zero.
+#define MIDR_REVISION_MASK	GENMASK(3, 0)
+#define MIDR_VARIANT_MASK	GENMASK(23, 20)
+
+/* Is @id a full x86 vendor-family-model-stepping CPUID, with 3 hyphens? */
+static bool is_full_x86_cpuid(const char *id)
+{
+	const char *tmp = id;
+	int count = 0;
+
+	while ((tmp = strchr(tmp, '-')) != NULL) {
+		count++;
+		tmp++;
+	}
+
+	return count == 3;
+}
+
+/*
+ * Compare arm64 MIDR values. Return 0 if @idstr is the same CPU type as
+ * @mapcpuid and its version, the Variant[23:20] and Revision[3:0] fields, is
+ * greater than or equal to that of @mapcpuid. Therefore, if @mapcpuid has 0 for
+ * the revision and variant then any version of @idstr will match as long as
+ * it's the same CPU type.
+ *
+ * Return 1 if the CPU type is different or the version of @idstr is lower.
  */
-int __weak strcmp_cpuid_str(uint16_t e_machine __maybe_unused, const char *mapcpuid,
-			    const char *cpuid)
+static int strcmp_arm64_cpuid_str(const char *mapcpuid, const char *idstr)
+{
+	u64 map_id = strtoull(mapcpuid, NULL, 16);
+	char map_id_variant = FIELD_GET(MIDR_VARIANT_MASK, map_id);
+	char map_id_revision = FIELD_GET(MIDR_REVISION_MASK, map_id);
+	u64 id = strtoull(idstr, NULL, 16);
+	char id_variant = FIELD_GET(MIDR_VARIANT_MASK, id);
+	char id_revision = FIELD_GET(MIDR_REVISION_MASK, id);
+	u64 id_fields = ~(MIDR_VARIANT_MASK | MIDR_REVISION_MASK);
+
+	/* Compare without version first. */
+	if ((map_id & id_fields) != (id & id_fields))
+		return 1;
+
+	/*
+	 * ID matches, now compare version.
+	 *
+	 * Arm revisions (like r0p0) are compared here like two digit semver
+	 * values eg. 1.3 < 2.0 < 2.1 < 2.2.
+	 *
+	 *  r = high value = 'Variant' field in MIDR
+	 *  p = low value  = 'Revision' field in MIDR
+	 */
+	if (id_variant > map_id_variant)
+		return 0;
+
+	if (id_variant == map_id_variant && id_revision >= map_id_revision)
+		return 0;
+
+	/*
+	 * Variant is less than mapfile variant or variants are the same but
+	 * the revision doesn't match. Return no match.
+	 */
+	return 1;
+}
+
+/* Return 0 if all of @cpuid matches the extended regular expression @mapcpuid. */
+static int strcmp_regex_cpuid_str(const char *mapcpuid, const char *cpuid)
 {
 	regex_t re;
 	regmatch_t pmatch[1];
@@ -989,6 +1050,96 @@ int __weak strcmp_cpuid_str(uint16_t e_machine __maybe_unused, const char *mapcp
 	return 1;
 }
 
+/*
+ * Compare x86 CPUIDs of the form vendor-family-model[-stepping]. A full
+ * @mapcpuid is stepping specific and requires a full @cpuid, otherwise the
+ * stepping of a full @cpuid is ignored.
+ */
+static int strcmp_x86_cpuid_str(const char *mapcpuid, const char *cpuid)
+{
+	unsigned int family, model, step;
+	char norm_buf[128], buf[128];
+	char vendor[32], extra;
+	bool full_mapcpuid, full_cpuid;
+
+	/* x86 get_cpuid() writes "vendor,family,model,step" in decimal. */
+	if (sscanf(cpuid, "%31[^,],%u,%u,%u%c", vendor, &family, &model, &step, &extra) == 4) {
+		snprintf(norm_buf, sizeof(norm_buf), "%s-%u-%X-%X", vendor, family, model, step);
+		cpuid = norm_buf;
+	}
+
+	full_mapcpuid = is_full_x86_cpuid(mapcpuid);
+	full_cpuid = is_full_x86_cpuid(cpuid);
+
+	/*
+	 * Full CPUID format is required to identify a stepping specific
+	 * platform. Error out if the cpuid string is incomplete.
+	 */
+	if (full_mapcpuid && !full_cpuid) {
+		pr_info("Invalid CPUID %s. Full CPUID is required, vendor-family-model-stepping\n",
+			cpuid);
+		return 1;
+	}
+
+	/* If the full CPUID format isn't required, ignore the stepping. */
+	if (!full_mapcpuid && full_cpuid) {
+		int len = strrchr(cpuid, '-') - cpuid;
+
+		snprintf(buf, sizeof(buf), "%.*s", len, cpuid);
+		cpuid = buf;
+	}
+	return strcmp_regex_cpuid_str(mapcpuid, cpuid);
+}
+
+/* Compare PowerPC PVR CPUIDs, matching @cpuid against the regex @mapcpuid. */
+static int strcmp_powerpc_cpuid_str(const char *mapcpuid, const char *cpuid)
+{
+	unsigned long pvr_ver, pvr_rev;
+	char norm_buf[32], extra;
+
+	/* PowerPC get_cpuid() writes "pvr_ver,pvr_rev" in decimal. */
+	if (sscanf(cpuid, "%lu,%lu%c", &pvr_ver, &pvr_rev, &extra) == 2) {
+		unsigned long pvr = ((pvr_ver & 0xffff) << 16) | (pvr_rev & 0xffff);
+
+		snprintf(norm_buf, sizeof(norm_buf), "0x%.8lx", pvr);
+		cpuid = norm_buf;
+	}
+	return strcmp_regex_cpuid_str(mapcpuid, cpuid);
+}
+
+/**
+ * strcmp_cpuid_str - Compare a pmu-events mapfile.csv CPUID with a CPUID.
+ * @e_machine: The ELF machine of the CPUIDs' architecture.
+ * @mapcpuid: The CPUID from the mapfile.csv, a regular expression for most
+ *            architectures.
+ * @cpuid: The CPUID from get_cpuid_str() or HEADER_CPUID.
+ *
+ * The test and common tables use EM_NONE and are compared exactly, arm64
+ * compares MIDR values and other architectures match @cpuid against the
+ * regular expression @mapcpuid. HEADER_CPUID values written by get_cpuid() on
+ * x86 and PowerPC differ from the get_cpuid_str() format of the mapfile.csv
+ * and are converted before matching.
+ *
+ * Return: 0 if the CPUIDs match, otherwise 1.
+ */
+int strcmp_cpuid_str(uint16_t e_machine, const char *mapcpuid, const char *cpuid)
+{
+	switch (e_machine) {
+	case EM_NONE:
+		return strcmp(mapcpuid, cpuid) ? 1 : 0;
+	case EM_AARCH64:
+		return strcmp_arm64_cpuid_str(mapcpuid, cpuid);
+	case EM_386:
+	case EM_X86_64:
+		return strcmp_x86_cpuid_str(mapcpuid, cpuid);
+	case EM_PPC:
+	case EM_PPC64:
+		return strcmp_powerpc_cpuid_str(mapcpuid, cpuid);
+	default:
+		return strcmp_regex_cpuid_str(mapcpuid, cpuid);
+	}
+}
+
 /*
  * default get_cpuid(): nothing gets recorded
  * actual implementation must be in arch/$(SRCARCH)/util/header.c
-- 
2.56.1.703.gf848ed807c-goog

