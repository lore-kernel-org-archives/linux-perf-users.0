Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E92322A1F
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Dec 2025 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766416496; cv=none; b=PP4pdo6zNfkP3pTUgq5lo+1a27q/GbfJsfT7Gns2N2gmCdMflh+kE3kUzcGMcvz00bFnvjaQNiyeg3qOhUklUDDBloJKDS094zqxkroAaDXWzAolzYhItQ1tUJpYrevhKYRHkuf5l27hi9SQcelPKSAme72Ytu8ZMsEE/2R0qFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766416496; c=relaxed/simple;
	bh=FTxDdPV8VRCnrc+wl5dgopj1RtcXYU68OejLvw73lKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KKG8s5q3+YugCMcXe4AJaQS9bbLMxQTyyGfK6peh63T536MiL3KA5RkVnkhOxCxy+eP0ch7Vzbi+s1egUK3fTRSEzkpEfHNn6wQaL9bSFeoWpYEV+bVSLa8vxp3NL2j/52N001J2Aa1gIM7P/rHW7HK6AVNYAwthMbZfxkdF55Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B8850Ybp; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B8850Ybp"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477770019e4so35310475e9.3
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Dec 2025 07:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766416491; x=1767021291; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U1bJE594NjB5xayk5BHzRci/xs2vEOkVDLlHSZrqiYE=;
        b=B8850Ybpwr4E5WjIUjw3uVxj+xJGVer4XEn0ZCMDXdANzjxSky/NKkzAjdoFonksnI
         YnDms7W0iIW8p2+txwIGgLjefCJ3AbKaqdJA5W9842Mg3CK3hMpfETRFgZpUKmE8MTbU
         LQydx1aSqZfZRrjEBIfSHxDgnZ+gBZ7ljyVi+/07I7YklUcMzWoguqY5DYqBhLmNtIgr
         XWgpI1lnLPupmc/JhuxUGDG0Z6YzWBbVpc4OpNChyKZvaz2J8HZcxZUzrhOueV/cFkhr
         8OB6EwUFuqxKuOyKG08znT/YvC4xNy4dC37DF8xW/WDISyDtHaF/i7citV+qVG0N7kHb
         dZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766416491; x=1767021291;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U1bJE594NjB5xayk5BHzRci/xs2vEOkVDLlHSZrqiYE=;
        b=E/tz4uuJsvj/veRT/iLv0AbjbJW6APzYwZqTbzH3tE7QfTYZBnhN9Af4/WL2U4hSGr
         9pduiWbw+mvzzMVju/rkJ87Dah5kErNwK3EQxdvlvl5Gd710bne99vE2M3uAbOedcAlq
         1EFZ3Loc+/w7fGLfz2JQjUnK19n887NT3u7STsUK2lH4pvj1zeZ3Z/+y1A5F7+SlhURu
         T6mZtrWgCT5D3qRpSU4WJYnChLlhOI73hG9iZdoA6veoKzsjbas+R/vIDh6yAY48iKs+
         HsQ/oTNvwudtFbFYgaS6VYr+1TUdLna9pcvewtEBfHw5wvh3pDAxxXC/6lL8yTgdoqRr
         SMeA==
X-Gm-Message-State: AOJu0YzjZiFh5hfvVJYgM+mUuM6iJlraD34mDZi9TagRMT+sbOxUqCAX
	GZ3q8tJVVe/MJVjLnROoCf10hQoJLuSdhzR0R4bfq44lDNylxkm+hQKKm4gJnt2qgiM=
