Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00932DB7BB;
	Fri, 10 Apr 2026 00:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775781660; cv=none; b=LZAtFSqKub8oBVDAlJZ6fvvXgkXtwMFzChUmHe9f/w3uSNCOrQpvgrxDaXwKZgCjon8IkvZWPC+Myvwme6M0g28UCqMvjNLml52QtjMbjJO7yh9fK6JLqHoDG/5cMkoFKU1wrrTkafAEywmZ2QYqjB+xEfF3bLMwpAoy9CVJNrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775781660; c=relaxed/simple;
	bh=x+HdZV5eWrspVCMl80WA2cJnwuIvxZP37vU4Ee9YRzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GdPkLnKbi09uFtABXS4XLHy9O5dBhM6ASZbdKtGHFg0Zq1vttx7pxjbEi1wlqlOoYgG8CNGBHdcniFZVOx7WkHSk494SgwkmHdK70abH5oJjs+ExKMvsgnZTuVxYv7/m2dsmBh5X8xFLiQ6jQeLJ6ZTxwqtJ9yYar54qYfF3G4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mN6yYfkK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mN6yYfkK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE74C4CEF7;
	Fri, 10 Apr 2026 00:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775781660;
	bh=x+HdZV5eWrspVCMl80WA2cJnwuIvxZP37vU4Ee9YRzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mN6yYfkKZfYLP0SSSv32s/fnK4yEwE1RcYxFqDhiDwsF4jXvaLkwCG3yRwudf5nPa
	 KsyOIM0/zQm4GPuazXX8biTkG3uSZkxEai24lvB8KSMyZ9kPiI/STDao2wzyBSqLSY
	 H0l2pFIBVAwWWwTIO/4yjMR0XZDzOWbWC03y0DhshCXn6arijMIKWklkmrV3W81kD+
	 upQ8GHDoir2ugFHXJhFsOgD5dFpyInOvpsuxGNTLNaef6eq4WvPyEXXxRgoygWyv2K
	 pYmwqa+QwBaqTVIHOAbDhmaQlqL229Ac8lxIQA4t6qDs6T35uL8aw9WYlMuhDfi6kM
	 hW8yGTduWeMuQ==
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
Date: Thu,  9 Apr 2026 21:39:54 -0300
Message-ID: <20260410004000.148138-8-acme@kernel.org>
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

Add upper bound check on pmu_num in process_pmu_mappings() to harden
against malformed perf.data files (max 4096).

Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Code:claude-opus-4-6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 45f533fbb8fdc3c6..1d7ca467acf32bd4 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3067,6 +3067,19 @@ static int process_pmu_mappings(struct feat_fd *ff, void *data __maybe_unused)
 		return 0;
 	}
 
+#define MAX_PMU_MAPPINGS 4096
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

