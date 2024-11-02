Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E921A3AA9
	for <linux-perf-users@vger.kernel.org>; Sat,  2 Nov 2024 16:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730566453; cv=none; b=pZJ5OOvJJaCKarV/JqLjZsorBN/DBcKh1S6WHhsjgBK5F+QxVWLWHPNqLj/gmMjaQwfGj9aVEtdmEyxkmHfaFQlz99/XA0oMlumYmP8hzYcz5OAom6wTN9sNAIC+tH/PbQSC2FHbl9AXl9YmtpIQ0Qm7+lW9wQ3qCzJc+ZsBfeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730566453; c=relaxed/simple;
	bh=uvT7Jt18QdLMEnWuwF5FiFkhA6QSqQ3s+ITWtrpIjkI=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=IIlv1SstYlwKw3Yvf3m8JqR4jBjo6hKxX4ypFtKI2Kk4/KbbIOhpgFmAFizHBTw+vw0iNW7uCgHIJYfFfIV6yMAlEvb461r3fLxc5v9pZZpa0nLqgUtUglQJMCTI3FAEj2VMd5bSsDu2t2n+lLMTkT4keAxQDH6zcMyjgZYC4UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Ca04J5F; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Ca04J5F"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e1fbe2a6b1so55645657b3.2
        for <linux-perf-users@vger.kernel.org>; Sat, 02 Nov 2024 09:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730566449; x=1731171249; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0uUEtUE6reGy3hUjf41A625G8CSBp4sF/WXt+DqRh+g=;
        b=4Ca04J5Fkcps73YO1sCJ9nsLRoFRUiDHW/cqQQPawZugl830rkmlRlOILk35VCP22n
         0OYjGBWLpLLZM/aXnZ7Ns5xn/yVlDgP4+adzgQ0gsY3XyWIptHSF5YOhf6YyQhWX2gF/
         Bq4ecxQYnGcWK4rgRIslMZmfUQ+Lbge658Cmz3EC12PTuo+Bvvr3AXUqNuOXRDCrS8GY
         y0UimGRcbD4wpafIhnDYJSEfDjX6j4JYf1Gq1aNSIXZwNEtB/YMHIJzdzlNhjervLTQS
         4gO2qB5TeOaOpxCsiOHf35bo8aSt27nkfLThTgbHY9TkAT+Efm+Zc1M5IAFb/uWe0cSZ
         CKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730566449; x=1731171249;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0uUEtUE6reGy3hUjf41A625G8CSBp4sF/WXt+DqRh+g=;
        b=sdvq8GH9xwQGS4PXOVRn/Q+Ossr2Z5I154RWXa3e6+qjk0URp6/bbkcGKq82Gg6wNg
         jWTLDVDvJvRDpRwtiq6Qt7VVoEMfYnVEQarBvNXhHttRxtRxb7JSp1epaqTRcsfsxZTQ
         a8Adlg9knRDlsb91n6fyGxPsqVWC+/0i/jU7H/kaWgvGchPOOKk/FJRpSkpuMI990tUo
         IrwFX58y7hgrGCrWSAQaidRhgRXjg23edTVKGP88a1MjcI2BAV8W/uUwTatRY9A/RF4a
         jEo1miU3kCXL0ybjatt0teusjLG9I9nQcrYLH5Bz3e+LP9tj4QqSuRFET7PgMFhIA2XX
         /qlw==
X-Forwarded-Encrypted: i=1; AJvYcCXpD8tvm/JkPXywmbsMgf0sQHBipQX62+mA47lSe/jWPnFjqzmyn7/sv4zppyhLZQ5RyxtS5AqR3EGAHeFmeDk7@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6M97oRtSZB5xoE9jU4do1/U7N0bQ95Z1g+XiNR5Od/zUd64gd
	hj4Jec7EI94fXlDxfU2DP7lJtaA46u4qqelAXOPamuBEht9X+EKOXk1ELKT/Cc6iMpyUE0RU4FN
	wHZCvKg==
X-Google-Smtp-Source: AGHT+IH6yRADeLOdKdN5cqV3LT8ueqp8pTwZmyGD9mGWjX5DLEF7FcbrGLj1y1N1/AolR+sBPyIB/iGB97Ps
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:26a5:cdb5:356c:64a4])
 (user=irogers job=sendgmr) by 2002:a05:690c:11:b0:6ea:6872:2fe6 with SMTP id
 00721157ae682-6ea68723031mr1053497b3.4.1730566449489; Sat, 02 Nov 2024
 09:54:09 -0700 (PDT)
Date: Sat,  2 Nov 2024 09:53:54 -0700
Message-Id: <20241102165400.75785-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v2 0/6] Avoid parsing tracepoint format just for id
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	James Clark <james.clark@linaro.org>, Dominique Martinet <asmadeus@codewreck.org>, 
	Yang Li <yang.lee@linux.alibaba.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Yang Jihong <yangjihong@bytedance.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Ben Gainey <ben.gainey@arm.com>, zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
	Zixian Cai <fzczx123@gmail.com>, Andi Kleen <ak@linux.intel.com>, Paran Lee <p4ranlee@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"

The tracepoint format isn't needed to open an event, just the id for
the config value. Refactor the use of evsel->tp_format to use an
accessor that will lazily construct its value. In evsel__newtp_idx
read the id so the config value can be set up/used.

This allows tracepoints to be used without libtraceevent in a number
of tests. Other functionality is enabled without libtracevent, such as
mapping a tracepoint id back to its name. There may be some
performance benefit to code using tracepoints but not using the format
information.

v2. Add additional error checking/handling in evsel__tp_format.

Ian Rogers (6):
  tool api fs: Correctly encode errno for read/write open failures
  perf trace-event: Constify print arguments
  perf trace-event: Always build trace-event-info.c
  perf evsel: Add/use accessor for tp_format
  perf evsel: Allow evsel__newtp without libtraceevent
  perf tests: Enable tests disabled due to tracepoint parsing

 tools/lib/api/fs/fs.c                         |   6 +-
 tools/perf/builtin-kmem.c                     |  15 ++-
 tools/perf/builtin-kwork.c                    |   3 +-
 tools/perf/builtin-record.c                   |   2 -
 tools/perf/builtin-script.c                   |   9 +-
 tools/perf/builtin-trace.c                    |  80 +++++++++----
 tools/perf/tests/Build                        |   6 +-
 tools/perf/tests/builtin-test.c               |   2 -
 tools/perf/tests/parse-events.c               |  25 +---
 tools/perf/util/Build                         |   2 +-
 tools/perf/util/data-convert-bt.c             |  10 +-
 tools/perf/util/data-convert-json.c           |   8 +-
 tools/perf/util/evsel.c                       | 110 +++++++++++++-----
 tools/perf/util/evsel.h                       |   9 +-
 tools/perf/util/evsel_fprintf.c               |   4 +-
 tools/perf/util/parse-events.c                |  16 +--
 tools/perf/util/perf_event_attr_fprintf.c     |   4 -
 .../util/scripting-engines/trace-event-perl.c |   3 +-
 .../scripting-engines/trace-event-python.c    |   3 +-
 tools/perf/util/sort.c                        |  33 ++++--
 tools/perf/util/trace-event-parse.c           |   4 +-
 tools/perf/util/trace-event-scripting.c       |  10 +-
 tools/perf/util/trace-event.h                 |   4 +-
 23 files changed, 219 insertions(+), 149 deletions(-)

-- 
2.47.0.199.ga7371fff76-goog

