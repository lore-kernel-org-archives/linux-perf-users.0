Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D00241664
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Jul 2025 21:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752097238; cv=none; b=mEUx9rvgKYhKia8dyCEEyZ5v95a+tJ3zRKZMn8gp5wfVg4/Zos+mQqeCr4O9nFthVsPpMIfa/dbXLawyvwdvgmTepAPeyLjMlLR1gMQFNrHnmeulNMUDSyNBVoyjRwOnVqlzGkbVB3kyXHIHIpIK4WaV0uA6QrcGjXvuuUi9zCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752097238; c=relaxed/simple;
	bh=1lk85E3pggo+4g2GknSYWSWNs6o0Mw8jBXtuFvYNkFU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=id3p9/yLAoWX+F8fzsZrJ4gjFCDMpRBgiI8SkT3RpNzPR9PTf6nmr3QqGGNhJOa5MLU4/0MurDPbHmMvU8tZi4l7KRBdhBUXxpkCAtjkBzeo7uTFBAlCSTZLn79ayBOcf/69K+hR0FZFooAjxwql1yGKeyDgPaovoEgbG0eJRHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FScjL0Rs; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FScjL0Rs"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2c37558eccso329026a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Jul 2025 14:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752097235; x=1752702035; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1RNkMgAEj4/GnB7BeI8C0UUIpPaOTXLCNgb+45zsMxs=;
        b=FScjL0RsBI9fOqixWgw+s3e0+ZVU6uRoglAfNGTOq4KMPjaGwfvlvsO3bneN9Sg+Rs
         j6q+LX5Ds0EbGDcGfdcZqXXwQQo4/0Q+rBJqjt3hLjnFzpbWs0iE0E/6oCSqSQF/zAjm
         6tl976wwpI83zeobotT8tN+5t91xiVigcPGyAt2wRxXHeJt04PhRaN5nKhFx+nOGh5MA
         BYXDpDFt4cB1A9JTOCB2k3cGM6+9jmJmY/I3yyOIyJnpK59wsEAjnSW2CLGMf2TNtTga
         +j0cEU7uyN34aMcuf4ErsRIv8ywSMD+FeTYrioFJaMHeTmyOjbhAFlhdHTWzOlF2QdI0
         A/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752097235; x=1752702035;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1RNkMgAEj4/GnB7BeI8C0UUIpPaOTXLCNgb+45zsMxs=;
        b=mEjRmh+qBvXgABhjX6G83EHNyoSCsjqSSe6EVYr3mxvPfl11tiYXy1BrAJKE8/cwVZ
         XZcncJzUN6anTD/CzCbgWj/16FEs4ZdwfQV/HXBn+4yhxzBeupu7FLEXlDrvqSXqGlpa
         773EVrMqQ811JGsQvfxHAwxTtXLvyHnV9AGg72zafk9Fiqr8WnddQ++MF6ZCO2nZIZPJ
         ovehmCezMbXZsLITeYRieyRpuvuDpEpXKX4SPlIrWe8315RdMkz8sEcvb+x4cETzW9WZ
         IXHYtq3TCz+rBraAvd0Moie88g65L9hKW2FzdU4isC7Ltswcycggu+wOYPzL+5Icx0vM
         yZPg==
X-Forwarded-Encrypted: i=1; AJvYcCXJO7ErrLm84V8gnS7H2eaPdGmVEk6gOmpx1pZ13AJD3a5MRRtXQ0rfJoVU308fa/RdJUKbMCMa8pHBGE8gJgMQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxNVlZLdFPZUPEYAfBs2nY4doxhaZEXj2sOZQB01sxCcT6KaeCV
	I7BBJwgqiNmiQRIWvd1JUANsvCdnbGtxVknQ6Vd+DSK0Yj0vS0wFpA3/R6Z/cVSMz0nLE1SogvR
	r53uM+CT9BQ==
X-Google-Smtp-Source: AGHT+IH2bEm5D5vL0/SOlKgLMUnkYuyDxrvhEh8Sk1TmdRPm6c9OAhUY7JUi0TVyz5YNrku0Gkgejj3nrlBH
X-Received: from pgr1.prod.google.com ([2002:a63:1141:0:b0:b2f:a31c:f7bc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6e91:b0:215:efed:acfc
 with SMTP id adf61e73a8af0-22cd5a06069mr6978021637.7.1752097235636; Wed, 09
 Jul 2025 14:40:35 -0700 (PDT)
Date: Wed,  9 Jul 2025 14:40:18 -0700
In-Reply-To: <20250709214029.1769089-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709214029.1769089-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709214029.1769089-2-irogers@google.com>
Subject: [PATCH v1 01/12] perf hwmon_pmu: Avoid shortening hwmon PMU name
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Howard Chu <howardchu95@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Weilin Wang <weilin.wang@intel.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Long names like ucsi_source_psy_USBC000:001 when prefixed with hwmon_
exceed the buffer size and the last digit is lost. This causes
confusion with similar names like ucsi_source_psy_USBC000:002. Extend
the buffer size to avoid this.

Fixes: 53cc0b351ec9 ("perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysfs")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/hwmon_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
index 7edda010ba27..416dfea9ffff 100644
--- a/tools/perf/util/hwmon_pmu.c
+++ b/tools/perf/util/hwmon_pmu.c
@@ -345,7 +345,7 @@ static int hwmon_pmu__read_events(struct hwmon_pmu *pmu)
 struct perf_pmu *hwmon_pmu__new(struct list_head *pmus, const char *hwmon_dir,
 				const char *sysfs_name, const char *name)
 {
-	char buf[32];
+	char buf[64];
 	struct hwmon_pmu *hwm;
 	__u32 type = PERF_PMU_TYPE_HWMON_START + strtoul(sysfs_name + 5, NULL, 10);
 
-- 
2.50.0.727.gbf7dc18ff4-goog

