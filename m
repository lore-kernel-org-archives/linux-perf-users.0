Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808653;
	b=ZV/2xDbKzXouFLPZUzG7/OKBA6wI+jy+H1ZQna2GkGSvGDtuX/rx5umoRcOgBokwN6pi
	 GMr4qvGO4hoXBnXaajeU1vF32b70DTE4lxjcFMtL559zAE6BVyFrvMy+XAZ+XWCZ5bwbT
	 TTz9SVNw5IXh09Ye1BVbY2pFjYui4rohu+8SYKCF4DHKqX78wqswZ8QcV0HnuOl2La9Nc
	 dFmAtSvDLHOzeJjvJlzh4fLEX4ve6F8DkNk3zDefHXXq7ipOULE1fMxzhFpEPs0yFBbep
	 lptvhGq0S+Xn+FqU1jME6q7kpUQnS9vOxDP8mbE6jvHM5XTIpJBeYGURaMvkEG2wb8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808653;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Mv67XmZm0wBG10N0XGa1LICzQ/7pzN1IQDuOUzryD+M=;
	b=cUYkiu6J7cRmMzy7XyqPzXpPtsKTlMNkcHPvsZt1MHRWGmQOgI3rB9P6oRKtUfDYvXsh
	 4o9sS4bVDBdB1ixf6SfwhEeG7o+zl9loYoSY5kihyWrQFfmXLjQGovm3NCRPydx8X/rfI
	 1DI5jr07MUfoeUoEIE9mHUTRrDGKyI2wKBBGUn1XXYDG+iIVxMvWpyEY2TBFZFyAsCtF/
	 f8jKxjLgla7YCu1oaYDNO5U5sWFpelHbKJJXzJm8PNPC5Jo10OYTXSjdUo2nnv1U+KBmq
	 XOC3PI8xGMf+v7VtZUQYuTbju6fc+wWfvMbeclKThqXdGl6Pz7Oc0b0AZgdrp+iCCow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bTTOyKrU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2460606A31C;
	Mon, 16 Nov 2026 05:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bTTOyKrU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318CD1F000C6;
	Mon, 16 Nov 2026 05:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794808653;
	bh=Mv67XmZm0wBG10N0XGa1LICzQ/7pzN1IQDuOUzryD+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bTTOyKrUizKUv5p6LBjnnlFjfZfml6/pZbaAOZmpFTDG7K/o1iksNXoUc8cuwX42x
	 3LfpyqzJHHN4xEEO7iPfa1jNPW/3VTtcFnhhn1P5befYITci+Qt+e7fL0QPy/o84bl
	 4Xmu4HbJE/WOrwcO9lCQNGkoLNDcdsdwOsrvHOO13auLbZ0VrmVMPXwac53R9cqU3+
	 dmqGd23lFLHQ0P7SGKVeZ+2Vv2EGf51CY4ezmvSH9yEFKckV5taOz+qgQ63fi/1GJr
	 kLkxYJcfmbR2tmGufmyxLDwkMRTgMha14T2tlR9FOaKYaYetaMZzkMDqZH0Q/DdMmE
	 MNPejWYIyEOhg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 01/11] perf tools: Add HEADER_BOOT_ID feature
Date: Sun, 15 Nov 2026 21:57:21 -0800
Message-ID: <20261116055731.707164-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
In-Reply-To: <20261116055731.707164-1-namhyung@kernel.org>
References: <20261116055731.707164-1-namhyung@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Save /proc/sys/kernel/random/boot_id in the perf.data header and
struct perf_env so post-processing tools can identify if it's the
same kernel boot on which the data was recorded.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 .../Documentation/perf.data-file-format.txt   |  5 +++
 tools/perf/builtin-inject.c                   |  1 +
 tools/perf/util/env.c                         | 44 +++++++++++++++++++
 tools/perf/util/env.h                         |  3 ++
 tools/perf/util/header.c                      | 28 ++++++++++++
 tools/perf/util/header.h                      |  1 +
 tools/perf/util/session.c                     |  1 +
 7 files changed, 83 insertions(+)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index 1f8e7d8e9ae21d73..359d6ef0c80aac26 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -491,6 +491,11 @@ struct memory_range {
 	u8 remote_region_id;
 }; [nr_memory_ranges]
 
+	HEADER_BOOT_ID = 36,
+
+	A perf_header_string with the kernel boot ID read from
+	/proc/sys/kernel/random/boot_id.
+
 	other bits are reserved and should be ignored for now
 	HEADER_FEAT_BITS	= 256,
 
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 3f3108fd39811017..0e01b14fa51676ab 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2307,6 +2307,7 @@ static bool keep_feat(struct perf_inject *inject, int feat)
 	case HEADER_CPU_DOMAIN_INFO:
 	case HEADER_CLN_SIZE:
 	case HEADER_MEMORY_RANGES:
+	case HEADER_BOOT_ID:
 		return true;
 	/* Information that can be updated */
 	case HEADER_BUILD_ID:
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 50993b0dedc577c7..24de685486af9bd5 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -12,6 +12,7 @@
 #include <linux/string.h>
 #include <linux/zalloc.h>
 #include "cgroup.h"
+#include <api/fs/fs.h>
 #include <errno.h>
 #include <sys/utsname.h>
 #include <stdlib.h>
@@ -258,6 +259,7 @@ void perf_env__exit(struct perf_env *env)
 	zfree(&env->os_release);
 	zfree(&env->version);
 	zfree(&env->arch);
