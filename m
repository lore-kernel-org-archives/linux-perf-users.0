Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168BE25A65B
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Jul 2025 18:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753469549; cv=none; b=ugP16oeqXcIdmxU78nK5aKsnm2Qm5c5CSwyPNfQQbfL1OK5g64DrfDjtiU0Vt+JOj3Xz5O/kQ7U5eiKj0iPKM5WevSUCSQqDNoiRzAMgeHi3K2I2Jx3voxmczXpI7yUJG6VyoDKmNBE40kyP/dI02Zn2AboBotjLaqR76p40C9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753469549; c=relaxed/simple;
	bh=HqDk6X1/DfCGPk0Gp0ehRv47DcS+8QrSdxSSMXn33lQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r/VceZCO6g3i4w1GqmyPtcGm0BgPusQAoj2pBmJpYEfzMQOIKiCQFwcPU0dG2vZlGQLMp3P4cV6AWeVkNafPGOxb6kg0mOI0nzFehhMoOLro18jatrVxgTdVKKzGdCx8lgyqTOCwCM6wPWVnyqgwo51bMLzZoqh5Py4fUHdlabI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nOZTinoG; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nOZTinoG"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b3beafa8d60so3363402a12.3
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Jul 2025 11:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753469547; x=1754074347; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dmEgoww/7meU+yLm8fgYCDKtHPDOME4Ul+s+jjhRtlQ=;
        b=nOZTinoGR+RKl2yLPkY9+bpYb5ySJNGOKiwJBXuS/YTApdz3ksDCXXrB2J26mgyCD7
         pzXmZjnf/avAdWzuc8AyLsc70uuKJ+JHU8UnMjD5XwMsBdxs+s7PXLHzuEClHGN/MqiZ
         BQUZUpG1HPgkZ4ozF3AP3QsXx1RlTQE7Vqo4EyCgJhHEUXN6/CCXYROegmst/czlIqye
         bEeyp4ZWf+tnMOxw+uDPVpvk8I5c56bF5z2Peu2/xmx0ds6x0QlxYR1mXxH/tXTTKZz+
         ilTU7goMXNQilhaJPzTNfCAJwQfZa753kadbXfsB45YNqMZmZ8FOxRo/JKxOzciYIKCe
         9Z7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753469547; x=1754074347;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dmEgoww/7meU+yLm8fgYCDKtHPDOME4Ul+s+jjhRtlQ=;
        b=Y1+hS7YogrRNmDh0q89him04bg5On1nFKXqidYxJTc8LT0hjXPcpgBOJllO7vGJVN1
         lZMU1N+vlKpobJrmSQlsmhig9UNpZnf9oS1VW2wvC8kTErAzkbK+Tes62HUFQ6VLhQ0n
         QiOkeeKseLMM18aamRGmmES+YH7srU3nqsMGcYPKMwbCYyY/my3XxcBoKyH/REWE/EPC
         6wAgc/E3clUeCZP7Z9CkEsWC/41lqQfjR66IvyZWeymZnVi9B5ZGe+IyNJ6jYf9t/V84
         WrnWW5CUIZxpf/xIAejAykksBr1uXs7OztGCl6yd7R4VdNxUo84XTmVUN3vLkZkMC+eS
         AdlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrDfbdQKEo3lqS05m0EK5ohsfQmEJm3pQNohbYIKBrkB2Nk0vNMZUbsRKx/d3GvFYZhu2necsBJonajdgTgZ3p@vger.kernel.org
X-Gm-Message-State: AOJu0YwnbcOWgFuxuFxTuK5Cmp23v96Pk3plFItL4OvpQva1KUeysTMF
	x102tlUQ74kfVkAlbnzz4aP95fnrfoj2WjPfhVv736V9ZDNRsohuAlr357gsMPjl/Bok13qkczl
	GFU/e0dlZHQ==
X-Google-Smtp-Source: AGHT+IGUqLRV5Yb6+qeKqxFNA0h+T/6ceXq86GJKGP9IFI8x/riCJDryd+TO6TzmpDgCqJ/6dINlzlxLO4nS
X-Received: from pjbqd6.prod.google.com ([2002:a17:90b:3cc6:b0:31c:32f8:3f88])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5244:b0:311:9e59:7aba
 with SMTP id 98e67ed59e1d1-31e77871248mr4447359a91.2.1753469547424; Fri, 25
 Jul 2025 11:52:27 -0700 (PDT)
Date: Fri, 25 Jul 2025 11:51:54 -0700
In-Reply-To: <20250725185202.68671-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250725185202.68671-1-irogers@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250725185202.68671-9-irogers@google.com>
Subject: [PATCH v9 08/16] perf python: Improve the tracepoint function if no libtraceevent
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
---
 tools/perf/util/python.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 3affde0ad15a..9c9972d77d1e 100644
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
@@ -1544,10 +1545,6 @@ static const struct perf_constant perf__constants[] = {
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
@@ -1556,12 +1553,7 @@ static PyObject *pyrf__tracepoint(struct pyrf_evsel *pevsel,
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
2.50.1.552.g942d659e1b-goog

