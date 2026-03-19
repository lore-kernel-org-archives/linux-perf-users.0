Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B692B41B37D
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 23:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773962698; cv=none; b=uFH8GSWwNgMjyQsyTPPAACMum0EsoZxuyYp0RgiqWxUPSwb6GWU+BPrUTa+ZEVLR98P/z1Nuy15moQJ4QXWn18RJFEzg3euiWSPTlVZ8JJ+zCC/JJk8O0QNGA99KO5dZEQVH5vWn2lGtQZr9pQuxfOXAizumF2xCV3ADGZdxdSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773962698; c=relaxed/simple;
	bh=DVFz0me6prlqmOZRJuHgLBjq4/TJp1BgBDFREufIWGc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kIIsThfEmEbLm/Pzozrn3AL7ffaszxdOAJ40ULs/wfIJYCOUUuXoP2vstBudL6/WO5Jr2bbHj+jwj2WiI69fjlsjpi4QvbsJzSTXJmGz1MzA/LJ65ovpTyjqf+xCcVzKR8D2A/NBF0z/sO8RKRtT71PKzAlo/pXqvAGyQMDGBOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g6wQ4Iig; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g6wQ4Iig"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35ba237d2e0so86387a91.2
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 16:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773962696; x=1774567496; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H9w9UzhqInn6IYvlRecfZ1X0RPnPfXjSSvFkmfIoAts=;
        b=g6wQ4IigxTsd/h4UZejtZz1wZAoqG8fvcrEewoBuXqcTHrhGEkmvl74HTJV+7Qm2tK
         X/Zgfx3FAoPqQvodEAX74DInGBXHJATqdfFAJ+aFmv0LVHpKYjYGljhKvtCVXpDoddf2
         Q63hr+4P9fZNPa/Tvkk4iBJHnNl8kcV9n9EDdG7ytn2m0RljAd9uhdKF+vdFcQMp85mA
         aPJH6+k5psVk0kkFLyU0TfAe9i3LpcnJEIR83pukj8ZvyGFpl/Yt8g6r/KitqUz9DIbH
         6GnxC1G9j/IGzLbMJICU3nfK+Kk2hTz/fBq7opkkjI8qZEXro5YmLGIEz+OCVMlYBcg5
         MvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773962696; x=1774567496;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H9w9UzhqInn6IYvlRecfZ1X0RPnPfXjSSvFkmfIoAts=;
        b=bIo1PPOWg8ErxRABotEyGS6ESuggzlRb7gMce3rl75uR7fE6zcGLnrwHE2VsuYuf3J
         AqZQ2NPv4lsQmWUpQ24T8k4TOe4QUi7LW4Xr/HBHK/pZ5L63fWiQaFdQMIVoKIi9hwkg
         WmZWmetfZ95qD3FmQjjLSYtJNb6YGj56TTyZdys3vZ/lYeFw6VRQ5YmH9O+0YEb4GHim
         2DROyZtPMNtb7dJ3kgfr7EOyhAMs7Gte2S/DqUVz782fqG2K3w9yRi/mUhWjxcwVB7tX
         bw8d829Qe+E87IeKrAvHb7tkKX8TYczh/itjBxLvDO30WNnTwVLVcsgzZM1j7q7vM1M4
         k2qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGATtl5VqWpT0JY+ZzkslZPS3zXINneXjGyXYI+3uvz1L1fwVnsoEFOwWMI1MJSvjG4V+8wXCR1JOxjlVWCHiR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3oE3wU6h/t/btDClPEbloWGVX03qnhkGlB9i+BC6xnFaYfK1V
	zvyqS6mtGqEI3iYESURTdfi0bZQVP9sIR30WN7KL6fYQPblzBKMRrF3OfWBz3LoAKyJmuN4w9C9
	ri3GBvPLYzg==
X-Received: from pjbbw10.prod.google.com ([2002:a17:90a:f60a:b0:35b:9c71:2d38])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3907:b0:35b:97e8:904d
 with SMTP id 98e67ed59e1d1-35bd2bf5398mr699189a91.13.1773962695804; Thu, 19
 Mar 2026 16:24:55 -0700 (PDT)
Date: Thu, 19 Mar 2026 16:23:33 -0700
In-Reply-To: <20260319232334.287517-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209174032.4142096-1-irogers@google.com> <20260319232334.287517-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260319232334.287517-25-irogers@google.com>
Subject: [PATCH v2 24/25] perf s390-sample-raw: Don't pass evsel with sample
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	ak@linux.intel.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	derek.foreman@collabora.com, dvyukov@google.com, howardchu95@gmail.com, 
	hrishikesh123s@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
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

