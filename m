Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB39307494
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 23:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752191546; cv=none; b=nu811pCwH71TfW8sEpb+blrTEzu3EWwHwH5d72skHOeVFBOvSDgiCDgWTVS+aluWhcsK3czh1TfEKxEmd6aRZL2ORzlxkYisObPvCkuyOldCv4imzdNDTbOR4BNOkj9CoAMmzNM7whR+UZHCZSl27HHT92qIjigYs6O5acFNE34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752191546; c=relaxed/simple;
	bh=m3mVuOV+FjGGQZSQOa/RyvRh8gyTPqaU/j/jeYS6pP8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=r8gG8m4MVOMSkf9OXuYkY/kB/NXCcxsctoQ+mpaVpXOuz1ho/77fgwvdxQS12iyZJwxnuNG63oNUpDckzdU31qOTym7s93BZgWJvJ52EQFzS6qhPCHb1SMVcbw+NemfTbb3Pwml6DgU+0FGkpzFPL1xhz3maFYUHuQXiIq2GXrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qwuvr5lO; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qwuvr5lO"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-312df02acf5so2119556a91.1
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 16:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752191545; x=1752796345; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bKKjyG04zvY4B3Cxa079gRu3GQTHZmfWcF0bIyCmCUs=;
        b=qwuvr5lOwwqVPQTQsMSGw0l30jY/H4mszQ1VzIOx5OO2KBF7MUdi6kOlaAwOjw3NdO
         yKwH+olDcyKIeY0Y057UQMA0jX3ocn4AatrS08Fya5H6gEq5Jd+/SugcrzrrPRLNMYTU
         i06G92xBBsIOzWTYcoIKCe4cFsMFQgQLRV8Df7ADCYNEn8EulimyX5ln1xLCdC9/7CmQ
         aHIGN/EDULPC9KFIeJxnVAhYJ/TQ0cq6AMuURrwNYC0egyGXryP4fVK9ySPbupoWQn7x
         QOLXhKEniDBEDtdNCSDT1AMZxdocNi1f6vkXoxbxi5UNQaC5QvMNL2zRWpdE6ibWrqxp
         eG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752191545; x=1752796345;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bKKjyG04zvY4B3Cxa079gRu3GQTHZmfWcF0bIyCmCUs=;
        b=exypR+FCnsWK6CZga05YO8a/zfsN9fo3SQZieCRPzw2OJG0L7lRKwO+Mdwy0bDWwaN
         S+7ZcbFNAKc5qLANM2kWuG80y1c6h8weOXjzX6q7ODg23SmFnqGkkg/OF7/iprGw30cT
         Q74M29lkLO/lFcaYxHL3t6ja+iCZFLBW+YKWN1G75XGenlFM9thHNIoR//aLkL/m64yU
         a+tQqJgeH4FIzj3f49d8O0WsV9NVaewXfleZVjsC5bRJqgdZfIJgEZs+QoGJV7OYcGBX
         dB1dt4B4rf+X/hSsAlDrs84EkKTxFIUNklzobsFu40cqe5nI25L92K4JqN17LddSvUp4
         dfgA==
X-Forwarded-Encrypted: i=1; AJvYcCUMWDKMDStgZPY9z5hQcVflYjlZPyCUAYNZeahQBDx+lVqrbsR6H/Dbj+Bk+UhU0iBHnVY5ZFYsPxmJY2uaWavY@vger.kernel.org
X-Gm-Message-State: AOJu0YwsbrbwH1kyg1LzNvYZrrWQdqGpA0F0YMjBpKMuQdnbz0VUFQqA
	XdtK1GdDY7aEzoW5CxHm5IBT3H0y2+UK75gItPqYNpExNfkpn/2lECrtduiivyjCnkvvJmerqjp
	k7QofP6Fksg==
X-Google-Smtp-Source: AGHT+IEft9H81ix8+PRtUb8fGu0rx8aTovDOrMeNFLdvqd3XCOAMP/4bRQbIg7tplRXJRqSEWXoqJsDp6j+n
X-Received: from pjbss4.prod.google.com ([2002:a17:90b:2ec4:b0:31c:2fe4:33be])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2b50:b0:30e:6a9d:d78b
 with SMTP id 98e67ed59e1d1-31c4d4d0740mr1354347a91.12.1752191544776; Thu, 10
 Jul 2025 16:52:24 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:51:26 -0700
In-Reply-To: <20250710235126.1086011-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710235126.1086011-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710235126.1086011-14-irogers@google.com>
Subject: [PATCH v2 13/13] perf python: Set index error for invalid thread/cpu
 map items
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Howard Chu <howardchu95@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Weilin Wang <weilin.wang@intel.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Returning NULL for out of bound CPU or thread map items causes
internal errors. Fix by correctly setting the error to be an index
error.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 1d9fa33d377a..2f28f71325a8 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -529,8 +529,10 @@ static PyObject *pyrf_cpu_map__item(PyObject *obj, Py_ssize_t i)
 {
 	struct pyrf_cpu_map *pcpus = (void *)obj;
 
-	if (i >= perf_cpu_map__nr(pcpus->cpus))
+	if (i >= perf_cpu_map__nr(pcpus->cpus)) {
+		PyErr_SetString(PyExc_IndexError, "Index out of range");
 		return NULL;
+	}
 
 	return Py_BuildValue("i", perf_cpu_map__cpu(pcpus->cpus, i).cpu);
 }
@@ -598,8 +600,10 @@ static PyObject *pyrf_thread_map__item(PyObject *obj, Py_ssize_t i)
 {
 	struct pyrf_thread_map *pthreads = (void *)obj;
 
-	if (i >= perf_thread_map__nr(pthreads->threads))
+	if (i >= perf_thread_map__nr(pthreads->threads)) {
+		PyErr_SetString(PyExc_IndexError, "Index out of range");
 		return NULL;
+	}
 
 	return Py_BuildValue("i", perf_thread_map__pid(pthreads->threads, i));
 }
-- 
2.50.0.727.gbf7dc18ff4-goog

