Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5277C309DB7
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 23:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752191532; cv=none; b=OYM0EaaiVnx9nptQhQ6teLfa63X/EPisPCMOi/jmCOuAdKa5Qem29IklZuVecenmiKX2qepsuD8eeh19OtRfbk+G8ngKt9oqNghqXaWYI216xvoVKTc4CPanG59jPtpUmE0y/D+Qdu9M+0z801BQLTGF4pDFVjhQGQGZeuYwmZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752191532; c=relaxed/simple;
	bh=S3yRMHiJp63Z3sa35dQZZnYodURgDAIos+timRoWgfo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=fx++2iSnapMm9xb3LI+gcK26kR5QvRg//qhcIZmlri9byGC5iHA/SHgI6eu/oNFikUZEbOC6fSeVKkh8QEfiBS0NqKx3lJWIOXiLAl5i0y0EXoPnZ4vBwKtckedatSvlOsUt5LlWcy90IMiQkOU25DkuOWPV+JZpBPS8YlfpwtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bpQ1TdXL; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bpQ1TdXL"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-313ff01d2a6so1694574a91.3
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 16:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752191531; x=1752796331; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ah0+wkOLh0SfnYMJxPVvQJg73AT2FFx/KryIhqiVcI4=;
        b=bpQ1TdXLCaa9bK0DJrk04lk8HBZBjA2/mcWf3m07VL05NqjNoEPq4rKRa8+x7jObIk
         ItHQtcWJbc6RIahOUVOYiNn8lpwZkJXDH3uR97Rr3I7+e6fket0jvut0GeZvnjr5Jbo/
         X3S3B2g7OdWTVmclNJ9zg8pNvTII0KQre6qLY/7XhjhygoKBXFWcL1mWg8eDhuxnBwJH
         OIQB2Tq5pEZzLW1JvkcdsvYf8oxPNr6yw2APBdLoB+IxfKWd/2o+IcWzqbie/puFjOq2
         ZLfIlM8Osz0N6Sk679SS14XSJisyMY3I+qHmJRW7uk9CQ/yhRwmq7p1XkMlZqXFQPM7+
         eKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752191531; x=1752796331;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ah0+wkOLh0SfnYMJxPVvQJg73AT2FFx/KryIhqiVcI4=;
        b=Bx+6LhxR0H5MAslnO/v+KhHerMjAGgJ0HSPrl5mFmkNFTCZwZidYbowXKZYAUiJIZf
         YztePeFHD1KnGJ68FJ9Dhqhv6VZ41zHdlNCs1hAHn6GEXUJfmXROYWqL6JMHMOkeWpiC
         YOTJwWn+NWtiCZ9VS9u9fHjxWYRGkyuIEMI4XvidlwPJAYSZaG0H0mZAeT9/iWHvjdhw
         oDjXtsewYzfjjizqb9v8p1eI5uOkVRaU+FMHW3eSf/0cDzgam6Z/YGFWpZeEgAOJ7z1O
         H5FPZlbsApQe11vd8YtEa0spk2q4glEQJS7gPmwKByQ4Uj922voAMNn6m08s5yI7YAX6
         VpPw==
X-Forwarded-Encrypted: i=1; AJvYcCUSb5RomQhRRKzA8UWdHDirgJzxmzd+aP4lAOyF4LlshmCPyNhJHiZuL+EI/0B7KPvBtCD9iWZeY+7MpOAnjQlV@vger.kernel.org
X-Gm-Message-State: AOJu0YwGS857MpjEgjFTVVQ+bWHSu5gZTN1TepMFnzlgGSNmWpeHzfOE
	r8r1TU46V2zdw8pJIzWtJ1n6Rr6PlN8dZu313HhHEdq11pvykB4BwTjeqbkpZlJge8nbnAJX4Vb
	b0/s+xY4o8g==
X-Google-Smtp-Source: AGHT+IHuXYQqG8mUduYyNsVRYiw4AnUaYNbBCA0c5zjyQheARQpeOx7R6/xtZBMi4TILoaAcAku0wTI+Ked+
X-Received: from pjbsq16.prod.google.com ([2002:a17:90b:5310:b0:313:221f:6571])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3844:b0:311:df4b:4b93
 with SMTP id 98e67ed59e1d1-31c4cc9c984mr1813908a91.7.1752191530631; Thu, 10
 Jul 2025 16:52:10 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:51:22 -0700
In-Reply-To: <20250710235126.1086011-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710235126.1086011-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710235126.1086011-10-irogers@google.com>
Subject: [PATCH v2 09/13] perf python: In str(evsel) use the evsel__pmu_name helper
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

The evsel__pmu_name helper will internally use evsel__find_pmu that
handles legacy events, extended types, etc. in determining a PMU and
will provide a better value than just trying to access the PMU's name
directly as the PMU may not have been computed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index b5ee9f7a4662..0821205b1aaa 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -925,10 +925,7 @@ static PyObject *pyrf_evsel__str(PyObject *self)
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
2.50.0.727.gbf7dc18ff4-goog

