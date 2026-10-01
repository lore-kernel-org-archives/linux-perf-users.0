Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D595351AFF8
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Oct 2026 14:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790864499; cv=none; b=SVeQ0qI1jZlINcBsSrXyFGnCEC1Dx6kTNVkDfmHG99nCSChmh2nAo7S/2XsAmuKLPiR3KN8M5cJfb/a4oBEbI0BH2URg78EO7E8XJ0PsaiUGdMZhYMoXz/Q4a1v6P1T+8HHyPT0iNRBz/v3VSsNaXDZX7SW4XiJIKB7XV/J4ajs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790864499; c=relaxed/simple;
	bh=n0cgsO9T0aWAUHgU6i5/oUZCDpuLAw/MjEqJwe2CU2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lL+FBB75Rl8mDzqFAybBZtwDOW7iQcQn9jTmgVCXGLjfSCsWAPN7d5tC2/zciAZGFyzzAtdq+tXXa8okwYns3IaRgRBz0o3JRd8AomVOIAuWlq+Fibi3m/Q4Q0Jh0oajEEKbIzT4oBAhAUTg167x4rmCc24SpTnWMKwoUbrvFH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AuxVfQzF; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AuxVfQzF"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffb83bf7aso44053695e9.2
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Oct 2026 07:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790864496; x=1791469296; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m/XzKic3mIkTxbK/Zld2/LgmkZ+m7jvrTtGlJe2zmg8=;
        b=AuxVfQzFFvCiAo8nv35+gbCN+jcwRReCKsdVNphD64gwx9GuA7yontWyaQCyGBZvCf
         PIA67Y2BFRFzuRof2UKQ4mpkJ8TX0m9xrCCb0R58YnpTi0RhInlbAVzNCw3a1HRB/ETX
         lqi8sIAWPhn8meEXZKYnUh5RRVqalqRhjudpavefwamWXVA5GXQRpC9JmE4m3M+nylSB
         MgZKzDtD8eEGgiszUODjCceOb4GTOTR+XxUqoQfa0MKDjl90SHr86yF14IS2q4CZY9uz
         WL9deHtfkuY3jxEqOZMSqxwnVVdpOZSapv0v4GCLN5yagtMIjAquXDru2BFniMnH+L44
         bVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790864496; x=1791469296;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m/XzKic3mIkTxbK/Zld2/LgmkZ+m7jvrTtGlJe2zmg8=;
        b=bzioBfPj7Qth/+B8Us4q2w1bKmF5kIc3335gFIfV1pEyTIoVFWGD6IW2nc0OvUA5nO
         UdUivA18FIGs+I68byextgmhCrUvMJ5OSIeuuPQLe6DSOG/aFBZSWgnx82WpbUWsTm99
         hrnMidjqsgtkWfB3l4zaRFd26QVgRVeNxeIkbFBO8V9kJG50Qlsr0X8w0R7cssDY50Rd
         OB+EtFdC4D8cm5TTjhCWGkpjtJ0p6a2ytH1c8MfKI/ug6UdxJ8+4rip+Hz0r34P3Iqh6
         WErrYaFgHWKvmTb+EyC9BcvKxS/M35NfK2C2dq9b7d9SAwvjXAuUhpkBbSX4RYHjS+5U
         fDPQ==
X-Gm-Message-State: AFuF++mLgHZ2gzjikx9y8ujlKcVPIPELsUUq/M5M2dk5/q+b3rNhTkOK
	NTfoUx1OtToi1sPjJat1YVnCA3lrQbr23w/PCq1Zlt3jxvmBB0OAOP3qhLdLLFUHbV8=
X-Gm-Gg: AYBFou3cRGhEHQgiImcP0Hu3EwZltN6x+wtGhZw4CvJPCegnXVB77CTzAmMcpoWDAmV
	pNVZsRPH0kLMf0OZRvDjwRj2stVciM3g7cKkJjDyHPbM8JDe0VT9BuJGHnEHV0wUjzCraVDeiHy
	I1uowhyHug5w9w5jx+ecD+gcFbbz0zLL5f2x8MsvorGFTfBPloZISRK3QY5S4Wcxu2p10Q0kJRd
	+c97UIaDFeCQkuhi2stzp52c+eNeZ2xuKjqB0g2pGaKmxdAaRzNn8jqf6eyQ67WjURIhqQw4pQL
	3+RbdoaAMOUVeBHz3+K/Dp+LGqF2ZHROxrZZY9WvuBiv3h4DY6hoaOJQeRBpl/dnu69dc+nsTHo
	Z73R/E/5NBQnxZuImelyu6q0lNdaxBrB+snMcmrPhydzZ4ZJlkc9SU2LOySzUg+3su2zZvmczs4
	/m2cAyqTla6dFqmTadQRMRywDL6BVvjlxoRbVThVUaKdh4FcooGTXH9lQouFR/lUxZOCQHh5vyM
	Q==
