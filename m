From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 1/3] perf alias: Remove trailing newline when reading sysfs files
Date: Thu, 14 Jun 2018 13:48:43 +0200
Message-ID: <20180614114845.41221-1-tmricht@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, jolsa@redhat.com
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Remove a trailing newline when reading sysfs file contents
such as /sys/devices/cpum_cf/events/TX_NC_TEND.
This show when verbose option -v is used.

Output before:
tx_nc_tend -> 'cpum_cf'/'event=0x008d
'/

Output after:
tx_nc_tend -> 'cpum_cf'/'event=0x8d'/

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/util/pmu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 7878934ebb23..26c79a9c4142 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -294,7 +294,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 
 static int perf_pmu__new_alias(struct list_head *list, char *dir, char *name, FILE *file)
 {
-	char buf[256];
+	char *cp, buf[256];
 	int ret;
 
 	ret = fread(buf, 1, sizeof(buf), file);
@@ -303,6 +303,11 @@ static int perf_pmu__new_alias(struct list_head *list, char *dir, char *name, FI
 
 	buf[ret] = 0;
 
+	/* Remove trailing newline from sysfs file */
+	cp = strrchr(buf, '\n');
+	if (cp)
+		*cp = '\0';
+
 	return __perf_pmu__new_alias(list, dir, name, NULL, buf, NULL, NULL, NULL,
 				     NULL, NULL, NULL);
 }
-- 
2.14.3
