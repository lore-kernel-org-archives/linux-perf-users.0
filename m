Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11D91A0BED
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jan 2025 05:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736313320; cv=none; b=mHiICjX4saBznNU0Ssy3/w4UEJU9KxfMHeWuh+rAdM/OR6AITjn/l7Om4PycjBUfVXg9j5+OTEAlZUIheq3QC28LDF4BnLRtTN1XskW9JdfFdXmwtwvnDB6GVnsZ2U1GbvE/Cw89zJsFS2K2FBPz8PcVWX7p/u8ohTmwlrz7v40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736313320; c=relaxed/simple;
	bh=+FUIceUBljXQwmCRFhOHGxWwPSQm0aXXrH6E+PxuQOg=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=rSmu3in1ff44R49Zb35odBgmV23pwPG4FDQIB9eZ2dLM3beHufru1wOw9a81VdDFr7uQ5gbfeyBWkax8IfiPf6zvxqT9lJ0I5ds+nOEMGW9pEwC48Dm6phNDaS/wXb4yCl02Bdkv5xY6KbBrhwlGITUJkVMSyllom+1KJaUso90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mK97ONhd; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mK97ONhd"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e4c27270591so14464796276.1
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Jan 2025 21:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736313317; x=1736918117; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AT8iEH9vJtkOa5w38JMpGTjeNCZxlcDJNjwk/k3hwYw=;
        b=mK97ONhdNr5TPaEV4cerpriclyT2U01frSEJ21YTdvi9uzJsdsxl40SDgv+na72zRf
         0ScTz5ziAKDxeGWoPm7QLLv7sOa9+bUV28Humx+RRgHKUO6VA+sm44VTHcZGbP0qDdug
         TiD5r17lNhV8nVZk+rHyXbeseAvdqtjZJ+GGilKR6OoJLuRwHC5fGGzLVGbEAlz4ocYC
         s6vQmdPtsqBJo27RFRwCPLaO+M1I+EGXkzFuKX4Mh4nBPJdq/08DoP/G2PK8MNurF6qS
         Z1LZg60he9G/xzNKRZgjZNYt5Dtgd8lmJNGM5QAuQNCchPl32v3ZBfn84tNJlNAUQGA6
         SzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736313317; x=1736918117;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AT8iEH9vJtkOa5w38JMpGTjeNCZxlcDJNjwk/k3hwYw=;
        b=SyK3Pa7k37+6ApnlHBkeDv9PJt0SL6Pte5eb95SxeRAlbEcxybZNxbvhE5nrIQkvO7
         Kij3LyRIjEEcO/MkfOeU89gAitrdgh5Wumxl4dlUFrmILTHn4NHYqRdmJjzUgOsnaS0Y
         +5LoiGBNCp+n2CuIHc12Srsm0U4myShmro35cO6bczQW/UPWCnq5eXK1RdP/33/eG9KK
         gZiX781BbwjFLTSmaSKFyghg+mzc6COTeWnOzrNTxWwr+BvHme+RX74DAHB045CXLMpG
         9M0h05lHHOPcgIK9Ol2DeZmBwM2B6bWs/puirKtngeaCq0Y7PpWqmKsCzz3E0HN28c8l
         TGiw==
X-Forwarded-Encrypted: i=1; AJvYcCWrE9ovCz9GiURXS958BEEdBTBCWsa5ICsnq9RUAfyh8xqdxZ648vvjEA4ePj/2vMD6VLG9A2oBi5YsBcfu095O@vger.kernel.org
X-Gm-Message-State: AOJu0YzUomAEhWZS3gjrueOSZYjMJgSB5F257uCV/tk5dFtHnIuoyhhD
	BdSBcbsgyEjD0MBSd0gv8bslPTuPauVdLak5MFRcQgHtB/JGPGikdjyprszKlUDipFUcHW91MDj
	TZkN44g==
X-Google-Smtp-Source: AGHT+IEJWREqN4VCs2OVQHrtGO7R0c+il2ZFdztGbPuyEp2GXh7uA8jD6ma9Y6eTpk/ZgN9UiEYm8mg9ZXMu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:7ae:a887:5504:e3ca])
 (user=irogers job=sendgmr) by 2002:a25:d8cb:0:b0:e39:3168:53be with SMTP id
 3f1490d57ef6-e54ee2330f6mr3853276.9.1736313317666; Tue, 07 Jan 2025 21:15:17
 -0800 (PST)
Date: Tue,  7 Jan 2025 21:15:11 -0800
Message-Id: <20250108051511.1720369-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1] perf test cpumap: Avoid use-after-free following merge
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Previously cpu maps in the test weren't modified by calls to the cpu
map API, however, perf_cpu_map__merge was modified so the left hand
argument was updated. In the test this meant the maps copy of the
"two" map was put/deleted in the merge meaning when accessed via maps,
the pointer was stale and to the put/deleted memory. To fix this add
an extra layer of indirection to the maps array, so the updated value
of two is accessed.

Fixes: a9d2217556f7 ("libperf cpumap: Refactor perf_cpu_map__merge()")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/cpumap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
index 5ed7ff072ea3..2354246afc5a 100644
--- a/tools/perf/tests/cpumap.c
+++ b/tools/perf/tests/cpumap.c
@@ -252,16 +252,16 @@ static int test__cpu_map_equal(struct test_suite *test __maybe_unused, int subte
 	struct perf_cpu_map *empty = perf_cpu_map__intersect(one, two);
 	struct perf_cpu_map *pair = perf_cpu_map__new("1-2");
 	struct perf_cpu_map *tmp;
-	struct perf_cpu_map *maps[] = {empty, any, one, two, pair};
+	struct perf_cpu_map **maps[] = {&empty, &any, &one, &two, &pair};
 
 	for (size_t i = 0; i < ARRAY_SIZE(maps); i++) {
 		/* Maps equal themself. */
-		TEST_ASSERT_VAL("equal", perf_cpu_map__equal(maps[i], maps[i]));
+		TEST_ASSERT_VAL("equal", perf_cpu_map__equal(*maps[i], *maps[i]));
 		for (size_t j = 0; j < ARRAY_SIZE(maps); j++) {
 			/* Maps dont't equal each other. */
 			if (i == j)
 				continue;
-			TEST_ASSERT_VAL("not equal", !perf_cpu_map__equal(maps[i], maps[j]));
+			TEST_ASSERT_VAL("not equal", !perf_cpu_map__equal(*maps[i], *maps[j]));
 		}
 	}
 
@@ -274,7 +274,7 @@ static int test__cpu_map_equal(struct test_suite *test __maybe_unused, int subte
 	perf_cpu_map__put(tmp);
 
 	for (size_t i = 0; i < ARRAY_SIZE(maps); i++)
-		perf_cpu_map__put(maps[i]);
+		perf_cpu_map__put(*maps[i]);
 
 	return TEST_OK;
 }
-- 
2.47.1.613.gc27f4b7a9f-goog

