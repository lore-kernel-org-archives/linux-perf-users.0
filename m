Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F501E04BE
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 17:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729187656; cv=none; b=izsMH0VOgGGb4Tjby8H7OQ1Cn6MsPic1Ur5NyME3B7414stxkaxsemLf329b8NW0NphQ5jLK1A4h6O95cbju7fDGfnG77yQSelhhsDxRJ/br1NNTHWHVhXSYiN/xx+REjYXUjnIerNdDENv6CD4GA7uk54bPjGMzzK6Gs5XAZA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729187656; c=relaxed/simple;
	bh=tWKJqnfBwSOmrMspZ2sdkDVmtmOQkJadh5Otwb2PTrM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=h52LT3WhGprd+w2cuGX4xUOeABh2exdtlkMxzdrPj93U0knxFWAJpGSw5MBJIJKQUSvZRDTsWtkTzkHtejvujl2n94RrFCcT6sq5r2tcHeUsgVN0BjJUyk1yKVBNG/GVqSUmAvVvepG90sWiN5+/V5NCWRjvohEIQzUd67FfYio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lh/iWkIw; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lh/iWkIw"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e290947f6f8so2131987276.2
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 10:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729187651; x=1729792451; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e2/oyoGU6HrX/Xxl9SMoDXlcRLOo1IYbCdJ0T7Dlej0=;
        b=lh/iWkIwsTys6DiiIOyHXtaFeDynTgub0bnsHrqqCCm2YL77fTWcX0qChsa481eJ2U
         Mdm6mv8R77gkzimulNOmt0b3RmxYQZVf/aPx3ag7ykvjxHk/DakcyrWA3XbHsAdacnhC
         u/UuTkoltwnjubpZkSQYW3dYNA8BSIwq29r4RJIkWW3GQkF5OARXDG0XKtrc80kL9YCd
         8mYFivJFGo0jDPikMvUp/2J0C3JyCyDFz8Lwj7puXSRbAgLBq+rMktMGpJ9XI6o78+U2
         agDT2Acsk247kcg6SLo9E8ie07fsrYKQnI/2qkFriUcreDLZM7c+StlG22GGjatX0b16
         V14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729187651; x=1729792451;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e2/oyoGU6HrX/Xxl9SMoDXlcRLOo1IYbCdJ0T7Dlej0=;
        b=PNYhct4YbVD9b4DoL03FbfaMLrz1V79F8Ww9p2MLP5YpxbYKajSFd2m5j43r7oaV36
         9+GZqjQZ3y6zqsP7kWGgApVzPrhN9vX0wI2FmzRIM8CCNkiWjiVuAH6Ed8kUPFCOlykV
         J9U/ThmsMr0OwlgmnfxZdC4+xIf+hHjFUO7xk5HqqOtxPftB4RwXp5RJMCbuN20C7uiO
         CGNSzPtXp74SM1Q6EQmsZd1WA5X9yanKS+WOFZ+B74gY1HoQjNpscFtiTojbahIaAo7l
         E+m4QbrLzFM7VxTTLe+bzWXClG4Utg7OAjLgZdEMevpNHmqOPXeDnnnnj4sEPPg81SQR
         V4Yw==
X-Forwarded-Encrypted: i=1; AJvYcCVTzcXvuBYlsnQ/Tzuo6ygGRmV+Ss12bEGS82ZGuzwPctrQHlY562PZ5eKgL2R1tSNc7G5vRexrbi6BK6ZGfIDc@vger.kernel.org
X-Gm-Message-State: AOJu0Yx84vpj4XDmK5vXehaPq1KcxA+fs1IudHVp2PxLP/AFeORsxaUL
	qxxxPcWzj2U/K7aF7hdwmz062eBPVzuv8bGHl2jylMfHVupLlDnn/ZQSDAQkEmC9P/GT+FQ/Vk2
	duRSTng==
X-Google-Smtp-Source: AGHT+IF8ZgJiYZC6Y4MdQnp0pzNBftyhUw/O0yoGc816lrCGCTote0tRmMfBMHmL7XgCp8i4ttUMCJ5vA92g
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:98a5:142e:8c2e:e9e5])
 (user=irogers job=sendgmr) by 2002:a25:b204:0:b0:e25:cea9:b0e with SMTP id
 3f1490d57ef6-e2978594b05mr4017276.9.1729187650384; Thu, 17 Oct 2024 10:54:10
 -0700 (PDT)
Date: Thu, 17 Oct 2024 10:53:53 -0700
In-Reply-To: <20241017175356.783793-1-irogers@google.com>
Message-Id: <20241017175356.783793-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017175356.783793-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v5 4/7] perf stat: Drop metric-unit if unit is NULL
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Yicong Yang <yangyicong@hisilicon.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
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
index a137b377efa4..c6d33010ed22 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -471,8 +471,8 @@ static void print_metric_json(struct perf_stat_config *config __maybe_unused,
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
2.47.0.105.g07ac214952-goog

