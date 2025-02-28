Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBA61E1A16
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Feb 2025 22:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740781456; cv=none; b=nLPP7I5eiC7rN1uuTq6nktKKE88HdAQoIZ4iDx9ynTC4Lknp3Ftu84Hm/qa5CR3701fLKc8AuYQqYszDlnyg+Xjoq565PhO/yW/MYcXMht/t04lQdrd701K4b9qDMULhhwu6nWwe/a5BZXcHNZP9cW0FBT4uU+YBt9bIlS8H+Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740781456; c=relaxed/simple;
	bh=jARGiuOKFpE7ttUiyi3nXCy1dRKbqXYHUbF5NHjb0bQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=hXgez61mbVIDWaQv5QgWPBzBPqVE56USxfJXAgC2axeDqjNuGiQTECVxxizlP1wK06kpKttdwlb+PihyJwDU4c9CcRaIybFbWQVLuYC5JOQvxgZHfvwIhjUT6BcNyjjCA6Xoz3pm7uYTJVf2m7N86XtodJClhjzvjybHzzw/zaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PYxO0cH2; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PYxO0cH2"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6fd36a398cfso29020477b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Feb 2025 14:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740781454; x=1741386254; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=enmPSmBHYN1yp2Q+rHUZdMzy5YlY4bNvK33F83dFzQM=;
        b=PYxO0cH264RH1PhhlGubyv9U+IHcFdJGk9690ga/wLCIWccjmucqtnvWOCok5aRTTC
         /vaeW3mhGYNttXgjocC98Gv/geClz5zMufi+wqKRfMGVsv0YaEAj60fs7wPxL+osIDFO
         HAqNPM89T4WOC/OkXhSDRlqknWAfzeDMgmO106gFVJgFupZSTCvUFGbonXVrDZod3hfG
         h8HXzW6Ttetkl0Mi4S1TCuFRrAKLLRkFeoZ9oW0+VPLQGmIq47vdGfq2Byds30JRqzys
         sB+4tSTnH1w+JSQESQaZkwaEGYOA66ezFrGNw18he5M25plmjmzOiifIP+fm+4e05T9x
         jSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740781454; x=1741386254;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=enmPSmBHYN1yp2Q+rHUZdMzy5YlY4bNvK33F83dFzQM=;
        b=qR2sUbsietyfYyvjFdxU5X8xCU+7J7eHYzMYnTNu/AxyQpwfzq3cex9bg0Bc9lSj/H
         Eg/7UBgROiCsKP0SJyZoxBzGeWCV9HGfyMZcE9sVhQKnCQS0GEkvwo5hdCGpimMziqii
         erCd7MeQTZDQFidj3y8VoyvccNTbZGoYfiCaU4pZStrwihq2JoN+PbRUvdHXeeKzevRa
         L08ai65YMdI7k/u7S/TBkVKYrjy2kCLdxtBq5xWbHKUWNBjkNRHHu3xWor7tKXHiTdTQ
         DRbWIJJLEGv3tblvtJnNvcocqqMAmCFo3YmigQDb0qEQBoMOlZcWDHyuVS9G2r+GD8Fl
         N9vw==
X-Forwarded-Encrypted: i=1; AJvYcCWoCfL1+g6pQ2f0TRSxr2I8U+qnh3oquC8kze5R02gFoHzkzjaEZRA2sWZLkchDypd3oWQ1S0HjsDU23xqa75z2@vger.kernel.org
X-Gm-Message-State: AOJu0YxpE7KTVq4vsIHAfgTBptQcoytysZ4bZ1lcFDdWpJrypBZHjP4N
	v1yg2+0cX6NJ0tG7oeIirHInDs7BoupXCw1lC5NTv4kGKWS9KjLwUtXIgSr01dgLdbEpxG8MgDD
	kz5RcJg==
X-Google-Smtp-Source: AGHT+IF5Ht5Zx7YaRV6uVmPiWZ2hPFfsxIko0UkgE1lrkUhapRpqms48maTlHe7yM9CQdUCAckPuCsM5tclE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:23a3:4d43:890f:dfd7])
 (user=irogers job=sendgmr) by 2002:a05:690c:6e10:b0:6fb:51bb:bb6 with SMTP id
 00721157ae682-6fd4a0f3ac6mr4933897b3.3.1740781454138; Fri, 28 Feb 2025
 14:24:14 -0800 (PST)
Date: Fri, 28 Feb 2025 14:23:07 -0800
In-Reply-To: <20250228222308.626803-1-irogers@google.com>
Message-Id: <20250228222308.626803-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228222308.626803-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Subject: [PATCH v2 10/11] perf python: Add evlist.config to set up record options
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, James Clark <james.clark@linaro.org>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Howard Chu <howardchu95@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Add access to evlist__config that is used to configure an evlist with
record options.

Reviewed-by: Howard Chu <howardchu95@gmail.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index c55c8392bc07..69ec2ad60d98 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -9,10 +9,12 @@
 #include <event-parse.h>
 #endif
 #include <perf/mmap.h>
+#include "callchain.h"
 #include "evlist.h"
 #include "evsel.h"
 #include "event.h"
 #include "print_binary.h"
+#include "record.h"
 #include "strbuf.h"
 #include "thread_map.h"
 #include "trace-event.h"
@@ -1052,6 +1054,31 @@ static PyObject *pyrf_evlist__open(struct pyrf_evlist *pevlist,
 	return Py_None;
 }
 
+static PyObject *pyrf_evlist__config(struct pyrf_evlist *pevlist)
+{
+	struct record_opts opts = {
+		.sample_time	     = true,
+		.mmap_pages	     = UINT_MAX,
+		.user_freq	     = UINT_MAX,
+		.user_interval	     = ULLONG_MAX,
+		.freq		     = 4000,
+		.target		     = {
+			.uses_mmap   = true,
+			.default_per_cpu = true,
+		},
+		.nr_threads_synthesize = 1,
+		.ctl_fd              = -1,
+		.ctl_fd_ack          = -1,
+		.no_buffering        = true,
+		.no_inherit          = true,
+	};
+	struct evlist *evlist = &pevlist->evlist;
+
+	evlist__config(evlist, &opts, &callchain_param);
+	Py_INCREF(Py_None);
+	return Py_None;
+}
+
 static PyObject *pyrf_evlist__disable(struct pyrf_evlist *pevlist)
 {
 	evlist__disable(&pevlist->evlist);
@@ -1109,6 +1136,12 @@ static PyMethodDef pyrf_evlist__methods[] = {
 		.ml_flags = METH_VARARGS | METH_KEYWORDS,
 		.ml_doc	  = PyDoc_STR("reads an event.")
 	},
+	{
+		.ml_name  = "config",
+		.ml_meth  = (PyCFunction)pyrf_evlist__config,
+		.ml_flags = METH_NOARGS,
+		.ml_doc	  = PyDoc_STR("Apply default record options to the evlist.")
+	},
 	{
 		.ml_name  = "disable",
 		.ml_meth  = (PyCFunction)pyrf_evlist__disable,
-- 
2.48.1.711.g2feabab25a-goog

