From: Lin Xiulei <linxiulei@gmail.com>
Subject: [PATCH v2] perf/core: Fix updating cgroup time with descendants
Date: Fri, 29 Sep 2017 13:54:44 +0800
Message-ID: <CALPjY3mkHiekRkRECzMi9G-bjUQOvOjVBAqxmWkTzc-g+0LwMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: yang_oliver@hotmail.com, Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, tglx@linutronix.de, Stephane Eranian <eranian@gmail.com>, torvalds@linux-foundation.org, Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org, brendan.d.gregg@gmail.com
List-Id: linux-perf-users.vger.kernel.org

From: "leilei.lin" <leilei.lin@alibaba-inc.com>

This fix updating cgroup time when event is being scheduled in
by descendants

Signed-off-by: leilei.lin <leilei.lin@alibaba-inc.com>
Reviewed-and-tested-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3e691b7..e3a5e32 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -662,7 +662,7 @@ static inline void
update_cgrp_time_from_event(struct perf_event *event)
        /*
         * Do not update time when cgroup is not active
         */
-       if (cgrp == event->cgrp)
+       if (cgroup_is_descendant(cgrp->css.cgroup, event->cgrp->css.cgroup))
                __update_cgrp_time(event->cgrp);
 }
