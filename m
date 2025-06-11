Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04A51FFC54
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 16:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749657741; cv=none; b=AWjBV2J1krmw8Kzg1m3spffNJIi2c/35EnXvnnjCs3XijCrV2QjmiNqbHdrhggJL2v3zLF2cPxXXWmwXDQ0t08o4ZvUbzdk65ZL6p8oVCERsJYgdcP4TEc45shA+WcinN1ZFZghhrDBtPqQVMUYiFcoNPRj/Zwh52pCumhp8Z8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749657741; c=relaxed/simple;
	bh=d1DekuT4b+RpmHHw8+0cV96WV12ZXy4R3fduBzB7g5w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Cn/kTwbwLjDukEkguiwcFXZ1v+OMcQTD0xgGpU2AV6Eyn6Uw9CalASPAlp/N+XU2r0FglMkQRQTf+6jyg9R8xw7Ec3/uIsmilLpxq7RFe22Jf8KX95b+rSZMgTApvrYeC6Geha3xDRX5Quzol6lx/J9WXVgHIz+u36STf0mlbnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FLnMM/5P; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FLnMM/5P"
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-6044db45c83so33208eaf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 09:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749657738; x=1750262538; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oTVLN6IxdloaWx8kgCQ0wDt7X84NOVop+ZW7Gi+fQHw=;
        b=FLnMM/5PpuUqhOSDx3o5uLHsROaSmsQdKnHY1PxUQutDLsIBBq6ZQgpIDjhA7WN9Nu
         /uwQbLyRpl9spFqdWGf/LdCIt3d1SsmzovFPQDtF4GNX8N0JC6wEVAf6BI5MCWUjRcsl
         4BBKCuJ61oztvtHRdxw1Lvh+LotyNNTjJ4YrPn781x+UToi4UGCEE+wviTucVSA4s18Y
         KeaIMf7TquKj/tecORDQV6oQH1rkiFIzYopNfQoWjrIAkq/c7B3jgc2UCjlRwdwc+oOM
         eKcBmznXcNJmlv2d9TBWOMACq2qaoKqgWTGCvlT+Jol/rTaGtQXmWIWt8ZFbynCreMCD
         REpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749657738; x=1750262538;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oTVLN6IxdloaWx8kgCQ0wDt7X84NOVop+ZW7Gi+fQHw=;
        b=h+A+ecwKeAh4JJS0kACa2Vc5hr7jrR8xgnn5OP8ZiqajKkdKGHAcGrVl2ZjLC3IB0h
         SD8Ue7yISbCGmhpdM9AsdhgFaZPCFuvEOuhd7vHwBtphVHuTflM0p9/EU1gzy4H5vIEt
         4qlkxgPhEhkl2uacktVw6FwegtFqOewNjEWDbYAtNknkijF/pqOyeMHJ92o7DNL4auK3
         9pMnAiYO4Hnu3GBDu8D7JqxwN/5eeN+pavTfdiKXeW6m7+AW/+HnZoyhLrEFeQiRo7oR
         a3YUAknEeWqPd1/nGOPgAVfeR9G6bAcBJlOphlJLZi7eiK8gft5aWQuUziJrqAELpQef
         CRTA==
X-Forwarded-Encrypted: i=1; AJvYcCX16j0CvdZHS01aNYFsVuVyXRCvpovQOGWwe3+kW3lEHuWDaON2t5WP8+a7KRsrOTkAhhXuRafy+kSQE1CAyQeX@vger.kernel.org
X-Gm-Message-State: AOJu0YwD0/8kfypsdYNkHJmox606ZigfYxfV07kvpQ/RUKPouOUfGZG+
	/dD296RWgSCi/xwNFf5clIghHid7OIFy6q7xXOCEFuIRlbmDEtHveNjpRFvwyTXyhpH3Hm1pb3T
	pCvcW+MV6sA==
X-Google-Smtp-Source: AGHT+IFoiLMJunKuHfD7BZb5nMY0HFrs6B+9Eaj9hc+LysXTSVMx4Dk2+g+yzQ1Jzg4198wofqrSI0y+5ln7
X-Received: from oabxe18.prod.google.com ([2002:a05:6870:ce92:b0:2c1:64e4:adb9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:4309:b0:2bc:716c:4622
 with SMTP id 586e51a60fabf-2ea97039523mr2369204fac.38.1749657737845; Wed, 11
 Jun 2025 09:02:17 -0700 (PDT)
Date: Wed, 11 Jun 2025 09:01:55 -0700
In-Reply-To: <20250611160206.552030-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611160206.552030-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Message-ID: <20250611160206.552030-5-irogers@google.com>
Subject: [PATCH v2 04/15] perf python: Fix thread check in pyrf_evsel__read
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, John Garry <john.g.garry@oracle.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Andi Kleen <ak@linux.intel.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Gautam Menghani <gautam@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The CPU index is incorrectly checked rather than the thread index.

Fixes: 739621f65702 ("perf python: Add evsel read method")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 49e1db3feb87..b724478fe34a 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -909,7 +909,7 @@ static PyObject *pyrf_evsel__read(struct pyrf_evsel *pevsel,
 		return NULL;
 	}
 	thread_idx = perf_thread_map__idx(evsel->core.threads, thread);
-	if (cpu_idx < 0) {
+	if (thread_idx < 0) {
 		PyErr_Format(PyExc_TypeError, "Thread %d is not part of evsel's threads",
 			     thread);
 		return NULL;
-- 
2.50.0.rc0.642.g800a2b2222-goog

