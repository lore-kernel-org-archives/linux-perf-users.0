Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793867644;
	b=c/4cK0Yx3oaopBJKgmOarmVMHrUOMiXO7CLG6f0f9AyR5D2BUmSXoeu7PNxd3jacqtX9
	 KevSp0wUuUfOaJ5CIDR0zMqDCfAv8ds03108wRr8GZEr7sIYI9WFS3tXmK1QVI8TA6Bag
	 QvZwoSu3vHFcipyXQDRyl52EBipiw1JFMohssbyT4wVXJYa+t7yISzrbF8fokBz8Be5kt
	 Q0Sj9/MRV878IL81AL0BWDPoiWwi1YQZ48PolOUKIGwaB1DdumD7Qn9fNZgfXZ5lmNpHk
	 6/IwEPWQEAJC3+vFEZuisJQjasnR5VR2gVmhHaRCZt4zeEjnpeHmtRTlQeNHckKmnUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793867644;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=q7Yg2k54AxCuDrMxGRaPerxf+zLG+4XvnfL6ItD6i3A=;
	b=TE2DHlhddPfOLIlAenVdunjOp7QSYViEj/Z/xXO/kyyUYkPem5znFjq142M2PPTer+mF
	 18x/Azn62I+9tp1Cem3PuwsjVDaXMlpFQZ1iRUp4kLqswRvYhNg2suEF961QcSE3GxuLA
	 Jz6JgH6vcoHur9XiQvnOQaOQiLV9sPBhHy9O7jclJRMZP62iintPXfzl+P4jCiS9IDH47
	 GOHMes68gTUrdbuSNxvybjQfM+wrls8axxSz/1S43lFdC3fyfBg4zNO109njahdMBdVZ0
	 0dqevF+bEnjWQZdJ7SlbZSvoSj595vj7fn1MCDhip4Hel4D05zLeJr3pJF52dNF1Zhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lyLe5nC+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75247606A31B
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 08:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lyLe5nC+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA2A1F0093A;
	Thu,  5 Nov 2026 08:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793867644;
	bh=q7Yg2k54AxCuDrMxGRaPerxf+zLG+4XvnfL6ItD6i3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lyLe5nC+artHA4/uyvGztIw31chprYyx2pBgoz7hiK+oGNNApLcTEQmUBGTwWX3QT
	 aUeWZrH+2kxEjS3ehxz2yzBjlVyZARgf9aPx+o49MZ+ECn4lntWBKrdHEz9/TMLZyr
	 IQSZNxCO0U6jmGRJPIOIQGkYy/z2jJaCs9Kf/2BTZgcbkmnZbfU0aI3eGKEYTGZU5e
	 FxpHELcgBfftxrTgFldoBwNoKFN12BKPHpLVIGlRql31LwKhqVkgDiYzeFI+Q9yJ/B
	 pdMu1+oKY2MNWObvoAdRO8fLTWGOTlDC4evFQ75FoBOBlW0OONCqeAeM8sEktRbmdM
	 g8/h6jDHKo78g==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: acme@redhat.com
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 3/3] perf: initialize and destroy error list in test__pmu_config_helpers()
Date: Thu,  5 Nov 2026 09:33:52 +0100
Message-ID: <b9796c017042a3074956474a83c9b2170caec6db.1793867553.git.jirislaby@kernel.org>
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
Content-Transfer-Encoding: 8bit

test__pmu_config_helpers() passes an uninitialized "err" to parse_events()
without ever calling parse_events_error__init() on it first. Sashiko
pointed this out in review:
> When parse_events() fails and records an error via
> parse_events_error__handle(), list_add(&entry->list, &err->list) and the
> subsequent list_for_each_entry() walks in parse_events_error__print() and
> parse_events_error__contains() will dereference the uninitialized err.list
> pointers on the stack, and any allocated parse_events_error_entry objects
> will be leaked.

Fix it by calling parse_events_error__init(&err) before parse_events(), and
by releasing the list with parse_events_error__exit(&err) on the new
err_out_errlist path taken once the list has been initialized.

Assisted-by: LLM
Fixes: 8e2ef85c66dc ("perf tests: Test evsel__set_config_if_unset() and config change tracking")
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
[v2] this is new in v2

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
---
 tools/perf/tests/pmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index b6ad2806659c..f208932590df 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -224,13 +224,14 @@ static int test__pmu_config_helpers(struct test_suite *test __maybe_unused,
 		goto err_out;
 	}
 
+	parse_events_error__init(&err);
 	ret = parse_events(evlist, event, &err);
 	if (ret) {
 		pr_debug("failed to parse event '%s', err %d\n", event, ret);
 		parse_events_error__print(&err, event);
 		if (parse_events_error__contains(&err, "can't access trace events"))
 			ret = TEST_SKIP;
-		goto err_out;
+		goto err_out_errlist;
 	}
 	evsel = evlist__first(evlist);
 
@@ -289,6 +290,8 @@ static int test__pmu_config_helpers(struct test_suite *test __maybe_unused,
 	evsel__get_config_val(evsel, "krava23", &val);
 	TEST_ASSERT_EQUAL("krava23 not overwritten", (int) val, 0);
 	ret = TEST_OK;
+err_out_errlist:
+	parse_events_error__exit(&err);
 err_out:
 	evlist__put(evlist);
 	test_pmu_put(dir, pmu);
-- 
2.56.0

