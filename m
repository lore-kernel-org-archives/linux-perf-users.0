Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793786891;
	b=SD1tkwICKxwEUD7MsKW+MtosPjjkTbhPaCK7ywGCallM9mWEOV/hxOhDUBBtAri4Q621
	 5rkSVM/9f53ehnCR5XdiAExlQFe5yZ0ePYN2zgRDOQdn2IB7tFTMRTMtmtMuhO6JaMBny
	 u6viLQLerVoj/aNAnVx29HBr6w/rzkplmJdjTbex7U10zaXDGH62PNMyPl5E+6rHXpFZU
	 NMSIYfEXyVKPKGuVQ14ypkRxd1H7ZNtQVBajhzS2dIHq/RzpIM/u183cFdXs2PijKJDt2
	 aKcOxtaTigENAiq7Fwd5K3S+uSqGeYRYyJ7riQNfjZ1n6jARPdrZzs3wFshze5iMnPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793786891;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=k8HyCsI5bHuW52aVY89g6/SGt2Mnk3paqIfHMwPntoM=;
	b=dr9/eDdXjPyTgRbIqJBi49R13nD0Oe4tLMJPxfwcLek4TIPvl8o55tYJ3a1ZMAc2gMy5
	 t0JhWQAzzkqAVd24xTIekGhaRNgFxKBMq5Rw4Ns2GMDTwYjyaS2mWPGxdFKiQmjVASfb3
	 lS0eFcRJ/kKGE2zXQQ+StIcRiu2+cR6A2qXGjMfFB+1TZ472uECwaQdWF7KCBlLZyHXGZ
	 ITNc4kgnTSoirzVbQn+IykD3S2BIzCmsy4h/ud4NvCCuNVVv0+cOm6xQEOCGbQJ5SpT9E
	 fudqMsCUdOEXoMVjVGHtBk5FUQIsxi70t/bnMiSbr0Sx+QAGfiU8tZPZz7Xe7eQ+Lbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UX/+Ss7r";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B639A606A33B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 10:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UX/+Ss7r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C951F00919;
	Wed,  4 Nov 2026 10:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793786890;
	bh=k8HyCsI5bHuW52aVY89g6/SGt2Mnk3paqIfHMwPntoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UX/+Ss7rLz9yhuf+daBf5k347LoAFbjQvLgrlXhGvTzQrng7SBHn4XswpHP47VNoO
	 GtqjBr/ZqwCNKTWExFrpgHAUP1gfBbbd9yeZfqf60+6Vy8KR5Yy7GJ6BJM1bntQT3c
	 dR+EAfRvgFCuNY8Qt0KMZFdrsoZjZ/N+tu58VuIhy0QkKP+GUoEZtiZk62lr07+/70
	 yZsYtqXYOFO+FVMnzF8eVpr5kqMVSAdBDnD65P/txwh2g9u4uPgXCr2bO6QoSiOQlM
	 VEb3Ft9lOvcje2p8eQB/rh7CYw0kvJ6NaluF8B9EzjywzOlmV+PaauFBpApg/QoIDC
	 8sXdsjYNTg3ew==
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
Subject: [PATCH 2/2] perf: do not call list_for_each_entry_safe() on uninitalized list
Date: Wed,  4 Nov 2026 11:08:02 +0100
Message-ID: <20261104100802.539266-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104100802.539266-1-jirislaby@kernel.org>
References: <20261104100802.539266-1-jirislaby@kernel.org>
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

In test__pmu_config_helpers(), when evlist__new() fails, the code
jumped to the err_out label, which calls
parse_events_terms__exit(&terms). At that point
parse_events_terms__init(&terms) has not run yet, so the terms list
head is uninitialized and list_for_each_entry_safe() walks a garbage
pointer.

Add a separate err_out_pmu label after the evlist/terms cleanup and
use it for the early evlist allocation failure, so the uninitialized
terms are never touched.

Fixes this compiler warning:
In function ‘parse_events_terms__exit’,
    inlined from ‘test__pmu_config_helpers’ at tests/pmu.c:296:2:
util/parse-events.c:2849:2: warning: ‘terms.terms.next’ may be used uninitialized [-Wmaybe-uninitialized]
tests/pmu.c: In function ‘test__pmu_config_helpers’:
tests/pmu.c:209:28: note: ‘terms’ declared here

Assisted-by: LLM
Fixes: 8e2ef85c66dc ("perf tests: Test evsel__set_config_if_unset() and config change tracking")
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: James Clark <james.clark@linaro.org>
---
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
 tools/perf/tests/pmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index 13e8d7fa80af..be984e1385df 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -223,7 +223,7 @@ static int test__pmu_config_helpers(struct test_suite *test __maybe_unused,
 	evlist = evlist__new();
 	if (evlist == NULL) {
 		pr_err("Failed allocation");
-		goto err_out;
+		goto err_out_pmu;
 	}
 
 	parse_events_terms__init(&terms);
@@ -295,6 +295,7 @@ static int test__pmu_config_helpers(struct test_suite *test __maybe_unused,
 err_out:
 	parse_events_terms__exit(&terms);
 	evlist__put(evlist);
+err_out_pmu:
 	test_pmu_put(dir, pmu);
 	return ret;
 }
-- 
2.56.0