+	zfree(&env->boot_id);
 	zfree(&env->cpu_desc);
 	zfree(&env->cpuid);
 	zfree(&env->cmdline);
@@ -400,6 +402,48 @@ const char *perf_env__os_release(struct perf_env *env)
 	return release;
 }
 
+static char *read_host_boot_id(void)
+{
+	char *buf = NULL;
+	size_t sz;
+
+	if (procfs__read_str("sys/kernel/random/boot_id", &buf, &sz) < 0)
+		return NULL;
+
+	strim(buf);
+	return buf;
+}
+
+const char *perf_env__boot_id(struct perf_env *env)
+{
+	const char *boot_id;
+
+	if (!env)
+		return NULL;
+
+	mutex_lock(&env->lock);
+	if (env->boot_id) {
+		boot_id = env->boot_id;
+		goto out;
+	}
+
+	/*
+	 * If this is an offline target environment (set by perf_session on
+	 * read or via HEADER_ARCH / HEADER_HOSTNAME), do not fall back to the
+	 * host's boot_id when boot_id is not populated in the file.
+	 */
+	if (env->offline || env->arch || env->hostname) {
+		boot_id = NULL;
+		goto out;
+	}
+
+	env->boot_id = read_host_boot_id();
+	boot_id = env->boot_id;
+out:
+	mutex_unlock(&env->lock);
+	return boot_id;
+}
+
 int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[])
 {
 	int i;
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 23d35425efe38b24..aafd213c7523c018 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -81,6 +81,7 @@ struct perf_env {
 	char			*os_release;
 	char			*version;
 	char			*arch;
+	char			*boot_id;
 	/* e_machine expanded from 16 to 32-bits for alignment. */
 	u32			e_machine;
 	u32			e_flags;
@@ -154,6 +155,7 @@ struct perf_env {
 	/* For fast cpu to numa node lookup via perf_env__numa_node */
 	int			*numa_map;
 	int			 nr_numa_map;
+	bool			 offline;
 
 	/* For real clock time reference. */
 	struct {
@@ -187,6 +189,7 @@ void perf_env__exit(struct perf_env *env);
 int perf_env__kernel_is_64_bit(struct perf_env *env);
 bool perf_arch_is_big_endian(const char *arch);
 const char *perf_env__os_release(struct perf_env *env);
+const char *perf_env__boot_id(struct perf_env *env);
 
 int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[]);
 
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 9eec6deee190ff21..3e0b6fce55973dd1 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -494,6 +494,27 @@ static int write_version(struct feat_fd *ff,
 	return do_write_string(ff, perf_version_string);
 }
 
+static int write_boot_id(struct feat_fd *ff, struct evlist *evlist)
+{
+	const char *boot_id = NULL;
+	char *buf = NULL;
+	size_t sz;
+	int ret;
+
+	if (evlist__session(evlist))
+		boot_id = perf_env__boot_id(perf_session__env(evlist__session(evlist)));
+
+	if (!boot_id) {
+		if (procfs__read_str("sys/kernel/random/boot_id", &buf, &sz) < 0)
+			return -1;
+		boot_id = strim(buf);
+	}
+
+	ret = do_write_string(ff, boot_id);
+	free(buf);
+	return ret;
+}
+
 static int __write_cpudesc(struct feat_fd *ff, const char *cpuinfo_proc)
 {
 	FILE *file;
@@ -2079,6 +2100,11 @@ static void print_version(struct feat_fd *ff, FILE *fp)
 	fprintf(fp, "# perf version : %s\n", ff->ph->env.version);
 }
 
+static void print_boot_id(struct feat_fd *ff, FILE *fp)
+{
+	fprintf(fp, "# boot id : %s\n", ff->ph->env.boot_id);
+}
+
 static void print_cmdline(struct feat_fd *ff, FILE *fp)
 {
 	int nr, i;
@@ -3022,6 +3048,7 @@ FEAT_PROCESS_STR_FUN(osrelease, os_release);
 FEAT_PROCESS_STR_FUN(version, version);
 FEAT_PROCESS_STR_FUN(cpudesc, cpu_desc);
 FEAT_PROCESS_STR_FUN(cpuid, cpuid);
+FEAT_PROCESS_STR_FUN(boot_id, boot_id);
 
 static int process_arch(struct feat_fd *ff, void *data __maybe_unused)
 {
@@ -4496,6 +4523,7 @@ const struct perf_header_feature_ops feat_ops[HEADER_LAST_FEATURE] = {
 	FEAT_OPR(E_MACHINE,	e_machine,	false),
 	FEAT_OPR(CLN_SIZE,	cln_size,	false),
 	FEAT_OPR(MEMORY_RANGES,	memory_ranges,	false),
+	FEAT_OPR(BOOT_ID,	boot_id,	false),
 };
 
 struct header_print_data {
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 765037762758ca11..5bbf16342b4d26d8 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -57,6 +57,7 @@ enum {
 	HEADER_E_MACHINE,
 	HEADER_CLN_SIZE,
 	HEADER_MEMORY_RANGES,
+	HEADER_BOOT_ID,
 	HEADER_LAST_FEATURE,
 	HEADER_FEAT_BITS	= 256,
 };
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index a58b4fe44b62e3bb..578abcb14de84a39 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -179,6 +179,7 @@ struct perf_session *__perf_session__new(struct perf_data *data,
 		session->data = data;
 
 		if (perf_data__is_read(data)) {
+			session->header.env.offline = true;
 			ret = perf_session__open(session);
 			if (ret < 0)
 				goto out_delete;
-- 
2.56.0.611.g1030f0b940-goog

