Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A6914AD0D
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Dec 2024 04:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733458996; cv=none; b=e4Jt56MZ3awYfV4q4CRA6p4MuDszb1sRsCYUXU03jzNiNGegjJy3OiAKq06FaxP6ShxuTJeCUybYi5c9vKxgQvTSJJ1p1eBEcwEJbUtrr88oXXHntPP/0TJ5B91muAVcSHIEjyaZXHrKAuurd3EYsNHWn3sxSgytwpnQarxHNnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733458996; c=relaxed/simple;
	bh=ivzmFMsWo2TkD+TpiEbpcTslMLYzWHdTEM/+FXZ3/K0=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=tdbsukKn4DsQtup0LUGG2TBViWoqEuP4aX72tuT+GNj+LpXwSGZIb9O4olNkiPkOOHLCyZ0gUFa88GT2CQ2B3yNmXVO2ewejaUMsKjfBMglYpSGM6l2vEE6oakjgYMcZdlIgczhxizoQt0+UoVaWOhbC4KI+372xXF4LNwRDTbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EgdST6S6; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EgdST6S6"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e39fd56398cso2330302276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Dec 2024 20:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733458994; x=1734063794; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3u0Jo/myRMQmTgFDZjkSIfnzHotxMGK46uHwrwBGJgM=;
        b=EgdST6S6C3+tBNRkIEmmHgry0aIjuxg0XHrGf+VshshXIJqQYEu/yJgOH0AEgsxth7
         eY1Kch2T2LWxt9BDpbvlQZZhl/kgAVWejtRziT2cE4KoqJbaWpoAYMKJ74OgT+oA2m3m
         /UhMnlJzyivnqaL7yD86fAV3biTDa3bMJf3L2QUGCWTuhtEZZ7UCViINCs+Ogk8K35mJ
         el50oXssQSM0wKKDzZj8m5GoBNoDh366zF0MvuqyaMmTEbC8ED12mtTrALIMk9dr5P/D
         cyytf8IlD4mSNkkwwAPPT9Z46A5UR59S6ovO/72+o4CqIFUI8pSeEqFhn/FBPZbA7MVS
         enqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733458994; x=1734063794;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3u0Jo/myRMQmTgFDZjkSIfnzHotxMGK46uHwrwBGJgM=;
        b=owEWbcyS8xFgqWOh61+9eTQh3GGITtRBweZ/YE3q72mRZUgxL20RyAfnTdOLpic2o8
         DUIuzY1F5paWQ6SXmenNq28/mp4fI4p7E6wz9IvGLz1bSZJoxQ0mbe097Ufx/Uqz6MA5
         RPXnSt6JEHrMnT0BT6zaHK4fhrcZ7ceeTGB/+MnrpkqDIsnRQFExkCxQNcNB6QxX0BOj
         nv6N1zyXolvKV7nTQr23eqm+d6cNpongih0bCAaw0iUX0Qz59l8Fe6ZHk16oryMRM77L
         hFQXzYOTCzEIno/pVtyuAJk7fJisABQVOOuMalyl5BGdnKoT1s93Ghvyd+BKnctyXHOD
         YTfg==
X-Forwarded-Encrypted: i=1; AJvYcCUU/c2suO9tDoOeUq8cc9nhs6HPZwD9jIZhNEF6REQPzCYZKqFCdrYmel2CczuHng/TM/RSBErdP2m7VsMROtAs@vger.kernel.org
X-Gm-Message-State: AOJu0YwaRu+3I/mkg6CypcrSwPUd5RxTqD3N2NCPUqe+wln9BVpPN2L+
	8aehBwJMUfdnu43I+iB2wqzYZblbu+BU/elWiHjNb1jX45/R6C5j2XsXASYxJr8+FOeG+QDCFk/
	lshyrsw==
X-Google-Smtp-Source: AGHT+IEjs9g0gbGtj7kmzQlXDJ3i78l4DsS+deT+ufr6kkUFl/9y5X1+lA2VzkrRO3i1fE3T+40Dua7ZqCXy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:eb75:393:2a8c:1440])
 (user=irogers job=sendgmr) by 2002:a25:aaee:0:b0:e39:84c6:562c with SMTP id
 3f1490d57ef6-e3a0b694179mr876276.8.1733458993883; Thu, 05 Dec 2024 20:23:13
 -0800 (PST)
Date: Thu,  5 Dec 2024 20:23:05 -0800
Message-Id: <20241206042306.1055913-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v1 1/2] perf hwmon_pmu: Use openat rather than dup to refresh directory
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The hwmon PMU test will make a temp directory, open the directory with
O_DIRECTORY then fill it with contents. As the open is before the
filling the contents the later fdopendir may reflect the initial empty
state, meaning no events are seen. Change to re-open the directory,
rather than dup the fd, so the latest contents are seen.

Minor tweaks/additions to debug messages.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/hwmon_pmu.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
index e61429b38ba7..4acb9bb19b84 100644
--- a/tools/perf/util/hwmon_pmu.c
+++ b/tools/perf/util/hwmon_pmu.c
@@ -258,8 +258,12 @@ static int hwmon_pmu__read_events(struct hwmon_pmu *pmu)
 	if (pmu->pmu.sysfs_aliases_loaded)
 		return 0;
 
-	/* Use a dup-ed fd as closedir will close it. */
-	dup_fd = dup(pmu->hwmon_dir_fd);
+	/*
+	 * Use a dup-ed fd as closedir will close it. Use openat so that the
+	 * directory contents are refreshed.
+	 */
+	dup_fd = openat(pmu->hwmon_dir_fd, ".", O_DIRECTORY);
+
 	if (dup_fd == -1)
 		return -ENOMEM;
 
@@ -336,6 +340,9 @@ static int hwmon_pmu__read_events(struct hwmon_pmu *pmu)
 			close(fd);
 		}
 	}
+	if (hashmap__size(&pmu->events) == 0)
+		pr_debug2("hwmon_pmu: %s has no events\n", pmu->pmu.name);
+
 	hashmap__for_each_entry_safe((&pmu->events), cur, tmp, bkt) {
 		union hwmon_pmu_event_key key = {
 			.type_and_num = cur->key,
@@ -343,8 +350,8 @@ static int hwmon_pmu__read_events(struct hwmon_pmu *pmu)
 		struct hwmon_pmu_event_value *value = cur->pvalue;
 
 		if (!test_bit(HWMON_ITEM_INPUT, value->items)) {
-			pr_debug("hwmon_pmu: removing event '%s%d' that has no input file\n",
-				hwmon_type_strs[key.type], key.num);
+			pr_debug("hwmon_pmu: %s removing event '%s%d' that has no input file\n",
+				pmu->pmu.name, hwmon_type_strs[key.type], key.num);
 			hashmap__delete(&pmu->events, key.type_and_num, &key, &value);
 			zfree(&value->label);
 			zfree(&value->name);
-- 
2.47.0.338.g60cca15819-goog

