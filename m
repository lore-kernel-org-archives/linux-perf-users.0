Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499E8190686;
	Wed, 16 Oct 2024 06:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729059843; cv=none; b=SPStZ6IL7MV7otD8FV+uUJ61eFBqKhtIska58TEbxSmlGUefOBowa464MsPndCyLJe+hupORXd09kkTAdRw8xFwV0RF78VkOcz9OOuXGgL+U54oibPqsshHPEg0bah5KaC7CmfCvvqecfE/9XZRw60NO4eacxaPGaa43nR996c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729059843; c=relaxed/simple;
	bh=h3H1s+HDvAm6uYjvq5M56pT6DF5MvKcb0eyQMPgkL4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kv9WbqYFnbPoRLbqllqn3ts4SZwsvMuzKB1s/c/RYe19InuMpLAM6YV24OgpKXmEbvrmR0/xdUdjqq7Lt4HNkph+uyvQpy55txqhDY4DWqhc/GMSzi9HP6+49hy59VvEQAQKX2xPrd98xjBInDLlDsrsIPEXJJelAtrslEBoIV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbnYmFtX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbnYmFtX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA8CC4CEC5;
	Wed, 16 Oct 2024 06:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729059843;
	bh=h3H1s+HDvAm6uYjvq5M56pT6DF5MvKcb0eyQMPgkL4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BbnYmFtXdetq2ewQI+eYRBH38cfgTbn+7RE87z7U2v/NpRl3kEwKkT5V60i5aNrdf
	 20oe5o1AmvdX61OdRnAxUG7TylGhJl0wZVhoOUbX1SLXm8zhG4K9FDbetWIBCgSZ2k
	 +PcWsIumTvflplnnNeC4LmQzzEVshkytAROqWduXepFQSk1NbNHmkuhz3Ob/12h5Ym
	 0x+icjD87AAzAgMYC5knpBcD2V6eZLwldFVawS4toQ2a5l9H17axKsJZNf8JYTGuTx
	 0L3I7r3F1P1MDckmhCvMek9Vny3N6x2H6aP/SgVNTMNTPF/c418K61M4kzXfOGFhht
	 Yr6wBfdK+oG4A==
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
Subject: [PATCH v5 3/9] perf tools: Simplify evsel__add_modifier()
Date: Tue, 15 Oct 2024 23:23:53 -0700
Message-ID: <20241016062359.264929-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
In-Reply-To: <20241016062359.264929-1-namhyung@kernel.org>
References: <20241016062359.264929-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since it doesn't set the exclude_guest, no need to special handle the
bit and simply show only if one of host or guest bit is set.  Now the
default event name might not have :H prefix anymore so change the
dlfilter test not to compare the ":" at the end.

Reviewed-by: Ian Rogers <irogers@google.com>
Acked-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: James Clark <james.clark@linaro.org>
Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/dlfilters/dlfilter-test-api-v0.c | 2 +-
 tools/perf/dlfilters/dlfilter-test-api-v2.c | 2 +-
 tools/perf/util/evsel.c                     | 5 +----
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/perf/dlfilters/dlfilter-test-api-v0.c b/tools/perf/dlfilters/dlfilter-test-api-v0.c
index 4083b1abeaabe605..4ca2d7b2ea6c8200 100644
--- a/tools/perf/dlfilters/dlfilter-test-api-v0.c
+++ b/tools/perf/dlfilters/dlfilter-test-api-v0.c
@@ -220,7 +220,7 @@ static int check_sample(struct filter_data *d, const struct perf_dlfilter_sample
 	CHECK_SAMPLE(raw_callchain_nr);
 	CHECK(!sample->raw_callchain);
 
-#define EVENT_NAME "branches:"
+#define EVENT_NAME "branches"
 	CHECK(!strncmp(sample->event, EVENT_NAME, strlen(EVENT_NAME)));
 
 	return 0;
diff --git a/tools/perf/dlfilters/dlfilter-test-api-v2.c b/tools/perf/dlfilters/dlfilter-test-api-v2.c
index 32ff619e881caa50..00d73a16c4fdaece 100644
--- a/tools/perf/dlfilters/dlfilter-test-api-v2.c
+++ b/tools/perf/dlfilters/dlfilter-test-api-v2.c
@@ -235,7 +235,7 @@ static int check_sample(struct filter_data *d, const struct perf_dlfilter_sample
 	CHECK_SAMPLE(raw_callchain_nr);
 	CHECK(!sample->raw_callchain);
 
-#define EVENT_NAME "branches:"
+#define EVENT_NAME "branches"
 	CHECK(!strncmp(sample->event, EVENT_NAME, strlen(EVENT_NAME)));
 
 	return 0;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index c965ec5676f8d54a..353b8da972bcfc54 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -517,7 +517,6 @@ static int evsel__add_modifiers(struct evsel *evsel, char *bf, size_t size)
 {
 	int colon = 0, r = 0;
 	struct perf_event_attr *attr = &evsel->core.attr;
-	bool exclude_guest_default = false;
 
 #define MOD_PRINT(context, mod)	do {					\
 		if (!attr->exclude_##context) {				\
@@ -529,17 +528,15 @@ static int evsel__add_modifiers(struct evsel *evsel, char *bf, size_t size)
 		MOD_PRINT(kernel, 'k');
 		MOD_PRINT(user, 'u');
 		MOD_PRINT(hv, 'h');
-		exclude_guest_default = true;
 	}
 
 	if (attr->precise_ip) {
 		if (!colon)
 			colon = ++r;
 		r += scnprintf(bf + r, size - r, "%.*s", attr->precise_ip, "ppp");
-		exclude_guest_default = true;
 	}
 
-	if (attr->exclude_host || attr->exclude_guest == exclude_guest_default) {
+	if (attr->exclude_host || attr->exclude_guest) {
 		MOD_PRINT(host, 'H');
 		MOD_PRINT(guest, 'G');
 	}
-- 
2.47.0.rc1.288.g06298d1525-goog

