Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D51F1A42A7;
	Thu,  5 Sep 2024 20:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725567870; cv=none; b=HKoYlEsgf6mxSJRbq7pOZZXnHqT91aaGoPojaqh1yHwffvbnvdKLUQfTSoIOa6Iu12KlTRtkzQ9INQOdklWKoyOnNFdPGFpFaUZcBkT3tIHao8jjxcFMSgUWRNOVP3d1VrQCmFupqK87qSDvjZxowLWqMAzO0Errrll8tW21NZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725567870; c=relaxed/simple;
	bh=wso+JxsY3KSfA1BAeaX6+KdhvT3pN2ZRYs/u5T+ZYlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mfkyceEFq86Nj4LG1ujbUnKyuHFWC115dW0/eO6Ww5mTSrmYX8ebRYLPHMr85OyedNw6a1p+M+6RyRekkY2jZYO9hT1GJ5wNoo2VVh2HRBclvKL1ie9AUmNKS1wx2AAmPJ7ElLhqvCdGF589ds1M6I1Ioo6vYWKSybAafCGV6kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDEpwQ1m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDEpwQ1m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3556C4CED0;
	Thu,  5 Sep 2024 20:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725567870;
	bh=wso+JxsY3KSfA1BAeaX6+KdhvT3pN2ZRYs/u5T+ZYlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bDEpwQ1mtpoJQJxc9ep66eaRVL4q8eFrTKBe+CBU3Sl/N9DPBJDecvFRPul03+Piq
	 0BIYguosxu+xjs5LHpdr6XNHfCGn20U3ETSiydTG2L2IqZr8wcjR2yKcbeS56YHefZ
	 ocKmj0EIq48s4xGyqQQNNX3xzLOlEMlnY0viBoelwDfVpCrz+cFaFjbk0VAFzqpamc
	 J8pP31X1665MlH7Nkxsbkz5OkXO6R7pakJBGYx4Ngfs4aRX6L9781Rlj7VwZjvoVZd
	 yqBfTurqFl9cntVkbetV/JChKVuXMYqYkpMzJVUT+YZ+IsTcwfp+7EjLXaoBZ8YbIw
	 0Zg9eqOvSlJkQ==
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
	Mingwei Zhang <mizhang@google.com>
Subject: [PATCH 03/10] perf tools: Simplify evsel__add_modifier()
Date: Thu,  5 Sep 2024 13:24:19 -0700
Message-ID: <20240905202426.2690105-4-namhyung@kernel.org>
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

Since it doesn't set the exclude_guest, no need to special handle the
bit and simply show only if one of host or guest bit is set.  Now the
default event name might not have :H prefix anymore so change the
dlfilter test not to compare the ":" at the end.

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
index d59ad76b28758906..dadcaf6e37063dfa 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -548,7 +548,6 @@ static int evsel__add_modifiers(struct evsel *evsel, char *bf, size_t size)
 {
 	int colon = 0, r = 0;
 	struct perf_event_attr *attr = &evsel->core.attr;
-	bool exclude_guest_default = false;
 
 #define MOD_PRINT(context, mod)	do {					\
 		if (!attr->exclude_##context) {				\
@@ -560,17 +559,15 @@ static int evsel__add_modifiers(struct evsel *evsel, char *bf, size_t size)
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
2.46.0.469.g59c65b2a67-goog

