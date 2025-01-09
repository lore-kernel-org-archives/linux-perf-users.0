Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725AA215050
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jan 2025 07:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736409085; cv=none; b=MXGyJoQEXbBxFwlG9Z+8/9dRV9bBKTlYiHkV/NzFK6j9FCAIm1ZsDmDImGxyBsu/wMo2a99XpYIe67InqdauWMi5hRD3w4eQYDRtXz94mz0za4rZzeSdEQTzhlqnB1E7juCszJMGyOLXu+KsWu2rd30mpz2ZaPulUYCQ6x2lu/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736409085; c=relaxed/simple;
	bh=D2vadbk3cOq/+EWq9g43saoHn+J5Gupg2/gIpPUhIrw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=I+O2wfRvQgDBc5yu1ocxd3oJQSHBMlVjXg+WGLhK4GKSDD+AHnbspMDszVAiXF+1dzf446PhK5T6m9g5w0U+84iWzv8CFsVrDyqZ05DOmbb5aOW310DX6bAHT3rL3Dl3MHD4t8tWhN1zX9QfZzfqf75H8nX8HD+RhUb1QL9myxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J6jZE2k2; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J6jZE2k2"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e39993d8594so1319564276.3
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jan 2025 23:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736409083; x=1737013883; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jQcA17ms8HvYcRiFBtp5KUfpun8NEvpfsnHmAmkz/ss=;
        b=J6jZE2k2/iwQiUAi4wtu/y6UZcvFwd6OCpa7ReKAOlUaa2PCbsklsf4eKJ/HBMVmsE
         1NJAQ7zghrSK/iTI9GqYVuaMZxDaf904E0b86sm2QxD8aZQaScShVxFTgXFmFicoMpsZ
         tb4x+An3YoXYaAbXvl/YlSTsSJ+kY4EMz4SDs0XhIOXPaM4Rllnvh7s8jZWXqcE7cSmO
         hdYCqOlwZr/m1Zm/Pi6VqQqzZrCW/3U8lu2Bq4u1r1+x0+E4wCsZPwWLZiKtNm5bm7uv
         Vr0jszLIh9HFkHnISK70wK7fWVSxRs6/yAR9NkY2XQKKgkouO84xLVug9SlYoKMPAzxy
         559A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736409083; x=1737013883;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jQcA17ms8HvYcRiFBtp5KUfpun8NEvpfsnHmAmkz/ss=;
        b=ZZBmfJXDKjOy3MrrnH8mn1KGXrmS2/Oyzi7JZPdmy4icRVsoZEUfB/kgLW5prDEQcu
         zoBJV2+05AwobKZZHtJTNY1GiXjaK0+Kd/0ohX7Ww9YCCMUw5uimdCCBtYTiNRttQ+In
         FZu7Fp+wYBAWDXW0HoYB8g5Df9kTlB15evGdKFZclQCDGtVwY4HP0wRDDiqEIC2YMumO
         zP80vmTxCUjywfo32LTiCkbiIY2O9SxW1Cwj2SyoHjlt3f4TOppOg/DsXn+RcXT63XB1
         k7/k9s5IqIZkNkZCagBlbf9Atng8SQ1RVevuq41wdYVk+4ymO35RkFd6sQfPX50eNwUQ
         qcVA==
X-Forwarded-Encrypted: i=1; AJvYcCXXKVp40xcX5mq7ThpwQdllArcNCUkvXZaxQC/hPqFITDK6ljlWAZ5j8zt/BfUCe82jvkZ9AKoakJoAv3Unvf19@vger.kernel.org
X-Gm-Message-State: AOJu0YwphpUYHgTfKqAneIWjKn8+SRsoOIFPq19RW1jXQV/sz3SRngra
	PbI+WP4UFHepITUro8QfVZOyK2ijtlZ0H5a+YH/jGJbFuXzQhd8zQJPuhuDPkMMdzdYgVQ5dMlY
	x09CfrA==
X-Google-Smtp-Source: AGHT+IGCahQWdbnl3OdawlTflOkDj2h+wIGV3RscZKPtsVYugDlRvjXk0T62AGYdj+3n+mW4iQktRlBwZVYW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:f801:f788:c7e5:c181])
 (user=irogers job=sendgmr) by 2002:a0d:d102:0:b0:6f4:beb3:1d8b with SMTP id
 00721157ae682-6f5312b5762mr148577b3.3.1736409083360; Wed, 08 Jan 2025
 23:51:23 -0800 (PST)
Date: Wed,  8 Jan 2025 23:51:00 -0800
In-Reply-To: <20250109075108.7651-1-irogers@google.com>
Message-Id: <20250109075108.7651-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250109075108.7651-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 03/11] perf evsel: tp_format accessing improvements
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Ensure evsel__clone copies the tp_sys and tp_name variables.
In evsel__tp_format, if tp_sys isn't set, use the config value to find
the tp_format. This succeeds in python code where pyrf__tracepoint has
already found the format.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 697428efa644..5324a8916da1 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -511,6 +511,16 @@ struct evsel *evsel__clone(struct evsel *dest, struct evsel *orig)
 	}
 	evsel->cgrp = cgroup__get(orig->cgrp);
 #ifdef HAVE_LIBTRACEEVENT
+	if (orig->tp_sys) {
+		evsel->tp_sys = strdup(orig->tp_sys);
+		if (evsel->tp_sys == NULL)
+			goto out_err;
+	}
+	if (orig->tp_name) {
+		evsel->tp_name = strdup(orig->tp_name);
+		if (evsel->tp_name == NULL)
+			goto out_err;
+	}
 	evsel->tp_format = orig->tp_format;
 #endif
 	evsel->handler = orig->handler;
@@ -634,7 +644,11 @@ struct tep_event *evsel__tp_format(struct evsel *evsel)
 	if (evsel->core.attr.type != PERF_TYPE_TRACEPOINT)
 		return NULL;
 
-	tp_format = trace_event__tp_format(evsel->tp_sys, evsel->tp_name);
+	if (!evsel->tp_sys)
+		tp_format = trace_event__tp_format_id(evsel->core.attr.config);
+	else
+		tp_format = trace_event__tp_format(evsel->tp_sys, evsel->tp_name);
+
 	if (IS_ERR(tp_format)) {
 		int err = -PTR_ERR(evsel->tp_format);
 
-- 
2.47.1.613.gc27f4b7a9f-goog

