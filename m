From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [RFC PATCHSET] Implement --switch-output-events
Date: Mon, 27 Apr 2020 18:19:28 -0300
Message-ID: <20200427211935.25789-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Song Liu <songliubraving@fb.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

Hi guys,

	Please take a look, the example provided is too simple, using
'perf probe' to put probes in specific places in some workload to then
get any other event close to the time the trigger hits comes to mind as
well, using the signal was just to reuse the pre-existing logic and keep
the patchkit small.

	Its available at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/switch-output-event

Best regards,

- Arnaldo

Arnaldo Carvalho de Melo (7):
  perf record: Move sb_evlist to 'struct record'
  perf top: Move sb_evlist to 'struct perf_top'
  perf bpf: Decouple creating the evlist from adding the SB event
  perf bpf: Decouple creating the evlist from adding the SB event
  perf parse-events: Add parse_events_option() variant that creates
    evlist
  perf evlist: Allow reusing the side band thread for more purposes
  perf record: Introduce --switch-output-event

 tools/perf/Documentation/perf-record.txt | 13 ++++++
 tools/perf/builtin-record.c              | 55 +++++++++++++++++++++---
 tools/perf/builtin-top.c                 | 20 ++++++---
 tools/perf/util/bpf-event.c              |  3 +-
 tools/perf/util/bpf-event.h              |  7 ++-
 tools/perf/util/evlist.c                 | 39 +++++++++++------
 tools/perf/util/evlist.h                 |  3 +-
 tools/perf/util/parse-events.c           | 23 ++++++++++
 tools/perf/util/parse-events.h           |  1 +
 tools/perf/util/top.h                    |  2 +-
 10 files changed, 133 insertions(+), 33 deletions(-)

-- 
2.21.1
