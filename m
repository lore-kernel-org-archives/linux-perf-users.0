Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC71E1E764B
	for <linux-perf-users@vger.kernel.org>; Tue,  5 Nov 2024 21:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730842022; cv=none; b=gEtFgYLQXQso4kCXUyxBcxYGShI7OmMxqttl9MECx9+htLUZ3pkiVPyR8LP++ucvId2r5Tt14BrGmfm4sfX6VyHXduwJ+z/3zxGW7I7ref7kfKZVLIhl2/kl8oDDct/I1WjpvXFkWRCLsp/Y1GX+yYdq7D7OP72MYnSxW3vN2dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730842022; c=relaxed/simple;
	bh=HS+/C0e0hpeLfwzCJv/WkWcH4j9dAH0Yg5tqwK/5gPU=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=V2JO35larYHzXpNmseLxjGweFRVFNuQ4d9ZVTtwBINPP6+CSlQa9BQ9wuQIIQDWOdrlgN7qLYYrB5GiNFszUyGs12q+K/MpomKYVO1o8IcBpwlaJF69avrGImdYtljiVhRiJH4MvEQSSs41l1pOhaDhIjVTpedaea+/y26CBtM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZGA4u84S; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZGA4u84S"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e7f633af02so83902847b3.3
        for <linux-perf-users@vger.kernel.org>; Tue, 05 Nov 2024 13:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730842020; x=1731446820; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yEmXLOQoeDgbB8Nzdb0EfC34B2gegQNp6g6GHNUgKDM=;
        b=ZGA4u84SXIfLJpYwuF2LASa3niVioxosoiwUM3xa6u4DI/jYHOpAkH/kfU9qDdd8fe
         L54M3PpeuVzHb0tnmVYYlUSy0JHVxprfT8pQOJjUEpHwpefl3CgUY1iNOfkY4orfWR5F
         b9IeLSIX6wUczXpZk3xVO+GCaZOVo1QpgxrXlKxNTKkqnabkw7XTLyKJg2m5WD4OiqYn
         1270siKoJqDuBungx+Q/9qKbnBi2B7pTgHkLGgwCWg+BM49MSDcunLwA9ZQuSedlIX6r
         UXPhPa8yuvsclZljb9RjjtV8mVuzS6Yy3yoXIknjjgmUVW8r8sJkAaH7k3V0O2dg6TXh
         k8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730842020; x=1731446820;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yEmXLOQoeDgbB8Nzdb0EfC34B2gegQNp6g6GHNUgKDM=;
        b=OD1CRi9bAQpEjOTH+woynVPRXJsxl5hSrbPC8pQCKe+/e4+wrFkZpEnaIdoYRrisPB
         JK6xzNis0Z903Gm03daGaJ0mfRVCMO0HsFimmOq496Et1zSVBTEi23fUBuxCNhx7gjbx
         KNWfvZ4pJ78wZYa8lR9UTwhIln7JVF7iY2LhIwy3vr3QvQyvel580vl7wJHG9e43Q3u3
         YUhawUiQgS8aXnRUqOxzFCZMuMGd+wkx9wNLx/b6PmrWBsklO7KIa/A8IN13YMvig7+V
         ztrG1XHCCDFf/3jPSNFOtocg/YXC0XtRlUOvGIyrNrB+BX7k2scltnT7sUMXQp1JWX9a
         hxvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVn8uaoHcX3bgYCDzzNb9P5zkxfu2emwxvkOWgfYiO9GUhrHSir+CUtq5Su+mZny3RARvU14rRWf02AqOwMQj1e@vger.kernel.org
X-Gm-Message-State: AOJu0YwvbbdbIf05z+QSDPOji4ch/cUO2pzeTp/OERo0rr7het+L2PyX
	fgK73H+O1NCwybI5+wdvt/VO7rY8wp528H6CkjtiJSqe1+G1qpv10c+EzHFnZKvZFMj9KBTkvuB
	lZV4Kcg==
X-Google-Smtp-Source: AGHT+IFyefUnXR7fmFIzAhayc6jLgdUhzGuPxNKLUajAPJaO+D+RRXPI25jmigj2QGfwRBN3wwxQksywcvRV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ff9e:ab12:75ac:c1a0])
 (user=irogers job=sendgmr) by 2002:a05:690c:11:b0:6ea:6872:2fe6 with SMTP id
 00721157ae682-6ea68723031mr3708907b3.4.1730842019826; Tue, 05 Nov 2024
 13:26:59 -0800 (PST)
Date: Tue,  5 Nov 2024 13:26:46 -0800
Message-Id: <20241105212652.401943-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v3 0/6] Avoid parsing tracepoint format just for id
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

v3. Whitespace changes, Arnaldo.
v2. Add additional error checking/handling in evsel__tp_format.

Ian Rogers (6):
  tool api fs: Correctly encode errno for read/write open failures
  perf trace-event: Constify print arguments
  perf trace-event: Always build trace-event-info.c
  perf evsel: Add/use accessor for tp_format
  perf evsel: Allow evsel__newtp without libtraceevent
  perf tests: Enable tests disabled due to tracepoint parsing

 tools/lib/api/fs/fs.c                         |   6 +-
 tools/perf/builtin-kmem.c                     |  12 +-
 tools/perf/builtin-kwork.c                    |   3 +-
 tools/perf/builtin-record.c                   |   2 -
 tools/perf/builtin-script.c                   |   9 +-
 tools/perf/builtin-trace.c                    |  79 +++++++++----
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
 23 files changed, 216 insertions(+), 148 deletions(-)

-- 
2.47.0.199.ga7371fff76-goog

