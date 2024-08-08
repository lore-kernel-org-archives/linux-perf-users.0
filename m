Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3CB804
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Aug 2024 00:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723075365; cv=none; b=eor60Z1w4Gu01PLn605c+P6L9TpaUDZFSM6XiumoTRLKHPsfINEAgY7uKGih7SZYvgYxSeSsw/676IoNjwP0YxF2nHKzEL35V5cUp4jWnaZ2/1GXi7CyEU+8S7ZK+czeNGLwU03Um0CUG1+UrhYLdLAw3m0YL8LbN2AuUWseZnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723075365; c=relaxed/simple;
	bh=ncA7j5FLjxgFNOOh4x0zP+SXzgSe/WPcOS1wyXrefGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D9iB98xn++G0/XXl9oeR/WOryoFGvYnZ8rli8syiw8idLKFlvKbpbD6JZXIF1rmfvh6LkCtYvf048YavgjPx3mNM0BvVN82n2W4u+j+y+imJWZ3tgkj2keBfHre4VUjNESa0ly19KwvCSPII59D9JX2oaAxxecaWWelQicU6VP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=xzozSXsh; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="xzozSXsh"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc692abba4so4196195ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Aug 2024 17:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723075363; x=1723680163; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6l4Ci1aLiOuMlqSXWNryAFu/epHjds4KPihSlu922mo=;
        b=xzozSXshKN5swpB/IgAIaEA+6faXWFpNwPm9KS0OwFOP3MK7kIT9NfjLY7l20WyUdm
         qcL8KPZ2evaExm6t1yuVljerIzdz73uk3LNXmMEv3k+y1wT9cvUNvuNNkfztLmDgY7LB
         tAO0yeMVDXo5672LeTqcIIj7N149jRAv8bjEmKu1Zp9ctMxelM56xh8VBT5fljpdi8V+
         FrzjCovoi1tkYA6RTO7VgYitwIVG46V5RP2fQJLlvGp6ZTSspikttWLvSe3/+yCxl7LK
         IpBhlClUxfBEcht78uyzaaKyheAQynHMEktCKole4zCHMjWoCc9SMAZQ9dl0szQ4MYIE
         NqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723075363; x=1723680163;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6l4Ci1aLiOuMlqSXWNryAFu/epHjds4KPihSlu922mo=;
        b=SsP9/wrByc0HsTtQ7OXhaT1LID2NIriiXmS/mJaj0vivpx4Vyk+2mWZ11x09QSAllj
         /0nbXv58j4hnuLD9GcTZVoO+SAHlSo7PZLdT6AuKClUZF5oKPq4B1QZ2zhNcod/SueXa
         xy7mbDvxpQgorsz/8clr2YupW8YmpKRODCUJcCppZdWYLYBmUiQrsSlBxmwWTllD00hM
         5wSSBLwVGH5bmAgiG5edKC7IzjhIFHqgZR8yrOtS1ryTiaT/4cgS8opnCgCL9FRZlFmz
         EEZ11i0KqCx9vsHY//97jykTnT1YOKChlgRpYEaYMf3niGlD2dxCZTQWsMZROV3JwUYh
         fRkA==
X-Gm-Message-State: AOJu0Yw8kaBhgkliIUofSIMsJXloq/vHqMQKhkZjGofCWwFQzZ9N8ZJX
	ardh3Je9pf8qZOe1iVie3IHMPes1NWXF4w2N60TlqfEWEVyy+2FVKfZSr5AtTXk=
X-Google-Smtp-Source: AGHT+IEZXeE8R1dp+Z+jNGji6FswRy7HfeN2sd6dx2SaQtJGTLwfu3hZeL0L4DGDbCnXJ1MlEQ5vMA==
X-Received: by 2002:a17:902:dac6:b0:1fb:5c3d:b8c3 with SMTP id d9443c01a7336-2009528e2a1mr3843515ad.4.1723075363421;
        Wed, 07 Aug 2024 17:02:43 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f586f7sm112867015ad.90.2024.08.07.17.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 17:02:42 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 07 Aug 2024 17:02:40 -0700
Subject: [PATCH v2 1/3] perf: Add PERF_EVENT_IOC_INC_EVENT_LIMIT
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240807-perf_set_event_limit-v2-1-823b78d04c76@rivosinc.com>
References: <20240807-perf_set_event_limit-v2-0-823b78d04c76@rivosinc.com>
In-Reply-To: <20240807-perf_set_event_limit-v2-0-823b78d04c76@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Atish Patra <atishp@rivosinc.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723075360; l=5119;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=ncA7j5FLjxgFNOOh4x0zP+SXzgSe/WPcOS1wyXrefGA=;
 b=xKNlBvDwGqe6fTTyVMg//MABQ1HB9LfTMABQImgU3OooLj1ZitDIP0xqvmU4EuFS3YTOCvvDC
 u51oqgrjahhDBewQXpDgy99pBNP7dqGXm4QZCb0bnllAEfGP56S9FrN
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

