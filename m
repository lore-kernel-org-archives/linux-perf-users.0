Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534CE199FBB
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Oct 2024 22:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730241879; cv=none; b=Pv/i3q0DT5MaVvd/byDrDYlUm93GZ0JV5R70BzxSyU/YfHFEJbd0aTzJnKWz9jp5S2W6rK202kmPRTz0qOa1qtsslGpYnO6brSPuW6RkOLx6YR1QfAMe7FrBIlz7/PEisQBXUATQtyYYHcJ1lQkAForxS93InrhPrYlV6M9qmvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730241879; c=relaxed/simple;
	bh=1U+miEa3kQwSNxk3U9G6wCwVhUksags9HM9B8lRhtZ4=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=XF26QPdWOEenwqxkWAmtcT+ovBDJxKJ4cpsmPCUpx4ggzx5i43DbF5rVK41sb9NLm+A9+m0lOQPmJ4GYoEb348o7VjvbNl+ECR1nuWEI97dVE0QYBXXcYI5UA69uzfIRvvcVcB03yoynkLAtXF8PvjFcoyO8U7c8WVywcyCVizo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VxFC4a0X; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VxFC4a0X"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3d660a1afso106092937b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Oct 2024 15:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730241876; x=1730846676; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZScZoLloXNE7Jh+jagI6pazhAYS35p8ttkuzpJMXUcY=;
        b=VxFC4a0XsaSH7Q3vNnbQfWI49y7N70VBTCBZsDSWHGJ1gTcayD7it1xHClxSNt9zI2
         hrikBH+W+1eD31QD6n7g91fqQSiFev9a/QncXIgsq4CFcGmJXsNSUok0Vsbte+23hMbF
         yFw4BZOhxHEvwpm+eGhVOOjvF6dmRD0HJ5rT3eb8ckj5nPJF3NcKGOR0BeY4EnD9tHqn
         rmVjQYOdzUQ7l8hW4qT0ORgwlLrIORqk+KogI0G/Qr0b0KbfG0RhBIP0a21xK89NfsF8
         gwuYIZ5D+CaD3swwdHgl3JbI93LF5PDGqwwJVFSVMVeI1loMP0m7QOyqO+SayNvFRbBG
         JKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730241876; x=1730846676;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZScZoLloXNE7Jh+jagI6pazhAYS35p8ttkuzpJMXUcY=;
        b=a0Rboas+2uGIcgL7eSaECCo5JCpdL69kLqSlFY5MS4dygzs8Z9h7AwYjIKupk0dFyC
         ZIh0m8yAj73alHjUiar5c8X6BfaIJ93gIBMIN3NIJWSB24HS5znCB6a5II1aa+xEqPex
         a0W+IKWzGpjoNpYW4q7QrnQfw0J8Guce+fS5tVv3lOSHNWj3s2PiCd4FuJFX5FlEs97U
         94FpKaciBKg5CJDBGn9USEBTvD4FF+9yqESKStBqcYg2kSz/uzDZunvNFrmeqbERHzsB
         +h4bMJ74716oKajreoOeIw7YapXuQxsvHe9Zy075o9rDr9x611EhVeJgs2LNcCsarqHj
         aINA==
X-Forwarded-Encrypted: i=1; AJvYcCU4AjCvoOngi7l0ZG8JLplDIcjghBsaOpNtk+QD2zC8gpSrAfwpaXOK3lkZsZhitAMsW6GgGUqw1W9osScnfVyw@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvf7Q/JIjdHhlAYvaIUPusPtOFlyrPQ0mJHiCQ2AUPQY6WiEZg
	mwNVseaA/iJS48400vmEG4/84wYrh7cYQypzFoBy2STDEK6FHsB14QAxxjtojV5HrmKyrKEp1Dm
	YicltXg==
