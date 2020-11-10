From: Ian Rogers <irogers@google.com>
Subject: [RFC PATCH 00/12] Topdown parser
Date: Tue, 10 Nov 2020 02:03:34 -0800
Message-ID: <20201110100346.2527031-1-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, John Garry <john.garry@huawei.com>, Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>
Cc: Stephane Eranian <eranian@google.com>, Sandeep Dasgupta <sdasgup@google.com>, linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>
List-Id: linux-perf-users.vger.kernel.org

This RFC is for a new tool that reads TMA_Metrics.csv as found on
download.01.org/perfmon and generates metrics and metric groups from
it. To show the functionality the TMA_Metrics.csv is downloaded, but
an accepted change would most likely include a copy of this file from
Intel. With this tool rather than just level 1 topdown metrics, a full
set of topdown metrics to level 4 are generated.

This change was:
Suggested-by: Stephane Eranian <eranian@google.com>

Sandeep Dasgupta (12):
  perf topdown-parser: Add a simple logging API.
  perf topdown-parser: Add utility functions.
  perf topdown-paser: Add a CSV file reader.
  perf topdown-parser: Add a json file reader.
  perf topdown-parser: Add a configuration.
  perf topdown-parser: Interface for TMA_Metrics.csv.
  perf topdown-parser: Metric expression parser.
  perf topdown-parser: Add event interface.
  perf topdown-paser: Add code generation API.
  perf topdown-parser: Add json metric code generation.
  perf topdown-parser: Main driver.
  perf pmu-events: Topdown parser tool

 tools/perf/Makefile.perf                      |  13 +-
 tools/perf/pmu-events/Build                   |  50 +-
 tools/perf/pmu-events/topdown-parser/README   |   5 +
 .../topdown-parser/code_gen_target.cpp        |  51 +
 .../topdown-parser/code_gen_target.h          |  77 ++
 .../code_gen_target_perf_json.cpp             | 546 ++++++++++
 .../code_gen_target_perf_json.h               |  25 +
 .../topdown-parser/configuration.cpp          | 198 ++++
 .../pmu-events/topdown-parser/configuration.h | 181 ++++
 .../topdown-parser/configuration.json         |  72 ++
 .../pmu-events/topdown-parser/csvreader.cpp   |  49 +
 .../pmu-events/topdown-parser/csvreader.h     |  51 +
 .../topdown-parser/dependence_dag_utils.cpp   | 984 ++++++++++++++++++
 .../topdown-parser/dependence_dag_utils.h     | 178 ++++
 .../pmu-events/topdown-parser/event_info.cpp  | 443 ++++++++
 .../pmu-events/topdown-parser/event_info.h    | 114 ++
 .../pmu-events/topdown-parser/expr_parser.y   | 224 ++++
 .../topdown-parser/general_utils.cpp          | 173 +++
 .../pmu-events/topdown-parser/general_utils.h | 131 +++
 .../pmu-events/topdown-parser/jsmn_extras.cpp | 199 ++++
 .../pmu-events/topdown-parser/jsmn_extras.h   |  42 +
 .../perf/pmu-events/topdown-parser/logging.h  |  25 +
 .../topdown-parser/topdown_parser_main.cpp    | 155 +++
 23 files changed, 3981 insertions(+), 5 deletions(-)
 create mode 100644 tools/perf/pmu-events/topdown-parser/README
 create mode 100644 tools/perf/pmu-events/topdown-parser/code_gen_target.cpp
 create mode 100644 tools/perf/pmu-events/topdown-parser/code_gen_target.h
 create mode 100644 tools/perf/pmu-events/topdown-parser/code_gen_target_perf_json.cpp
 create mode 100644 tools/perf/pmu-events/topdown-parser/code_gen_target_perf_json.h
 create mode 100644 tools/perf/pmu-events/topdown-parser/configuration.cpp
 create mode 100644 tools/perf/pmu-events/topdown-parser/configuration.h
 create mode 100644 tools/perf/pmu-events/topdown-parser/configuration.json
 create mode 100644 tools/perf/pmu-events/topdown-parser/csvreader.cpp
 create mode 100644 tools/perf/pmu-events/topdown-parser/csvreader.h
 create mode 100644 tools/perf/pmu-events/topdown-parser/dependence_dag_utils.cpp
 create mode 100644 tools/perf/pmu-events/topdown-parser/dependence_dag_utils.h
 create mode 100644 tools/perf/pmu-events/topdown-parser/event_info.cpp
 create mode 100644 tools/perf/pmu-events/topdown-parser/event_info.h
 create mode 100644 tools/perf/pmu-events/topdown-parser/expr_parser.y
 create mode 100644 tools/perf/pmu-events/topdown-parser/general_utils.cpp
 create mode 100644 tools/perf/pmu-events/topdown-parser/general_utils.h
 create mode 100644 tools/perf/pmu-events/topdown-parser/jsmn_extras.cpp
 create mode 100644 tools/perf/pmu-events/topdown-parser/jsmn_extras.h
 create mode 100644 tools/perf/pmu-events/topdown-parser/logging.h
 create mode 100644 tools/perf/pmu-events/topdown-parser/topdown_parser_main.cpp

-- 
2.29.2.222.g5d2a92d10f8-goog
