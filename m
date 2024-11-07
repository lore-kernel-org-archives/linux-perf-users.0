Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2605F218929
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Nov 2024 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996447; cv=none; b=CtOGUsbLrLrhvTJL/JfgWRgPnQeULrndECqCYJcpujG5EQs78nveBD/g7/QI9UeJDCLKJWEKeOQENbIvH76N+R6eAxVAfzIV4v0w3vYV1YgM8fw2+ZcJNrcMWjUiRrYpdOx+lNAGKgNo8/ER2vPvWHlm4F+POD1Bu5IMn/YtKrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996447; c=relaxed/simple;
	bh=7oem3ThhepX9gsZkLkU3ubM5v/EmPX06HEqwbDIU+q4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=iDZ6/eT3v9pZ6UP2YwDs0WIKBf2XI3XPy1fGS0NvdEi6nAHOrYUWQeGxbOUxg66pqpD4bdL+EKiBx4hnErrd0a0lbzsWXR/bAa9YIvqYpUOfgAwiFaEQaI7516o2KA+9S0UVN4EaDrO3pSVJN6STK2WQyiwjF06zU4ZxZtxyQuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bw6IXehJ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bw6IXehJ"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea8d6fb2ffso21218407b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Nov 2024 08:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730996445; x=1731601245; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l25I5Jel5U2/0S9AyIDPTs5/QytgoUZMY3CNnmJZTzE=;
        b=bw6IXehJkYX4+BylYkDNFo3v8i1Zha1jQ7CrufGEmzY7ZL70rx23yE7mh0TG98s9qa
         WowOS5guH95BGTOKoOvJZ9leIId9buWx1Q+Cpp604ni+ThgEBO5gi8p3FdNDd6sSyOxD
         u1FqF5Jq8/c0W0zHXNEVjgxhWjwAl2glo2dfS84vpRjAvXlpEUZCPLN5K69rAxK1BEiA
         JXTAjRw+MsRxMsYS1Tx7/l1Z7XZzJgDyeHqfoOKG6qC4BlKajjGtJr7qIQ/TKtxDiUzW
         +MkVJUQ+qkCbs1ziswB9+jus9Gp0T1uCicaMg7i/Gqf8YyN+furRmQ+fVqLd1YNkPH08
         S1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730996445; x=1731601245;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l25I5Jel5U2/0S9AyIDPTs5/QytgoUZMY3CNnmJZTzE=;
        b=e4scs+mhiHsmCUriDjQorrxa8qYp9uPaI8F+/xzHocTDKANLX8EAKODcEkczKIfEuc
         x63Kvesiqo8EWU50B6nhWSh3RvsoCO5j/nMCPkrRCxhrFdWDHqCyM2FW0tbEKmOl4dLe
         Gr6iCLTf2qByv696S1kE8ITJD1jB6UOs49p7Bo4GAWw1e8AhlN1fhrR5CJN+CzmuoZ6+
         ogIs/vlwjHnp8Vz6U+CxMlyUkEd2hX5/mtt5GMcW4OtT/rB2og3k+fQO76jBgsXd7/1A
         eF08wueQHgB+39GlQVvyoNip3lYexyK8ZOmwN1vLYAzIExD7MYs929To0hE8Kw2qXqFn
         eXgA==
X-Forwarded-Encrypted: i=1; AJvYcCUnBNl12jTZ/3JrXNkztxZUY5Ji8F2nEzLu16G1368l17FCMMba6sGvU8p8lvEPoh3qq8Hnsb9qTE85QR/kpRSZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1StpzIWrk/n8rJY1Bmi98XLW1VcOmI+evPdgFRt04Djnaea9n
	5DVWfQZyBohIdOagIvnbRxLrhDdxD3N5Xz9dz0N3d1J+RPtZTTtT/bWWD9uTRP0KPG3fCuP/E5k
	dBJVmAg==
X-Google-Smtp-Source: AGHT+IFnTI4IcNJ51YDO3rsAiQCbXWeV3EQq6I2FsC+sGE3SpDVNd7WlWxpa52LoAfCUNYpttoUYsg4Abinq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc7:bda:7167:18d8])
 (user=irogers job=sendgmr) by 2002:a05:690c:6313:b0:6e3:6414:80c5 with SMTP
 id 00721157ae682-6eadbedccc8mr2287b3.0.1730996445083; Thu, 07 Nov 2024
 08:20:45 -0800 (PST)
Date: Thu,  7 Nov 2024 08:20:29 -0800
In-Reply-To: <20241107162035.52206-1-irogers@google.com>
Message-Id: <20241107162035.52206-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107162035.52206-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v2 2/8] perf header: Move is_cpu_online to numa bench
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

