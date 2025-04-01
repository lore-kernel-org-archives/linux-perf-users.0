Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA38228CB7
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Apr 2025 18:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743531972; cv=none; b=CwdRS2yObEgrUewp+HuLaTxe+nLzq3xcgCXCJ+LDCmyZxNTWj2kot5zongLuFIvzWLzUDXIjPM4/UDOz0zGUbRCmB889JvmiBI30zTio4C/MAVtHbYIAxUI/9tUbwZcooVLRfzA8BLv/w84ZMlTcdMd6Dp91vnLcIbCtwdyZ8EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743531972; c=relaxed/simple;
	bh=s717chdg+kUkOKWgech/40orJr8HpUqoe1xLZ+drgUo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=B9oE8k5dv6cKKHrpYRhSWNdWFmHYbgYYzLe/kOqdA6d+vZowOB614rnYd728LtbfoTGq7Wab9d65BE2jqjp26Hz5mW3CK9gu+Lq1V0sPZNFg/ryZRTXafKgUiFqewiXvFyDtkl8mRA6AE0wGCb4tjxWx5uYDFQuHEKVvH/NlxaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YqVaU0O5; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YqVaU0O5"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-229668c8659so5269625ad.3
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Apr 2025 11:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743531970; x=1744136770; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uf82K12GlQ/n7riesGFWT8XnJRxl30Twhf4yK1Xn0q4=;
        b=YqVaU0O5yaEbd2b5vN388AxmKocEzGjzAzoIkdTud1rvkhj4NW8NnSSFgTu17heGf+
         Xx1lKiWMy+7DYbtOh+ElETSylpWxHzb1cJHHgw+5Eerg2TC3cuNmcFptbnEicf8xFLq8
         OFD0JRTrxpPSTpXHrLWIkCcbVlT3XlB7XpOLge/05AQ2okcu+gIIx1fQNwTIuZyqbw1k
         nvY/9s6oxoH2n7/8Up6svz3r1kOQ3os0A5SGIpBQ+z10nc6G2xIgvxi7ufNCW63Kwr/E
         xFBxj3GxVc3z1FmGefaUfjOdd6TyVhl7FTmhNgTSAe5XtSwxmleRymHcwSjEVaTKSBPZ
         P4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743531970; x=1744136770;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uf82K12GlQ/n7riesGFWT8XnJRxl30Twhf4yK1Xn0q4=;
        b=a+I2Dh0pn8HA/n/Eze1u6G35uDst1y/OWsGWxsAxbkqc589QdE+iBlx5NxboDKV3v6
         0aggFRAZShATfz+1keTWN+qa1BcZtNDBh/dts3se/XtvTbD86OVL0broyiCvc55Ysz+S
         NfDBgC3xqVhBKVAuADkHyENmw8twmTH8HMFGbnj5dPfuzFjIbPdvenYxYfESOTcK0i9c
         PFzidQqkg2D8Zvgvr3ypPxKyWE1WNsEg5qfjf2hTDy0QtHtN7gzscIgKvSim4VmA7wdV
         SyhKFIfOMEi+69m909SF0ukMT2IGSui/16le3+0tt6Ay+dfOhGm4wMivccSIANnKg+Po
         K8hA==
X-Forwarded-Encrypted: i=1; AJvYcCUadCPs9+AmWaCHKMwM4WBUx8At2AHN5XPgMmaq6g+36KzSJPLUQotp3sV63Sm+eVX/kvSc2PD+pFT+aHujVM2G@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6RD6yT6kWgefA7SAmcc23Q2ltfqg0PyjnszLxXmIrvKu4m1eS
	c13mLTXRESqTqrXPeCI5sBgW4W9poS2Y8Myr4vAj+EPZmsMONpq252w5X8ZlXTlPHHqw4n/5LPI
	SUaQ1Lw==
X-Google-Smtp-Source: AGHT+IER4xC3pb/cBZi0Xgwt4i8RZtO+p4l4gcTF5gsnxGo5ob1iymplbCkmr8xH6eC77SkY7Tl6nBneD8IY
X-Received: from plcn5.prod.google.com ([2002:a17:902:d2c5:b0:223:8244:94f6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f64e:b0:223:669f:ca2d
 with SMTP id d9443c01a7336-2292f9d67e9mr257670695ad.35.1743531969969; Tue, 01
 Apr 2025 11:26:09 -0700 (PDT)
Date: Tue,  1 Apr 2025 11:23:44 -0700
In-Reply-To: <20250401182347.3422199-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401182347.3422199-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250401182347.3422199-47-irogers@google.com>
Subject: [PATCH v1 46/48] perf util: Silence -Wshorten-64-to-32 warnings
From: Ian Rogers <irogers@google.com>
To: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
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
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Andrew Kreimer <algonell@gmail.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Zixian Cai <fzczx123@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yujie Liu <yujie.liu@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
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
2.49.0.504.g3bcea36a83-goog

