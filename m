Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD03D2DC339
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Dec 2025 21:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764798436; cv=none; b=LdSl414feRpFXLNZGWE55ghbQdqChKNc1yDBAaT/5IXgkEYawvdyYbbn3NdT504nNqlABWjtD7tX0ZBrLYoGzETs3TZcQUaAVgx20PQQAY5AJJBhvZ9uNUFMvO9X1p5jVW08BbVX+VY5UDZNqv9Nqw3LB/9xiICPbO/kniBRmmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764798436; c=relaxed/simple;
	bh=RnRkqXZ4JTrwCm2Wz2Zuk8jh3jbWrplurAPzXjoLNRs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mawQIRLZGf6CuTbhw7pxHgvh808YKbpkCLFyysWys4Y9DOEvBIaiderGw3S8t7AYM30Ys9NymaGIqixxJo4Uj3krJpGx2yOWHt119vW/8y4Hogbk4LiEYxQaaGjQvg/2GqVDz1c4n7QGS1NhvupClFD3Q62UGTZvaFL2TzssZrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B2OugdYP; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B2OugdYP"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-bce224720d8so323005a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Dec 2025 13:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764798434; x=1765403234; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eOcSMNeJ/ZMXLpzeMBUmAqAigtJI1TPFFdhHf8jwosU=;
        b=B2OugdYPk/CQs+p3NCdKT+0vV5ZMaghUiPdabUb+M2wBGuTnmSo7R1z8SzAQJ0B41Z
         iN50Hxh2FebPyudNLMp9NAYuL0IHoxYwj55lSlWp5wzR9zYzxZy7bUzeaaZqjn45N5MS
         BBeVQQSgL/CWjxC5doLFS3PBT/QeW6+6BvWeO6P1+EmafzxbXPkiip85/quby+9h/QFQ
         XAJGJMLrVYvRM5/Ye97hSLGSAopG4r9KHvccWPjAAxXi18ln4XPAUT0Llme8QDZy+m/i
         Rx3atFvrX+ptxVDdsKC7b2BsBYtPTVNUJKMdppSCjoL/0fXIYxIMNLLYjA6jWjQxTCV0
         KFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764798434; x=1765403234;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eOcSMNeJ/ZMXLpzeMBUmAqAigtJI1TPFFdhHf8jwosU=;
        b=PHFs5C0f5OPrg8+q6LJYA5WEj6cHrzqADQzDElPlxlCQyz06rtORUjBmLvFU+9WNI6
         89KVCKFMrBubF+xFXOpjLrhBwpaCynsWST79odccyrRZ2sUvqlWJtOgqBKbdorSKQMsN
         v9X7lh5xy9HoIy0LNl+hEEY4HRr1aCEn2sd9FnfZtmDzuggU/0HCfN74puLOOXRuFoGl
         b7c/wjQwno8HAAQfwQ48NSQ83Klb1UoPymlgECvfrRWncLD2BCsEcuQqwRJk3EztAeCj
         6wMRoDjqI3DBRSQgxuuG3OwuxkUDA8wEYz8bGoq83I53lZSNWkKPWJeIBZt0efXHDV5J
         3EfA==
X-Forwarded-Encrypted: i=1; AJvYcCUx2fV7HSR2kHpy0SXMJ1IVCPmKFpVRrjGaAXVnCgfaSXbrhc3vZK9Ulbp1xAQtpM8mY90ngnADB36CgyL+pYF3@vger.kernel.org
X-Gm-Message-State: AOJu0YzGX8VGHYCYNsAMHEXxIl4vIWRl0a5Re/SyUBXTPi+HpCMn3Stz
	V8z6jDFZiu0+2j5sqy7XZb8H+Y5LTBySj4lo+HKutG1HtmsnMLO0LrjrMyDxNyWbB3JrbAEd23k
	lGSxLVsO4mw==
X-Google-Smtp-Source: AGHT+IFm5eUCWRwz5Nfygqjtwh5PieLN6MVOHBcL6m3z8SCNLQ9bZBKQIdp75woC2gQZxpW8S+MHehpUntax
X-Received: from dyjn15.prod.google.com ([2002:a05:7300:a8f:b0:2a4:5a4a:cc6d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:b0a:b0:2a6:d0bd:4a07
 with SMTP id 5a478bee46e88-2ab92e52960mr1991364eec.18.1764798433998; Wed, 03
 Dec 2025 13:47:13 -0800 (PST)
Date: Wed,  3 Dec 2025 13:47:01 -0800
In-Reply-To: <20251203214706.112174-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251203214706.112174-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.177.g9f829587af-goog
Message-ID: <20251203214706.112174-3-irogers@google.com>
Subject: [PATCH v2 2/7] libperf cpumap: Fix perf_cpu_map__max for an
 empty/NULL map
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Passing an empty map to perf_cpu_map__max triggered a SEGV. Explicitly
test for the empty map.

Reported-by: Ingo Molnar <mingo@kernel.org>
Closes: https://lore.kernel.org/linux-perf-users/aSwt7yzFjVJCEmVp@gmail.com/
Tested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index 7e88417ba84d..4160e7d2e120 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -368,10 +368,12 @@ struct perf_cpu perf_cpu_map__max(const struct perf_cpu_map *map)
 		.cpu = -1
 	};
 
-	// cpu_map__trim_new() qsort()s it, cpu_map__default_new() sorts it as well.
-	return __perf_cpu_map__nr(map) > 0
-		? __perf_cpu_map__cpu(map, __perf_cpu_map__nr(map) - 1)
-		: result;
+	if (!map)
+		return result;
+
+	// The CPUs are always sorted and nr is always > 0 as 0 length map is
+	// encoded as NULL.
+	return __perf_cpu_map__cpu(map, __perf_cpu_map__nr(map) - 1);
 }
 
 /** Is 'b' a subset of 'a'. */
-- 
2.52.0.177.g9f829587af-goog

