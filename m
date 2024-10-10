Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EBA11712
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Oct 2024 01:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728523300; cv=none; b=WupWzZxj8f4zK7/e1Fi+yW5Ou9JxpZZ3Ifp9EE87NiVwYuxSMH5jrfvRBqk0KRIPH1ecdFTThJ4oI0VDgLjzcwoYJhkrate2SWCASidKe99ugNUcYOFr416s/oQNBelhZH9lgz5Mrpu5FnjqlXnO6AX09IUKWP7BOCde2JO5J7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728523300; c=relaxed/simple;
	bh=t7+Xm23rFntNT72tJU+PBupmwVOBnjMLS0/HU1OJPLY=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=D0cJpYS2xvlkfrU2wG9VUUUHWQ3ErEwGh3gNpkIiD9YTu3TGvONfIyDAWEMcZnC44BeJ5PSY1z3BDUjY6BulRmbKsSYo9SRs6qe7Ldtdi27XCd5S2KilDprcUmH1p4sH6UjQD+wPO13E4YpJRmWsOI5QtZkViWXVwZtBa18SHOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3nf6voTD; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3nf6voTD"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e32e920cf6so10457687b3.2
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Oct 2024 18:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728523298; x=1729128098; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H4EsSfgvjieiysBAaZRmDwmuXhJUeXONObNB3pTJ5ow=;
        b=3nf6voTDYiUqfFtbM0kC2c8u8FUONokLvGmEGEBmXV4656MGFp6phnCYu+1UXQI5M5
         ZoHAYYUMDxKhoOCq4I3u4IzX12pWMA+5+rfq7SXjKI38SrmS1EK7dylfnLmFs5+/ilqL
         liu9w/8d7hGfjmaAsV82TzfSyR+0sN7SkWoOurfx2VI2ca74h9G3wTheSsujeFIMcHXh
         RyIs1B7aBqCGUTLgD891uX4G/S28PPyAVRPbHAHkC+yv/mTFLoEIkQxa2uHbAn1eZk3e
         IkQToHpUtmoi25zeBuHniU4puIUmW8uwWMLrDRwpaqCo3rOvY3vO0HPgKD9vK0VTkTr5
         Nj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728523298; x=1729128098;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H4EsSfgvjieiysBAaZRmDwmuXhJUeXONObNB3pTJ5ow=;
        b=QeKRZBFyz4uz4RjPQoV3MHVVf8wxRep0MV/dds38jvqgLADz88DsCbVtlgGTGCovwg
         YUaUJ70zax9i0ERHAsAt2QM6Psor1AMWvpFaTNVU5G24f3y9Vc+mJs3JSgcPg+dHdV23
         xVgWCrcpA0mKRGuJGR2vHkY8ddiVMduRtJztRDhfvsfeGcgv0zsA//MKt77mabQgSx41
         4rYwgozeLGnBbvA3U6nhzXVZeeDLLcK2vmHdhHetbwaffVet6Oasu9dUQsHQib4x5epb
         5HUVxsj/sum7VAW3IKJVFg7XtVnCeywNXge5D5/QSdIX2XU2t/TMMLMGbsXmqj80Uymi
         m3Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWAbv1hNnLK4IH+OaqPYGTLlnlD8WJe6jPParqTnOvPTJcsDiu6gEsTmumxuOsAjZaupDaUTwacyL20LiP/o869@vger.kernel.org
X-Gm-Message-State: AOJu0Yw418nkGLrT987CHZ/QohAZZG8UgWqfj4UTUPhr3pVEHdWsdx6v
	hZLYJq64hY2IRm5TqrJHzwfg621ihjewu4sdgIhM8+zjbbwLTrTHCTCY0S6aDMDDkErJxkUIZb5
	jODbRKw==
X-Google-Smtp-Source: AGHT+IGD/HNw5pjcSUi+MRAd6uz661d5qjMFSjFtSyfUyURc5nnXQbawJ032cuCC4+gdDmJUtcghlm5nssP/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6c8b:1170:a0ca:9d72])
 (user=irogers job=sendgmr) by 2002:a25:d817:0:b0:e25:6701:410b with SMTP id
 3f1490d57ef6-e28fe379330mr75895276.5.1728523297988; Wed, 09 Oct 2024 18:21:37
 -0700 (PDT)
Date: Wed,  9 Oct 2024 18:21:26 -0700
Message-Id: <20241010012135.1272535-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 0/8] CSV/JSON metric thresholds, fix printf modifiers
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

Resend. The first send cut-off patches 7 and 8. Sorry.

Metric thresholds are being computed for CSV and JSON output but not
displayed. Rename the color that encodes the threshold as enum values
and use to generate string constants in a CSV column or json
dictionary value.

Add printf attribute to functions in color.h that could support
it. Fix bad printf format strings that this detected.

v2. Don't display metric-value for json output if there is no unit.

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
2.47.0.rc1.288.g06298d1525-goog

