Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DD51E7647
	for <linux-perf-users@vger.kernel.org>; Mon, 18 Nov 2024 22:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731970458; cv=none; b=Ei20R1YXdip9siQEAW+yB8WuWLqKJFO2RbIXPMUWQgsdUUawCMlOYsOvCcOOsa9+ISR1ErUL2Zk0/QAAXpoiqoCB3/i9lRt069KnbYu0tuPdpUGbtqvwE0u9MUaCoDxeDc3edA5VhKUMRFOz9PhRsakk3TdMxUuuGNXddHWGHs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731970458; c=relaxed/simple;
	bh=HxVQh/chPIJpI4D5mX+UAey/IbJDz5dBp7et+70bql4=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=QVrqCFEIE+uNr3Ed68uLTc93zrOeISFQW4gXgaoiIL5VO/70dZVgAZke35XlPGgJ60gDssr4inSAD7NhZLBhmwZfEfQgQWPgvueu+WBNvDL0DtH9GnWqBQD01u6Cp/bjGBROFpe0olAKfr+4ebtvRziwoqggRsxKRYGb8aj2DFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rFaUvzEB; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rFaUvzEB"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e30df8dbfd4so3198459276.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Nov 2024 14:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731970456; x=1732575256; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w+rYPSQWnk+W0N+0vHGM75nlyNa/lvl5McLIEiTriGo=;
        b=rFaUvzEBi7q5mSU0bTFUG/db6z6g4v0j682cjEIOsitjBPL0IMFpYv6F1VctceLoWN
         NPx4uPk5s1ihvgef0Y1a/+e0gClr/7/cd4av7wTLvvK9LGgCIxviJOCzGVSTPeesVR27
         qiL7+l8qvbI7//cklA9fGlclf1mTxXyGGVmpsdsBv/t8dSUq63+TBmWaDS+X5+MenZ/z
         Eg84xrHKourAcGJbOOP3OSrihAvXcmLzmcFQ+IQsEvfyLvOziLmOS6Uarg7UzNUs0hNk
         Ceci8MNrugr1q6SwWaLqHJ6pu9WGjtzP5XDE3QmS6PQfqT8bLrcnuLKBWIT05wGQhZIb
         t49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731970456; x=1732575256;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w+rYPSQWnk+W0N+0vHGM75nlyNa/lvl5McLIEiTriGo=;
        b=CweaqMdXRF88DpTiCUT5tmF+DdOrR1dDx7lH/sUbry/6t0wgw3IpbHXPm6r0Ruuwao
         BcFJ1KdqZefjs5kLFjgeMZpos4AExdXrgSdK6UAsB9bN+6fZtfS/jOuR6adPTlpI3N/O
         MEbZILLk2Z7YHOCzaqFGFxsZrdi3estJAiUNNKx4pj52oGUVxShdz9IJPwzvTVJ1IH0m
         EP251j4NOxqqouM3zRSO1s9tA5X22RtXnEmp5jSUMohRNzpbl3mBvp3BPPuikww1oyV3
         xP+1+MYQzxdbzGkPo7iqQFUMgYYsjYpZYCKSLOXhvFwTJn7/tQ7U59ovG0mLrFprDuYw
         fi4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVqUjO0c2huymEne0d54FQCM3rUO0nx/2V17dCFfajrcLoMEmWhwt1qcF3MHucimxUXUKEZw1+oyM4EdAl9yVLE@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7kZjLEbR2X7ChJemPA7vWe6ontH2c7CQ00X2lWPhEK5NM2HS+
	kI0lCqQINzgch2tG/8KQ27Zx2y3krey37qZqTI+stL0AHmw1uwp0OQeckucRXLRLmB949o+M0m5
	QWFyn4Q==
X-Google-Smtp-Source: AGHT+IGTc8FWCpB5TQTdJUdjQTTeM8YLo4Q5kXDArVtJusrkUf+pa8GqAJCf4dnWy4tP3RgIjUmcykfpk6Pv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:22a4:ded5:5c37:fcc7])
 (user=irogers job=sendgmr) by 2002:a25:664d:0:b0:e38:7f55:14a with SMTP id
 3f1490d57ef6-e387f550340mr58071276.7.1731970456009; Mon, 18 Nov 2024 14:54:16
 -0800 (PST)
Date: Mon, 18 Nov 2024 14:53:38 -0800
Message-Id: <20241118225345.889810-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v5 0/7] Avoid parsing tracepoint format just for id
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

v5. Add perf env fixed found by Namhyung.
v4. Rebase due to conflict with 9ac98662dbd3 ("perf: event: Remove deadcode")
v3. Whitespace changes, Arnaldo.
v2. Add additional error checking/handling in evsel__tp_format.

Ian Rogers (7):
  perf env: Ensure failure broken topology file reads are always -1
    encoded
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
 tools/perf/util/env.c                         |   9 +-
 tools/perf/util/evsel.c                       | 110 +++++++++++++-----
 tools/perf/util/evsel.h                       |   9 +-
 tools/perf/util/evsel_fprintf.c               |   4 +-
 tools/perf/util/parse-events.c                |  16 +--
 tools/perf/util/perf_event_attr_fprintf.c     |   4 -
 .../util/scripting-engines/trace-event-perl.c |   3 +-
 .../scripting-engines/trace-event-python.c    |   3 +-
 tools/perf/util/sort.c                        |  33 ++++--
 tools/perf/util/trace-event-parse.c           |   2 +-
 tools/perf/util/trace-event-scripting.c       |  10 +-
 tools/perf/util/trace-event.h                 |   2 +-
 24 files changed, 220 insertions(+), 149 deletions(-)

-- 
2.47.0.338.g60cca15819-goog