X-Google-Smtp-Source: AGHT+IGpZHWdkqq4D1OMb/pNE0SO4VsnqyBS/b+meypXZpfCgJLC9qLP6BtMC1KqDedOIyQEKqXdRveW3UZp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8991:d3fd:38a7:c282])
 (user=irogers job=sendgmr) by 2002:a05:690c:6807:b0:6e3:39e5:f0e8 with SMTP
 id 00721157ae682-6e9d8a99518mr7125207b3.6.1730241876274; Tue, 29 Oct 2024
 15:44:36 -0700 (PDT)
Date: Tue, 29 Oct 2024 15:44:12 -0700
Message-Id: <20241029224431.167623-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v4 00/19] Python module cleanup
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
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
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

v4. Rebase. Fix the parse events evsel to be embedded in a
    pyrf_evsel. Add __str__/__repr__ functions to evlist and
    evsel. Throw an exception for a bad evlist index.
v3. Move is_directory_at to patch 6 rather than patch 7, respond to
    review feedback on the list from Namhyung.
v2. Add the bottom 4 bullet points - 13 more patches.

Ian Rogers (19):
  perf python: Remove python 2 scripting support
  perf python: Constify variables and parameters
  perf python: Remove unused #include
  perf script: Move scripting_max_stack out of builtin
  perf kvm: Move functions used in util out of builtin
  perf script: Move find_scripts to browser/scripts.c
  perf stat: Move stat_config into config.c
  perf script: Move script_spec code to trace-event-scripting.c
  perf script: Move script_fetch_insn to trace-event-scripting.c
  perf script: Move perf_sample__sprintf_flags to
    trace-event-scripting.c
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
 tools/perf/bench/inject-buildid.c             |  13 +-
 tools/perf/builtin-kvm.c                      |  61 ----
 tools/perf/builtin-kwork.c                    |   3 +-
 tools/perf/builtin-lock.c                     | 137 +------
 tools/perf/builtin-script.c                   | 303 +---------------
 tools/perf/builtin-stat.c                     |  27 --
 tools/perf/builtin-trace.c                    |   1 -
 tools/perf/builtin.h                          |   6 -
 .../scripts/python/Perf-Trace-Util/Context.c  |  20 +-
 tools/perf/tests/stat.c                       |  16 +-
 tools/perf/trace/beauty/arch_errno_names.sh   |   3 +-
 tools/perf/ui/browsers/scripts.c              | 177 ++++++++-
 tools/perf/util/Build                         |   2 +
 tools/perf/util/bpf_kwork.c                   |   2 +-
 tools/perf/util/bpf_kwork_top.c               |   2 +-
 tools/perf/util/bpf_lock_contention.c         |   2 +-
 tools/perf/util/cgroup.c                      |   2 +-
 tools/perf/util/config.c                      |  27 ++
 tools/perf/util/dlfilter.c                    |   3 +-
 tools/perf/util/env.c                         |   2 +
 tools/perf/util/env.h                         |   2 -
 tools/perf/util/evsel.c                       |  19 +-
 tools/perf/util/evsel.h                       |   2 +-
 tools/perf/util/kvm-stat.c                    |  70 ++++
 tools/perf/util/kvm-stat.h                    |   3 +
 tools/perf/util/kwork.h                       |   6 +-
 tools/perf/util/lock-contention.c             | 170 +++++++++
 tools/perf/util/lock-contention.h             |  37 +-
 tools/perf/util/path.c                        |  10 +
 tools/perf/util/path.h                        |   1 +
 tools/perf/util/python.c                      | 338 ++++++++----------
 .../scripting-engines/trace-event-python.c    |  63 +---
 tools/perf/util/stat.h                        |   3 +-
 tools/perf/util/trace-event-scripting.c       | 176 +++++++++
 tools/perf/util/trace-event.h                 |   5 +-
 36 files changed, 854 insertions(+), 867 deletions(-)
 create mode 100644 tools/perf/util/kvm-stat.c
 create mode 100644 tools/perf/util/lock-contention.c

-- 
2.47.0.163.g1226f6d8fa-goog

