Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B693DFC7F;
	Fri, 10 Apr 2026 22:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775858996; cv=none; b=iH0sADBxab9/T0ko/J/6fscY8xOHMn6J7yCsc4ia3Gr8E+layG85dLDtS75bq1cmVto3ZNStucx6EYsr4yCQFnmpvT2qtxN/6L+vPGWdTy4NV0CtfClz2tlw8jzonQowPTDztMCBfw+OjJoR6p+8K4Mqt2QRL/Tv9uknHEuEAx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775858996; c=relaxed/simple;
	bh=nTVueE5sivSHveP+KHEDhryCMxE648En1ksQQHY7Jgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bo/8DtyaWRBvHVQ+6oaSYJqjoiktordjNKUenebb6jTcjSdhi7vySlFsjHesNVsLPenZ0Lkw8GJoN3Mj/frZO67TAiRvQc0gPWgCQdvBlO3u22AuRT13RMBdmHvqRyN4jIr/ARR0mxAFL/fLfyIVys/fh3t3sc9U6miOw0qiYuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnv1Qcyd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnv1Qcyd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E83C19421;
	Fri, 10 Apr 2026 22:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775858996;
	bh=nTVueE5sivSHveP+KHEDhryCMxE648En1ksQQHY7Jgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jnv1QcydL7ECC03ntPctojrO7tz66Jk2d9VFIc3khbpwOfARcRzsFZdYtWnqziHIO
	 hZuEkn79E+nrMV4DsPla9bh+jNAwm+Lnem4yFbgMiiABQp48YPgsY/hSAp7PzSUAoF
	 IfuUStITh906CcQWD1dRqd1qw42xkLlJVSy8b7Ah3BXB93/Fif9vXpZAMyP6kZGrUR
	 1XpiBEbSFshRZQ1fU5tJFxrfpYL9yzT+x3rxvliFUDH9h+N2EbxG9aNqNUYeTUdSJ3
	 umJtUJooBuAHAkrLwITMMwGfNYEKCyxVDYCn0FmuLDuN4mLdXcdRD4JrpRDW8HilIM
	 1pbMqVBsxGy1Q==
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
Subject: [PATCH 10/13] perf header: Sanity check HEADER_HYBRID_TOPOLOGY
Date: Fri, 10 Apr 2026 19:09:02 -0300
Message-ID: <20260410220905.200051-11-acme@kernel.org>
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

Add upper bound check on nr_nodes in process_hybrid_topology() to
harden against malformed perf.data files (reuses MAX_PMU_MAPPINGS,
4096).

Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Code:claude-opus-4-6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 749a522fe057e739..a609fc7d959fae04 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3450,6 +3450,18 @@ static int process_hybrid_topology(struct feat_fd *ff,
 	if (do_read_u32(ff, &nr))
 		return -1;
 
+	if (nr > MAX_PMU_MAPPINGS) {
+		pr_err("Invalid HEADER_HYBRID_TOPOLOGY: nr_nodes (%u) > %u\n",
+		       nr, MAX_PMU_MAPPINGS);
+		return -1;
+	}
+
+	if (ff->size < sizeof(u32) + nr * 2 * sizeof(u32)) {
+		pr_err("Invalid HEADER_HYBRID_TOPOLOGY: section too small (%zu) for %u nodes\n",
+		       ff->size, nr);
+		return -1;
+	}
+
 	nodes = calloc(nr, sizeof(*nodes));
 	if (!nodes)
 		return -ENOMEM;
-- 
2.53.0

