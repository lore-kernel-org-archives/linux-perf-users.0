Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E31471CF3
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 09:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787305863; cv=none; b=HS5RoaM3wrZEjy3TiczE8lBKS8+OY2KwdQ1p5vs05WQBq3FOi9vWdJqRk9Bgdi76bwaQlMJUTg8k2ccbPZq8f2ENUyiY2B76FCCVSVou40M1lPlxhq4dX9puFaujMHEPc7JSTj++/3d481EuMvMtXjWjaB8hM5NJ4pQHQIDWBjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787305863; c=relaxed/simple;
	bh=nzEQ8JU4JoYYnPRoIwkN2IQxvscqWNK64xxNJksGgsU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S+ctVHNDubtZ6mU3zI1OR4Ts3vk03AYZmOUABMpRDUUga+5FzufD5BYA9er8STjGAhY9SpaOtiXFiO+c5BwzQKuAINh9rERMeb2sKBW+xyC38FMxbpLTMhT+I2BYOIsDpq+TYrkiIxc5FFzq53IvJMoXnj+J4wWBY1h+BrxPaww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HcRS+fJr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HcRS+fJr"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4998590d392so6810905e9.0
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 02:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787305849; x=1787910649; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=05DUnskBW8qYusWX8ek9jHQJpSgnNnSpmQtWmqnHEBs=;
        b=HcRS+fJr8RFiwCfd6JUcPYsqUHHbircLmB19fWIRKkLj+mhCcu+Vbs9+UlF6zRUGq+
         +6IqMPEM0J+7WcewkGkXLXvGXhAHWmds8byDt7x5OkiVlQ7z9ZuTGqMWvKQYlV1K7kbQ
         F8lwwUhDHqOYGmbVSsURodZ4zFrdT2ozj48O6nI7HyvSfmJRPqhbN3CJFbKoop4KoBJT
         5bZAuCkUmpPXJ75ek7FXkH3R2hTxqoY2Gh+k89wy4wRQubl0Oll1FbFfWEJaTSlhA2Qf
         Hag1t5IiJ4/uuiDDyMO22XEIhuP6ifjEmdwPJF7y4JenU+ipa8KiuEDBzWUPmCO1GfQV
         lQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787305849; x=1787910649;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=05DUnskBW8qYusWX8ek9jHQJpSgnNnSpmQtWmqnHEBs=;
        b=bWQwkHgwYi2kcVqN0PVmB/q2eWI1TZ5Oi9kiyI6s32NEKvDQp2rOaSjyb7U3+mlJop
         ZdBCfErWOnBTuSWId0C8dos2G/6EOxC3gD5wLcFRK/ZTtxIR7DLT2uCc2Xy7NmnW1XCO
         2OMAQ1dzIOnWvkG0VRR4UCdSMYJG9Rsp/cnkYgeN4TU57dHmZkfc9/SdPL9NzcCEoMli
         cA3Tl+aBufvaQUjiyW7kzlkav+KfPxfdB0NDndkwihGGa/mUQikHBazF5RyqUAPwdaiB
         P3CmHDbXunK9rLDeB6CGOkqBkfHsNGb72pFCgpsN739IKL3TCW6iPVu8Nsx7Tio4VgBR
         pV7g==
X-Forwarded-Encrypted: i=1; AHgh+RrVMy1tGjolZJuZ8oDF+aS6CbPTLbiiSmYCzRujz4RyZ0zdN4xXqGv1SPr1jZ0OMntOXsY8KNcLXcfahJswszdu@vger.kernel.org
X-Gm-Message-State: AFuF++k4lyylLY01eL/6pNLSCDHjl2aeLVICqYOfghmhaih1TrSKikvp
	bH17tI7LK9ZXe6WQ4ywzf2k9ysT2s3yLKzG3i8OGnrBd7ptsBnE5no8j3y1zTA8qGV8=
X-Gm-Gg: AR+sD12TxV/tHh07YkeV+UKpbu/iXORHMrewdqjsVZRCnlE+sK04uwbiJhgyMBPUpl2
	hY8OHHlIHtLT8rlyZe6kFsO/8tuLeu+yZGxfFozv/ehk2o5QFZwlrr5gBX3KPMshphIzrdsa5oc
	Ha99HmBmeyEHhOir+QF5Ys6bEYf6jcQkNWcNQlZhFx12WLRZ9BS1DjcdJYTXizVHyaL65jeAFdx
	3uraClJbRMRhXvz+hyS5mCQbl9s7838A5m+M4ZI4ANi3tUUcAAmzSSRUfRWayCCNK6aCFYJdbr6
	risCsIYKMOhghfqhIg2DGz8KSch9/Rq1dv6MuxMi/2fYvlxFi8BSuH5Tt9iVLNkO1XYTJllfBfo
	cbuYnxtBR/d9tCLP0uVtzajw/EOUb5OTdZj1bwSi6mBTeoj01Lz9cSjhbC+ODX3nv/PG7yay5Qi
	gKFW5BAB5ufaKQNR5CBOI5WdSEoOd+SbRa5McKKdPCeQmqbaOPCBS6SK1HZkulxlYM
X-Received: by 2002:a05:6000:4811:b0:47f:6f9e:1e82 with SMTP id ffacd0b85a97d-482c0b4ef34mr8274865f8f.9.1787305848760;
        Fri, 21 Aug 2026 02:50:48 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14c3775sm14474284f8f.26.2026.08.21.02.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 02:50:48 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 21 Aug 2026 10:50:34 +0100
Subject: [PATCH 6/6] coresight: perf: Retry failed HW_ID writes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-james-cs-hw_id-output-failure-v1-6-9d532ddabcc3@linaro.org>
References: <20260821-james-cs-hw_id-output-failure-v1-0-9d532ddabcc3@linaro.org>
In-Reply-To: <20260821-james-cs-hw_id-output-failure-v1-0-9d532ddabcc3@linaro.org>
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@linux.dev>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

Don't set the aux_hwid_done bit when writes fail so that it can be
retried later if the ring buffer was full.

Add a second attempt on stop in case this session only has one call
to start. Otherwise there is no chance to retry and it isn't fixed by
not setting aux_hwid_done.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 52 +++++++++++++++---------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 09b21a711a87..0ffc5cd9c88f 100644
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
@@ -630,7 +639,7 @@ static void etm_event_start(struct perf_event *event, int flags)
 	 */
 	if (READ_ONCE(handle->event)) {
 		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
-		perf_aux_output_end(handle, 0);
+		perf_aux_output_end(path->handle, 0);
 	}
 fail:
 	event->hw.state = PERF_HES_STOPPED;
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

