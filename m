Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AACE2749DF
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Jul 2025 23:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753312992; cv=none; b=hykLoDsa3Zp6Ft341I6Ad0GooCmYdx/7wKh3Ti46npZqGRWFXvWfHd7keDc4RU3ukgDx/e7CkZ8am4L0KyRSHMUwdnLl/Mmknq7rEdcaosfnOfaN6AJSYZGmdNXqst9OaiLUd4wKhLtweSNzwoO27pyEW6FLFeBGeTN8t7OVq68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753312992; c=relaxed/simple;
	bh=Vo6tbVjdJL4lzlTuKJJDRAwcz+98CMZF7SiPUqEkxLQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pf1/fjHd7zc6qwjD4NqS45L3rlqGOiA+j673CokfNYdaUdfuRuZosNeFmB/YdinuU5ofeCMCMzBDZgnZLg62qttW2hHavpAL+y3AqnYPQ2gGxGtmTb5o1Yqz/rOP7/ff3JIkhaK2sMZHDo38jWR9iXdwm6a4d7KDlKvzM/HAzj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HfMyHg8A; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HfMyHg8A"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2c37558eccso244432a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Jul 2025 16:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753312991; x=1753917791; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MrcDIPxORzR9yt+tgwZuFcuDMoj49Q8f2loh+BQfr6I=;
        b=HfMyHg8AnryrejuqlYZ3nvVg4UrDCPjxb0+3bYZZIZEJJJWcCj6LH8uy4cs47KrBx0
         TthGBXS+dEUx1uwMUr9EFofSMZo4XIIN6meDTY0Bs2BglwJlgZITByy9vcSPJUJbU6Zb
         ekURDrV76YfSY+wQslBS14bIabRg5br15wQ5IyV3p+RAn/35qoe/YuoTYZaoD+hTCG6C
         3vEA7rla9KgO3EFWGlS7lJlzc84tXfGVxoHZcYeM62Dnz2wKWyNwrQqkX/0Je4JH12K/
         KAeSZ6Yijb4kaYi9mre4IU7JpgbRvYZknNMPMjDg8HkTsHAInFw0ONwKHjhUua+++63f
         +Dew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753312991; x=1753917791;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MrcDIPxORzR9yt+tgwZuFcuDMoj49Q8f2loh+BQfr6I=;
        b=Jcyf2o1xfPdymIFBnWRK+gJg7qO+q9lfQLNaThoBMhT+0qETFWLshQacJ5sKXR9SvI
         BL7Ya/7lGFibY5u2sKaqHDK5/C9T/QnBK7R91zQD7uLznkbCyQchhtkWIyJwKR3JHXn0
         PxI3MuJLpW8tvlcj28dm7eJvCs60H5FiZ/tEORdMgm9MbeGSE72tgvmt0ylmAO7YDNI9
         JcSWYkjKc6oqlDllLQqmoW0D3r5L52SM3S37eMJPK6ZWxo56x/AgbHXHdNb1pDpIDHlM
         LD9/JeQKEpnm44/NS4Ysc0P5bXexmbx//pNl6RmbnsJ2HZlHn5YktdyWYqTq2U8YEA64
         IHpg==
X-Forwarded-Encrypted: i=1; AJvYcCW86y3+zVjss903zQay9HU5u8btdhYR8rQHQ1Ox46XxJtuvSikSA6PLM94/Mn4yo7ktUY8/EtXxhMJCRtBsge30@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/cTo5c9yQ82ACVCycThC56TUYwcWPXaoQymy7jPZ7i8cet0/H
	JA22aLeEVtFt4E3faPISH1zU+0Zyk2P+jI07k4r5ApsqeWPgK/wl42CB6oARLo5IB0ydpgbHNoh
	VBHH7HSBWoA==
X-Google-Smtp-Source: AGHT+IFDE+kBOJYEVOILaCtT1VmDeMx0V3Sfa2nJ010p8G2+kgJm6eS0vfB2ty7mGIzMy5/ZPafr7Cv05stm
X-Received: from pjvf3.prod.google.com ([2002:a17:90a:da83:b0:312:ea08:fa64])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5483:b0:313:d79d:87eb
 with SMTP id 98e67ed59e1d1-31e50800129mr7366836a91.35.1753312990676; Wed, 23
 Jul 2025 16:23:10 -0700 (PDT)
Date: Wed, 23 Jul 2025 16:22:09 -0700
In-Reply-To: <20250723232217.516179-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250723232217.516179-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250723232217.516179-9-irogers@google.com>
Subject: [PATCH v8 08/16] perf python: Improve the tracepoint function if no libtraceevent
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
2.50.0.727.gbf7dc18ff4-goog

