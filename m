Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7C12983E8
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 17:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746035553; cv=none; b=n3jUuVA4uHEQfp4y/UYEOjjpz2qGc90C/CAHnUklKaO7jtyYQFeSuSxrq1aKwnQV2Ch8wG+zzypJER+ZQ5pJ729NBpkcGr4QE7hhezW0ceUbvBdPIJQa8qgH5n4SYy+DHm847SJpoFQldu+lF1uyNZxboZAkpmmDQNgAt0kRDbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746035553; c=relaxed/simple;
	bh=lWqFYgl3HTS7Tl2tVPG6nZIYiJsr1wKyR6IBEtnlSzc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hdom+KAGV9Jjh9m4ZYEfvHvzoJn4a5S/8gUmYwRkLEXroD426Hb9VUTZry/8w+vIj5MxH2T92tpWO3VvVve4bF54Uyhrl0na3cGIC6dDxJwWagJ82KvHCZM/46uIr9u916kDL6XDtx6QkUbrpZmoZp+9ZqElg5sbXYbfV0BUEu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UM9OJGwn; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UM9OJGwn"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-739515de999so119083b3a.1
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 10:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746035550; x=1746640350; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4yabIbUk+xIRtJF5jv9hpcDwrR80Am0KwQapUtOfXns=;
        b=UM9OJGwnDUnNjfgCV4Z6KlDyictmzoyeavR6NpKRwehzu5pOdPfTtZ7HmIYTuT45T6
         8SWNJQhgLHUcIhIaFq0roaT+XUDQwXVHGO4LG8Q2ZsXRFwhLC115mlXev/YKmfZatl2F
         TZqbHkByxuGU7VVz3LL2hBMzaJgryotT4lauDONsMVMoxI6dDOWSdymC9fboG28mxn+t
         OIvcoJoFhzj5Yl7xxicMqNOLxooB+V5uHfLvyxVhd0uCTCHXWU5EmVsCNNLYNguJgDs8
         FDbhqGwzeN7fbNGqFRXk0PTbvbL91/LgLmZjOoiYXaNr3XBhIqxt8IrZKbUYeBBKbrYI
         z7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746035550; x=1746640350;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4yabIbUk+xIRtJF5jv9hpcDwrR80Am0KwQapUtOfXns=;
        b=LRRh8+0I9GwYlFAoyN08ol2wOafh2CWhHX5ZMNIPHdV/LMo39X2pyeawZYjPH8YLuX
         kCdDxu2gkVAyyb6afrFbvLslYvFxkY9vpzzxgrA3NWVpL+C5ypR5voBoUUAjNlEwhlDf
         zXn1lYBU1rKwsBdJV/OlM9h+jSk/3tlgOv7bjockxc4EfkG58pXu2SIPHudd/d1jHSwF
         EyMCOQ2J4Z9dKmnOO6cfoRAUGiVt0gZgxTFy8Fi3Qw+SLuGYiYSTO9yaWIymXqbZLesn
         dMj5Xo850hGt+pcBvZzumLE8c4VZrDBIKxH9oYyhrYhvWRB+g5wrDxwIz1K57kzy/PsW
         Avsw==
X-Forwarded-Encrypted: i=1; AJvYcCVzbwMZ7fG9FsdYwyXvq85blvUrXRiypYs8r49U6cHO7HzifEZ047GXfGPTG8iM2/gjnDlFOg7co0icFpNXb+fp@vger.kernel.org
X-Gm-Message-State: AOJu0YyKbx6IjbKQsaaAbgy2eAzjaeDDQHkherIja8toclE5URrbSpmr
	4mfQpFnCuK3dtXValCFlcwmFBTWM2YjE+yeHza0fZ05dqCVedbk3M6gdSlKTtJACmEoLjboNIWQ
	pBY6tqg==
X-Google-Smtp-Source: AGHT+IFVpsqvRs30tpntf3/3Xdl4bxpC0d+peJzYW9nRhnIlF0QkqoqqAmaauRqHtSrH8d+lRVohnKVgLGEQ
X-Received: from pfbko7.prod.google.com ([2002:a05:6a00:4607:b0:730:597f:f227])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:8895:0:b0:736:5f75:4a3b
 with SMTP id d2e1a72fcca58-74038989737mr6342425b3a.7.1746035548690; Wed, 30
 Apr 2025 10:52:28 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:50:33 -0700
