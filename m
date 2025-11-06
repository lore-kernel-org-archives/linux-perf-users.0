Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460C72DECAA
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Nov 2025 07:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762413171; cv=none; b=sP/3B3/oi2OWTBwr8DsuNL8/ZQ0HrE5ZdD067loYdTk3+oziggef8dWZfvow1e2z3zyDg8WlU4fAUPKC8jgKA0JZi8fP2UMNsz+AsMHUVw0WflPTaqTrzQScK5muVr20FR9MYbBF0gy3iLwvncKgex02mguI+XjwNvGCcCwlIeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762413171; c=relaxed/simple;
	bh=Kgo7sxJNHAVdmzHf5VuG0p/PQfK1697phqEp6Xwcyo0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Iu2h/SoBj+OIBDM3hU+fuTpQx21fTeOEoY3wyuKlGf2VbD4MncFwkMYI9IP9UsAXQVKvcs0v12yuAle0ZSijkbWK1ogIPzwTeTDNc68XCI95V7U52EDYVSX12ALF0JfzxfRMOM5gsJImAv8Jxk9egmd4GyWvB5dYJOmjmaP3FFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ulgRsk7Q; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ulgRsk7Q"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-ba265ee0e34so586019a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Nov 2025 23:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762413169; x=1763017969; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PLwg+2AiO3F/YfbdpvnrnBijRms/bsxixJsYS/jBPB8=;
        b=ulgRsk7Qfhwo3pqHcQt0YUie4GJdldVKv15mztbKz6tVQPiYtq3H35lPvDH0bQpNRH
         +qYR3Sb0AI8kyCjInUpdXq3Ah+IBJKs9BCAgRS6Daqkyzx+PvCqavALpG2XpicKo0lCl
         qW1odj2jRImhzj9nULKtxu4J3L44ZEj3DdAtYTrGJX/6Z31lYkKtoBRmIp4zUb7lQh7b
         /PcM14QbMcYvuqT0Y1v2zmHhWDPcgUXdh8lWyvA/NFMjj3hxL4UoTNx+0HZWTN7Yh7Kj
         4ckBNoJUyaf9tH+tzSeND1rLMArc4MGndqgX3FziTOxqm0KDR5Tksp5qNMxqN63ypjZc
         scmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762413169; x=1763017969;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PLwg+2AiO3F/YfbdpvnrnBijRms/bsxixJsYS/jBPB8=;
        b=lR0Hh+/a+TGsh5Fwa796i5JZQghJPAZ4BHJdYJ2kdagjAT5CIlzIcYehV5EWRgO8Dl
         +W2G5wXccVNqXj+c00/PUqrZhll0tWZoe+IBgpSd8jCOiuE2pfm0hUNw3Boe1dsrRgl4
         vUT0/n2ckb48opyCJcbB5ekT9hLEigdAjZJvNxjv3FbNUevYK8Iaq1XiK+De8XeZcamU
         yUOX4NBMCuq0m29/+T5wzneJszWlNNs9ukcfT0/xh80TNUXlL80VjihxZIr9M0sSTBsP
         IR6DpVwzF8i0H5ppQoyag3Hyxx7EK6ay/2wkfUdgwta8vJjaR+gGkInv1ZPeHxECHzd7
         Iwqw==
X-Forwarded-Encrypted: i=1; AJvYcCWPGEZ2zI8Vm6l7/onWGvFMUMI5VJIfGnO+k2gB8fcQNuXrLp1WEnteUd95wDpQ1KhgDGJ0+ksbwp3pZcy6hEjh@vger.kernel.org
X-Gm-Message-State: AOJu0YzociV+Tn3hfRwBLxCGjVRXCQ2nU4jA9lcan9cQn6ACHzqwDQCU
	XN5uqKOrgu7wWsT1Mjh3vbJG4j6iCVuYUY8WJc/n4jgEkaJt6mMRMe/H5RZ37EH8pXGZtRIHoT2
	QMS/hAYod5g==
X-Google-Smtp-Source: AGHT+IE0YX5vsYPKWDEQJBgQGJdnX5svKCKT5iKNi+LiQBs+q034F7/hs6Iv6PwLztjF2Ff/O7meufnROYpz
X-Received: from dlbsv11.prod.google.com ([2002:a05:7022:3a0b:b0:119:49ca:6b9f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:12c3:b0:2fb:2e04:eeae
 with SMTP id adf61e73a8af0-34f83d0f7d1mr7648612637.21.1762413169496; Wed, 05
 Nov 2025 23:12:49 -0800 (PST)
Date: Wed,  5 Nov 2025 23:12:33 -0800
In-Reply-To: <20251106071241.141234-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106071241.141234-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106071241.141234-3-irogers@google.com>
Subject: [PATCH v3 2/9] perf pmu: perf_cpu_map__new_int to avoid parsing a string
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Yang Li <yang.lee@linux.alibaba.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Prefer perf_cpu_map__new_int(0) to perf_cpu_map__new("0") as it avoids
strings parsing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/drm_pmu.c   | 2 +-
 tools/perf/util/hwmon_pmu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/drm_pmu.c b/tools/perf/util/drm_pmu.c
index 98d4d2b556d4..fc864bde4cb2 100644
--- a/tools/perf/util/drm_pmu.c
+++ b/tools/perf/util/drm_pmu.c
@@ -119,7 +119,7 @@ static struct drm_pmu *add_drm_pmu(struct list_head *pmus, char *line, size_t li
 		return NULL;
 	}
 
-	drm->pmu.cpus = perf_cpu_map__new("0");
+	drm->pmu.cpus = perf_cpu_map__new_int(0);
 	if (!drm->pmu.cpus) {
 		perf_pmu__delete(&drm->pmu);
 		return NULL;
diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
index 5c27256a220a..279d6b1a47f0 100644
--- a/tools/perf/util/hwmon_pmu.c
+++ b/tools/perf/util/hwmon_pmu.c
@@ -376,7 +376,7 @@ struct perf_pmu *hwmon_pmu__new(struct list_head *pmus, const char *hwmon_dir,
 		perf_pmu__delete(&hwm->pmu);
 		return NULL;
 	}
-	hwm->pmu.cpus = perf_cpu_map__new("0");
+	hwm->pmu.cpus = perf_cpu_map__new_int(0);
 	if (!hwm->pmu.cpus) {
 		perf_pmu__delete(&hwm->pmu);
 		return NULL;
-- 
2.51.2.1041.gc1ab5b90ca-goog

