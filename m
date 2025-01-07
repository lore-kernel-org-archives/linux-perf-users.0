Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55969145A11
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Jan 2025 04:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736222871; cv=none; b=V+m7sq7E4V/zOzyjCvpWApkGC/WHfov/5sQcTOKAFyJVHTBWryQwyq4OEzZ5ZfHpfxUHHO6uJOrcEbG0D/WukoGehk+s9sQzOa0efQKVxcd1skeZK7O9743sBnuViUTZdlzSBYexs3fUhILvlDqRkpoJCR6moSUoYpN6/J3P2Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736222871; c=relaxed/simple;
	bh=3MPuBqEVBmCpQhxI/FOWLYc7igp3KxmQR/V7e/nsaE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IkmRBFYmF8baI3lLPz0srpsf62Ep7aFnjrGrtdRem28OE5K7uj1ixpfJm37PCVrUPA/+mbsSxs+ZGrpRwu2S8x5GbCj+ch/4IIH3LpGgqhjKvPZyEup8Xcbm8i+HyUWUBi1eLWkWltNviTi7rkNLtO7Y3B1q1YImMWny0T4HkME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=W0eCzJfM; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="W0eCzJfM"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21683192bf9so215172245ad.3
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Jan 2025 20:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736222869; x=1736827669; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DNHnHbzW4EWqalC8dcRjJBtEIigc0/S+kzDt+RIKIFA=;
        b=W0eCzJfMvcvDBlaXNjpvWHF1lLl7tZzRQ4eRUihACvrxxhpCOPO87Pa9NBqRGDbBKv
         f9VcgXeQxnqlsjLbTbA6qXfqV3k8WQhGXZx6Xx+yA0yNbJ0bSTZd6zlT2/eUNJKEnSLN
         ocwpyzCIbpFaBd53rJ+2nEzTV2hAfvBnMJs9z7/u+5byfctwI1iOSDy4v0rjSztMpJV8
         GX41yusKdQyDcrf2qay0pZ7pMIhvm3ADWkzVkSoJaLZq+BBlJthOzkwUbA/BozGFG1xg
         8FmEINPcvAU7XXhmSJQG65i1yRrxYhbRyRsnBaJDTynTSvwpxgbADWxHE5f9xvgFK2Cp
         OC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736222869; x=1736827669;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNHnHbzW4EWqalC8dcRjJBtEIigc0/S+kzDt+RIKIFA=;
        b=qx8M5HsjPoEDLp3MPFzJAVea/SKjo5xdPjuNl7Gslzjnnwsl34ryZm5aNwMeA97EhP
         eM7YBItXCk5zemGChK7iL3DB2eyBvSEG3vWZ5ksrmKgEOa68Pt5GTX3U/NdfmO9SGnPD
         bR7c9d/TzW/d34r6NSrPb7BGyuvzzPz7n4TgC8+n4q1pofLLZO/oqqwdEYwUMfsrHUoV
         2xC/SL/XM6gRE6ct7DOwkKHbySSTr8OU0WHgEHtw0eP6g8ovgKY+1rDFr+KI5GLoVajc
         DGAouOfWH3Vd0Ywor45rBfnECZAHlt71CdL+g/UlNmyW01S3AOJjzwRu2CwGs97VUG4O
         B3sg==
X-Gm-Message-State: AOJu0YyCDV60tDEVDpqGo5hTNd6HeakjW17W30Gisk+0cfBYIWFu/xmH
	rIo3F8dH0vR+L8ekTwtto3Ej2z2N+mtvwM+6YLv3yHtcpfvm25l9s7JB2oq8gEE=
X-Gm-Gg: ASbGncsv+JHvRQXB+QQpn4eQEl+RO03KPCnbBfCvORWgPvFwCJIE1pTqQzfALyOEhgc
	bUWcKGspc7xGQppRcbiRAvIAqDtP+9Khz+Eh5PyaKn8EiPCk+wbFzQjZB61WL/3neFvi60P/Rn6
	Y2y4WQG0kRoWrfHqeLiA3D78Ldb/0LA3cKYIelPNdV8xs4lPq7cSAhi5XAEYnJeF9wibIHgW7lV
	uJUCSThky+hYpesjN+26jIB+rPNJ6mPRp/9gOGCgkXoM0mjWK/oshqJ6m/1hNyZChBC6Vdr
X-Google-Smtp-Source: AGHT+IGt5Xr4ZrdGTGRgc+v8hXP75iAuD3iY3kyvw2yCrut7mjnj4SL6G2vG7EJad+ARbh1l/AgRkw==
X-Received: by 2002:a05:6a20:12cc:b0:1d9:2705:699e with SMTP id adf61e73a8af0-1e5e044ea31mr94166315637.7.1736222869591;
        Mon, 06 Jan 2025 20:07:49 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-92587c62eacsm11698726a12.21.2025.01.06.20.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 20:07:48 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 06 Jan 2025 20:07:32 -0800
