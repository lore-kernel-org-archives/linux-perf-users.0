Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ACC28EF;
	Wed,  9 Oct 2024 06:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728454971; cv=none; b=tAqGgRuaYbf2C3Yu2rIcX8u2N5yr+ucLx165nc9F4janQGvmqg5W/4rFOGQyrHG+Lac5aPongnij4m9W4+VlEupyydBUa5UBNo9DLUjPS+he2QL/5wsyNQBV4OP7ZhtVHr9FO8dw+wU9epO9UKF9Qc7ecy6WYl4lvGsRSi+pwKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728454971; c=relaxed/simple;
	bh=VQDBI3P2v1glV69DXsoPdzq8y4H8cqcf/WnJRvLCTO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fJXInjMWdZ3mzyXP/dvdldhRHO5v60iOQPE6Jgr0IwOIkYUSMJ5/cGVoOTms9r7NYr6p/myvdzplvZ006KWVbWbBSryFinO2Vcq64Y4qxssWIwj5YWJLbZMsMA0CIajwlUgKrIPok/PyGfq9w0xXZMOKdUcgLNGKEZyAsAMr3uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oA5HzNK1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oA5HzNK1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF93FC4CEC5;
	Wed,  9 Oct 2024 06:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728454971;
	bh=VQDBI3P2v1glV69DXsoPdzq8y4H8cqcf/WnJRvLCTO4=;
	h=From:To:Cc:Subject:Date:From;
	b=oA5HzNK1yIaxzfcSCoe4IRBPT1nX3pv7QlI3vZQdbIGkOQGsPSRp0gBfNxGvOLfjX
	 VB6m+sV6HKNMZrZqQ5hRXXAYJYTWXeS9sXYT221W+5EjflqSo083h9++JB1kMrK+PE
	 E5C1KX2kYRT5go3saGurF1GjTJuq7ikV6SDmufURu+O/RkFis/S2Uigsk2jitBCqqB
	 Nxlqv05RjrNYN+URYdlM45VAVJyivPC6sH6UczlJoDP56WTkcu4HkOrWilFxEgY9Bz
	 KHWcgL50l7q9OeiqxuExvLeA7H2jzcAAy9df5htbBIRTP6ClOg0nZo+WI/Xocw6A38
	 ZVwnMHa2y7yng==
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
	Ben Gainey <ben.gainey@arm.com>
Subject: [PATCH] perf evsel: Fix missing inherit + sample read check
Date: Tue,  8 Oct 2024 23:22:50 -0700
Message-ID: <20241009062250.730192-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It should not clear the inherit bit simply because the kernel doesn't
support the sample read with it.  IOW the inherit bit should be kept
when the sample read is not requested for the event.

Fixes: 90035d3cd876cb71 ("tools/perf: Allow inherit + PERF_SAMPLE_READ when opening events")
Cc: Ben Gainey <ben.gainey@arm.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/evsel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d8fd493af01458b7..507f526ccbbcfc36 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2112,7 +2112,8 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 static void evsel__disable_missing_features(struct evsel *evsel)
 {
-	if (perf_missing_features.inherit_sample_read)
+	if (perf_missing_features.inherit_sample_read && evsel->core.attr.inherit &&
+	    (evsel->core.attr.sample_type & PERF_SAMPLE_READ))
 		evsel->core.attr.inherit = 0;
 	if (perf_missing_features.branch_counters)
 		evsel->core.attr.branch_sample_type &= ~PERF_SAMPLE_BRANCH_COUNTERS;
-- 
2.47.0.rc0.187.ge670bccf7e-goog

