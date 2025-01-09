Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6AC215780
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jan 2025 07:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736409101; cv=none; b=uxVjoRBgYDXZ1iVLM0tGP8l+rHa5h/fVD+H30sXjBOKLxWCa8MIF0Exr4tg4QzMSU5/fj3ikRW1VCPxswnDlToZU5u6g/omO7GyGJaWStbXAFFwX1g2zDv9eVk1th6RUv1lDmwdCE2fkG9mFiefNf+YSXsY1W7Euioga5lioRCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736409101; c=relaxed/simple;
	bh=406aBAYGFzDV1bL8OXedVAztzJzIPqw3jyxHJV9iafY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=twW2r55UOYtd689VY4p/SNTBXTw0yPdtwPPmtGfwY/72vVBWpbHCpLbrFiB7xVbHfWvFGftGfq/PnaEum/gnCcWaJDaTUoCNeJy4LjIqA22wFxmTBoTcTDDvsDBmaRj9w94o4qr5ttj/iHZQ8mWkHllHO5SaSwv2gbLz26GEIik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gKOxsjY3; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gKOxsjY3"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e3a0d165daeso1428080276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jan 2025 23:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736409099; x=1737013899; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cCiXoa6hR4V0Hw+AXJa/eNgQ4Vri6Ug0YtvV6AM9HlI=;
        b=gKOxsjY3BQz7mPQozo7ijPkehrao6MuMzdnkxRIO1NnUzMSK5nikTDm3Ov/BMpaJY5
         eiLRMMubRQztQ2FVWDdSONnTQAlhDb8VIEc9c0RvAbcA0LjoHp4u9Fvf3iDGRRekhVn6
         q0kOQjoKPwb2Sl1Q3AtMjm3ZvKlzNbA9gUl9FAv1vXAog9nL9tJaNonmLERzvFKJ6nFV
         KhhkO1eCbcTzB9YMWFZ0IGx5wYvc+JrlSqN6ehPQ9CO9r1tMZWgRQd3wefl6D6MGWhCk
         dqqdWzpjnAwxyvfb1OgSA7aq1UwMGNBnctdcYCIZNUbX7C9CqtVeeXISn8wAEH3PwGLF
         +mFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736409099; x=1737013899;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cCiXoa6hR4V0Hw+AXJa/eNgQ4Vri6Ug0YtvV6AM9HlI=;
        b=XlvmnbHMJOZhRiwnLubT1B99vySZoVsc+W23NUOmgno8Ur7zFQiCORUN1kILy/jAc8
         TBjyB0OmveEcndGK3gEegpDNVViKYVC3OJte3kZLR6B+vOurWp7lr1HsuIzvJQwYqVJb
         98ZogexvqjiPX3m9XrjX2iIymIN7KpHK34n5TXjsgACGSBvbfCtS0LYUTvOxFMf1iruH
         li7wUQFEv70awJmQDCEUfwg/j6y0bu73vlRqs1h2F/0B+WakTRT6XaC070tPYTulmY2J
         cdBFnyvwv0mI18Ec9l+v/3KyXWlDZhBsYcoUGUbAKh21bCDzzwfUbJbDfVr2PC2UzG36
         ss6w==
X-Forwarded-Encrypted: i=1; AJvYcCWwKCIssm5vGf4NW+AzmTNVcaEaysmy/JOZPi8GCbnXRKlday4bd1KmEmFdwdRtS2wKLnJZM8C68pdFdn5lPYOA@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7nr7iuMLlI68GLLJxtmMBAz1F68ZMaW4VEz6aFezQyODjw3R9
	KdNG8yc2wB3p+pANEFwuo/362+XfPYGsm1JOzdXhwS3p0thGI7E2PrHEulUg/jR8vK/b/HiGKvr
	9cyABvg==
X-Google-Smtp-Source: AGHT+IEUKlwAipnWk8Ae+MXLNubrpdFPQ+OhZD+yTJnGFg/lMMxHqtycrS4GlaxwkuwxAUkdpNQSkeuw8Qk5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:f801:f788:c7e5:c181])
 (user=irogers job=sendgmr) by 2002:a25:2782:0:b0:e3c:9fb5:3933 with SMTP id
 3f1490d57ef6-e54efa4e3b4mr11130276.9.1736409099307; Wed, 08 Jan 2025 23:51:39
 -0800 (PST)
Date: Wed,  8 Jan 2025 23:51:07 -0800
In-Reply-To: <20250109075108.7651-1-irogers@google.com>
Message-Id: <20250109075108.7651-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250109075108.7651-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 10/11] perf python: Add evlist.config to set up record options
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

Add access to evlist__config that is used to configure an evlist with
record options.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 1e8ab5291637..38a7e16e09c9 100644
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
@@ -1043,6 +1045,31 @@ static PyObject *pyrf_evlist__open(struct pyrf_evlist *pevlist,
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
+			.no_buffering = true,
+			.no_inherit = true,
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
@@ -1100,6 +1127,12 @@ static PyMethodDef pyrf_evlist__methods[] = {
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
2.47.1.613.gc27f4b7a9f-goog