Subject: [PATCH v3 1/3] perf: Add PERF_EVENT_IOC_INC_EVENT_LIMIT
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250106-perf_set_event_limit-v3-1-dbde0e90ddde@rivosinc.com>
References: <20250106-perf_set_event_limit-v3-0-dbde0e90ddde@rivosinc.com>
In-Reply-To: <20250106-perf_set_event_limit-v3-0-dbde0e90ddde@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Atish Patra <atishp@rivosinc.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5343; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=3MPuBqEVBmCpQhxI/FOWLYc7igp3KxmQR/V7e/nsaE4=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3rNionxVnFMdV5vvs/IXPjHbv5D41MHPRKXFT3bxbO7O
 vbkuSU8HaUsDGIcDLJiiiw81xqYW+/olx0VLZsAM4eVCWQIAxenAEzErInhf0lAf/eKxWF+Nn+7
 rGdrtlbPXO77WyjgQHL5rSk2f49bPmP4Z876/FqZSfJ6LvaOn4EMadHT84sd9Y/uN/uQ335mI+s
 0TgA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

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
index cb99ec8c9e96f63c64eeeb4470c019d86bc6e50f..9b407d51818f59e1548f8936ec0bb185fc4d9f0c 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1147,7 +1147,7 @@ extern int perf_event_task_enable(void);
 
 extern void perf_pmu_resched(struct pmu *pmu);
 
-extern int perf_event_refresh(struct perf_event *event, int refresh);
+extern int perf_event_refresh(struct perf_event *event, int refresh, bool enable);
 extern void perf_event_update_userpage(struct perf_event *event);
 extern int perf_event_release_kernel(struct perf_event *event);
 extern struct perf_event *
@@ -1835,7 +1835,7 @@ static inline int perf_event_read_local(struct perf_event *event, u64 *value,
 static inline void perf_event_print_debug(void)				{ }
 static inline int perf_event_task_disable(void)				{ return -EINVAL; }
 static inline int perf_event_task_enable(void)				{ return -EINVAL; }
-static inline int perf_event_refresh(struct perf_event *event, int refresh)
+static inline int perf_event_refresh(struct perf_event *event, int refresh, bool enable)
 {
 	return -EINVAL;
 }
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 0524d541d4e3d50150da03186467382bc60bdf50..5eeccd57078c95f08f6ac401b1e38c2e84e86d9a 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -569,6 +569,7 @@ struct perf_event_query_bpf {
 #define PERF_EVENT_IOC_PAUSE_OUTPUT		_IOW('$', 9, __u32)
 #define PERF_EVENT_IOC_QUERY_BPF		_IOWR('$', 10, struct perf_event_query_bpf *)
 #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES	_IOW('$', 11, struct perf_event_attr *)
+#define PERF_EVENT_IOC_INC_EVENT_LIMIT		_IO ('$', 12)
 
 enum perf_event_ioc_flags {
 	PERF_IOC_FLAG_GROUP		= 1U << 0,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 065f9188b44a0d8ee66cc76314ae247dbe45cb57..6514065513ba01e99c88854f3947a114562e81ad 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3210,7 +3210,7 @@ void perf_event_addr_filters_sync(struct perf_event *event)
 }
 EXPORT_SYMBOL_GPL(perf_event_addr_filters_sync);
 
-static int _perf_event_refresh(struct perf_event *event, int refresh)
+static int _perf_event_refresh(struct perf_event *event, int refresh, bool enable)
 {
 	/*
 	 * not supported on inherited events
@@ -3219,7 +3219,8 @@ static int _perf_event_refresh(struct perf_event *event, int refresh)
 		return -EINVAL;
 
 	atomic_add(refresh, &event->event_limit);
-	_perf_event_enable(event);
+	if (enable)
+		_perf_event_enable(event);
 
 	return 0;
 }
@@ -3227,13 +3228,13 @@ static int _perf_event_refresh(struct perf_event *event, int refresh)
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
@@ -6019,7 +6020,7 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
 		break;
 
 	case PERF_EVENT_IOC_REFRESH:
-		return _perf_event_refresh(event, arg);
+		return _perf_event_refresh(event, arg, true);
 
 	case PERF_EVENT_IOC_PERIOD:
 	{
@@ -6099,6 +6100,10 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
 
 		return perf_event_modify_attr(event,  &new_attr);
 	}
+
+	case PERF_EVENT_IOC_INC_EVENT_LIMIT:
+		return _perf_event_refresh(event, arg, false);
+
 	default:
 		return -ENOTTY;
 	}
@@ -6820,7 +6825,7 @@ void perf_event_wakeup(struct perf_event *event)
 	ring_buffer_wakeup(event);
 
 	if (event->pending_kill) {
-		kill_fasync(perf_event_fasync(event), SIGIO, event->pending_kill);
+		kill_fasync(perf_event_fasync(event), SIGTRAP, event->pending_kill);
 		event->pending_kill = 0;
 	}
 }
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 0524d541d4e3d50150da03186467382bc60bdf50..5eeccd57078c95f08f6ac401b1e38c2e84e86d9a 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -569,6 +569,7 @@ struct perf_event_query_bpf {
 #define PERF_EVENT_IOC_PAUSE_OUTPUT		_IOW('$', 9, __u32)
 #define PERF_EVENT_IOC_QUERY_BPF		_IOWR('$', 10, struct perf_event_query_bpf *)
 #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES	_IOW('$', 11, struct perf_event_attr *)
+#define PERF_EVENT_IOC_INC_EVENT_LIMIT		_IO ('$', 12)
 
 enum perf_event_ioc_flags {
 	PERF_IOC_FLAG_GROUP		= 1U << 0,

-- 
2.34.1

