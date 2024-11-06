Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD12410E3
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Nov 2024 00:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730854108; cv=none; b=Q6Tfltz3Z+NJZ4Q6btuMQuRCeH5prj9W1dLC4DFvwHrIjGK8PIccxaUqIGbVhyK0cl66zZrEyr8FlrWhV4Zhxy4HYMHriSN4Z1suFdSM53GHpKLQMokko9+slllHkoJbOc1jXOfV4wNwPKehHLmF3mphSXZeekz/QozqeWJJXSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730854108; c=relaxed/simple;
	bh=9I6xl/pCNtYb3pgbMGqxTrPrnk7hUSdh2wehgp4aL/0=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=iudQjccUu2x4fDm8QZjKym1qgCA1L9P9kPLGV2ButIdZeINrQN5Md/c2rKo94hbCfDV2HXZD+Epsu91GZtD6Te5W+m6riDc8Zqr/RX1W3GjOmwHmy6BrvRMevZUBfQYhnNnc5IHlQwALPthflL/c3EJn7oXgn1VjkNGHbBmOHUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZMGLJB7W; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZMGLJB7W"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e29135d1d0cso9784563276.1
        for <linux-perf-users@vger.kernel.org>; Tue, 05 Nov 2024 16:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730854106; x=1731458906; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vYd57AoGodRvVgwIHi85ZBfZjyzkHdyJhjySvflJKD0=;
        b=ZMGLJB7WUhtq/nE1s3UeDjO0KNgsDo6DKs8Gz0cteN9z2vbjK+01wZ6c9hDBq3lMjz
         RgSFstfMrv7UYzYAx+p4hQdMT7MMjcZSygYokzVW+Ip3og7j6HO/8R9r0lPr4CHtrZdm
         McjZs2wYtHAd0MkCQYmsh8wtBcoAV1VA5SeOCbmFgwPp+LduoknEl77Q8rHryYJzsYC+
         3KFA0DBviyxT6r31AsgSZrNV3WSdJIVJ+GXcGFFt5Nwhm57xAy1pET5GD8KO3ifvuwe1
         jgdVn+NjpfRjoHLq/8Bz5BWH9ksn3JetkC+oVd4diV8e1m/Yf+wKed4TgBT7+2aAwAni
         v4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730854106; x=1731458906;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vYd57AoGodRvVgwIHi85ZBfZjyzkHdyJhjySvflJKD0=;
        b=l1GXZtqovMWB9rSt+UI1bxFvCNS3S3AOZm2bNMZ/jQ1RT5wOv7WekTdNEH19pozktA
         FlDhZJtEcNS70krtSU8sXSrXRu+846W0xNbjpSE9qC9LzYjKAOQh+8fuyOIAvEK3ZMrR
         M6lGByEE1pG9nbOHRTIqgdiGze/Dwa9fkSHyH2NcoZc8sS5v1iyOGnhrEAR8yVfihQI+
         /3+eFXU2MHgkaq29NWaz002MSR77myya2vBLo+R6AoXGr9GugDOfnRJB/YPhcm+7tj5F
         EHpm8GkHfmGbw8M0gpAgh4E+XlmJvHqqAdivuKwyzADO1dJKebL84KgNFg1XKV1tlC5K
         Rz4w==
X-Forwarded-Encrypted: i=1; AJvYcCU6/ooCf8Knmnuat8aHlNSaXrMdrY/tr2PvkusUneok7vvEZNsMR6mrs3iwvr1XASomv5hXBsFwAl9J2D1khyO2@vger.kernel.org
X-Gm-Message-State: AOJu0YxnS4tDF+fsStyDi7SNVF8KSw0TIjKrX7R6kXBZSM8kdpFnlIWH
	Jn7Vq11YGgf1cFGPzV+NeOvsAk+KXgKK7wdIQ6epKefP4lc3ktELIsNOYN8G+3j1YOD2UbVh7dg
	bQpJyzA==
X-Google-Smtp-Source: AGHT+IEObSlB6Ht1DmKatDDLJH5puuB4Uxp9+SL2zbA9P+sOY39CyoDGJ97g9J4RcN87Uji5jwYp7xyib0mX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ff9e:ab12:75ac:c1a0])
 (user=irogers job=sendgmr) by 2002:a25:9b42:0:b0:e30:c741:ab06 with SMTP id
 3f1490d57ef6-e30cf42ddb2mr16401276.5.1730854105236; Tue, 05 Nov 2024 16:48:25
 -0800 (PST)
Date: Tue,  5 Nov 2024 16:48:18 -0800
Message-Id: <20241106004818.2174593-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v1] perf stat: Expand metric+unit buffer size
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Long metric names combined with units may exceed the metric_bf and
lead to truncation. Double metric_bf in size to avoid this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-shadow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 8c9292aa61d3..6b531d4f58a3 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -507,7 +507,7 @@ static void generic_metric(struct perf_stat_config *config,
 	if (!metric_events[i]) {
 		if (expr__parse(&ratio, pctx, metric_expr) == 0) {
 			char *unit;
-			char metric_bf[64];
+			char metric_bf[128];
 
 			if (metric_threshold &&
 			    expr__parse(&threshold, pctx, metric_threshold) == 0 &&
-- 
2.47.0.199.ga7371fff76-goog

