Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367AC32AAAE
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Jan 2026 05:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768627777; cv=none; b=avvicI6r0CPomc9nJe8Z5HNGNpflZMNi62Hl7pYIcX0WL80qM/rPopl366Gn4LA0TMS0fHphTQ+7gtZNUi3ujLIw4h/+BWdlPm3BWw/ttArFkfrmbawVSayJWYHEjkKBaXJHNd7B5+SFgW3L8lDoUf9511WiHbQSJ/qWkkCP1dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768627777; c=relaxed/simple;
	bh=KYMlIYaO4TFVGe4X8XgmkKM5kQetl6AIq2SNvs1o89Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=e3ucm+Ea02YEC+i38ePH8yob7AtixWEctLPCrsn87JjB+iNvxDrMgYpy4w1JldMJFSs7uaEKYSfoto0Nne81jQgA4FrjP3O/2FzGnHBCMqOF1zOM45TQz2wB21RIjbF0ptjg3ACJJD2yBMwV/W1lwoDLDqX0o/NNuLbSNwyRBkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=etkslVtf; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="etkslVtf"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-11b94abc09dso5088553c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Jan 2026 21:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768627774; x=1769232574; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1S66FILKRfXMvRmBPDp7wjeWNFb1HGCJm/Z2kIzT3UE=;
        b=etkslVtf+WabkqxmYU0hOpR+zkX8Vw5nHTrbcPa6GQt4QbTbomCCLjlP3qnQW3y/Bw
         03hvruFfEqtgcK/11st2jj78BKjUgYA1opueROPJJ4VSA8u2iD34gacXcRZK1dEMqBq7
         TYYTyniY+TE0DG3mkNRLlmf3oS3R1rfNnSTq0vCSyjqGQBNpWDypgEld4x2HHNyty7A1
         OWWoVLzexmaLE2p2+qh3Y68dTKHNK2w8SXtkFJPZcieKXzzUjdP0fqhmoN+Scp259t5l
         djbXzoURbu9+wPvEITjIetiU3njp5uwSuYZp9UuP4wnUGFzdZHQZjld9A68GQUEW64Px
         Zggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768627774; x=1769232574;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1S66FILKRfXMvRmBPDp7wjeWNFb1HGCJm/Z2kIzT3UE=;
        b=fr+94hag/XAfRE53tItir07dBf/+h/NA2zQtEndcIj2wznOinf3AvvWWMeqnEL9RiX
         LUfD/0pXm7LQwMe6KBGEGxFEV2cbvDBbaAonz8C2DXUhplvCzYG7hng9ILEpjXuqjrW6
         FeksH/fVpFVukUTOxm8QvauLrxEvkIjEuiDNnSdw6E7EhvjlMHTpRGYlj43rxhLgpCBb
         AJFdBJ2WFb1r+QQIcPsTCtIuoCYn6d8MvN1Rvpr2r2t9pJg8NW5J7I4bjxRAeWOcQMrX
         RCTmyWcZ+Qan23OrB2F4rkUNy865Q4OwqtajRfEO/2Lv3arWvY8rCwYijJt6A86msNnL
         4ldw==
X-Forwarded-Encrypted: i=1; AJvYcCWUBrQrSm7jl/SqqhUkGvHUBLxGt5zmXQCKZXdsQu0dS1PijxQ0FtaN6DqV7cQUPDzHapvIBfZlrUqQ8Hru/M11@vger.kernel.org
X-Gm-Message-State: AOJu0YxisDkXrLJp4VpU9/myxqrHL1xCJE2h1RdBJK+/F9XHjPwwCREa
	eAqxozz8agKrwWRk35eQCAuFGU2P3kmS19DrxNFy1O3gJeSuKWIsP0IW8E7g7ABE8tW0THtCDoj
	zxlcBxWZ/zg==
