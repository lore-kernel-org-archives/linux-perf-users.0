Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KhmO9gzr"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482E0A4
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Dec 2023 21:04:46 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d7e7e10231so2027577b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Dec 2023 21:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701925485; x=1702530285; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R9RMTJtlPt1jfAFH/k4xNYuBt8CVOB8J0dneg0Xx2oQ=;
        b=KhmO9gzrB0D3xNmF7OcjIEoKLAtShQcKGG5G6Y/OoTVeTdFN3xj1Lr/KEN+SQoMeP2
         NU5QyM3ScFY+L/A4BGmnVhZxNltwnUUf/UtzNTWzdezsOjFUHdb3+zpQqkRvMN9lXqsp
         7zI0PHQXMRXlI73BBM6W5GJFNPC734o7Hfy3aVNDty/47ptfJ5tFQhjNL/I0bjc5pDtZ
         TZMVjzPxvigm6tIfAUrGgqwQ45av1uebT/RDUCmSLL9h6rO10zEzxrqGbqHfmBTuFDCs
         6jpfoHXbwk6qWdpI1PDMOdK6JlJULpu3d9TzIlpKAM8jMUwQICxCquywushclaLjJd0W
         ZAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701925485; x=1702530285;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R9RMTJtlPt1jfAFH/k4xNYuBt8CVOB8J0dneg0Xx2oQ=;
        b=Vnr2uPtP6nKfybEgzp8Pf2r0wWH7JkdL0tjpQG+tRDwPnUcQaZwSldiR9u9qR8EdWQ
         t1xMWMvyX36IiH65/TU/RhvgOaS25T0JgK2hxacVDQjx7VHtA5ZKmzwUQYgslbzDWOnr
         cekK0Zj6FOzt5sJMOxs9+rewgMvg2mkKHiHBsCughXU3uCQA1G9F/IhpdSAuP6TmT9GB
         ezVCj3mvon1nZYLlwrIKSq3bGIB+tnPPdDWN9pjKKpUXgNewMtDUfSuaKO+BpcnjzwLI
         mqMMI/1UesMdVhJWnWM347KZI5ggifLAe+g2P60GTZu61NWsXTlt6U65yFNAjm05PHNn
         B8Yg==
X-Gm-Message-State: AOJu0YwJkTwegfFKOoulWr3nN/+33jX1oCsZvZxdYeZA4Q/JwjMv1+m3
	Hh+OkLcoSoTbX36sG766AKrs9PWOh9QX
X-Google-Smtp-Source: AGHT+IFlYcSaTvvG5Jhy92MCs2tHiMPKJjjuwWzlUJDLK62l2h3mHEbfMkMgGUSXwdUpVOUuVYJBOgORd2NT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a81:be14:0:b0:5d3:56a4:9073 with SMTP id
 i20-20020a81be14000000b005d356a49073mr54099ywn.2.1701925485235; Wed, 06 Dec
 2023 21:04:45 -0800 (PST)
Date: Wed,  6 Dec 2023 21:04:27 -0800
Message-Id: <20231207050433.1426834-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v1 0/6] Add io_dir to avoid memory overhead from opendir
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, Quentin Monnet <quentin@isovalent.com>, 
	Fangrui Song <maskray@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yanteng Si <siyanteng@loongson.cn>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Artem Savkov <asavkov@redhat.com>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

glibc's opendir allocates a minimum of 32kb, when called recursively
for a directory tree the memory consumption can add up - nearly 300kb
during perf start-up when processing modules. Add a stack allocated
variant of readdir sized a little more than 1kb

This was previously part of the memory saving change set:
https://lore.kernel.org/lkml/20231127220902.1315692-1-irogers@google.com/
It is separated here and a feature check and syscall workaround for
missing getdents64 added.

Ian Rogers (6):
  tools build: Add a feature test for getdents64
  tools lib api: Add io_dir an allocation free readdir alternative
  perf maps: Switch modules tree walk to io_dir__readdir
  perf pmu: Switch to io_dir__readdir
  perf header: Switch mem topology to io_dir__readdir
  perf events: Remove scandir in thread synthesis

 tools/build/Makefile.feature          |  1 +
 tools/build/feature/Makefile          |  4 ++
 tools/build/feature/test-all.c        |  5 ++
 tools/build/feature/test-getdents64.c | 12 ++++
 tools/lib/api/Makefile                |  2 +-
 tools/lib/api/io_dir.h                | 84 +++++++++++++++++++++++++++
 tools/perf/Makefile.config            |  4 ++
 tools/perf/util/header.c              | 31 +++++-----
 tools/perf/util/machine.c             | 19 +++---
 tools/perf/util/pmu.c                 | 48 ++++++---------
 tools/perf/util/pmus.c                | 30 ++++------
 tools/perf/util/synthetic-events.c    | 22 +++----
 12 files changed, 177 insertions(+), 85 deletions(-)
 create mode 100644 tools/build/feature/test-getdents64.c
 create mode 100644 tools/lib/api/io_dir.h

-- 
2.43.0.rc2.451.g8631bc7472-goog

