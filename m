Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007A91803D
	for <linux-perf-users@vger.kernel.org>; Sat, 20 Jul 2024 07:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721461609; cv=none; b=sdqZSgDrSYsEK3lWKbH83VAFwVxpcxMnbOULZhRhWo+IcTbfsc1tmpDYh8dh48zHD4RXLUZEBzenjwdVc7+9qGvKJetEG1vJlBivqofmXh8IukWeyRHVChKLcRhdliSmpzEUlnjlSRI5vr5PsVOUJ+GGYbyye6+5oJa84EbNBGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721461609; c=relaxed/simple;
	bh=TCkraRgkZ/cWDF55w+lJe2JNLcX3iOyf3fjmZqlM1v8=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=QD+Ahi8SdX6eSho5YAUDQI5BUpkrwuHvBkH7eGD5Taw6AeCAtsOCj5WOpdJ8y+1m9UwPUCZ/7bYO0spKiAMApOkGMPXDlpLnyBBZY4ul6OTcz3aLIQbyVS3lYNwc7GARqfIVGaA2O7PnSVbODyrp7KKTJul8OfoQcLxU+XmeA+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C2ApYbbV; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C2ApYbbV"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e08723e9d7cso1040479276.0
        for <linux-perf-users@vger.kernel.org>; Sat, 20 Jul 2024 00:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721461607; x=1722066407; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yp3G2O/AMKzgruzp+hIrvoG3w9Lyd6HB8ME50phSljQ=;
        b=C2ApYbbVT/yk02iOOy8itcbHYnQcN8P/xSBlhnFzfXXsfMhFkUj5R1cF3xgkGFMAhS
         wdVy0cfBlAIOzWOlGvhjrkjkhs20XjQ8FMDHQnxAJvMFISuBnN2TLF/rjUMycliRFPt9
         V3MrPVBEP7e6O61boLd2chZ/UAxBwnHBrhkBiu2KFtkQqZNAWFuS1mEw9rg4ZRQtS/mQ
         QZGXlu2XdEpmO2bleTNPdMB4pTV8tqkRL2gYybYHwkIc1QBTdDYb6vQ3ofX5IzgByb/a
         K2qk18Y6trzvqIJthuT1Ihxfo81qCKkDwGjTRE5Gyz41thty1aNR4ivVvRy4hkOOVEnF
         klYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721461607; x=1722066407;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yp3G2O/AMKzgruzp+hIrvoG3w9Lyd6HB8ME50phSljQ=;
        b=p77+h6sCUbz6ijpq52e2JLDH8+dctTrSIVOWZzQucSJZ1JgB4sYhD9g5IT38kAB2En
         hZTcLfA2nqiiMM8J8HtozjzrHaUmQm6rEoVZOGk/KAYTXCYa8DRi0gTOYKZPTYJL01XQ
         7ntcrfn9+998O3/VQFJOP3DJYtIOsV/+RSRRjDzXNP3vnzOf7Lh2oQfVVPs64K5Jt/PG
         jGF4zMhlalnAW5ohCJVZ6SCMtDOGmSjH5CWlcgDSKQjrB8B8DpIiwinMVFT9AbwXEBk5
         UzSn76eOi/LJELQAZ0Rvf/3GE1yKlC7W+BtcIgaSajYMfHCjJJb0Qh5l9VNeO0bLcUIn
         OD+g==
X-Forwarded-Encrypted: i=1; AJvYcCUKa0Yc1ZkedU39X8ZyM5vMP34EOvQf19PotdzYGqbngmtGZvAMJ8WlSPjoi0kUBtHpomFsm2Q9DPhvrPE+hX1ah9aiBtnSjQSHS9O+y8TKsw==
X-Gm-Message-State: AOJu0YyizAlHcQLxDz4RctVCniJnmH5cPF2c7cgLuj6CwByMDfewkHMN
	euSiV5iVGzjprVszSjjK1rC0Xw2OOKkzJZlGNScxvOJVlauzqMklWUJ47JgWBpJj0PaMnE3r5QU
	2nN8ifw==
X-Google-Smtp-Source: AGHT+IECSiL47Avn+rFt/Lw8pbMrOMAl/W6rko3QnvPj+nApn4mgO2aALZpE+QoJUBwZ98UOHRhfGoOoLw1o
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:5df:6f0f:a93c:ac73])
 (user=irogers job=sendgmr) by 2002:a25:902:0:b0:e05:a1b5:adc0 with SMTP id
 3f1490d57ef6-e08704570c3mr7212276.10.1721461606800; Sat, 20 Jul 2024 00:46:46
 -0700 (PDT)
Date: Sat, 20 Jul 2024 00:45:51 -0700
Message-Id: <20240720074552.1915993-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v1 1/2] libperf threadmap: Add ability to find index from pid
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"

It is useful to be able to determine the index of thread in a thread
map as the index is used in other situations like finding the perf
count values. Unlike with perf_cpu_map__idx a binary search can't be
performed as the array isn't ordered. Also -1 in the array matches any
pid.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/include/internal/threadmap.h | 1 +
 tools/lib/perf/threadmap.c                  | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/tools/lib/perf/include/internal/threadmap.h b/tools/lib/perf/include/internal/threadmap.h
index df748baf9eda..92889d81b6b1 100644
--- a/tools/lib/perf/include/internal/threadmap.h
+++ b/tools/lib/perf/include/internal/threadmap.h
@@ -19,5 +19,6 @@ struct perf_thread_map {
 };
 
 struct perf_thread_map *perf_thread_map__realloc(struct perf_thread_map *map, int nr);
+int perf_thread_map__idx(const struct perf_thread_map *threads, pid_t pid);
 
 #endif /* __LIBPERF_INTERNAL_THREADMAP_H */
diff --git a/tools/lib/perf/threadmap.c b/tools/lib/perf/threadmap.c
index 07968f3ea093..728683199a85 100644
--- a/tools/lib/perf/threadmap.c
+++ b/tools/lib/perf/threadmap.c
@@ -99,3 +99,12 @@ pid_t perf_thread_map__pid(struct perf_thread_map *map, int idx)
 {
 	return map->map[idx].pid;
 }
+
+int perf_thread_map__idx(const struct perf_thread_map *threads, pid_t pid)
+{
+	for (int i = 0; i < threads->nr; i++) {
+		if (pid == threads->map[i].pid || threads->map[i].pid == -1)
+			return i;
+	}
+	return -1;
+}
-- 
2.45.2.1089.g2a221341d9-goog

