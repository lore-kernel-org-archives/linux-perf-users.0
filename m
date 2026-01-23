Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F2629D29D
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 22:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769206954; cv=none; b=YdH2noCGTkt12py6KPz5uwpWZFc87GvGfxB7bRXWzpycLzEwTUlz81XMtCZ7ANi8tULMfxgK/2yc6Y7VL4sP5Af5084cqTDPP1fvoMQrIMnWzaZTHZRxsPS+QSYZ5xNbl79BdO+lnaRA2Cg3Fgana9YF8wX/Gk76QKqrqiUzXAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769206954; c=relaxed/simple;
	bh=X+j6IMHaSqoAmjhFlIdC9P156kMZjNmv94D2iyUpGOA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=G/fxivswF4k9T0apC9vKvk/szODlnvKHn5paBGuGFsPqztnfqOr0NSh7JsQFZOTd9i6vU4HWMGd6DcFxSUNgge9wb3M+IIcRTtlyeCDL7DugtnXkp/g2ezbOboPfRunUzyq+VnruRan+bkMm/g6ziHICMMVzBDIwkzuUdDtXShc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mc5qzRas; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mc5qzRas"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b71041d135so2493574eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 14:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769206951; x=1769811751; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nNKLtKIqPJ9pdKccuJ/RLnEYZDsb6fUVRBWn7Y4Nmvo=;
        b=mc5qzRasM8DWVCf5P0LM/LCdM5ThEZNfEIQATmCYAmIy47Mr/hsb8bytu/UUSt6Ty5
         n0Z2FgAPczXEr5fGzN3FUkhinlU6qYLQbrIi83dWthhJ/MBnLU99il3Cbl123lx85t/u
         v+hdrB8P0DwDIh3I0B9Y5CQUxfT+fjJW9kO1E/VugD2dJOCVaFFp9o080FS9RQLkZWOa
         5+XhdHqbbrhVGHPODdQ4qfV69zJ02S5/12vPdtUfBV+2MNxzvqyQ1uS20hH6QZ+ZBL6N
         ukzQfeBOESTjNDrQE1QUJjjujdipEzp8aInFfdY5q3OUANBfiAZ8KrFaDvKY8ejVi5Ds
         6/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769206951; x=1769811751;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nNKLtKIqPJ9pdKccuJ/RLnEYZDsb6fUVRBWn7Y4Nmvo=;
        b=PMYWPiFGlp1B486izQzea9Gv3T5fzRuNgNaMgrhWY2263bUIG6RlxYLskCs9d44A+I
         UmS1MjZHsqIzYUXCUEGTreD30a4OVXABcT3p3AnnbxGYal++Xk3/IpbZGn2rO3DnxuC+
         1MB9tYgly1NikropYxdoln4Lfqvhny3FTBdrVvK3OwwutwbCVXhWdUcvNlkWrRsoXCrP
         JXBfhLExKCmyB4leKNfEBzCoZ2D6WHI6mJ7ojYqP6xcSpBcoIbmlr7Bl5w60caQqJV6L
         86iWeKCHhuEpA7wSEosRExBzZvRtCxg9sUr3ky22A0+7LR0yEdzkRNTcJiHlpk5scCxA
         p50g==
X-Forwarded-Encrypted: i=1; AJvYcCUvnftiWhGfgeySMfpYIeYmWZ+sQ7RHgAq3D1Re/ZMq+OHg5xA62IDmhtwOCCB97uwSwWAGH5qMZvDq817ttd5D@vger.kernel.org
X-Gm-Message-State: AOJu0YwIR3Bu8o7+aWgGJXMaXqI4MxhMuQPvi5Awvom9DmHcoswzg2Nx
	/gE7/rjcNdcvxBbHcoYEUo2XkE6gpctIA+SHlhPEvpCfKesFu6Vi132Y2zY3HdI1fzskS5IUuBb
	Mpdu39Yuk0A==
X-Received: from dyon5.prod.google.com ([2002:a05:7300:6d05:b0:2a4:733c:4a27])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4195:b0:2b6:bb18:c70a
 with SMTP id 5a478bee46e88-2b724819b28mr3711949eec.15.1769206950958; Fri, 23
 Jan 2026 14:22:30 -0800 (PST)
