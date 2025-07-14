Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0221D262FD4
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Jul 2025 16:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511458; cv=none; b=dDH2a3qMHKfUAy9yCJPDMkX2CJ9UiXspAzBBAoP4KFE+IxIo3ncwSj06mpYPzDSuJK9navEcpMACNOoX+IJStnAj/drP2fP3Jsna7vtzB9R6251GY9ooJYIzprabenjEt1uIjv/xF0r6zoqH1QI27itV7e+saRu5NhRML1+zIWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511458; c=relaxed/simple;
	bh=f6B46ndAnVJ4g7u3Wcbahd9XpxkMGRK1fvldnGqU7+w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=k1xwhP+T2g4TyfHZ2/CiAbTyVCuXqd98HWKEbJQp8pJi5aGy85bwespbxC/u97rrELb4If0UJEq2YAjCtWXMhgTcarw8+mcVHIaK322BdIxxextzzkiijH/KPL8SYUjMKg/msicfcKfk9DN3VqOPd4c/EnFRbJHEugCZnLSkXSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nbOSF3Qn; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nbOSF3Qn"
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2eaf00d1b3bso4501963fac.1
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Jul 2025 09:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752511456; x=1753116256; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AeBzxvyY7UGXA7iznB5xBFaZ5PTJHzeehwuSQ3/j4oI=;
        b=nbOSF3Qno9ykCQFB7DPy1g4MdB/cYKODmGlVwu5aNd9co6aBS082D7k6edwRf6kGPw
         OB+u4wrSVKFQhJOavKsl8b7f0qOhOLB08tK7H0KqFpWCR6D9yD1VvMACjBUoOkzS1eis
         A2jGZp8jeFZrXwXknrUvx3KNxdVfKxT6Bly4WAQWOr6MOdmuhMmMqwvYamYVXJVQjpGl
         O63+y1V4XYbbDf4lVSQQA6px5d/Wany0nRpfv3NQwcRv6j4S9cFRTgNxMZNdPa5ZGShc
         OYmnX8lYWmpT/zXUIt+ugCpIa1GAH3J1I0GX5l1qf2yk07ZCXTLBjeOKdqqi1Udw91nC
         WfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752511456; x=1753116256;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AeBzxvyY7UGXA7iznB5xBFaZ5PTJHzeehwuSQ3/j4oI=;
        b=XYsbPCDuL5ty9AfN1AJ8q+vhETIu8GySYIM22u89XeXSVBraSPTRWAAj+e/sKrM4JM
         TpCJnO+aNTgo+9Sjsh3fYsggGzEda6KEU6eyD8wh8hAmkuF6yHc69ribH0Ujy/OrZ2DP
         A/+jMbCrv7tJVOxesahrrded/iqpenPIT++hSrATDJ0coAMZ6Y8RQTgv36oASP2YEq6Q
         XJUrfQqYQm4Nku/U9N3N7lejD6xo6Ssm+1k/nZPMTTCHC+xNUzvpNhgBysqSQaKTHI2N
         JdVeKw9q6Uartvlys+0fcFAiObXznufYKMyFjkyEFjdGLUwJC08UJS96Kw5m7rf/H4qc
         Rxaw==
X-Forwarded-Encrypted: i=1; AJvYcCUrZN3PsUlhb5p5nLjBPo2TUoT/SaDggjoaXjpDG1cSC0hhRBHWp3+kODK4y5ZSaVAza3Az6s8UnmqFL+IWRTut@vger.kernel.org
X-Gm-Message-State: AOJu0YxL3s98ujNUEKcpEg9MHXz7C9BIjbvHl8MqhosVhG9t7L+zMMdD
	7E7UScFYNwRLd0y3+o/D2F9GbbQlPHObIWQDn97NWEe0PYiRefndF6ZAVzYaWRSoWeH44Q+Q1Ve
	nCVPTWEw0DQ==
X-Google-Smtp-Source: AGHT+IEb4Iu2v00ykTD3KxYlVwmZ2fyvL5Kcpo9xGZpKuwapVUC3oDzrLJBRL7Qi4cJCyUWL4U0urny7ztTs
X-Received: from oait15.prod.google.com ([2002:a05:6870:44cf:b0:2d9:841d:6155])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:9727:b0:2f7:93bf:4eaa
 with SMTP id 586e51a60fabf-2ff2b52e7d9mr8159913fac.11.1752511455933; Mon, 14
 Jul 2025 09:44:15 -0700 (PDT)
Date: Mon, 14 Jul 2025 09:43:49 -0700
In-Reply-To: <20250714164405.111477-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714164405.111477-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714164405.111477-2-irogers@google.com>
Subject: [PATCH v7 01/16] perf python: Add more exceptions on error paths
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

Returning NULL will cause the python interpreter to fail but not
report an error. If none wants to be returned then Py_None needs
returning. Set the error for the cases returning NULL so that more
meaningful interpreter behavior is had.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 2f28f71325a8..02544387f39d 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -475,13 +475,19 @@ static PyObject *pyrf_event__new(const union perf_event *event)
 	if ((event->header.type < PERF_RECORD_MMAP ||
 	     event->header.type > PERF_RECORD_SAMPLE) &&
 	    !(event->header.type == PERF_RECORD_SWITCH ||
-	      event->header.type == PERF_RECORD_SWITCH_CPU_WIDE))
+	      event->header.type == PERF_RECORD_SWITCH_CPU_WIDE)){
+		PyErr_Format(PyExc_TypeError, "Unexpected header type %u",
+			     event->header.type);
 		return NULL;
+	}
 
 	// FIXME this better be dynamic or we need to parse everything
 	// before calling perf_mmap__consume(), including tracepoint fields.
-	if (sizeof(pevent->event) < event->header.size)
+	if (sizeof(pevent->event) < event->header.size) {
+		PyErr_Format(PyExc_TypeError, "Unexpected event version: %zd < %u",
+			     sizeof(pevent->event), event->header.size);
 		return NULL;
+	}
 
 	ptype = pyrf_event__type[event->header.type];
 	pevent = PyObject_New(struct pyrf_event, ptype);
@@ -1199,8 +1205,10 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 		return NULL;
 
 	md = get_md(evlist, cpu);
-	if (!md)
+	if (!md) {
+		PyErr_Format(PyExc_TypeError, "Unknown CPU '%d'", cpu);
 		return NULL;
+	}
 
 	if (perf_mmap__read_init(&md->core) < 0)
 		goto end;
-- 
2.50.0.727.gbf7dc18ff4-goog

