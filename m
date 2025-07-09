Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3399D25D8F0
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Jul 2025 21:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752097256; cv=none; b=RlgocbXufNo04koj/IB3rGw8Ic5CDkPpVe6WV7LJ0CoFdk8FK1JkCcqUaPrDj3RZV90rFb5s2oCRTJznIQoG7QOJrUbQhxDLRE0nJ8OhywxtIZSLgwWpINdLbosHQVfwLEY4qyxsw3n8SzRm1YVQ44zySb4Yq/YgcFhYu9/Oe0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752097256; c=relaxed/simple;
	bh=vOwZDvr9Vl8FEdFAuVf8wVoxDa4D0UfmaiOanE6AyxM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ToFSCeATDI2wLpmwXJGPcIwecIT8Q7c64klh7jtMEYw/YsRlspw0PmIhw26v0e/LSQ5HkLMOQBDksV52qnlA4fL4teRRWuX8m4L9f+SCGGorO15l0zdT1RRhONAXrNyrLgGXsnar6stgKbgh2zbF+OmB9p0P8cOc5Bn8sQGsWuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SoSabULx; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SoSabULx"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-315af0857f2so373473a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Jul 2025 14:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752097254; x=1752702054; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P9BHuR06NtQbT/Ectw1+ZMQbL3vfn86FK+37sdptByE=;
        b=SoSabULxdVtX4WWyPkkiZ+4CzrvKw/H9RBlB5LaMNlDbljihg9v3Z0IhL0pd0HS0c7
         TlwsgPw5Ml7ODEvTgzPYXRKAkZyWS/S0ZXCezhu7Nz+a3bVcKIcmkw62nqEqKH1U4Zqs
         ejVuzLswOpjeZK+qTKxpCj8OaF1GbRKGn8wyYtL31mReyflYHieLB1gUM1SZw1kICs42
         KuC6mGeiZeZB+tCWR7Fppm7I9X5rkTOlSSFp5yC6rGrvd5EZtUuXpO4qzSIdbSX7t55a
         oydIAq+eaLhIMNWLo7x5T9gVSSmcLWEZmbSFlw7JVla/MT1s1IESeXMQ675eHkEVsy8X
         RQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752097254; x=1752702054;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P9BHuR06NtQbT/Ectw1+ZMQbL3vfn86FK+37sdptByE=;
        b=pv0cqT0SPiLAo2syEYnVM6P83WtQHdPE//DR88xIdGuu6zumx7IX3j/FviK+tEiU4e
         vI5Oz1AH7CVfj8GdcGMhxRvQL7oTu39YB7J1LcO19m6ybGdEmeWuczYDGzVwwIsn/efS
         FU0j0uDP9gu+3/wPUv5xslEGBtgG46bUa7HODC/NmnTyZ/qZ1rHlaIClFOiIPT8aBWVe
         4mODtXx3Yl4YemBa7heLo6+/hfN0hvkLi802jlVorMCPQEeolllrwllAXKRzW8df3DxN
         AvI1lVWH2eT5Ev5wfSwekrm8r2Cz+eLTfXrT/6GE2u0bubTY1jKYeuInjQr8bo600Ucw
         oeLw==
X-Forwarded-Encrypted: i=1; AJvYcCXhzS4aTb+H4Tum/WKtt6smTLxqIf7i5V9ggbIkHQ9cYDbKOviNrioFSd1L5H8/50vzJ4YCgMh8kPNN82Eqlwkh@vger.kernel.org
X-Gm-Message-State: AOJu0YxhxIrm4KgZJ4LSwJ5svP2mF74QOFf0xRYJ55CxVRLP+Qyf6Sv2
	qP4EGGI58xRQTtiEnF0SFoB9oTdr5OawPX3MPmrOE0Dvvj7x5ip7LqfN0yFzA/u4Z5WamfYAjhS
	SEZSvNeBlzQ==
X-Google-Smtp-Source: AGHT+IET4wDIl8RWHQ92JBgsF3e1FcY+s+Ox/E3fRRO5h6tw2hx4TVcghr6OXM4+cGpdN8tZCfY3Osn5sSmw
X-Received: from pjbqd13.prod.google.com ([2002:a17:90b:3ccd:b0:312:26c4:236])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3512:b0:311:c1ec:7d0a
 with SMTP id 98e67ed59e1d1-31c3f03f810mr234327a91.25.1752097254579; Wed, 09
 Jul 2025 14:40:54 -0700 (PDT)
Date: Wed,  9 Jul 2025 14:40:27 -0700
In-Reply-To: <20250709214029.1769089-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709214029.1769089-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709214029.1769089-11-irogers@google.com>
Subject: [PATCH v1 10/12] perf python: Fix thread check in pyrf_evsel__read
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
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The CPU index is incorrectly checked rather than the thread index.

Fixes: 739621f65702 ("perf python: Add evsel read method")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 0821205b1aaa..4a3c2b4dd79f 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -910,7 +910,7 @@ static PyObject *pyrf_evsel__read(struct pyrf_evsel *pevsel,
 		return NULL;
 	}
 	thread_idx = perf_thread_map__idx(evsel->core.threads, thread);
-	if (cpu_idx < 0) {
+	if (thread_idx < 0) {
 		PyErr_Format(PyExc_TypeError, "Thread %d is not part of evsel's threads",
 			     thread);
 		return NULL;
-- 
2.50.0.727.gbf7dc18ff4-goog

