Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232D01C54AA
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Mar 2025 13:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096218; cv=none; b=GSuI2GA31V5ulr8cTHaINyH2uJ+GPKlYSa1z/79nEqrHYtrh1hYX43hBsrvJ/JhJBmpDrQtfVP/ZKFimG0Bmy8HKprF33bj3Cwh37Gb9gVriJyXolofpZznFhs1aGPhpLk20LZsouWFZg54SyJzPteEyuIMNmg6nLdh0oMoYSxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096218; c=relaxed/simple;
	bh=fotnUl6mFVw6Lu0WmVlkseT+Ib5u0hL9bJOrBpjvm3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UoWQwdkwzLM9lJl/QRxduOJEENuo/5l26k+B8tcIyVJGyby328IQROqFbFSVVFhgc+Z5SpV4kWwf02sVLwrVlLJhJs0JX2CpoTyupBgDDCjpwnvQd4Mp+LekfT7Fb+vwYARF5M5h5PzNazrOL22pSHAu7g8XrDd5/mUMHny9YdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MgoUqlXl; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MgoUqlXl"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-390f5556579so2237220f8f.1
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Mar 2025 05:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741096215; x=1741701015; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oyc+dQeRJPZgGXdSbanHL1FEsriyRzJPurWdjKL7aTU=;
        b=MgoUqlXlA24ZC4OtijXioBT2X6yZ/uiWw8LkanFnRiBomSeTX+wc0soGJkbbl7YxrL
         tVXkajRqwTWALbvu4xxC5wk8jVn7jY8/s+uZjWYoqBPhMN4gP5qR6u0JlVkVDa203BGG
         LonKvRWFuXt8el74b+jwMChuvpyTyCgCfymBPi309bhpyzd956linHwmHmOjrx/Dr6Rk
         B3tRPMTjhJHfrPvWw5XATVp+WkV0jIMA449HWjxD/xg7oCw3M64JfJ6aMNU+miZmZRjK
         D+zC+KHYUCZyDJeXnj8rDxljP1KvbluMQsOOiywvJQ/5jiHumdTI65i+lSjrI//OFI7u
         J/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741096215; x=1741701015;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oyc+dQeRJPZgGXdSbanHL1FEsriyRzJPurWdjKL7aTU=;
        b=DhyT1Bv+2Gy//UuGkbR6FGH8mp0BJlFHPuhshFLLKIKa389qc3Z0KBPxOVljjLiXRP
         s/WCl30mzXgSzUkKBxtecfL79rxXB71dfHvgM7VpmbeebunRTmwbNHZD+Icb6Sm5OQVW
         5pWf6yqNq2w7Oiu/2SR1P4njZxK8TqHTVzJb45TNp59f1gOuC1DnwQQ1TOVhp80ThHNP
         d0Xhc4WcnmHGTq1xJTM4guVFFr6Y7+PQdSed6g7vxNCGa0sK6z3Eju3djkOZZCOhmeC0
         YavmZzxGOEOBHF8ozGNfteb6XAC8HlrrZsaQMtBduGQ/dYpRWV+9toSHeWKWvXW8BuiB
         f75Q==
X-Gm-Message-State: AOJu0YxC/RHVx5UZuRGjM4jTKvKpSZawl58wRS7R1tGo9Y3G++DkZn8s
	UhYB4DmEIbAtbPesADIA+AIJDbQKDX7XPWj/dnL1udt4j8mNKquJ24NHljmfdIZUwJABklzTTKX
	Jonk=
X-Gm-Gg: ASbGncvvyoegk2rfNIjW8gtGInSB59Yfq5VHQhbT3jy/kSrwQEN8V4sshnbTcwhgnid
	SWPw/TQ6tNON79h5mCMdSEiChOoJyRI8c8Ia7XAZOJkJeUZZ+HB45CqdVhrbBuHM6KdBS/QLbjO
	ZdOacBJaOcQuSV0jfZzwJDA+fJEgxOAVH5NwSaiUeugFN8gCOD1C1pwEo14tC5CCapf+ZaOyp9i
	6AZ/JxZ/lG4kbrN2kkFrcQcnm6bU1ntrKV1R3URCVdHmWe+xEvljj4sy4XpRj2UsVO0/kcKdAMr
	rlhj0oxUWuSAkp+8a4fNtT1kJx93H4IsOVqB3kr7EBpdoA9V
X-Google-Smtp-Source: AGHT+IEuxLuB2VKvMIgoNJYYZcq8eunqDiuuEPPOKwodqE83YBs5enQUed7C/k5mduwZC+ZQXinvcg==
X-Received: by 2002:a5d:5f84:0:b0:38f:28dc:db58 with SMTP id ffacd0b85a97d-390ec7c70fcmr15776645f8f.10.1741096215355;
        Tue, 04 Mar 2025 05:50:15 -0800 (PST)
Received: from pop-os.lan ([209.198.129.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7cf2sm18096697f8f.59.2025.03.04.05.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 05:50:14 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Tue, 04 Mar 2025 13:49:13 +0000
Subject: [PATCH 1/3] perf list: Order events by event name before PMU name
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-james-perf-hybrid-list-v1-1-a363ffac283c@linaro.org>
References: <20250304-james-perf-hybrid-list-v1-0-a363ffac283c@linaro.org>
In-Reply-To: <20250304-james-perf-hybrid-list-v1-0-a363ffac283c@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Robin Murphy <robin.murphy@arm.com>, Leo Yan <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

In order to be able to show a single line for the same events on
different PMUs, they need to be grouped by event name. This is because
deduplication relies on similar items being adjacent in the list.

Even without the following changes this would arguably be better
grouping because it's easier to find events in a topic alphabetically
by name, rather than in separate PMU blocks.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/pmus.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index dd7c2ffdab38..4d60bac2d2b9 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -445,15 +445,15 @@ static int cmp_sevent(const void *a, const void *b)
 	if (a_iscpu != b_iscpu)
 		return a_iscpu ? -1 : 1;
 
-	/* Order by PMU name. */
-	if (as->pmu != bs->pmu) {
-		ret = strcmp(as->pmu_name ?: "", bs->pmu_name ?: "");
-		if (ret)
-			return ret;
-	}
-
 	/* Order by event name. */
-	return strcmp(as->name, bs->name);
+	ret = strcmp(as->name, bs->name);
+	if (ret)
+		return ret;
+
+	/* Order by PMU name. */
+	if (as->pmu == bs->pmu)
+		return 0;
+	return strcmp(as->pmu_name ?: "", bs->pmu_name ?: "");
 }
 
 static bool pmu_alias_is_duplicate(struct sevent *a, struct sevent *b)

-- 
2.34.1

