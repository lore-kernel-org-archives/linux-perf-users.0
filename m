Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2561A257452;
	Tue, 14 Jul 2026 00:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783989858; cv=none; b=WuO5RHwO4nmuJjXTEMBk7JObbQMbgIyKsk79SbVZs0QV1uGQQBtytZ8ChhtJzlACNgaJH379+V0oF6VkdjBKqTeH14csUJG0dHx8L3LybqqC6iqAXkPCNG2RCpIXRZOeVXTTr1MLl/1sVdAdfNSlp+U2QfT3yBfppE3IBPoBof0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783989858; c=relaxed/simple;
	bh=EHQWZCby+86QZyL8GyW64x/uqQoAOWjwYbwQmwIxx+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/x12HHQatVrbltNkDIEnnwpR9QtMQY1wYqfeKXc9eWEjnp4ooGF4VhovvskpcZQfnKuVa5zffUlDefRXn8nnCnD/Wo0huWD4bma6c247ILrvpn1CCCOkqTvHyXFAx51BMVVpD4GShfMHnUMedCbviT0mis+Btu6TKYlaYW3p4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dfBULFXY; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dfBULFXY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783989856; x=1815525856;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EHQWZCby+86QZyL8GyW64x/uqQoAOWjwYbwQmwIxx+M=;
  b=dfBULFXYmJ5BEBzPy/g4qfPPVf1vrZ7jzMTtv72eKuzL4TZC8BSRL/xU
   v5Y4tTk6NVQHGhkODFAPWlmepgJ/hZLQdUrf9AuToQ3Y9n5Qne/Ek9zQK
   TFU0Vx1PqXYaEyn3M4kpLfZiYSEDUl5JQ00t35CtaryA3iJLU8m9bl18c
   doG6JYTUblbAlyn2T8SdjJoZaaXzvHuRmqHRt8czaX5WIdP/ZwRLVHSX3
   bbaCJCJ+V0X/58m9+de0C9C3T6XMgPcqSHhXS+meaj30Zqau2uHh0C4N/
   tQ+M5NORChydq3slZ4SR5hHGKRn0QcTkVq+uniezMbAVpeJMOE+0NCkfJ
   Q==;
X-CSE-ConnectionGUID: 1tAjTz6rTZ+oHE+q8DH++w==
X-CSE-MsgGUID: fIoSx3N1TNmeFKZou1Qh9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="72130668"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="72130668"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 17:44:16 -0700
X-CSE-ConnectionGUID: +mhml6qOQvSnn/efFhRg/w==
X-CSE-MsgGUID: 37fSUZ5xR0ml/jRD019QUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="260582154"
Received: from rodrigoa-mobl1.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.220.48])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 17:44:14 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH v2 5/6] perf header: Support memory ranges
Date: Mon, 13 Jul 2026 19:43:58 -0500
Message-ID: <20260714004359.179451-6-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714004359.179451-1-thomas.falcon@intel.com>
References: <20260714004359.179451-1-thomas.falcon@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Memory ranges were created to track different types of memory,
such as persistent, high bandwidth, or CXL-attached, that may
be present on a system for performance monitoring and resource
control purposes.

Memory range data are parsed from the ACPI MRRM table and exposed
to userspace tools via sysfs [1]. Memory range data is read from:

	/sys/firmware/acpi/memory_ranges/rangeX

With the following attributes:

	u64 base;
	u64 length;
	int node;
	u8  local_region_id;
	u8  remote_region_id;

Read memory range data from sysfs if present and save it in
the header of the perf data file under a new feature bit,
HEADER_MEMORY_RANGES (35). Memory range data can be viewed with the
--header or --header-only options of perf-report and perf-script.

[1]: https://lore.kernel.org/lkml/20250505173819.419271-1-tony.luck@intel.com/

Assisted-by: Sashiko:gemini-3.1-pro-preview
Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
---
Changes in v2: 
-- Added check for NULL return of sysfs__mountpoint() when parsing
   memory ranges in sysfs