X-Received: from dlag7.prod.google.com ([2002:a05:701b:2507:b0:11f:3043:2c7f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:b93:b0:123:3508:893f
 with SMTP id a92af1059eb24-1244a765c10mr3680068c88.31.1768627774218; Fri, 16
 Jan 2026 21:29:34 -0800 (PST)
Date: Fri, 16 Jan 2026 21:28:34 -0800
In-Reply-To: <20260117052849.2205545-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260117052849.2205545-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260117052849.2205545-9-irogers@google.com>
Subject: [PATCH v1 08/23] perf perf_regs: Switch from arch string to int e_machine
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Shimin Guo <shimin.guo@skydio.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Dmitry Vyukov <dvyukov@google.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Chun-Tse Shao <ctshao@google.com>, 
	Aditya Bodkhe <aditya.b1@linux.ibm.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Wielaard <mark@klomp.org>
Content-Type: text/plain; charset="UTF-8"

The arch string requires multiple strcmp to identify things like the
IP and SP. Switch to passing in an e_machine that in the bulk of cases
is computed using a current thread load. The e_machine also allows
identification of 32-bit vs 64-bit processes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c                   |  17 ++-
 tools/perf/util/evsel.c                       |  14 ++-
 tools/perf/util/perf_regs.c                   | 105 +++++++++++-------
 tools/perf/util/perf_regs.h                   |  10 +-
 .../scripting-engines/trace-event-python.c    |  21 ++--
 tools/perf/util/session.c                     |  65 ++++++++---
 tools/perf/util/session.h                     |   1 +
 tools/perf/util/unwind-libdw.c                |  12 +-
 tools/perf/util/unwind-libunwind-local.c      |   7 +-
 9 files changed, 164 insertions(+), 88 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 62e43d3c5ad7..372bede30230 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -717,7 +717,7 @@ static int perf_session__check_output_opt(struct perf_session *session)
 	return 0;
 }
 
-static int perf_sample__fprintf_regs(struct regs_dump *regs, uint64_t mask, const char *arch,
+static int perf_sample__fprintf_regs(struct regs_dump *regs, uint64_t mask, uint16_t e_machine,
 				     FILE *fp)
 {
 	unsigned i = 0, r;
@@ -730,7 +730,7 @@ static int perf_sample__fprintf_regs(struct regs_dump *regs, uint64_t mask, cons
 
 	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
 		u64 val = regs->regs[i++];
-		printed += fprintf(fp, "%5s:0x%"PRIx64" ", perf_reg_name(r, arch), val);
+		printed += fprintf(fp, "%5s:0x%"PRIx64" ", perf_reg_name(r, e_machine), val);
 	}
 
 	return printed;
@@ -787,23 +787,23 @@ tod_scnprintf(struct perf_script *script, char *buf, int buflen,
 }
 
 static int perf_sample__fprintf_iregs(struct perf_sample *sample,
-				      struct perf_event_attr *attr, const char *arch, FILE *fp)
+				      struct perf_event_attr *attr, uint16_t e_machine, FILE *fp)
 {
 	if (!sample->intr_regs)
 		return 0;
 
 	return perf_sample__fprintf_regs(perf_sample__intr_regs(sample),
-					 attr->sample_regs_intr, arch, fp);
+					 attr->sample_regs_intr, e_machine, fp);
 }
 
 static int perf_sample__fprintf_uregs(struct perf_sample *sample,
-				      struct perf_event_attr *attr, const char *arch, FILE *fp)
+				      struct perf_event_attr *attr, uint16_t e_machine, FILE *fp)
 {
 	if (!sample->user_regs)
 		return 0;
 
 	return perf_sample__fprintf_regs(perf_sample__user_regs(sample),
-					 attr->sample_regs_user, arch, fp);
+					 attr->sample_regs_user, e_machine, fp);
 }
 
 static int perf_sample__fprintf_start(struct perf_script *script,
@@ -2418,7 +2418,6 @@ static void process_event(struct perf_script *script,
 	struct evsel_script *es = evsel->priv;
 	FILE *fp = es->fp;
 	char str[PAGE_SIZE_NAME_LEN];
-	const char *arch = perf_env__arch(machine->env);
 
 	if (output[type].fields == 0)
 		return;
@@ -2506,10 +2505,10 @@ static void process_event(struct perf_script *script,
 	}
 
 	if (PRINT_FIELD(IREGS))
-		perf_sample__fprintf_iregs(sample, attr, arch, fp);
+		perf_sample__fprintf_iregs(sample, attr, thread__e_machine(thread, machine), fp);
 
 	if (PRINT_FIELD(UREGS))
-		perf_sample__fprintf_uregs(sample, attr, arch, fp);
+		perf_sample__fprintf_uregs(sample, attr, thread__e_machine(thread, machine), fp);
 
 	if (PRINT_FIELD(BRSTACK))
 		perf_sample__fprintf_brstack(sample, thread, evsel, fp);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 6d324141588c..5ac1a05601b1 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -34,6 +34,7 @@
 #include "callchain.h"
 #include "cgroup.h"
 #include "counts.h"
+#include "dwarf-regs.h"
 #include "event.h"
 #include "evsel.h"
 #include "time-utils.h"
@@ -1007,6 +1008,13 @@ int evsel__group_desc(struct evsel *evsel, char *buf, size_t size)
 	return ret;
 }
 
+static uint16_t evsel__e_machine(struct evsel *evsel)
+{
+	struct perf_session *session = evsel__session(evsel);
+
+	return session ? perf_session__e_machine(session) : EM_HOST;
+}
+
 static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *opts,
 				      struct callchain_param *param)
 {
@@ -1042,13 +1050,13 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
 
 	if (param->record_mode == CALLCHAIN_DWARF) {
 		if (!function) {
-			const char *arch = perf_env__arch(evsel__env(evsel));
+			uint16_t e_machine = evsel__e_machine(evsel);
 
 			evsel__set_sample_bit(evsel, REGS_USER);
 			evsel__set_sample_bit(evsel, STACK_USER);
 			if (opts->sample_user_regs &&
-			    DWARF_MINIMAL_REGS(arch) != arch__user_reg_mask()) {
-				attr->sample_regs_user |= DWARF_MINIMAL_REGS(arch);
+			    DWARF_MINIMAL_REGS(e_machine) != arch__user_reg_mask()) {
+				attr->sample_regs_user |= DWARF_MINIMAL_REGS(e_machine);
 				pr_warning("WARNING: The use of --call-graph=dwarf may require all the user registers, "
 					   "specifying a subset with --user-regs may render DWARF unwinding unreliable, "
 					   "so the minimal registers set (IP, SP) is explicitly forced.\n");
diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
index 44b90bbf2d07..b58d59b84fb1 100644
--- a/tools/perf/util/perf_regs.c
+++ b/tools/perf/util/perf_regs.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <elf.h>
 #include <errno.h>
 #include <string.h>
 #include "perf_regs.h"
@@ -30,30 +31,48 @@ const struct sample_reg * __weak arch__sample_reg_masks(void)
 	return sample_reg_masks;
 }
 
-const char *perf_reg_name(int id, const char *arch)
+const char *perf_reg_name(int id, uint16_t e_machine)
 {
 	const char *reg_name = NULL;
 
-	if (!strcmp(arch, "csky"))
+	switch (e_machine) {
+	case EM_ARM:
+		reg_name = __perf_reg_name_arm(id);
+		break;
+	case EM_AARCH64:
+		reg_name = __perf_reg_name_arm64(id);
+		break;
+	case EM_CSKY:
 		reg_name = __perf_reg_name_csky(id);
-	else if (!strcmp(arch, "loongarch"))
+		break;
+	case EM_LOONGARCH:
 		reg_name = __perf_reg_name_loongarch(id);
-	else if (!strcmp(arch, "mips"))
+		break;
+	case EM_MIPS:
 		reg_name = __perf_reg_name_mips(id);
-	else if (!strcmp(arch, "powerpc"))
+		break;
+	case EM_PPC:
+	case EM_PPC64:
 		reg_name = __perf_reg_name_powerpc(id);
-	else if (!strcmp(arch, "riscv"))
+		break;
+	case EM_RISCV:
 		reg_name = __perf_reg_name_riscv(id);
-	else if (!strcmp(arch, "s390"))
+		break;
+	case EM_S390:
 		reg_name = __perf_reg_name_s390(id);
-	else if (!strcmp(arch, "x86"))
+		break;
+	case EM_386:
+	case EM_X86_64:
 		reg_name = __perf_reg_name_x86(id);
-	else if (!strcmp(arch, "arm"))
-		reg_name = __perf_reg_name_arm(id);
-	else if (!strcmp(arch, "arm64"))
-		reg_name = __perf_reg_name_arm64(id);
+		break;
+	default:
+		break;
+	}
+	if (reg_name)
+		return reg_name;
 
-	return reg_name ?: "unknown";
+	pr_debug("Failed to find register %d for ELF machine type %u\n", id, e_machine);
+	return "unknown";
 }
 
 int perf_reg_value(u64 *valp, struct regs_dump *regs, int id)
@@ -83,52 +102,60 @@ int perf_reg_value(u64 *valp, struct regs_dump *regs, int id)
 	return 0;
 }
 
-uint64_t perf_arch_reg_ip(const char *arch)
+uint64_t perf_arch_reg_ip(uint16_t e_machine)
 {
-	if (!strcmp(arch, "arm"))
+	switch (e_machine) {
+	case EM_ARM:
 		return __perf_reg_ip_arm();
-	else if (!strcmp(arch, "arm64"))
+	case EM_AARCH64:
 		return __perf_reg_ip_arm64();
-	else if (!strcmp(arch, "csky"))
+	case EM_CSKY:
 		return __perf_reg_ip_csky();
-	else if (!strcmp(arch, "loongarch"))
+	case EM_LOONGARCH:
 		return __perf_reg_ip_loongarch();
-	else if (!strcmp(arch, "mips"))
+	case EM_MIPS:
 		return __perf_reg_ip_mips();
-	else if (!strcmp(arch, "powerpc"))
+	case EM_PPC:
+	case EM_PPC64:
 		return __perf_reg_ip_powerpc();
-	else if (!strcmp(arch, "riscv"))
+	case EM_RISCV:
 		return __perf_reg_ip_riscv();
-	else if (!strcmp(arch, "s390"))
+	case EM_S390:
 		return __perf_reg_ip_s390();
-	else if (!strcmp(arch, "x86"))
+	case EM_386:
+	case EM_X86_64:
 		return __perf_reg_ip_x86();
-
-	pr_err("Fail to find IP register for arch %s, returns 0\n", arch);
-	return 0;
+	default:
+		pr_err("Failed to find IP register for ELF machine type %u\n", e_machine);
+		return 0;
+	}
 }
 
-uint64_t perf_arch_reg_sp(const char *arch)
+uint64_t perf_arch_reg_sp(uint16_t e_machine)
 {
-	if (!strcmp(arch, "arm"))
+	switch (e_machine) {
+	case EM_ARM:
 		return __perf_reg_sp_arm();
-	else if (!strcmp(arch, "arm64"))
+	case EM_AARCH64:
 		return __perf_reg_sp_arm64();
-	else if (!strcmp(arch, "csky"))
+	case EM_CSKY:
 		return __perf_reg_sp_csky();
-	else if (!strcmp(arch, "loongarch"))
+	case EM_LOONGARCH:
 		return __perf_reg_sp_loongarch();
-	else if (!strcmp(arch, "mips"))
+	case EM_MIPS:
 		return __perf_reg_sp_mips();
-	else if (!strcmp(arch, "powerpc"))
+	case EM_PPC:
+	case EM_PPC64:
 		return __perf_reg_sp_powerpc();
-	else if (!strcmp(arch, "riscv"))
+	case EM_RISCV:
 		return __perf_reg_sp_riscv();
-	else if (!strcmp(arch, "s390"))
+	case EM_S390:
 		return __perf_reg_sp_s390();
-	else if (!strcmp(arch, "x86"))
+	case EM_386:
+	case EM_X86_64:
 		return __perf_reg_sp_x86();
-
-	pr_err("Fail to find SP register for arch %s, returns 0\n", arch);
-	return 0;
+	default:
+		pr_err("Failed to find SP register for ELF machine type %u\n", e_machine);
+		return 0;
+	}
 }
diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
index f2d0736d65cc..7bfc6a34c02b 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -28,10 +28,10 @@ uint64_t arch__intr_reg_mask(void);
 uint64_t arch__user_reg_mask(void);
 const struct sample_reg *arch__sample_reg_masks(void);
 
-const char *perf_reg_name(int id, const char *arch);
+const char *perf_reg_name(int id, uint16_t e_machine);
 int perf_reg_value(u64 *valp, struct regs_dump *regs, int id);
-uint64_t perf_arch_reg_ip(const char *arch);
-uint64_t perf_arch_reg_sp(const char *arch);
+uint64_t perf_arch_reg_ip(uint16_t e_machine);
+uint64_t perf_arch_reg_sp(uint16_t e_machine);
 const char *__perf_reg_name_arm64(int id);
 uint64_t __perf_reg_ip_arm64(void);
 uint64_t __perf_reg_sp_arm64(void);
@@ -60,9 +60,9 @@ const char *__perf_reg_name_x86(int id);
 uint64_t __perf_reg_ip_x86(void);
 uint64_t __perf_reg_sp_x86(void);
 
-static inline uint64_t DWARF_MINIMAL_REGS(const char *arch)
+static inline uint64_t DWARF_MINIMAL_REGS(uint16_t e_machine)
 {
-	return (1ULL << perf_arch_reg_ip(arch)) | (1ULL << perf_arch_reg_sp(arch));
+	return (1ULL << perf_arch_reg_ip(e_machine)) | (1ULL << perf_arch_reg_sp(e_machine));
 }
 
 #endif /* __PERF_REGS_H */
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 6655c0bbe0d8..b90edc147796 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -50,6 +50,7 @@
 #include "../thread-stack.h"
 #include "../trace-event.h"
 #include "../call-path.h"
+#include "dwarf-regs.h"
 #include "map.h"
 #include "symbol.h"
 #include "thread_map.h"
@@ -713,7 +714,7 @@ static void set_sample_datasrc_in_dict(PyObject *dict,
 			_PyUnicode_FromString(decode));
 }
 
-static void regs_map(struct regs_dump *regs, uint64_t mask, const char *arch, char *bf, int size)
+static void regs_map(struct regs_dump *regs, uint64_t mask, uint16_t e_machine, char *bf, int size)
 {
 	unsigned int i = 0, r;
 	int printed = 0;
@@ -731,7 +732,7 @@ static void regs_map(struct regs_dump *regs, uint64_t mask, const char *arch, ch
 
 		printed += scnprintf(bf + printed, size - printed,
 				     "%5s:0x%" PRIx64 " ",
-				     perf_reg_name(r, arch), val);
+				     perf_reg_name(r, e_machine), val);
 	}
 }
 
