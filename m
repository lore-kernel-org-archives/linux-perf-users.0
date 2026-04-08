Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D32C3D6462;
	Wed,  8 Apr 2026 17:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669563; cv=none; b=rZZHyz2y0zUGrF2ZsL3urr0nLllAc1d8ObTkKy6Wk7mO//3IAzKs+zpUT6DGoj2yyFNwbnDcMvAOC2RtXJxWJniOkfiQYWy+wrkkYHvoLZdRJMAWqjs1/2+7WStwxA02jsp1EYl3zmI0tm1HwBM9KQXgXIvV7Do52qyiDuntwQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669563; c=relaxed/simple;
	bh=orlL54mCmEorzqNfVbLNSd1ScbzcBuEP0XD1vjtyr4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+FJx0cm92d0bW/j3cZVlVbWaU2qSpgQk94dp6u4HtjHmd1AXhJMEIB7/LDkF23PVEZgjnN4rCAT7fZbT71g4fDb7tLYkiHrgwxPyDSuzcZhnH0B88wTwDMKUE04tDrYnONfSPfLBMa8io56HeXVTuVDmLyqV/E04leyMv+f/D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ohioj3xV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ohioj3xV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D6DC2BC87;
	Wed,  8 Apr 2026 17:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775669563;
	bh=orlL54mCmEorzqNfVbLNSd1ScbzcBuEP0XD1vjtyr4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ohioj3xVqUEza7sr1irUOBIgSvMX5f/UUY5mrZCmYaQmKSZ40klxCXj+pqfEBruWZ
	 V4bDA7R6MNpIIeQD4Oqfzlfk798UbZCKmOaG2m+T+T2Wmjaj2AaTHf8xOpIsbflIIi
	 Yjl+b1quRTf6dKN/j2pZBYTmnIWp36S3KDaiToPYquofZ5W3LJfSowHNhKL4FWuIwX
	 nD0O1k98vdN7/i51qnvuyGCsvJGwix/ZH75UuFJ3HJcJkBAgxGW7XEiHaWfwDl2OKF
	 jubmAp+WlG3mo5H+b2RbEzxRP98y90D5PVmewAFmsayaUM2K5vah3K/YFG/t2lMk0V
	 wKny8czmc90Zg==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 6/8] perf header: Do validation of perf.data HEADER_CPU_DOMAIN_INFO
Date: Wed,  8 Apr 2026 14:32:01 -0300
Message-ID: <20260408173203.96700-7-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408173203.96700-1-acme@kernel.org>
References: <20260408173203.96700-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As suggested in an unrelated sashiko review:

  https://sashiko.dev/#/patchset/20260407195145.2372104-1-acme%40kernel.org

"
Could a malformed perf.data file provide out-of-bounds values for cpu and
domain?
These variables are read directly from the file and used as indices for
cd_map and cd_map[cpu]->domains without any validation against
env->nr_cpus_avail or max_sched_domains.
Similar to the issue above, this is an existing lack of validation that
becomes apparent when looking at the allocation boundaries.
"

Validate it.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index a18f216f77c27430..4925e33778b91313 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3717,6 +3717,11 @@ static int process_cpu_domain_info(struct feat_fd *ff, void *data __maybe_unused
 		if (do_read_u32(ff, &cpu))
 			return -1;
 
+		if (cpu >= nra) {
+			pr_err("Invalid HEADER_CPU_DOMAIN_INFO: cpu %d >= nr_cpus_avail (%d)\n", cpu, nra);
+			return -1;
+		}
+
 		cd_map[cpu] = zalloc(sizeof(*cd_map[cpu]));
 		if (!cd_map[cpu])
 			return -1;
@@ -3736,6 +3741,12 @@ static int process_cpu_domain_info(struct feat_fd *ff, void *data __maybe_unused
 			if (do_read_u32(ff, &domain))
 				return -1;
 
+			if (domain >= max_sched_domains) {
+				pr_err("Invalid HEADER_CPU_DOMAIN_INFO: domain %d >= max_sched_domains (%d)\n",
+				       domain, max_sched_domains);
+				return -1;
+			}
+
 			d_info = zalloc(sizeof(*d_info));
 			if (!d_info)
 				return -1;
-- 
2.53.0

