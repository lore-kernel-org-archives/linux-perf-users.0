Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40A64D7961;
	Wed, 16 Sep 2026 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576331; cv=none; b=ml4ZBkxu19GD76D9fsl3PBUaKX+obA+2ckVR4CkbU6nNctS3Ebtk/VQ93iOCwz2Iqxt4w7RzNlURZEzWbh3U0NQL3HhiOuK/K6KajowykC+DsNqtV691Satw+tKk/wtsXMYAqaPB2/wyRKz1rMjIMLvO1WrUM41Tycsh2/VR+nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576331; c=relaxed/simple;
	bh=iZdDlLmSP1xQyThCvFt2E8EEhM7YwNXqb2G0ddHAE2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qswiJFGgv6yRSozL5F45HQMZVPgXw9PUdbQoH8mCkvg2MF8KKl+CBWKv18P4osk+5GltHRFaJUGvYw7CcARhX4K2AagHvTPEPJ6vf0Q/FHUSDFczXZ1FR/gvZp47jK6OBNVRyd65KCVUYGwU8eMkbeLkxufY+gZOpl5squZXNOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FsWqviQQ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FsWqviQQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789576321; x=1821112321;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iZdDlLmSP1xQyThCvFt2E8EEhM7YwNXqb2G0ddHAE2Y=;
  b=FsWqviQQaCMhqwF7e9SuywHLRov0410adh8cNcM7F4SbiCxqRx47raOu
   HG8JI31Iock/truLdjHpUATfilwcVRgDXAKgfedOZOuDaOTyhq0yrZK4/
   ZzJU3vwwFD4WQ09PLXDixDHymEU2B2K0IauPWwBbtwi+DA3aNdURMAp8l
   CcXYVuNKRIYMWL6AHrQfOmtTY4i49llcV7s/2PMp1pqrofzdJrHo73Yva
   IceS8UrmgCJo7rHY/C1og8xcubSvCNg+vcDa5QrGb6XwLJPZMlzy+VE6W
   7imgXzVO+Rd8fzaLHB4xN8LsgR58nxFYyO2kisfKtVzN017DvyRoEqgWz
   A==;
X-CSE-ConnectionGUID: YbHHHgZVRtGcDnT5/uQ3OQ==
X-CSE-MsgGUID: QLrx1BDYRSGeZ17uXyJiMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90093411"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90093411"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 09:31:49 -0700
X-CSE-ConnectionGUID: cx/o+7DnToKbZ9302/x3dQ==
X-CSE-MsgGUID: 3MyNogs6Qai+kSsXQvKKqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="273363827"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.223.212])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 09:31:48 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH v10 3/6] perf header: Support memory ranges
Date: Wed, 16 Sep 2026 11:31:24 -0500
Message-ID: <20260916163127.318885-4-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916163127.318885-1-thomas.falcon@intel.com>
References: <20260916163127.318885-1-thomas.falcon@intel.com>
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

Example output:
 # memory ranges (nr 5):
 # range0: [0x0000000000000000-0x00000000bfffffff], node = 0, local_region_id = 0, remote_region_id = 255
 # range1: [0x0000000100000000-0x000000203fffffff], node = 0, local_region_id = 0, remote_region_id = 255
 # range2: [0x0000008000000000-0x0000027fffffffff], node = -2, local_region_id = 1, remote_region_id = 255
 # range3: [0x0000028000000000-0x0000047fffffffff], node = -2, local_region_id = 1, remote_region_id = 255
 # range4: [0x0000048000000000-0x000004ffffffffff], node = -2, local_region_id = 1, remote_region_id = 255

[1]: https://lore.kernel.org/lkml/20250505173819.419271-1-tony.luck@intel.com/

Assisted-by: Sashiko:gemini-3.1-pro-preview
Assisted-by: GitHub-Copilot:claude-opus-4-8
Reviewed-by: Ian Rogers <irogers@google.com>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
---
v10:
-- Add missing #include <fcntl.h> for open/openat/O_DIRECTORY (Sashiko)
-- Fix up incorrectly formatted comment in process_memory_ranges()
v4:
-- Fixed bounds checking for local and remote region IDs in
   memory_range__read(), which made region "255" invalid
v3:
-- Added missing ff->size check in process_memory_ranges()
-- used open/openat to read memory range sysfs files in memory_range__read()
-- Removed path name and file name buffers in memory_range__read(),
   instead pass path name from as a parameter from memory_range__parse()
-- use calloc instead of zalloc in memory_range__parse() and
   process_memory_ranges()
-- Removed redundant check for existance of memory range directory in
   memory_range__read()