@@ -739,10 +740,10 @@ static void regs_map(struct regs_dump *regs, uint64_t mask, const char *arch, ch
 
 static int set_regs_in_dict(PyObject *dict,
 			     struct perf_sample *sample,
-			     struct evsel *evsel)
+			     struct evsel *evsel,
+			     uint16_t e_machine)
 {
 	struct perf_event_attr *attr = &evsel->core.attr;
-	const char *arch = perf_env__arch(evsel__env(evsel));
 
 	int size = (__sw_hweight64(attr->sample_regs_intr) * MAX_REG_SIZE) + 1;
 	char *bf = NULL;
@@ -752,7 +753,7 @@ static int set_regs_in_dict(PyObject *dict,
 		if (!bf)
 			return -1;
 
-		regs_map(sample->intr_regs, attr->sample_regs_intr, arch, bf, size);
+		regs_map(sample->intr_regs, attr->sample_regs_intr, e_machine, bf, size);
 
 		pydict_set_item_string_decref(dict, "iregs",
 					_PyUnicode_FromString(bf));
@@ -764,7 +765,7 @@ static int set_regs_in_dict(PyObject *dict,
 			if (!bf)
 				return -1;
 		}
-		regs_map(sample->user_regs, attr->sample_regs_user, arch, bf, size);
+		regs_map(sample->user_regs, attr->sample_regs_user, e_machine, bf, size);
 
 		pydict_set_item_string_decref(dict, "uregs",
 					_PyUnicode_FromString(bf));
@@ -834,6 +835,8 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 					 PyObject *callchain)
 {
 	PyObject *dict, *dict_sample, *brstack, *brstacksym;
+	struct machine *machine;
+	uint16_t e_machine = EM_HOST;
 
 	dict = PyDict_New();
 	if (!dict)
@@ -920,7 +923,11 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 			PyLong_FromUnsignedLongLong(sample->cyc_cnt));
 	}
 
