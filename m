Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C49222565;
	Thu, 20 Nov 2025 00:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763599651; cv=none; b=CGCseuQ81mDPmVJ0g2p+l9yX699dO3CnBYY+8MJk+bA3V24DRjA7p8smyn6VHHiC5PdcBIc7RxcYCxZXRHsqxGt3Ojvln42ZhMVloqUgTZA0QvQ9Uw9y0XHPPHLBqN8kzGI5OZBkpvVUEkmrjXBOplxbHF0HPvTCsaDv5xZdQS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763599651; c=relaxed/simple;
	bh=fMFQXNNNh6qPqnyh6nI2efrhtrlizECu75ennidkLTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPIhyLRWWWBV9y2/5373CnJK1P3iN9enDN3k3PYBdV7x47YpdfI+Ikr/XEcFLCZbpKOVL77yt/LRE0u8W52YcTBL16G5M83dkTCygtfaA50DZp6lr+c/XVz2BYX4h2DCPCLe3tDyj1cZKGFpGBt+kf2+Lf3uWXJvdGP9eKDIKkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psRpzVBA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psRpzVBA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA938C116B1;
	Thu, 20 Nov 2025 00:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763599650;
	bh=fMFQXNNNh6qPqnyh6nI2efrhtrlizECu75ennidkLTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=psRpzVBATKEr2HtAiG0pDg/AygxaqTswIlINeKWXtPKhT2/NP9u9igTfryO199f56
	 /Vw1SOlGvTf3KoHrNtgLkHoU6560Rxhdj2gXI3eHLauNJAHuMlMjue5Y+J/ySvDJKk
	 lCvg/zzQOpfUaFARRnPh3/XrEysm3pE13i6PntpENEk1/6V12LKYobUu72K64Oyx9v
	 +snayEo/s7RmHWX9GrAGMPXKIEDlHwwoFBAZXO6tgUtms9MtSZx+6Yyuerz17udDSt
	 YZOu925i0fTZ0XgiUWFAaxJIiRLSBE34uMa+rEhF/nT3VA6IoMEjV+D5tG1f4tgxuO
	 g9JBCH1KMWGvw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 3/3] perf list: Support filtering in JSON output
Date: Wed, 19 Nov 2025 16:47:26 -0800
Message-ID: <20251120004726.61660-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251120004726.61660-1-namhyung@kernel.org>
References: <20251120004726.61660-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like regular output mode, it should honor command line arguments to
limit to a certain type of PMUs or events.

  $ perf list -j hw
  [
  {
          "Unit": "cpu",
          "Topic": "legacy hardware",
          "EventName": "branch-instructions",
          "EventType": "Kernel PMU event",
          "BriefDescription": "Retired branch instructions [This event is an alias of branches]",
          "Encoding": "cpu/event=0xc4\n/"
  },
  {
          "Unit": "cpu",
          "Topic": "legacy hardware",
          "EventName": "branch-misses",
          "EventType": "Kernel PMU event",
          "BriefDescription": "Mispredicted branch instructions",
          "Encoding": "cpu/event=0xc5\n/"
  },
  ...

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-list.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 6c5913f129f39c94..5cbca0bacd35237e 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -373,6 +373,23 @@ static void json_print_event(void *ps, const char *topic,
 	FILE *fp = print_state->common.fp;
 	struct strbuf buf;
 
+	if (deprecated && !print_state->common.deprecated)
+		return;
+
+	if (print_state->common.pmu_glob &&
+	    (!pmu_name || !strglobmatch(pmu_name, print_state->common.pmu_glob)))
+		return;
+
+	if (print_state->common.exclude_abi && pmu_type < PERF_TYPE_MAX &&
+	    pmu_type != PERF_TYPE_RAW)
+		return;
+
+	if (print_state->common.event_glob &&
+	    (!event_name || !strglobmatch(event_name, print_state->common.event_glob)) &&
+	    (!event_alias || !strglobmatch(event_alias, print_state->common.event_glob)) &&
+	    (!topic || !strglobmatch_nocase(topic, print_state->common.event_glob)))
+		return;
+
 	strbuf_init(&buf, 0);
 	fprintf(fp, "%s{\n", print_state->need_sep ? ",\n" : "");
 	print_state->need_sep = true;
@@ -449,6 +466,13 @@ static void json_print_metric(void *ps __maybe_unused, const char *group,
 	FILE *fp = print_state->common.fp;
 	struct strbuf buf;
 
+	if (print_state->common.event_glob &&
+	    (!print_state->common.metrics || !name ||
+	     !strglobmatch(name, print_state->common.event_glob)) &&
+	    (!print_state->common.metricgroups || !group ||
+	     !strglobmatch(group, print_state->common.event_glob)))
+		return;
+
 	strbuf_init(&buf, 0);
 	fprintf(fp, "%s{\n", print_state->need_sep ? ",\n" : "");
 	print_state->need_sep = true;
-- 
2.52.0.rc1.455.g30608eb744-goog

