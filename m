Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1311C1DFE0C
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Feb 2025 22:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740781447; cv=none; b=Oec+sF1QIv6Dz8sUrks8dqlUAQOWuzhsz3ZO8Y3m9U6A57I8xtVvkZrHK5wIoOpKX1/h0nBGiMorQUlbiBHG5dPrE6Kx5HOMWACeyOYKNpy32AFMHJg4QXTjDwYQCVaPGSwTnA/ACcByOBUvMLhZfuPKepsT/Ka3Owq+4J9JVso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740781447; c=relaxed/simple;
	bh=c20W4Lu/yCFUCIff1Ju7FoRwzLs1VC3M4seD1jUrq3E=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=aSFkn5thGSt8caw66wlPYIZSkoHnMA4x7zVu7wFFxeP3PnQ8Ulmp2cctGWuijz6On272DhwnEN7RA07xjJVGKbwZgah2aJwJVOPeRUT/usUsTSufv1x1yiFIWop+Bndv5cIuFx8vfrQceeMqjCCBW9l6/RFMSmbc6yN2ZCWXmKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hGEtrz0w; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hGEtrz0w"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6fb518ad1e4so29036067b3.1
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Feb 2025 14:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740781445; x=1741386245; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DUsOhiF32RtA3rdS/vMtgZcfTtdyvQ+DyGJcYbuYksQ=;
        b=hGEtrz0wEox6rzvuO6NpBDVqctkakMf1cHnYjdbymY13S1De23RW5kyCd2RRR5prpI
         BD4jhAVQQa3cPF8NE1Zb3ERsesmbIjmsTJaLw2WW4WoCxYgKPBggzO/E4QsLVxqlYKq9
         BUkO7+6swLDpE4bl/aLNl51D0KrjnePMPeOsThVKdWU9Jlefy1+2d35kIS1zIDjzlc4g
         5/1H7c4KszCNoztpgabDIYQmNBZ6b/mc0od7INWWuLyYDmKknQZM+rNZcsCayJ2RD/xr
         8JcjytiFPcTVlAHidc8sTYZiu8s9h+s+IpSW+a2e1iszEpTEBmw2Qfs7WG0/f83jQKHg
         1S+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740781445; x=1741386245;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DUsOhiF32RtA3rdS/vMtgZcfTtdyvQ+DyGJcYbuYksQ=;
        b=X63vtxFN9G+ynQgkX5VKpXppvNNdrcw2gNsoNsSaZmfWDl1P0kqVYYpvTC/ddcI3z2
         LrVm11Bqp8NwcH1wzZpQLCvplhhw575Ns+6H9J6HkdxIsOsi2skVds5G0klHRSW42eb9
         qVnXzQL2WjVKUDqTXD925AtKM1Mn2d6DQ/HZKJlCrPZiRtIi9k+j+N4KFTuAlMZulxYt
         WYR5JUB6dfNVypYmHu7CODx20NeA0O0ys7pg6gzhZssHlYxHqzR6bG6hx2TDx5X3tErX
         zQCT5IstKzfCcW1lcGpI9r4aYwy+fuxv0d07mK+4tzr2Vssed2pmyghNTRJ8NHV8ZzZh
         T/8A==
X-Forwarded-Encrypted: i=1; AJvYcCWw6SRSgGW4Hh7hw1aK1fWUKLygF8cJcGtpEDj5MjtXg0FmwDqD9fDMgHpfETKeL39p6csWDGCTjLJrKqkwSycf@vger.kernel.org
X-Gm-Message-State: AOJu0YwPe7YkM93b7Jnw1J4AsTODJPQrhM4AuNbEPEujxXCxOd9XWw+h
	5McK7E2hqeG2XYUWoVBdTUbBL6TKz34ky84xO1F7PAONRQSeqGguH0sM/Guqv4odXnAEzEAd085
	Jr7vJTQ==
X-Google-Smtp-Source: AGHT+IHfd7GrwJfhb+MWua2bx3vtIpV6EB15tYflsFx+umvkBji+DSYZmokYAdQCo0ENr+WPX3hvXcndIKmZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:23a3:4d43:890f:dfd7])
 (user=irogers job=sendgmr) by 2002:a05:690c:5c16:b0:6f9:d2ce:45e4 with SMTP
 id 00721157ae682-6fd394641c2mr11001607b3.1.1740781445317; Fri, 28 Feb 2025
 14:24:05 -0800 (PST)
Date: Fri, 28 Feb 2025 14:23:03 -0800
In-Reply-To: <20250228222308.626803-1-irogers@google.com>
Message-Id: <20250228222308.626803-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228222308.626803-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Subject: [PATCH v2 06/11] perf python: Add optional cpus and threads arguments
 to parse_events
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

Used for the evlist initialization.

Reviewed-by: Howard Chu <howardchu95@gmail.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index b600b6379b4e..4a3015e7dc83 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1339,12 +1339,18 @@ static PyObject *pyrf__parse_events(PyObject *self, PyObject *args)
 	struct evlist evlist = {};
 	struct parse_events_error err;
 	PyObject *result;
+	PyObject *pcpus = NULL, *pthreads = NULL;
+	struct perf_cpu_map *cpus;
+	struct perf_thread_map *threads;
 
-	if (!PyArg_ParseTuple(args, "s", &input))
+	if (!PyArg_ParseTuple(args, "s|OO", &input, &pcpus, &pthreads))
 		return NULL;
 
+	threads = pthreads ? ((struct pyrf_thread_map *)pthreads)->threads : NULL;
+	cpus = pcpus ? ((struct pyrf_cpu_map *)pcpus)->cpus : NULL;
+
 	parse_events_error__init(&err);
-	evlist__init(&evlist, NULL, NULL);
+	evlist__init(&evlist, cpus, threads);
 	if (parse_events(&evlist, input, &err)) {
 		parse_events_error__print(&err, input);
 		PyErr_SetFromErrno(PyExc_OSError);
-- 
2.48.1.711.g2feabab25a-goog

