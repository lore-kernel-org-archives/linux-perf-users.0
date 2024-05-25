Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0777E1
	for <linux-perf-users@vger.kernel.org>; Sat, 25 May 2024 01:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716600639; cv=none; b=GcjjX+KPLtM6FxeLmeYTO7LmVoUFrB5irIO00na9YqKahA6L7cWp+tKc9g3vv6MolyrQnkle8lURuH8CJffKj4i7q2DZh3pAtKTLOU0O/XCLDUMk6E2YoHkaiSebku6vFEE2Fsq5VJV1G+akZyLxFSWZNauVn8n1yP1WLLyFRLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716600639; c=relaxed/simple;
	bh=Ts0dqe6K6uKFuGxzf0I0eXV77lX2kybuRrr/f6Fr+ws=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=cksSEQEY1aUvNJIryjXLpR7hYYeQYOa+xx/sEidVTCRW/U7tsYymU8byVw3ZpWL+Y1F3wGXSmIRI0pKvUm8dLOlGsU2G2Lt67U72rbPBQR0FNpJYzpX87G5qpskrsySoG90xICC/4xcY3pmAyXBBZwQd608FjaL5ET43WuveG78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uy402Tw5; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uy402Tw5"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62a052ffe31so8782507b3.1
        for <linux-perf-users@vger.kernel.org>; Fri, 24 May 2024 18:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716600636; x=1717205436; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QPb6Q+KRqvfktX5EPKrvPHvH0PQLcGsMH8/fhQZA9+w=;
        b=Uy402Tw5gMQqz+wVu8Oa1n8rR9zS1JoNzGqJVKgg8ZguZPR1zoI7+qzAO3fOS6Pkvn
         ta5/QmQZ+ZixmIXhSgzpOedAM6zgHLKz4eWgnhbrC1GAz4tK7f6JzMTssPgrP3gV71fr
         DnGmvszc+9j2NMgHoXYBv4Babbh56uOKQF1eS2m5DUSdbRRgQ6wYK/b9RYSNwP4KonmY
         99XtnQBpP7BFVHWcNkqZpzHd1BB7Mwpwwpu/YxV5mYGmLBhsPfX/NM4YztECW59H9giP
         a1pf2cBT1QJ4hzj4XzMSar7dNtuN9xZViBlhR6E7DIqtrcS4h14cqECX4DZK0qB4F4Cs
         YZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716600636; x=1717205436;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QPb6Q+KRqvfktX5EPKrvPHvH0PQLcGsMH8/fhQZA9+w=;
        b=aARxwtw6KHqQZk3oS++gUL9z3QiHTr6OIONgxy8U/0ZpN4YmswlTEP2zUCRAbSZcTg
         gxk1BI2QdN9ANK6Rlhp7/EZX5rC8FfUMT9gwLwoVJicnfFUCX7ObmQ+9eqOJt+1zrr4f
         RU9kt5Jq3dwrEBshMEMLu4SNOFIkbN2Q5dcIq26gDT/xUHVzwxHAcgQNoYNyHh5/YPe6
         15NWFtZ1uhA1IoZ0TF5UErageUSe9Fi4VhsXwkTtmzKeqKk0EBwmmmLouIsSp0jGRZqW
         I0kbLlPnA47WJ5+jvtfwkV7iaJpUXiOqLDG2SWbMBSlaWVEaVsef9ODMG7n7EPNi+o++
         TkaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUTEf8qeBdZ8GKGokGg5EC74wMttyYXUTy8h0Esy7SMhTTJ+j7/rjAm3GkebjXOKV95IuuRhXwpkJAObaj9xs9DmysXBuaw35GAYAxWsRlVw==
X-Gm-Message-State: AOJu0YwpzLK6gjzBEBy/RRXz82V+xpEKHGcuAMjM9RD3bYSyfcKrFUzq
	bAxW6r6suRH3jIkbx/i71vr0VzAyLdtvxJOfERBw49/IiUYZaRLLsUAN1qn06ynufByyyTs7mZw
	auD2omg==
X-Google-Smtp-Source: AGHT+IGmkF3+V0Ozuy5EbuioYBt68G7Q+xND22wXwzK3iViocRlXZg7Tm+LKiaDwSTzMv31osrsbToh9E09B
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b0b5:95af:a29:375e])
 (user=irogers job=sendgmr) by 2002:a05:690c:600b:b0:611:5a9d:bb0e with SMTP
 id 00721157ae682-62a076284d6mr9246757b3.4.1716600636541; Fri, 24 May 2024
 18:30:36 -0700 (PDT)
Date: Fri, 24 May 2024 18:30:20 -0700
Message-Id: <20240525013021.436430-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Subject: [PATCH v2 1/2] perf jevents: Use name for special find value
From: Ian Rogers <irogers@google.com>
To: Weilin Wang <weilin.wang@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	John Garry <john.g.garry@oracle.com>, Sandipan Das <sandipan.das@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

-1000 was used as a special value added in Commit 3d5045492ab2 ("perf
pmu-events: Add pmu_events_table__find_event()") to show that 1 table
lacked a PMU/event but that didn't terminate the search in other
tables. Add a new constant PMU_EVENTS__NOT_FOUND for this value and
use it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py   | 6 +++---
 tools/perf/pmu-events/pmu-events.h | 9 +++++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index e42efc16723e..7cc16ff96dc8 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -905,7 +905,7 @@ static int pmu_events_table__find_event_pmu(const struct pmu_events_table *table
   do_call:
                 return fn ? fn(&pe, table, data) : 0;
         }
-        return -1000;
+        return PMU_EVENTS__NOT_FOUND;
 }
 
 int pmu_events_table__for_each_event(const struct pmu_events_table *table,
@@ -943,10 +943,10 @@ int pmu_events_table__find_event(const struct pmu_events_table *table,
                         continue;
 
                 ret = pmu_events_table__find_event_pmu(table, table_pmu, name, fn, data);
-                if (ret != -1000)
+                if (ret != PMU_EVENTS__NOT_FOUND)
                         return ret;
         }
-        return -1000;
+        return PMU_EVENTS__NOT_FOUND;
 }
 
 size_t pmu_events_table__num_events(const struct pmu_events_table *table,
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index f5aa96f1685c..5435ad92180c 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -70,6 +70,8 @@ struct pmu_metric {
 struct pmu_events_table;
 struct pmu_metrics_table;
 
+#define PMU_EVENTS__NOT_FOUND -1000
+
 typedef int (*pmu_event_iter_fn)(const struct pmu_event *pe,
 				 const struct pmu_events_table *table,
 				 void *data);
@@ -82,6 +84,13 @@ int pmu_events_table__for_each_event(const struct pmu_events_table *table,
 				    struct perf_pmu *pmu,
 				    pmu_event_iter_fn fn,
 				    void *data);
+/*
+ * Search for table and entry matching with pmu__name_match. Each matching event
+ * has fn called on it. 0 implies to success/continue the search while non-zero
+ * means to terminate. The special value PMU_EVENTS__NOT_FOUND is used to
+ * indicate no event was found in one of the tables which doesn't terminate the
+ * search of all tables.
+ */
 int pmu_events_table__find_event(const struct pmu_events_table *table,
                                  struct perf_pmu *pmu,
                                  const char *name,
-- 
2.45.1.288.g0e0cd299f1-goog

