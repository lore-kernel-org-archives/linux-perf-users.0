Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB73B13D88E
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jul 2024 22:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721861673; cv=none; b=bwntHFUV8o3ZdRyA546dPuYiVDxIXDZx9f95o9GfI2n1KsCo2F++o8fjdhPkf+PQ002159iRnjgHUe27Wtcj2aUvCJRfbUCZRHtV4+bTNRZSOB03Q5cmXtsp7M4GgNn2GkmDsr4+ByOWGmystO7rVaX/dA9GcJBOf2lNH9xbpHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721861673; c=relaxed/simple;
	bh=OP0JdHoSd9gMBU62TPqG4ciM1LELFK61GDnQjRxEkpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NB0n9pHebTrBkooWY4VGPCEGvfYydjutQxRwgzMjsBQzySJlPmAKWMMBebjyLkYcae7QLDisg4smolrw7c7dOxmjn2PtKR3a4bNgI8bLHbTwxgWqGcWdBV2nIioMG6bTwFRUOJ/iN25I/4o+DruoOtwUxuoKO4RmGA/AIYrf5s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=njLUo5js; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="njLUo5js"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70d2b921cdfso287467b3a.0
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Jul 2024 15:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721861670; x=1722466470; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tDb9UcxpPJ+x+vOamEQvSw2xOsae11rJfZQoPCR9PSA=;
        b=njLUo5jssxii1UDYO2QPlpaRMuAZh7EtVBA+fZ6RcVf/jI9pwAHgXxW9V+ZA7Urops
         ET1+KkVPg1lNYEc7VoydSqPwQGNpj1zsRECAolNN+rsHuYoY8KjC74HATC0IRgdflGC7
         NKEBubk7/va4Jd+oKxCN5r4ce+V8zMyK5XksmXHRrEIDKdvOSQkhv1Asy75/mpX7j3uA
         F8ZlpfwnPc/JyhhPczv1GCKhBvPLDs2XNWbu4fYi3e9jaDzIFPKDndLdg60jxWJcJ17U
         aU3ErwM0fMwRjvMeQivxjiGto4LEN5wRm6cWhiQum9qDe4wgL+R2Qi+QGetwIQUNGQho
         qqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721861670; x=1722466470;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tDb9UcxpPJ+x+vOamEQvSw2xOsae11rJfZQoPCR9PSA=;
        b=SYbvrcu9lV4/WR+9jQHhJnGz5wgAiug2tXk3Fo0j1HWC36jRT/8ckxJUhP6nUhhSmS
         168rIjesB1DqeI/lnLOjcq3G+j2YkZ13XMblzHZxsCVvgYpmtx44M1LQ3e/MQX8sps5k
         /IAB9i3PWgwd4Ftc2E15WQ8xrX69fOr1PfY0byXagw6/E38W3Ljcdg0K0zJo2xj3fxyt
         RoHVdo7mscuc3YwlbWv8HMmWhx3SAJ/P5YAcBvfsBVz+zFrD5LOcfmjYV2QPRjLfCAhB
         dxVG4dh5dY/62+EFWXrmYoDAkrNMD8lrbZVXdf7aWeUuDX2j7bh5aO4YcLIsWaztkZ7L
         xTYA==
X-Gm-Message-State: AOJu0Yx3fOmZu+SywO43JveJrp5yi2xUjixWirQwWGjOdm7Xka0FaZLV
	/b960UklS/Sp9YCfAeCjb2wBo7xsZFGFxPJ31ROerQke7H9Vemvu9YAfLO5ZqA4=
X-Google-Smtp-Source: AGHT+IF9fif1HCfBJ4YhIrH1wtC24GQEnJ5adEf6WQQm+HSY06XkFnQlsT0TMF+ih4DDmrs90zkr0g==
X-Received: by 2002:a05:6a20:12d3:b0:1bd:18ee:f145 with SMTP id adf61e73a8af0-1c472803abdmr1849216637.1.1721861669976;
        Wed, 24 Jul 2024 15:54:29 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead874c6fsm74992b3a.165.2024.07.24.15.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 15:54:29 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 24 Jul 2024 15:54:11 -0700
Subject: [PATCH 1/2] perf: Add PERF_EVENT_IOC_INC_EVENT_LIMIT
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-perf_set_event_limit-v1-1-e680c93eca55@rivosinc.com>
References: <20240724-perf_set_event_limit-v1-0-e680c93eca55@rivosinc.com>
In-Reply-To: <20240724-perf_set_event_limit-v1-0-e680c93eca55@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Atish Patra <atishp@rivosinc.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721861667; l=5119;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=OP0JdHoSd9gMBU62TPqG4ciM1LELFK61GDnQjRxEkpI=;
 b=xk6OYmV6UNcRRVlbkOqATweVf+A0I3+Nel2KBoFXVaG9WmkaZy235qX37LIex6eODtMs9Fc3j
 pUEQnO+Sm0jDfN85eaQNcOKBI42GGWw2z8bn/NzLqq8cH5v4Fiife7E
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
2.44.0