-- increased MAX_MEMORY_RANGES sanity check from 64 to 256 based on 
   ACPI MRRM table implementation in Linux kernel
-- added comment for MAX_MEMORY_RANGES to clarify that it is a sanity check
   for malformed perf.data files
-- removed a line of code was removed from util/env.h but was added back in
   v1 due to bad rebase
---
 .../Documentation/perf.data-file-format.txt   |  13 ++
 tools/perf/builtin-inject.c                   |   1 +
 tools/perf/util/env.c                         |   1 +
 tools/perf/util/env.h                         |  10 +
 tools/perf/util/header.c                      | 195 ++++++++++++++++++
 tools/perf/util/header.h                      |   1 +
 6 files changed, 221 insertions(+)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index b90cba9168f8..1f8e7d8e9ae2 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -478,6 +478,19 @@ The size of the cacheline in bytes. Format:
 
 	unsigned int cln_size;
 
+	HEADER_MEMORY_RANGES = 35,
+
+List of memory ranges. The format of the data is as below.
+
+u32 nr_memory_ranges;
+struct memory_range {
+	u64 base;
+	u64 length;
+	int node;
+	u8 local_region_id;
+	u8 remote_region_id;
+}; [nr_memory_ranges]
+
 	other bits are reserved and should be ignored for now
 	HEADER_FEAT_BITS	= 256,
 
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 70bbfad5653e..169617a884d3 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2306,6 +2306,7 @@ static bool keep_feat(struct perf_inject *inject, int feat)
 	case HEADER_PMU_CAPS:
 	case HEADER_CPU_DOMAIN_INFO:
 	case HEADER_CLN_SIZE:
+	case HEADER_MEMORY_RANGES:
 		return true;
 	/* Information that can be updated */
 	case HEADER_BUILD_ID:
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index c0e2b9d5f0b2..50993b0dedc5 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -297,6 +297,7 @@ void perf_env__exit(struct perf_env *env)
 		zfree(&env->pmu_caps[i].pmu_name);
 	}
 	zfree(&env->pmu_caps);
+	zfree(&env->memory_ranges);
 	free_cpu_domain_info(env->cpu_domain, env->schedstat_version, env->nr_cpus_avail);
 }
 
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 7acca39b42ff..23d35425efe3 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -68,6 +68,14 @@ struct cpu_domain_map {
 	struct domain_info	**domains;
 };
 
