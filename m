Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02278363
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Mar 2024 00:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709857176; cv=none; b=lPWq2id+hWFOAdFY7stQd7S2n5J1dQbe+aLCwd5FAhw9eT25YDPrQ8FDNNk7GZSVKi/EcypmGhHkOToZJLLZbTNTsrHbugI3ZHqiuoNxFGmY5HxJjoPKLdwrN4LBs+m1OgMSXbpm6t/rbStAA+4BUrL5ut5u69ipLVwItmHxE/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709857176; c=relaxed/simple;
	bh=41OGcxDXHE9reRyhpUNhOqjp5DIntWx9erI9QUJZ7zM=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=B8MYrtY0cgcaM9a+42tSF6O2QV94o2nz5XPNcb88sSP0R2Nmm7s4zBs2c0SaZLXsl1fsdxQU16oAVJRcwDHpb/NFbLZZ1C/ikaxZfBuNQgLrN7wk+Uo2Q3LALzxEDUgOUoOueJnaOKO1fkDR4OPXNnW+nqVzN2KiDOaFlVm18pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lfrtRmJG; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lfrtRmJG"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcdc3db67f0so3035390276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Mar 2024 16:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709857174; x=1710461974; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=De+xXG9LErpx0jsehLOAYTZORpUzSmU7F+YMDvAGffE=;
        b=lfrtRmJGg9W8iRwkRhBBdvZpYoH+RwfbIKDOAp+IjVKwyl19jfUOTy0F9+0qGR4mG9
         ari+gJ0P/aKFPVa1l+EIGJrXGCJdQJV4YyToA6qV7m93/vrC+RzqFya5ZP74PDnpzCf3
         eQiOOJbqONhh/ENrWi53ej6pupp0vo0vCRYR4Y7094buNYsVtucbjkwyrk0lp5xgbls7
         U1f4mw2smZNQG2nClM9dbHA0e/e2aLtqRIL47sJvvV9AJzEjE3AH+aX98osWwafANe9k
         58UxjFw0rqd2Ac5K1zUwxsiha/4K1LXFj5YuNZUvbCypUnWsC9Eq1rIt8R6mrEXkkbLq
         FwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709857174; x=1710461974;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=De+xXG9LErpx0jsehLOAYTZORpUzSmU7F+YMDvAGffE=;
        b=Llxrc73/0bO4UZUaDOOec9fg7dTrj+8/Jh1x5P0wrrnpVnrsOtkwHDQOh63ZOYBI85
         kq4UPRWBUYGrY7uUSvoA4JCT8/i706zphYH0PY9L2mSmjGDL1IyCXhuIUr5p2nKp1umz
         jwviDOTDTtQn5ByC0n/zisNRAVzPWvzI1NSZdyBc/CcGdCBL8zeTy4IY5pskrVJvTN2Y
         E4rF1rssvEj3iLOfK5NyUC+i+KAqN+DMMEEctsoIsMZDMAzRIR3Lh+2v4VeS4esAodfk
         Dod+d1dSwu8icr7CuV/phfa2ZQ80T4eQdjDPwki4N25gCSMcvFcOzCa10VtZ8iRLIioO
         I86A==
X-Forwarded-Encrypted: i=1; AJvYcCUyRcuHLz9jH7wg/MHWCEGw+mc7T/kYBFnF53UdjEkrgnqaE1nMrn08RZH0QIbhd3BZzxi+xVodoo+oKshhSE33GaOTds8L3yC22G28hXGHqQ==
X-Gm-Message-State: AOJu0YzF2KdNxqk3XuEuNavYLObtZZL+JRT9xMrW1MrTni5t5aC0uymT
	A/FSEca2uYMtQ5dRs/xSDZvEmMpHmzmIM03OHBb4l879JZlxpyf6fQMhjkHjR3FBOWz1lFsxlxD
	qeDT1Pw==
X-Google-Smtp-Source: AGHT+IHNsQE0fEVEtOu1phuNJbGl8EvuyfUoDyFIcxYP78HmFEzRfUDobphGohVDT9DtbXgpL2DDOGV/1fHt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:218f:92ee:d543:c1a2])
 (user=irogers job=sendgmr) by 2002:a25:310a:0:b0:dc6:b7c2:176e with SMTP id
 x10-20020a25310a000000b00dc6b7c2176emr84209ybx.4.1709857173521; Thu, 07 Mar
 2024 16:19:33 -0800 (PST)
Date: Thu,  7 Mar 2024 16:19:09 -0800
Message-Id: <20240308001915.4060155-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 0/6] Extra verbose/perf-list details
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add more encoding detail and raw event details in perf list. Add PMU
name and reverse lookup from config to event name to
perf_event_attr_fprintf. This makes the verbose output easier to read,
and the perf list information more specific.

v3. Fix to reverse lookup to ensure or aliases are loaded and if
    getting the config value fails for an event/alias just continue to
    the next one.
v2. Address feedback from Kan Liang, "Raw hardware event descriptor"
    becomes "Raw event descriptor" add assert to keep term numbers in
    sync, fix a commit message.

Ian Rogers (6):
  perf list: Add tracepoint encoding to detailed output
  perf pmu: Drop "default_core" from alias names
  perf list: Allow wordwrap to wrap on commas
  perf list: Give more details about raw event encodings
  perf tools: Use pmus to describe type from attribute
  perf tools: Add/use PMU reverse lookup from config to name

 tools/perf/builtin-list.c                 | 21 ++++-
 tools/perf/util/perf_event_attr_fprintf.c | 26 +++++--
 tools/perf/util/pmu.c                     | 82 +++++++++++++++++++-
 tools/perf/util/pmu.h                     |  4 +
 tools/perf/util/pmus.c                    | 94 +++++++++++++++++++++++
 tools/perf/util/pmus.h                    |  1 +
 tools/perf/util/print-events.c            | 55 +++++++------
 7 files changed, 242 insertions(+), 41 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog

