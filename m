Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27C91E520A
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 01:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781227460; cv=none; b=mNB+lUXIjN1HKo7/KxV5+hcFy6Tesu05cM5aSD9a3hIpCZyFRC9WlBtJZrgSM6AQ1asLmQ5bjHQqCcUjceHduO2ygcO3gQeiTo7y9TBP/QTsWKj4xEHNlBjvECOcx9Fp1tirBUwJfbQ4K45A7573vIL3WAMmxjFj0aMSLspkuG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781227460; c=relaxed/simple;
	bh=rLtPC9Xc9ogyweD3ppe5jzvn2LHgBI0AqlRvvD0eOKs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=JNt7K5GJmDpEqlRRG1A23gaURkCsa9axXZ9xQvtSITmlk3Fim+6VWwpg3waRGoB6PH7apDL7kTlZf8qcTl7Np1ZsjY4kQrI4XQzVywq42TfLm39gxhganLEnPRAQC3RaK6sxodHn5nPDH64AGEYFNv7MVaFogdIFDQitVgeHb2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gq9QkImN; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gq9QkImN"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304d0d0b28eso1516354eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 18:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781227457; x=1781832257; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gxcK+x89zH4PvAg5dARZeJB00wmkNtOk0iZ4hBLf22U=;
        b=gq9QkImNcw96uh9YDyX27j3RzzEDgf6RjA8ZM+5kHIWN9Xn6Rqsbkn6vmWhTd2fnpW
         gLwi7Zmjea+fjY4xHYSMvwe8k08vC89LG0YplRz60MXnF0jOCSXwXyEdmlkyRA6XQu5C
         f61jDW08Z/yISP6p3BG/OlqgECeC5gpc/o0D3H2yNtxkaORjMroskAvgRjO2YIXDsA9P
         XCmc9whlgO3RJpTNRtSRrFO4gGMe9YSzgdpA28o0ImccfHNsF42pvqkgqpMMvoh8yJyS
         2SKomk9LCnyIZOaJ92/mYe2hexyleRGBNyU7b8KX9uBALdNOkILBEbCw3fOT2Jl4NJpn
         h4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781227457; x=1781832257;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gxcK+x89zH4PvAg5dARZeJB00wmkNtOk0iZ4hBLf22U=;
        b=WGQm1T8i21bboyykS9ePTD45IhimKCLtrW0wdAolN7hLCnqkKFeMTzR/twuBCqVkOY
         a985agrWFegMFBqFXdJuVgscGG4S8yiRvZS35y2a+bznJyBr4yVbd4mn8mmqKhZDIfuR
         RYjM6cPBDL/spnr6ZRA1osuHSFk/sEL3YOJWP4JBmMSa3MxgS/0WscmwPCRkKRcxSYm/
         TVqSlZuIHNupOmITJamHPL3lLLXCtOMYrWMBOyfNuCsv+n5Bg8dWvDlqYq/sXNiwZelt
         gnz4kbB7SAZNSrOmOrkp123jRuBswNV9n5oNcdwA7422nFkE+nena0ON9TGKImwfifr9
         d3zQ==
X-Forwarded-Encrypted: i=1; AFNElJ/W64nfO/tIvRzw5cuwS7pXfMielVCRjcKS8jTQAVeVs41aRxprNZcrcpm4jd51Ts01hoSPWkIWhuiAWTEqDGAv@vger.kernel.org
X-Gm-Message-State: AOJu0YwZdHMnJXdC/LD/sC6CDBTEfVvP07wIrbsnwnHavCUrmTo5cryT
	BeYxrKoL2TOhockN0HrtC0CdBM85NpaJBJEtplxAqyTFYTHTW9bjrd94EvdCaHXM+RbWkbAf9sC
	9hh8ag34b7A==
X-Received: from dybox23.prod.google.com ([2002:a05:7300:ec97:b0:2ee:9140:ff36])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:3213:b0:2f1:6252:f8fe
 with SMTP id 5a478bee46e88-3081ff639b2mr535070eec.3.1781227456675; Thu, 11
 Jun 2026 18:24:16 -0700 (PDT)
Date: Thu, 11 Jun 2026 18:24:13 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612012413.3253516-1-irogers@google.com>
Subject: [PATCH v1] perf pmu: Recognize default_core as a core PMU in more places
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Qinxin Xia <xiaqinxin@huawei.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The python metrics code used in places like ilist.py passes a
pmu-filter of "default_core" on non-hybrid x86/ARM/.. systems. As a
PMU like "cpu" isn't a literal name match then no PMU matches
"default_core" and the events fail to parse for the metric. Fix the
name matching and PMU lookup for "default_core" and check that it
fixes ilist.py.

Fixes: 74e2dbe7be50 ("perf tools: Add --pmu-filter option for filtering PMUs")
Signed-off-by: Ian Rogers <irogers@google.com>
---
Note: this bug is in 7.1 but it is a little too late to send for the
      release. It should get picked up via the fixes tag.
---
 tools/perf/util/pmu.c  | 6 +++++-
 tools/perf/util/pmus.c | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index a550f030b85d..836e3b5615cd 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2660,8 +2660,12 @@ bool perf_pmu__wildcard_match(const struct perf_pmu *pmu, const char *wildcard_t
 		pmu->name,
 		pmu->alias_name,
 	};
-	bool need_fnmatch = strisglob(wildcard_to_match);
+	bool need_fnmatch;
 
+	if (pmu->is_core && !strcmp(wildcard_to_match, "default_core"))
+		return true;
+
+	need_fnmatch = strisglob(wildcard_to_match);
 	if (!strncmp(wildcard_to_match, "uncore_", 7))
 		wildcard_to_match += 7;
 
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 5e3f571450fe..e0a4cb2428ca 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -150,6 +150,8 @@ struct perf_pmu *perf_pmus__find(const char *name)
 	bool core_pmu;
 	unsigned int to_read_pmus = 0;
 
+	if (!strcmp(name, "default_core"))
+		return perf_pmus__find_core_pmu();
 	/*
 	 * Once PMU is loaded it stays in the list,
 	 * so we keep us from multiple reading/parsing
-- 
2.54.0.1136.gdb2ca164c4-goog

