From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 19/73] perf vendor events intel: Add uncore_upi JSON support
Date: Fri, 17 May 2019 16:35:17 -0300
Message-ID: <20190517193611.4974-20-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Perf cannot parse UPI (Intel's "Ultra Path Interconnect" [1]) events.

    # perf stat -e UPI_DATA_BANDWIDTH_TX
    event syntax error: 'UPI_DATA_BANDWIDTH_TX'
                     \___ parser error
    Run 'perf list' for a list of valid events

The JSON lists call the box UPI LL, while perf calls it upi.  Add
conversion support to JSON to convert the unit properly.

Committer notes:

[1] https://en.wikipedia.org/wiki/Intel_Ultra_Path_Interconnect

"The Intel Ultra Path Interconnect (UPI) is a point-to-point processor
interconnect developed by Intel which replaced the Intel QuickPath
Interconnect (QPI) in Xeon Skylake-SP platforms starting in 2017.

UPI is a low-latency coherent interconnect for scalable multiprocessor
systems with a shared address space. It uses a directory-based home
snoop coherency protocol with a transfer speed of up to 10.4 GT/s.
Supporting processors typically have two or three UPI links."

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/1557234991-130456-1-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/jevents.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 68c92bb599ee..daaea5003d4a 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -235,6 +235,7 @@ static struct map {
 	{ "iMPH-U", "uncore_arb" },
 	{ "CPU-M-CF", "cpum_cf" },
 	{ "CPU-M-SF", "cpum_sf" },
+	{ "UPI LL", "uncore_upi" },
 	{}
 };
 
-- 
2.20.1