Date: Fri, 23 Jan 2026 14:22:08 -0800
In-Reply-To: <20260123222209.1181249-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260123222209.1181249-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260123222209.1181249-4-irogers@google.com>
Subject: [PATCH v1 3/4] perf perf_regs: Accurately compute register names for CSKY
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Guo Ren <guoren@kernel.org>, 
	Tianyou Li <tianyou.li@intel.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Aditya Bodkhe <aditya.b1@linux.ibm.com>, 
	Chun-Tse Shao <ctshao@google.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	Howard Chu <howardchu95@gmail.com>, Sergei Trofimovich <slyich@gmail.com>, 
	Shimin Guo <shimin.guo@skydio.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

CSKY needs the e_flags to determine the ABI level and know whether
additional registers are encoded or not. Wire this up now that the
e_flags for a thread can be determined.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c                   | 28 +++++++++++++------
 tools/perf/util/parse-regs-options.c          |  4 +--
 .../perf/util/perf-regs-arch/perf_regs_csky.c | 13 +++++----
 tools/perf/util/perf_regs.c                   |  4 +--
 tools/perf/util/perf_regs.h                   |  4 +--
 .../scripting-engines/trace-event-python.c    | 17 ++++++-----
 tools/perf/util/session.c                     | 24 ++++++++--------
 7 files changed, 56 insertions(+), 38 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 8c0de27a9713..6ec225c697a4 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -717,7 +717,8 @@ static int perf_session__check_output_opt(struct perf_session *session)
 	return 0;
 }
 
