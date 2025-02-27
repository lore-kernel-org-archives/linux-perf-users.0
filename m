Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F9F226545;
	Thu, 27 Feb 2025 08:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740646557; cv=none; b=NdueQcJECLd/YbVW6btCwoUreMxfxrE7CAYcDcz8zimb1/uIFP2WP0W7oAdpeFEQC/nB0I3c7BcQr3XT9W8yXgbukGk4TepisAfGBK7iwZqJwV8A//bc/79Uo/PmI7M+48m9ykic/KKdkwQgzx8+wcbEDtwC81bsWdP3lMvpn9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740646557; c=relaxed/simple;
	bh=nFDb0HQ5klcSt3RHTBaM1dgkK9KKZ5hTRoc8C2uCHDA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jSH1gnQsh9XzNetqBeEIgE6zuzwbU20RS7mCokhoPzgkPtsrOubBF+FXdUiv0Wy46iVv8ia+ANaESlFxL4Ay2qi9G4yeN9i9wXf11GDjwinm0WbEbwKZmJfus3+jzbqRFeReRHEcwoJNJ0zbcKJJ2QmpyDnn/LargimCFPbp278=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE8102BCA;
	Thu, 27 Feb 2025 00:56:10 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 11EFD3F6A8;
	Thu, 27 Feb 2025 00:55:52 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2] perf arm-spe: Report error if set frequency
Date: Thu, 27 Feb 2025 08:55:44 +0000
Message-Id: <20250227085544.2154136-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When users set the parameter '-F' to specify frequency for Arm SPE, the
tool reports error:

  perf record -F 1000 -e arm_spe_0// -- sleep 1
  Error:
  Invalid event (arm_spe_0//) in per-thread mode, enable system wide with '-a'.

The output logs are confused and it does not give the correct reminding.
Arm SPE does not support frequency setting given it adopts a statistical
based approach.

Alternatively, Arm SPE supports setting period.  This commit adds a
for frequency setting.  It reports error and reminds users to set period
instead.

After:

  perf record -F 1000 -e arm_spe_0// -- sleep 1
  Arm SPE: Frequency is not supported. Set period with -c option or PMU parameter (-e arm_spe_0/period=NUM/).

Signed-off-by: Leo Yan <leo.yan@arm.com>
---

Changes from v1:
- Sugguested users for '-c' option or PMU parameter 'period' in the log
  (Namhyung)

 tools/perf/arch/arm64/util/arm-spe.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 4301181b8e45..4f2833b62ff5 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -40,6 +40,19 @@ struct arm_spe_recording {
 	bool			*wrapped;
 };
 
+/* Iterate config list to detect if the "freq" parameter is set */
+static bool arm_spe_is_set_freq(struct evsel *evsel)
+{
+	struct evsel_config_term *term;
+
+	list_for_each_entry(term, &evsel->config_terms, list) {
+		if (term->type == EVSEL__CONFIG_TERM_FREQ)
+			return true;
+	}
+
+	return false;
+}
+
 /*
  * arm_spe_find_cpus() returns a new cpu map, and the caller should invoke
  * perf_cpu_map__put() to release the map after use.
@@ -389,6 +402,14 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 				return -EINVAL;
 			}
 			opts->full_auxtrace = true;
+
+			if (opts->user_freq != UINT_MAX ||
+			    arm_spe_is_set_freq(evsel)) {
+				pr_err("Arm SPE: Frequency is not supported. "
+				       "Set period with -c option or PMU parameter (-e %s/period=NUM/).\n",
+				       evsel->pmu->name);
+				return -EINVAL;
+			}
 		}
 	}
 
-- 
2.25.1