X-Received: by 2002:a05:600c:6206:b0:49f:eddb:bcb1 with SMTP id 5b1f17b1804b1-4a01b11cb33mr86968865e9.25.1790864495929;
        Thu, 01 Oct 2026 07:21:35 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a020f7f1c2sm34783975e9.2.2026.10.01.07.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 07:21:35 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 01 Oct 2026 15:21:16 +0100
Subject: [PATCH 2/2] coresight: Retry failed HW_ID writes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-james-cs-retry-hw_id-v1-2-4d45ab46cde7@linaro.org>
References: <20261001-james-cs-retry-hw_id-v1-0-4d45ab46cde7@linaro.org>
In-Reply-To: <20261001-james-cs-retry-hw_id-v1-0-4d45ab46cde7@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>, 
 Leo Yan <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

Don't set the aux_hwid_done bit when writes fail so that it can be
retried later if the ring buffer was full. Add a second attempt on stop,
which will always succeed if the stop's AUX output also has enough space
to be written. If there is no AUX record then there will be no decoding,
so the missing HW_ID isn't important.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 50 +++++++++++++++---------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 09b21a711a87..9238a12628fb 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -536,6 +536,31 @@ static int etm_event_resume(struct coresight_path *path)
 	return ret;
 }
 
+static void etm_output_hw_id(struct perf_event *event,
+			     struct etm_event_data *event_data,
+			     struct coresight_path *path,
+			     struct coresight_device *sink)
+{
+	int cpu = smp_processor_id();
+	u64 hw_id;
+
+	/*
+	 * output cpu / trace ID in perf record, once for the lifetime
+	 * of the event.
+	 */
+	if (!cpumask_test_cpu(cpu, &event_data->aux_hwid_done)) {
+		hw_id = FIELD_PREP(CS_AUX_HW_ID_MAJOR_VERSION_MASK,
+				CS_AUX_HW_ID_MAJOR_VERSION);
+		hw_id |= FIELD_PREP(CS_AUX_HW_ID_MINOR_VERSION_MASK,
+				CS_AUX_HW_ID_MINOR_VERSION);
+		hw_id |= FIELD_PREP(CS_AUX_HW_ID_TRACE_ID_MASK, path->trace_id);
+		hw_id |= FIELD_PREP(CS_AUX_HW_ID_SINK_ID_MASK, coresight_get_sink_id(sink));
+
+		if (!perf_report_aux_output_id(event, hw_id))
+			cpumask_set_cpu(cpu, &event_data->aux_hwid_done);
+	}
+}
+
 static void etm_event_start(struct perf_event *event, int flags)
 {
 	int cpu = smp_processor_id();
@@ -544,7 +569,6 @@ static void etm_event_start(struct perf_event *event, int flags)
 	struct perf_output_handle *handle = &ctxt->handle;
 	struct coresight_device *source, *sink;
 	struct coresight_path *path;
-	u64 hw_id;
 
 	if (flags & PERF_EF_RESUME) {
 		path = etm_event_get_ctxt_path(ctxt);
@@ -596,22 +620,7 @@ static void etm_event_start(struct perf_event *event, int flags)
 	if (coresight_enable_source(source, event, CS_MODE_PERF, path))
 		goto fail_disable_path;
 
-	/*
-	 * output cpu / trace ID in perf record, once for the lifetime
-	 * of the event.
-	 */
-	if (!cpumask_test_cpu(cpu, &event_data->aux_hwid_done)) {
-		cpumask_set_cpu(cpu, &event_data->aux_hwid_done);
-
-		hw_id = FIELD_PREP(CS_AUX_HW_ID_MAJOR_VERSION_MASK,
-				CS_AUX_HW_ID_MAJOR_VERSION);
-		hw_id |= FIELD_PREP(CS_AUX_HW_ID_MINOR_VERSION_MASK,
-				CS_AUX_HW_ID_MINOR_VERSION);
-		hw_id |= FIELD_PREP(CS_AUX_HW_ID_TRACE_ID_MASK, path->trace_id);
-		hw_id |= FIELD_PREP(CS_AUX_HW_ID_SINK_ID_MASK, coresight_get_sink_id(sink));
-
-		perf_report_aux_output_id(event, hw_id);
-	}
+	etm_output_hw_id(event, event_data, path, sink);
 
 out:
 	/* Tell the perf core the event is alive */
@@ -679,6 +688,7 @@ static void etm_event_pause(struct coresight_path *path,
 		if (!size)
 			return;
 
+		etm_output_hw_id(event, event_data, path, sink);
 		perf_aux_output_end(handle, size);
 		perf_aux_output_begin(handle, event);
 	} else {
@@ -769,10 +779,12 @@ static void etm_event_stop(struct perf_event *event, int mode)
 		 * But we should never get a non-zero size with
 		 * an invalid handle.
 		 */
-		if (READ_ONCE(handle->event))
+		if (READ_ONCE(handle->event)) {
+			etm_output_hw_id(event, event_data, path, sink);
 			perf_aux_output_end(handle, size);
-		else
+		} else {
 			WARN_ON(size);
+		}
 	}
 
 	/* Disabling the path make its elements available to other sessions */

-- 
2.43.0

