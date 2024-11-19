Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA542B9A6
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 01:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731979021; cv=none; b=P+sllgIP6DG0kAToXnaIODsOVkQvhruI4ChYifyGRtZfEz75qf///d+jSmeupdbyao9bnnDvxncbanXbLZAluafOOBba46HtJIARwg/ScyC/oIaqzyPo7BhA4NkZX8Rlf7DoIm/XylMRhetUMiPjsD4lEY0CTsqNJjk/vknfzR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731979021; c=relaxed/simple;
	bh=mj1TYlGjypzaRKv/9Vs2oJsosaO5OMaz3VltVuBhe70=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=YxVRBLMW0NBrPVt65tJhUrOXf0JQJh2CSqkBK9kHHJd/Rfa2c90D1WRjb+5Vva71CfSmH+Uudq1JgaJ2sIl7CnjwmZxrMZHY+z3CNM/dPb1lgSvHhK0GMZ8KdHPIAi0U7/Nc9Ut/HrRm0DHkq1OZMeAxbirmjzXcl+acWfyswdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=psGxRtxU; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="psGxRtxU"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2971589916so4989388276.3
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Nov 2024 17:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731979019; x=1732583819; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TTxXth8FKid7MsnWj6zjsfoXRJdOxSAT4OWD8juj9rE=;
        b=psGxRtxUPi131m/+RaDuNYLdhQvSUiFbzt7fpTbRIjXQDyj0dyWzOEhlG6Z89DnpTP
         Hbz2VoPvhTXaa8inQBcv4euZ9XSQg/qL4Z3njXqf/vAqYSoeAiyL58ek+IZlvASOGj9J
         kfdNulxPiT2Q6Cwo6wZ/lnvpCPFXvRBdpfDaMRDe09DsVTUMnGqMpIvj3zw94/XNgDGW
         CJtjTujiYo2tGrMaXgliOkUSEE25ypPhxyci25wSTTSo7jfgXOKGy1oVrM1qKacYn//7
         YBoG+P+YPFyAovoxbMGFkWbJrE3iMKBhOWH7ljGnS+X5x8tnP+N76O1BJeHx99VAShfc
         jXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731979019; x=1732583819;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TTxXth8FKid7MsnWj6zjsfoXRJdOxSAT4OWD8juj9rE=;
        b=lX3F4Cdpjz3xjiIhys9RrE4AonYgqsrNm13vf97KFNOdoD0KpafeqzMu5VWu7CEQAC
         7PG0OeXUqzKxSe1d/j3NZ+kBPW9BCYhgAhzyocVPXqQ3/loIaguiAURwGzMI+dMQHBsg
         0aKfIyIVj269WBCh0bRXDRrMO4MB01KvvknJvUPS9DFko/GEPGf/IkvDnostYEab3OJL
         QDUfIKG2cVaYM6gv6EGs0n8hvfE3bhKAFYfhs2mbEYKJW+0p97Mmhgr1WillzLKbDsYW
         +4CvTedHhbnnvxkeKUSLmJFUUDvuflz6Yi4EKiSbEr+wZB67DXRSl4E1kv4PH6k2xKDF
         L/7A==
X-Forwarded-Encrypted: i=1; AJvYcCUU4rjPNoR+uDpMiJCPTImAQb3m2rBSU85sl3Nxtmgm/maXfaEnJGh3QzYRK0//btxlQV8JUEEbzuHP11AKaToU@vger.kernel.org
X-Gm-Message-State: AOJu0Yy071Mnb0yZOkKprkDIdPlMpFU39MplulucuhXpee4agb16iMqo
	1lu8yjFeMvckpDgv6DaM67ei+5Ey7uhtnCoW++jShCyb7n/h3cEXPRb1DjymJPgb2imNQmI8lLc
	0vbl36A==
X-Google-Smtp-Source: AGHT+IFHHSibZqFSeR6+HwN+6MBqNs0wYmg/0yrHVPgwi8PTrRXbLClCpeBKmwMxyg4SU13Se1Hyqu1HQK0E
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:22a4:ded5:5c37:fcc7])
 (user=irogers job=sendgmr) by 2002:a05:6902:1370:b0:e2b:cd55:11b3 with SMTP
 id 3f1490d57ef6-e3826386bbamr10463276.5.1731979018593; Mon, 18 Nov 2024
 17:16:58 -0800 (PST)
Date: Mon, 18 Nov 2024 17:16:22 -0800
Message-Id: <20241119011644.971342-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v7 00/22] Python module cleanup
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

v7. Move ifdef-ed function stubs into header file for Namhyung.
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
 tools/perf/util/lock-contention.c             | 143 ++++++++
 tools/perf/util/lock-contention.h             |  18 +-
 tools/perf/util/path.c                        |  10 +
 tools/perf/util/path.h                        |   1 +
 tools/perf/util/python.c                      | 341 ++++++++----------
 .../scripting-engines/trace-event-python.c    |  63 +---
 tools/perf/util/stat.h                        |   3 +-
 tools/perf/util/trace-event-scripting.c       | 177 +++++++++
 tools/perf/util/trace-event.h                 |   5 +-
 39 files changed, 847 insertions(+), 860 deletions(-)
 create mode 100644 tools/perf/util/kvm-stat.c
 create mode 100644 tools/perf/util/lock-contention.c

-- 
2.47.0.338.g60cca15819-goog