In-Reply-To: <20250430175036.184610-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430175036.184610-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250430175036.184610-46-irogers@google.com>
Subject: [PATCH v2 45/47] perf util: Silence -Wshorten-64-to-32 warnings
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

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/perf-sys.h        |  3 +--
 tools/perf/util/cacheline.c  |  5 ++++-
 tools/perf/util/cgroup.c     |  4 ++--
 tools/perf/util/comm.c       |  2 +-
 tools/perf/util/config.c     |  6 +++---
 tools/perf/util/cpumap.c     |  4 ++--
 tools/perf/util/debug.c      |  7 +++----
 tools/perf/util/memswap.c    |  4 ++--
 tools/perf/util/memswap.h    |  4 ++--
 tools/perf/util/strfilter.c  |  2 +-
 tools/perf/util/string.c     | 11 ++++++-----
 tools/perf/util/svghelper.c  | 23 ++++++++++++-----------
 tools/perf/util/time-utils.c |  9 +++++----
 tools/perf/util/util.c       |  9 +++++----
 tools/perf/util/util.h       |  2 +-
 15 files changed, 50 insertions(+), 45 deletions(-)

diff --git a/tools/perf/perf-sys.h b/tools/perf/perf-sys.h
index 7a2264e1e4e1..89e44798ed2b 100644
--- a/tools/perf/perf-sys.h
+++ b/tools/perf/perf-sys.h
@@ -14,8 +14,7 @@ sys_perf_event_open(struct perf_event_attr *attr,
 		      pid_t pid, int cpu, int group_fd,
 		      unsigned long flags)
 {
-	return syscall(__NR_perf_event_open, attr, pid, cpu,
-		       group_fd, flags);
+	return (int)syscall(__NR_perf_event_open, attr, pid, cpu, group_fd, flags);
 }
 
 #endif /* _PERF_SYS_H */
diff --git a/tools/perf/util/cacheline.c b/tools/perf/util/cacheline.c
index e98b5250a517..6d4505aeaa5f 100644
--- a/tools/perf/util/cacheline.c
+++ b/tools/perf/util/cacheline.c
@@ -3,7 +3,10 @@
 #include <unistd.h>
 
 #ifdef _SC_LEVEL1_DCACHE_LINESIZE
-#define cache_line_size(cacheline_sizep) *cacheline_sizep = sysconf(_SC_LEVEL1_DCACHE_LINESIZE)
+static void cache_line_size(int *cacheline_sizep)
+{
+	*cacheline_sizep = (int)sysconf(_SC_LEVEL1_DCACHE_LINESIZE);
+}
 #else
 #include <api/fs/fs.h>
 #include "debug.h"
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index fbcc0626f9ce..30c7f60048b7 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -310,7 +310,7 @@ static int match_cgroups(const char *str)
 		return -1;
 
 	/* cgroup_name will have a full path, skip the root directory */
-	prefix_len = strlen(mnt);
+	prefix_len = (int)strlen(mnt);
 
 	/* collect all cgroups in the cgroup_list */
 	if (nftw(mnt, add_cgroup_name, 20, 0) < 0)
@@ -607,7 +607,7 @@ void read_all_cgroups(struct rb_root *root)
 {
 	char mnt[PATH_MAX];
 	struct cgroup_name *cn;
-	int prefix_len;
+	size_t prefix_len;
 
 	if (cgroupfs_find_mountpoint(mnt, sizeof(mnt), "perf_event"))
 		return;
diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
index 8aa456d7c2cd..3d8f30ddcac1 100644
--- a/tools/perf/util/comm.c
+++ b/tools/perf/util/comm.c
@@ -111,7 +111,7 @@ static void comm_strs__remove_if_last(struct comm_str *cs)
 		entry = bsearch(comm_str__str(cs), comm_strs->strs, comm_strs->num_strs,
 				sizeof(struct comm_str *), comm_str__search);
 		comm_str__put(*entry);
-		for (int i = entry - comm_strs->strs; i < comm_strs->num_strs - 1; i++)
+		for (long i = entry - comm_strs->strs; i < comm_strs->num_strs - 1; i++)
 			comm_strs->strs[i] = comm_strs->strs[i + 1];
 		comm_strs->num_strs--;
 	}
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index ae72b66b6ded..5fd20776e6bb 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -388,7 +388,7 @@ int perf_config_int(int *dest, const char *name, const char *value)
 		bad_config(name);
 		return -1;
 	}
