Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B493351B167
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Oct 2026 14:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790864499; cv=none; b=FAlp7mEiwo/1gFzSBjMK3sTOSLBnP5he1SF4VO8lkquvfrsNShSpZ6TYsPQKOQF+KMtwoSUAwVgZ6s7+tlvnlbxOK6QZr6WiPSDpyHHYx0dvKJKALkBHIq2pveTEG3WF5+fRlAmM/elCAGNsC8sC8M85mnW9lj1odFh8QRfYup8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790864499; c=relaxed/simple;
	bh=Yv/xmdpOF6BM35fDfDz6GZPVYeNpS2zgLO6H9ajzwFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lQaioeUfCnI4IYQJGAJZfA0mZsKNzQqmOariViaQrZvnx7md5d/Uy66xBzGeFsmxqCBK3dzNXzRlUakgqfhvrUA6P/9XqeZOyTKvq/PVK9fK1CG4PuZP5zHSuFNqyVWnaTIYIArvfTgavlXFLKAGHUkVuzYNnijb1iNccvb7KEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZP4It3B6; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZP4It3B6"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e69b9e16aso67950755e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Oct 2026 07:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790864495; x=1791469295; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K7TkIz3XcNZzBFScIUbNy9ytIHILZUanUufywGu/Sn8=;
        b=ZP4It3B6n7cocF6xxVG6pDYkmRZxScpI5O8tb30mURgQPt6+p2HkhxvCzdzVY5Nc2b
         9KbrpomBjwrjuykqP1AajM0EMPwJqOCffu0q67NwMBNxvZ+KnbtBkLiZlvw7SbDUSuQo
         V9ZfKF/3U5TAYKDurMf3U6U/IK3SP6Vu1NeuJtbiWG6FyNqZ4jzQGTf21DWNAbCHcRxH
         wvX7NtMl2EsW0kIa7KvEE+MAWlFbtw7UYiEcfxTq2Kyy/JvtXlv0DCs0eo6WOtmTJibc
         mB4Ss3wmNtDu+gG6YlM3F/adv1r3vwegg7oRlm0GPVJKA7uPTR32+lEnLH4pxET1U4Nu
         nXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790864495; x=1791469295;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K7TkIz3XcNZzBFScIUbNy9ytIHILZUanUufywGu/Sn8=;
        b=KyZIHgQ9GGDswyQn0wz6QrbaoBK7cvdJuo+9ij+7BoX1p0MENtzo3YTIK485sqy1uM
         6MnVmK6kpNznYXFkkSsNG8DOYY9ZhERX+4uHFO91FBR5+dKmR2ubF1fKScaVY0qWNFN/
         z3bZbD/pFBXSvyww/FZnBMh0Q9U43uRz89RPYLIRYqlQJXZXNJW/XkBiWjmC1rhBZv+l
         vV3HPjKEgWJSb5+XquUB1AWAP/nx9AjoU6K4jJKU7P0vB2wWSW5pSelE9ZzHnID/vVvH
         ozyx1a1EhS9gbJIqse1wP7WZFjXJMoUaFWlP8kOaP9qGM5EN21fHRsz7RrusDYrTo1QF
         cn6Q==
X-Gm-Message-State: AFuF++mNwhWQ/ytncums81vNyoLT2Eu2wJQrqxd1GCeiWrHoOZl3M2qq
	iUYZzliMJv8FcIWm5y9Rwc86VxZDnUusVH24+fgpI6lUl7ATMSWytlk1mzuh6SPUmfA=
X-Gm-Gg: AYBFou2yUuKBZpyhTeszPsjQSv5EDFYyX/K79fxcxq7VpI+GssBbCYwKgAM+PrBzGZr
	+6kBVn1ty4Nfqs0jBxyBMf2tE5A12NZ8t4QDCHMTPhN5/nyt6HqDSAoxNCKw7LpSDFe6RILi3Xp
	jK7Ji6yfAB8vOf+N5ZuCQfLsadZapZZsl5Q12O9XhphxlRBiCJ60VM5YCgbu+pLyCmkz8JR/M3Y
	2dVDnBw0wukoxlM12id1nZcQSg2vS7T2BteHxBlgfTbnU2/XzNXvUzZOveCTMkHfOoNO4AWntdN
	ZtBItqEWXIPWswcXedFAStwZKIr1iQHz9sc1vf3pMZcwZDuGcSUADQG7j9sP6TugllypVV5xMjr
	CwF3g6JhkY895PTygfakMTEU9qSgezLpbenecjRuOKvv/UoTQDEl5R3/rZt+Lp6HcRS8caYV3Dg
	eJ98B4yflyICdYzn/qqQ4v2HA4ms/7jWEomaVR75t3+TqoR2hK7Kn/x5pujd90CwZIQpsweaynk
	w==
X-Received: by 2002:a05:600c:638d:b0:4a0:21b9:a55c with SMTP id 5b1f17b1804b1-4a021b9a5f4mr42960425e9.29.1790864494791;
        Thu, 01 Oct 2026 07:21:34 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a020f7f1c2sm34783975e9.2.2026.10.01.07.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 07:21:34 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 01 Oct 2026 15:21:15 +0100
Subject: [PATCH 1/2] perf/core: Return errors from
 perf_report_aux_output_id()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-james-cs-retry-hw_id-v1-1-4d45ab46cde7@linaro.org>
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

It's useful to know if this failed or not so a retry can be attempted
later. Return the error code or success.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 include/linux/perf_event.h | 2 +-
 kernel/events/core.c       | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 48d851fbd8ea..01d318a4de50 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1896,7 +1896,7 @@ static inline struct fasync_struct **perf_event_fasync(struct perf_event *event)
 }
 
 extern void perf_event_addr_filters_sync(struct perf_event *event);
-extern void perf_report_aux_output_id(struct perf_event *event, u64 hw_id);
+extern int perf_report_aux_output_id(struct perf_event *event, u64 hw_id);
 
 extern int perf_output_begin(struct perf_output_handle *handle,
 			     struct perf_sample_data *data,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index d7f3e2c2ecb1..232da3b6f393 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10563,7 +10563,7 @@ static void perf_log_itrace_start(struct perf_event *event)
 	perf_output_end(&handle);
 }
 
-void perf_report_aux_output_id(struct perf_event *event, u64 hw_id)
+int perf_report_aux_output_id(struct perf_event *event, u64 hw_id)
 {
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
@@ -10585,12 +10585,14 @@ void perf_report_aux_output_id(struct perf_event *event, u64 hw_id)
 	ret = perf_output_begin(&handle, &sample, event, rec.header.size);
 
 	if (ret)
-		return;
+		return ret;
 
 	perf_output_put(&handle, rec);
 	perf_event__output_id_sample(event, &handle, &sample);
 
 	perf_output_end(&handle);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(perf_report_aux_output_id);
 

-- 
2.43.0