-static int perf_sample__fprintf_regs(struct regs_dump *regs, uint64_t mask, uint16_t e_machine,
+static int perf_sample__fprintf_regs(struct regs_dump *regs, uint64_t mask,
+				     uint16_t e_machine, uint32_t e_flags,
 				     FILE *fp)
 {
 	unsigned i = 0, r;
@@ -730,7 +731,9 @@ static int perf_sample__fprintf_regs(struct regs_dump *regs, uint64_t mask, uint
 
 	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
 		u64 val = regs->regs[i++];
-		printed += fprintf(fp, "%5s:0x%"PRIx64" ", perf_reg_name(r, e_machine), val);
+		printed += fprintf(fp, "%5s:0x%"PRIx64" ",
+				   perf_reg_name(r, e_machine, e_flags),
+				   val);
 	}
 
 	return printed;
@@ -787,23 +790,29 @@ tod_scnprintf(struct perf_script *script, char *buf, int buflen,
 }
 
 static int perf_sample__fprintf_iregs(struct perf_sample *sample,
-				      struct perf_event_attr *attr, uint16_t e_machine, FILE *fp)
+				      struct perf_event_attr *attr,
+				      uint16_t e_machine,
+				      uint32_t e_flags,
+				      FILE *fp)
 {
 	if (!sample->intr_regs)
 		return 0;
 
 	return perf_sample__fprintf_regs(perf_sample__intr_regs(sample),
-					 attr->sample_regs_intr, e_machine, fp);
+					 attr->sample_regs_intr, e_machine, e_flags, fp);
 }
 
 static int perf_sample__fprintf_uregs(struct perf_sample *sample,
-				      struct perf_event_attr *attr, uint16_t e_machine, FILE *fp)
+				      struct perf_event_attr *attr,
+				      uint16_t e_machine,
+				      uint32_t e_flags,
+				      FILE *fp)
 {
 	if (!sample->user_regs)
 		return 0;
 
 	return perf_sample__fprintf_regs(perf_sample__user_regs(sample),
-					 attr->sample_regs_user, e_machine, fp);
+					 attr->sample_regs_user, e_machine, e_flags, fp);
 }
 
 static int perf_sample__fprintf_start(struct perf_script *script,
@@ -2418,6 +2427,7 @@ static void process_event(struct perf_script *script,
 	struct evsel_script *es = evsel->priv;
 	FILE *fp = es->fp;
 	char str[PAGE_SIZE_NAME_LEN];
+	uint32_t e_flags;
 
 	if (output[type].fields == 0)
 		return;
@@ -2506,13 +2516,15 @@ static void process_event(struct perf_script *script,
 
 	if (PRINT_FIELD(IREGS)) {
 		perf_sample__fprintf_iregs(sample, attr,
-					   thread__e_machine(thread, machine, /*e_flags=*/NULL),
+					   thread__e_machine(thread, machine, &e_flags),
+					   e_flags,
 					   fp);
 	}
 
 	if (PRINT_FIELD(UREGS)) {
 		perf_sample__fprintf_uregs(sample, attr,
-					   thread__e_machine(thread, machine, /*e_flags=*/NULL),
+					   thread__e_machine(thread, machine, &e_flags),
+					   e_flags,
 					   fp);
 	}
 
diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
index c0d0ef9fd495..8dd35f50f644 100644
--- a/tools/perf/util/parse-regs-options.c
+++ b/tools/perf/util/parse-regs-options.c
@@ -21,7 +21,7 @@ static void list_perf_regs(FILE *fp, uint64_t mask)
 		if (((1ULL << reg) & mask) == 0)
 			continue;
 
-		name = perf_reg_name(reg, EM_HOST);
+		name = perf_reg_name(reg, EM_HOST, EF_HOST);
 		if (name && (!last_name || strcmp(last_name, name)))
 			fprintf(fp, "%s%s", reg > 0 ? " " : "", name);
 		last_name = name;
@@ -39,7 +39,7 @@ static uint64_t name_to_perf_reg_mask(const char *to_match, uint64_t mask)
 		if (((1ULL << reg) & mask) == 0)
 			continue;
 
-		name = perf_reg_name(reg, EM_HOST);
+		name = perf_reg_name(reg, EM_HOST, EF_HOST);
 		if (!name)
 			continue;
 
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_csky.c b/tools/perf/util/perf-regs-arch/perf_regs_csky.c
index 75b461ef2eba..d685b3fe418f 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_csky.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_csky.c
@@ -1,10 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0
-
+#include <elf.h>
 #include "../perf_regs.h"
+#undef __CSKYABIV2__
+#define __CSKYABIV2__ 1  // Always want the V2 register definitions.
 #include "../../arch/csky/include/uapi/asm/perf_regs.h"
 
-const char *__perf_reg_name_csky(int id)
+const char *__perf_reg_name_csky(int id, uint32_t e_flags)
 {
+	if (id >= PERF_REG_CSKY_EXREGS0 && (e_flags & EF_CSKY_ABIMASK) == EF_CSKY_ABIV2)
+		return NULL;
+
 	switch (id) {
 	case PERF_REG_CSKY_A0:
 		return "a0";
@@ -40,7 +45,6 @@ const char *__perf_reg_name_csky(int id)
 		return "lr";
 	case PERF_REG_CSKY_PC:
 		return "pc";
-#if defined(__CSKYABIV2__)
 	case PERF_REG_CSKY_EXREGS0:
 		return "exregs0";
 	case PERF_REG_CSKY_EXREGS1:
@@ -77,12 +81,9 @@ const char *__perf_reg_name_csky(int id)
 		return "hi";
 	case PERF_REG_CSKY_LO:
 		return "lo";
-#endif
 	default:
 		return NULL;
 	}
-
-	return NULL;
 }
 
 uint64_t __perf_reg_ip_csky(void)
diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
index cd5acee3dc62..14b7be30ab20 100644
--- a/tools/perf/util/perf_regs.c
+++ b/tools/perf/util/perf_regs.c
@@ -23,7 +23,7 @@ uint64_t __weak arch__user_reg_mask(void)
 	return 0;
 }
 
-const char *perf_reg_name(int id, uint16_t e_machine)
+const char *perf_reg_name(int id, uint16_t e_machine, uint32_t e_flags)
 {
 	const char *reg_name = NULL;
 
@@ -35,7 +35,7 @@ const char *perf_reg_name(int id, uint16_t e_machine)
 		reg_name = __perf_reg_name_arm64(id);
 		break;
 	case EM_CSKY:
-		reg_name = __perf_reg_name_csky(id);
+		reg_name = __perf_reg_name_csky(id, e_flags);
 		break;
 	case EM_LOONGARCH:
 		reg_name = __perf_reg_name_loongarch(id);
diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
index 2c2a8de6912d..ed7c1b1358fa 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -16,7 +16,7 @@ int arch_sdt_arg_parse_op(char *old_op, char **new_op);
 uint64_t arch__intr_reg_mask(void);
 uint64_t arch__user_reg_mask(void);
 
-const char *perf_reg_name(int id, uint16_t e_machine);
+const char *perf_reg_name(int id, uint16_t e_machine, uint32_t e_flags);
 int perf_reg_value(u64 *valp, struct regs_dump *regs, int id);
 uint64_t perf_arch_reg_ip(uint16_t e_machine);
 uint64_t perf_arch_reg_sp(uint16_t e_machine);
@@ -26,7 +26,7 @@ uint64_t __perf_reg_sp_arm64(void);
 const char *__perf_reg_name_arm(int id);
 uint64_t __perf_reg_ip_arm(void);
 uint64_t __perf_reg_sp_arm(void);
-const char *__perf_reg_name_csky(int id);
+const char *__perf_reg_name_csky(int id, uint32_t e_flags);
 uint64_t __perf_reg_ip_csky(void);
 uint64_t __perf_reg_sp_csky(void);
 const char *__perf_reg_name_loongarch(int id);
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 50f0d16520cc..62c9c73daef5 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -714,7 +714,8 @@ static void set_sample_datasrc_in_dict(PyObject *dict,
 			_PyUnicode_FromString(decode));
 }
 
-static void regs_map(struct regs_dump *regs, uint64_t mask, uint16_t e_machine, char *bf, int size)
+static void regs_map(struct regs_dump *regs, uint64_t mask, uint16_t e_machine, uint32_t e_flags,
+		     char *bf, int size)
 {
 	unsigned int i = 0, r;
 	int printed = 0;
@@ -732,7 +733,7 @@ static void regs_map(struct regs_dump *regs, uint64_t mask, uint16_t e_machine,
 
 		printed += scnprintf(bf + printed, size - printed,
 				     "%5s:0x%" PRIx64 " ",
-				     perf_reg_name(r, e_machine), val);
+				     perf_reg_name(r, e_machine, e_flags), val);
 	}
 }
 
@@ -741,7 +742,8 @@ static void regs_map(struct regs_dump *regs, uint64_t mask, uint16_t e_machine,
 static int set_regs_in_dict(PyObject *dict,
 			     struct perf_sample *sample,
 			     struct evsel *evsel,
-			     uint16_t e_machine)
+			     uint16_t e_machine,
+			     uint32_t e_flags)
 {
 	struct perf_event_attr *attr = &evsel->core.attr;
 
@@ -753,7 +755,7 @@ static int set_regs_in_dict(PyObject *dict,
 		if (!bf)
 			return -1;
 
-		regs_map(sample->intr_regs, attr->sample_regs_intr, e_machine, bf, size);
+		regs_map(sample->intr_regs, attr->sample_regs_intr, e_machine, e_flags, bf, size);
 
 		pydict_set_item_string_decref(dict, "iregs",
 					_PyUnicode_FromString(bf));
@@ -765,7 +767,7 @@ static int set_regs_in_dict(PyObject *dict,
 			if (!bf)
 				return -1;
 		}
-		regs_map(sample->user_regs, attr->sample_regs_user, e_machine, bf, size);
+		regs_map(sample->user_regs, attr->sample_regs_user, e_machine, e_flags, bf, size);
 
 		pydict_set_item_string_decref(dict, "uregs",
 					_PyUnicode_FromString(bf));
@@ -837,6 +839,7 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 	PyObject *dict, *dict_sample, *brstack, *brstacksym;
 	struct machine *machine;
 	uint16_t e_machine = EM_HOST;
+	uint32_t e_flags = EF_HOST;
 
 	dict = PyDict_New();
 	if (!dict)
@@ -925,9 +928,9 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 
 	if (al->thread) {
 		machine = maps__machine(thread__maps(al->thread));
-		e_machine = thread__e_machine(al->thread, machine, /*e_flags=*/NULL);
+		e_machine = thread__e_machine(al->thread, machine, &e_flags);
 	}
-	if (set_regs_in_dict(dict, sample, evsel, e_machine))
+	if (set_regs_in_dict(dict, sample, evsel, e_machine, e_flags))
 		Py_FatalError("Failed to setting regs in dict");
 
 	return dict;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 0e8a128d7c04..7c7c65b0f536 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -959,7 +959,7 @@ static void branch_stack__printf(struct perf_sample *sample,
 	}
 }
 
-static void regs_dump__printf(u64 mask, u64 *regs, uint16_t e_machine)
+static void regs_dump__printf(u64 mask, u64 *regs, uint16_t e_machine, uint32_t e_flags)
 {
 	unsigned rid, i = 0;
 
@@ -967,7 +967,7 @@ static void regs_dump__printf(u64 mask, u64 *regs, uint16_t e_machine)
 		u64 val = regs[i++];
 
 		printf(".... %-5s 0x%016" PRIx64 "\n",
-		       perf_reg_name(rid, e_machine), val);
+		       perf_reg_name(rid, e_machine, e_flags), val);
 	}
 }
 
