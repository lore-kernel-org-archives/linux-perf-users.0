From: Mengting Zhang <zhangmengting@huawei.com>
Subject: [PATCH] perf parse events: Fix invalid precise_ip handling
Date: Fri, 10 Nov 2017 16:28:37 +0800
Message-ID: <1510302517-33383-1-git-send-email-zhangmengting@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:10434 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbdKJIhd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Nov 2017 03:37:33 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: jolsa@redhat.com, namhyung@kernel.org, alexander.shishkin@linux.intel.com
Cc: acme@kernel.org, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, huawei.libin@huawei.com, wangnan0@huawei.com, zhangmengting@huawei.com

When the user set a precise_ip greater than the highest precision available,
perf should return EINVAL to indicate the invalid precise_ip setting.

Currently, in get_event_modifier(), perf compares the user-specified precise_ip
with 3, instead of the highest precision available in the current processor.
It is incorrect if the maximum precision available is less than 3.

For example, with a highest precision perf_event_attr.precise_ip = 2, the
user-specified precise_ip greater than 2 should be handled as invalid argument.

Introduce perf_get_max_precise_ip() to get max precision available and compare
it with the user-specified precise_ip. Also show the available max precision in
an error message when the user-specified precise_ip is invalid.

Before:
$./perf record -e cycles:ppp sleep 1
Error:
PMU Hardware doesn't support sampling/overflow-interrupts.

After:
$./perf record -e cycles:ppp sleep 1
Error: Invalid argument for precise_ip setting.
The highest level of precise ip is 2
invalid or unsupported event: 'cycles:ppp'
Run 'perf list' for a list of valid events

 Usage: perf record [<options>] [<command>]
    or: perf record [<options>] -- <command> [<options>]

    -e, --event <event>   event selector. use 'perf list' to list available events

Signed-off-by: Mengting Zhang <zhangmengting@huawei.com>
---
 tools/perf/util/parse-events.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 39b1596..25225f4 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1369,6 +1369,32 @@ struct event_modifier {
 	int pinned;
 };
 
+static int perf_get_max_precise_ip(void)
+{
+       int max_precise_ip = 0;
+       struct perf_event_attr attr = {
+               .type   = PERF_TYPE_HARDWARE,
+               .config = PERF_COUNT_HW_CPU_CYCLES,
+       };
+
+       event_attr_init(&attr);
+       
+       attr.precise_ip = 3;
+       attr.sample_period = 1;
+
+       while (attr.precise_ip != 0) {
+               int fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
+               if (fd != -1){
+                       close(fd);
+                       break;
+               }
+               --attr.precise_ip;
+       }
+       max_precise_ip = attr.precise_ip;
+
+       return max_precise_ip;
+}
+
 static int get_event_modifier(struct event_modifier *mod, char *str,
 			       struct perf_evsel *evsel)
 {
@@ -1382,6 +1408,7 @@ static int get_event_modifier(struct event_modifier *mod, char *str,
 	int precise_max = 0;
 	int sample_read = 0;
 	int pinned = evsel ? evsel->attr.pinned : 0;
+	int max_precise_ip = 0;
 
 	int exclude = eu | ek | eh;
 	int exclude_GH = evsel ? evsel->exclude_GH : 0;
@@ -1438,8 +1465,12 @@ static int get_event_modifier(struct event_modifier *mod, char *str,
 	 *
 	 *  See also PERF_RECORD_MISC_EXACT_IP
 	 */
-	if (precise > 3)
+	max_precise_ip = perf_get_max_precise_ip();
+	if (precise > max_precise_ip) {
+		pr_err("Error: Invalid argument for precise_ip setting. \n"
+                       "The highest level of precise ip is %d\n", max_precise_ip);
 		return -EINVAL;
+	}
 
 	mod->eu = eu;
 	mod->ek = ek;
-- 
1.7.12.4
