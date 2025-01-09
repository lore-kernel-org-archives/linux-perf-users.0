Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3AA21576D
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jan 2025 07:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736409099; cv=none; b=Vdquh64GBuPedLr9WBxzV+HmhbAiWoGu7ERBzSU9AAFmVFpuByHUoCcjUY3omawyB8Woc5wIaCF2iUCKyrpRpFMspTxo5QIEU9OmnRDgsX3cXcfvgNOgQTwZDD9leAtyG7dA1/zRo93D+cD3CpFPM/n7E3fi6l85yt2PScKc+zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736409099; c=relaxed/simple;
	bh=GuHMIsQjp4bNuyF9P2iuK/6mUQTUkq/9ExOKZGD7pHk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Hqu4Q/FQfQxZB6ZCp2npAZOIhfteUHBpql8c/22XomZygDEeFGWNS/OnXF+qgSu7qcqETyev3UOUQOxMPJT9eWQn/89+Yj9NoZ1wxuj4DFeQPrK+sDzTLkFlILkqq7JnvQT5t6frhmVCQkYEcTDU/J9jdDdRp6xrh3JkyFQsPbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hJ5H/G/+; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hJ5H/G/+"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02fff66a83so1230928276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jan 2025 23:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736409097; x=1737013897; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vX0FPpAq44g4U6f0SlAuMrhRB4aCR4aQgT67H1xwScg=;
        b=hJ5H/G/+ejLfGU6S8TbtB8sGzFmFj0meLYHSCip2jfxbftkyh01dH1KQCE8++0VOy4
         sV1lr49RzjM8NV69UhiTii2rRmow+69RjdfLFaD+RmGSCCw4P3guwrHdVX7/lbGd+nxU
         CE0WBXL5vS9Dh8D/19xuiJV624SnNyozRyXn78RYKBh+Z1W17dYnx3GL+AaNzFnUgCZ6
         k2+gKMvYEJYvFHd7mUAe4V2/10RWFiDiGHNxZRbkvmkRYDmK0PT6yb9u+yHN6jMPQC1/
         PJq3PdfMQaLjU4JKZhRuu1ar707jFaCO7gNIB20xN+fBC3iv7S6gCS41UgoB6Su/ckuN
         zonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736409097; x=1737013897;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vX0FPpAq44g4U6f0SlAuMrhRB4aCR4aQgT67H1xwScg=;
        b=t0aPM0eUnDFe8EFZtodo5uVEeRLU+TdUQtQAHfNRoDcuYiK1v4JOumXz35gxkDNOvn
         CVfsI67uuAK/TVatUWe7dN7TmZkddtDDk8Kq2inNkoQ0qArxIv9+evVfyYDMoUAu5+Tc
         En1+SBpJJfByP1jduDL3+RAhKlPYyMr0OGN61YY15n54lZQ/BaU6G+5yG9JXQu80ljMy
         qH7MwkwZPG6B/d5WbmgbULibvwMU3Kwr3h8dOLzmK2eP+uNp5jMYIVRUfe2i64qtwOor
         cmZJbzg3G5Ll1FYZSDa/vy3P6yf+3+aaZA754OPm9vSkzzBy9fybxt3QisLCbyeNOp+o
         1W6A==
X-Forwarded-Encrypted: i=1; AJvYcCVjrIpV+vfvADvfEADfmRSc4XOC6d5akQBklt+NOFQvKw5Tc09NEIlaLgacTV2aNy9K0sGuXeCfDnQLQp91JKYD@vger.kernel.org
X-Gm-Message-State: AOJu0YxegGlAQLxyL+AfjF8Q7C+ME1Sgju6TICm85rhF8xHs6Ec4kI59
	iNOtaLWt08lEYX0oa0m9lZ0SFByE8NNNEYsnpGD/YaCi/6XzGjcu8m1ZbUL2OqcPQgMF8fau67O
	Y0TNL+w==
X-Google-Smtp-Source: AGHT+IHDZuMeExAM13mUvVGjBDZ1b0jptwReHIxWzvrc6z5nX7GHSViezjng9bKkyV8hxAjaKJrReFsn0cJk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:f801:f788:c7e5:c181])
 (user=irogers job=sendgmr) by 2002:a25:74c5:0:b0:e46:8e7a:b404 with SMTP id
 3f1490d57ef6-e54edf1627cmr13135276.1.1736409097209; Wed, 08 Jan 2025 23:51:37
 -0800 (PST)
Date: Wed,  8 Jan 2025 23:51:06 -0800
In-Reply-To: <20250109075108.7651-1-irogers@google.com>
Message-Id: <20250109075108.7651-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250109075108.7651-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 09/11] perf python: Add evlist all_cpus accessor
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

Add a means to get the reference counted all_cpus CPU map from an
evlist in its python form.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index d1ce3b6b5bf1..1e8ab5291637 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -865,6 +865,16 @@ static void pyrf_evlist__delete(struct pyrf_evlist *pevlist)
 	Py_TYPE(pevlist)->tp_free((PyObject*)pevlist);
 }
 
+static PyObject *pyrf_evlist__all_cpus(struct pyrf_evlist *pevlist)
+{
+	struct pyrf_cpu_map *pcpu_map = PyObject_New(struct pyrf_cpu_map, &pyrf_cpu_map__type);
+
+	if (pcpu_map)
+		pcpu_map->cpus = perf_cpu_map__get(pevlist->evlist.core.all_cpus);
+
+	return (PyObject *)pcpu_map;
+}
+
 static PyObject *pyrf_evlist__mmap(struct pyrf_evlist *pevlist,
 				   PyObject *args, PyObject *kwargs)
 {
@@ -1048,6 +1058,12 @@ static PyObject *pyrf_evlist__enable(struct pyrf_evlist *pevlist)
 }
 
 static PyMethodDef pyrf_evlist__methods[] = {
+	{
+		.ml_name  = "all_cpus",
+		.ml_meth  = (PyCFunction)pyrf_evlist__all_cpus,
+		.ml_flags = METH_NOARGS,
+		.ml_doc	  = PyDoc_STR("CPU map union of all evsel CPU maps.")
+	},
 	{
 		.ml_name  = "mmap",
 		.ml_meth  = (PyCFunction)pyrf_evlist__mmap,
-- 
2.47.1.613.gc27f4b7a9f-goog