The helper function is only used in the NUMA benchmark as typically
online CPUs are determined through
perf_cpu_map__new_online_cpus(). Reduce the scope of the function for
now.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/numa.c  | 53 ++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/header.c | 51 --------------------------------------
 tools/perf/util/header.h |  1 -
 3 files changed, 53 insertions(+), 52 deletions(-)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 1fbd7c947abc..19be2aaf4dc0 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -27,6 +27,7 @@
 #include <sys/resource.h>
 #include <sys/wait.h>
 #include <sys/prctl.h>
+#include <sys/stat.h>
 #include <sys/types.h>
 #include <linux/kernel.h>
 #include <linux/time64.h>
@@ -35,6 +36,7 @@
 
 #include "../util/header.h"
 #include "../util/mutex.h"
+#include <api/fs/fs.h>
 #include <numa.h>
 #include <numaif.h>
 
@@ -533,6 +535,57 @@ static int parse_cpu_list(const char *arg)
 	return 0;
 }
 
+/*
+ * Check whether a CPU is online
+ *
+ * Returns:
+ *     1 -> if CPU is online
+ *     0 -> if CPU is offline
+ *    -1 -> error case
+ */
+static int is_cpu_online(unsigned int cpu)
+{
+	char *str;
+	size_t strlen;
+	char buf[256];
+	int status = -1;
+	struct stat statbuf;
+
+	snprintf(buf, sizeof(buf),
+		"/sys/devices/system/cpu/cpu%d", cpu);
+	if (stat(buf, &statbuf) != 0)
+		return 0;
+
+	/*
+	 * Check if /sys/devices/system/cpu/cpux/online file
+	 * exists. Some cases cpu0 won't have online file since
+	 * it is not expected to be turned off generally.
+	 * In kernels without CONFIG_HOTPLUG_CPU, this
+	 * file won't exist
+	 */
+	snprintf(buf, sizeof(buf),
+		"/sys/devices/system/cpu/cpu%d/online", cpu);
+	if (stat(buf, &statbuf) != 0)
+		return 1;
+
+	/*
+	 * Read online file using sysfs__read_str.
+	 * If read or open fails, return -1.
+	 * If read succeeds, return value from file
+	 * which gets stored in "str"
+	 */
+	snprintf(buf, sizeof(buf),
+		"devices/system/cpu/cpu%d/online", cpu);
+
+	if (sysfs__read_str(buf, &str, &strlen) < 0)
+		return status;
+
+	status = atoi(str);
+
+	free(str);
+	return status;
+}
+
 static int parse_setup_cpu_list(void)
 {
 	struct thread_data *td;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index a6386d12afd7..55c28e4377ec 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -987,57 +987,6 @@ static int write_dir_format(struct feat_fd *ff,
 	return do_write(ff, &data->dir.version, sizeof(data->dir.version));
 }
 
-/*
- * Check whether a CPU is online
- *
- * Returns:
- *     1 -> if CPU is online
- *     0 -> if CPU is offline
- *    -1 -> error case
- */
-int is_cpu_online(unsigned int cpu)
-{
-	char *str;
-	size_t strlen;
-	char buf[256];
-	int status = -1;
-	struct stat statbuf;
-
-	snprintf(buf, sizeof(buf),
-		"/sys/devices/system/cpu/cpu%d", cpu);
-	if (stat(buf, &statbuf) != 0)
-		return 0;
-
-	/*
-	 * Check if /sys/devices/system/cpu/cpux/online file
-	 * exists. Some cases cpu0 won't have online file since
-	 * it is not expected to be turned off generally.
-	 * In kernels without CONFIG_HOTPLUG_CPU, this
-	 * file won't exist
-	 */
-	snprintf(buf, sizeof(buf),
-		"/sys/devices/system/cpu/cpu%d/online", cpu);
-	if (stat(buf, &statbuf) != 0)
-		return 1;
-
-	/*
-	 * Read online file using sysfs__read_str.
-	 * If read or open fails, return -1.
-	 * If read succeeds, return value from file
-	 * which gets stored in "str"
-	 */
-	snprintf(buf, sizeof(buf),
-		"devices/system/cpu/cpu%d/online", cpu);
-
-	if (sysfs__read_str(buf, &str, &strlen) < 0)
-		return status;
-
-	status = atoi(str);
-
-	free(str);
-	return status;
-}
-
 #ifdef HAVE_LIBBPF_SUPPORT
 static int write_bpf_prog_info(struct feat_fd *ff,
 			       struct evlist *evlist __maybe_unused)
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index a63a361f20f4..e91e89d22537 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -196,7 +196,6 @@ int write_padded(struct feat_fd *fd, const void *bf,
 
 #define MAX_CACHE_LVL 4
 
-int is_cpu_online(unsigned int cpu);
 int build_caches_for_cpu(u32 cpu, struct cpu_cache_level caches[], u32 *cntp);
 
 /*
-- 
2.47.0.199.ga7371fff76-goog

