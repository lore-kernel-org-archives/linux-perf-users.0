Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F794482EB
	for <linux-perf-users@vger.kernel.org>; Sat,  2 Nov 2024 07:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730532176; cv=none; b=ftHvFvdtZGTU9f9YFvY48mVjLDM09kDM3iA+ffU3tpWu8wwD9hWJe9/MEpF4Aq+rC9EthD1kFC1iP4YZZTnWs43n6/+Jj/GXUCgvd72gkzg5wbZzAS5E3rboM6jRzL1RE003xeYV6EhlT0E65El3jsi7MfgpmzfVtEepzLfZUZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730532176; c=relaxed/simple;
	bh=f60Xoj2LKvx05w0dDR9TU+j/qJ4oIAZCk8jPDR3rWWI=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=STHc0QMbWxwU1nldnGXrequy3FB+Gub3GYj6SFp5H4NU+jIOsGz9Gj09zNXRc56h6JUIvmN2/0H20AIE5ZsUKTO8fv1eA+fqhokSGVpk6l8mjoOfKqj/nhnSuXYQRHQ9L+WJ4wftnxTSu0iiw/9q899EAiU+kfQTVYORWn1YrWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tl6iE6+A; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tl6iE6+A"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e35199eb2bso52289567b3.3
        for <linux-perf-users@vger.kernel.org>; Sat, 02 Nov 2024 00:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730532173; x=1731136973; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U4Ll6UfGCwpaV6mWAj1ZZS2HGux/z3qO7p026R/r0GU=;
        b=Tl6iE6+AcFGcIfrxDLD/uwe78DgrjMf7x39U4Av0SXv/jirX+XAlic5RRSiClnX98V
         eABuJbTscYCzFtT5gq5l2F5H7C1/w259S3/xSOvevKINbSpmwU25XSr/pIXlKa6EK6Zd
         umFNaLScd/oMaG7HrdG+OjyCqCeq5lq1tSYDKV/Zm7Q+WLgTYjoumDMiUZByh6s4SzRa
         Kw6nFsDYrncm566pzIm/LYpJm0e2H7vU5gReIm1HE65uh1iRXvaewG6xU7mAzq2uH25l
         mvjkpOvDB5+ELIkrIKsLVX6eCH3vnjfIUduQO6er6nqfIVv5bhUm/nweKq2xjgjt35Hs
         o0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730532173; x=1731136973;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U4Ll6UfGCwpaV6mWAj1ZZS2HGux/z3qO7p026R/r0GU=;
        b=BIbaPKl845xOhN+pTeW1nYnJpuUAha+wkClZH0Ojjq0P3oZHwRLz1a6T7jlKXXIKJc
         tZxcgb8N0g+Yka93WTXmEsJ+GU8P5CJYW3TQ8K/UzEcnH0dDukBofq/BhGpVmBJIMCHC
         JdwxvRs/5oUyzhSBEzLpIK95IoJCiDQa5D4PK2P1YZKw7wULegEae/nlgWGwKk8ydcLQ
         gIxH8UaCIJ+aPpopqIXQLki6j5tV+47AqQFfIenGNMlv/OGivsMAJMOlLvUDYO5IOIuq
         rGeZq4fjR5GReLwEIa136kXGcqnTU8j/jQ7rZivD7EAPBA1+FBruTrLYmg9XTD06olHd
         Ks/w==
X-Forwarded-Encrypted: i=1; AJvYcCXIkQcODI2wGi64vtQq9HB/mBuA6Fo4pHbZKtjITuAlMQ522Mkcrxlj48w1le86dPDkcXHfZv/+3WagEOgUBYZQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdi+3uB4FjAtLA/XD9kpeNsOGgrsEW7JM6FHcxd/KmPc89ULlz
	GPzumNE/wZ78b5rbj+yAX4RW50YqN7LISXMYq6c6TOxk86feDHqW8uUpYdAvyIDFd0u02pdF16q
	Bfga8Qg==
X-Google-Smtp-Source: AGHT+IEjsy1irjQ+8hts98qCl0YOjz8PtzdRq53YzMky7FbPhMiXdi/cRfpLe+fvtjBoxdCBRe0SAM7VWzb3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:26a5:cdb5:356c:64a4])
 (user=irogers job=sendgmr) by 2002:a05:690c:6c88:b0:62c:f976:a763 with SMTP
 id 00721157ae682-6ea64a961a6mr1045757b3.1.1730532173442; Sat, 02 Nov 2024
 00:22:53 -0700 (PDT)
Date: Sat,  2 Nov 2024 00:22:42 -0700
Message-Id: <20241102072248.12836-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v1 0/6] Avoid parsing tracepoint format just for id
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
mapping a tracepoint id back to its name.

Ian Rogers (6):
  tool api fs: Correctly encode errno for read/write open failures
  perf trace-event: Constify print arguments
  perf trace-event: Always build trace-event-info.c
  perf evsel: Add/use accessor for tp_format
  perf evsel: Allow evsel__newtp without libtraceevent
  perf tests: Enable tests disabled due to tracepoint parsing

 tools/lib/api/fs/fs.c                         |   6 +-
 tools/perf/builtin-kmem.c                     |  15 +--
 tools/perf/builtin-kwork.c                    |   3 +-
 tools/perf/builtin-record.c                   |   2 -
 tools/perf/builtin-script.c                   |   9 +-
 tools/perf/builtin-trace.c                    |  80 ++++++++++----
 tools/perf/tests/Build                        |   6 +-
 tools/perf/tests/builtin-test.c               |   2 -
 tools/perf/tests/parse-events.c               |  25 +----
 tools/perf/util/Build                         |   2 +-
 tools/perf/util/data-convert-bt.c             |  10 +-
 tools/perf/util/data-convert-json.c           |   8 +-
 tools/perf/util/evsel.c                       | 100 +++++++++++++-----
 tools/perf/util/evsel.h                       |   9 +-
 tools/perf/util/evsel_fprintf.c               |   4 +-
 tools/perf/util/parse-events.c                |  16 +--
 tools/perf/util/perf_event_attr_fprintf.c     |   4 -
 .../util/scripting-engines/trace-event-perl.c |   3 +-
 .../scripting-engines/trace-event-python.c    |   3 +-
 tools/perf/util/sort.c                        |  33 +++---
 tools/perf/util/trace-event-parse.c           |   4 +-
 tools/perf/util/trace-event-scripting.c       |  10 +-
 tools/perf/util/trace-event.h                 |   4 +-
 23 files changed, 209 insertions(+), 149 deletions(-)

-- 
2.47.0.199.ga7371fff76-goog

