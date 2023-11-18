Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058C1D6A;
	Fri, 17 Nov 2023 18:51:42 -0800 (PST)
Received: from kwepemm000003.china.huawei.com (unknown [172.30.72.53])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SXJ9Y32bmz1P8FM;
	Sat, 18 Nov 2023 10:48:17 +0800 (CST)
Received: from ubuntu2204.huawei.com (10.67.174.22) by
 kwepemm000003.china.huawei.com (7.193.23.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 18 Nov 2023 10:51:40 +0800
From: Yang Jihong <yangjihong1@huawei.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
	<adrian.hunter@intel.com>, <avagin@google.com>, <daniel.diaz@linaro.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <yangjihong1@huawei.com>
Subject: [PATCH 1/3] perf kwork: Fix a build error on 32-bit
Date: Sat, 18 Nov 2023 02:48:56 +0000
Message-ID: <20231118024858.1567039-2-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231118024858.1567039-1-yangjihong1@huawei.com>
References: <20231118024858.1567039-1-yangjihong1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.174.22]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm000003.china.huawei.com (7.193.23.66)
X-CFilter-Loop: Reflected

lkft reported a build error for 32-bit system:

    builtin-kwork.c: In function 'top_print_work':
    builtin-kwork.c:1646:28: error: format '%ld' expects argument of
  type 'long int', but argument 3 has type 'u64' {aka 'long long
  unsigned int'} [-Werror=format=]
     1646 |         ret += printf(" %*ld ", PRINT_PID_WIDTH, work->id);
          |                         ~~~^                     ~~~~~~~~
          |                            |                         |
          |                            long int                  u64
  {aka long long unsigned int}
          |                         %*lld
    cc1: all warnings being treated as errors
    make[3]: *** [/builds/linux/tools/build/Makefile.build:106:
  /home/tuxbuild/.cache/tuxmake/builds/1/build/builtin-kwork.o] Error 1

Fix it.

Fixes: 55c40e505234 ("perf kwork top: Introduce new top utility")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-kwork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index f007a9b27065..0092b9b39611 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -1643,7 +1643,7 @@ static int top_print_work(struct perf_kwork *kwork __maybe_unused, struct kwork_
 	/*
 	 * pid
 	 */
-	ret += printf(" %*ld ", PRINT_PID_WIDTH, work->id);
+	ret += printf(" %*" PRIu64 " ", PRINT_PID_WIDTH, work->id);
 
 	/*
 	 * tgid
-- 
2.34.1

