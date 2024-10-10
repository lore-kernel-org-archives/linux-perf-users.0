Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B912170A14
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Oct 2024 01:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728523309; cv=none; b=JQsMtRbIIxt1HrrVo63DW67tCvtjDf3y83wa1j3NhwaaiKaup5XDTbngnIVVREkFSyXyjicunE7bNf5TKds+eBBC+cK95MRcVDcdTbgzS2xMpf0GOU675pZOinipH/C6ClmkxlnweaEtMZTcA6PUfFm01c9ddn2kotTJ/cojKhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728523309; c=relaxed/simple;
	bh=1azV7E7FNm5ZgpAvEIdQ64JI8F44TJjzhA8h4p43pa4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=P/Dls/SdVcY3a/MjX9IoCdpTNa1syv9pnxVzI0/y0e+AMsISJ9OL0A/ubJIe3PnYDquLFjjHCLRbjwRh/9eXuyL5fFz0wOU+053SwciMN7xkwKc0pAzGyyzLwbFu3QLOh7RbGD3WWi27NEr/yvA38ID5ymsEYkrROI76XN4rhIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hHNU6si7; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hHNU6si7"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e31e5d1739so11474167b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Oct 2024 18:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728523307; x=1729128107; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H1XFcCPRE5WoawTRbLhb/GdnJyywM9jpDE6V/JQJDp0=;
        b=hHNU6si7JZaoWpjrzgyWVMduBBudici6tiIky+NZGGCK4jqEKwDbks83xHRwNe6KKX
         DuGTk4zp4WeQeIV9lzVCjZx0fIFTL6oluhsIpXir1dahKOxOaEWD3LAeRVdEx2ZSBTS9
         Y77A8jEmGS4mlbPjfDTI6RhpXePH7yRkxf5Yho2QSK35ECvVnzVU9+ZgG7kLmh3h3ya9
         SDgUDstNPxSyW8G7xCzkrTh4G22floj4GqGvWsBF3jbzC3QANe12bmug4eTM/F2WbW1H
         5qrIb+gePXe/nPuJG8d3ZHdjmDkC8P/39JAEkL/aWvmdEp6GBKFrlyj7292hksgFln3C
         tK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728523307; x=1729128107;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H1XFcCPRE5WoawTRbLhb/GdnJyywM9jpDE6V/JQJDp0=;
        b=wn8QheBjvYoEtDm8esPSRp5v5S+s0hLZ/ElnYNYNyK6mQtaYwgxGH7nZ4N3B8oEphp
         0a5Jb1qMRjTzb8SR7OdQ1pWDP+ZzvNVaJycEvNJn35zFKIcGVwwAVkKbfFG7Offt1uR0
         5JhHtBjX9uBSxtDynbcXrru1xzo4aLUkzejU/a08cBNlpS/XG8DNn96Z13Ps9Qg7DnmG
         Zq38Saj7VWDt+tm8/45xsbaN15Zm6bJZ7BxNTmLbN+rXuJ0un3cix117TmIAfrmDVJry
         NK3fo6BjF7mMtaHoFHWAenAJmJlBUwFYkwyZprfgR1jyZ040LIh82jP5gV5pNRupwED1
         OYgg==
X-Forwarded-Encrypted: i=1; AJvYcCU6X9Izf8e2vf+Id7iETscYeQDXJAMFoXZ8rC9vQ/U4BvbNnaXdnfIl0M2a4iuZ4dZ3G0DOUlmpMPcsb33T3XXv@vger.kernel.org
X-Gm-Message-State: AOJu0YyE79HEiHUOl3zcU3vQejnRQArWXBfHoSd+jzo8mb6DNDwSS88w
	dTwkPGfHIV9Q2VXuEKf68lc/A72gjZlNHPmDKfMA7GsrNr69NeMz32I5kTs4O96e1+TIwQ++8/7
	bpXwqJg==
X-Google-Smtp-Source: AGHT+IH/Ad5uqCUblxRnAXog3BTfXT0jL5Xh0TWAOrvBEeg9poXkASqKARbLzbeTDuRshUQbzG1dEiobfRav
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6c8b:1170:a0ca:9d72])
 (user=irogers job=sendgmr) by 2002:a05:690c:2511:b0:6e2:b263:103f with SMTP
 id 00721157ae682-6e3220e2a8bmr549377b3.0.1728523307301; Wed, 09 Oct 2024
 18:21:47 -0700 (PDT)
Date: Wed,  9 Oct 2024 18:21:30 -0700
In-Reply-To: <20241010012135.1272535-1-irogers@google.com>
Message-Id: <20241010012135.1272535-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010012135.1272535-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 4/8] perf stat: Drop metric-unit if unit is NULL
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Yicong Yang <yangyicong@hisilicon.com>, Weilin Wang <weilin.wang@intel.com>, 
	Tim Chen <tim.c.chen@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Avoid cases like:
```
$ perf stat -a -M topdownl1 -j -I 1000
...
{"interval" : 11.127757275, "counter-value" : "85715898.000000", "unit" : "", "event" : "IDQ.MITE_UOPS", "event-runtime" : 988376123, "pcnt-running" : 100.00, "metric-value" : "0.000000", "metric-unit" : "(null)"}
...
```

If there is no unit then drop the metric-value too as:
Suggested-by: Tim Chen <tim.c.chen@linux.intel.com>

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index e392ee5efb45..6bb048fefe9d 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -470,8 +470,8 @@ static void print_metric_json(struct perf_stat_config *config __maybe_unused,
 	struct outstate *os = ctx;
 	FILE *out = os->fh;
 
-	fprintf(out, "\"metric-value\" : \"%f\", ", val);
-	fprintf(out, "\"metric-unit\" : \"%s\"", unit);
+	if (unit)
+		fprintf(out, "\"metric-value\" : \"%f\", \"metric-unit\" : \"%s\"", val, unit);
 	if (!config->metric_only)
 		fprintf(out, "}");
 }
-- 
2.47.0.rc1.288.g06298d1525-goog