@@ -985,7 +985,8 @@ static inline const char *regs_dump_abi(struct regs_dump *d)
 	return regs_abi[d->abi];
 }
 
-static void regs__printf(const char *type, struct regs_dump *regs, uint16_t e_machine)
+static void regs__printf(const char *type, struct regs_dump *regs,
+			 uint16_t e_machine, uint32_t e_flags)
 {
 	u64 mask = regs->mask;
 
@@ -994,10 +995,10 @@ static void regs__printf(const char *type, struct regs_dump *regs, uint16_t e_ma
 	       mask,
 	       regs_dump_abi(regs));
 
-	regs_dump__printf(mask, regs->regs, e_machine);
+	regs_dump__printf(mask, regs->regs, e_machine, e_flags);
 }
 
-static void regs_user__printf(struct perf_sample *sample, uint16_t e_machine)
+static void regs_user__printf(struct perf_sample *sample, uint16_t e_machine, uint32_t e_flags)
 {
 	struct regs_dump *user_regs;
 
@@ -1007,10 +1008,10 @@ static void regs_user__printf(struct perf_sample *sample, uint16_t e_machine)
 	user_regs = perf_sample__user_regs(sample);
 
 	if (user_regs->regs)
-		regs__printf("user", user_regs, e_machine);
+		regs__printf("user", user_regs, e_machine, e_flags);
 }
 
