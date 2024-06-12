Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3844416FF3E
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Jun 2024 12:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718196033; cv=none; b=am2IH9Qs8vZ99WELiGy2b0XcH3nIEneEtk/7TgMawgpPMkAZ/yUNy8yI0PX7/wEFGqk9TZCOY1SD1tz0v6IbnCfqEUu0KtQ8Se21EZx68EPxMHkas0dFeaMM+9msbvvF8tlBYg9AuFUtfpSGCk2OJRdkXpbZSrfSUwDsYQ/g76M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718196033; c=relaxed/simple;
	bh=c+DRRveXulk99snT5VccdZXEOQB7aOSMnf5enVXmdbQ=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=NGfQmYeckSTm5FxtYMDkeFTkb2EHyDV0NOtad17a5QPS7fqxhRJqQvtIADCOpwnSaxEQuXhi+JAKclB469TL1iNj+SNmXCDUSYoa9jx67NjLv6v0aMAGjd4bSUtf1E8Hoxh/hEKE4pxPHS712QwUBuE95Uko+OI+0VHlcO3d0Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u4YR6W9z; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u4YR6W9z"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62fb4a1f7bfso12750057b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Jun 2024 05:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718196031; x=1718800831; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DfSgBhx2prDvvpbn/rXVh0w6qYSSonJrkoho8C5QmNY=;
        b=u4YR6W9zi+yi3lOYpXYJI/c0cQHv1faIKiyySmXHvKBzcxQAv4VTrFCMMAJ62XyTYU
         Lhe07dewELjfoKad4pDBCI7kAlKVkXDRRG6v79GkrvCiVOprft/zKYABldsnVx3ZvjSU
         XpJaW45o+tTIFPaR/ZeHE1RvNjZdKdsNpyixRiCEryYmiWhCNaE55X+YbWcD+RtFkHMm
         fXWYmpz5QFw8G0kYBOaKJTeqATcjDF1Zm1xhK5LqnB0NDqJUHCDwSKboKa//f8iKnxZK
         eSexkE2fcKseibo8VJ9yH1EIXoQcHjvCYidLhtuqSu7O6yI44iFUQflZ8lWmZh8u7FV+
         B+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718196031; x=1718800831;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DfSgBhx2prDvvpbn/rXVh0w6qYSSonJrkoho8C5QmNY=;
        b=gk2J2CQyBvljubG95Ruet7u3ICfargq26Yos7ZRZD8a2C2hZhyUipxrkMSpprF6YTP
         aeKjj1iwXxZn3cJlcXUYni2f8oWOIAz0jsKMsgPUjsAZpGyZYv8nGf5qMkF8eaAt/zLL
         oZNcFZJ8ZIp2EwN70fWM29XimopCEGa9kZPnETUIaw0EOMsF0WJTJnVaeM54/XszPfOc
         r67ssn49a+34aajee/eWTjsp0J8U6YJHdmjk/T+BzMrHLpX7bQqwAYL2XKmKVXU4SwDQ
         69ArFSIvsXSJtJdRZ6ZN/UWoBy7whDg6v6fJiLY5Reyi7cw6HCPsWM0VWLmCVi6vwOjo
         Vbhg==
X-Forwarded-Encrypted: i=1; AJvYcCVzbT2kDoNAexNuYKqq15RwTlad6H6/4L0Gf9Vbj4kWohUvcZRSy72pO4b1hDq4RARaosaBvQXnjS1+OAcEu0Bq3T0e8t11Jmn9WjgRufmkpQ==
X-Gm-Message-State: AOJu0YwFoqeirGhDOptKSAAXerrkcP7rO8zZX1A3xJqAgMCQKZui31Kr
	EfZvBuakQ/ueEr8NyJdCpLWRCoKB3uiKdhsbT8PTMTVyb9crQXGFEREEsiyeR+eJdAnghU9mPVE
	nvkPOjg==
X-Google-Smtp-Source: AGHT+IFsvL4EQynJNi0fl6hpXid6BCCRZLXCXaUyrZcJtE/YeA0i+GUTbcsmCCc9bk4eqiIQIkDukubWbUDJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ea09:ea36:268b:d86f])
 (user=irogers job=sendgmr) by 2002:a05:690c:4491:b0:62f:f535:f37 with SMTP id
 00721157ae682-62ff535129amr3636757b3.0.1718196031241; Wed, 12 Jun 2024
 05:40:31 -0700 (PDT)
Date: Wed, 12 Jun 2024 05:40:27 -0700
Message-Id: <20240612124027.2712643-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Subject: [PATCH v1] perf test pmu: Warn don't fail for legacy mixed case event names
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Kajol Jain <kjain@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

PowerPC has mixed case events matching legacy hardware cache
events. Warn but don't fail in this case. Event parsing will still
work in this case by matching the legacy case.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Kajol Jain <kjain@linux.ibm.com>
---
 tools/perf/tests/pmu.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index cc88b5920c3e..201df4446f7c 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -260,26 +260,42 @@ static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest
 static bool permitted_event_name(const char *name)
 {
 	bool has_lower = false, has_upper = false;
+	__u64 config;
 
 	for (size_t i = 0; i < strlen(name); i++) {
 		char c = name[i];
 
 		if (islower(c)) {
 			if (has_upper)
-				return false;
+				goto check_legacy;
 			has_lower = true;
 			continue;
 		}
 		if (isupper(c)) {
 			if (has_lower)
-				return false;
+				goto check_legacy;
 			has_upper = true;
 			continue;
 		}
 		if (!isdigit(c) && c != '.' && c != '_' && c != '-')
-			return false;
+			goto check_legacy;
 	}
 	return true;
+check_legacy:
+	/*
+	 * If the event name matches a legacy cache name the legacy encoding
+	 * will still be used. This isn't quite WAI as sysfs events should take
+	 * priority, but this case happens on PowerPC and matches the behavior
+	 * in older perf tools where legacy events were the priority. Be
+	 * permissive and assume later PMU drivers will use all lower or upper
+	 * case names.
+	 */
+	if (parse_events__decode_legacy_cache(name, /*extended_pmu_type=*/0, &config) == 0) {
+		pr_warning("sysfs event '%s' should be all lower/upper case, it will be matched using legacy encoding.",
+			   name);
+		return true;
+	}
+	return false;
 }
 
 static int test__pmu_event_names(struct test_suite *test __maybe_unused,
-- 
2.45.2.505.gda0bf45e8d-goog

