From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/19] perf alias: Remove trailing newline when reading sysfs files
Date: Mon, 25 Jun 2018 14:40:39 -0300
Message-ID: <20180625174045.25765-14-acme@kernel.org>
References: <20180625174045.25765-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180625174045.25765-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Thomas Richter <tmricht@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Jiri Olsa <jolsa@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

Remove a trailing newline when reading sysfs file contents such as
/sys/devices/cpum_cf/events/TX_NC_TEND.  This shows when verbose option
-v is used.

Output before:

  tx_nc_tend -> 'cpum_cf'/'event=0x008d
  '/

Output after:

  tx_nc_tend -> 'cpum_cf'/'event=0x8d'/

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180615101105.47047-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index d2fb597c9a8c..2738fc8d200d 100644
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
