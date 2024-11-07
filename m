Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC2D1DE8A5
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Nov 2024 07:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730963771; cv=none; b=BNlTLSnmDMYehgAy9l1rOzX8loEl6YnnM5px0VBIvulJqU8thmQbGBmxM91I/Rk6SqazFxOYUOIYqdMP5NzvKeXHn0SvQ9RvHtbyYR4F6wzVhC+b7tRpjrtXIsp74c83IKkSfKRWfC6IUU4cy/IaPufxnZacqhgPgcwcczdRrp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730963771; c=relaxed/simple;
	bh=UGgs7qpyQsaOAD/+38PffSoTksURxSZGP6Fxx9r4zHE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=XTH6onE3EdFm5+quVV+4lSXKYwLXtMTWP+3ckRJHO7Ojrq2UIDpGcTsYk0GV5ZReZsEqX7VaCvCG55dNeG9cUrwFReSIgbJyuu5POdUkwKpjCOnFF5sp1TyKfylFZiVK6oR/+cxFo98YOdGNC6AryH1vx92b3yTwWIy6HQa9PtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PJrCX8Od; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PJrCX8Od"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e30ceaa5feeso1271370276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Nov 2024 23:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730963768; x=1731568568; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QeV5H6hULi4PmNWhXYnKicIpV1Vf/5KV4yP0bFilR2g=;
        b=PJrCX8OdT7c1isBx4Mlmd1XTGV7MUCa+Ssb8EGzUFA7OJp3+Vshy54YRuOLvd0F5La
         BkMEUeCOMonBy3hDNkyz8os55Y3/eaHWOudpXeTGKefAKyffpwoVb7fzsCHoYCx2MiM0
         oUNNi7VeBeSyhC9XmaPiPse5g3xvVJm9ae5RCCtOmbkoDslhW+nAT5Ft4QZsON+/QA7T
         7LYYHgJTBL1a5L6QORkmMyM3cGZoeCRQEwxvUZ8FYpmMZVW9JON562pF2zKuXvntxVnm
         ZyCBnc/IaTb+AyY9GXBBSAR4x7I9S9fKbQdw1V4iHSU3nTlJdx5gUclsW3kO+SR05uxh
         WUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730963768; x=1731568568;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QeV5H6hULi4PmNWhXYnKicIpV1Vf/5KV4yP0bFilR2g=;
        b=WLp1YNhJuuGfbKRk/FYnJAQ35TUSAMNa8q/CYSUvwFSV2LBOjMYD/99ceR1njEXISp
         5q9i04aAd0rgo070DrimDW9bcSkjYnO1Mj6VMhZql4uePPyDywR2BAuIAmgXs5jtmwh+
         Vt2cBevTXR844RgrBrum8mym/o16YIG1OLevO8tZbQTtTli+LaNZaaeZogrQAblPkxUg
         zGPsjnkS8pDSY8DAq3D4lsF9w0b6mrrmqaF/MR5h6AsoNTnfRhNA79rDJdLBOYj9m/wF
         Ib2ONkS1ybNT24BFZE+9qZAPouhb9T9TCEOn89j8vP1dshP6LcQ/Rzgb2gbNMhZSNXWa
         UjNA==
X-Forwarded-Encrypted: i=1; AJvYcCXCL4zNqulb9qpsda+NEksFGMIhpGHw08uQTyOk40vhwMYDVuco3yGH62f8OSzJdJwc9BYpbNjEj8yX3gSnKGIu@vger.kernel.org
X-Gm-Message-State: AOJu0YyDPQjRnzzhWIhuGJlRphV1prh964r7lE+gKYUgPRiNInbncVjp
	6zg4I/TDsW9c9BdkLLl75CAl3j/m0RoeOYnuXW41haF0KiawJrkPR85OEcINi6zduc8C89Vp5nI
	mk/f/qQ==
X-Google-Smtp-Source: AGHT+IE/ABVQ+QoaXLev0j3L1bcYVcVKTmJ8bev+UrY6tq85vQOpw2ZTVBgndT6AQUc++Em5ZIlqp477wVKR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc7:bda:7167:18d8])
 (user=irogers job=sendgmr) by 2002:a25:d695:0:b0:e2b:d28f:bf28 with SMTP id
 3f1490d57ef6-e3302537c7dmr36619276.2.1730963768215; Wed, 06 Nov 2024 23:16:08
 -0800 (PST)
