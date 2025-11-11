Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25932BE059;
	Tue, 11 Nov 2025 07:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762847985; cv=none; b=vEUoyonMre+B+fixpnBRbbQouKIjWl+eI6ujT4qNZdSvQMiT7JNVEHcpktlujBRN8eIxjAa+0NZuFDPxh7nhEMtft1G8clHSwO+FTfBavcKp6C13KyxlKcfIdKfMdT+F+QBM+7VuXKklFoRem9cG3ciB+Pqk7hcTx8txtXeC2uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762847985; c=relaxed/simple;
	bh=wU/4chIBiKswVk2ZLdfvUxpnXcvkeaW4+cNktUAjkSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HMwt3pQefpO2haxU8aS7aV6JGvVg+eoihWl67U7ajUVBk9GvHoDGz1ZKDMau26VK/8DxNShnVWD4MyHrjfQs/wrgf7xKx2rmU7Z4XTqmCxTvH/rS3y73i3+1JMz1ASceU+7FGhqpL9XxyBwPEylZ7T/1V+sWjWMhT/Ri2Z4ZPo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmeQHynK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmeQHynK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44B9C4CEFB;
	Tue, 11 Nov 2025 07:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762847985;
	bh=wU/4chIBiKswVk2ZLdfvUxpnXcvkeaW4+cNktUAjkSA=;
	h=From:To:Cc:Subject:Date:From;
	b=bmeQHynKIRhbZPJkezIqtjLO9IP4QQcvWJ323YnEdJ74ZfTGUsjsvipt0z9watFU5
	 OfjP+nzjZurfdxRXJS2qw8KCct5DCq4yt34tZqUxiWuvO7VmvYTK6JGVvcGjpn8CNz
	 q7MieUP+7Tn7ZrhdKhcAxNMcGJi8sLdCMlrM3Ev42g293FgDUXtp0M9Ua/FPLM/IOx
	 9V16MY6pvfI9cCHVeJi06GyY+MbUdq/N4B6TY0o/5pIryYdhQjV1kQZnduFdxZk+DZ
	 1TgfEGZIq8dEqtiC4ayeXDafzBEBEClTgFimzLiwfjTJ1xTrVoUCK7ONJYqbJvH3ou
	 riVZUv5Zv5S5A==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	"Chen, Zide" <zide.chen@intel.com>
Subject: [PATCH] perf tools: Fix missing feature check for inherit + SAMPLE_READ
Date: Mon, 10 Nov 2025 23:59:44 -0800
Message-ID: <20251111075944.2328021-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It should also have PERF_SAMPLE_TID to enable inherit and PERF_SAMPLE_READ
on recent kernels.  Not having _TID makes the feature check wrongly detect
the inherit and _READ support.

It was reported that the following command failed due to the error in
the missing feature check on Intel SPR machines.

  $ perf record -e '{cpu/mem-loads-aux/S,cpu/mem-loads,ldlat=3/PS}' -- ls
  Error:
  Failure to open event 'cpu/mem-loads,ldlat=3/PS' on PMU 'cpu' which will be removed.
  Invalid event (cpu/mem-loads,ldlat=3/PS) in per-thread mode, enable system wide with '-a'.

Fixes: 3b193a57baf15c468 ("perf tools: Detect missing kernel features properly")
Reported-by: "Chen, Zide" <zide.chen@intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/evsel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 67a898cda86ab559..989c56d4a23f74f4 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2474,7 +2474,7 @@ static bool evsel__detect_missing_features(struct evsel *evsel, struct perf_cpu
 	/* Please add new feature detection here. */
 
 	attr.inherit = true;
-	attr.sample_type = PERF_SAMPLE_READ;
+	attr.sample_type = PERF_SAMPLE_READ | PERF_SAMPLE_TID;
 	if (has_attr_feature(&attr, /*flags=*/0))
 		goto found;
 	perf_missing_features.inherit_sample_read = true;
-- 
2.51.2.1041.gc1ab5b90ca-goog

