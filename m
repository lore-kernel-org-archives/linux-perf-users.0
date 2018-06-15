From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 1/3 v2] perf alias: Remove trailing newline when reading sysfs files
Date: Fri, 15 Jun 2018 12:11:03 +0200
Message-ID: <20180615101105.47047-1-tmricht@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Remove a trailing newline when reading sysfs file contents
such as /sys/devices/cpum_cf/events/TX_NC_TEND.
This shows when verbose option -v is used.

Output before:
tx_nc_tend -> 'cpum_cf'/'event=0x008d
'/

Output after:
tx_nc_tend -> 'cpum_cf'/'event=0x8d'/

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
---
 tools/perf/util/pmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 7878934ebb23..6d2012405f2b 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -303,6 +303,9 @@ static int perf_pmu__new_alias(struct list_head *list, char *dir, char *name, FI
 
 	buf[ret] = 0;
 
+	/* Remove trailing newline from sysfs file */
+	rtrim(buf);
+
 	return __perf_pmu__new_alias(list, dir, name, NULL, buf, NULL, NULL, NULL,
 				     NULL, NULL, NULL);
 }
-- 
2.14.3
