From: Cheng Jian <cj.chengjian@huawei.com>
Subject: [PATCH] perf/tools : remove default system_wide in sched record
Date: Tue, 24 Oct 2017 15:45:34 +0800
Message-ID: <1508831134-151993-1-git-send-email-cj.chengjian@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:9032 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750868AbdJXHmh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 24 Oct 2017 03:42:37 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, xiexiuqi@huawei.com, huawei.libin@huawei.com, cj.chengjian@huawei.com, zhangmengting@huawei.com

When running perf sched record, there is a bug.

It's system_wide when we specify a command line.

$ perf sched record ls
$ perf script
         swapper     0 [001] 1312209.826144:
sched:sched_wakeup: crash:21979 [120] success=1 CPU:001
         swapper     0 [001] 1312209.826148:
sched:sched_switch: swapper/1:0 [120] R ==> crash:21979 [120]
           crash 21979 [001] 1312209.826151:
sched:sched_stat_runtime: comm=crash pid=21979
runtime=8161 [ns] vruntime=1591295759555 [ns]
           crash 21979 [001] 1312209.826185:
sched:sched_switch: crash:21979 [120] S ==> swapper/1:0 [120]
              ls 148873 [169] 1312209.826818:
sched:sched_stat_runtime: comm=ls pid=148873
runtime=999532 [ns] vruntime=8099789362030 [ns]
            perf 148872 [109] 1312209.826818:
sched:sched_stat_runtime: comm=perf pid=148872
runtime=1001606 [ns] vruntime=7794318690006 [ns]

This is because '-a'(system_wide) is set in record_args.
so just remove it.

After :
	  swapper     0 [109] 1313349.767284:
sched:sched_wakeup: comm=perf pid=149865 prio=120 success=1 target_cpu=109
              ls 149865 [133] 1313349.769066: sched:sched_stat_runtime:
comm=ls pid=149865 runtime=1001167 [ns] vruntime=7871277236086 [ns]
              ls 149865 [133] 1313349.770062:
sched:sched_stat_runtime: comm=ls pid=149865
runtime=998985 [ns] vruntime=7871278235071 [ns]
              ls 149865 [133] 1313349.770731:
sched:sched_wakeup: comm=kworker/133:2 pid=137042
prio=120 success=1 target_cpu=133

Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
Signed-off-by: Zhang MengTing <zhangmengting@huawei.com>
---
 tools/perf/builtin-sched.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 322b4de..47b79fc 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3248,7 +3248,6 @@ static int __cmd_record(int argc, const char **argv)
 	const char **rec_argv;
 	const char * const record_args[] = {
 		"record",
-		"-a",
 		"-R",
 		"-m", "1024",
 		"-c", "1",
-- 
1.8.3.1
