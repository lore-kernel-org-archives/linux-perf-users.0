Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5F9146D53;
	Wed,  4 Sep 2024 06:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725432099; cv=none; b=IVrlH/pbTERRyTo5YGEf+DXtD/2FmHyr8VBDUVt1JL22OK0iPbVDw/jbE/kbzd/BMkJ0+aa6B7Xr8RZkRqnO1ztSytjqFg+H2LlHlu00fY5bYIvI0bAWVjg4M9nBb4dPy2QpW9RArGB5ekYzHfmBvzMjDhPzxTosZk1NDxQWe+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725432099; c=relaxed/simple;
	bh=JSUTiRYrec2Pg4nNV3pvx3fwv2H5+nDz6b4nRjjCT4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNSvjoaHo9VFhbhae6QsZZH7h2OBfgW13w9gO+6BJsOBEc5yAjc5QvR6lq3U/Bmz6DJZmn328FhV5bhJ7ujYuMzf0/DVdyUrj/WVGgfzNBsAL08YqcmF14Y3kfLKJTEpkWL9Q+W5GAMES2/YfJrQUpAchoAz6GwCvnTd9lE46Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKgp2t7m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKgp2t7m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEAFAC4CEC9;
	Wed,  4 Sep 2024 06:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725432098;
	bh=JSUTiRYrec2Pg4nNV3pvx3fwv2H5+nDz6b4nRjjCT4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VKgp2t7mdb3rdIvpXJyGAgPoMIp5qsNJrfeOp/cXhHj5ALvDuyF307aiAmg80vTDK
	 buWbAZJ+UMWxOSag7anjK+wya96X0LBnS6EcP3bYTIawUnuRPXAQX1+WCMEcrZRs4U
	 rxrTj+A5bdudut3/rvNLjMnfrskFUvSTa0EGuUy2oP1R/EEB5LgEPYouWnhQ/YSOmA
	 mSioGrFxh/mDMhAeWVpBwEQhu1lPeCUGQQhUH9Qvi1wvzRS3AbMvPlQKYgFBaFM8W0
	 dOvdvBUU+SsykIgMgJInkriPLpFZGsNYCn++Yx1pVt0378eNwuidBOgOWGkzgJxfB/
	 NxM6pTgC43Ltw==
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
	Mingwei Zhang <mizhang@google.com>,
	James Clark <james.clark@linaro.org>
Subject: [PATCH 7/8] perf tools: Add fallback for exclude_guest
Date: Tue,  3 Sep 2024 23:41:30 -0700
Message-ID: <20240904064131.2377873-8-namhyung@kernel.org>
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

It seems Apple M1 PMU requires exclude_guest set and returns EOPNOTSUPP
if not.  Let's add a fallback so that it can work with default events.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Clark <james.clark@linaro.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/evsel.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 0de0a72947db3f10..8c4d70f7b2f5b880 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3400,6 +3400,27 @@ bool evsel__fallback(struct evsel *evsel, struct target *target, int err,
 			  "to fall back to excluding hypervisor samples", paranoid);
 		evsel->core.attr.exclude_hv = 1;
 
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
+		if (asprintf(&new_name, "%s%su", name, sep) < 0)
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

