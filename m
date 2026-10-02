Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDCC363094
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 18:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790965600; cv=none; b=U0GPmiVD6pu/EM2wZgKdOg4bqPunQjiNXvugmF1lAqghir8kyAkn193dqwY5tHW0MzFheNH6y8rErV0J8ZPIDItAkAvGY5I+cHDNNjsW780thSj6ax5uLrygIDw5JFXGrlbLBvSXCGthA08agmbWvsL9GQaqpaArj6rK4h7+eUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790965600; c=relaxed/simple;
	bh=E83WVq+sl75VmGJCSZqVEKWrHBHpGyUZzp7rOb7loLg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=h8rMvzpnVMj3f2vvgXMGDkH9nek3xcLEg3GFcSFrPvv5o7gzS5y8uB13SEtSxAzOFmT45IYv7UVkQTG69QW4eC1MkUNxdum8gLelLc/BCPHftj2ihBLCOQJR3r0/eQ/H2/PADJTEt89XoXNgXHvoyouplNy6tvTJov8AwnlY1Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G1InFksI; arc=none smtp.client-ip=74.125.82.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G1InFksI"
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-147be78cd56so8242947c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Oct 2026 11:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790965598; x=1791570398; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:mime-version:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TnS/vndYMUOQrrB0lkWzqEc8TWsam8hh0VK9Ygm9omk=;
        b=G1InFksI5mPuXuKXMzpT7Vlfc0nxYM5iDGXXvp+kKJ32YFzFXeEF2vxBMSs0fEdFu6
         +mOPJKZcRaQo1Eae++/1gwkH2YUD4wcieAjPsBi/eccuu2hyJ9OkuNGUEzAHbthC2rXI
         wiVy485NLZVnHBS5buHMiA3ivkFdPwbQMiXVhfP07OatuluzzkTzkgjkiI7uXSYmqekZ
         hyRI10WPKMLZSQfk5HTBOZ25Je1eMjK8AIyUxHFtOdkSzM3Y+UbmPE4ATs5sGNAyteDn
         O3D2cQ5M0P5bEJQ4H+bSVaiFsrBetecHUuj9N+7SisOjGoh9yKSczRZqhXyXCcS7RLod
         v1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790965598; x=1791570398;
        h=content-type:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TnS/vndYMUOQrrB0lkWzqEc8TWsam8hh0VK9Ygm9omk=;
        b=JZCDReoLNF9KUTqsEzzfHI+HoRFZF+TSUqOKwUrCI6qSYIY3F+tbPisxZAFP0gWh4t
         RxgfCx272GrKephEYuebYHNtDyacpgt/BIYmkV4ehMewxP5kKh7L98l7LB+QU70/O5li
         8qO2VSwiPzFZRXujCAWbrYczsqJccFHHcDShUEzOh3z4iNFiu07DI8H63EA6zDuqZnjx
         hFlzbi2KGQHkz5OGBBim1upXyGAitFkrIkKwihbLfScA9JYU0kMDaWAf/cu4RQLqGkCo
         6X7LPBVD6JJ6i53tAI5UTc/xlbnGfr5mtQJ42XKM8adL05F5u0lh8kJeH70C7ZnB93pI
         fTVg==
X-Forwarded-Encrypted: i=1; AKwUvBy27LvXRCzvRrP7QAozKzyNHcMy7F/JycHM87xsoIudkRXSih0n0WbBueI0z4x2idtcyP8AlmjxkZYor/x4AJBE@vger.kernel.org
X-Gm-Message-State: AFuF++kkyaJawSv1NKUf67ZRgMibJ5bMZwbH69Pv+mEaZmWcCel6Okb1
	cEXnciuKwpJ8AK61UbUQTbic0z/iwSWvvMGhNgbr4xTXf71t7KiiCM+XpmvWXXdbuOBP9FyCeEs
	o7hyP0ObkPA==
