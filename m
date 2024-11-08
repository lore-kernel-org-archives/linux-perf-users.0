Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510B3192D7F
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Nov 2024 18:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731091676; cv=none; b=i2lcaklbqrVJ9QqiXPm8U4AoFmMX2+ZLmIkIsxTBnaSVD/MC6Ka30qxl4E/0Db18FcAcbenUq+DeC/7y54oqb/AM4+eE2flkcRPBr/HO3mnJBzWE8KXm9+jmcmgkJSJu/W51Agi2wBNs4LpVqPTNx7iyfxNppxk2JdapEuNtvdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731091676; c=relaxed/simple;
	bh=6LmbQELXxQKouTzm2dR1ruovpAw+ncobzPbgDcIN/fQ=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=Oj3kTfmBmn79Auzziwh8JLWuv/XYPGJxbwtaiHTfntCMRRLJfkEdpew3zLRDXmX0cnzA5Ojx/HZ/1/EY5VSraDFcS98t/Q44cNLd8VoLrSHqTBQP29+KUobNxiOD8YXDuLUKBLXrfb0ae1j7ix3WKXYVKs+06rmjp1Tl8POLOWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DwWAUdWZ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DwWAUdWZ"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea82a5480fso48458917b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 10:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731091674; x=1731696474; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sYbic6g8fYbYz/lxOerjmFFUp0LautdATerL7NAvkig=;
        b=DwWAUdWZFR5bEl67z9DStOOqyibAc+SjHtrhhGw8dCSPUFz8Yz4oR4YD+HPQN4dapE
         mHsFZyxwXYG1PzaFIbP7StVgNNTFTwTiMUWiWkMq5XWIC1wQMiB3YXSCEpTcO3SvWptt
         AKGCaTtICyTEIazFQt8qyCS5wpCEwEyCd8a2SJbOeOo8Q/9KXfQ0/TTjuesocrzzHEid
         6KuLCTaE+BMNBCiFY2jOWsKnGhWutd3g5mJEgPdvITCDZI8eBvO7WtT+QBglxYNvd2el
         o/AimvZEEv+BvUUnqqoOQ+HsfnHKqzQJDAPZFUHh6xOIgkPNkKE+9W2rDE/LJhe6nGSo
         SAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731091674; x=1731696474;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sYbic6g8fYbYz/lxOerjmFFUp0LautdATerL7NAvkig=;
        b=m+6hMPPJI7K09NSzoDV1vSX7R6jstjAGBDs16GLTnAKYIiRCpyAjuhtAT6KlZZHTPH
         AQ8mgmiN4KN4EitLyz6h3lncgoaPjm7bRIKLIMXk2gq2S3EqRGxx7ChUqk8PSMhXv3aA
         7Px+Tgb0whhx9FwMfXc/HhcBpRY5NafwGQEWYmKWOesSUJMZnADvXpYSoix5H6ZVl/2e
         75IAXQm2cvOTqw131cY9mFphDBdMI+/n0KAXhuxDGPzZMh11w2f8WwwbncQHgzXrrZmR
         aZ2y0nfas2lNDC2DQKrwj2dF80Ue87LC/FruoWJeTByZaQfDJTQMYl+rlgE2lfOz3Gp7
         dIHw==
X-Forwarded-Encrypted: i=1; AJvYcCW79/kJhkpujyKz/XGsm06ZCFHFT0QAgV4/1tg+LCObKB7aV7iia1TNbVcrCvVsVnmOElV4YzlYj3Ud3ycKcOF9@vger.kernel.org
X-Gm-Message-State: AOJu0YwFqnvznJxwjhkSxc48/Sqa8h01hj4LWL/S3kOWuvHd6d6BkDry
	LrPHFpujUsM2+ErXbZe+7S0g/zaxh6LQ/rBO8189d/WE7ha8aYpDpic430BkOPKV7v0DMNbJDFE
	7ecVBIg==
X-Google-Smtp-Source: AGHT+IFVw3cau2nh6WkJX7tgUmWOKqlA+HW6J4EJ3L5pw0bFMLr6+1Gics50g/HEmg0uDIcINH3fE11rYHA1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a05:690c:288:b0:6e2:1ab6:699a with SMTP id
 00721157ae682-6eaddfea2a9mr419297b3.7.1731091674267; Fri, 08 Nov 2024
 10:47:54 -0800 (PST)
Date: Fri,  8 Nov 2024 10:47:45 -0800
Message-Id: <20241108184751.359237-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v4 0/6] Avoid parsing tracepoint format just for id
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

v4. Rebase due to conflict with 9ac98662dbd3 ("perf: event: Remove deadcode")
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
 tools/perf/util/trace-event-parse.c           |   2 +-
 tools/perf/util/trace-event-scripting.c       |  10 +-
 tools/perf/util/trace-event.h                 |   2 +-
 23 files changed, 214 insertions(+), 146 deletions(-)

-- 
2.47.0.277.g8800431eea-goog

