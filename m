Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD9D262FFE
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Jul 2025 16:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511471; cv=none; b=pW/TPKtHolzEgdpgEta+0VPbASm/U+Mrjwfp9C5Xa4rw3YIdGz9fKV2fg5HL/j7XASaaIxDrGPzfEEGv3IvBQByqXZqqfdVym8KiKbrmunAiHtivcT1XR1ZEljAU8UmQVT/RN9Msl5J44ZJEhe6chtc9JY4Fi/3qXDd8vtrSyR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511471; c=relaxed/simple;
	bh=IO7FvvdNH5mdXbeA366TB1YHTzn2Zgj5KkqRuVkdEz8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=DNbSyMjnuSy39OKRfwlqlOaCxdpX+sVXvLzqr7DeTCrrFNwtkagb49yA5lrqQdTBDnjb+My7kr6lUI9M6U4OxdmiKZnANBRP1Wa92h+FqJvFyPBz8MHgEGZfokKHAORFktZ7gFUqnOl7M7nqX9xI9IPMKYiR1dOPGQvkHC40k2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IB3EanhT; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IB3EanhT"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2354ba59eb6so56568745ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Jul 2025 09:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752511469; x=1753116269; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RNpTkoNE8II3Xmed5cX8hZeCLxHuWXoamhAnTHonxFM=;
        b=IB3EanhTuEc5MdR32bs+wya3imnzXl0cqMjQ5E7k68AkYMrxYA/9JQuGIyv6X6r/F6
         7haZmnIC6K/aSwKy4cGrqAOXIaWSlXtnkWlq+Qo7naer1J8qMNGLDLBiYGK4cg5Vd5YZ
         3F7f1S/h46IZEj9YIh9fcywhcfplnwNl6y0bxdX4FUg5To7KYaDXaBioYuHW/EOfhU+x
         rOSl7YJPfNaehz+Z5Xg3hLZmQVPy8HYXO1XGX0IB7A3YO5vWymW1MRs5KGVrcX3qwisA
         YjkH9Heo93j1fqVBVccCho4SSL8UPn4NxeOdc2dSfS3WfKDiG1rJcWapzoh8HVAJCN54
         9GuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752511469; x=1753116269;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNpTkoNE8II3Xmed5cX8hZeCLxHuWXoamhAnTHonxFM=;
        b=TZjDa4xjznJL6rXEUDUY8WltOWA6Z4a+GjcmD6L2Fu3btpXkJMekbdRO9lCyLGIHl+
         069B3lkkR5xxPZhMvOKwa6jEoF/wFnd+EK/h3EcMfCIPoZ/Jk3Y77pMaNV6BgGx2pcra
         MV1cg7fasv6uR7CS5ybjya13bcH8GyxhES38vZ8xVRmoK4qz/9VSULMQ4B3ZMkR+kngk
         PWet4Rxhz2fXVnUwtqUGg0KKdCEc0MeW1RUlzn62Pqs0RZQF9uzns9vJyhNoTsbJofvY
         /a0nStORLBQlUbWKDEL1GWlb8ZQQCrXSH/ODuqv/egIaooPHfIX28e4ke44Y6uivMdsm
         ExaA==
X-Forwarded-Encrypted: i=1; AJvYcCVJoo/jEjkAFK83jbKmZjFUjBSc3j5E05UrGAufC6sS+urjjrxZSl3HZpEDsARL7oQmTmvqmiWm/zQmw+/M9/dS@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3MgLsU8Q4rbEnJw2xlj/qyDkknOJC+PjGpsgkMiBJh2OzubB3
	F4rPsYZUZB3uFNit2F6e+zcZcao6SYyWfm20n9wNeQ6q0nYKkJKyugCWtStMMs6yhIm3mgysQtC
	NAiBT6ffCBw==
X-Google-Smtp-Source: AGHT+IEGJcSrv1or/zD0cju4ZrW/u3RgyXa/Qm8OVx7fWyxbcGF6DW9TTLNdvDZtAiLSp57AUWfQL8GaEhTJ
X-Received: from plhs17.prod.google.com ([2002:a17:903:3211:b0:234:683b:5792])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f1d5:b0:23d:fa75:eaee
 with SMTP id d9443c01a7336-23dfa75ec43mr135766855ad.32.1752511468998; Mon, 14
 Jul 2025 09:44:28 -0700 (PDT)
Date: Mon, 14 Jul 2025 09:43:56 -0700
In-Reply-To: <20250714164405.111477-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714164405.111477-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714164405.111477-9-irogers@google.com>
Subject: [PATCH v7 08/16] perf python: Improve the tracepoint function if no libtraceevent
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
Content-Type: text/plain; charset="UTF-8"

The tracepoint function just returns the tracepoint id, this doesn't
require libtraceevent which is only used for parsing the event format
data. Implement the function using the id function in tp_pmu. No
current code in perf is using this, the previous code migrated to
perf.parse_events, but it feels good to have less ifdef
HAVE_LIBTRACEEVENT.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 02544387f39d..9d97affb79c1 100644
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
2.50.0.727.gbf7dc18ff4-goog

