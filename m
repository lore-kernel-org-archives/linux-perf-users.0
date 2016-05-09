From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [RFC 2/2] perf/core: change errno for sampling event not supported in
 hardware
Date: Mon, 9 May 2016 15:07:40 +0530
Message-ID: <1462786660-2900-3-git-send-email-vgupta@synopsys.com>
References: <1462786660-2900-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <1462786660-2900-1-git-send-email-vgupta@synopsys.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: linux-perf-users@vger.kernel.org, peterz@infradead.org, acme@redhat.com
Cc: vincent.weaver@maine.edu, linux-snps-arc@lists.infradead.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>, linux-kernel@vger.kernel.org, mingo@kernel.org
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
index 4e2ebf6f2f1f..41c5c7122987 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8435,7 +8435,7 @@ SYSCALL_DEFINE5(perf_event_open,
 
 	if (is_sampling_event(event)) {
 		if (event->pmu->capabilities & PERF_PMU_CAP_NO_INTERRUPT) {
-			err = -ENOTSUPP;
+			err = -EOPNOTSUPP;
 			goto err_alloc;
 		}
 	}
-- 
2.5.0
