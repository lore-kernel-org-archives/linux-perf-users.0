Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746F8377EB5
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 08:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994176; cv=none; b=i0yTEFs16zhxmRnsx46dQsZQbJIbJAqeE05xQMPtJYxOVmgGoatscpFgf3bs/wndrh0bGorSPZxKjle2k9CikcKbzNlD2ZENRc5+mlCYPd1QIvyPGaYU6Jvt78qD0ZnMgvQ0ZkEvcfQdsEHYd7Bpd6/0fL2ItsySJqPMQuc8c88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994176; c=relaxed/simple;
	bh=DVFz0me6prlqmOZRJuHgLBjq4/TJp1BgBDFREufIWGc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YboZYD7Qne5aqfHSZlpkKqvxdeo1fHJwMbHNqqP+wSrZvZJEz69UyMMBTjXJp7f41d3RiRGvDqy8GFXJEBP9W0e9/O0bVlt1R5JgOgq19fzd9rE/OdRvUHBhLxUmgnKxQujhnP5LHsgVvf6czbaWTCkOEoaHE1EsxbXUmehJRbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LAG1fUow; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LAG1fUow"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12721cd1a2aso20250073c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 01:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773994175; x=1774598975; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H9w9UzhqInn6IYvlRecfZ1X0RPnPfXjSSvFkmfIoAts=;
        b=LAG1fUowsjI8mHWEX/KanqI2jf9nValB1t/VFNpVJ5almEBHpqOYU3anPY3FUT81JS
         Ye9qsz8ho8z3lFb/Q/duF/lR3HrQfPiutT0SIoOA4ONp/Pfttt6abgksXcf7kI5YWGeb
         b8+YcdPGnKsY4900jV4CLbA+kUl3PKOByc+2OKHu93nNHBrerwerz7Wnr+graZqgYil7
         7N4NUrEK9XpF392IR3tyFd+Jj5lAL/tp/9HpvkK03JFtyJ57+Jgm28ldNKr+0UGGCqpB
         IRFxfDpwa3TcHol2NjPFE/sK2C+nGklS9k0+D796zHBhfDj7IFoNziOqJ4nzVqvIaNpI
         0GhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773994175; x=1774598975;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H9w9UzhqInn6IYvlRecfZ1X0RPnPfXjSSvFkmfIoAts=;
        b=ca1wR8ghosjRcA7BBspvGQ6Bcl4HkADEt5+Mvuz1sM6bSKXjx/VWpfdhcGPfpR8x1j
         dQICs6R/DiwdBsg1yd26eY+RZ5dFuaCJOb7wQF5EnkSDE+L9Ezp60xXXrm9qYjObLlIU
         ZcaejGIXFSjbU2HgQtlzK8e2G4Z6NkOlz3B5ezxKgjIiK2feMRCHxHuetOnmuiMtSjWJ
         xPhn4uYENH8KygFn8/Q/lxS9zKpZZbKE/SRNZH6X9IaZsysLOMERwSyWPgYmDVOVezCt
         W5f1Sreof1dYFF4k9QQ3CiOGW8jLylzoXQAhK0DTff8ggKD8yN2uS04B/Grc5WVEsXvD
         OFrA==
X-Forwarded-Encrypted: i=1; AJvYcCX1a9BgHVaDdFE4UnGiX1dH3DdaIQUlRdxC1Yy8o6h5I7QDCdmiyae8t6UjFWlOqU1pPVsd0+tSL3VUnn7wRCuK@vger.kernel.org
X-Gm-Message-State: AOJu0YzaVfX4HWh3DfR5MMUQTbmCc/b+92AcFVd0qV01pL2r18vvQMTQ
	oJBFzPcCHFw/lmPoHPiopzatXA/MS7mueT2XmpnsPlvoBgBGl+u0DxRhqtExubOMplhhahnACkO
	JcakeOlcBbg==
X-Received: from dybta13.prod.google.com ([2002:a05:7301:6f0d:b0:2be:b4eb:b056])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2227:b0:128:ce44:be8f
 with SMTP id a92af1059eb24-12a726572c7mr1029687c88.2.1773994174288; Fri, 20
 Mar 2026 01:09:34 -0700 (PDT)
Date: Fri, 20 Mar 2026 01:08:33 -0700
In-Reply-To: <20260320080835.724836-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260319232334.287517-1-irogers@google.com> <20260320080835.724836-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320080835.724836-25-irogers@google.com>
Subject: [PATCH v3 24/25] perf s390-sample-raw: Don't pass evsel with sample
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ajones@ventanamicro.com, ak@linux.intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

The sample contains the evsel and so it is unnecessary to pass the
evsel as well.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/s390-sample-raw.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
index c6ae0ae8d86a..bfa342536b9b 100644
--- a/tools/perf/util/s390-sample-raw.c
+++ b/tools/perf/util/s390-sample-raw.c
@@ -284,8 +284,9 @@ static bool s390_pai_all_test(struct perf_sample *sample)
 	return true;
 }
 
-static void s390_pai_all_dump(struct evsel *evsel, struct perf_sample *sample)
+static void s390_pai_all_dump(struct perf_sample *sample)
 {
+	struct evsel *evsel = sample->evsel;
 	size_t len = sample->raw_size, offset = 0;
 	unsigned char *p = sample->raw_data;
 	const char *color = PERF_COLOR_BLUE;
@@ -332,14 +333,16 @@ void evlist__s390_sample_raw(struct evlist *evlist, union perf_event *event,
 			     struct perf_sample *sample)
 {
 	const char *pai_name;
-	struct evsel *evsel;
+	struct evsel *evsel = sample->evsel;
 
 	if (event->header.type != PERF_RECORD_SAMPLE)
 		return;
 
-	evsel = evlist__event2evsel(evlist, event);
-	if (!evsel)
-		return;
+	if (!evsel) {
+		evsel = evlist__event2evsel(evlist, event);
+		if (!evsel)
+			return;
+	}
 
 	/* Check for raw data in sample */
 	if (!sample->raw_size || !sample->raw_data)
@@ -372,6 +375,6 @@ void evlist__s390_sample_raw(struct evlist *evlist, union perf_event *event,
 	} else {
 		if (!evsel->pmu)
 			evsel->pmu = perf_pmus__find_by_type(evsel->core.attr.type);
-		s390_pai_all_dump(evsel, sample);
+		s390_pai_all_dump(sample);
 	}
 }
-- 
2.53.0.959.g497ff81fa9-goog

