Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE50B1EB1B8;
	Wed, 19 Feb 2025 13:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739972462; cv=none; b=qXckfNpR5z8p9ICuy0ofI8Pyfd6r2rZlDge/C51ZUGkiFVBlxWYdGJtU7/kNHKA+BVJDnuuyGInkALeK24BdOSuQNgF5cZSDyXXsVaCWcettKoWuw3BZxTmYUXMtg5bZeMtExCje/mwrox0AkzYkLH7vCrxeciQArHREcLjc0Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739972462; c=relaxed/simple;
	bh=Agd8dAvug++fNqH4Fy/1e7D6Lgjyatp74gkEX5NdNps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FaCjCvchDsmfjTHtEH2oxJnST1OCXYbDMgL20+fIIMo4SU5nGPwYDJZqtoKaa3pdSmybEynmE6RSW2SPQPafmJeI6wyJAopdNeliZOan9+blYdM1xbymzo2UWIzZFgl8r1Syxwb1UwIPn6lfGlPu3bNzYlgnCiRpAK2IMe1HJlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vBdg6rzO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vBdg6rzO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5617C4CEE7;
	Wed, 19 Feb 2025 13:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739972461;
	bh=Agd8dAvug++fNqH4Fy/1e7D6Lgjyatp74gkEX5NdNps=;
	h=From:To:Cc:Subject:Date:From;
	b=vBdg6rzOtRgIpF2ExgrdPZyFzcjdO/yMw8De+F+0Uu93VrR/30dOZetNZjReJaEbp
	 BSfQfRYf2AxPzk8a70HfoB8C53PB6gPbTPAKv0HerNwi/+C2yFs32ASVXQel/GWbul
	 L4EnK2IGxTdFiL0Nn8DV+hkYtGlLpduOZLipucck=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable <stable@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf: fix up some comments and code to properly use the event_source bus
Date: Wed, 19 Feb 2025 14:40:56 +0100
Message-ID: <2025021955-implant-excavator-179d@gregkh>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5486; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=Agd8dAvug++fNqH4Fy/1e7D6Lgjyatp74gkEX5NdNps=; b=owGbwMvMwCRo6H6F97bub03G02pJDOlb76ebbU9UnT+X4ZnUhoWH5R9O2PNTc3Pzo9v8O7ksO Hd33e2f2hHLwiDIxCArpsjyZRvP0f0VhxS9DG1Pw8xhZQIZwsDFKQAT6VrLsKD/3/tZr2bObREz Z1p6LnD1HuYCcz+G+XG2l1qW8QgKzCvoLeD43XleQlgkFQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

In sysfs, the perf events are all located in
/sys/bus/event_source/devices/ but some places ended up hard-coding the
location to be at the root of /sys/devices/ which could be very risky as
you do not exactly know what type of device you are accessing in sysfs
at that location.

So fix this all up by properly pointing everything at the bus device
list instead of the root of the sysfs devices/ tree.

Cc: stable <stable@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/Documentation/intel-hybrid.txt | 12 ++++++------
 tools/perf/Documentation/perf-list.txt    |  2 +-
 tools/perf/arch/x86/util/iostat.c         |  2 +-
 tools/perf/builtin-stat.c                 |  2 +-
 tools/perf/util/mem-events.c              |  2 +-
 tools/perf/util/pmu.c                     |  4 ++--
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/perf/Documentation/intel-hybrid.txt b/tools/perf/Documentation/intel-hybrid.txt
index e7a776ad25d7..0379903673a4 100644
--- a/tools/perf/Documentation/intel-hybrid.txt
+++ b/tools/perf/Documentation/intel-hybrid.txt
@@ -8,15 +8,15 @@ Part of events are available on core cpu, part of events are available
 on atom cpu and even part of events are available on both.
 
 Kernel exports two new cpu pmus via sysfs:
-/sys/devices/cpu_core
-/sys/devices/cpu_atom
+/sys/bus/event_source/devices/cpu_core
+/sys/bus/event_source/devices/cpu_atom
 
 The 'cpus' files are created under the directories. For example,
 
