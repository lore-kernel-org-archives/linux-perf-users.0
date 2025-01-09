Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EDA43169
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jan 2025 07:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736409088; cv=none; b=HhBfvjMgzxTUAW1QzzNwVrWE8XFGHlqv7LzFeIw/DV7Dfz2QycHxdecDRMoGuEEduqBr5O8x4lqiBqMSeZG+JOxmd4g8L4SFQ2VibOMvoQ5JSDRxdJDNO/bxaGMKQmR51O2ENJ4OnAf0PqsHaxoZpLb4enNtCc28lGoXwZJbY8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736409088; c=relaxed/simple;
	bh=JWLHLZaHXZUbCGyEiGTHx6SFRTHPlzSBMWL1I5q0294=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Hxnbn00RZPDiEDtx2cqSeLsDbU9NZ2/jO0C7A6hH16+bn4kMuVUiwabDI+9Xwu4DDeT9KgxqlUGsdMj+7I9GIFYEvO0wG66Dc6VVxuLltibwp0WN8daYCj2MpF8gwcl7GGi4JaXQq3PF9c3Ecky9rnCF8oLCk/r1zUXrOmTEjEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lDbMTg+C; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lDbMTg+C"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e535f2c8f7eso1491670276.3
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jan 2025 23:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736409086; x=1737013886; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=epzBIcpq14vhr2+XgSqG+4thTJ3QNCJ6p4BI0eNk4RM=;
        b=lDbMTg+Ccv1fYL84iPpiSpNDsZ8+HsK+K6aSIy1sYTETn0A86qIp/mvur/VDRQJoL4
         FBTZUOXZJvrAdKh2N7Pdhn4D8WzWAWdjEORNcpZCVGwM7c2Rg85eTAnJ+nb/56G2a/nv
         00flQh7MlGoDtrEwS2c59w7+C7vleHwjlxN3/E4cSbTaI55/FFAoAxiFYZf8hHzRD1uW
         npMRgZjPhFEjfaQmwtqklMQ3U7LSeSw2wdfugx+ZX8iWiyVTXzxBAKaXLcZIM+Pz859X
         66rzluV2T/QRcv7JiVG2LE/u3KIfM1q9cQTGhrn0Uk4EG/bxcs+K3EODLnUwkli3maPw
         3fzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736409086; x=1737013886;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=epzBIcpq14vhr2+XgSqG+4thTJ3QNCJ6p4BI0eNk4RM=;
        b=KmuuVnhbd1SARVvCky0YkRQKKRz3hFLqJbMOM79mHkKv7tDRwArtHI81q+Ry2dmHdr
         iaC4WOn8/yQac8F4RkYpgUQawgHmSZbTFQuw9IJPXQufzeAdp9stA23v7hwIBiuERMPt
         n4zN1TiP8ZJ6+Z7gCrN1FacayWwqVl+zD6GEMYQ+2gkeSE1QzGW2Yu+s8f0AxqmiuzXo
         4OIsYqqHSzCqqHtJBPqiRNzdioUTh1jyFTKpA7PBtDzvEV1Pq3dTd9HLMzwyJZmJitWg
         1Y11Sic4egJjCHiTma7PaFgCDfzIUuURc0NjXtJWIQQTe93fSLdVfwfDRtMAoElz4Y1s
         3sQg==
X-Forwarded-Encrypted: i=1; AJvYcCXj5r8XIzSAgJty5zAn6p1Y0JRdEWvXF/RG3GDNutZXhpwaZwSCQ7fpxn87jgUSChURdQCT/Pf/DvG3TuFTHdXh@vger.kernel.org
X-Gm-Message-State: AOJu0YxwQg/y8Ju0ltkvSsh9AEoc23vCbR26Hluj9ugGtLhr6QJA4Qcp
	1LQeuIxkYW7wm1Iydq9iI0dRR8MTj3AMb0ClBN1um9AldkA8c9etGerQo7OStwnMQ10kJq8vWxg
	dIuxDkw==
X-Google-Smtp-Source: AGHT+IG16oQcBcWxWzba8vjLnphRCfLsB1BOo7MqZBmhZ+9j3cgfHLBvEUa+7wAK787lSMmL1smOrh1E4PHi
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:f801:f788:c7e5:c181])
 (user=irogers job=sendgmr) by 2002:a25:cecf:0:b0:e4c:35c4:cf05 with SMTP id
 3f1490d57ef6-e54ee1e51a6mr11486276.5.1736409085711; Wed, 08 Jan 2025 23:51:25
 -0800 (PST)
Date: Wed,  8 Jan 2025 23:51:01 -0800
In-Reply-To: <20250109075108.7651-1-irogers@google.com>
Message-Id: <20250109075108.7651-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250109075108.7651-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 04/11] perf python: Add evlist enable and disable methods
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

By default the evsels from parse_events will be disabled. Add access
to the evlist functions so they can be enabled/disabled.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index b4bc57859f73..8f68320130c4 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1019,6 +1019,20 @@ static PyObject *pyrf_evlist__open(struct pyrf_evlist *pevlist,
 	return Py_None;
 }
 
+static PyObject *pyrf_evlist__disable(struct pyrf_evlist *pevlist)
+{
+	evlist__disable(&pevlist->evlist);
+	Py_INCREF(Py_None);
+	return Py_None;
+}
+
+static PyObject *pyrf_evlist__enable(struct pyrf_evlist *pevlist)
+{
+	evlist__enable(&pevlist->evlist);
+	Py_INCREF(Py_None);
+	return Py_None;
+}
+
 static PyMethodDef pyrf_evlist__methods[] = {
 	{
 		.ml_name  = "mmap",
@@ -1056,6 +1070,18 @@ static PyMethodDef pyrf_evlist__methods[] = {
 		.ml_flags = METH_VARARGS | METH_KEYWORDS,
 		.ml_doc	  = PyDoc_STR("reads an event.")
 	},
+	{
+		.ml_name  = "disable",
+		.ml_meth  = (PyCFunction)pyrf_evlist__disable,
+		.ml_flags = METH_NOARGS,
+		.ml_doc	  = PyDoc_STR("Disable the evsels in the evlist.")
+	},
+	{
+		.ml_name  = "enable",
+		.ml_meth  = (PyCFunction)pyrf_evlist__enable,
+		.ml_flags = METH_NOARGS,
+		.ml_doc	  = PyDoc_STR("Enable the evsels in the evlist.")
+	},
 	{ .ml_name = NULL, }
 };
 
-- 
2.47.1.613.gc27f4b7a9f-goog

