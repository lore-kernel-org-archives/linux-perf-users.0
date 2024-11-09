Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92540233D65
	for <linux-perf-users@vger.kernel.org>; Sat,  9 Nov 2024 06:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731133104; cv=none; b=C2dCDoYck/ZjtUhwIC3QeLJvMQEPTTqIvRxLTnp4W5S2StlEpxNpWWWuD0V1zFgYKDi5ZWwCKLOx3UrBxAKKCKzmIVp62KV2RIQZArbu9VjUStSsIy6Ph7d8nINin4SoCjJOyCE3ID4cgAaSxfuq73GQTA7kT4zx4K7ph89ul4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731133104; c=relaxed/simple;
	bh=pbgLTFFr4uI+4LrzuiuIdZNDR0i5Pu9mo6BzRIx2014=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=BMJIc+McH4TsSaY4KikUIpJac2FVoYjnVMrYTpEZ2OIV9Qvp7j3RsF7FPC5oYCcMWUbLLttRkN1CvtbbJvg3I/0RJsUsihJVkyDVG9Qe2+hVfvdwdTyLut0BkDrpBHfcpoRrR9TQuthkkgFuUR3HSjamh8qlOLt2IuCmpmXJt0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wA+edgHL; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wA+edgHL"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e5bdb9244eso43883137b3.2
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 22:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731133101; x=1731737901; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xGlhy2Jf70C/nc+DkEnXhF3Aqyqew+42qfbA3RATI2g=;
        b=wA+edgHLE7GTxaiVUuiLsDi83vjdWB8ZYygQKOh6GfzJgVF57PZ5sRaD1qm7IYIlup
         LzmM59kLNLLy5H13rH1bUGNwJYQq8ezA94q++X2TA1IKJCPlUoGzJqXkm82jvwpDtXbV
         nAyz7fGhcDD+mX0V4l3ZReu+Q3LeLzc8NfjsL0iMyLImrEiTUV/Srm82dh3YfkErooko
         CxV9m7LcTp4JoDG9PznffUyYuli0YS2AoQLqFKjyW/P7dN5CVTK4aVjqM9Ek0PbQL4Nc
         5YuSdAZDf4c4xgUOdM5b3D4ln4zp9/Ovg4zn4cRxxkDsPXF85c7CL1iI5DmUoXJQtp2q
         gDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731133101; x=1731737901;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xGlhy2Jf70C/nc+DkEnXhF3Aqyqew+42qfbA3RATI2g=;
        b=wXFGDCG3ykbI+TLSd1XPi7zNZL+BnzFcBnqrFjVr+pxfoRr/bzBuNmPRYxZfubsct5
         iJxhjOIyKEIcL4WG200lFMFM9eXcc1VP1qm2lzkZwrZ8p9J6sTPrZOYJlaPsiG1B0YPi
         vP67dmImROsaocoK3+1se7wr/UGnvQqbBBJYb7BR1pcT7nzTMziBYh5u9MUF+V5WMHwc
         1IJNNmbqbg/6f38PLQ8YpDSsmZF+91iJMN9khTUorLhr9nLasfpibOYDEHhiaEoZasNc
         FYqXEOXFI1E2Ow8g3OojMsUA6a3oPBUJERnRJI9slQflth1cg3WrGmG/t84VBHka3pve
         Qt9w==
X-Forwarded-Encrypted: i=1; AJvYcCVNZRIt9eHmrp2S0KfdeGlhc8K9FpdXiinEfNpqhs1GtIY4RKMD9Xd2vmoKp6aGPCQiUsCVDE0H6i3J7ROZ1JVX@vger.kernel.org
X-Gm-Message-State: AOJu0YwHZ6us5GFvIW8CQ8jEuZmAo73krcmJXHQlfL0X56zY+02hFrcP
	f9v56fFATkOH0Lzj++PxBS4DMKsUNEm1O/h6Uy5dfzgxhbtd81NsDU/fDMJ47eqhOIEbMn5gURL
	s0K+4wA==
X-Google-Smtp-Source: AGHT+IHGGXxTIkV7oynhaMdGf8BZFoCRQ0qf8xUTg042vK198mIanvjubKWTRx8WAPkh3eaVOloFA5sFBfe9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc2:d48f:a998:5915])
 (user=irogers job=sendgmr) by 2002:a0d:e703:0:b0:64a:e220:bfb5 with SMTP id
 00721157ae682-6eaddd87123mr315567b3.1.1731133101451; Fri, 08 Nov 2024
 22:18:21 -0800 (PST)
Date: Fri,  8 Nov 2024 22:17:47 -0800
Message-Id: <20241109061809.811922-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v6 00/22] Python module cleanup
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch:
 - removes workarounds for Python 2 module support due to long
   deprecation and challenges in developing new code;
 - constifies variables and parameters to functions;
 - removes python.c stub code which existed due to missing functions
   that are defined in the builtin-* files, in general the builtin-*
   code is moved into util;
 - remove bench and test perf C code from the python module;
 - adds parse_events to the python perf module.
 - improves upon some of the existing python perf module functins.