-cat /sys/devices/cpu_core/cpus
+cat /sys/bus/event_source/devices/cpu_core/cpus
 0-15
 
-cat /sys/devices/cpu_atom/cpus
+cat /sys/bus/event_source/devices/cpu_atom/cpus
 16-23
 
 It indicates cpu0-cpu15 are core cpus and cpu16-cpu23 are atom cpus.
@@ -60,8 +60,8 @@ can't carry pmu information. So now this type is extended to be PMU aware
 type. The PMU type ID is stored at attr.config[63:32].
 
 PMU type ID is retrieved from sysfs.
-/sys/devices/cpu_atom/type
-/sys/devices/cpu_core/type
+/sys/bus/event_source/devices/cpu_atom/type
+/sys/bus/event_source/devices/cpu_core/type
 
 The new attr.config layout for PERF_TYPE_HARDWARE:
 
diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index d0c65fad419a..c3ffd93f94d7 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -188,7 +188,7 @@ in the CPU vendor specific documentation.
 
 The available PMUs and their raw parameters can be listed with
 
-  ls /sys/devices/*/format
+  ls /sys/bus/event_source/devices/*/format
 
 For example the raw event "LSD.UOPS" core pmu event above could
 be specified as
diff --git a/tools/perf/arch/x86/util/iostat.c b/tools/perf/arch/x86/util/iostat.c
index 00f645a0c18a..7442a2cd87ed 100644
--- a/tools/perf/arch/x86/util/iostat.c
+++ b/tools/perf/arch/x86/util/iostat.c
@@ -32,7 +32,7 @@
 #define MAX_PATH 1024
 #endif
 
-#define UNCORE_IIO_PMU_PATH	"devices/uncore_iio_%d"
+#define UNCORE_IIO_PMU_PATH	"bus/event_source/devices/uncore_iio_%d"
 #define SYSFS_UNCORE_PMU_PATH	"%s/"UNCORE_IIO_PMU_PATH
 #define PLATFORM_MAPPING_PATH	UNCORE_IIO_PMU_PATH"/die%d"
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 77e327d4a9a7..68ea7589c143 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -97,7 +97,7 @@
 #include <internal/threadmap.h>
 
 #define DEFAULT_SEPARATOR	" "
-#define FREEZE_ON_SMI_PATH	"devices/cpu/freeze_on_smi"
+#define FREEZE_ON_SMI_PATH	"bus/event_source/devices/cpu/freeze_on_smi"
 
 static void print_counters(struct timespec *ts, int argc, const char **argv);
 
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 3692e988c86e..0277d3e1505c 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -189,7 +189,7 @@ static bool perf_pmu__mem_events_supported(const char *mnt, struct perf_pmu *pmu
 	if (!e->event_name)
 		return true;
 
-	scnprintf(path, PATH_MAX, "%s/devices/%s/events/%s", mnt, pmu->name, e->event_name);
+	scnprintf(path, PATH_MAX, "%s/bus/event_source/devices/%s/events/%s", mnt, pmu->name, e->event_name);
 
 	return !stat(path, &st);
 }
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 6206c8fe2bf9..a8193ac8f2e7 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -36,12 +36,12 @@
 #define UNIT_MAX_LEN	31 /* max length for event unit name */
 
 enum event_source {
-	/* An event loaded from /sys/devices/<pmu>/events. */
+	/* An event loaded from /sys/bus/event_source/devices/<pmu>/events. */
 	EVENT_SRC_SYSFS,
 	/* An event loaded from a CPUID matched json file. */
 	EVENT_SRC_CPU_JSON,
 	/*
-	 * An event loaded from a /sys/devices/<pmu>/identifier matched json
+	 * An event loaded from a /sys/bus/event_source/devices/<pmu>/identifier matched json
 	 * file.
 	 */
 	EVENT_SRC_SYS_JSON,
-- 
2.48.1

