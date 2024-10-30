Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3C81E5733
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Oct 2024 11:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730288412; cv=none; b=ADhtEKN2LPGEPGTjPtumZDPU9CiQhKqBuDHaQ4Nrn/CBgq/Y9FAcodCPvyFyiDoPJSMiWns7HSlqRvHRjv9nJcn6MYK6pdtAIe6rJWNfyw8Bct91vjOqmfjtOGEfm0Q7ArLYmY8aloPAC5N3rrbdkFhfHy9+W0FeRRjH3DfethA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730288412; c=relaxed/simple;
	bh=d/FHF8pJ8v0slueq+fAHV3I8duIMdYBFQu9B+exFmco=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bQ+1RMKFt4NwuzbTOiSCSqrMWAGZSzSwK9C6CthOzjJyOgfpVnjg7lFwSgkp2OPKupYsuIxbEYRqfwZ+iNygrGi2KZ3g6XKUqtKlhAJtXJTAvkeY41WKsWsc1bG0q6XHV4TM0W6V+MVjWITIrs5+aW+xXb18NxrnRhLki0Y9IEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nm4V7vkq; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nm4V7vkq"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43161e7bb25so60539345e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Oct 2024 04:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730288408; x=1730893208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyDWS+jYpYGuwqnSKV2ManTocBtmYRodTmjKi3UEELA=;
        b=nm4V7vkqz/KJ6faF5PW3ZmtpqNhqdp0KxWbsUharSrDJiGeaPP0IfHlbrKp40UOXtv
         amB3CzDtEZz/nNdxzX3EItE2ABeULfnS6gmbvwsO0BgVjP8RKsSZN0iaE/sax51QPsxG
         DmlC5fJlgYdn78sXXSsXxvsvAX6vMvaFx0TrD0cKWkm5Eng7lA1mFK65oof4sxKFQOm6
         sElAINEeBXTMCxnRZ7KEuyC8CehNG5oRGB6QJDMJ7zabJhEIEqA6Sz8NGCJ3U7opAxpF
         C6o4O08IDGpsS1V4AkEri4TiliwmBtv0L88m4GuLkEGWk7pVxpheybalkmUhfsg3um5B
         7CxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730288408; x=1730893208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VyDWS+jYpYGuwqnSKV2ManTocBtmYRodTmjKi3UEELA=;
        b=L+gp96Wt4ZIhbSlY7cOjN8v9iSpAmtzCmyM70Vl8j6oL2zFdFOOXmR347aepmSeJUe
         QEYe7N9cFCXsBr/AjRtyHn4RfHDqvYBpzndW7UjWpcY1/y3PHK7etEQs10o2XixT44Es
         uk/eXxzjCD1ZhNKcRSW7nlve2rayPCqrGPzyMT3gg+sMBl8FFTZRKhvuk9kl3uth0sFN
         eeKBOQJZAewiGzBBhWnMJIWnGooYw0/EQqAzf99bvel9l2SQHowDkVsDS7fvyb+W9aXc
         s8ISBQbIDZ0LQdoCFCnWMspWDrI1G5Q0uvL7nfUXEBQ/GT3EQ/8KujmJ3QucFmoL2/RD
         EhqA==
X-Gm-Message-State: AOJu0YxmsG5PMzysOJQ273ypjgGjo/wotviSUYgFG+ivqHPqz3X+lxFU
	lQdhC63nuW3Sluqr8CGb7WBEv67mwa7etjEAs3JsJTVeIa2RVvNPxN4MvT3G07NrqjIlIIvhtiT
	KHRw=
X-Google-Smtp-Source: AGHT+IG/EGxoba9efCvi8ShRo05h9yQcITPDgjVaGxzgq1DBbWgIiEyF8Y+mPbCexVOuxUXoAhkQdg==
X-Received: by 2002:a05:600c:1f82:b0:430:57f2:bae2 with SMTP id 5b1f17b1804b1-431bb9d14afmr21602635e9.23.1730288408266;
        Wed, 30 Oct 2024 04:40:08 -0700 (PDT)
Received: from pop-os.. ([145.224.65.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9ca6f8sm18885045e9.39.2024.10.30.04.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 04:40:07 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	tim.c.chen@linux.intel.com
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] perf stat: Also hide metric-units from JSON when event didn't run
Date: Wed, 30 Oct 2024 11:39:45 +0000
Message-Id: <20241030113946.229361-3-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241030113946.229361-1-james.clark@linaro.org>
References: <20241030113946.229361-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We decided to hide NULL metric-units rather than showing it as "(null)"
when a dependent event for a metric doesn't exist. But on hybrid systems
if the process doesn't hit a PMU you get an empty string metric unit
instead. To make it consistent change all empty strings to NULL.

Note that metric-threshold is already hidden in this case without this
change.

Where a process only runs on cpu_core and never hits cpu_atom:
Before:
 $ perf stat -j -- true
 ...
 {"counter-value" : "<not counted>", "unit" : "", "event" : "cpu_atom/branch-misses/", "event-runtime" : 0, "pcnt-running" : 0.00, "metric-value" : "0.000000", "metric-unit" : ""}
 {"counter-value" : "6326.000000", "unit" : "", "event" : "cpu_core/branch-misses/", "event-runtime" : 293786, "pcnt-running" : 100.00, "metric-value" : "3.553394", "metric-unit" : "of all branches", "metric-threshold" : "good"}
 ...

After:
 ...
 {"counter-value" : "<not counted>", "unit" : "", "event" : "cpu_atom/branch-misses/", "event-runtime" : 0, "pcnt-running" : 0.00}
 {"counter-value" : "5778.000000", "unit" : "", "event" : "cpu_core/branch-misses/", "event-runtime" : 282240, "pcnt-running" : 100.00, "metric-value" : "3.226797", "metric-unit" : "of all branches", "metric-threshold" : "good"}
 ...

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/stat-display.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index a5d72f4a515c..0e16eecfbad8 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -854,7 +854,8 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 
 	if (run == 0 || ena == 0 || counter->counts->scaled == -1) {
 		if (config->metric_only) {
-			pm(config, os, METRIC_THRESHOLD_UNKNOWN, "", "", 0);
+			pm(config, os, METRIC_THRESHOLD_UNKNOWN, /*format=*/NULL,
+			   /*unit=*/NULL, /*val=*/0);
 			return;
 		}
 
@@ -909,7 +910,7 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 			perf_stat__print_shadow_stats(config, counter, uval, aggr_idx,
 						      &out, &config->metric_events);
 	} else {
-		pm(config, os, METRIC_THRESHOLD_UNKNOWN, /*format=*/NULL, /*unit=*/"", /*val=*/0);
+		pm(config, os, METRIC_THRESHOLD_UNKNOWN, /*format=*/NULL, /*unit=*/NULL, /*val=*/0);
 	}
 
 	if (!config->metric_only) {
-- 
2.34.1