v6. Rebase. When moving find_scripts, separate the switch to using
    is_directory_at into a patch before moving the function,
    Arnaldo/Namhyung. Add acked/tested tags from Arnaldo and Adrian.
v5. Rebase. Fix NO_LIBBPF and NO_AUXTRACE related build failures
    caught by Arnaldo and the build-test. Fix NO_AUXTRACE x86
    arch_fetch_insn in the process, which was incorrectly using an
    empty weak symbol stub.
v4. Rebase. Fix the parse events evsel to be embedded in a
    pyrf_evsel. Add __str__/__repr__ functions to evlist and
    evsel. Throw an exception for a bad evlist index.
v3. Move is_directory_at to patch 6 rather than patch 7, respond to
    review feedback on the list from Namhyung.
v2. Add the bottom 4 bullet points - 13 more patches.

Ian Rogers (22):
  perf python: Remove python 2 scripting support
  perf python: Constify variables and parameters
  perf python: Remove unused #include
  perf script: Move scripting_max_stack out of builtin
  perf kvm: Move functions used in util out of builtin
  perf script: Use openat for directory iteration
  perf script: Move find_scripts to browser/scripts.c
  perf stat: Move stat_config into config.c
  perf script: Move script_spec code to trace-event-scripting.c
  perf script: Move script_fetch_insn to trace-event-scripting.c
  perf script: Move perf_sample__sprintf_flags to
    trace-event-scripting.c
  perf x86: Define arch_fetch_insn in NO_AUXTRACE builds
  perf intel-pt: Remove stale build comment
  perf env: Move arch errno function to only use in env
  perf lock: Move common lock contention code to new file
  perf bench: Remove reference to cmd_inject
  perf kwork: Make perf_kwork_add_work a callback
  perf build: Remove test library from python shared object
  perf python: Add parse_events function
  perf python: Add __str__ and __repr__ functions to evlist
  perf python: Add __str__ and __repr__ functions to evsel
  perf python: Correctly throw IndexError

 tools/perf/Makefile.perf                      |   7 +-
 tools/perf/arch/x86/util/Build                |   2 +-
 tools/perf/bench/inject-buildid.c             |  13 +-
 tools/perf/builtin-kvm.c                      |  61 ----
 tools/perf/builtin-kwork.c                    |   3 +-
 tools/perf/builtin-lock.c                     | 137 +------
 tools/perf/builtin-script.c                   | 304 +---------------
 tools/perf/builtin-stat.c                     |  27 --
 tools/perf/builtin-trace.c                    |   1 -
 tools/perf/builtin.h                          |   6 -
 .../scripts/python/Perf-Trace-Util/Context.c  |  20 +-
 tools/perf/tests/stat.c                       |  16 +-
 tools/perf/trace/beauty/arch_errno_names.sh   |   3 +-
 tools/perf/ui/browsers/scripts.c              | 177 ++++++++-
 tools/perf/util/Build                         |   4 +-
 tools/perf/util/bpf_kwork.c                   |   2 +-
 tools/perf/util/bpf_kwork_top.c               |   2 +-
 tools/perf/util/bpf_lock_contention.c         |   2 +-
 tools/perf/util/cgroup.c                      |   2 +-
 tools/perf/util/config.c                      |  27 ++
 tools/perf/util/dlfilter.c                    |   3 +-
 tools/perf/util/env.c                         |   4 +
 tools/perf/util/env.h                         |   2 -
 tools/perf/util/evsel.c                       |  19 +-
 tools/perf/util/evsel.h                       |   2 +-
 tools/perf/util/intel-pt-decoder/Build        |  18 +-
 .../intel-pt-decoder/intel-pt-insn-decoder.c  |   3 -
 tools/perf/util/kvm-stat.c                    |  70 ++++
 tools/perf/util/kvm-stat.h                    |   3 +
 tools/perf/util/kwork.h                       |   6 +-
 tools/perf/util/lock-contention.c             | 170 +++++++++
 tools/perf/util/lock-contention.h             |  37 +-
 tools/perf/util/path.c                        |  10 +
 tools/perf/util/path.h                        |   1 +
 tools/perf/util/python.c                      | 341 ++++++++----------
 .../scripting-engines/trace-event-python.c    |  63 +---
 tools/perf/util/stat.h                        |   3 +-
 tools/perf/util/trace-event-scripting.c       | 177 +++++++++
 tools/perf/util/trace-event.h                 |   5 +-
 39 files changed, 872 insertions(+), 881 deletions(-)
 create mode 100644 tools/perf/util/kvm-stat.c
 create mode 100644 tools/perf/util/lock-contention.c

-- 
2.47.0.277.g8800431eea-goog

