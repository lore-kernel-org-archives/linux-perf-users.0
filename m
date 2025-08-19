Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E5E261B80
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Aug 2025 01:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755567622; cv=none; b=QIc1g+aMuAug52WS+HcG2/zRbkVGwQS910WeES5YKrGRFeRUA0juaACXmO2qWIF//Ns+GzA1lb1KtljEhBL2AA/tX3jb7r1zaj8OxqeaOz6xXAhZpq1duLEiYKgYEbxHLSlCwsryrdTLNAVtNnOLq9RKMBmDi7bdEu0fgHewuFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755567622; c=relaxed/simple;
	bh=khs4S/7IxVCuql9myiBmwSw6UVebkoy5hCfsOWhQDjQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=btZpUaj/f7kFzsuaQDwY3m2d9bvMKjxg0NTVHSsHLsvFI1YFkWrtv4r4CVvaYgdlFtNYeFG7MuJrzQ9oIYLfeFTusKEE5bD3mpQcMmlUszB7lQ+RKiyuXkRpSuj3sFOeypRZ0q8cNoMc63+zL6kQVxlcSEcID6JOazEZ0LPCKI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H7N+yrp5; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H7N+yrp5"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b47173bb3daso3879125a12.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Aug 2025 18:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755567620; x=1756172420; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jh50Dmb4zL5UKBnMYgwYnwoepImIAnKG7fDAfETvJtE=;
        b=H7N+yrp59lN3p1S6A2GqSwh9DIy9RKNwcsIrY/K+E0+3WhXWFbH5XW1urKRE+Lamd+
         k3pMZu25oXx8Xi/HX9xgUdPO0kkr3DPvSDktC/pIHdIDdxutzpDg2nwsOkIbAbPoO4UC
         Yt6M6DN54coHL/2ek1TY3gGEgiYMlYG8njMBiQb3wPogDgfmOc09wCn9UCeHIGUPwC9h
         CdVGfCbdA6QMu/0RrDpEak38hdZcMGRnmbSTcCf2+fk8bLecH1xUWYJ2CNuHeRZNyjb/
         O+cThg1Vm+17hHh6EMdIBDKNv+GZXP7QH0HfzzDnnk11MMZ11Td8qD99NaOIIIb/nN4q
         3Msw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755567620; x=1756172420;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jh50Dmb4zL5UKBnMYgwYnwoepImIAnKG7fDAfETvJtE=;
        b=WgiyP0T7CBFX85IRQeRqGLMWygM06hnjbluiE9JHESPKf+U9CAMpQ0hY6wRqfM9cLz
         tA7pln12mIskEU+PXdSrU9rJ2McgDCQLJ6UdBOeeSEka7fonrTTad5K/T5XLp9clyLJ2
         CznE/JjqZvZKAf8g9XXthE/HwLC/rXTjNHXStR9OWGpic5ItlBIpaLCajoF95yQuH/YZ
         3FlRgjnOitvVGE6HAkfPYDRgG9X88uig7RAAaBfkIJQlSTqyF+3/kxn3txDfY6W/tP2G
         IvDprE49/o6aTAVWNXvsXVGT6ue9BvduqSkKV0fZBhc7n5ehDN4/lYe3R3+7uHP7/zQ8
         tV+A==
X-Forwarded-Encrypted: i=1; AJvYcCVwcLz5sO/OrAnMWfvTLm1XK4b3wERra5xQkJrYFhrPEzQdtwj+Mf4iYH80jrE4AirwF+9/C2D/2q8IosUCznos@vger.kernel.org
X-Gm-Message-State: AOJu0Yxht5sJcXmfc/YQLjiEolI2WJUaYkKFmXA4+HR8l4j6noM3Wo1U
	JhhgIq/2vpy5l1EEmZlYJ7GYpiqphH/wL/wcNR2nhaBmsjpXGXBw/4/DdHDSfNyXioSo1Vr9IGe
	38rA5+ALYLg==
X-Google-Smtp-Source: AGHT+IHhO25EIfvqplWW5D7diRrlzK6/WU28ojDclYhVCxL/0RuiRvqPMqemYCaiuJ90EthLaFXcPZ46iV4a
X-Received: from plrp4.prod.google.com ([2002:a17:902:b084:b0:240:770f:72d2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c410:b0:240:3f43:25f
 with SMTP id d9443c01a7336-245e041d9e0mr9070415ad.23.1755567620423; Mon, 18
 Aug 2025 18:40:20 -0700 (PDT)
Date: Mon, 18 Aug 2025 18:39:32 -0700
In-Reply-To: <20250819013941.209033-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819013941.209033-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819013941.209033-3-irogers@google.com>
Subject: [PATCH v10 02/11] perf python: Improve the tracepoint function if no libtraceevent
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Collin Funk <collin.funk1@gmail.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

The tracepoint function just returns the tracepoint id, this doesn't
require libtraceevent which is only used for parsing the event format
data. Implement the function using the id function in tp_pmu. No
current code in perf is using this, the previous code migrated to
perf.parse_events, but it feels good to have less ifdef
HAVE_LIBTRACEEVENT.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Reviewed-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/util/python.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index d47cbc1c2257..127934af4828 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -18,6 +18,7 @@
 #include "record.h"
 #include "strbuf.h"
 #include "thread_map.h"
+#include "tp_pmu.h"
 #include "trace-event.h"
 #include "metricgroup.h"
 #include "mmap.h"
@@ -1554,10 +1555,6 @@ static const struct perf_constant perf__constants[] = {
 static PyObject *pyrf__tracepoint(struct pyrf_evsel *pevsel,
 				  PyObject *args, PyObject *kwargs)
 {
-#ifndef HAVE_LIBTRACEEVENT
-	return NULL;
-#else
-	struct tep_event *tp_format;
 	static char *kwlist[] = { "sys", "name", NULL };
 	char *sys  = NULL;
 	char *name = NULL;
@@ -1566,12 +1563,7 @@ static PyObject *pyrf__tracepoint(struct pyrf_evsel *pevsel,
 					 &sys, &name))
 		return NULL;
 
-	tp_format = trace_event__tp_format(sys, name);
-	if (IS_ERR(tp_format))
-		return PyLong_FromLong(-1);
-
-	return PyLong_FromLong(tp_format->id);
-#endif // HAVE_LIBTRACEEVENT
+	return PyLong_FromLong(tp_pmu__id(sys, name));
 }
 
 static PyObject *pyrf_evsel__from_evsel(struct evsel *evsel)
-- 
2.51.0.rc1.167.g924127e9c0-goog

