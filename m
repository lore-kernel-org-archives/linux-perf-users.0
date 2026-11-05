Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793867641;
	b=WWBifLkwpEUA+fGyzHVcnjkgpb0ogXfKy4ofQJR4LenNzTKlXhwvLLLF+Q+7YbjHrHAm
	 rf3AaaVrE+FbktJ+MVNUELudjs4Wtxm8Udzjdt+6QTVLD6IwWQ0eLl9AXlmaOJwlbQQqN
	 iECogOpngFd/V5XytDuTpCKNXD+zs2bHxPqj7/Tj/h3t+YFvVJQoaWVyLgPu/pUhW62LN
	 1VZyeSA/t6MOUMdRRDjJsgTTeaLaPkLWPVJvmtoVt9Ho0qSnyZHwz4fgjYR5w5LI4SQJk
	 IbD5kGAWkTSFbi8rA/RVBnivkGJqwkIqzIKfyFUEg7Pf2mbeZhF7qHTvNSXsbyh/12A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793867641;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=g1z6lhbfTmpCBeImsfdQYA7OJHIdU+dlhb2qrfEYb40=;
	b=4hH4vfTh5UdaeW+ItaXV+94Yr6Z5uP0V2KLUAx9PtGJ242+c00BfAbSwvWs94Sr05Il1
	 uzyN8/tWpr1dxfAuHF4FL6Afe2VByP5iQN9aZ1LcGAfvZg7p8feX0cwJArcQRINWlC+zG
	 VC8oLyxWl8yQRiGs8rUx68vDsjZoqoPwGC+j56mI47bAl6F3xPMxUwWKCXO+iu1JeiWFm
	 mVIqgN/q/SXcQ/g+Q5lva04aeXBz+avX4GSNDJ10KxA+knHwxCSb/LG8AhPBKSRfw9USV
	 bEYiwuiYyTzTbpgwH0aGU3+8SMbCQT7+rTMMdcv+3I2S+GpPIWMmfshSmUMe4Umiv6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WvxWhwMq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC3B606A326
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 08:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WvxWhwMq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808E71F000C1;
	Thu,  5 Nov 2026 08:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793867641;
	bh=g1z6lhbfTmpCBeImsfdQYA7OJHIdU+dlhb2qrfEYb40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WvxWhwMqnHbBeJlSM7dEd2no9YG8eTLaKDDnKGmj4JN30zJNneF/8FpM6wl1TYMgo
	 Vcem97aJNaOgpiDh5GjAGK9XnQBV3O0nxQnfPzC3QILajpA+CoOjmPTqAKJFZInma4
	 C6t6QNLLG3gF8k1mvEUcUKjX5o/ETJqemgvp6ZleAU4a3Q7I5AbkUlOFOYy/zrs2TB
	 x7gdR1RLoJNDTiWLJf5hNa9dJqb+IBKjrioFT2yuLyRk3vNwnBehO518cW2AV0vm2W
	 UJ27wNH/hfHE8sAI6vngggBcs0NVFrIRUqwv5b1uFbpcvMq4t7p+MZ1ISBDLA95zMS
	 Yb3ztLKmTMqOQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: acme@redhat.com
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 2/3] perf: do not call list_for_each_entry_safe() on uninitalized list
Date: Thu,  5 Nov 2026 09:33:51 +0100
Message-ID: <465e342ac620ec4f784424da897aecb4d0aa58cb.1793867553.git.jirislaby@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1793867553.git.jirislaby@kernel.org>
References: <cover.1793867553.git.jirislaby@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In test__pmu_config_helpers(), when evlist__new() fails, the code jumped
to the err_out label, which calls parse_events_terms__exit(&terms). At
that point parse_events_terms__init(&terms) has not run yet, so the
terms list head is uninitialized and list_for_each_entry_safe() walks a
garbage pointer.

Fixes this compiler warning:
In function ‘parse_events_terms__exit’,
    inlined from ‘test__pmu_config_helpers’ at tests/pmu.c:296:2:
util/parse-events.c:2849:2: warning: ‘terms.terms.next’ may be used uninitia
tests/pmu.c: In function ‘test__pmu_config_helpers’:
tests/pmu.c:209:28: note: ‘terms’ declared here

Assisted-by: LLM
Fixes: 8e2ef85c66dc ("perf tests: Test evsel__set_config_if_unset() and config change tracking")
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: James Clark <james.clark@linaro.org>
---
[v2] drop terms completely (Sashiko)

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org
---
 tools/perf/tests/pmu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index 13e8d7fa80af..b6ad2806659c 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -206,9 +206,7 @@ static int test__pmu_config_helpers(struct test_suite *test __maybe_unused,
 {
 	const char *event = "perf-pmu-test/config=15,config1=4,krava02=170,"
 			    "krava03=1,krava11=27,krava12=1/";
-	struct parse_events_terms terms;
 	struct parse_events_error err;
-	LIST_HEAD(config_terms);
 	struct evlist *evlist;
 	struct perf_pmu *pmu;
 	struct evsel *evsel;
@@ -226,7 +224,6 @@ static int test__pmu_config_helpers(struct test_suite *test __maybe_unused,
 		goto err_out;
 	}
 
-	parse_events_terms__init(&terms);
 	ret = parse_events(evlist, event, &err);
 	if (ret) {
 		pr_debug("failed to parse event '%s', err %d\n", event, ret);
@@ -293,7 +290,6 @@ static int test__pmu_config_helpers(struct test_suite *test __maybe_unused,
 	TEST_ASSERT_EQUAL("krava23 not overwritten", (int) val, 0);
 	ret = TEST_OK;
 err_out:
-	parse_events_terms__exit(&terms);
 	evlist__put(evlist);
 	test_pmu_put(dir, pmu);
 	return ret;
-- 
2.56.0