Date: Wed,  6 Nov 2024 23:15:55 -0800
In-Reply-To: <20241107071600.9082-1-irogers@google.com>
Message-Id: <20241107071600.9082-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107071600.9082-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v1 2/7] perf header: Refactor get_cpuid to take a CPU for ARM
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

ARM BIG.little has no notion of a constant CPUID for both core
types. To reflect this reality, change the get_cpuid function to also
pass in a possibly unused logical cpu. If the dummy value (-1) is
passed in then ARM can, as currently happens, select the first logical
CPU's "CPUID". The changes to ARM getcpuid happen in a follow up
change.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm64/util/header.c     | 2 +-
 tools/perf/arch/loongarch/util/header.c | 2 +-
 tools/perf/arch/powerpc/util/header.c   | 2 +-
 tools/perf/arch/riscv/util/header.c     | 2 +-
 tools/perf/arch/s390/util/header.c      | 2 +-
 tools/perf/arch/x86/util/auxtrace.c     | 3 ++-
 tools/perf/arch/x86/util/header.c       | 2 +-
 tools/perf/builtin-kvm.c                | 4 +++-
 tools/perf/util/env.c                   | 3 ++-
 tools/perf/util/header.c                | 9 +++++----
 tools/perf/util/header.h                | 2 +-
 11 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/util/header.c
index 741df3614a09..760c21784713 100644
--- a/tools/perf/arch/arm64/util/header.c
+++ b/tools/perf/arch/arm64/util/header.c
@@ -50,7 +50,7 @@ static int _get_cpuid(char *buf, size_t sz, struct perf_cpu_map *cpus)
 	return ret;
 }
 
-int get_cpuid(char *buf, size_t sz)
+int get_cpuid(char *buf, size_t sz, struct perf_cpu cpu __maybe_unused)
 {
 	struct perf_cpu_map *cpus = perf_cpu_map__new_online_cpus();
 	int ret;
diff --git a/tools/perf/arch/loongarch/util/header.c b/tools/perf/arch/loongarch/util/header.c
index d962dff55512..f1f0b116962d 100644
--- a/tools/perf/arch/loongarch/util/header.c
+++ b/tools/perf/arch/loongarch/util/header.c
@@ -70,7 +70,7 @@ static char *_get_cpuid(void)
 	return cpuid;
 }
 
-int get_cpuid(char *buffer, size_t sz)
+int get_cpuid(char *buffer, size_t sz, struct perf_cpu cpu __maybe_unused)
 {
 	int ret = 0;
 	char *cpuid = _get_cpuid();
diff --git a/tools/perf/arch/powerpc/util/header.c b/tools/perf/arch/powerpc/util/header.c
index 251cdbf58a4d..6d1a63a2922f 100644
--- a/tools/perf/arch/powerpc/util/header.c
+++ b/tools/perf/arch/powerpc/util/header.c
@@ -24,7 +24,7 @@ static bool is_compat_mode(void)
 }
 
 int
-get_cpuid(char *buffer, size_t sz)
+get_cpuid(char *buffer, size_t sz, struct perf_cpu cpu __maybe_unused)
 {
 	unsigned long pvr;
 	int nb;
diff --git a/tools/perf/arch/riscv/util/header.c b/tools/perf/arch/riscv/util/header.c
index 1b29030021ee..ebac294c877f 100644
--- a/tools/perf/arch/riscv/util/header.c
+++ b/tools/perf/arch/riscv/util/header.c
@@ -81,7 +81,7 @@ static char *_get_cpuid(void)
 	return cpuid;
 }
 
