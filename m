Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C59E184555
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 17:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727372194; cv=none; b=BJQcooMEZDddj1SND7Qre4ZGHQU9tg0OCBHxXv/lSqn1Ht3cfNhHtQRUqjdQPbx0y/PMCwQ92Q4lsjCUaI+jd8IWEE/lKluNXE7ylC6Aa46euHt5PxH8xfKv/KtFplNFh+7hS58HZeh0y9/xXdUTtKdbv7z7rgSEbK1o/QMhXbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727372194; c=relaxed/simple;
	bh=fI23lg2vSD0PJe5j7dtsTs9wlvKu/gvHpzMuGdst40w=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=IHXHJZSYqDvHzLfBIIPV4n+8Wu0kkP78CBM/nkuk0zyEo7jOFt4yVUkhDRtG46i+SPAgpAYYtO4DlIkc7pvwPM8PdLzZ7mBQMJPViiedpNKCN76FDPnZNErWrOSJLQsOI4YQrz/yzaXzIWZMmnSeuZGKwjZ9BAC+TNK3kX4n3Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gQEx/nho; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gQEx/nho"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1d46cee0b0so1956550276.2
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 10:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727372190; x=1727976990; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a6UDuHGKMWgBm1lEl1cmmS7v6p/aZimzfV7mPrGbWXw=;
        b=gQEx/nhobTYi7Sbnaur5EvXYZkUe3oLZywROy88coGdMILCqiEhYvrwHh2mH3XuTT7
         TNGkR0CwG6hXSfx5TMWgJ0fNLyrBO+AXsmT4lZ7m8fp2tT/nYsq++q0jLwMS+tYSpJsG
         0l8+OoazvZNEnDm1WAZhWkPNANnoeI59CLzlJrSlq2Yu/PHIT5Ff1NPuKqD+frMGHVVE
         nyeuT9QoDbmE/em249CtFSHbYd4dHe3KfXV5+BechpWL1EMBQtxtj5uz/bCWgOaEkv6u
         urtRi7Q2SSJwPStziiQjRbJrS5KXJdBeMeUQBILzLU979xE4cmc1wCI748LwflGK6ieb
         BZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727372190; x=1727976990;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a6UDuHGKMWgBm1lEl1cmmS7v6p/aZimzfV7mPrGbWXw=;
        b=SOu8r6JOU4f1oQXrUneifdmRmNBbSXp/OsNYL+iHn01fLC9GfrxAGaMX4+DPI9LxZf
         BAgNR6u7qNP34JnH5w4ozHQrZi5RBN6xqejrha0N5ydOtVaCn5pGgd6W8vTpGflaAfkX
         EYT3sbi3frceggjD8wQEkrAgkCneqoYg7ANFyK/DE069B0ttAjzLL/t0P6FBrsFTrsiu
         qa5VUfbedF6HTAVydcVZUjMBIJCqxsLQSnXbyHAskNLgVZVZ9FS/jfVOguvI0zrQN/6c
         HSyFMXS8VzdD77t/8JgC06uLJ22JM7k8N33qSd6OnCD+V2nQMBxJby5SI0iueltA+MDH
         kaGA==
X-Forwarded-Encrypted: i=1; AJvYcCUC6freCojgVvG8vGu+mZ9taNE/BHI6gahKgzM8/c4s+E2evDQs/+3AhFOJpE/SM6E027jIm0PdrIsZma4K0HAR@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsf8km2C7i9vgJUi2tqm1I9CrLGDwJJCppWQ00C9/xKv6oTATo
	yl9bfWzSX0EurZXdlFejUnHVDrHFMEHEXkshFLrTac5ImhqvjtPXeC6M4QB/RDQ5wF4w24Q+sjj
	i5p15nA==
X-Google-Smtp-Source: AGHT+IEQ1v1udEuCVrnBHWM8Chy/nN8/OC9iN2ju/Bd9VgTTXhMcCxeiRvBecFcpETJs3lIyyiKunBEaUEPh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a25:d6c1:0:b0:e16:51f9:59da with SMTP id
 3f1490d57ef6-e2604b79520mr174276.6.1727372190471; Thu, 26 Sep 2024 10:36:30
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:35:52 -0700
In-Reply-To: <20240926173554.404411-1-irogers@google.com>
Message-Id: <20240926173554.404411-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926173554.404411-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 10/12] perf jevents: Skip optional metrics in metric group list
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For metric groups, skip metrics in the list that are None. This allows
functions to better optionally return metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index b39189182608..dd8fd06940e6 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -493,13 +493,15 @@ class MetricGroup:
   """
 
   def __init__(self, name: str,
-               metric_list: List[Union[Metric, 'MetricGroup']],
+               metric_list: List[Union[Optional[Metric], Optional['MetricGroup']]],
                description: Optional[str] = None):
     self.name = name
-    self.metric_list = metric_list
+    self.metric_list = []
     self.description = description
     for metric in metric_list:
-      metric.AddToMetricGroup(self)
+      if metric:
+        self.metric_list.append(metric)
+        metric.AddToMetricGroup(self)
 
   def AddToMetricGroup(self, group):
     """Callback used when a MetricGroup is added into another."""
-- 
2.46.1.824.gd892dcdcdd-goog

