Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439B52D9EF0;
	Fri, 10 Apr 2026 00:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775781639; cv=none; b=aHZLI9YfMLNvvoA8D24QRVEfyKzXzOGi1isAqRq4jLcwcNFJw0V0JkPHLBm0qDKKXgudTRBxjrR+Yk2KgzElQcKKmWO52HjGXOMy0bI9cEYriexGcQPjgIAX0K519Cx9JMYm/m5MxpjMgAZEzBo5v1bo34czCNFm1ZPznb0Cb2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775781639; c=relaxed/simple;
	bh=biYJmZbXc6Vv/jraHHe4RTvMieVhQJsZQN/flam6bRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ab3FU++tjcv+GlWm46WMy9/sdJicEaBaM2doJjyh4SAn1fwjxjZK71bFKPfO3wiV0p0Vi723OyEksP7664vOC4scPV69BpQeIc4k/Wyx7Hq2xsmS0ZKqwwOYWvtDOSfmvsOgUdBLL3uBHupyFBu86GhLwybPmj0/Woq6HheSp94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5vXy6MG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5vXy6MG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E3DC4CEF7;
	Fri, 10 Apr 2026 00:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775781638;
	bh=biYJmZbXc6Vv/jraHHe4RTvMieVhQJsZQN/flam6bRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H5vXy6MGkCkZ4c+HRRHhb47sFCpEnm33jwf8fLAzocrMeVME6xe+Zw48PPjUn58+9
	 GRNbeX+PO69UO0pLOcBBskIczUhFcdXgcajJ5gf7yDy4Aw92TDuM4+3HHLJdlyKjRO
	 JrbzMxP933TOMKCre9eVjitryCA5oU/BDVZx4B/LNGyKMhk+88mDgYEtmREy1kupb5
	 5TaCOigsRMrlmwZbKd/6vMH3CivMI3rQ6lnVw2QDeVx1Z06u0T0KGSDI8eQODflzli
	 N9iyzWfhOx/Ri0x1LG6M+Vy6gUHh3IugixxHnZWGMKyUg6pu9QGZuA4u/q/xjx88rs
	 YK5+8QdYHfsDA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>
Subject: [PATCH 03/13] perf header: Sanity check HEADER_NRCPUS and HEADER_CPU_DOMAIN_INFO
Date: Thu,  9 Apr 2026 21:39:50 -0300
Message-ID: <20260410004000.148138-4-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410004000.148138-1-acme@kernel.org>
References: <20260410004000.148138-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

While working on some cleanups sashiko questioned about pre-existing
issues, namely lacking sanity checks for perf.data headers, add some
with the help of Claude.

Cc: Ian Rogers <irogers@google.com>
Cc: Swapnil Sapkal <swapnil.sapkal@amd.com>
Assisted-by: Claude Code:claude-opus-4-6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 44 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 22c44b6f0b098f95..2d23dbc666b676be 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2722,6 +2722,13 @@ static int process_nrcpus(struct feat_fd *ff, void *data __maybe_unused)
 	ret = do_read_u32(ff, &nr_cpus_online);
 	if (ret)
 		return ret;
+
+	if (nr_cpus_online > nr_cpus_avail) {
+		pr_err("Invalid HEADER_NRCPUS: nr_cpus_online (%u) > nr_cpus_avail (%u)\n",
+		       nr_cpus_online, nr_cpus_avail);
+		return -1;
+	}
+
 	env->nr_cpus_avail = (int)nr_cpus_avail;
 	env->nr_cpus_online = (int)nr_cpus_online;
 	return 0;
@@ -3698,6 +3705,17 @@ static int process_cpu_domain_info(struct feat_fd *ff, void *data __maybe_unused
 	nra = env->nr_cpus_avail;
 	nr = env->nr_cpus_online;
 
+	if (nra == 0 || nr == 0) {
+		pr_err("Invalid HEADER_CPU_DOMAIN_INFO: missing HEADER_NRCPUS\n");
+		return -1;
+	}
+
+	if (ff->size < 2 * sizeof(u32) + nr * 2 * sizeof(u32)) {
+		pr_err("Invalid HEADER_CPU_DOMAIN_INFO: section too small (%zu) for %u CPUs\n",
+		       (size_t)ff->size, nr);
+		return -1;
+	}
+
 	cd_map = calloc(nra, sizeof(*cd_map));
 	if (!cd_map)
 		return -1;
@@ -3714,6 +3732,19 @@ static int process_cpu_domain_info(struct feat_fd *ff, void *data __maybe_unused
 	if (ret)
 		return ret;
 
+	/*
+	 * Sanity check: real systems have at most ~10 sched domain levels
+	 * (SMT, CLS, MC, PKG + NUMA hops). Reject obviously bogus values
+	 * from malformed perf.data files before they cause excessive
+	 * allocation in the per-CPU loop.
+	 */
+#define MAX_SCHED_DOMAINS 64
+	if (max_sched_domains > MAX_SCHED_DOMAINS) {
+		pr_err("Invalid HEADER_CPU_DOMAIN_INFO: max_sched_domains %u > %u\n",
+		       max_sched_domains, MAX_SCHED_DOMAINS);
+		return -1;
+	}
+
 	env->max_sched_domains = max_sched_domains;
 
 	for (i = 0; i < nr; i++) {
@@ -3725,6 +3756,11 @@ static int process_cpu_domain_info(struct feat_fd *ff, void *data __maybe_unused
 			return -1;
 		}
 
+		if (cd_map[cpu]) {
+			pr_err("Invalid HEADER_CPU_DOMAIN_INFO: duplicate cpu %u\n", cpu);
+			return -1;
+		}
+
 		cd_map[cpu] = zalloc(sizeof(*cd_map[cpu]));
 		if (!cd_map[cpu])
 			return -1;
@@ -3760,7 +3796,13 @@ static int process_cpu_domain_info(struct feat_fd *ff, void *data __maybe_unused
 			if (!d_info)
 				return -1;
 
-			assert(cd_map[cpu]->domains[domain] == NULL);
+			if (cd_map[cpu]->domains[domain]) {
+				pr_err("Invalid HEADER_CPU_DOMAIN_INFO: duplicate domain %u for cpu %u\n",
+				       domain, cpu);
+				free(d_info);
+				return -1;
+			}
+
 			cd_map[cpu]->domains[domain] = d_info;
 			d_info->domain = domain;
 
-- 
2.53.0

