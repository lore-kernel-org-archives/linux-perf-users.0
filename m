From: Kim Phillips <kim.phillips@amd.com>
Subject: [PATCH 4/4] perf vendor events amd: Enable Family 19h users by matching Zen2 events
Date: Tue,  1 Sep 2020 17:09:44 -0500
Message-ID: <20200901220944.277505-4-kim.phillips@amd.com>
References: <20200901220944.277505-1-kim.phillips@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200901220944.277505-1-kim.phillips@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@redhat.com>, kim.phillips@amd.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Vijay Thakkar <vijaythakkar@me.com>, Andi Kleen <ak@linux.intel.com>, John Garry <john.garry@huawei.com>, Kan Liang <kan.liang@linux.intel.com>, Yunfeng Ye <yeyunfeng@huawei.com>, Jin Yao <yao.jin@linux.intel.com>, =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>, Borislav Petkov <bp@suse.de>, Jon Grimm <jon.grimm@amd.com>, Martin Jambor <mjambor@suse.cz>, Michael Petlan <mpetlan@redhat.com>, William Cohen <wcohen@redhat.com>, Stephane Eranian <eranian@google.com>
List-Id: linux-perf-users.vger.kernel.org

This enables zen3 users by reusing mostly-compatible zen2 events
until the official public list of zen3 events is published in a
future PPR.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Vijay Thakkar <vijaythakkar@me.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Yunfeng Ye <yeyunfeng@huawei.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: "Martin Liška" <mliska@suse.cz>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jon Grimm <jon.grimm@amd.com>
Cc: Martin Jambor <mjambor@suse.cz>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: William Cohen <wcohen@redhat.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/perf/pmu-events/arch/x86/mapfile.csv | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 25b06cf98747..2f2a209e87e1 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -38,3 +38,4 @@ GenuineIntel-6-7E,v1,icelake,core
 GenuineIntel-6-86,v1,tremontx,core
 AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
 AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
+AuthenticAMD-25-[[:xdigit:]]+,v1,amdzen2,core
-- 
2.27.0
