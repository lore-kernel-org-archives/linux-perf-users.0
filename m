Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA78338F80
	for <linux-perf-users@vger.kernel.org>; Wed, 21 May 2025 13:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747835711; cv=none; b=E13JlI9jnNZSWp0Yos6Y2zCzSGg/PrGh0pfbrKc8kXuY0zSgztKaVR2FH391yRcEYQHuM0V4uz5tHxLgeoLtYB0+kgcAZVQgBk+4lp5veqLmCQozVxhs97I3+FUq6DH1h1EjpARkKI5nqxP7jQOrrZYAQrRAS7Jh6vvaCCQNygU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747835711; c=relaxed/simple;
	bh=rVbYGqc6uu4pi52v0t9cDGdujwUq54fjcCy4+b7uFP0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=szDYDPtqAHCOvzK+tZP/EQF+nxDlxfod4oLrYn+SwobQAUA2WRn2KcwmKPfo290KdOrQumM5/OusEgNZdqVCP9jj/TVtFpk9Hlickc3Zpms0sxv4I+PpndIu23NNilO8CzOJMpJZrYaTIIirVpKLCRjNp8stwXRXqw2F+pM0F7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IHo8HMX4; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IHo8HMX4"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b090c7c2c6aso4479801a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 21 May 2025 06:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747835709; x=1748440509; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SHwjOM67YtRFALWcy9t4h9R2idl0QlF9QCqJIzMXRTo=;
        b=IHo8HMX4MXA9szEpMTE1W1z2G1JMJ7wgYiRQF78un/R3rTGjcsPZ6IkdZovrtHP1MK
         WA22N15JSpulO7CcClB805erZEVdrs0SOPLrhIQ6gfkUYVV9LBywxWNPXgUTi0sv/KMl
         yce4OvyL3iaj9EccQWePHCI1vjpRv1/TYfRetYiN9uPTJyrCwn8JXqnsKUbzZaeLcDsV
         vxQtxbXKRVfO3hhe+anj25VJwWYOovyboKy619qP+QNKL9LfLPYvtH7KIA0AbnNHDAoh
         YGQqYifHxPwW/2j0zKGINFjvo5k/960h6oQI5LPEl9xXMzFJCg4GlIeHHTiUC7keIPl/
         rytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747835709; x=1748440509;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SHwjOM67YtRFALWcy9t4h9R2idl0QlF9QCqJIzMXRTo=;
        b=k/0Hardpifo3DU3TQ6ypURhFwdtOpA6EeZSmhkzAa3XKnwQnrRqE5kow6N5Q7UV+UL
         K/AIB/AAIKBSSm/9IQkTn5xaRC7xPV3LrZoghrBG+WB7geWpAWipNzNGOpDxmTDfEF3G
         Hv6FXbZv0ZAvfcE8aj86nANtp/mdtIuCE7K1psNlmOik4TDiUeZWTepGk3RJjMe5mf4w
         potIb6C9XfzhQewvQIWkaoyb0Qv3xr6BWN9axk+IJGdwpawkEQ/3jXdsvCHYkQL5Egl+
         WcIx0rurdjNI5zVxqNOrMlnUcXpayOxw26K29QsdaFCPV7qjpSDBdWynysCOdfGTNaOV
         s2QA==
X-Forwarded-Encrypted: i=1; AJvYcCXXPyYCuA/w2RUTtsZTYYTWpjo0bcAzOmRL7TOWGg2XWR9LoKua/fk8kIzDJ3gf2UM4SJQvaoC1bv/Bv78F0pkZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4tGwY8Fe11SgmhSIBzG5RaCSI9e70XduFsMl9CMGm/bA3pLxe
	B3mmP3do9LZPG6y3F/CkpWoB2wZSw/Oc+NCUqtQow7DLf/mIrjEkvv1mfMbVuanMBCsWm09+nep
	nF5UQRD+N+g==
