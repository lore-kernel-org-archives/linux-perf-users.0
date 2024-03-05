Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D9D7E568
	for <linux-perf-users@vger.kernel.org>; Tue,  5 Mar 2024 06:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709618930; cv=none; b=oCS9v24Oaqi5b+yYRTiyj8jbU76QUcXDIfzgEaNzRpPcpD3Nu7AUXuF0z8DFWEwHDzt5FXfff9ktGcdZdmg2ZDkzfcdAvgQdZeHAbbweC36NSPpsnJL0YJ7JpAmQZuZUqbjW6V3k6LoTDJkXsA8PJ6ixf9xisaFKV9hdIv9kZ5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709618930; c=relaxed/simple;
	bh=rI+UFBLzHgh5osY1C+DB3EoIdb5NuomFAo9d4P0bbRs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cfnyckmbt2JW/rIJcFUjOyZOUt1G60b/+jmqizT01eUIlixqQb3CofeMNP2hlA1elRn6Mtwcrhq0QXiQ73HoOCLak2AcFgaswosFqt1+UyBS5XtDhJSen3x95uNcHtswBXP2v9JZSRWM5PEkHaz0nUq7kfwkeQ3NEJyCQQFUgWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=K/KSsDs3; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="K/KSsDs3"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-299b818d63aso3867104a91.0
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Mar 2024 22:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1709618926; x=1710223726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5V8y3dySFl8kdmMCLan3vQixGPkJBiAZiaFJHDPmSXw=;
        b=K/KSsDs3cZvhHTgSRLVUU81HWOMLNTgsNjsv92bB1zIiKKdJQGqLpSTmZT8I9vmJw4
         CVxYDliWh0MJgeHACZJSVkXbok2QtfX2Dk0hnQzVMk1WC4Z6RWWAMaT5gbK2+mrcKuFR
         mgXonqUZIrIy8/XTA7sPTFxzlzf5XbnoOotdKX1F0kW3PSKSCdjjFhmYqzOvUex60LBn
         efiJTOeGDaul+QlfczCOKYb6hRUKZZBk6I/FpCIo1UQ8FDv3bMJCbBBSVux3AfTLb7Q0
         fZi4uEFuGbOgZE2I4eO2WkP7mdg9MzMAuiXUYPTbyChZ9VlNnBYxftpXiT1K0w/pyq7e
         v6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709618926; x=1710223726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5V8y3dySFl8kdmMCLan3vQixGPkJBiAZiaFJHDPmSXw=;
        b=jCLOAcVYZ9wL356LhGUkf8clwkLs0NS2aZLqXD3eysoGk8I4IXVPHuzOsGahLQDwGi
         UQ9l6AClkM6MCAKH6jrYhDTIirCOdtBbBZNtnIMa/rokHfbNsc4yuGOhXcJ3zr+NII1O
         P8PccF1QkXf33pzHb4ZTaNPTdkgxK45fGh8Tp2tOAvlpWz2OfjT+rjvBHLf7vvhpde0L
         KrpXa5JWPr7RPSVB1M/MophXpPUDhSZyETZGxrPpBITisoB0va7wtY4v1lSgDb4dd6UR
         6hawUGxQw2Wg0olT/HoDKKBGdCQMMv89IpNwO7+/EW6GzkKsIZYNvQGagxgcgW/LmJP2
         yNqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNuOvsxRkC16cSV91C1iLu5pQ32msAyvG73WSt40crUvgEmp3dLkFkmso1PczKKF4ZSNxnMLJQnWdwBlZF6Lg0cIKRKJBGAaImfzZpWC/Yzg==
X-Gm-Message-State: AOJu0Yw12L3O08nYJgrasqexjhZrHZz+YGgUehp6t2DQEuVyzTwKYXyn
	gxH66UJs6PtByX3o92RF4LtXzQiICpASbqDOziC5ibO9EEyR9azU3OwM/yN3Aw==
X-Google-Smtp-Source: AGHT+IGOEpXZTnOK5iI6B5DC1+LZXkbdTDnSB+eSncz2xsnVcoJBCg72j+iep0MPpUIqYZuf2r80xA==
X-Received: by 2002:a17:90a:a89:b0:29b:2c47:37d5 with SMTP id 9-20020a17090a0a8900b0029b2c4737d5mr2169834pjw.13.1709618926532;
        Mon, 04 Mar 2024 22:08:46 -0800 (PST)
Received: from zhadum.home.kylehuey.com (c-76-126-33-191.hsd1.ca.comcast.net. [76.126.33.191])
        by smtp.gmail.com with ESMTPSA id s5-20020a170902ea0500b001d7057c2fbasm9601708plg.100.2024.03.04.22.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 22:08:45 -0800 (PST)
From: Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To: Kyle Huey <khuey@kylehuey.com>,
	Robert O'Callahan <robert@ocallahan.org>,
	linux-kernel@vger.kernel.org,
	Ian Rodgers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 1/2] perf/ring_buffer: Trigger IO signals for watermark wakeups
Date: Mon,  4 Mar 2024 22:08:42 -0800
Message-Id: <20240305060844.9499-1-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf_output_wakeup() already marks the perf event fd available for polling.
Add code to trigger IO signals with FASYNC too.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
---
 include/linux/perf_event.h  | 8 ++++++++
 kernel/events/core.c        | 8 --------
 kernel/events/ring_buffer.c | 3 +++
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index c8bd5bb6610c..c077968d7e52 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1914,4 +1914,12 @@ static inline void perf_lopwr_cb(bool mode)
 }
 #endif
 
+static inline struct fasync_struct **perf_event_fasync(struct perf_event *event)
+{
+	/* only the parent has fasync state */
+	if (event->parent)
+		event = event->parent;
+	return &event->fasync;
+}
+
 #endif /* _LINUX_PERF_EVENT_H */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index a329bec42c4d..36b5fbdf8e6e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6684,14 +6684,6 @@ static const struct file_operations perf_fops = {
  * to user-space before waking everybody up.
  */
 
-static inline struct fasync_struct **perf_event_fasync(struct perf_event *event)
-{
-	/* only the parent has fasync state */
-	if (event->parent)
-		event = event->parent;
-	return &event->fasync;
-}
-
 void perf_event_wakeup(struct perf_event *event)
 {
 	ring_buffer_wakeup(event);
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 60ed43d1c29e..033e54bb5c62 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -22,6 +22,9 @@ static void perf_output_wakeup(struct perf_output_handle *handle)
 	atomic_set(&handle->rb->poll, EPOLLIN);
 
 	handle->event->pending_wakeup = 1;
+	if (*perf_event_fasync(handle->event) && !handle->event->pending_kill)
+		handle->event->pending_kill = POLL_IN;
+
 	irq_work_queue(&handle->event->pending_irq);
 }
 
-- 
2.34.1