X-Gm-Gg: AY/fxX4YaczIE/6eUQKSiY/icUADG/kja6M3hnyQUdX+H4qM+k5MhYLKt5JDSxYkH58
	/YsyDwHOUat+sQ7CdU2FNoSh2Afp+ZLwpT3oDo7JoOFqH6S3Yvmz0xQ5OZiQ0wEQv8vkzB+TskE
	DvbYhuUGkgbK14BJow6EhPbmZKfHZFewS/zMspIcYPIqaCEWlK5ZBflt7OWVnFah67V7ohPOIpS
	oSv6aM8OC3Aa0avXp6xO5MSgPcGjhsCKM6V7n+lop/8cB1lUFdBiDAaE+azLoT4VozdIye3Ywwv
	VwmII765rDjen+uIJ4rzajLhw8+DnKhhPXD56l6qOu1fTkDAnKHwYcDUfYI1+FQ0Ju09sBIwA+4
	s2vcuB1e/oV3A1dqSV6Iw/N6QMhvAKFB8oFU8bbIHFuaVQ/amnkplYeDA5EdkVbRreiyqnHFzuJ
	CftnEMhs1ct2+V7IqYINqRkuKc4LaM8BE=
X-Google-Smtp-Source: AGHT+IFddjiKvcVB6cB7sXuBjaeFQkW72VpuWm8Z2oCtbr9Um6xxbGDEDSw9Q4XBeyAlVCQFF3b1FQ==
X-Received: by 2002:a05:6000:26d1:b0:430:f463:b6a7 with SMTP id ffacd0b85a97d-4324e50ec19mr13688757f8f.45.1766416491127;
        Mon, 22 Dec 2025 07:14:51 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea830fesm22750093f8f.20.2025.12.22.07.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 07:14:50 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 22 Dec 2025 15:14:29 +0000
Subject: [PATCH v4 04/14] perf evsel: Support sparse fields in
 evsel__set_config_if_unset()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-james-perf-config-bits-v4-4-0608438186fc@linaro.org>
References: <20251222-james-perf-config-bits-v4-0-0608438186fc@linaro.org>
In-Reply-To: <20251222-james-perf-config-bits-v4-0-0608438186fc@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>, 
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Sparse config fields are technically supported although currently
unused. field_prep() only works for contiguous bitfields so replace it
with pmu_format_value().

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/evsel.c | 4 +---
 tools/perf/util/pmu.c   | 3 +--
 tools/perf/util/pmu.h   | 1 +
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 21878e9bd029..45ab97beeb34 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1322,7 +1322,6 @@ struct evsel_config_term *__evsel__get_config_term(struct evsel *evsel, enum evs
  * the bit pattern. It is shifted into position by this function, so to set
  * something to true, pass 1 for val rather than a pre shifted value.
  */
-#define field_prep(_mask, _val) (((_val) << (ffsll(_mask) - 1)) & (_mask))
 void evsel__set_config_if_unset(struct evsel *evsel, const char *config_name,
 				u64 val)
 {
@@ -1339,8 +1338,7 @@ void evsel__set_config_if_unset(struct evsel *evsel, const char *config_name,
 		return;
 
 	/* Otherwise replace it */
-	evsel->core.attr.config &= ~bits;
-	evsel->core.attr.config |= field_prep(bits, val);
+	pmu_format_value(&bits, val, &evsel->core.attr.config, /*zero=*/true);
 }
 
 void __weak arch_evsel__set_sample_weight(struct evsel *evsel)
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index e3a1f26213ec..599fdf5e28ba 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1404,8 +1404,7 @@ int perf_pmu__format_type(struct perf_pmu *pmu, const char *name)
  * Sets value based on the format definition (format parameter)
  * and unformatted value (value parameter).
  */
-static void pmu_format_value(unsigned long *format, __u64 value, __u64 *v,
-			     bool zero)
+void pmu_format_value(unsigned long *format, __u64 value, __u64 *v, bool zero)
 {
 	unsigned long fbit, vbit;
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 8f11bfe8ed6d..e34db47ae5ef 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -254,6 +254,7 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_
 			  u64 *alternate_hw_config, struct parse_events_error *err);
 int perf_pmu__find_event(struct perf_pmu *pmu, const char *event, void *state, pmu_event_callback cb);
 
+void pmu_format_value(unsigned long *format, __u64 value, __u64 *v, bool zero);
 void perf_pmu_format__set_value(void *format, int config, unsigned long *bits);
 bool perf_pmu__has_format(const struct perf_pmu *pmu, const char *name);
 int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_callback cb);

-- 
2.34.1

