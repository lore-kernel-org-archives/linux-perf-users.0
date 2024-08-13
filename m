Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8922D19B5A6
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 13:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723555498; cv=none; b=f4FWXRtYAlLyNETzCGiIfFvDr6zcqjV30kqihfz0E6TtRxmBFaO3k1edbhhgpJnn7/HX36ttPLF9CLIIqg4VwtDx/67TmpTgLckbNU2hYIdo0miPm1/2jReeV8NN7NBm+jpET/Yb6LOWK+E7A9GOPGMl+JwtS3LFcqsG6CexTXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723555498; c=relaxed/simple;
	bh=169AxUGyTxrsEVYe8bfX3XyoWe92S2PZ842YmAzlLUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IZMHwbeiGL/ykWYpPNnzYUlgqEpXepPvu056gDw8sMMOIXieMVfhALH4pqJivU45UCqBRSHHrmHIsnUW50BTZ++2u/U4p08jNWTmPs40suHXldN2HmtVBMGkC87owWi5lN8opzhmG4agoGCBQ8zNxPlLQO9EA7mnVzI0shQiwZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MDfVY8Y0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MDfVY8Y0"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42819654737so41228235e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 06:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723555495; x=1724160295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8nva4x7yooIvcMdEZLd+2R1OWdlEwTPtLBsl8/711k=;
        b=MDfVY8Y0MrmEwRBDochpJdUq/lEnlnyW05js9JdOowF6g3qGhCqwzLAP3N7pdqi8h+
         Q7/WeZWZ81sqn+jS0v3zM/7LbM11eNHc34Eh1M6VFFhVfjmWY0rsnA6wdNxPTZdgkBV+
         uF4AVjP9WkUjjxkqnZrh0XxQwiE6jLDvj3GH3zuojG4YiB1Jki42eB8DD2gYinED8dHp
         1sRhdGu3dIKfZ7TcA+8sUlNhxlXxeFQHAUQgfrIAQTwbp9IJ5mAFViPtITT06eZG2zv3
         DPEiHNoPUHDxIgM/iA3H0NXN0/O/R2SszD6o3Go3wuw2x65VS4zWnofdNnCQzxdk1PiZ
         kvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723555495; x=1724160295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8nva4x7yooIvcMdEZLd+2R1OWdlEwTPtLBsl8/711k=;
        b=ioicmH+RTl1QLsl4IC93xF9QOf8HZYmAAjqRmVR7eet94Da7Ncsywv5xhqaj8Df9qL
         EZHPBUdezIpwJtJweSLrX0SK25pEkUETbprkg2b+QLnIXyCclgMzJfSnei6jQs+l9y7G
         rLhB0Ul9HXD1z4+ZWPQfvB7aBz60KjtbrIZ07xvXRYFjJ5bwo4T3XjegRNxmKGArGPDS
         z3HbrQ0JWdOlpdRdr28pKQ8XZvuZFZaKMfscGo062+FddPtOwI/MseigPNgeTSxbCYZH
         38Z751lM2ARvqgNgjgUOsovXojLQYijpSR/UfB9yVmx/L7rUjV1GaN+fcY8HjwM3W5bg
         3hxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUl0wkiZdM18HRF1eGR2dYBDWIqFm2iKUAuPQMhAZfMyPubFskCEVDeIIPA+JCfstVf7wQd90J+1X3Eys7xrTErnUXr+WFd02FLEvrRPtpYmA==
X-Gm-Message-State: AOJu0YwAB+Ql9YFE3Xy9KR2o2EEawRheiJ3pA1BNcuYOJ23WdV9JYBIV
	9/eJ9S6hddpMz4p1Q3jDfroRPQ2ViiT8Myo+3yki5MHixQX13IB06NLoruQxXNk=
X-Google-Smtp-Source: AGHT+IEB1qfIIkAEbIEcPEEgKpvjsK/gwklipRfgBKtNp6pSHRtCu9iLJZf0fYv5sQNz+N8Z4iTFNA==
X-Received: by 2002:a05:600c:3b07:b0:429:994:41a2 with SMTP id 5b1f17b1804b1-429d47f19f2mr27005205e9.7.1723555494826;
        Tue, 13 Aug 2024 06:24:54 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c738d21sm223186625e9.12.2024.08.13.06.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 06:24:54 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: irogers@google.com,
	linux-perf-users@vger.kernel.org
Cc: James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Ze Gao <zegao2021@gmail.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/7] perf stat: Initialize instead of overwriting clock event
Date: Tue, 13 Aug 2024 14:23:09 +0100
Message-Id: <20240813132323.98728-2-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813132323.98728-1-james.clark@linaro.org>
References: <20240813132323.98728-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This overwrite relies on the clock event remaining at index 0 and is
quite a way down from where the array is initialized, making it easy to
miss. Just initialize it with the correct clock event to begin with.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/builtin-stat.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 1f92445f7480..a65f58f8783f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1817,7 +1817,9 @@ static int add_default_attributes(void)
 {
 	struct perf_event_attr default_attrs0[] = {
 
-  { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_TASK_CLOCK		},
+  { .type = PERF_TYPE_SOFTWARE, .config = target__has_cpu(&target) ?
+						PERF_COUNT_SW_CPU_CLOCK :
+						PERF_COUNT_SW_TASK_CLOCK	},
   { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_CONTEXT_SWITCHES	},
   { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_CPU_MIGRATIONS		},
   { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_PAGE_FAULTS		},
@@ -2030,9 +2032,6 @@ static int add_default_attributes(void)
 
 	if (!evsel_list->core.nr_entries) {
 		/* No events so add defaults. */
-		if (target__has_cpu(&target))
-			default_attrs0[0].config = PERF_COUNT_SW_CPU_CLOCK;
-
 		if (evlist__add_default_attrs(evsel_list, default_attrs0) < 0)
 			return -1;
 		if (perf_pmus__have_event("cpu", "stalled-cycles-frontend")) {
-- 
2.34.1

