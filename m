Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B382D27A44F
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 17:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746035476; cv=none; b=mZXh2nTqYiwJtkWA/F7msrELD16bPKF8k/qcasGBnJhNpImz3pTcfBcksphZF+2FW2YCtY5NJdiPSW0uxnmaZo07xAk2ypT0IFDYvPBI6gqTAlmhAJ5GmpeYdiWJcbk/BQzPsy8I0H90zI3H58Yh3lBlZiIHJGRHs8+f30E3iTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746035476; c=relaxed/simple;
	bh=xjyQ7g9jq6RKekqoqi9q1JclHgXj/0ej3wup3SnSAN4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZrvxmwxsIoshx+BS6GsnClkgx7GkumWwh4ACk6FAYFehqhsAVdJ+KNfFexJ7Yn10MEsg18E2l+JboUD3Iw3upT7CC6t5p9sn/YRvDiRCK612+ChCiwr6309Zh5KG/pF4Cv18NiipUy06piM7LD8Xacchj/mUjkhqLm+hppaVXwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MaXGN8LE; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MaXGN8LE"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-af2f03fcc95so110363a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 10:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746035474; x=1746640274; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lHzlJA54u8q5bx76vzxWhQW+rfsmIFz0AvsWO5D3DUE=;
        b=MaXGN8LEwSlTgjOQyisJPcQy0NasebRnGsmeMy6xXIWM6lttROUj+BWqPl/39jpXCA
         9lLDfGOJ69EhcLjc2YRwn2A3outAm9CQp6utjGzUYMy56n8P4R2Q9w6SVmLLM25rbc9Z
         VqPi3HqU8ZGbBDWCKBpe/AvXK9FQbQYhEjUGVtAZVHMy2uW2rxZbSOTWUi6x6mbkkfe7
         64bhfXf6VqMz8ZRzrxlvW/Z0PE9FW8xYY3q0y5740u194mCIGbnDI3BNkc9rxBbXEadM
         DDwmaFpimR+9NbkSSbVU9aK7mIVfn8HJook9ePy5Mx9LDjzlLQeKCagCcnvj6gJHXF3i
         eLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746035474; x=1746640274;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lHzlJA54u8q5bx76vzxWhQW+rfsmIFz0AvsWO5D3DUE=;
        b=ag87kOanVIsC0XTO5sc5KywI3c9sgiS2IpGgjQVPF9Iu8iCYSUOB5KBxNDA5MvKA5O
         865tjTYUhED2j6BmCK65OA46XHcWHXetDF70+tlYdlzb+ZcrYoI6mZNM6/gOChVC1Vwz
         TGcukiidxWS0lZizTRYF4gULqQGnRF6YlsMs5v7UMBMr7GfVowLHcUY7ABRY4U7CMvju
         dz7Ve52fzIpqTRrGASmYbIVqkyvicVtFInHOK65g6D2w2BZDb/JtjF1LiQ29u7wyqeb8
         eCr7aGcT1ZzpZVnTZ/SZlShtcfyBTJ0Gaa3KayEUiDKSUknm44/N6HsFDt662tBOweG8
         Ra2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfj/LiYuQM4VZw0rQw/KFqtsvUnHK0kNMlhgqFcIPm9Js8o9sfj3nJkf65y9nxfiOph6Fz3UGdkfrMRbq18LEF@vger.kernel.org
X-Gm-Message-State: AOJu0YwDJilkdFNEhaFQbqAa/bsn9xUmbSe2rtYjDFMQpgTdEQHZhRN+
	L9tcgOlCPB+vVChP7R1C19lmUhd74KRHpjIXf1kZScICshlntRb+idERz/PkRdzDCmjQX3BIzEm
	nPsmPvg==