-	if (set_regs_in_dict(dict, sample, evsel))
+	if (al->thread) {
+		machine = maps__machine(thread__maps(al->thread));
+		e_machine = thread__e_machine(al->thread, machine);
+	}
+	if (set_regs_in_dict(dict, sample, evsel, e_machine))
 		Py_FatalError("Failed to setting regs in dict");
 
 	return dict;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 922ef6577bbb..d7b28cb4e672 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -17,6 +17,7 @@
 #include "map_symbol.h"
 #include "branch.h"
 #include "debug.h"
+#include "dwarf-regs.h"
 #include "env.h"
 #include "evlist.h"
 #include "evsel.h"
@@ -942,7 +943,7 @@ static void branch_stack__printf(struct perf_sample *sample,
 	}
 }
 
-static void regs_dump__printf(u64 mask, u64 *regs, const char *arch)
+static void regs_dump__printf(u64 mask, u64 *regs, uint16_t e_machine)
 {
 	unsigned rid, i = 0;
 
@@ -950,7 +951,7 @@ static void regs_dump__printf(u64 mask, u64 *regs, const char *arch)
 		u64 val = regs[i++];
 
 		printf(".... %-5s 0x%016" PRIx64 "\n",
-		       perf_reg_name(rid, arch), val);
+		       perf_reg_name(rid, e_machine), val);
 	}
 }
 