-	*dest = ret;
+	*dest = (int)ret;
 	return 0;
 }
 
@@ -454,10 +454,10 @@ static int perf_buildid_config(const char *var, const char *value)
 static int perf_default_core_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "core.proc-map-timeout"))
-		proc_map_timeout = strtoul(value, NULL, 10);
+		proc_map_timeout = (int)strtoul(value, NULL, 10);
 
 	if (!strcmp(var, "core.addr2line-timeout"))
-		addr2line_timeout_ms = strtoul(value, NULL, 10);
+		addr2line_timeout_ms = (int)strtoul(value, NULL, 10);
 
 	/* Add other config variables here. */
 	return 0;
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 89570397a4b3..7a8bf6843362 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -107,14 +107,14 @@ static struct perf_cpu_map *cpu_map__from_mask(const struct perf_record_cpu_map_
 
 	for (int i = 0, j = 0; i < mask_nr; i++) {
 		int cpus_per_i = (i * data->mask32_data.long_size  * BITS_PER_BYTE);
-		int cpu;
+		size_t cpu;
 
 		perf_record_cpu_map_data__read_one_mask(data, i, local_copy);
 		for_each_set_bit(cpu, local_copy, 64) {
 			if (cpu + cpus_per_i < INT16_MAX) {
 				RC_CHK_ACCESS(map)->map[j++].cpu = cpu + cpus_per_i;
 			} else {
-				pr_err("Invalid cpumap entry %d\n", cpu + cpus_per_i);
+				pr_err("Invalid cpumap entry %zu\n", cpu + cpus_per_i);
 				perf_cpu_map__put(map);
 				return NULL;
 			}
diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index f9ef7d045c92..3027477652b6 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -303,13 +303,12 @@ void perf_debug_setup(void)
 void dump_stack(void)
 {
 	void *array[16];
-	size_t size = backtrace(array, ARRAY_SIZE(array));
+	int size = backtrace(array, ARRAY_SIZE(array));
 	char **strings = backtrace_symbols(array, size);
-	size_t i;
 
-	printf("Obtained %zd stack frames.\n", size);
+	printf("Obtained %d stack frames.\n", size);
 
-	for (i = 0; i < size; i++)
+	for (int i = 0; i < size; i++)
 		printf("%s\n", strings[i]);
 
 	free(strings);
diff --git a/tools/perf/util/memswap.c b/tools/perf/util/memswap.c
index c1317e4983bc..68f9b3f72812 100644
--- a/tools/perf/util/memswap.c
+++ b/tools/perf/util/memswap.c
@@ -3,7 +3,7 @@
 #include "memswap.h"
 #include <linux/types.h>
 
-void mem_bswap_32(void *src, int byte_size)
+void mem_bswap_32(void *src, size_t byte_size)
 {
 	u32 *m = src;
 	while (byte_size > 0) {
@@ -13,7 +13,7 @@ void mem_bswap_32(void *src, int byte_size)
 	}
 }
 
-void mem_bswap_64(void *src, int byte_size)
+void mem_bswap_64(void *src, size_t byte_size)
 {
 	u64 *m = src;
 
diff --git a/tools/perf/util/memswap.h b/tools/perf/util/memswap.h
index 2c38e8c2d548..956de6b014f8 100644
--- a/tools/perf/util/memswap.h
+++ b/tools/perf/util/memswap.h
@@ -9,7 +9,7 @@ union u64_swap {
 	u32 val32[2];
 };
 
-void mem_bswap_64(void *src, int byte_size);
-void mem_bswap_32(void *src, int byte_size);
+void mem_bswap_64(void *src, size_t byte_size);
+void mem_bswap_32(void *src, size_t byte_size);
 
 #endif /* PERF_MEMSWAP_H_ */
diff --git a/tools/perf/util/strfilter.c b/tools/perf/util/strfilter.c
index 02807b9d4122..d09523712138 100644
--- a/tools/perf/util/strfilter.c
+++ b/tools/perf/util/strfilter.c
@@ -287,7 +287,7 @@ static int strfilter_node__sprint(struct strfilter_node *node, char *buf)
 		len += rlen;
 		break;
 	default:
-		len = strlen(node->p);
+		len = (int)strlen(node->p);
 		if (buf)
 			strcpy(buf, node->p);
 	}
diff --git a/tools/perf/util/string.c b/tools/perf/util/string.c
index c0e927bbadf6..cfc8f4d07abb 100644
--- a/tools/perf/util/string.c
+++ b/tools/perf/util/string.c
@@ -199,8 +199,9 @@ bool strlazymatch(const char *str, const char *pat)
  */
 int strtailcmp(const char *s1, const char *s2)
 {
-	int i1 = strlen(s1);
-	int i2 = strlen(s2);
+	size_t i1 = strlen(s1);
+	size_t i2 = strlen(s2);
+
 	while (--i1 >= 0 && --i2 >= 0) {
 		if (s1[i1] != s2[i2])
 			return s1[i1] - s2[i2];
@@ -331,7 +332,7 @@ char *strdup_esc(const char *str)
 }
 
 /* Remove backslash right before quote and return next quote address. */
-static char *remove_consumed_esc(char *str, int len, int quote)
+static char *remove_consumed_esc(char *str, size_t len, int quote)
 {
 	char *ptr = str, *end = str + len;
 
@@ -373,7 +374,7 @@ char *strdup_esq(const char *str)
 		if (*d == '"' || *d == '\'') {
 			/* This is non-escaped quote */
 			int quote = *d;
-			int len = strlen(d + 1) + 1;
+			size_t len = strlen(d + 1) + 1;
 
 			/*
 			 * Remove the start quote and remove consumed escape (backslash
@@ -420,7 +421,7 @@ unsigned int hex(char c)
  */
 char *strreplace_chars(char needle, const char *haystack, const char *replace)
 {
-	int replace_len = strlen(replace);
+	size_t replace_len = strlen(replace);
 	char *new_s, *to;
 	const char *loc = strchr(haystack, needle);
 	const char *from = haystack;
diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
index b1d259f590e9..487860f557ac 100644
--- a/tools/perf/util/svghelper.c
+++ b/tools/perf/util/svghelper.c
@@ -100,7 +100,7 @@ void open_svg(const char *filename, int cpus, int rows, u64 start, u64 end)
 	 * if the recording is short, we default to a width of 1000, but
 	 * for longer recordings we want at least 200 units of width per second
 	 */
-	new_width = (last_time - first_time) / 5000000;
+	new_width = (int)((last_time - first_time) / 5000000);
 
 	if (new_width > svg_page_width)
 		svg_page_width = new_width;
@@ -344,7 +344,8 @@ static char *cpu_model(void)
 	file = fopen("/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies", "r");
 	if (file) {
 		while (fgets(buf, 255, file)) {
-			unsigned int freq;
+			unsigned long long freq;
+
 			freq = strtoull(buf, NULL, 10);
 			if (freq > max_freq)
 				max_freq = freq;
@@ -698,12 +699,11 @@ struct topology {
 };
 
 static void scan_thread_topology(int *map, struct topology *t, int cpu,
-				 int *pos, int nr_cpus)
+				 int *pos, size_t nr_cpus)
 {
-	int i;
-	int thr;
+	for (int i = 0; i < t->sib_thr_nr; i++) {
+		size_t thr;
 
-	for (i = 0; i < t->sib_thr_nr; i++) {
 		if (!test_bit(cpu, cpumask_bits(&t->sib_thr[i])))
 			continue;
 
@@ -713,15 +713,16 @@ static void scan_thread_topology(int *map, struct topology *t, int cpu,
 	}
 }
 
-static void scan_core_topology(int *map, struct topology *t, int nr_cpus)
+static void scan_core_topology(int *map, struct topology *t, size_t nr_cpus)
 {
 	int pos = 0;
-	int i;
-	int cpu;
 
-	for (i = 0; i < t->sib_core_nr; i++)
+	for (int i = 0; i < t->sib_core_nr; i++) {
+		size_t cpu;
+
 		for_each_set_bit(cpu, cpumask_bits(&t->sib_core[i]), nr_cpus)
-			scan_thread_topology(map, t, cpu, &pos, nr_cpus);
+			scan_thread_topology(map, t, (int)cpu, &pos, nr_cpus);
+	}
 }
 
 static int str_to_bitmap(char *s, cpumask_t *b, int nr_cpus)
diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 1b91ccd4d523..8579c2800ceb 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -25,7 +25,6 @@ int parse_nsec_time(const char *str, u64 *ptime)
 		return -1;
 
 	if (*end == '.') {
-		int i;
 		char nsec_buf[10];
 
 		if (strlen(++end) > 9)
@@ -35,7 +34,7 @@ int parse_nsec_time(const char *str, u64 *ptime)
 		nsec_buf[9] = '\0';
 
 		/* make it nsec precision */
-		for (i = strlen(nsec_buf); i < 9; i++)
+		for (size_t i = strlen(nsec_buf); i < 9; i++)
 			nsec_buf[i] = '0';
 
 		time_nsec = strtoull(nsec_buf, &end, 10);
@@ -284,7 +283,8 @@ static int percent_comma_split(struct perf_time_interval *ptime_buf, int num,
 			       time_pecent_split func)
 {
 	char *str, *p1, *p2;
-	int len, ret, i = 0;
+	int ret, i = 0;
+	size_t len;
 
 	str = strdup(ostr);
 	if (str == NULL)
@@ -328,7 +328,8 @@ static int one_percent_convert(struct perf_time_interval *ptime_buf,
 			       const char *ostr, u64 start, u64 end, char *c)
 {
 	char *str;
-	int len = strlen(ostr), ret;
+	size_t len = strlen(ostr);
+	int ret;
 
 	/*
 	 * c points to '%'.
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 0f031eb80b4c..85bb8049ce65 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -360,7 +360,7 @@ int perf_tip(char **strp, const char *dirpath)
 	if (strlist__nr_entries(tips) == 0)
 		goto out;
 
-	node = strlist__entry(tips, random() % strlist__nr_entries(tips));
+	node = strlist__entry(tips, (unsigned int)random() % strlist__nr_entries(tips));
 	if (asprintf(strp, "Tip: %s", node->s) < 0)
 		ret = -ENOMEM;
 
@@ -370,9 +370,10 @@ int perf_tip(char **strp, const char *dirpath)
 	return ret;
 }
 
-char *perf_exe(char *buf, int len)
+char *perf_exe(char *buf, size_t len)
 {
-	int n = readlink("/proc/self/exe", buf, len);
+	ssize_t n = readlink("/proc/self/exe", buf, len);
+
 	if (n > 0) {
 		buf[n] = 0;
 		return buf;
@@ -409,7 +410,7 @@ char *filename_with_chroot(int pid, const char *filename)
 	char buf[PATH_MAX];
 	char proc_root[32];
 	char *new_name = NULL;
-	int ret;
+	ssize_t ret;
 
 	scnprintf(proc_root, sizeof(proc_root), "/proc/%d/root", pid);
 	ret = readlink(proc_root, buf, sizeof(buf) - 1);
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 3423778e39a5..f0057d8410ff 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -64,7 +64,7 @@ extern bool perf_singlethreaded;
 void perf_set_singlethreaded(void);
 void perf_set_multithreaded(void);
 
-char *perf_exe(char *buf, int len);
+char *perf_exe(char *buf, size_t len);
 
 #ifndef O_CLOEXEC
 #ifdef __sparc__
-- 
2.49.0.906.g1f30a19c02-goog

