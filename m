Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8044B203714
	for <linux-perf-users@vger.kernel.org>; Tue, 12 Nov 2024 16:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427283; cv=none; b=rY5kKbqS2ce2cr2T37I3st2G+Sy3ftv+3O8BBu3d3oGqkziXqYkzsb23m2wvfK51ivv8WiK04ZVb9GUaMvK+xbvgbx1eS3eRvUNX8h/FUxXQVfHEbGspKhe521MtGJQETnZPWQ7v/UMl+rZ257BHpjvjSU9EAzFTh+mnqtPJFGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427283; c=relaxed/simple;
	bh=X11z4nP5ntnwRF1ZolXpN7FUrcu0tKB9xT6gGdibvic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gd0NR2owaYfQOJaLcNTckH+cWtggwzkDHXqUnVnGWnS4U/0fMOg6mkYbtP4HJZReRWyr0A9tXrAZHJ01hSUleNV4f2xNVUizvJq+Qn2zVye9kIQQLkzJWZT134Qlqd+upu94cdxfn5EAKci3q5lurzTmsGYYxRklr+vXDTrZdZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pCfGX1eF; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pCfGX1eF"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539ebb5a20aso6447327e87.2
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Nov 2024 08:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731427280; x=1732032080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGPOgTfEx0zJge0MarOgxWQ/d+55clu7muVrKzy61Ic=;
        b=pCfGX1eFWD8Y995zSqxy9F/Hdu9tNUCDIt4ufs/icWCfyvkw3WjrVJhgmpRii70THx
         NVfjkZrbcIYDxJmtBdAktXeMurxe0DOXHPXNQD9LiVqhXDa+j+AQKQb+tLj4ElgZsP4v
         P2Zabv9DhDx/pXl072/JqGTOAFI7oq+K39U30+dV6BZ5CxnCjBrGR/17n/4nyA2C/kyS
         yFkfDOMHjCBGM1+coNFWYMUbXMIqTMvz1Q9C/C/zeeWHZsRFIVxetkAe+Vt92GRJRKJU
         mnx6sBM/KWb8jeqj6Kzt5eyKrlDFsHx6QqJtzUUcQr+YKEv5ycCZJuXdU7RRmeitzRhx
         KFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731427280; x=1732032080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NGPOgTfEx0zJge0MarOgxWQ/d+55clu7muVrKzy61Ic=;
        b=c0ixvWYCxgk8ER1jvnSvzErb60Ek9vELRGMaJgM4bvgozZiromnWoRGk44xTUCsaJ0
         3R3zDF5adtRk/SxWN10zdPGmyKnLBqoawa496krGv8tUX01yeJ12L6uX73MIFlCBH2j6
         0WaVFaoEuzl1uhtuJs2hGqLWMS4PNm34UZVPmlX1crBKxbNc3mSjqp793HLXTDEDto6d
         xjMmtcMlnaTZpsY71oLTrqdSME6NQ4Rg+N0xK8l73X3G1g+VkMIgqxOT+nudHHe9ijtr
         GjY1OCCw+psWPSHOENQCANtTNzKDZWJHnYAkGM6aZJLYlI497m4gR01ogxQDdG81ly8M
         fZTQ==
X-Gm-Message-State: AOJu0YyuV+nqfHOFHkBE/mG/OxCPX6zBxwMfK10BjsxPA25mwhKZRdA4
	KT0rRToj4vjDiywhvuIYxfUcMXE8xo/I3As3/aYqOqD4jVgLAebU0TnRCDBNTNWXUwK0QY9nqxu
	0z6c=
X-Google-Smtp-Source: AGHT+IEdng9Cf3uldN4S+XjdS7jJypPc3Cm092Iw1cAx9FuZf73d96gc+rFbb9O++UlTz/UpP50Bzw==
X-Received: by 2002:a05:6512:3a82:b0:539:918c:5124 with SMTP id 2adb3069b0e04-53d862e3283mr8220628e87.31.1731427278787;
        Tue, 12 Nov 2024 08:01:18 -0800 (PST)
Received: from pop-os.. ([145.224.90.214])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03bb760fsm6148172a12.47.2024.11.12.08.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 08:01:17 -0800 (PST)
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
Subject: [PATCH v3 2/5] perf stat: Also hide metric-units from JSON when event didn't run
Date: Tue, 12 Nov 2024 16:00:42 +0000
Message-Id: <20241112160048.951213-3-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112160048.951213-1-james.clark@linaro.org>
References: <20241112160048.951213-1-james.clark@linaro.org>
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

Reviewed-by: Ian Rogers <irogers@google.com>
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

