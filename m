Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D68621E082
	for <linux-perf-users@vger.kernel.org>; Wed, 21 May 2025 16:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747846421; cv=none; b=ojnIktd/D952Kckq44pFx2f8AqMhz7GGjEf+Qc/3QfLLIaKvROb2yOsGeXgErlK6qKFq6xCy9aCXqYdBOWm8C0Rw5lPgWyB33BqNinF7CG2LEtdkvffGHF5caT0XEL0OVcitxJLmrWKfQZxIblpdiQLb26NF1HTfT9JXfCKJ6gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747846421; c=relaxed/simple;
	bh=/6cG1UExbTK3wCJmRyYwDHluktLcBVaJoz4/gFUB1E0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=fM67q6tcVD8uI4GKnGy7TKHr0XqzpF5puscnQKdtd8/fX4pEQdnS7kMHy2Vc5MvSZjMWkOJIzejUXoS51HS2UN7r/bi+jaHumPLwcDesHUgV/xsszJkXtUlo1ny3ZjbkGQayT8QQYiay4z6WyHY6TOwsC9GhkHmaatF40WtSfh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kuaV04Ut; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kuaV04Ut"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7375e2642b4so5241287b3a.2
        for <linux-perf-users@vger.kernel.org>; Wed, 21 May 2025 09:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747846417; x=1748451217; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PJDwk9lUeWYqaloF3KP9PdD4INzzphYEk8OumbojYXE=;
        b=kuaV04UtUQ/nHpyA22eSMbQpi0dMGmJ9hFFpVxM13ZAplbVHc7mhbQpyXrZlvsGWsz
         etp18hWXJ37waASPbFCTShBHJOFtw1uxT62/vwQRM1CBzDm/p8f0Z4dXpsEwNASd0c4c
         7GfSPSzktfjuQER/L0qQ6F58AXfogu6vsxarznfjIzFfT3maz/C8FK8vdSZKHpMry0K1
         UZvlLZaWydPfwhvvVnahQppwwsD8tGgKb5M771p8Wd3ydtKIeEvg4UIS4Yo7rWB4oB2D
         AGTA7b9t0pze1345gDRRrCFWmgUQUKI4/+v9WwWvrQYi+DWlktfRzEWIi4ALy/AyM15r
         4BkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747846417; x=1748451217;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PJDwk9lUeWYqaloF3KP9PdD4INzzphYEk8OumbojYXE=;
        b=rvPrGgEwWY5k5BEmfSdjskFTFQbDXPJazuiQCfGkdkWnvkQAGf/YOX/audbYXhYpQf
         m1oGA51HCxykto8fV++Umg6sSkPdGLugmQYraIaGu22bdagdPtBhaJQGT6uCCtmsQ5yi
         oYF0644cH/l4FEmP4zUbUTIIIzRTZpcnN2Y8jgM4Ipun7Crr4699RZXtOD2WIk/Sbb1L
         HWqt2gGWfLH9lhM27oTu496xSVWfaba5OPr1fBAkvrFnSbPTjJRsDDwAkLSka0GKU1du
         WWuxd4AtCJSirsYhYUTNIgq1yDbYVMzjXdS4iEhH1sF8qxy5yMTiwA+Qm9xhRHiGxmMQ
         WZEg==
X-Forwarded-Encrypted: i=1; AJvYcCV9BvDwaU3eXRgQfMneGzrUIhmomiV+er47H8pnWgHapcGuEEOf7OmfdB15xOaH/WkoOhwSIEhR/k7mPXLbFbEj@vger.kernel.org
X-Gm-Message-State: AOJu0YyLI0ttpj5CAhxcZkgafFwe/+WQS1Ncj7iMc/r7gQ1OYYSE7+Pw
	pGl4Il3lIZfYwTCTQ+PQh2U+fc1x/IARRnIOtncdLZ7Q5cxUl2UgGJXZBx2JmnNKXlna2+YRrbM
	52Fulb+l9fg==
X-Google-Smtp-Source: AGHT+IHNtvMZiy9V/nlqZBj/BZJ3CVXw8tEEjM3Ced/VNZbyxdocjSeMDVn2IQN64SDBVY8MSfqlpS++GleC
X-Received: from pfblc16.prod.google.com ([2002:a05:6a00:4f50:b0:740:b061:1007])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2da5:b0:740:41e4:e761
 with SMTP id d2e1a72fcca58-742a98c144emr28807373b3a.22.1747846417381; Wed, 21
 May 2025 09:53:37 -0700 (PDT)
Date: Wed, 21 May 2025 09:53:14 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1143.g0be31eac6b-goog
Message-ID: <20250521165317.713463-1-irogers@google.com>
Subject: [PATCH v3 0/3] Generic weight struct, use env for sort key and header
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
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"

The arch directory is a barrier to cross-platform development as files
and behaviors within it are inherently platform specific. Sample
parsing should be generic but the PERF_SAMPLE_WEIGHT_STRUCT handling
was only present if building for x86 or powerpc. The sort key and
headers should be specific to the session that is being executed and
not to the machine perf is being run upon. These patches clean this
and associated code up.

v3: Code reorganizations suggested by Kan Liang.
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
2.49.0.1143.g0be31eac6b-goog

