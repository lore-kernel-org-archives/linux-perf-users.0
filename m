Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C482AC2E3;
	Tue,  1 Oct 2024 00:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727742031; cv=none; b=ShqdzwynDqXy8EK5TZwnmHswjklPYXKvi3uw5qxFlQa/Ce0PEFLLVZbJG6BrYd7Tk7jfuUNcO9Hbn3ByzzeylfkvhE7SUxtHxD2FivQbcg7M2B/+BqPdvPG4TKEUgrbNjKArYf6X8fMxHbf4ufmEGjRMuOmFDULULdVTDD15qsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727742031; c=relaxed/simple;
	bh=WisHYEcdCSkfkVkvX+IWJW/zRWzgI9OT+00Jz6iq/pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s6+e9XdkUpTeDx4NUWuANKJ1euaCvknXHw+bHglKZJ45QcyZGbcRj6GKPlXxGAPOS21xIX9TwP8YR/c1/yus5frO7NOftvZazkE1cilU4q8SBhBgvgeHVNb9XTFlEwRJhJlc3/rARP3bst3M9kVPJrUmp8VcUSyc20v3uyv4A7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJzgdUAq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJzgdUAq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26DCC4CEC7;
	Tue,  1 Oct 2024 00:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727742031;
	bh=WisHYEcdCSkfkVkvX+IWJW/zRWzgI9OT+00Jz6iq/pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uJzgdUAqncYD6+xk+gCEKgwgohZe03N1Vpr0tzDWoHH6gWdBA0id55G2Q1HgBuLV6
	 MQs01yb9Agymf/Junzsp9Jf1yY6MLdWoegxA5RaqgDXXghMAQlEX4CU06JARBWH4lX
	 +pHh9gYBWrzS8ibjwBkqhmyBC7hN6ixwJrJHrDxDWg8hFVPdQ/zbIhoqAYWhkiZqGV
	 3Le1mtqAhlwK+Lof2nbCH4k8BaSr1x7GORL83cyIYBSUu5PHjxhaqp9uVqCQdHpmiO
	 ua+RrZGRHWJsiiDzxkrRdNH64IH+soHhG4HlCIfBR28lRA66CzfQRrmAEpUnbQpmpd
	 PUCSWvG1y/95g==
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
Subject: [PATCH 3/8] perf tools: Simplify evsel__add_modifier()
Date: Mon, 30 Sep 2024 17:20:22 -0700
Message-ID: <20241001002027.1272889-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20241001002027.1272889-1-namhyung@kernel.org>
References: <20241001002027.1272889-1-namhyung@kernel.org>
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
index 0ddd77c139e89a2e..f202d28147d62a44 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -545,7 +545,6 @@ static int evsel__add_modifiers(struct evsel *evsel, char *bf, size_t size)
 {
 	int colon = 0, r = 0;
 	struct perf_event_attr *attr = &evsel->core.attr;
-	bool exclude_guest_default = false;
 
 #define MOD_PRINT(context, mod)	do {					\
 		if (!attr->exclude_##context) {				\
@@ -557,17 +556,15 @@ static int evsel__add_modifiers(struct evsel *evsel, char *bf, size_t size)
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
2.46.1.824.gd892dcdcdd-goog

