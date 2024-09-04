Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA151422D8;
	Wed,  4 Sep 2024 06:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725432095; cv=none; b=fbt01FPPMYR/wSLaR6CWdziEKRVzTGecST25QSEAEi3qupZhNs0Sx/ZYY9KrN0twIWfuP7cPwyCP4cReOlhL6nqtjB70NFZV7FQm3qjbgHzEU8w8OR8N7E+iUVOfjydX/rvO+9+VcNoFA2mV3cw5DSGBR6P394m6IKigxfVLAjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725432095; c=relaxed/simple;
	bh=ptRo3QiXqIZa4qbDGw/CbKZghezbb4dj4jwD2ORLUGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b2TynXvEQSmW8hhuCMhsDkTePrYMP18gmPIVgcIYqmmxDvZupYMeLtFdApYmnihe+QKFkyKaP/wyvw6kVarpulsJyQ890Vnqqg6ph0c4FsqXLUwNb+S88L8nTU2YGNIJKiuzwP6OOxKfGSbUET9ne347w2eeUKlsxMa7Ls0vrbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6XRXpzC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6XRXpzC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDCEC4CED0;
	Wed,  4 Sep 2024 06:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725432094;
	bh=ptRo3QiXqIZa4qbDGw/CbKZghezbb4dj4jwD2ORLUGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c6XRXpzCXKBT5TPAPpFVkt0ulk0/ib6Rjutu/FxOxX9YYauSSuWe6GUP47wY+Z/hx
	 a0jzo8MPQgGyeyO0sF7/1JhbA5ASL1xuBgJKud/dRCw8/Zo5VZPcY1MO4CKi+pozHZ
	 dOzrpR3BZID15KWdIdGwMF6gm7ZxoS6mb//a6ltBWz5VKEbwi0rVEttaywTzQRMmB0
	 JH8T52G6aycK8yUWmBsXpz1U7eEDz0QwySOz3FLq31BDYgpz3+c0MlkDdUsV/pOkj6
	 wCONaYpeU9WytPwM18DomzI2JWMpaDYLyVPYluSD/UPwixzTd8qOPA/zshb/AOhbgD
	 fRdXhnXvJYqTQ==
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
Subject: [PATCH 2/8] perf tools: Simplify evsel__add_modifier()
Date: Tue,  3 Sep 2024 23:41:25 -0700
Message-ID: <20240904064131.2377873-3-namhyung@kernel.org>
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
index 49cc71511c0c8ce8..57fe0f9b06f9a8bb 100644
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

