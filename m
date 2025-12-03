Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F06E2D9792
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Dec 2025 21:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764798434; cv=none; b=HONFM1i7w1IS8oP13825OrqahxJ2HpwMk2MW6pkjLpDsOal9TrMGGFvdKN8hmIWqU0wDuMX0JP1j34IXdl0V8vyzfTrGvI+bOkq67KAgjIjo9BpO9ALEuJQzbIG9ftXGQy4wKT5DHGRXn0uQwYO2DgdvkjvYz+tQAc8ZPT13KCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764798434; c=relaxed/simple;
	bh=gR16hXUGmvBYon0NXkKR6UIc51eic/vdJdsFwlnfBmQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GlpzFDf/B/np1l8Q3Z3rVy3uNvMT7n5OIkdcAXHuRiMRQNIwj11OAC7xFrpDGDywjspGkYOlIIJUX1c1nML83n1yUCs3V0cB1aXNnmSY+kLrWVObs1LVkZts7JyhsiM/5TXF1E0lN7+c3XQb31oXNHI3DtyJOnWrYUPjoCC+Ju8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EuQYnEEo; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EuQYnEEo"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2a45fea6efbso1718001eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Dec 2025 13:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764798432; x=1765403232; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0JLDB1+Famcj/1uPLs4rB9WCCpUFUNy+DKkLH/GTWVU=;
        b=EuQYnEEoYR/aadRRh9mHXpXFwYPGTK0RRSgEVvj7uI0Ug7WJpizODd3TRzm8ySSSJI
         bURS5zam3vbdSmbw9bXCndKQkhMUywo8Cr8SVdcGPcxLc18vHhPrgk9vX7byD6JtllsZ
         sLeuySfsNGuLFvO10RR3eB+t6+lKrwqaPA9CxmEdINKkH9i7tq9S+1+z0ToT06IsIuet
         WtIjLwMICDVdHiIkwPDVZvmEP4pXZA9v7awpPF0dlAqr8a23ewTP0O70XSnnZNlrLMYf
         icYxK2Uwq6BMLm2LIxMP6oFpWetHq9dIKbvGQZVae4mnM9y8putQi0reQtxo05aSwC6/
         87dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764798432; x=1765403232;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0JLDB1+Famcj/1uPLs4rB9WCCpUFUNy+DKkLH/GTWVU=;
        b=D5Cxl/ytS7qMBT2W0PYGB1lGvgMwjcqZ+Njr9Lxh+Wpwjqxsk8n9bDRsR6Qm4u2Nuo
         cst05RFEwBWj3d+CvJBMvExwic11dvQr8AWMYK9XYTKCb1L/fsuYqTWfK4P/uVIhvkzR
         Zhz41sSve/3OUuKYiQf62V344eZTUrxyP6k2fUGMB5WXeCLAx+srtip+iqOn0kDhj6PT
         LM/4xRvltfsF77lclyhcpPMRBhBZ6+926AggYD37smUMS3f4a3ileQcgRykd09iUhIKM
         v60K4u6++wn9sGgczJWCz6vqRsrNpPeaH5CNauVo1RodhVW7tNvK7Z+pVyHffks4CS+4
         +dyg==
X-Forwarded-Encrypted: i=1; AJvYcCWY4nbKVROyETYW3vb+KvaKi+SnxqcjRoKQmeyU0aZGgpJJO9ST/0eQ8XNwjLPrNjHamV8nachemh8VCc0vPLIH@vger.kernel.org
X-Gm-Message-State: AOJu0YymciK9DrCH0Q7s19U/pI8kwWY6GnDOT2/qU7Dt9wVFZQ7DD2ky
	KtA+ZT/MzEK9RfFtV2p6v3BXrX8owYES9v7E4WsOUsRT14YNwmpuxnqqsIGmHhZWtNPeSRlezSC
	4GTQ4l81hRw==
X-Google-Smtp-Source: AGHT+IHu/jj6pSf2/OU7jAgX2yW38AXdSzMKTldoaWwQfMGHkoQ8ENZUp5NPZM91LnGiAdpVMi15XVZwV4So
X-Received: from dys5.prod.google.com ([2002:a05:693c:8005:b0:2a4:51e8:c5c8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:60e:b0:2a4:3593:cca7
 with SMTP id 5a478bee46e88-2aba3394a44mr812863eec.4.1764798431987; Wed, 03
 Dec 2025 13:47:11 -0800 (PST)
Date: Wed,  3 Dec 2025 13:47:00 -0800
In-Reply-To: <20251203214706.112174-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251203214706.112174-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.177.g9f829587af-goog
Message-ID: <20251203214706.112174-2-irogers@google.com>
Subject: [PATCH v2 1/7] perf stat: Allow no events to open if this is a
 "--null" run
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"

It is intended that a "--null" run doesn't open any events.

Fixes: 2cc7aa995ce9 ("perf stat: Refactor retry/skip/fatal error handling")
Tested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 5c06e9b61821..6410115ed9c5 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -923,7 +923,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			goto err_out;
 		}
 	}
-	if (!has_supported_counters) {
+	if (!has_supported_counters && !stat_config.null_run) {
 		evsel__open_strerror(evlist__first(evsel_list), &target, open_err,
 				     msg, sizeof(msg));
 		ui__error("No supported events found.\n%s\n", msg);
-- 
2.52.0.177.g9f829587af-goog

