Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F691241E4
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Feb 2024 09:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707297398; cv=none; b=nkpyDQaD302lIXQRskt6dufhUMgocsBj4P/sWVukseIb/Pvm//7t0luHgu4lu/EDFx1PlWw7BXLufdyKGaR+LecBzVKf06tjDQZdCfReUbBzWnVl1IrRbCVzeJ/Qbf17cI7/kxuCovXOWMV2NJvRQbfSwu3fZCs8wBf2S/UDyQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707297398; c=relaxed/simple;
	bh=sAfyil+E7gV/q0wyQpyw6RhHQEq6xQkhD7Re06uEatE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c2+71vlSFU/HwIXLJbtCvOCgYP8XGZsv1Q/iTcPf4bkAuYGG151CG9CAuu4SXag/vYcrfXiO4F0LjetK9qLmBJLiYC7KC4oSKJFCtCIfXadQy5/7a8/XU7oETwHc/CZEKwid8CqovQDfgfaVQD2IBnbuGNOoJR4XJ2cUW3tneqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TVDvv09Mfz1gy5q;
	Wed,  7 Feb 2024 17:14:35 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id 5FF671400CF;
	Wed,  7 Feb 2024 17:16:31 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 17:16:31 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <acme@kernel.org>, <namhyung@kernel.org>, <peterz@infradead.org>,
	<mingo@redhat.com>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<linux-perf-users@vger.kernel.org>
CC: <yangyicong@hisilicon.com>, <linuxarm@huawei.com>
Subject: [PATCH] perf test: Skip metric w/o event name on arm64 in stat STD output linter
Date: Wed, 7 Feb 2024 17:12:22 +0800
Message-ID: <20240207091222.54096-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)

From: Yicong Yang <yangyicong@hisilicon.com>

stat+std_output.sh test fails on my arm64 machine:
[root@localhost shell]# ./stat+std_output.sh
Checking STD output: no args Unknown event name in TopDownL1                 #     0.18 retiring
[root@localhost shell]# ./stat+std_output.sh
Checking STD output: no args [Success]
Checking STD output: system wide [Success]
Checking STD output: interval [Success]
Checking STD output: per thread Unknown event name in tmux: server-1114960                                                   #     0.41 frontend_bound

When no args specified `perf stat` will add TopdownL1 metric group
and the output will be like:
[root@localhost shell]# perf stat -- stress-ng --vm 1 --timeout 1
stress-ng: info:  [3351733] setting to a 1 second run per stressor
stress-ng: info:  [3351733] dispatching hogs: 1 vm
stress-ng: info:  [3351733] successful run completed in 1.02s

 Performance counter stats for 'stress-ng --vm 1 --timeout 1':

          1,037.71 msec task-clock                       #    1.000 CPUs utilized
                13      context-switches                 #   12.528 /sec
                 1      cpu-migrations                   #    0.964 /sec
            67,544      page-faults                      #   65.090 K/sec
     2,691,932,561      cycles                           #    2.594 GHz                         (74.56%)
     6,571,333,653      instructions                     #    2.44  insn per cycle              (74.92%)
       521,863,142      branches                         #  502.901 M/sec                       (75.21%)
           425,879      branch-misses                    #    0.08% of all branches             (87.57%)
                        TopDownL1                 #     0.61 retiring                    (87.67%)
                                                  #     0.03 frontend_bound              (87.67%)
                                                  #     0.02 bad_speculation             (87.67%)
                                                  #     0.34 backend_bound               (74.61%)

       1.038138390 seconds time elapsed

       0.844849000 seconds user
       0.189053000 seconds sys

Metrics in group TopDownL1 don't have event name on arm64 but are not
listed in the $skip_metric list which they should be listed. Add them
to the skip list as what does for x86 platforms in [1].

[1] commit 4d60e83dfcee ("perf test: Skip metrics w/o event name in stat STD output linter")
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 tools/perf/tests/shell/stat+std_output.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
index 4fcdd1a9142c..f46a0c9908c0 100755
--- a/tools/perf/tests/shell/stat+std_output.sh
+++ b/tools/perf/tests/shell/stat+std_output.sh
@@ -13,7 +13,7 @@ stat_output=$(mktemp /tmp/__perf_test.stat_output.std.XXXXX)
 
 event_name=(cpu-clock task-clock context-switches cpu-migrations page-faults stalled-cycles-frontend stalled-cycles-backend cycles instructions branches branch-misses)
 event_metric=("CPUs utilized" "CPUs utilized" "/sec" "/sec" "/sec" "frontend cycles idle" "backend cycles idle" "GHz" "insn per cycle" "/sec" "of all branches")
-skip_metric=("stalled cycles per insn" "tma_")
+skip_metric=("stalled cycles per insn" "tma_" "retiring" "frontend_bound" "bad_speculation" "backend_bound")
 
 cleanup() {
   rm -f "${stat_output}"
-- 
2.24.0

