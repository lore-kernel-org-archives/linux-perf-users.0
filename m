Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C528913AD20;
	Wed,  4 Sep 2024 06:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725432099; cv=none; b=t6cGYj4aNnPV2h1g/ZJYmIo73VJk09YkMCgtDrOsArtJjuZRAxrYCfH+20BQLX8MKN16tkm7RgbHDLdGzL2z1FgmMMSGJZp1ISopVFLfZA8sE8IvK0XGM+pKPT1uBBswqDqntDN4O+AgSN10VEv4xPZj6y9X5iTWJbPyX5mrNjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725432099; c=relaxed/simple;
	bh=fJvW9+KOOQiYHrzVIueBlhdfWUeSt3NI3rnFw8+S5ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u6PrEbmcTO84ipLctQlFD1sNBVAUo2KrfYWfE7qlu8SSH9UvTHb5+tz//9LDiBeahnjGOSaIrXDwh2UQjS0V6cxeFSikoPA66bEn6ZGajrdLX/52T8L2cmmEhcGYzzbna4qsghROVjd6LgD7vB+sM1w1P61SydUN52lErTiYT7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gzq675cZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gzq675cZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18E1C4CEC3;
	Wed,  4 Sep 2024 06:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725432099;
	bh=fJvW9+KOOQiYHrzVIueBlhdfWUeSt3NI3rnFw8+S5ek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gzq675cZmGqQoCOIk+pb2drHDbFQbxN3ggodNzgZ+6wLpOt6vI+j+W+iy9AiQwu0h
	 f+KUK5Ijn22uPs5aFv7Bq41IfQpGfx+tGWKObDLluYzvUWt4qXQndIW6gS5RczJ1IW
	 DNMjsUGipMci2PIt+Pc6M/rCXeWPWn1cTz3GEPw5QPInhT+fkPPMuCIz62ZYgMzJMy
	 2V378N6on2eWK6G+ND+ThWumMfaap9yCcJtH6DpjCKAcLZlv/8g7lTJvxFqy+yPj4g
	 cyR3yAeZpRiPXqUF/nLWwRLq93HGcCPepAVRW3WUrcnLRvC1IKMXcqcL+ZdxNWKU0X
	 mMxf7q2V523jw==
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
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mingwei Zhang <mizhang@google.com>
Subject: [PATCH 8/8] perf tools: Check fallback error and order
Date: Tue,  3 Sep 2024 23:41:31 -0700
Message-ID: <20240904064131.2377873-9-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240904064131.2377873-1-namhyung@kernel.org>
References: <20240904064131.2377873-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The perf_event_open might fail due to various reasons, so blindly
reducing precise_ip level might not be the best way to deal with it.

It seems the kernel return -EOPNOTSUPP when PMU doesn't support the
given precise level.  Let's try again with the correct error code.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/evsel.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 8c4d70f7b2f5b880..0133c9ad3ce07a24 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2565,9 +2565,6 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	return 0;
 
 try_fallback:
-	if (evsel__precise_ip_fallback(evsel))
-		goto retry_open;
-
 	if (evsel__ignore_missing_thread(evsel, perf_cpu_map__nr(cpus),
 					 idx, threads, thread, err)) {
 		/* We just removed 1 thread, so lower the upper nthreads limit. */
@@ -2584,11 +2581,12 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	if (err == -EMFILE && rlimit__increase_nofile(&set_rlimit))
 		goto retry_open;
 
-	if (err != -EINVAL || idx > 0 || thread > 0)
-		goto out_close;
+	if (err == -EOPNOTSUPP && evsel__precise_ip_fallback(evsel))
+		goto retry_open;
 
-	if (evsel__detect_missing_features(evsel))
+	if (err == -EINVAL && evsel__detect_missing_features(evsel))
 		goto fallback_missing_features;
+
 out_close:
 	if (err)
 		threads->err_thread = thread;
-- 
2.46.0.469.g59c65b2a67-goog