@@ -968,7 +969,7 @@ static inline const char *regs_dump_abi(struct regs_dump *d)
 	return regs_abi[d->abi];
 }
 
-static void regs__printf(const char *type, struct regs_dump *regs, const char *arch)
+static void regs__printf(const char *type, struct regs_dump *regs, uint16_t e_machine)
 {
 	u64 mask = regs->mask;
 
@@ -977,10 +978,10 @@ static void regs__printf(const char *type, struct regs_dump *regs, const char *a
 	       mask,
 	       regs_dump_abi(regs));
 
-	regs_dump__printf(mask, regs->regs, arch);
+	regs_dump__printf(mask, regs->regs, e_machine);
 }
 
-static void regs_user__printf(struct perf_sample *sample, const char *arch)
+static void regs_user__printf(struct perf_sample *sample, uint16_t e_machine)
 {
 	struct regs_dump *user_regs;
 
@@ -990,10 +991,10 @@ static void regs_user__printf(struct perf_sample *sample, const char *arch)
 	user_regs = perf_sample__user_regs(sample);
 
 	if (user_regs->regs)
-		regs__printf("user", user_regs, arch);
+		regs__printf("user", user_regs, e_machine);
 }
 
-static void regs_intr__printf(struct perf_sample *sample, const char *arch)
+static void regs_intr__printf(struct perf_sample *sample, uint16_t e_machine)
 {
 	struct regs_dump *intr_regs;
 
@@ -1003,7 +1004,7 @@ static void regs_intr__printf(struct perf_sample *sample, const char *arch)
 	intr_regs = perf_sample__intr_regs(sample);
 
 	if (intr_regs->regs)
-		regs__printf("intr", intr_regs, arch);
+		regs__printf("intr", intr_regs, e_machine);
 }
 
 static void stack_user__printf(struct stack_dump *dump)
