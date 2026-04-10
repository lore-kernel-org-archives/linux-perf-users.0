Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C552EA749;
	Fri, 10 Apr 2026 00:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775781676; cv=none; b=WcMk4jET8YfriTTVo2iMugB24PKWjFLEPQycWz/XJkr1qJRA36Qx6+jliJDpoHhd2oMtw9ucgmahfCZ+j7BH3OaX+TwK3KQfPuNFqq46sMSE4pGfmAcYXBg8NHGQqBZ8dM5IbImzrx8m9IlOEI8T0KlH9HFwrG37DvhfJebNHdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775781676; c=relaxed/simple;
	bh=kcCt8KLANRhZti7x7N45YPBBSZhkbpritvjXyabvHfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRVRJ+kASHoRmkTLRulWZ/cixfsJDl9LRIXexxkVMpz31p5dYGGVqGVjAYJ1cxPRBo/4cbsGnGKt8IP+tRrQPYZDDedVMUeEq5fWiuIyhSMEhGHSMfqhQg9axQWk0lSEmsogPgTOD5jNJe89c8lpzrsMuyFvqszvBze3BMxqLl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRe+HQ3B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRe+HQ3B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44027C2BCAF;
	Fri, 10 Apr 2026 00:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775781675;
	bh=kcCt8KLANRhZti7x7N45YPBBSZhkbpritvjXyabvHfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uRe+HQ3BEEt97ZnRmYKOsMvojM/fX0CqMNuXoH/tbOZAtqKjNt6RUz6/GLA/fUUAT
	 CMEdhv44bOaDRHg+ulgYiUOLfF6hslscpAvAvuRDtiL8GQ4CjKLb/RldVjsU6PQsis
	 GtxKXnggx79uSFYTh+gECVD4fWONjkcsB10HzgF4YaxK+Rhm3YORUZyITJMFROAutv
	 WAHleSl5CEFTPUVyrDY/i50XEihSc0vA6uOLsK+YtKOpZvI210tfYWosUZ+XvmeuQT
	 6PDqB+FT9usHQHmT+fMjjeudPhWANBX2zP2yn/A4c57crRQvQzPub+RfByFU7I0qXW
	 pyeGSu7jFn4kA==
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
Date: Thu,  9 Apr 2026 21:39:57 -0300
Message-ID: <20260410004000.148138-11-acme@kernel.org>
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
index 494206faeb250956..a1f19c1954774e9d 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3448,6 +3448,18 @@ static int process_hybrid_topology(struct feat_fd *ff,
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

