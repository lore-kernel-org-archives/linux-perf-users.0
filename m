From: Mengting Zhang <zhangmengting@huawei.com>
Subject: [PATCH v2] perf evsel: Fix incorrect precise_ip in default event name
Date: Fri, 10 Nov 2017 15:57:08 +0800
Message-ID: <1510300628-31648-1-git-send-email-zhangmengting@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:10433 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750756AbdKJIGb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Nov 2017 03:06:31 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: jolsa@redhat.com, namhyung@kernel.org, alexander.shishkin@linux.intel.com
Cc: acme@kernel.org, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, huawei.libin@huawei.com, wangnan0@huawei.com, zhangmengting@huawei.com

When no event is specified with -e option, perf will specify a
"cycles" event with the highest level of precision available in
perf_event_attr.precise_ip as the default event. But the evsel name
shows an incorrect precise ip, fix it.

For example, with a highest precision perf_event_attr.precise_ip = 2,
the evsel name "cycles:ppp" shows a wrong precision available.

Before:
$./perf record sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.014 MB perf.data (21 samples) ]
$./perf evlist -v
cycles:ppp: size: 112, { sample_period, sample_freq }: 4000,
sample_type: IP|TID|TIME|PERIOD, disabled: 1, inherit: 1, mmap: 1,
comm: 1, freq: 1, enable_on_exec: 1, task: 1, precise_ip: 2,
sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1

After:
$./perf record sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.014 MB perf.data (16 samples) ]
$./perf evlist -v
cycles:pp: size: 112, { sample_period, sample_freq }: 4000,
sample_type: IP|TID|TIME|PERIOD, disabled: 1, inherit: 1, mmap: 1,
comm: 1, freq: 1, enable_on_exec: 1, task: 1, precise_ip: 2,
sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1

Signed-off-by: Mengting Zhang <zhangmengting@huawei.com>
---
 tools/perf/util/evsel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 0dccdb8..d6a6205 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -312,7 +312,7 @@ struct perf_evsel *perf_evsel__new_cycles(bool precise)
 	if (asprintf(&evsel->name, "cycles%s%s%.*s",
 		     (attr.precise_ip || attr.exclude_kernel) ? ":" : "",
 		     attr.exclude_kernel ? "u" : "",
-		     attr.precise_ip ? attr.precise_ip + 1 : 0, "ppp") < 0)
+		     attr.precise_ip, "ppp") < 0)
 		goto error_free;
 out:
 	return evsel;
-- 
1.7.12.4