-static void regs_intr__printf(struct perf_sample *sample, uint16_t e_machine)
+static void regs_intr__printf(struct perf_sample *sample, uint16_t e_machine, uint32_t e_flags)
 {
 	struct regs_dump *intr_regs;
 
@@ -1020,7 +1021,7 @@ static void regs_intr__printf(struct perf_sample *sample, uint16_t e_machine)
 	intr_regs = perf_sample__intr_regs(sample);
 
 	if (intr_regs->regs)
-		regs__printf("intr", intr_regs, e_machine);
+		regs__printf("intr", intr_regs, e_machine, e_flags);
 }
 
 static void stack_user__printf(struct stack_dump *dump)
@@ -1115,6 +1116,7 @@ static void dump_sample(struct machine *machine, struct evsel *evsel, union perf
 	u64 sample_type;
 	char str[PAGE_SIZE_NAME_LEN];
 	uint16_t e_machine = EM_NONE;
+	uint32_t e_flags = 0;
 
 	if (!dump_trace)
 		return;
@@ -1124,7 +1126,7 @@ static void dump_sample(struct machine *machine, struct evsel *evsel, union perf
 	if (sample_type & (PERF_SAMPLE_REGS_USER | PERF_SAMPLE_REGS_INTR)) {
 		struct thread *thread = machine__find_thread(machine, sample->pid, sample->pid);
 
-		e_machine = thread__e_machine(thread, machine, /*e_flags=*/NULL);
+		e_machine = thread__e_machine(thread, machine, &e_flags);
 	}
 
 	printf("(IP, 0x%x): %d/%d: %#" PRIx64 " period: %" PRIu64 " addr: %#" PRIx64 "\n",
@@ -1138,10 +1140,10 @@ static void dump_sample(struct machine *machine, struct evsel *evsel, union perf
 		branch_stack__printf(sample, evsel);
 
 	if (sample_type & PERF_SAMPLE_REGS_USER)
-		regs_user__printf(sample, e_machine);
+		regs_user__printf(sample, e_machine, e_flags);
 
 	if (sample_type & PERF_SAMPLE_REGS_INTR)
-		regs_intr__printf(sample, e_machine);
+		regs_intr__printf(sample, e_machine, e_flags);
 
 	if (sample_type & PERF_SAMPLE_STACK_USER)
 		stack_user__printf(&sample->user_stack);
-- 
2.52.0.457.g6b5491de43-goog

