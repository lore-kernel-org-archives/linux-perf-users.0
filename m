Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B2014D299
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Oct 2024 23:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728085286; cv=none; b=UXZM84m+TmqF9hNU32wf+lOq1YtKQ+8DJm3NSrr+gD40Auihx1eESNOhcyXqf2STyyG8OcsXYtPeJGNgrIKsvnOYpUaMg4a9Q9T8TETm69+ARPl3MV39yAL15L9LqvwhBuzchAAUyIJTdEGtyd+wTb0QWbgjBlmBR3TS2INjZK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728085286; c=relaxed/simple;
	bh=0ewX+Ngc0NcpulzsenrDwxUPqfYbaus5LQCFfX+bSKU=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=a3LjH3PNQiFOCHeKet9640oSkAt9PEWYxqyCm76WKyGDONDee5ROdBfiHFtAgtQPJ8wJjo4WrggPauQ8NDdeVG7xoeOma/ejvuu87A9Kt33PDLz7c0aupxuftlMm5+b3cBTYmbshg2dqD+ziVOHcbbOcrs8nUrG0IyKM2omIdd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iIhc7osT; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iIhc7osT"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e28694ff555so4271059276.2
        for <linux-perf-users@vger.kernel.org>; Fri, 04 Oct 2024 16:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728085283; x=1728690083; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cwiDFuSbl6FB7NmqYOyxOc/XwPagJhaLZPJBTtRN9Gw=;
        b=iIhc7osTNMV5/wURfwsnnwXwf+egHnOSRdAv0s/HthMS3U8wSDcgQuRim0TyowB46g
         I/73MOWJTYyhNBku/319hrt5tKFqHB8H67U2PtbDqqrQCF+ICl0zeQG50qHoZAx9j02V
         Dgy59oaIq6p0I1t7Z2U+OaFdFmopvGNaZk0ZeaM7GSNJOwrnWn94OUSdMLciFRyfIP9m
         rcR7XlY23T4yxL/iG54Nm/OJn0oxVK17UeTzxI+VD0yBuqW4gp1vtN6DfbMakU0XFYfr
         CWPdbOpUDzNXflLbS2Ljo/xGStqVpOddCgPYsiaaduV7T2XUcWXmong1foTS5Id6N0hj
         pv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728085283; x=1728690083;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cwiDFuSbl6FB7NmqYOyxOc/XwPagJhaLZPJBTtRN9Gw=;
        b=cuPrSRqRQuB6CdGG4KRNjiDvc6vReK/3m4ZcoERkVM2Kg5j5EeO53E4gwVJSoIS4Q3
         y151QbIFqLgUceWh8f6hCyvHuCp7iV5B/9N2/p3qIzCGp4SoR7cPcR2tszUDOer6u6O0
         2KoIvMSuAWtp0nAG/YUV7s+sBWKH6Zj1vHQA/cDtrc58NG220/pDTOhn61m/KtGtMup+
         7fGPoqonwW1ZBKDaKmlLN9pKFpdDhGTHNRCExhjPWrnGv/tAFml6mEMi4SD2rQbD06UZ
         OUUTxZIXe3ecGaJirtVr2V7fCfnT57Pt/cDCGPoFPIabqoZceq74ay+5+FwJFGiauGiI
         5SuA==
X-Forwarded-Encrypted: i=1; AJvYcCVwVEExJmpLAO1gAaw6EHpltB4zdCmyg9oQzVBZVgrrS55MPmwvWNUy4N4zA7f9gb+2AHU4QCF1rHOm0JPqpHuu@vger.kernel.org
X-Gm-Message-State: AOJu0YwQKdhd6g7ker/l896dilZ+Oiysr5QQ1VnmNwkkY+ETZmZCq29A
	xd288IeCA3yIsNwJR6FilUu9nsjBYJSrZ/EX/7u8Enc+hDxlxS+FMaZ1Vd5zvHTB157DzQgz1VD
	7tVNUtw==
X-Google-Smtp-Source: AGHT+IHQmFybmLmWSQKXu8t25MjnCcbz9iuIAs3Pnyt0Y1H4euwaDEThxlC7JNbnVvQxWUSSP2JxskAgdM3p
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8d23:e3c7:679f:19df])
 (user=irogers job=sendgmr) by 2002:a25:6908:0:b0:e22:624b:aea2 with SMTP id
 3f1490d57ef6-e28934fc7a7mr3435276.0.1728085283292; Fri, 04 Oct 2024 16:41:23
 -0700 (PDT)
Date: Fri,  4 Oct 2024 16:41:12 -0700
Message-Id: <20241004234120.1495209-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Subject: [PATCH v1 0/8] CSV/JSON metric thresholds, fix printf modifiers
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

Metric thresholds are being computed for CSV and JSON output but not
displayed. Rename the color that encodes the threshold as enum values
and use to generate string constants in a CSV column or json
dictionary value.

Add printf attribute to functions in color.h that could support
it. Fix bad printf format strings that this detected.

Ian Rogers (8):
  perf color: Add printf format checking and resolve issues
  perf stat: Fix/add parameter names for print_metric
  perf stat: Display "none" for NaN with metric only json
  perf stat: Drop metric-unit if unit is NULL
  perf stat: Change color to threshold in print_metric
  perf stat: Display metric threshold value in CSV output
  perf stat: Add metric-threshold to json output
  perf stat: Disable metric thresholds for CSV/JSON metric-only mode

 tools/perf/Documentation/perf-stat.txt        |   1 +
 tools/perf/arch/x86/util/iostat.c             |   2 +-
 tools/perf/builtin-sched.c                    |   2 +-
 tools/perf/builtin-script.c                   |   6 +-
 tools/perf/builtin-stat.c                     |   8 ++
 tools/perf/builtin-trace.c                    |   2 +-
 .../tests/shell/lib/perf_json_output_lint.py  |   5 +-
 tools/perf/tests/shell/stat+csv_output.sh     |  24 ++--
 tools/perf/util/arm-spe.c                     |   2 +-
 tools/perf/util/color.h                       |   9 +-
 tools/perf/util/intel-bts.c                   |   2 +-
 tools/perf/util/intel-pt.c                    |   2 +-
 tools/perf/util/s390-cpumsf.c                 |   2 +-
 tools/perf/util/s390-sample-raw.c             |   6 +-
 tools/perf/util/stat-display.c                |  85 +++++++++---
 tools/perf/util/stat-shadow.c                 | 128 ++++++++++--------
 tools/perf/util/stat.h                        |  16 ++-
 17 files changed, 191 insertions(+), 111 deletions(-)

-- 
2.47.0.rc0.187.ge670bccf7e-goog

