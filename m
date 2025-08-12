Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C954722332E;
	Tue, 12 Aug 2025 01:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754962063; cv=none; b=OoUkLoaEN6f+j7in768ggIllZf7CGAmhaU2F06QxrH1187QX9cqWLeNcSaEWeNJs1ZSNeTYcRLX0A4+Q5/k7px9hgzgYovxwXGdJ6tOLCgvR9jvq5WmwKEkpdHD37v/2yP6eu9hiTWxA4tY7lWu5w3vQ4jQLK/Fpj3y2owxU5tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754962063; c=relaxed/simple;
	bh=RoxD1aG1RWQxFWWsFZz7qapdHfFLS3SnVyou3HTXxZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=afwJACBR2ITEW65HN2/5MIJcwbSP8Z2YPTi5j+18aa38qtcaXXMzFF8QIh6PKdRqIa+kTV3WXSP8M24c3ellkHMbkNwEhtEaD1fI2kNU517WD3L0nBne+1UNF28J9cgfQOlIo6A9lM/mmkMMZd7u/RaZkEgl2f6E75KHNTwvxRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-31f5ed172daso931382a91.2;
        Mon, 11 Aug 2025 18:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754962061; x=1755566861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JVuTHpo8HlQXIpXQibhEcFczkCHN73jjtQMy1pV6lPk=;
        b=W8n4FHZkoWDVBY7Mo8aL5wrkIwKR/fDjSC56MuLLgdypYJJD1nfZM6kzOphZcsYUps
         ZiMtp6x1o9WxbHn0yI7JJcNUPelGB6R3TmC9K8rJljemaY+kGS3DUSWbJPK8TEfyoSo5
         DPPMYaaal+AMAQryeNg72eyY6NCd+Y9shlB5rSTh03xaisPGJyf5d2w3fnCneR2YxaIv
         rUpCngI2qOIC2ogl6hS9Dz0SqK5T52AZ994EMVNMRW1zP3PVjJOLpc2kdisyXw8Q9Cnj
         frJ2aPdnWDGnQUkS5uZJjNyqYW7hP7NAXioZSdlT5V9ZsTXTuJH0UIpu1I+l46DyWTD2
         eg7w==
X-Forwarded-Encrypted: i=1; AJvYcCVmPTE4LwuDG/tlygFqVkNVGKlPKkVzZrmcz0KReh81Yj+exklCoSDhdrC1dsEB1wqG6V/p4nz6N24/Mm2D+MsMBw==@vger.kernel.org, AJvYcCXSt/l+u/+FxSliO2fTOc6KMXODSJyZ6RV1n5q2wqI5kUiyi3xWcIXSRu6lFWaHjVF6NeQXTP5CeB3w1VY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0TBahUTMgEMpDsOHolX/Iw1pOJRHvKrkcMA0eJDZ4wJnOYRcj
	naloqRnykXQxcpYY3SSRmPd+rfzGLJRtPhwou6CRxvjp8ybdinqyKS2ELBPFpX1W
X-Gm-Gg: ASbGncsflX/NYGxXygqDfwj/Sz/9qso1cWI4Vg0E/Bp7bkjOEnwl4IQox6nGP/L/32o
	SUN5maST2LuH8T4pAybbHT6k7BswBsewIpRrlH7rIzC3E0dksaxAQm3WfQHOST7rolOvfbrKme8
	VS4OE1pLzsTOWn2QcteRkIG+DbbeEbeGeO6BIi4gwYyK72xBK1rUTeVbUvL7gdJJGmTOpBbOjqf
	6Qo/dy2e5X2xziu6O8DMwicEsPAh0e68JwiPYONk3Be9hx1T+17dYSDZr4Yjr/JqYMKnGTqbWvy
	cUlwBSHlV3yEawEaxQpcyQFF0FB2HEM6IWPgj/XJrU9WhlnUiRZx9qhels5HAfbDrTQMPdq/yzj
	OxHPsivlBF3O0
X-Google-Smtp-Source: AGHT+IH+sHU+p6EE9tLJ69xDjRQjSaP6OQiHInaa4IyLnxW+9kjONfmq9qED3fS22qoiduoFsDg71w==
X-Received: by 2002:a05:6a20:914a:b0:235:5818:66a3 with SMTP id adf61e73a8af0-2409aaf5c23mr1286557637.8.1754962061095;
        Mon, 11 Aug 2025 18:27:41 -0700 (PDT)
Received: from localhost ([218.152.98.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b424ca987desm19134173a12.40.2025.08.11.18.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 18:27:40 -0700 (PDT)
From: Yunseong Kim <ysk@kzalloc.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	Will Deacon <will@kernel.org>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Austin Kim <austindh.kim@gmail.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller@googlegroups.com,
	Yunseong Kim <ysk@kzalloc.com>
Subject: [PATCH v2] perf: Avoid undefined behavior from stopping/starting inactive events
Date: Tue, 12 Aug 2025 01:27:22 +0000
Message-ID: <20250812012722.127646-1-ysk@kzalloc.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling pmu->start()/stop() on events in PERF_EVENT_STATE_OFF can leave
event->hw.idx at -1, which may lead to UBSAN shift-out-of-bounds reports
when the PMU code later shifts by a negative exponent.

Move the state check into perf_event_throttle()/perf_event_unthrottle() so
that inactive events are skipped entirely. This ensures only active events
with a valid hw.idx are processed, preventing undefined behavior and
silencing UBSAN warnings.

The problem can be reproduced with the syzkaller reproducer:
Link: https://lore.kernel.org/lkml/714b7ba2-693e-42e4-bce4-feef2a5e7613@kzalloc.com/

Fixes: 9734e25fbf5a ("perf: Fix the throttle logic for a group")
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
---
 kernel/events/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8060c2857bb2..c9322029a8ae 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2665,6 +2665,9 @@ static void perf_log_itrace_start(struct perf_event *event);
 
 static void perf_event_unthrottle(struct perf_event *event, bool start)
 {
+	if (event->state <= PERF_EVENT_STATE_OFF)
+		return;
+
 	event->hw.interrupts = 0;
 	if (start)
 		event->pmu->start(event, 0);
@@ -2674,6 +2677,9 @@ static void perf_event_unthrottle(struct perf_event *event, bool start)
 
 static void perf_event_throttle(struct perf_event *event)
 {
+	if (event->state <= PERF_EVENT_STATE_OFF)
+		return;
+
 	event->hw.interrupts = MAX_INTERRUPTS;
 	event->pmu->stop(event, 0);
 	if (event == event->group_leader)
-- 
2.50.0

