Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2111BBBD7
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Jan 2025 19:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736622131; cv=none; b=rdQzlUeZ7TVzHyWb7uqd5dpm9Dd3xeGAxw4fV+dpijOuh2BEyt6eqFdNh4EEhqAW8D4U2DMeX6Ph0pPMgVRETgd+XKGhVhgE5AmrorcinlI5jBZV0kgM/DVQSBY+PSCm2V5aNTUtt5+dqMDwmhbolPrcSf37oe+j2NGxLtQ0kBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736622131; c=relaxed/simple;
	bh=3iZTgbtPfPPo2dK3hZUj/hH00tBcjj3k6Tp559ZGZ6Q=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=DwbYsLTYrFwpa0KdPq4QetEiBVkqJvcxGqdMTUdIJ9sURzthAjeo9apBgu5XLe/VhuJtxwPxSXt1UiKS+HMAJvePU5i991BF5xm2F0zNTgcaFZQv7/+k3x0a7KG3k2XKh61O/7FilDMl3DXZ9jpq/8wk8D24AjmJnvS7Pq3R558=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yc/lrTXM; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yc/lrTXM"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e549b6c54a0so7496125276.3
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Jan 2025 11:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736622128; x=1737226928; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lo5Sf+zXLl8ZXrA9urL48zDPlXAPEvaxJJVLmevfZ+A=;
        b=Yc/lrTXMDN/wZKzpt0w/6KbWdawENCc9QL346Tw39g0c7DFmFnQfrUu6q8Vy0fqgqS
         9HU1HDD3z8UBkg16vDbKNZDsUv/OUVW+BrldXvf98R+l9X1iJ0YPqPuZKVdutqcfy0R0
         dOhx7bcRMnjgbuovPRZXQqJu5ikWRSwbEHcYXMrf4B/fxvmODA9fufDullkyiS5HyiuS
         Duj5nK6LCGt8tGD1L7lUIl557au5NPiizLwW0OcSRsgGaJqkj2T9Bb+s/DJdzzmqJTNv
         UkQG+GgHSlDkiBu7KnP7CQHNmguUdhOBU6ZvO2Kbk9j7jMU5Q1EISPJmbHrWVd07Uldy
         DPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736622128; x=1737226928;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lo5Sf+zXLl8ZXrA9urL48zDPlXAPEvaxJJVLmevfZ+A=;
        b=wtTD4smqoQ83bLU4dnSFrJqm9DPQbC0syuPJWoPMw0SfOUEdTozsenVFydcDXts8nV
         hznykR2aLYwulekeeNN2PM0sSJvo3SBS8bwkwVtlLYadetfBdWLNzexUwe1eYGG0iDcC
         I9o+jwHONoQFuWe6rgXMAayW+4ceMSsl805aBbevWaBRGC5UTvZZfOdyr7pQdEj/lGUf
         dKZgwtyBnVYcftYYVTS2Pp4sUvwxbObKq4W94laE4tJF2W/2mxiRSU0XEP2Z3SEbFp6Y
         8V+zoye0QoBMxXSqiSaA//L+aLBtX8o5Niaz8JYzBsS8nSqSy8n+WgN4T/dV7sMbZBUS
         yWAA==
X-Forwarded-Encrypted: i=1; AJvYcCUCJfiflrASZT2xsxdiBTNmZWX6ikx6F5Q8Z/BY3yRdPMscVP7lZGvSutmyf0tTxjkAM6H9pzHzd7eC2h8YxHrM@vger.kernel.org
X-Gm-Message-State: AOJu0YyuebXJsvfFzkD+uRSPZWyOxpxB5HNyhC8VZ95GZXx+xDI8cjf3
	3shYCGQ6igiNH+w6XCPMAmOYI1iktzFxr9/z5hyO0ILC7QPQ9wqsX7u5OIucZEe27BBuu83dQRE
	NrlfRwg==
X-Google-Smtp-Source: AGHT+IGnoYfG1oTH51KIaDyWcknRyKMXaYCxZE7NhmRJul3YRs8HpwbD0S9YYGVk8qHUCQ5DIFz5YobHyhwB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8807:d7c5:bb27:35fc])
 (user=irogers job=sendgmr) by 2002:a25:d617:0:b0:e57:40fb:df53 with SMTP id
 3f1490d57ef6-e5740fbe41emr3105276.2.1736622128594; Sat, 11 Jan 2025 11:02:08
 -0800 (PST)
Date: Sat, 11 Jan 2025 11:01:37 -0800
In-Reply-To: <20250111190143.1029906-1-irogers@google.com>
Message-Id: <20250111190143.1029906-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250111190143.1029906-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 04/10] perf parse-events: Add parse_uid_filter helper
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Hao Ge <gehao@kylinos.cn>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Levi Yun <yeoreum.yun@arm.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Tengda Wu <wutengda@huaweicloud.com>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add parse_uid_filter filter as a helper to parse_filter, that
constructs a uid filter string.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 11 +++++++++++
 tools/perf/util/parse-events.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index f147e13a7017..dd298dd6655a 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2451,6 +2451,17 @@ int parse_filter(const struct option *opt, const char *str,
 					  (const void *)str);
 }
 
+int parse_uid_filter(struct evlist *evlist, uid_t uid)
+{
+	struct option opt = {
+		.value = &evlist,
+	};
+	char buf[128];
+
+	snprintf(buf, sizeof(buf), "uid == %d", uid);
+	return parse_filter(&opt, buf, /*unset=*/0);
+}
+
 static int add_exclude_perf_filter(struct evsel *evsel,
 				   const void *arg __maybe_unused)
 {
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index e176a34ab088..289afd42d642 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -45,6 +45,7 @@ static inline int parse_events(struct evlist *evlist, const char *str,
 int parse_event(struct evlist *evlist, const char *str);
 
 int parse_filter(const struct option *opt, const char *str, int unset);
+int parse_uid_filter(struct evlist *evlist, uid_t uid);
 int exclude_perf(const struct option *opt, const char *arg, int unset);
 
 enum parse_events__term_val_type {
-- 
2.47.1.613.gc27f4b7a9f-goog