PERF_EVENT_IOC_REFRESH immediately enables after incrementing
event_limit.  Provide a new ioctl flag that allows programs to increment
event_limit without enabling the event. A usecase for this is to set an
event_limit in combination with enable_on_exec.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 include/linux/perf_event.h            |  4 ++--
 include/uapi/linux/perf_event.h       |  1 +
 kernel/events/core.c                  | 17 +++++++++++------
 tools/include/uapi/linux/perf_event.h |  1 +
 4 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index a5304ae8c654..40025a5eb98a 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1103,7 +1103,7 @@ extern int perf_event_task_enable(void);
 
 extern void perf_pmu_resched(struct pmu *pmu);
 
-extern int perf_event_refresh(struct perf_event *event, int refresh);
+extern int perf_event_refresh(struct perf_event *event, int refresh, bool enable);
 extern void perf_event_update_userpage(struct perf_event *event);
 extern int perf_event_release_kernel(struct perf_event *event);
 extern struct perf_event *
@@ -1770,7 +1770,7 @@ static inline int perf_event_read_local(struct perf_event *event, u64 *value,
 static inline void perf_event_print_debug(void)				{ }
 static inline int perf_event_task_disable(void)				{ return -EINVAL; }
 static inline int perf_event_task_enable(void)				{ return -EINVAL; }
-static inline int perf_event_refresh(struct perf_event *event, int refresh)
+static inline int perf_event_refresh(struct perf_event *event, int refresh, bool enable)
 {
 	return -EINVAL;
 }
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 3a64499b0f5d..992f51effb27 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -560,6 +560,7 @@ struct perf_event_query_bpf {
 #define PERF_EVENT_IOC_PAUSE_OUTPUT		_IOW('$', 9, __u32)
 #define PERF_EVENT_IOC_QUERY_BPF		_IOWR('$', 10, struct perf_event_query_bpf *)
 #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES	_IOW('$', 11, struct perf_event_attr *)
+#define PERF_EVENT_IOC_INC_EVENT_LIMIT		_IO ('$', 12)
 
 enum perf_event_ioc_flags {
 	PERF_IOC_FLAG_GROUP		= 1U << 0,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8f908f077935..b9d009733ace 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3142,7 +3142,7 @@ void perf_event_addr_filters_sync(struct perf_event *event)
 }
 EXPORT_SYMBOL_GPL(perf_event_addr_filters_sync);
 
-static int _perf_event_refresh(struct perf_event *event, int refresh)
+static int _perf_event_refresh(struct perf_event *event, int refresh, bool enable)
 {
 	/*
 	 * not supported on inherited events
@@ -3151,7 +3151,8 @@ static int _perf_event_refresh(struct perf_event *event, int refresh)
 		return -EINVAL;
 
 	atomic_add(refresh, &event->event_limit);
-	_perf_event_enable(event);
+	if (enable)
+		_perf_event_enable(event);
 
 	return 0;
 }
@@ -3159,13 +3160,13 @@ static int _perf_event_refresh(struct perf_event *event, int refresh)
 /*
  * See perf_event_disable()
  */
-int perf_event_refresh(struct perf_event *event, int refresh)
+int perf_event_refresh(struct perf_event *event, int refresh, bool enable)
 {
 	struct perf_event_context *ctx;
 	int ret;
 
 	ctx = perf_event_ctx_lock(event);
-	ret = _perf_event_refresh(event, refresh);
+	ret = _perf_event_refresh(event, refresh, enable);
 	perf_event_ctx_unlock(event, ctx);
 
 	return ret;
@@ -5920,7 +5921,7 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
 		break;
 
 	case PERF_EVENT_IOC_REFRESH:
-		return _perf_event_refresh(event, arg);
+		return _perf_event_refresh(event, arg, true);
 
 	case PERF_EVENT_IOC_PERIOD:
 	{
@@ -6006,6 +6007,10 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
 
 		return perf_event_modify_attr(event,  &new_attr);
 	}
+
+	case PERF_EVENT_IOC_INC_EVENT_LIMIT:
+		return _perf_event_refresh(event, arg, false);
+
 	default:
 		return -ENOTTY;
 	}
@@ -6721,7 +6726,7 @@ void perf_event_wakeup(struct perf_event *event)
 	ring_buffer_wakeup(event);
 
 	if (event->pending_kill) {
-		kill_fasync(perf_event_fasync(event), SIGIO, event->pending_kill);
+		kill_fasync(perf_event_fasync(event), SIGTRAP, event->pending_kill);
 		event->pending_kill = 0;
 	}
 }
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 3a64499b0f5d..992f51effb27 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -560,6 +560,7 @@ struct perf_event_query_bpf {
 #define PERF_EVENT_IOC_PAUSE_OUTPUT		_IOW('$', 9, __u32)
 #define PERF_EVENT_IOC_QUERY_BPF		_IOWR('$', 10, struct perf_event_query_bpf *)
 #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES	_IOW('$', 11, struct perf_event_attr *)
+#define PERF_EVENT_IOC_INC_EVENT_LIMIT		_IO ('$', 12)
 
 enum perf_event_ioc_flags {
 	PERF_IOC_FLAG_GROUP		= 1U << 0,

-- 
2.45.0