X-Received: from dlbrj21.prod.google.com ([2002:a05:7022:f415:b0:146:40d5:dd5c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:280e:b0:14d:523b:ce86
 with SMTP id a92af1059eb24-14f5bffb066mr3951520c88.20.1790965597017; Fri, 02
 Oct 2026 11:26:37 -0700 (PDT)
Date: Fri,  2 Oct 2026 11:26:09 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261002182624.3259797-1-irogers@google.com>
Subject: [PATCH v1 00/13] perf timechart/list/treport: Interactive Textual
 TUIs and perf python session improvements
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Alice Rogers <alice.mei.rogers@gmail.com>, Changbin Du <changbin.du@huawei.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, tanze <tanze@kylinos.cn>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This series adds interactive terminal user interfaces (TUIs) built with
Python's textual framework for 'perf timechart' (--tui and --live) and
'perf list' (--tui), updates 'treport' to progressively display profiles
while loading in the background, adds headless shell tests for all three
TUIs, and improves the 'perf' Python extension module to support
responsive background and live pipe event processing:

1. Session and Python extension improvements (patches 1-5):
   - Skip flushing remaining deferred samples and auxtrace events once
     session_done() is set so stopping event processing is immediate.
   - Quietly stop processing events when a Python session callback raises
     an exception (e.g., to cancel a background load on quit) without
     corrupting TUI output with reader error messages.
   - Lazily copy perf_event and perf_sample in process_events() only when
     a Python callback retains a reference beyond its return, shrinking
     struct pyrf_event to fit in CPython's small-object allocator.
   - Lazily unwind and resolve sample callchains only when
     event.callchain is accessed.
   - Release the Python GIL around perf_session__new() and
     perf_session__process_events() (reacquiring it in callbacks and
     guarding concurrent thread/comm/symbol access) so blocking pipe
     reads do not freeze TUI threads.

2. 'perf list --tui' and ilist test (patches 6-7):
   - Add 'perf list --tui' to launch the interactive ilist script via
     'perf script', and add a shell test driving ilist headlessly.

3. Progressive loading in treport and test (patches 8-9):
   - Load profiles in a background thread in treport.py so the report
     tree and flame graph are interactive while loading, with lazy tree
     node creation and a headless shell test.

4. 'perf timechart --tui' and '--live' and tests (patches 10-13):
   - Add ttimechart.py and 'perf timechart --tui' to interactively view,
     zoom, and pan per-CPU (busy, frequency, idle), per-task (running,
     runnable, blocked, wakeups), and I/O timelines along with a summary
     table.
   - Add 'perf timechart --live' to stream live scheduler, power, or I/O
     events from a 'perf record' subprocess over a pipe with a rolling
     time window, pause/resume via the control pipe, and optional output
     recording (-o).
   - Add headless shell tests covering both '--tui' and '--live' modes.

Alice Rogers (6):
  perf treport: Show the profile while it loads
  perf test: Add a test for the treport script
  perf timechart: Add an interactive --tui mode
  perf test: Add a test for perf timechart --tui
  perf timechart: Add a --live mode to the TUI
  perf test: Test perf timechart --live

Ian Rogers (7):
  perf session: Don't flush remaining events once processing is done
  perf python: Quietly stop processing events when a callback raises
  perf python: Lazily copy events and samples from process_events
  perf python: Lazily resolve sample callchains
  perf python: Release the GIL while processing session events
  perf list: Add a --tui option to launch ilist
  perf test: Add a test for the ilist script

 tools/perf/Documentation/perf-list.txt        |   10 +
 tools/perf/Documentation/perf-timechart.txt   |   24 +
 tools/perf/builtin-list.c                     |   34 +
 tools/perf/builtin-timechart.c                |  114 +-
 tools/perf/python/treport.py                  |  458 ++-
 tools/perf/python/ttimechart.py               | 2467 +++++++++++++++++
 tools/perf/tests/shell/test_ilist_python.sh   |  181 ++
 tools/perf/tests/shell/test_treport_python.sh |  247 ++
 .../tests/shell/test_ttimechart_python.sh     |  537 ++++
 tools/perf/util/auxtrace.c                    |    7 +
 tools/perf/util/python.c                      | 1191 +++++---
 tools/perf/util/session.c                     |    8 +
 12 files changed, 4754 insertions(+), 524 deletions(-)
 create mode 100755 tools/perf/python/ttimechart.py
 create mode 100755 tools/perf/tests/shell/test_ilist_python.sh
 create mode 100755 tools/perf/tests/shell/test_treport_python.sh
 create mode 100755 tools/perf/tests/shell/test_ttimechart_python.sh

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

