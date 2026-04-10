Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8F43DFC7F;
	Fri, 10 Apr 2026 22:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775858985; cv=none; b=I9jjDEDkPfXgNLFHrpDDH8VrWvn9lxK40xoJ77QwLmv2WkFpL6ZnEcSVeHRty53QPlD52Gk2sG8SjFqukHN51kZG5Z7Wmz00xG+rGxSUsMg3RoLIYUpgy3bjiwKqkYmSQKZ6Q7DxReNbTQRrTIjeBgbeN2no5Bilejg04tfE6n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775858985; c=relaxed/simple;
	bh=y5muVBclDDD5JHumd2ZKnBINCZzJgClZlIqyrILwvDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KgIcvv9t5Cav763SK1ZtG91CwvO3nnZmHKUVTk2EgjySAMtXs0vyCDdsGYnVxsLQK57S5oo1tx0FBSY6dVC2iQpDHWH4WaOIwLiKSa2AGr8r7midNEEDwbaAT4WNBBet/shnGMirBeMtk8dgsBczcwDCGzST/SH4xHst8Q6zoAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rIDJiEFp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rIDJiEFp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C46C19421;
	Fri, 10 Apr 2026 22:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775858984;
	bh=y5muVBclDDD5JHumd2ZKnBINCZzJgClZlIqyrILwvDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rIDJiEFprirRebflUb0XZjZ9Ddwf70S5DAjbSvg26yGXW18oABlYjSyeijiBfXyhV
	 VTPoLwOwSUht6eQeW4qTB3YQ96bvfKrGF23406JFwshtmRf5Y7iD+C16thcB5KjPV3
	 EA16nF36uqAN9OFfjQpwai3v5cZMYVWb9NmZ6eFO+islMQVu25mr9OefdmQy+nbOVe
	 bDdsV4HJhFoqGcnOXb8NZkMTPOod2PLHCHB5Se3ltGufWYkjFNh9Xkl30MvMFmtj/1
	 iFInyvM92yCiO+pfKxaBiMesgR/IrvDwIDwIxYbJA4jEUBZaDU9f/nXTVX+5pJJARL
	 9Xg6gjcvoGw8g==
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
Subject: [PATCH 07/13] perf header: Sanity check HEADER_PMU_MAPPINGS
Date: Fri, 10 Apr 2026 19:08:59 -0300
Message-ID: <20260410220905.200051-8-acme@kernel.org>
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

Add upper bound check on pmu_num in process_pmu_mappings() to harden
against malformed perf.data files (max 4096).

Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Code:claude-opus-4-6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 2eb909672f826ca4..77035d9b138cb3cd 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -64,6 +64,7 @@
 #endif
 
 #define MAX_NUMA_NODES		4096
+#define MAX_PMU_MAPPINGS	4096
 #define MAX_SCHED_DOMAINS	64
 
 /*
@@ -3069,6 +3070,18 @@ static int process_pmu_mappings(struct feat_fd *ff, void *data __maybe_unused)
 		return 0;
 	}
 
+	if (pmu_num > MAX_PMU_MAPPINGS) {
+		pr_err("Invalid HEADER_PMU_MAPPINGS: pmu_num (%u) > %u\n",
+		       pmu_num, MAX_PMU_MAPPINGS);
+		return -1;
+	}
+
+	if (ff->size < sizeof(u32) + pmu_num * 2 * sizeof(u32)) {
+		pr_err("Invalid HEADER_PMU_MAPPINGS: section too small (%zu) for %u PMUs\n",
+		       ff->size, pmu_num);
+		return -1;
+	}
+
 	env->nr_pmu_mappings = pmu_num;
 	if (strbuf_init(&sb, 128) < 0)
 		return -1;
-- 
2.53.0