+struct memory_range {
+	u64 base;
+	u64 length;
+	int node;
+	u8 local_region_id;
+	u8 remote_region_id;
+};
+
 struct perf_env {
 	char			*hostname;
 	char			*os_release;
@@ -100,6 +108,7 @@ struct perf_env {
 	int			nr_cpu_pmu_caps;
 	int			nr_hybrid_nodes;
 	int			nr_pmus_with_caps;
+	int			nr_memory_ranges;
 	char			*cmdline;
 	const char		**cmdline_argv;
 	char			*sibling_cores;
@@ -122,6 +131,7 @@ struct perf_env {
 	unsigned long long	 memory_bsize;
 	struct hybrid_node	*hybrid_nodes;
 	struct pmu_caps		*pmu_caps;
+	struct memory_range	*memory_ranges;
 #ifdef HAVE_LIBBPF_SUPPORT
 	/*
 	 * bpf_info_lock protects bpf rbtrees. This is needed because the
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index e90e541f546b..0669898362d6 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -92,6 +92,7 @@
 #define MAX_PMU_CAPS		512
 #define MAX_PMU_MAPPINGS	4096
 #define MAX_SCHED_DOMAINS	64
+#define MAX_MEMORY_RANGES	256
 
 /*
  * magic2 = "PERFILE2"
@@ -1891,6 +1892,130 @@ static int write_cpu_domain_info(struct feat_fd *ff,
 	return ret;
 }
 
+static int memory_range__read(struct memory_range *range, int idx)
+{
+	char path[PATH_MAX], file[PATH_MAX];
+	struct stat st;
+	int tmp;
+
+	scnprintf(path, PATH_MAX, "firmware/acpi/memory_ranges/range%d", idx);
+	scnprintf(file, PATH_MAX, "%s/%s", sysfs__mountpoint(), path);
+	if (stat(file, &st))
+		return -1;
+
+	scnprintf(file, PATH_MAX, "%s/base", path);
+	if (sysfs__read_xll(file, (unsigned long long *) &range->base))
+		return -1;
+
+	scnprintf(file, PATH_MAX, "%s/length", path);
+	if (sysfs__read_xll(file, (unsigned long long *) &range->length))
+		return -1;
+
+	scnprintf(file, PATH_MAX, "%s/node", path);
+	if (sysfs__read_int(file, (int *) &range->node))
+		return -1;
+
+	scnprintf(file, PATH_MAX, "%s/local_region_id", path);
+	if (sysfs__read_int(file, &tmp))
+		return -1;
+
+	if (tmp < 0 || tmp > 255)
+		return -1;
+	range->local_region_id = tmp;
+
+	scnprintf(file, PATH_MAX, "%s/remote_region_id", path);
+	if (sysfs__read_int(file, &tmp))
+		return -1;
+
+	if (tmp < 0 || tmp > 255)
+		return -1;
+	range->remote_region_id = tmp;
+
+	return 0;
+}
+
+static int memory_range__parse(struct memory_range **ranges)
+{
+	const char *sysfs = sysfs__mountpoint();
+	int i, err, nr_memory_ranges = 0;
+	char path[PATH_MAX];
+	struct stat st;
+
+	if (!sysfs)
+		return 0;
+
+	scnprintf(path, PATH_MAX, "%s/firmware/acpi/memory_ranges", sysfs);
+	if (stat(path, &st))
+		return 0;
+
+	while (1) {
+		scnprintf(path, PATH_MAX, "%s/firmware/acpi/memory_ranges/range%d", sysfs, nr_memory_ranges);
+		if (stat(path, &st))
+			break;
+
+		nr_memory_ranges++;
+	}
+
+	if (nr_memory_ranges == 0)
+		return 0;
+
+	*ranges = zalloc(nr_memory_ranges * sizeof(struct memory_range));
+	if (!(*ranges))
+		return -ENOMEM;
+
+	for (i = 0; i < nr_memory_ranges; i++) {
+		struct memory_range range;
+
+		err = memory_range__read(&range, i);
+		if (err < 0)
+			goto out_error;
+
+		(*ranges)[i] = range;
+	}
+
+	return nr_memory_ranges;
+
+out_error:
+	zfree(ranges);
+	return -1;
+}
+
+static int write_memory_ranges(struct feat_fd *ff,
+			 struct evlist *evlist __maybe_unused)
+{
+	struct memory_range *ranges = NULL;
+	int nr_memory_ranges = 0, ret;
+
+	nr_memory_ranges = memory_range__parse(&ranges);
+	if (nr_memory_ranges < 0)
+		return nr_memory_ranges;
+
+	ret = do_write(ff, &nr_memory_ranges, sizeof(nr_memory_ranges));
+	if (ret < 0)
+		goto out;
+
+	for (int i = 0; i < nr_memory_ranges; i++) {
+		ret = do_write(ff, &ranges[i].base, sizeof(u64));
+		if (ret < 0)
+			goto out;
+		ret = do_write(ff, &ranges[i].length, sizeof(u64));
+		if (ret < 0)
+			goto out;
+		ret = do_write(ff, &ranges[i].node, sizeof(u32));
+		if (ret < 0)
+			goto out;
+		ret = do_write(ff, &ranges[i].local_region_id, sizeof(u8));
+		if (ret < 0)
+			goto out;
+		ret = do_write(ff, &ranges[i].remote_region_id, sizeof(u8));
+		if (ret < 0)
+			goto out;
+	}
+out:
+	zfree(&ranges);
+	return ret;
+}
+
 static void print_hostname(struct feat_fd *ff, FILE *fp)
 {
 	fprintf(fp, "# hostname : %s\n", ff->ph->env.hostname);
@@ -2628,6 +2753,23 @@ static void print_cpu_domain_info(struct feat_fd *ff, FILE *fp)
 	}
 }
 
+static void print_memory_ranges(struct feat_fd *ff, FILE *fp)
+{
+	struct memory_range *ranges = ff->ph->env.memory_ranges;
+	int nr_memory_ranges = ff->ph->env.nr_memory_ranges;
+	int i;
+
+	fprintf(fp, "# memory ranges (nr %d):\n", nr_memory_ranges);
+
+	for (i = 0; i < nr_memory_ranges; i++) {
+		fprintf(fp, "# range%u: 0x%16" PRIx64 "-0x%16" PRIx64,
+			i, ranges[i].base, ranges[i].base + ranges[i].length - 1);
+		fprintf(fp, ", node = %d, local_region_id = %d, remote_region_id = %d\n",
+			ranges[i].node, ranges[i].local_region_id,
+			ranges[i].remote_region_id);
+	}
+}
+
 static int __event_process_build_id(struct perf_record_header_build_id *bev,
 				    char *filename,
 				    struct perf_session *session)
@@ -4201,6 +4343,58 @@ static int process_cpu_domain_info(struct feat_fd *ff, void *data __maybe_unused
 	return ret;
 }
 
+static int process_memory_ranges(struct feat_fd *ff, void *data __maybe_unused)
+{
+	struct perf_env *env = &ff->ph->env;
+	struct memory_range *ranges, *r;
+	u32 nr_memory_ranges, i;
+
+	if (do_read_u32(ff, &nr_memory_ranges))
+		return -1;
+
+	if (!nr_memory_ranges) {
+		pr_debug("memory ranges not available\n");
+		return 0;
+	}
+
+	/* According to version 1.1 of the ACPI MRRM table, the maximum
+	 * number of memory regions can be at most 255. Do a sanity check
+	 * here to guard against a malformed perf.data file.
+	 */
+	if (nr_memory_ranges >= MAX_MEMORY_RANGES) {
+		pr_err("Invalid memory_ranges: nr_memory_ranges (%u) > %u\n",
+		       nr_memory_ranges, MAX_MEMORY_RANGES);
+		return -1;
+	}
+
+	ranges = zalloc(nr_memory_ranges * sizeof(*ranges));
+	if (!ranges)
+		return -1;
+
+	for (i = 0; i < nr_memory_ranges; i++) {
+		r = &ranges[i];
+
+		if (do_read_u64(ff, &r->base))
+			goto error;
+		if (do_read_u64(ff, &r->length))
+			goto error;
+		if (do_read_u32(ff, (u32 *) &r->node))
+			goto error;
+		if (__do_read(ff, &r->local_region_id, sizeof(u8)))
+			goto error;
+		if (__do_read(ff, &r->remote_region_id, sizeof(u8)))
+			goto error;
+	}
+
+	env->memory_ranges = ranges;
+	env->nr_memory_ranges = nr_memory_ranges;
+
+	return 0;
+error:
+	zfree(&ranges);
+	return -1;
+}
+
 #define FEAT_OPR(n, func, __full_only) \
 	[HEADER_##n] = {					\
 		.name	    = __stringify(n),			\
@@ -4265,6 +4459,7 @@ const struct perf_header_feature_ops feat_ops[HEADER_LAST_FEATURE] = {
 	FEAT_OPR(CPU_DOMAIN_INFO,	cpu_domain_info,	true),
 	FEAT_OPR(E_MACHINE,	e_machine,	false),
 	FEAT_OPR(CLN_SIZE,	cln_size,	false),
+	FEAT_OPR(MEMORY_RANGES,	memory_ranges,	false),
 };
 
 struct header_print_data {
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 5e03f884b7cc..765037762758 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -56,6 +56,7 @@ enum {
 	HEADER_CPU_DOMAIN_INFO,
 	HEADER_E_MACHINE,
 	HEADER_CLN_SIZE,
+	HEADER_MEMORY_RANGES,
 	HEADER_LAST_FEATURE,
 	HEADER_FEAT_BITS	= 256,
 };
-- 
2.43.0

