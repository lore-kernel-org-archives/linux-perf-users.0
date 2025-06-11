Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DCA1F1317
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 16:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749657737; cv=none; b=B+PzeJtEtlvChRSS4ePTVXQ9yYsw335rqCgO7dbEpIsvL8rw4bTDKQQqD+0uJ/ClkccdytvvBOdKUQ4hNSmuNfQhW1o0CDOzBZR2iDgxyZTg20cIfhYXtE6PMbAYzKxsTwDOQp/LWKPT1HkgqF61fmP3pCO9P7EwUO1w/FdNnb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749657737; c=relaxed/simple;
	bh=BtcOquUGwsjRLqbBlkEJh0ol3cqkffLVbzVijupKQ7E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=QG400NYcaZr7gxygaDQRVUplauZ/8PrEQz6kN2p1voNoNqxrZtMtMwkadSfwGt2EF+oyMfoNhc+2pF8LyzDYBx5A/mRttqxwhdhJ7xKOWe7pXy0t+2UXtG6HgfWJx+jhbLs/jKzFdz3ocUUg8jZyfM7Ad/om8n3Kk0t3VBhGHQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0XRYq4QJ; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0XRYq4QJ"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b16b35ea570so6672844a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 09:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749657736; x=1750262536; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f5Xx6iphroRaR7e/xw5HkqxmSocnFfl7rcbz//2QDaI=;
        b=0XRYq4QJBEV/Yne39+4MQlPwZ6auG/asLwzIAqUIKQtMABpkswgsnj9VgFyKpQHY58
         W+Ue7AGFJkmOqd4PflQU/1QkXsxwM21H5jkMMkwWxPkGigHxzPh0pUSfj9D5amTQb+vm
         70R43MAnCVUOlY5W+MajBGWju1MX0TBU72ZU9H0sAKfu2JSAd2S0UPMR1PUqYN/RwflK
         hrZda2rc38ZAUuXkwfGlmBVaVFvFZAuquXq7/v3XvKcWtQ86gUTHhyK2TorlF3eEtHlI
         ptIr0qTH/qE4wfRpTw19XwrLs2bZyyCwdC9KL5AFhFOC4mqBVCxxHFBNdVO0XYFtE3pU
         FxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749657736; x=1750262536;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f5Xx6iphroRaR7e/xw5HkqxmSocnFfl7rcbz//2QDaI=;
        b=rZQAWo8sp3NfUbPS9/izb6YcsuSxYl857TMGnHQYki75gXi85sn8LqPc1zYylxE1H8
         /4a+rnktZQQhY+iQ1Py9pYaGlJ393tOV3jGNl5dHLzTaHXSfsk5TS/x3X/kBegltaNvZ
         Crx1QLCTIJiNF0d6BmF1jIxS7mehaeXUNv1IBUlJ/FLor94E1u9Db90CxnTQytk6qUrv
         6D0wZbq6boqLzS+sAM1ekH1QomsuwNXxpUeMGhRczHtz41/lVGNdcGO5lVd61fUyg54u
         wuqjMStTR2vmg5I9wadzpA+EtUaNNnZQ2gnb9qMbeqU2Q/1xfITnk+f2xH2lKJdunGkx
         TcQw==
X-Forwarded-Encrypted: i=1; AJvYcCVcrOcMDTWlgvGOUnocjGxvI2lw5pGG8IXL7tC4M/KWFdr1HLH2gZtSjGqy7+9ZJnfgBS08RYwoisejzV0cVMjl@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5v4gyK0rhgoXZ8piRrGHdN0GlFVmDy7a/C9s8LnGCVWJXEWyj
	wtwB3VhMt8yCInLUuCuqA3rqHIznc7XnSen6rxWBO0oHyWpasSW5+2Z2vkXm28wmu7vZvbNhDw+
	4y0Pmxdr5Mg==
X-Google-Smtp-Source: AGHT+IFAkRbgSlWhSoM6PRzyRRiPAqWwAEoNMW5/8t9gaYd2P64BUSTvoB7DysOP5MYkv1aet9iGtDpbV1+3
X-Received: from pjq7.prod.google.com ([2002:a17:90b:5607:b0:311:462d:cb60])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1dd2:b0:312:959:dc41
 with SMTP id 98e67ed59e1d1-313af264ec6mr5574694a91.27.1749657735660; Wed, 11
 Jun 2025 09:02:15 -0700 (PDT)
Date: Wed, 11 Jun 2025 09:01:54 -0700
In-Reply-To: <20250611160206.552030-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611160206.552030-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Message-ID: <20250611160206.552030-4-irogers@google.com>
Subject: [PATCH v2 03/15] perf python: In str(evsel) use the evsel__pmu_name helper
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

The evsel__pmu_name helper will internally use evsel__find_pmu that
handles legacy events, extended types, etc. in determining a PMU and
will provide a better value than just trying to access the PMU's name
directly as the PMU may not have been computed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 82666bcd2eda..49e1db3feb87 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -924,10 +924,7 @@ static PyObject *pyrf_evsel__str(PyObject *self)
 	struct pyrf_evsel *pevsel = (void *)self;
 	struct evsel *evsel = &pevsel->evsel;
 
-	if (!evsel->pmu)
-		return PyUnicode_FromFormat("evsel(%s)", evsel__name(evsel));
-
-	return PyUnicode_FromFormat("evsel(%s/%s/)", evsel->pmu->name, evsel__name(evsel));
+	return PyUnicode_FromFormat("evsel(%s/%s/)", evsel__pmu_name(evsel), evsel__name(evsel));
 }
 
 static PyMethodDef pyrf_evsel__methods[] = {
-- 
2.50.0.rc0.642.g800a2b2222-goog