X-Google-Smtp-Source: AGHT+IHTn5eMvpTptVNuhPDlyaiSK8pVVa+lYEtgEB6cPWQHj9df6/bmr0Y1r1JqU5RVWuD5LV6s5tEQuM51
X-Received: from pgah25.prod.google.com ([2002:a05:6a02:4e99:b0:b26:8f51:5788])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:695:b0:1f5:8cc8:9cbe
 with SMTP id adf61e73a8af0-2170cb07de7mr27159029637.5.1747835709039; Wed, 21
 May 2025 06:55:09 -0700 (PDT)
Date: Wed, 21 May 2025 06:54:56 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
Message-ID: <20250521135500.677508-1-irogers@google.com>
Subject: [PATCH v2 0/3] Generic weight struct, use env for sort key and header
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>, Leo Yan <leo.yan@arm.com>, 
	Yujie Liu <yujie.liu@intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Matt Fleming <matt@readmodwrite.com>, 
	Chun-Tse Shao <ctshao@google.com>, Ben Gainey <ben.gainey@arm.com>, Song Liu <song@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The arch directory is a barrier to cross-platform development as files
and behaviors within it are inherently platform specific. Sample
parsing should be generic but the PERF_SAMPLE_WEIGHT_STRUCT handling
was only present if building for x86 or powerpc. The sort key and
headers should be specific to the session that is being executed and
not to the machine perf is being run upon. These patches clean this
and associated code up.

v2: Avoid changes to include/perf/perf_dlfilter.h as suggested by
    Adrian Hunter.

Ian Rogers (3):
  perf sample: Remove arch notion of sample parsing
  perf test: Move PERF_SAMPLE_WEIGHT_STRUCT parsing to common test
  perf sort: Use perf_env to set arch sort keys and header

 tools/perf/arch/powerpc/util/Build         |   1 -
 tools/perf/arch/powerpc/util/event.c       |  60 ----------
 tools/perf/arch/x86/include/arch-tests.h   |   1 -
 tools/perf/arch/x86/tests/Build            |   1 -
 tools/perf/arch/x86/tests/arch-tests.c     |   2 -
 tools/perf/arch/x86/tests/sample-parsing.c | 125 ---------------------
 tools/perf/arch/x86/util/event.c           |  46 --------
 tools/perf/builtin-annotate.c              |   2 +-
 tools/perf/builtin-c2c.c                   |  53 +++++----
 tools/perf/builtin-diff.c                  |   2 +-
 tools/perf/builtin-report.c                |   2 +-
 tools/perf/builtin-script.c                |   2 +-
 tools/perf/builtin-top.c                   |  16 +--
 tools/perf/tests/hists_cumulate.c          |   8 +-
 tools/perf/tests/hists_filter.c            |   8 +-
 tools/perf/tests/hists_link.c              |   8 +-
 tools/perf/tests/hists_output.c            |  10 +-
 tools/perf/tests/sample-parsing.c          |  14 +++
 tools/perf/util/dlfilter.c                 |   2 +-
 tools/perf/util/event.h                    |   5 -
 tools/perf/util/evsel.c                    |  17 ++-
 tools/perf/util/hist.c                     |   4 +-
 tools/perf/util/hist.h                     |   2 +-
 tools/perf/util/intel-tpebs.c              |   4 +-
 tools/perf/util/sample.h                   |   5 +-
 tools/perf/util/session.c                  |   2 +-
 tools/perf/util/sort.c                     |  67 +++++++----
 tools/perf/util/sort.h                     |   5 +-
 tools/perf/util/synthetic-events.c         |  10 +-
 29 files changed, 150 insertions(+), 334 deletions(-)
 delete mode 100644 tools/perf/arch/powerpc/util/event.c
 delete mode 100644 tools/perf/arch/x86/tests/sample-parsing.c

-- 
2.49.0.1112.g889b7c5bd8-goog

