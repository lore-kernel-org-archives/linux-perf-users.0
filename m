Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD08D7A;
	Fri, 17 Nov 2023 18:51:43 -0800 (PST)
Received: from kwepemm000003.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SXJ8b66tjzNm6f;
	Sat, 18 Nov 2023 10:47:27 +0800 (CST)
Received: from ubuntu2204.huawei.com (10.67.174.22) by
 kwepemm000003.china.huawei.com (7.193.23.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 18 Nov 2023 10:51:41 +0800
From: Yang Jihong <yangjihong1@huawei.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
	<adrian.hunter@intel.com>, <avagin@google.com>, <daniel.diaz@linaro.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <yangjihong1@huawei.com>
Subject: [PATCH 3/3] perf bench sched-seccomp-notify: Fix __NR_seccomp undeclared build error on i386
Date: Sat, 18 Nov 2023 02:48:58 +0000
Message-ID: <20231118024858.1567039-4-yangjihong1@huawei.com>
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

Fix a build error on i386 system:

bench/sched-seccomp-notify.c: In function 'seccomp':
bench/sched-seccomp-notify.c:46:17: error: '__NR_seccomp' undeclared (first use in this function); did you mean 'seccomp'?
  return syscall(__NR_seccomp, op, flags, args);
                 ^~~~~~~~~~~~
                 seccomp
bench/sched-seccomp-notify.c:46:17: note: each undeclared identifier is reported only once for each function it appears in
bench/sched-seccomp-notify.c:47:1: error: control reaches end of non-void function [-Werror=return-type]
 }
 ^
cc1: all warnings being treated as errors

Fixes: 7d5cb68af638 ("perf/benchmark: add a new benchmark for seccom_unotify")
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/arch/x86/include/uapi/asm/unistd_32.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/arch/x86/include/uapi/asm/unistd_32.h b/tools/arch/x86/include/uapi/asm/unistd_32.h
index 4798f9d18fe8..9de35df1afc3 100644
--- a/tools/arch/x86/include/uapi/asm/unistd_32.h
+++ b/tools/arch/x86/include/uapi/asm/unistd_32.h
@@ -26,6 +26,6 @@
 #ifndef __NR_setns
 #define __NR_setns 346
 #endif
-#ifdef __NR_seccomp
+#ifndef __NR_seccomp
 #define __NR_seccomp 354
 #endif
-- 
2.34.1

