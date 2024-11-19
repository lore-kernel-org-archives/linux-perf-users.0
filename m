Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A5B1D2715
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 23:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732057238; cv=none; b=Ouy71jnJCeRVFnt69GSD5aL/3iCDdplNquZWt08y9PKwb0EviCCWYA9SoqjC3QJgZk7dlB/Z/uBx4eoGqTzV3+vz1kPwcM4ENitG9vbUeIS5CUxG8sz11d6WK6wHmOZKz7zmvRFpJTjaelc+0tAwqAHZEWi+3+cbhMK/qfp2iUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732057238; c=relaxed/simple;
	bh=SnQpaiNZeh5n+vgyLHEhD2s+3Dj5vTuGYjm83k/t/bg=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=uUQVcfbiI6HmO3C3gwdbItyjkt8Yi2eaI8MFi4WEN6IcOHmF8AMGZgEe9OAfkKabkGBSOv7nilxVtBzDVfmHNjdNxhwLgCuAyoHAQ9wBE9ixcXaN/QfXn2YHytxrKtoOwaY2APz/PSHJWal8MQsqO9c3UdEHhsiW0f4HM+qAZjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pe9wnOF3; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pe9wnOF3"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e293b3e014aso4789346276.3
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 15:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732057236; x=1732662036; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LnbME42R2LfFNaMpUrmesNpgT8Nb/L9TgLUhFREqeck=;
        b=Pe9wnOF3JJTgCP1ZcfmJAbZKNJiq1b2GHU8eGP6nbZXb2oZICJGNOIoKXDoTQNnsGv
         Y9OJ08XZzJDVzOqh191HL7FVqAFW74xMLyKHsX5zNzBkCqMaveqNQW5zdJNUCz9Zc16/
         MQ2ydqUn8ZrS3xXLYjeW1vc4V9yWCUvN37bIZqnivJFNzeyPiRMz+B/WMmgDiDXOmzlD
         6OF9SDxQhFK73RmiHky5oXzqGPuYKz/6QOqS3fKUK0+DXPS9ijs9AMzCVs8EiVYJxy/X
         xLz/hWWOtLAoJNLKI2MXVctee+ENBJfDGU3LbKfVBll85DulOhSNcxt7ziRoHpUJ8+nT
         Cljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732057236; x=1732662036;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LnbME42R2LfFNaMpUrmesNpgT8Nb/L9TgLUhFREqeck=;
        b=foEEio3l8KmhHDsuPigtFKBqyOpfU3WPj4YqSh9KvgWIdzwzvuOnPuCvY8lxH5SQDh
         7RTiRBHegHrVGySZ6xXQ2eiKaM6ZymkWkIOCtu0KkuuG/BnR2Ge/Qeo0NvsRy+WqC52i
         0Lea2Hz9gmdY43ZU4pxZwdxR/2AukklWPBZwNd47Ir65iSYxql+Nt/30eyzQ48o5Wvrh
         Sx0nqYWsaLs5GCFqkriE+XY5gMQnp+HenMXr5hD9y3XAYyDnpLeRcbPVS/DufXRMMoAF
         WuPJZa1+JuaUJC5koFyLJR/53qQovRTFxpEJlutVbn3eGGahuD5Xf9fnnuh/kXmol/DT
         M9qg==
X-Forwarded-Encrypted: i=1; AJvYcCXXBcdxD2Pc9LZqP/7gDd1DFbMSZ1IbykqMM34Wxamw1/iUPlVwd7S96puAAnoU3kVfSSAJfOxoCMJagK4FgNvT@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Bjbc65O+rRGfeyIarESxlHzHZCXeEgu3r+kx3/UW2KPHa036
	cmaCF3PLn0xckpPcLM2cbwGPnQtan6w2DdL+19yQXSDvT/aHi/oF51nO0tL/n1lM/mkXlPDuNfM
	j0U+w9g==
X-Google-Smtp-Source: AGHT+IH9Co679ZSlkYRRyEiksAwN016d3EZ59f4JN3HnyaZ+TNBb4fPcTYXG+hxapEGy1a5D49gMcxDCur8O
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:89d:ee73:740b:dfb3])
 (user=irogers job=sendgmr) by 2002:a25:9005:0:b0:e28:e510:6ab1 with SMTP id
 3f1490d57ef6-e38cb726100mr190276.8.1732057236028; Tue, 19 Nov 2024 15:00:36
 -0800 (PST)
Date: Tue, 19 Nov 2024 15:00:33 -0800
Message-Id: <20241119230033.115369-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Subject: [PATCH v1] perf hwmon_pmu: Ensure hwmon key union is zeroed before use
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Non-zero values led to mismatches in testing. This was reproducible
with -fsanitize=undefined.

Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Closes: https://lore.kernel.org/lkml/Zzdtj0PEWEX3ATwL@x1/
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/hwmon_pmu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
index ac2245acdc6d..4d9d6f405434 100644
--- a/tools/perf/util/hwmon_pmu.c
+++ b/tools/perf/util/hwmon_pmu.c
@@ -274,7 +274,7 @@ static int hwmon_pmu__read_events(struct hwmon_pmu *pmu)
 		int number;
 		enum hwmon_item item;
 		bool alarm;
-		union hwmon_pmu_event_key key = {};
+		union hwmon_pmu_event_key key = { .type_and_num = 0 };
 		struct hwmon_pmu_event_value *value;
 
 		if (ent->d_type != DT_REG)
@@ -560,7 +560,7 @@ bool hwmon_pmu__have_event(struct perf_pmu *pmu, const char *name)
 	struct hwmon_pmu *hwm = container_of(pmu, struct hwmon_pmu, pmu);
 	enum hwmon_type type;
 	int number;
-	union hwmon_pmu_event_key key = {};
+	union hwmon_pmu_event_key key = { .type_and_num = 0 };
 	struct hashmap_entry *cur;
 	size_t bkt;
 
@@ -623,10 +623,11 @@ static int hwmon_pmu__config_term(const struct hwmon_pmu *hwm,
 					return -EINVAL;
 			} else {
 				union hwmon_pmu_event_key key = {
-					.type = type,
-					.num = number,
+					.type_and_num = 0,
 				};
 
+				key.type = type;
+				key.num = number;
 				attr->config = key.type_and_num;
 			}
 			return 0;
-- 
2.47.0.371.ga323438b13-goog

