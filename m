Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003F221481E
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jan 2025 07:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736409083; cv=none; b=GiR4KfW4IDsSGwDXOwOxuDbuleI8Kzc6zrP4uWQfLZE8hhbF4d8iSoaUz5TMMnIPqCUucQimqXHGefStjoQyxflkrGXjNkCUDFbhRs4MHNptfFR8hfwewpXnCPs3HvUybAvqHOIoJV7mhTOcsBjuKIVcCPEf4IX1eARVAsSmGm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736409083; c=relaxed/simple;
	bh=l3rsftF8R/Lbyc2l8yy+s7iBe/R5ucGrbpLeFvVhTAs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=SulDAGktHterGFOPyvZC61E5AscIRiNGQcIxVPH2h30cgVC5Zs5uTW/XjoRHq8W9loaRFdHJ319xq5AoDm5T5GOjXICBBExcAF8eAPNw+RVzQdefbV5BahHMdNfIRxUNbKAiXL8pEKC0jE850AI0acjW7xsV3SpTP9JU0ZZczWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iQe7xpUw; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iQe7xpUw"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e544c8dae18so1580213276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jan 2025 23:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736409081; x=1737013881; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BR5b0II9MP8kbiarazKtxJYt5Ueqv9IehOmdPFNXrQI=;
        b=iQe7xpUwzABl8UOGPHFY5lIKIovakAdgjGsUimb3UMcJprT8+RywvlbWE5naqviDrs
         NrzV7wXMAPVE9xDgIu5EVdtkVG5mnizPGJSR2vtXqmB2+XFvozOp8qPLpWhsmEk2s2St
         i8EktFY8LaTc+GcvKE6dpq0rgsHYw3L4c8WQihUQXXrtfs0Wu69tudPnSPeRFQb3zida
         /oj+ao5X3KqtSoAfMhQC8VYM4B7uUNlM5kDiLiXQ/EeRCGovFkjoh/BE9B8AksihlViC
         VVzhHHc6dYDtf4t/rFnZCsk4Eo3zxfeCaM0rNx3uCxWUj4GC3lg9Wf9HA4ylH/4RCPvm
         uOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736409081; x=1737013881;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BR5b0II9MP8kbiarazKtxJYt5Ueqv9IehOmdPFNXrQI=;
        b=doGTPLluuINyYL5D/NCxuYSvi2uoZoUDodVis8ZAzjD41BUl8TYLliFC2e203T9+6S
         Xdo51lDqnYX+2d0CuxrRJ/BWSfrKgQYc8u5jd6UVYPqrOhrrP6gyPeDdgzecDJmQe09B
         nhz69O0j1Jccbm9DzzMmtRLHomJE+9VLV63E493ftCyIFB8W2qqlhRMQ65OJAKXQ6GAp
         wA0at39+cdCwQ5/DqG5/rn8HgO3FCG8GK0nCj1GunSI/nEgchMpnfrjEM5WUUskttvnY
         cJoO4jevjrstlSr58Lf21epliz8qCzL8cvpvCBxHlhFrVGx4g3Lt9eHn0mipZKzhj4fn
         zgCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWluTIYs1K2d6Or9hrb9ulWQ+o5SI7jk6EvIQrLg1Fy7Hbr0WTJyNRjkcHYwpUOLUZ51uYsOJp5eNmvDyTdcSPe@vger.kernel.org
X-Gm-Message-State: AOJu0YyIXaKAnKYuDXDiL8fQtq+JR/imdMMitRbilBHPB57RW10nEvcW
	KCXjkCpJYC7zmqcaFjCWwwD2J2vv+1IPMjqsu6+WBndJyMbVgcsctNMInJ2RwsD4tfAIFuvQpGn
	WJpLodw==
X-Google-Smtp-Source: AGHT+IFaLpuzEz62THI4YJQg5UCkmxrc6rOT4j4MT0fvtNntW9tGS36QfwR2+cn28xMqnY1sGhdl7efGDtAM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:f801:f788:c7e5:c181])
 (user=irogers job=sendgmr) by 2002:a25:ab65:0:b0:e53:d953:90a8 with SMTP id
 3f1490d57ef6-e54ee1388famr13080276.4.1736409080861; Wed, 08 Jan 2025 23:51:20
 -0800 (PST)
Date: Wed,  8 Jan 2025 23:50:59 -0800
In-Reply-To: <20250109075108.7651-1-irogers@google.com>
Message-Id: <20250109075108.7651-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250109075108.7651-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 02/11] perf evlist: Add success path to evlist__create_syswide_maps
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

Over various refactorings evlist__create_syswide_maps has been made to
only ever return with -ENOMEM. Fix this so that when
perf_evlist__set_maps is successfully called, 0 is returned.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evlist.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index f0dd174e2deb..633df7d9204c 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1373,19 +1373,18 @@ static int evlist__create_syswide_maps(struct evlist *evlist)
 	 */
 	cpus = perf_cpu_map__new_online_cpus();
 	if (!cpus)
-		goto out;
+		return -ENOMEM;
 
 	threads = perf_thread_map__new_dummy();
-	if (!threads)
-		goto out_put;
+	if (!threads) {
+		perf_cpu_map__put(cpus);
+		return -ENOMEM;
+	}
 
 	perf_evlist__set_maps(&evlist->core, cpus, threads);
-
 	perf_thread_map__put(threads);
-out_put:
 	perf_cpu_map__put(cpus);
-out:
-	return -ENOMEM;
+	return 0;
 }
 
 int evlist__open(struct evlist *evlist)
-- 
2.47.1.613.gc27f4b7a9f-goog