@@ -1092,21 +1093,28 @@ char *get_page_size_name(u64 size, char *str)
 	return str;
 }
 
-static void dump_sample(struct evsel *evsel, union perf_event *event,
-			struct perf_sample *sample, const char *arch)
+static void dump_sample(struct machine *machine, struct evsel *evsel, union perf_event *event,
+			struct perf_sample *sample)
 {
 	u64 sample_type;
 	char str[PAGE_SIZE_NAME_LEN];
+	uint16_t e_machine = EM_NONE;
 
 	if (!dump_trace)
 		return;
 
+	sample_type = evsel->core.attr.sample_type;
+
+	if (sample_type & (PERF_SAMPLE_REGS_USER | PERF_SAMPLE_REGS_INTR)) {
+		struct thread *thread = machine__find_thread(machine, sample->pid, sample->pid);
+
+		e_machine = thread__e_machine(thread, machine);
+	}
+
 	printf("(IP, 0x%x): %d/%d: %#" PRIx64 " period: %" PRIu64 " addr: %#" PRIx64 "\n",
 	       event->header.misc, sample->pid, sample->tid, sample->ip,
 	       sample->period, sample->addr);
 
-	sample_type = evsel->core.attr.sample_type;
-
 	if (evsel__has_callchain(evsel))
 		callchain__printf(evsel, sample);
 
@@ -1114,10 +1122,10 @@ static void dump_sample(struct evsel *evsel, union perf_event *event,
 		branch_stack__printf(sample, evsel);
 
 	if (sample_type & PERF_SAMPLE_REGS_USER)
-		regs_user__printf(sample, arch);
+		regs_user__printf(sample, e_machine);
 
 	if (sample_type & PERF_SAMPLE_REGS_INTR)
-		regs_intr__printf(sample, arch);
+		regs_intr__printf(sample, e_machine);
 
 	if (sample_type & PERF_SAMPLE_STACK_USER)
 		stack_user__printf(&sample->user_stack);
@@ -1432,10 +1440,10 @@ static int machines__deliver_event(struct machines *machines,
 		}
 		if (machine == NULL) {
 			++evlist->stats.nr_unprocessable_samples;
-			dump_sample(evsel, event, sample, perf_env__arch(NULL));
+			dump_sample(machine, evsel, event, sample);
 			return 0;
 		}
-		dump_sample(evsel, event, sample, perf_env__arch(machine->env));
+		dump_sample(machine, evsel, event, sample);
 		if (sample->deferred_callchain && tool->merge_deferred_callchains) {
 			struct deferred_event *de = malloc(sizeof(*de));
 			size_t sz = event->header.size;
@@ -2928,3 +2936,28 @@ struct perf_env *perf_session__env(struct perf_session *session)
 {
 	return &session->header.env;
 }
+
+static int perf_session__e_machine_cb(struct thread *thread,
+				      void *arg __maybe_unused)
+{
+	uint16_t *result = arg;
+	struct machine *machine = maps__machine(thread__maps(thread));
+
+	*result = thread__e_machine(thread, machine);
+	return *result != EM_NONE ? 1 : 0;
+}
+
+/*
+ * Note, a machine may have mixed 32-bit and 64-bit processes and so mixed
+ * e_machines. Use thread__e_machine when this matters.
+ */
+uint16_t perf_session__e_machine(struct perf_session *session)
+{
+	uint16_t e_machine = EM_NONE;
+
+	machines__for_each_thread(&session->machines,
+					 perf_session__e_machine_cb,
+					 &e_machine);
+
+	return e_machine == EM_NONE ? EM_HOST : e_machine;
+}
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index 22d3ff877e83..eddc4c630b33 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -211,5 +211,6 @@ int perf_event__process_finished_round(const struct perf_tool *tool,
 				       struct ordered_events *oe);
 
 struct perf_env *perf_session__env(struct perf_session *session);
+uint16_t perf_session__e_machine(struct perf_session *session);
 
 #endif /* __PERF_SESSION_H */
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index dc882f17f52d..c25190cdceb4 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -187,7 +187,7 @@ static bool memory_read(Dwfl *dwfl __maybe_unused, Dwarf_Addr addr, Dwarf_Word *
 			void *arg)
 {
 	struct unwind_info *ui = arg;
-	const char *arch = perf_env__arch(ui->machine->env);
+	uint16_t e_machine = thread__e_machine(ui->thread, ui->machine);
 	struct stack_dump *stack = &ui->sample->user_stack;
 	u64 start, end;
 	int offset;
@@ -197,7 +197,7 @@ static bool memory_read(Dwfl *dwfl __maybe_unused, Dwarf_Addr addr, Dwarf_Word *
 		return false;
 
 	ret = perf_reg_value(&start, ui->sample->user_regs,
-			     perf_arch_reg_sp(arch));
+			     perf_arch_reg_sp(e_machine));
 	if (ret)
 		return false;
 
@@ -300,16 +300,18 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
 			int max_stack,
 			bool best_effort)
 {
+	struct machine *machine = maps__machine(thread__maps(thread));
 	struct unwind_info *ui, ui_buf = {
 		.sample		= data,
 		.thread		= thread,
-		.machine	= maps__machine((thread__maps(thread))),
+		.machine	= machine,
 		.cb		= cb,
 		.arg		= arg,
 		.max_stack	= max_stack,
 		.best_effort    = best_effort
 	};
-	const char *arch = perf_env__arch(ui_buf.machine->env);
+	uint16_t e_machine = thread__e_machine(thread, machine);
+	const char *arch = perf_env__arch(machine->env);
 	Dwarf_Word ip;
 	int err = -EINVAL, i;
 	const Dwfl_Thread_Callbacks *callbacks;
@@ -327,7 +329,7 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
 	if (!ui->dwfl)
 		goto out;
 
-	err = perf_reg_value(&ip, data->user_regs, perf_arch_reg_ip(arch));
+	err = perf_reg_value(&ip, data->user_regs, perf_arch_reg_ip(e_machine));
 	if (err)
 		goto out;
 
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 0b037e7389a0..a24b45106acd 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -572,7 +572,6 @@ static int access_mem(unw_addr_space_t __maybe_unused as,
 		      int __write, void *arg)
 {
 	struct unwind_info *ui = arg;
-	const char *arch = perf_env__arch(ui->machine->env);
 	struct stack_dump *stack = &ui->sample->user_stack;
 	u64 start, end;
 	int offset;
@@ -585,7 +584,7 @@ static int access_mem(unw_addr_space_t __maybe_unused as,
 	}
 
 	ret = perf_reg_value(&start, perf_sample__user_regs(ui->sample),
-			     perf_arch_reg_sp(arch));
+			     perf_arch_reg_sp(thread__e_machine(ui->thread, ui->machine)));
 	if (ret)
 		return ret;
 
@@ -734,7 +733,7 @@ static void _unwind__finish_access(struct maps *maps)
 static int get_entries(struct unwind_info *ui, unwind_entry_cb_t cb,
 		       void *arg, int max_stack)
 {
-	const char *arch = perf_env__arch(ui->machine->env);
+	uint16_t e_machine = thread__e_machine(ui->thread, ui->machine);
 	u64 val;
 	unw_word_t ips[max_stack];
 	unw_addr_space_t addr_space;
@@ -742,7 +741,7 @@ static int get_entries(struct unwind_info *ui, unwind_entry_cb_t cb,
 	int ret, i = 0;
 
 	ret = perf_reg_value(&val, perf_sample__user_regs(ui->sample),
-			     perf_arch_reg_ip(arch));
+			     perf_arch_reg_ip(e_machine));
 	if (ret)
 		return ret;
 
-- 
2.52.0.457.g6b5491de43-goog

