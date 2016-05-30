From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH-REBASED 2/2] perf/core: change errno for sampling event not supported in hardware
Date: Mon, 30 May 2016 17:01:46 +0530
Message-ID: <1464607906-16012-3-git-send-email-vgupta@synopsys.com>
References: <alpine.DEB.2.20.1605121903470.18777@macbook-air>
 <1464607906-16012-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464607906-16012-1-git-send-email-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-perf-users@vger.kernel.org
Cc: peterz@infradead.org, acme@redhat.com, linux-kernel@vger.kernel.org, mingo@kernel.org, vincent.weaver@maine.edu, linux-snps-arc@lists.infradead.org, Alexey.Brodkin@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>
List-Id: linux-perf-users.vger.kernel.org

This allows userspace to identify this case specifically from the
catch all error msg it prints currently.

This is an ABI change

Before
-------
| # perf record ls
| Error:
| The sys_perf_event_open() syscall returned with 524 (Unknown error 524)
| for event (cycles:ppp).
| /bin/dmesg may provide additional information.
| No CONFIG_PERF_EVENTS=y kernel support configured?

Now
-------
| # perf record ls
| Error:
| PMU Hardware doesn't support sampling/overflow-interrupts.

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 274450efea90..a156ec0cb420 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9271,7 +9271,7 @@ SYSCALL_DEFINE5(perf_event_open,
 
 	if (is_sampling_event(event)) {
 		if (event->pmu->capabilities & PERF_PMU_CAP_NO_INTERRUPT) {
-			err = -ENOTSUPP;
+			err = -EOPNOTSUPP;
 			goto err_alloc;
 		}
 	}
-- 
2.5.0
