Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D5713C825
	for <linux-perf-users@vger.kernel.org>; Tue,  7 May 2024 18:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715106967; cv=none; b=Xg72Bd43OkXG+4I3m2n3bUjj22vVXV9JnWE5A+o2wqQl/jRmlQKdsn+4I2lMmxdAy9nufhOgjoAIpcIa1Ac9U+CjrtokOdcp0WnoktKXDNwTmvng4PYRe/y0z+8y8BYOLdPAgmwC74Q1J6fQyCBmpGv+gpv/X1fZ/+hNtPEZJvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715106967; c=relaxed/simple;
	bh=tzWS+kPyt79XbOX+5oaytxEr+MBWVTX6zlqUe/8VBnc=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=jjuG4CCl8nV5OrlHgkVXPkftyWZcQVEj8qvGm0UQLyxz4TN6EGEylSRzK0828pjP4geBuMnHj7ToitqltDurqdOUjpNRN3ZkmjCNnKx6i5Avl+jRdJtSYps78HVRhvBbogkt4sr+LUW/roCCzIjNvYYT+yWN1udAYC7C9OKQS2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MOdzxAuw; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MOdzxAuw"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de6054876efso6962661276.2
        for <linux-perf-users@vger.kernel.org>; Tue, 07 May 2024 11:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715106964; x=1715711764; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SxLHBX613BezPFCosUL3vMa1Z1WB1g1HWATAv+V05wY=;
        b=MOdzxAuwvzp28I7qBQQYnY8ctEtXxn2lqCdq8jISugFk2Y7dLx0A5pr67vsHkLRI9y
         b6jWH0E6JUsa3NpjzaTWc5atX9+YwAKmH3LJLzC2MM88RlBw6x4MbkmhfthdxFEtJdKS
         t5/IjtBT2yIhPHAAwVw3Hloonqb+9i2dOEGeaMuoozH+MF3gefA7AkMQ/Pbvc7d3twqe
         kBfK1V+tqK03amzuJVCq9gO+I5SUXae9bXVyzNx7P+RDVicUiUN+rQQrCNfxxRfXufL+
         XQkicNaCxRp02hU22r1VusPVqaVcJGlRm97PJ/ujalmMdlsAX5VJxUsO4QyFbp5fUT2u
         wPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715106964; x=1715711764;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SxLHBX613BezPFCosUL3vMa1Z1WB1g1HWATAv+V05wY=;
        b=b0o14exiAl9jUFq9MynZ+w2VRGooV1A+QdahlLMuO0hkWGnu8weSXHiXS5QMSuXfhF
         8Nvw1/8TOneCHrjlBPTuYEKZLZnTRtDxUTUsPyZrH91Ipd1Heg0dU628c7ea21E8JF+E
         6Cb6HB0OMR3r5t+YZMueP/5T+Xd5gcLF3+wtjQ1dXXdAAoxkOpyGbxJVtN1cyICVLmYz
         qAEpnNPUWli2p3riJhLrBkkxRW7jkeu6VMN8icl9FRpCEqsPqcNGqs2aOWe3MSSt7UWl
         saNYrp7zn3E6hGLGdsKwGJHwfVRYeMfPWPAq8re+R00o0Z3ngRy4gUGOWSeALYGxMdYE
         LWQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdxAeSEaemSRo5De67qAAELvZL7+I63B4Q17LQIqpORSxETFGc+AciMxLlDuDMt3+iGkGhv1bIEjsu2PYaUV11XMocQzyAbUMYJfB36oNnxw==
X-Gm-Message-State: AOJu0YwjxArHkoIdbylGJanyBa6SqRKm8g1OTRuQ3CqWHmnJNW7HrcHB
	z5TfC8y+w3u6GjQFn/LmjDQSzT0lYpt77GpeWI8kTh93M8WQGkn7zPUbvMhY16qN0+czYqod7p1
	mJDu88g==
X-Google-Smtp-Source: AGHT+IHLQRJTCEv97D7oZ5BJYbjKtKtzp6hp1etnh5mXJgEBM/I0f4k6ffrpTNXBtnPmKqqKpoweO9puZjHH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8095:fd7:9773:b1df])
 (user=irogers job=sendgmr) by 2002:a25:b20a:0:b0:de6:1301:600a with SMTP id
 3f1490d57ef6-debb9da609fmr114708276.9.1715106963603; Tue, 07 May 2024
 11:36:03 -0700 (PDT)
Date: Tue,  7 May 2024 11:35:37 -0700
Message-Id: <20240507183545.1236093-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1 0/8] Address/leak sanitizer clean ups
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	James Clark <james.clark@arm.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Kajol Jain <kjain@linux.ibm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, Li Dong <lidong@vivo.com>, 
	Paran Lee <p4ranlee@gmail.com>, Ben Gainey <ben.gainey@arm.com>, Andi Kleen <ak@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Remove unnecessary reference counts for structs with no gets.  Add
reference count checking to comm_str and mem_info.  Fix memory leaks
and errors detected on "perf mem report" by address sanitizer and leak
sanitizer.

Ian Rogers (8):
  perf ui browser: Don't save pointer to stack memory
  perf annotate: Fix memory leak in annotated_source
  perf block-info: Remove unused refcount
  perf cpumap: Remove refcnt from cpu_aggr_map
  perf comm: Add reference count checking to comm_str
  perf mem-info: Move mem-info out of mem-events and symbol
  perf mem-info: Add reference count checking
  perf hist: Avoid hist_entry_iter mem_info memory leak

 tools/perf/builtin-c2c.c                      |  13 +-
 tools/perf/builtin-report.c                   |   3 +-
 tools/perf/builtin-script.c                   |  12 +-
 tools/perf/builtin-stat.c                     |  16 +-
 tools/perf/tests/mem.c                        |  11 +-
 tools/perf/ui/browser.c                       |   4 +-
 tools/perf/ui/browser.h                       |   2 +-
 tools/perf/util/Build                         |   1 +
 tools/perf/util/annotate.c                    |   6 +
 tools/perf/util/block-info.c                  |  22 +-
 tools/perf/util/block-info.h                  |  15 +-
 tools/perf/util/comm.c                        | 196 +++++++++++-------
 tools/perf/util/cpumap.c                      |   2 -
 tools/perf/util/cpumap.h                      |   2 -
 tools/perf/util/hist.c                        |  62 +++---
 tools/perf/util/hist.h                        |   8 +-
 tools/perf/util/machine.c                     |   7 +-
 tools/perf/util/mem-events.c                  |  36 ++--
 tools/perf/util/mem-events.h                  |  29 +--
 tools/perf/util/mem-info.c                    |  35 ++++
 tools/perf/util/mem-info.h                    |  54 +++++
 .../scripting-engines/trace-event-python.c    |  12 +-
 tools/perf/util/sort.c                        |  69 +++---
 tools/perf/util/symbol.c                      |  26 +--
 tools/perf/util/symbol.h                      |  12 --
 25 files changed, 370 insertions(+), 285 deletions(-)
 create mode 100644 tools/perf/util/mem-info.c
 create mode 100644 tools/perf/util/mem-info.h

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