X-Google-Smtp-Source: AGHT+IG2k/ZxRcyjEA8PDx6q+rfzzdGM/sd8XT8EODwAXypaNMonj3txM//jVFszLvjUCeGyNazMihy30y7O
X-Received: from pgam9.prod.google.com ([2002:a05:6a02:2b49:b0:af2:54b0:c8d5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9c8c:b0:1f5:64fd:68ea
 with SMTP id adf61e73a8af0-20a87642f46mr6025571637.4.1746035473857; Wed, 30
 Apr 2025 10:51:13 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:49:56 -0700
In-Reply-To: <20250430175036.184610-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430175036.184610-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250430175036.184610-9-irogers@google.com>
Subject: [PATCH v2 08/47] libperf: Silence -Wshorten-64-to-32 warnings
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Kyle Meyer <kyle.meyer@hpe.com>, 
	Ben Gainey <ben.gainey@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	Eder Zulian <ezulian@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kuan-Wei Chiu <visitorckw@gmail.com>, He Zhe <zhe.he@windriver.com>, 
	Dirk Gouders <dirk@gouders.net>, Brian Geffon <bgeffon@google.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Howard Chu <howardchu95@gmail.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Jann Horn <jannh@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Yang Jihong <yangjihong@bytedance.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Hao Ge <gehao@kylinos.cn>, Tengda Wu <wutengda@huaweicloud.com>, 
	Gabriele Monaco <gmonaco@redhat.com>, Chun-Tse Shao <ctshao@google.com>, 
	Casey Chen <cachen@purestorage.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Weilin Wang <weilin.wang@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Andrew Kreimer <algonell@gmail.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Zixian Cai <fzczx123@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yujie Liu <yujie.liu@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

The clang warning -Wshorten-64-to-32 can be useful to catch
inadvertent truncation. In some instances this truncation can lead to
changing the sign of a result, for example, truncation to return an
int to fit a sort routine. Silence the warning by making the implicit
truncation explicit.

Note: this change avoids truncating size_t values to int by changing
the type to size_t, but this causes sign comparison warnings requiring
the -Wno-sign-compare EXTRA_CFLAGS option. This gets resolved by the
end of the series.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c                     | 18 +++++-----
 tools/lib/perf/evsel.c                      | 40 +++++++++------------
 tools/lib/perf/include/internal/cpumap.h    |  2 +-
 tools/lib/perf/include/internal/evsel.h     |  2 +-
 tools/lib/perf/include/internal/lib.h       |  2 +-
 tools/lib/perf/include/internal/mmap.h      |  4 +--
 tools/lib/perf/include/internal/threadmap.h |  2 +-
 tools/lib/perf/include/internal/xyarray.h   |  8 ++---
 tools/lib/perf/include/perf/cpumap.h        |  3 +-
 tools/lib/perf/lib.c                        |  2 +-
 tools/lib/perf/mmap.c                       | 13 ++++---
 tools/lib/perf/threadmap.c                  |  4 +--
 tools/lib/perf/xyarray.c                    |  2 +-
 13 files changed, 46 insertions(+), 56 deletions(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index 4454a5987570..37d94911449b 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -20,7 +20,7 @@ void perf_cpu_map__set_nr(struct perf_cpu_map *map, int nr_cpus)
 	RC_CHK_ACCESS(map)->nr = nr_cpus;
 }
 
-struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus)
+struct perf_cpu_map *perf_cpu_map__alloc(size_t nr_cpus)
 {
 	RC_STRUCT(perf_cpu_map) *cpus;
 	struct perf_cpu_map *result;
@@ -30,7 +30,7 @@ struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus)
 
 	cpus = malloc(sizeof(*cpus) + sizeof(struct perf_cpu) * nr_cpus);
 	if (ADD_RC_CHK(result, cpus)) {
-		cpus->nr = nr_cpus;
+		cpus->nr = (int)nr_cpus;
 		refcount_set(&cpus->refcnt, 1);
 	}
 	return result;
@@ -78,7 +78,7 @@ void perf_cpu_map__put(struct perf_cpu_map *map)
 static struct perf_cpu_map *cpu_map__new_sysconf(void)
 {
 	struct perf_cpu_map *cpus;
-	int nr_cpus, nr_cpus_conf;
+	size_t nr_cpus, nr_cpus_conf;
 
 	nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
 	if (nr_cpus < 0)
@@ -86,15 +86,13 @@ static struct perf_cpu_map *cpu_map__new_sysconf(void)
 
 	nr_cpus_conf = sysconf(_SC_NPROCESSORS_CONF);
 	if (nr_cpus != nr_cpus_conf) {
-		pr_warning("Number of online CPUs (%d) differs from the number configured (%d) the CPU map will only cover the first %d CPUs.",
+		pr_warning("Number of online CPUs (%zu) differs from the number configured (%zu) the CPU map will only cover the first %zu CPUs.",
 			nr_cpus, nr_cpus_conf, nr_cpus);
 	}
 
 	cpus = perf_cpu_map__alloc(nr_cpus);
 	if (cpus != NULL) {
-		int i;
-
-		for (i = 0; i < nr_cpus; ++i)
+		for (size_t i = 0; i < nr_cpus; ++i)
 			RC_CHK_ACCESS(cpus)->map[i].cpu = i;
 	}
 
@@ -132,7 +130,7 @@ static int cmp_cpu(const void *a, const void *b)
 	return cpu_a->cpu - cpu_b->cpu;
 }
 
-static struct perf_cpu __perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx)
+static struct perf_cpu __perf_cpu_map__cpu(const struct perf_cpu_map *cpus, size_t idx)
 {
 	return RC_CHK_ACCESS(cpus)->map[idx];
 }
@@ -247,13 +245,13 @@ static int __perf_cpu_map__nr(const struct perf_cpu_map *cpus)
 	return RC_CHK_ACCESS(cpus)->nr;
 }
 
-struct perf_cpu perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx)
+struct perf_cpu perf_cpu_map__cpu(const struct perf_cpu_map *cpus, size_t idx)
 {
 	struct perf_cpu result = {
 		.cpu = -1
 	};
 
-	if (cpus && idx < __perf_cpu_map__nr(cpus))
+	if (cpus && idx < (size_t)__perf_cpu_map__nr(cpus))
 		return __perf_cpu_map__cpu(cpus, idx);
 
 	return result;
diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index c475319e2e41..d647ca25a6db 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -71,7 +71,7 @@ int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads)
 	return evsel->fd != NULL ? 0 : -ENOMEM;
 }
 
-static int perf_evsel__alloc_mmap(struct perf_evsel *evsel, int ncpus, int nthreads)
+static int perf_evsel__alloc_mmap(struct perf_evsel *evsel, size_t ncpus, size_t nthreads)
 {
 	evsel->mmap = xyarray__new(ncpus, nthreads, sizeof(struct perf_mmap));
 
@@ -83,7 +83,7 @@ sys_perf_event_open(struct perf_event_attr *attr,
 		    pid_t pid, struct perf_cpu cpu, int group_fd,
 		    unsigned long flags)
 {
-	return syscall(__NR_perf_event_open, attr, pid, cpu.cpu, group_fd, flags);
+	return (int)syscall(__NR_perf_event_open, attr, pid, cpu.cpu, group_fd, flags);
 }
 
 static int get_group_fd(struct perf_evsel *evsel, int cpu_map_idx, int thread, int *group_fd)
@@ -179,11 +179,9 @@ int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
 	return err;
 }
 