-int get_cpuid(char *buffer, size_t sz)
+int get_cpuid(char *buffer, size_t sz, struct perf_cpu cpu __maybe_unused)
 {
 	char *cpuid = _get_cpuid();
 	int ret = 0;
diff --git a/tools/perf/arch/s390/util/header.c b/tools/perf/arch/s390/util/header.c
index 7933f6871c81..2add1a561242 100644
--- a/tools/perf/arch/s390/util/header.c
+++ b/tools/perf/arch/s390/util/header.c
@@ -27,7 +27,7 @@
 #define SYSINFO		"/proc/sysinfo"
 #define SRVLVL		"/proc/service_levels"
 
-int get_cpuid(char *buffer, size_t sz)
+int get_cpuid(char *buffer, size_t sz, struct perf_cpu cpu __maybe_unused)
 {
 	char *cp, *line = NULL, *line2;
 	char type[8], model[33], version[8], manufacturer[32], authorization[8];
diff --git a/tools/perf/arch/x86/util/auxtrace.c b/tools/perf/arch/x86/util/auxtrace.c
index 354780ff1605..ecbf61a7eb3a 100644
--- a/tools/perf/arch/x86/util/auxtrace.c
+++ b/tools/perf/arch/x86/util/auxtrace.c
@@ -55,11 +55,12 @@ struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
 					      int *err)
 {
 	char buffer[64];
+	struct perf_cpu cpu = perf_cpu_map__min(evlist->core.all_cpus);
 	int ret;
 
 	*err = 0;
 
-	ret = get_cpuid(buffer, sizeof(buffer));
+	ret = get_cpuid(buffer, sizeof(buffer), cpu);
 	if (ret) {
 		*err = ret;
 		return NULL;
diff --git a/tools/perf/arch/x86/util/header.c b/tools/perf/arch/x86/util/header.c
index a51444a77a5f..690f86cbbb1c 100644
--- a/tools/perf/arch/x86/util/header.c
+++ b/tools/perf/arch/x86/util/header.c
@@ -58,7 +58,7 @@ __get_cpuid(char *buffer, size_t sz, const char *fmt)
 }
 
 int
-get_cpuid(char *buffer, size_t sz)
+get_cpuid(char *buffer, size_t sz, struct perf_cpu cpu __maybe_unused)
 {
 	return __get_cpuid(buffer, sz, "%s,%u,%u,%u$");
 }
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 099ce3ebf67c..274568d712d1 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1226,7 +1226,9 @@ static int cpu_isa_config(struct perf_kvm_stat *kvm)
 	int err;
 
 	if (kvm->live) {
-		err = get_cpuid(buf, sizeof(buf));
+		struct perf_cpu cpu = {-1};
+
+		err = get_cpuid(buf, sizeof(buf), cpu);
 		if (err != 0) {
 			pr_err("Failed to look up CPU type: %s\n",
 			       str_error_r(err, buf, sizeof(buf)));
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index ccb464026642..93cabdd7ff43 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -373,7 +373,8 @@ int perf_env__read_pmu_mappings(struct perf_env *env)
 int perf_env__read_cpuid(struct perf_env *env)
 {
 	char cpuid[128];
-	int err = get_cpuid(cpuid, sizeof(cpuid));
+	struct perf_cpu cpu = {-1};
+	int err = get_cpuid(cpuid, sizeof(cpuid), cpu);
 
 	if (err)
 		return err;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 55c28e4377ec..60b42ddc3dac 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -856,18 +856,19 @@ int __weak strcmp_cpuid_str(const char *mapcpuid, const char *cpuid)
  * default get_cpuid(): nothing gets recorded
  * actual implementation must be in arch/$(SRCARCH)/util/header.c
  */
-int __weak get_cpuid(char *buffer __maybe_unused, size_t sz __maybe_unused)
+int __weak get_cpuid(char *buffer __maybe_unused, size_t sz __maybe_unused,
+		     struct perf_cpu cpu __maybe_unused)
 {
 	return ENOSYS; /* Not implemented */
 }
 
-static int write_cpuid(struct feat_fd *ff,
-		       struct evlist *evlist __maybe_unused)
+static int write_cpuid(struct feat_fd *ff, struct evlist *evlist)
 {
+	struct perf_cpu cpu = perf_cpu_map__min(evlist->core.all_cpus);
 	char buffer[64];
 	int ret;
 
-	ret = get_cpuid(buffer, sizeof(buffer));
+	ret = get_cpuid(buffer, sizeof(buffer), cpu);
 	if (ret)
 		return -1;
 
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index e91e89d22537..b77f89de12dd 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -201,7 +201,7 @@ int build_caches_for_cpu(u32 cpu, struct cpu_cache_level caches[], u32 *cntp);
 /*
  * arch specific callback
  */
-int get_cpuid(char *buffer, size_t sz);
+int get_cpuid(char *buffer, size_t sz, struct perf_cpu cpu);
 
 char *get_cpuid_str(struct perf_pmu *pmu __maybe_unused);
 int strcmp_cpuid_str(const char *s1, const char *s2);
-- 
2.47.0.199.ga7371fff76-goog

