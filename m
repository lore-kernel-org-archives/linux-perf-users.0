Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AD71995;
	Thu,  7 Dec 2023 00:20:20 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Sm6d42l1DzYsps;
	Thu,  7 Dec 2023 16:19:36 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 16:20:16 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
	<adrian.hunter@intel.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <hejunhao3@huawei.com>,
	<yangyicong@hisilicon.com>, <linuxarm@huawei.com>
Subject: [PATCH 0/2] Perf fix two memory leakage
Date: Thu, 7 Dec 2023 16:16:33 +0800
Message-ID: <20231207081635.8427-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected

From: Yicong Yang <yangyicong@hisilicon.com>

ASan reports two memory leakage in the raw trace dump mode `perf report -D`.
One is in the framework and can be reproduced when using hisi_ptt and
arm_spe, which is fixed in Patch 1/2. Another is in the hisi_ptt parser
and fixed in Patch 2/2.

Yicong Yang (2):
  perf header: Fix one memory leakage in
    perf_event__fprintf_event_update()
  perf hisi-ptt: Fix one memory leakage in
    hisi_ptt_process_auxtrace_event()

 tools/perf/util/header.c   | 5 +++--
 tools/perf/util/hisi-ptt.c | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.24.0