-static void perf_evsel__close_fd_cpu(struct perf_evsel *evsel, int cpu_map_idx)
+static void perf_evsel__close_fd_cpu(struct perf_evsel *evsel, size_t cpu_map_idx)
 {
-	int thread;
-
-	for (thread = 0; thread < xyarray__max_y(evsel->fd); ++thread) {
+	for (size_t thread = 0; thread < xyarray__max_y(evsel->fd); ++thread) {
 		int *fd = FD(evsel, cpu_map_idx, thread);
 
 		if (fd && *fd >= 0) {
@@ -195,7 +193,7 @@ static void perf_evsel__close_fd_cpu(struct perf_evsel *evsel, int cpu_map_idx)
 
 void perf_evsel__close_fd(struct perf_evsel *evsel)
 {
-	for (int idx = 0; idx < xyarray__max_x(evsel->fd); idx++)
+	for (size_t idx = 0; idx < xyarray__max_x(evsel->fd); idx++)
 		perf_evsel__close_fd_cpu(evsel, idx);
 }
 
@@ -224,13 +222,11 @@ void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu_map_idx)
 
 void perf_evsel__munmap(struct perf_evsel *evsel)
 {
-	int idx, thread;
-
 	if (evsel->fd == NULL || evsel->mmap == NULL)
 		return;
 
-	for (idx = 0; idx < xyarray__max_x(evsel->fd); idx++) {
-		for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
+	for (size_t idx = 0; idx < xyarray__max_x(evsel->fd); idx++) {
+		for (size_t thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
 			int *fd = FD(evsel, idx, thread);
 
 			if (fd == NULL || *fd < 0)
@@ -246,7 +242,7 @@ void perf_evsel__munmap(struct perf_evsel *evsel)
 
 int perf_evsel__mmap(struct perf_evsel *evsel, int pages)
 {
-	int ret, idx, thread;
+	int ret;
 	struct perf_mmap_param mp = {
 		.prot = PROT_READ | PROT_WRITE,
 		.mask = (pages * page_size) - 1,
@@ -258,8 +254,8 @@ int perf_evsel__mmap(struct perf_evsel *evsel, int pages)
 	if (perf_evsel__alloc_mmap(evsel, xyarray__max_x(evsel->fd), xyarray__max_y(evsel->fd)) < 0)
 		return -ENOMEM;
 
-	for (idx = 0; idx < xyarray__max_x(evsel->fd); idx++) {
-		for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
+	for (size_t idx = 0; idx < xyarray__max_x(evsel->fd); idx++) {
+		for (size_t thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
 			int *fd = FD(evsel, idx, thread);
 			struct perf_mmap *map;
 			struct perf_cpu cpu = perf_cpu_map__cpu(evsel->cpus, idx);
@@ -415,7 +411,7 @@ int perf_evsel__read(struct perf_evsel *evsel, int cpu_map_idx, int thread,
 }
 
 static int perf_evsel__ioctl(struct perf_evsel *evsel, int ioc, void *arg,
-			     int cpu_map_idx, int thread)
+			     size_t cpu_map_idx, size_t thread)
 {
 	int *fd = FD(evsel, cpu_map_idx, thread);
 
@@ -427,11 +423,9 @@ static int perf_evsel__ioctl(struct perf_evsel *evsel, int ioc, void *arg,
 
 static int perf_evsel__run_ioctl(struct perf_evsel *evsel,
 				 int ioc,  void *arg,
-				 int cpu_map_idx)
+				 size_t cpu_map_idx)
 {
-	int thread;
-
-	for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
+	for (size_t thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
 		int err = perf_evsel__ioctl(evsel, ioc, arg, cpu_map_idx, thread);
 
 		if (err)
@@ -463,10 +457,9 @@ int perf_evsel__enable_thread(struct perf_evsel *evsel, int thread)
 
 int perf_evsel__enable(struct perf_evsel *evsel)
 {
-	int i;
 	int err = 0;
 
-	for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
+	for (size_t i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
 		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, i);
 	return err;
 }
@@ -478,10 +471,9 @@ int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu_map_idx)
 
 int perf_evsel__disable(struct perf_evsel *evsel)
 {
-	int i;
 	int err = 0;
 
-	for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
+	for (size_t i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
 		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, NULL, i);
 	return err;
 }
@@ -512,7 +504,7 @@ struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel)
 	return &evsel->attr;
 }
 
-int perf_evsel__alloc_id(struct perf_evsel *evsel, int ncpus, int nthreads)
+int perf_evsel__alloc_id(struct perf_evsel *evsel, size_t ncpus, size_t nthreads)
 {
 	if (ncpus == 0 || nthreads == 0)
 		return 0;
diff --git a/tools/lib/perf/include/internal/cpumap.h b/tools/lib/perf/include/internal/cpumap.h
index e2be2d17c32b..624c8163cc84 100644
--- a/tools/lib/perf/include/internal/cpumap.h
+++ b/tools/lib/perf/include/internal/cpumap.h
@@ -21,7 +21,7 @@ DECLARE_RC_STRUCT(perf_cpu_map) {
 	struct perf_cpu	map[];
 };
 
-struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus);
+struct perf_cpu_map *perf_cpu_map__alloc(size_t nr_cpus);
 int perf_cpu_map__idx(const struct perf_cpu_map *cpus, struct perf_cpu cpu);
 bool perf_cpu_map__is_subset(const struct perf_cpu_map *a, const struct perf_cpu_map *b);
 
diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
index ea78defa77d0..ed04a5d4b032 100644
--- a/tools/lib/perf/include/internal/evsel.h
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -139,7 +139,7 @@ void perf_evsel__free_fd(struct perf_evsel *evsel);
 int perf_evsel__read_size(struct perf_evsel *evsel);
 int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter);
 
-int perf_evsel__alloc_id(struct perf_evsel *evsel, int ncpus, int nthreads);
+int perf_evsel__alloc_id(struct perf_evsel *evsel, size_t ncpus, size_t nthreads);
 void perf_evsel__free_id(struct perf_evsel *evsel);
 
 bool perf_evsel__attr_has_per_thread_sample_period(struct perf_evsel *evsel);
diff --git a/tools/lib/perf/include/internal/lib.h b/tools/lib/perf/include/internal/lib.h
index 85471a4b900f..60253b81699f 100644
--- a/tools/lib/perf/include/internal/lib.h
+++ b/tools/lib/perf/include/internal/lib.h
@@ -4,7 +4,7 @@
 
 #include <sys/types.h>
 
-extern unsigned int page_size;
+extern size_t page_size;
 
 ssize_t readn(int fd, void *buf, size_t n);
 ssize_t writen(int fd, const void *buf, size_t n);
diff --git a/tools/lib/perf/include/internal/mmap.h b/tools/lib/perf/include/internal/mmap.h
index 5f08cab61ece..4780691c65f3 100644
--- a/tools/lib/perf/include/internal/mmap.h
+++ b/tools/lib/perf/include/internal/mmap.h
@@ -23,7 +23,7 @@ typedef void (*libperf_unmap_cb_t)(struct perf_mmap *map);
  */
 struct perf_mmap {
 	void			*base;
-	int			 mask;
+	size_t			 mask;
 	int			 fd;
 	struct perf_cpu		 cpu;
 	refcount_t		 refcnt;
@@ -40,7 +40,7 @@ struct perf_mmap {
 
 struct perf_mmap_param {
 	int	prot;
-	int	mask;
+	size_t	mask;
 };
 
 size_t perf_mmap__mmap_len(struct perf_mmap *map);
diff --git a/tools/lib/perf/include/internal/threadmap.h b/tools/lib/perf/include/internal/threadmap.h
index df748baf9eda..c223432be7a5 100644
--- a/tools/lib/perf/include/internal/threadmap.h
+++ b/tools/lib/perf/include/internal/threadmap.h
@@ -18,6 +18,6 @@ struct perf_thread_map {
 	struct thread_map_data map[];
 };
 
-struct perf_thread_map *perf_thread_map__realloc(struct perf_thread_map *map, int nr);
+struct perf_thread_map *perf_thread_map__realloc(struct perf_thread_map *map, size_t nr);
 
 #endif /* __LIBPERF_INTERNAL_THREADMAP_H */
diff --git a/tools/lib/perf/include/internal/xyarray.h b/tools/lib/perf/include/internal/xyarray.h
index f10af3da7b21..f8f6e1facf91 100644
--- a/tools/lib/perf/include/internal/xyarray.h
+++ b/tools/lib/perf/include/internal/xyarray.h
@@ -14,11 +14,11 @@ struct xyarray {
 	char contents[] __aligned(8);
 };
 
-struct xyarray *xyarray__new(int xlen, int ylen, size_t entry_size);
+struct xyarray *xyarray__new(size_t xlen, size_t ylen, size_t entry_size);
 void xyarray__delete(struct xyarray *xy);
 void xyarray__reset(struct xyarray *xy);
 
-static inline void *__xyarray__entry(struct xyarray *xy, int x, int y)
+static inline void *__xyarray__entry(struct xyarray *xy, size_t x, size_t y)
 {
 	return &xy->contents[x * xy->row_size + y * xy->entry_size];
 }
@@ -30,12 +30,12 @@ static inline void *xyarray__entry(struct xyarray *xy, size_t x, size_t y)
 	return __xyarray__entry(xy, x, y);
 }
 
-static inline int xyarray__max_y(struct xyarray *xy)
+static inline size_t xyarray__max_y(struct xyarray *xy)
 {
 	return xy->max_y;
 }
 
-static inline int xyarray__max_x(struct xyarray *xy)
+static inline size_t xyarray__max_x(struct xyarray *xy)
 {
 	return xy->max_x;
 }
diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
index 8c1ab0f9194e..51bf70f639ad 100644
--- a/tools/lib/perf/include/perf/cpumap.h
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -5,6 +5,7 @@
 #include <perf/core.h>
 #include <stdbool.h>
 #include <stdint.h>
+#include <stdlib.h>
 
 /** A wrapper around a CPU to avoid confusion with the perf_cpu_map's map's indices. */
 struct perf_cpu {
@@ -47,7 +48,7 @@ LIBPERF_API void perf_cpu_map__put(struct perf_cpu_map *map);
  * perf_cpu_map__cpu - get the CPU value at the given index. Returns -1 if index
  *                     is invalid.
  */
-LIBPERF_API struct perf_cpu perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx);
+LIBPERF_API struct perf_cpu perf_cpu_map__cpu(const struct perf_cpu_map *cpus, size_t idx);
 /**
  * perf_cpu_map__nr - for an empty map returns 1, as perf_cpu_map__cpu returns a
  *                    cpu of -1 for an invalid index, this makes an empty map
diff --git a/tools/lib/perf/lib.c b/tools/lib/perf/lib.c
index 696fb0ea67c6..b759f9caee7a 100644
--- a/tools/lib/perf/lib.c
+++ b/tools/lib/perf/lib.c
@@ -5,7 +5,7 @@
 #include <linux/kernel.h>
 #include <internal/lib.h>
 
-unsigned int page_size;
+size_t page_size;
 
 static ssize_t ion(bool is_read, int fd, void *buf, size_t n)
 {
diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
index c1a51d925e0e..3af5150f6ccf 100644
--- a/tools/lib/perf/mmap.c
+++ b/tools/lib/perf/mmap.c
@@ -109,11 +109,11 @@ void perf_mmap__consume(struct perf_mmap *map)
 		perf_mmap__put(map);
 }
 
-static int overwrite_rb_find_range(void *buf, int mask, u64 *start, u64 *end)
+static int overwrite_rb_find_range(void *buf, size_t mask, u64 *start, u64 *end)
 {
 	struct perf_event_header *pheader;
 	u64 evt_head = *start;
-	int size = mask + 1;
+	size_t size = mask + 1;
 
 	pr_debug2("%s: buf=%p, start=%"PRIx64"\n", __func__, buf, *start);
 	pheader = (struct perf_event_header *)(buf + (*start & mask));
@@ -157,7 +157,7 @@ static int __perf_mmap__read_init(struct perf_mmap *md)
 	if ((md->end - md->start) < md->flush)
 		return -EAGAIN;
 
-	size = md->end - md->start;
+	size = (unsigned long)(md->end - md->start);
 	if (size > (unsigned long)(md->mask) + 1) {
 		if (!md->overwrite) {
 			WARN_ONCE(1, "failed to keep up with mmap data. (warn only once)\n");
@@ -212,7 +212,7 @@ static union perf_event *perf_mmap__read(struct perf_mmap *map,
 {
 	unsigned char *data = map->base + page_size;
 	union perf_event *event = NULL;
-	int diff = end - *startp;
+	s64 diff = end - *startp;
 
 	if (diff >= (int)sizeof(event->header)) {
 		size_t size;
@@ -228,8 +228,7 @@ static union perf_event *perf_mmap__read(struct perf_mmap *map,
 		 * be inside due to u64 alignment of output.
 		 */
 		if ((*startp & map->mask) + size != ((*startp + size) & map->mask)) {
-			unsigned int offset = *startp;
-			unsigned int len = size, cpy;
+			u64 offset = *startp, len = size, cpy;
 			void *dst = map->event_copy;
 
 			if (size > map->event_copy_sz) {
@@ -242,7 +241,7 @@ static union perf_event *perf_mmap__read(struct perf_mmap *map,
 
 			do {
 				cpy = min(map->mask + 1 - (offset & map->mask), len);
-				memcpy(dst, &data[offset & map->mask], cpy);
+				memcpy(dst, &data[offset & map->mask], (size_t)cpy);
 				offset += cpy;
 				dst += cpy;
 				len -= cpy;
diff --git a/tools/lib/perf/threadmap.c b/tools/lib/perf/threadmap.c
index 07968f3ea093..21c50737bbc2 100644
--- a/tools/lib/perf/threadmap.c
+++ b/tools/lib/perf/threadmap.c
@@ -7,7 +7,7 @@
 #include <asm/bug.h>
 #include <stdio.h>
 
-static void perf_thread_map__reset(struct perf_thread_map *map, int start, int nr)
+static void perf_thread_map__reset(struct perf_thread_map *map, size_t start, size_t nr)
 {
 	size_t size = (nr - start) * sizeof(map->map[0]);
 
@@ -15,7 +15,7 @@ static void perf_thread_map__reset(struct perf_thread_map *map, int start, int n
 	map->err_thread = -1;
 }
 
-struct perf_thread_map *perf_thread_map__realloc(struct perf_thread_map *map, int nr)
+struct perf_thread_map *perf_thread_map__realloc(struct perf_thread_map *map, size_t nr)
 {
 	size_t size = sizeof(*map) + sizeof(map->map[0]) * nr;
 	int start = map ? map->nr : 0;
diff --git a/tools/lib/perf/xyarray.c b/tools/lib/perf/xyarray.c
index dcd901d154bb..35b2088da9c4 100644
--- a/tools/lib/perf/xyarray.c
+++ b/tools/lib/perf/xyarray.c
@@ -4,7 +4,7 @@
 #include <stdlib.h>
 #include <string.h>
 
-struct xyarray *xyarray__new(int xlen, int ylen, size_t entry_size)
+struct xyarray *xyarray__new(size_t xlen, size_t ylen, size_t entry_size)
 {
 	size_t row_size = ylen * entry_size;
 	struct xyarray *xy = zalloc(sizeof(*xy) + xlen * row_size);
-- 
2.49.0.906.g1f30a19c02-goog

