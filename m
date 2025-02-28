Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD681DEFD4
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Feb 2025 22:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740781437; cv=none; b=czwPfUki1m1N/0B/zc1NHh/bAeD9ixQU0xGL70rg0Xltts5z6lSwHjbJ/NEZGGQRukFyuMpMqOs5yIoWarvZUTUbl4nI3rgqpeyue5jjVagwah/V4cu4p6iSHwocatUjlzCzX1VF/DKxn/DPHXAcnrlu95FVfJua+mwANI/gLxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740781437; c=relaxed/simple;
	bh=jw2JvCMwh40S1sqr4HtAsdcBJhtA5W1IjdOGgQVIXGU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=l9iFlKVGaRHexg+p1jrSeCASoPr2qZGgb+hTsQzJ9HmIFMcVJLfWuyc2uHo/S5xvStiAcs0Qx9wVCDPuTbkJ4k+YKUIpIG7+CceEBK9YHvh24fbGGI/oMbLmYi6GOe+Oosx7ofA28Y5N6pNk94aTvNCbmOwb2TzIaWJrntT3CFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z1wq6nRt; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z1wq6nRt"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6fd541f4b43so10614297b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Feb 2025 14:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740781435; x=1741386235; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=deGH2VjmLT83Kk+l97C6+20x9ip/iQR0QehEJSDELbI=;
        b=z1wq6nRtNA9tyaDFtU95Xm6NvOZ/3VfqHXJVgl/GIcv4N6UNZPeFJNfWlfkO6uiyuI
         aEiIWtCHHO38azHEwAa8JMjPU6TqcOzi138EsoVWikJR94uaynb08ZT2nF38eX0QptZx
         hBEVl0OiIKvOsFJQx/sI3NaBSxPkxKAFiTiEvuyEXt3awMSAmrd8BviudIiE/4cfYjV9
         IUGM+g3UDh8fFRtlLxF65WZK6LhJsh+PIxJ8Y3BJ6stoD9//FPrBgy/3eUl5sydqXt+R
         XctqMJVdn22Rj2ptqtDWxuECEjp6ayYv7J6yURYUlz1WnQAY4jXezzuV8aAgG88s5vd3
         Iybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740781435; x=1741386235;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=deGH2VjmLT83Kk+l97C6+20x9ip/iQR0QehEJSDELbI=;
        b=LPy5ygNmTr4zGtMkCxnCj6rJ95uNo1QV9w1P4g08uDU4mKyyDdALCYDPGsWLil4AM0
         XjBdTjv8OCkKOsfjPV9HWbPEieFQq4m9bNMIddDNJ1gKRgc6m41Hg3slRfEKBbfaKFnr
         7QJOyaIekJssSF1lE+iHjJ3e6YHvcaAFGbwv+gMeHwJPJOwOrpOIoegoLzeopM6na8gT
         yiHklhMEw4X6dLXlSZBNfRtxA8XFQVXtTr16KxDqI96U+xg5BRsSjP9XA6inMwvmzHJX
         SuPSQ8Omgqc/OImFmSmpDr1vd/XTRBKcXTkNNazh1wtRGo9/RKZgbSI50gYU0wcsONNl
         87YA==
X-Forwarded-Encrypted: i=1; AJvYcCWKdr0kFSJJpB/os+FohCnM519bElblZzJsMjn3tYdYnqsIEr4z8I39osT8arbqfGMLLZcCvjQHaf9S1Kfe7ff3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx64Dkn7VUdbhxGmP5PD1WfsDMW+sF5IXcsBfpaAOmjx32s3Xaw
	OtYWNlwHG42yorl4uZkMTqa4JbRRlen2zp4wEX/Do5uPeFhELBStSfA+RlIaEtVhs+H2d/QTGFF
	Hpp3d3Q==
X-Google-Smtp-Source: AGHT+IFE7d3v320fruJZDyKQRPxtYcFs1S4WGsj03GrTm6oN1eMjN5dQCeQksAPTYLlZWWAXkO95dI7pXbC2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:23a3:4d43:890f:dfd7])
 (user=irogers job=sendgmr) by 2002:a05:690c:528a:b0:6fb:78b2:8b70 with SMTP
 id 00721157ae682-6fd4a10fda2mr5924667b3.7.1740781435497; Fri, 28 Feb 2025
 14:23:55 -0800 (PST)
Date: Fri, 28 Feb 2025 14:22:59 -0800
In-Reply-To: <20250228222308.626803-1-irogers@google.com>
Message-Id: <20250228222308.626803-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228222308.626803-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Subject: [PATCH v2 02/11] perf evlist: Add success path to evlist__create_syswide_maps
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

Over various refactorings evlist__create_syswide_maps has been made to
only ever return with -ENOMEM. Fix this so that when
perf_evlist__set_maps is successfully called, 0 is returned.

Reviewed-by: Howard Chu <howardchu95@gmail.com>
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
2.48.1.711.g2feabab25a-goog

