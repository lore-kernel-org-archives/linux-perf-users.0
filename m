Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AE510CE;
	Fri, 17 Nov 2023 18:51:43 -0800 (PST)
Received: from kwepemm000003.china.huawei.com (unknown [172.30.72.54])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SXJ851lR1zMmkY;
	Sat, 18 Nov 2023 10:47:01 +0800 (CST)
Received: from ubuntu2204.huawei.com (10.67.174.22) by
 kwepemm000003.china.huawei.com (7.193.23.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 18 Nov 2023 10:51:39 +0800
From: Yang Jihong <yangjihong1@huawei.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
	<adrian.hunter@intel.com>, <avagin@google.com>, <daniel.diaz@linaro.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <yangjihong1@huawei.com>
Subject: [PATCH 0/3] A few fixes for i386 build errors
Date: Sat, 18 Nov 2023 02:48:55 +0000
Message-ID: <20231118024858.1567039-1-yangjihong1@huawei.com>
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
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm000003.china.huawei.com (7.193.23.66)
X-CFilter-Loop: Reflected

Yang Jihong (3):
  perf kwork: Fix a build error on 32-bit
  perf lock contention: Fix a build error on 32-bit
  perf bench sched-seccomp-notify: Fix __NR_seccomp undeclared build
    error on i386

 tools/arch/x86/include/uapi/asm/unistd_32.h | 2 +-
 tools/perf/builtin-kwork.c                  | 2 +-
 tools/perf/util/bpf_lock_contention.c       | 3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.34.1

