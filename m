Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DD33E0259;
	Fri, 10 Apr 2026 22:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775859000; cv=none; b=F2Lr5h/ojiKI3f//QYyEFBQ0m5TzuCgyU/Lgm31gq9hzn+541UNJwgkTaFBtwQJ8hGwMtTE7dgR0qAUzGx1V2n/8tIZpPy35ZRxr3Rk9LubhMclNqj6wsjL9odO6NhByWPpXnnEu+J8TuNEumgvWJ30b3QR+whluB4prnY/ggPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775859000; c=relaxed/simple;
	bh=DGanuo7H1Cz0/iclidenEyL10ERjkYfUFJF7X9lfhus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s4whjor1/ZJSPr2UDR4ed+bJHr6Uvi3vIH7L1+o+5CEiR7Z9d28qxEhvFYhHVgzo6a8Gog9iKenujV2iQtfxV58PYD0d/j4URnZGLwjN8rogWijUitixE/jNebraO06k2sdM2fvcSULUfvdQMD//TT/6mMcqu/KNOqipgp+qmKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eO8aW/f3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eO8aW/f3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57FDC2BC87;
	Fri, 10 Apr 2026 22:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775859000;
	bh=DGanuo7H1Cz0/iclidenEyL10ERjkYfUFJF7X9lfhus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eO8aW/f3k46yzxHjQTPVatlcK9ODnFUOg4ACs4PzRRAAfWlfOEUGc45QcPE0EBq2V
	 CudnTYHBlRMvQy/dlYNCEWcUCSiLJ3LS3eciOOrwpDTdswfgJSfekAtbh6m04x+Buf
	 kwidKVre5oQ5vSdI9JKSbxIFsW7U+ohOq0JHFmDUSxY/6hbgZ/Jz8wGjCi0DmfAWDu
	 Y0Vs3TYlwdqZiYY1qbpLa+t2qYTxzIaw43q8zFAPVf0VEnc7wnTay+eFGsdmnGfsrX
	 Uz2BST2OXXHyIicVSj62Hb+t2kRYt6e020E7raBfKtV0+BFFoLmrTrKm4s6ifzrSZX
	 yUT/cVyvQqBBQ==
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
	Ravi Bangoria <ravi.bangoria@amd.com>
Subject: [PATCH 11/13] perf header: Sanity check HEADER_PMU_CAPS
Date: Fri, 10 Apr 2026 19:09:03 -0300
Message-ID: <20260410220905.200051-12-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410220905.200051-1-acme@kernel.org>
References: <20260410220905.200051-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Add upper bound checks in PMU capabilities processing to harden against
malformed perf.data files:

- nr_pmu bounded to MAX_PMU_MAPPINGS (4096) in process_pmu_caps()
- nr_pmu_caps bounded to MAX_PMU_CAPS (512) in __process_pmu_caps()

Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Code:claude-opus-4-6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index a609fc7d959fae04..37c1afbc081672f1 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -66,6 +66,7 @@
 #define MAX_CACHE_ENTRIES	32768
 #define MAX_GROUP_DESC		32768
 #define MAX_NUMA_NODES		4096
+#define MAX_PMU_CAPS		512
 #define MAX_PMU_MAPPINGS	4096
 #define MAX_SCHED_DOMAINS	64
 
@@ -3677,6 +3678,12 @@ static int __process_pmu_caps(struct feat_fd *ff, int *nr_caps,
 	if (!nr_pmu_caps)
 		return 0;
 
+	if (nr_pmu_caps > MAX_PMU_CAPS) {
+		pr_err("Invalid pmu caps: nr_pmu_caps (%u) > %u\n",
+		       nr_pmu_caps, MAX_PMU_CAPS);
+		return -1;
+	}
+
 	*caps = calloc(nr_pmu_caps, sizeof(char *));
 	if (!*caps)
 		return -1;
@@ -3754,6 +3761,18 @@ static int process_pmu_caps(struct feat_fd *ff, void *data __maybe_unused)
 		return 0;
 	}
 
+	if (nr_pmu > MAX_PMU_MAPPINGS) {
+		pr_err("Invalid HEADER_PMU_CAPS: nr_pmu (%u) > %u\n",
+		       nr_pmu, MAX_PMU_MAPPINGS);
+		return -1;
+	}
+
+	if (ff->size < sizeof(u32) + nr_pmu * sizeof(u32)) {
+		pr_err("Invalid HEADER_PMU_CAPS: section too small (%zu) for %u PMUs\n",
+		       ff->size, nr_pmu);
+		return -1;
+	}
+
 	pmu_caps = calloc(nr_pmu, sizeof(*pmu_caps));
 	if (!pmu_caps)
 		return -ENOMEM;
-- 
2.53.0