-- Included examples of memory range output in commit message
v2:
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
 tools/perf/util/header.c                      | 205 ++++++++++++++++++
 tools/perf/util/header.h                      |   1 +
 6 files changed, 231 insertions(+)

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
index ec2935c0ed04..38f2da9de5f0 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -7,6 +7,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <fcntl.h>
 
 #include <byteswap.h>
 #include <dirent.h>
@@ -95,6 +96,7 @@
 #define MAX_PMU_CAPS		512
 #define MAX_PMU_MAPPINGS	4096
 #define MAX_SCHED_DOMAINS	64
+#define MAX_MEMORY_RANGES	256
 
 /*
  * magic2 = "PERFILE2"
@@ -1914,6 +1916,132 @@ static int write_cpu_domain_info(struct feat_fd *ff,
 	return ret;
 }
 
+static int memory_range__read(struct memory_range *range, const char *path)
+{
+	char buf[32];
+	ssize_t n;
+	int dfd, fd, tmp, ret = -1;
+
+	dfd = open(path, O_RDONLY | O_DIRECTORY);
+	if (dfd < 0)
+		return -1;
+
+#define _R(name, dst, conv)			\
+	fd = openat(dfd, name, O_RDONLY);	\
+	if (fd < 0)				\
+		goto out;			\
+	n = read(fd, buf, sizeof(buf) - 1);	\
+	close(fd);				\
+	if (n <= 0)				\
+		goto out;			\
+	buf[n] = '\0';				\
+	dst = conv(buf, NULL, 0);
+
+	_R("base", range->base, strtoull);
+	_R("length", range->length, strtoull);
+	_R("node", range->node, strtol);
+	_R("local_region_id", tmp, strtol);
+	if (tmp < 0 || tmp > UINT8_MAX)
+		goto out;
+	range->local_region_id = tmp;
+	_R("remote_region_id", tmp, strtol);
+	if (tmp < 0 || tmp > UINT8_MAX)
+		goto out;
+	range->remote_region_id = tmp;
+#undef _R
+
+	ret = 0;
+out:
+	close(dfd);
+	return ret;
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
+		scnprintf(path, PATH_MAX,
+			  "%s/firmware/acpi/memory_ranges/range%d",
+			  sysfs, nr_memory_ranges);
+		if (stat(path, &st))
+			break;
+
+		nr_memory_ranges++;
+	}
+
+	if (nr_memory_ranges == 0)
+		return 0;
+
+	*ranges = calloc(nr_memory_ranges, sizeof(struct memory_range));
+	if (!(*ranges))
+		return -ENOMEM;
+
+	for (i = 0; i < nr_memory_ranges; i++) {
+		struct memory_range range;
+
+		scnprintf(path, PATH_MAX,
+			  "%s/firmware/acpi/memory_ranges/range%d", sysfs, i);
+		err = memory_range__read(&range, path);
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
@@ -2652,6 +2780,23 @@ static void print_cpu_domain_info(struct feat_fd *ff, FILE *fp)
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
+		fprintf(fp, "# range%u: [0x%016" PRIx64 "-0x%016" PRIx64,
+			i, ranges[i].base, ranges[i].base + ranges[i].length - 1);
+		fprintf(fp, "], node = %d, local_region_id = %d, remote_region_id = %d\n",
+			ranges[i].node, ranges[i].local_region_id,
+			ranges[i].remote_region_id);
+	}
+}
+
 static int __event_process_build_id(struct perf_record_header_build_id *bev,
 				    char *filename,
 				    struct perf_session *session)
@@ -4227,6 +4372,65 @@ static int process_cpu_domain_info(struct feat_fd *ff, void *data __maybe_unused
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
+	/*
+	 * According to version 1.1 of the ACPI MRRM table, the maximum
+	 * number of memory regions can be at most 255. Do a sanity check
+	 * here to guard against a malformed perf.data file.
+	 */
+	if (nr_memory_ranges >= MAX_MEMORY_RANGES) {
+		pr_err("Invalid memory_ranges: nr_memory_ranges (%u) > %u\n",
+		       nr_memory_ranges, MAX_MEMORY_RANGES);
+		return -1;
+	}
+
+	if (ff->size < sizeof(u32) + nr_memory_ranges * (2 * sizeof(u64) + sizeof(u32) + 2 * sizeof(u8))) {
+		pr_err("Invalid HEADER_MEMORY_RANGES: section too small (%zu) for %u range entries\n",
+		       ff->size, nr_memory_ranges);
+		return -1;
+	}
+
+	ranges = calloc(nr_memory_ranges, sizeof(*ranges));
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
@@ -4291,6 +4495,7 @@ const struct perf_header_feature_ops feat_ops[HEADER_LAST_FEATURE] = {
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

