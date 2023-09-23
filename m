Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D07D519
	for <linux-perf-users@vger.kernel.org>; Sat, 23 Sep 2023 09:32:11 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F863C2;
	Sat, 23 Sep 2023 02:32:09 -0700 (PDT)
Received: from kwepemm000003.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rt3hz2cCgzNng1;
	Sat, 23 Sep 2023 17:28:19 +0800 (CST)
Received: from ubuntu2204.huawei.com (10.67.174.22) by
 kwepemm000003.china.huawei.com (7.193.23.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 23 Sep 2023 17:32:06 +0800
From: Yang Jihong <yangjihong1@huawei.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
	<adrian.hunter@intel.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <yangjihong1@huawei.com>
Subject: [PATCH 0/4] perf bench messaging: Kill child processes when exit abnormally in process mode
Date: Sat, 23 Sep 2023 09:30:33 +0000
Message-ID: <20230923093037.961232-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.174.22]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000003.china.huawei.com (7.193.23.66)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

If perf bench messaging in process mode exits abnormally, the forked child
processes does not exit.

The test result is as follows:

  # perf bench sched messaging -l 1000000 -g 1 &
  [4] 553
  # Running 'sched/messaging' benchmark:
  # kill -15 533
  # ps -ef | grep perf
  root         425     371  0 09:11 pts/0    00:00:00 perf bench sched messaging -l 1000000 -g 1
  root         426     425 17 09:11 pts/0    00:01:56 perf bench sched messaging -l 1000000 -g 1
  root         427     425 17 09:11 pts/0    00:01:55 perf bench sched messaging -l 1000000 -g 1
  root         428     425 17 09:11 pts/0    00:01:55 perf bench sched messaging -l 1000000 -g 1
  root         429     425 17 09:11 pts/0    00:01:55 perf bench sched messaging -l 1000000 -g 1
  root         430     425 17 09:11 pts/0    00:01:55 perf bench sched messaging -l 1000000 -g 1
  root         431     425 17 09:11 pts/0    00:01:56 perf bench sched messaging -l 1000000 -g 1
  root         432     425 17 09:11 pts/0    00:01:55 perf bench sched messaging -l 1000000 -g 1
  root         433     425 17 09:11 pts/0    00:01:55 perf bench sched messaging -l 1000000 -g 1
  root         434     425 17 09:11 pts/0    00:01:55 perf bench sched messaging -l 1000000 -g 1
  root         435     425 17 09:11 pts/0    00:01:55 perf bench sched messaging -l 1000000 -g 1
  root         436     425 17 09:11 pts/0    00:01:55 perf bench sched messaging -l 1000000 -g 1
  root         437     425 17 09:11 pts/0    00:01:55 perf bench sched messaging -l 1000000 -g 1
  root         438     425 17 09:11 pts/0    00:01:55 perf bench sched messaging -l 1000000 -g 1
  root         439     425 17 09:11 pts/0    00:01:55 perf bench sched messaging -l 1000000 -g 1
  root         440     425 17 09:11 pts/0    00:01:55 perf bench sched messaging -l 1000000 -g 1
  root         441     425 17 09:11 pts/0    00:01:55 perf bench sched messaging -l 1000000 -g 1
  root         442     425 17 09:11 pts/0    00:01:55 perf bench sched messaging -l 1000000 -g 1
  root         443     425 17 09:11 pts/0    00:01:55 perf bench sched messaging -l 1000000 -g 1
  root         444     425 17 09:11 pts/0    00:01:54 perf bench sched messaging -l 1000000 -g 1
  root         445     425 17 09:11 pts/0    00:01:55 perf bench sched messaging -l 1000000 -g 1
  root         446     425 16 09:11 pts/0    00:01:50 perf bench sched messaging -l 1000000 -g 1
  root         447     425 16 09:11 pts/0    00:01:49 perf bench sched messaging -l 1000000 -g 1
  root         448     425 16 09:11 pts/0    00:01:50 perf bench sched messaging -l 1000000 -g 1
  root         449     425 16 09:11 pts/0    00:01:49 perf bench sched messaging -l 1000000 -g 1
  root         450     425 16 09:11 pts/0    00:01:50 perf bench sched messaging -l 1000000 -g 1
  root         451     425 16 09:11 pts/0    00:01:50 perf bench sched messaging -l 1000000 -g 1
  root         452     425 16 09:11 pts/0    00:01:50 perf bench sched messaging -l 1000000 -g 1
  root         453     425 16 09:11 pts/0    00:01:49 perf bench sched messaging -l 1000000 -g 1
  root         454     425 16 09:11 pts/0    00:01:49 perf bench sched messaging -l 1000000 -g 1
<SNIP>

Capture signals SIGINT and SIGTERM to kill child processes in signal handler

Yang Jihong (4):
  perf bench messaging: Fix coding style issues for sched-messaging
  perf bench messaging: Factor out create_worker()
  perf bench messaging: Store chlid process pid when creating worker for
    process mode
  perf bench messaging: Kill child processes when exit abnormally in
    process mode

 tools/perf/bench/sched-messaging.c | 102 ++++++++++++++++++-----------
 1 file changed, 64 insertions(+), 38 deletions(-)

-- 
2.34.1

