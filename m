Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D8819DFB8;
	Thu,  5 Sep 2024 20:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725567869; cv=none; b=iemo3NvtKe95YKB9cgInw0+DkB5ORI/BfOzfxMCewPYpSP60IPIQ3WrPBx9/pPTmtVWM3H4q4nnc+weHrLezBKOiw6ZNqsiwpBHpmbbI3w94G8wsszYwd2J55WS5rCBjgAqo5ceM9YezXgkerGO/86FQc50N+R8r8FPFJ9gngcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725567869; c=relaxed/simple;
	bh=zz+ySZgl+pIeh+EpjXnttIluXk7iAW08LlNQv9LsfNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czfF+t35PRfYVR8RwALsVRtSLlhfwh7uED8ZWAD0wRwLsop+wBJeJqyywE5tSkp/KBnEHtu7zUtrHETGl/RzKVluyx7ySyIzHQod4Xt3mTN2VNBTYAynszIixuWdHuuGbN2QYmjJwG8jFCiAmSiB5q/NHFZYPNMAdKIs7OXjGDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7Gpo4aL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7Gpo4aL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C129C4CEC4;
	Thu,  5 Sep 2024 20:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725567868;
	bh=zz+ySZgl+pIeh+EpjXnttIluXk7iAW08LlNQv9LsfNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F7Gpo4aLn3769GgnX8et58GnBGuZ6WfzEOm+74jViYooOaJxVBT7PgDAzzbo6fG/K
	 NHpTUy3huuVq7lU/JCfXYfCECuFT0dq73It92V4AEV8/mV7Xa1Z7qLFd2DrdwcatU3
	 SSplkOggu2NEtNuw2G0jpMbzr1YYBpbSMN7T5fc4US6o2BLKLV9IXca+rtNdk1U3Dp
	 lAVjB49AGRtFqPIVVJwKr9eehkHJzaiBHLAm2L39GBElJr6wat4+iGuiyUwA9j7btX
	 IRbVbpB4HVNSr0JLhR876n0XqR2iEGXbyMV/BOv8GO2ickFWreEUyAw41vmTs+oQIT
	 VA4/ng3Cx/1Gg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@arm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mingwei Zhang <mizhang@google.com>,
	James Clark <james.clark@linaro.org>
Subject: [PATCH 01/10] perf tools: Add fallback for exclude_guest
Date: Thu,  5 Sep 2024 13:24:17 -0700
Message-ID: <20240905202426.2690105-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240905202426.2690105-1-namhyung@kernel.org>
References: <20240905202426.2690105-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 7b100989b4f6bce70 ("perf evlist: Remove __evlist__add_default")
changed to parse "cycles:P" event instead of creating a new cycles
event for perf record.  But it also changed the way how modifiers are
handled so it doesn't set the exclude_guest bit by default.

It seems Apple M1 PMU requires exclude_guest set and returns EOPNOTSUPP
if not.  Let's add a fallback so that it can work with default events.

Fixes: 7b100989b4f6bce70 ("perf evlist: Remove __evlist__add_default")
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Clark <james.clark@linaro.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c |  3 +--
 tools/perf/util/evsel.c   | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index cf985cdb9a6ee588..d8315dae930184ba 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -639,8 +639,7 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
 	 * (behavior changed with commit b0a873e).
 	 */
 	if (errno == EINVAL || errno == ENOSYS ||
-	    errno == ENOENT || errno == EOPNOTSUPP ||
-	    errno == ENXIO) {
+	    errno == ENOENT || errno == ENXIO) {
 		if (verbose > 0)
 			ui__warning("%s event is not supported by the kernel.\n",
 				    evsel__name(counter));
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 49cc71511c0c8ce8..d59ad76b28758906 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3244,6 +3244,27 @@ bool evsel__fallback(struct evsel *evsel, struct target *target, int err,
 		evsel->core.attr.exclude_kernel = 1;
 		evsel->core.attr.exclude_hv     = 1;
 
+		return true;
+	} else if (err == EOPNOTSUPP && !evsel->core.attr.exclude_guest &&
+		   !evsel->exclude_GH) {
+		const char *name = evsel__name(evsel);
+		char *new_name;
+		const char *sep = ":";
+
+		/* Is there already the separator in the name. */
+		if (strchr(name, '/') ||
+		    (strchr(name, ':') && !evsel->is_libpfm_event))
+			sep = "";
+
+		if (asprintf(&new_name, "%s%sH", name, sep) < 0)
+			return false;
+
+		free(evsel->name);
+		evsel->name = new_name;
+		/* Apple M1 requires exclude_guest */
+		scnprintf(msg, msgsize, "trying to fall back to excluding guest samples");
+		evsel->core.attr.exclude_guest = 1;
+
 		return true;
 	}
 
-- 
2.46.0.469.g59c65b2a67-goog

