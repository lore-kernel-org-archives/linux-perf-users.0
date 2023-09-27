Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECDB2FB6
	for <linux-perf-users@vger.kernel.org>; Wed, 27 Sep 2023 03:24:30 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBBF140C8;
	Tue, 26 Sep 2023 20:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695785068; x=1727321068;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ycMyhEAn9ZsRQ3bijHZc8YDuhP6Nbbfwf7cwH5wQeXk=;
  b=Ui21nhBySHLPI3+/rBHlK8cKkUin8HbEVzst4AM1OTS08BsEkGj9W68y
   gdi/eVsv7HirOq7qYSm8ldAgqWJzlouepgwNH9mQl9vxGHJ9dslm8nqSR
   W5M3K03dd6DpksrEVDXkokoHZqmTnpMKDbt9OFCpAYho+U5w//4LOIbMX
   wx8pSfZ2G2EXiAXtNMPA8bn/IeTWgnGmVorY5JF/aFosrgJxMfdi6iozT
   eL/7CncQNDLW6TVmWQmYuo8BYZELK47Sqpal/BxRzQgpyKotIXYL942ba
   OD17CxPzn4am4FPn2YeTEjdIjxIYKgzPT583u5EzR3EjjAQFTO1++F9jn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="366780770"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="366780770"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 20:24:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="864637076"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="864637076"
Received: from dmi-pnp-i7.sh.intel.com ([10.239.159.155])
  by fmsmga002.fm.intel.com with ESMTP; 26 Sep 2023 20:24:22 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Like Xu <likexu@tencent.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: kvm@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhenyu Wang <zhenyuw@linux.intel.com>,
	Zhang Xiong <xiong.y.zhang@intel.com>,
	Lv Zhiyuan <zhiyuan.lv@intel.com>,
	Yang Weijiang <weijiang.yang@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v4 03/13] perf/core: Add function perf_event_group_leader_check()
Date: Wed, 27 Sep 2023 11:31:14 +0800
Message-Id: <20230927033124.1226509-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927033124.1226509-1-dapeng1.mi@linux.intel.com>
References: <20230927033124.1226509-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Extract the group leader checking code in function sys_perf_event_open()
to create a new function perf_event_group_leader_check().

The subsequent change would add a new function
perf_event_create_group_kernel_counters() which is used to create group
events in kernel space. The function also needs to do same check for group
leader event just like function sys_perf_event_open() does. So extract
the checking code into a separate function and avoid the code
duplication.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 kernel/events/core.c | 143 +++++++++++++++++++++++--------------------
 1 file changed, 78 insertions(+), 65 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4c72a41f11af..d485dac2b55f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12313,6 +12313,81 @@ perf_check_permission(struct perf_event_attr *attr, struct task_struct *task)
 	return is_capable || ptrace_may_access(task, ptrace_mode);
 }
 
+static int perf_event_group_leader_check(struct perf_event *group_leader,
+					 struct perf_event *event,
+					 struct perf_event_attr *attr,
+					 struct perf_event_context *ctx,
+					 struct pmu **pmu,
+					 int *move_group)
+{
+	if (!group_leader)
+		return 0;
+
+	/*
+	 * Do not allow a recursive hierarchy (this new sibling
+	 * becoming part of another group-sibling):
+	 */
+	if (group_leader->group_leader != group_leader)
+		return -EINVAL;
+
+	/* All events in a group should have the same clock */
+	if (group_leader->clock != event->clock)
+		return -EINVAL;
+
+	/*
+	 * Make sure we're both events for the same CPU;
+	 * grouping events for different CPUs is broken; since
+	 * you can never concurrently schedule them anyhow.
+	 */
+	if (group_leader->cpu != event->cpu)
+		return -EINVAL;
+
+	/*
+	 * Make sure we're both on the same context; either task or cpu.
+	 */
+	if (group_leader->ctx != ctx)
+		return -EINVAL;
+
+	/*
+	 * Only a group leader can be exclusive or pinned
+	 */
+	if (attr->exclusive || attr->pinned)
+		return -EINVAL;
+
+	if (is_software_event(event) &&
+	    !in_software_context(group_leader)) {
+		/*
+		 * If the event is a sw event, but the group_leader
+		 * is on hw context.
+		 *
+		 * Allow the addition of software events to hw
+		 * groups, this is safe because software events
+		 * never fail to schedule.
+		 *
+		 * Note the comment that goes with struct
+		 * perf_event_pmu_context.
+		 */
+		*pmu = group_leader->pmu_ctx->pmu;
+	} else if (!is_software_event(event)) {
+		if (is_software_event(group_leader) &&
+		    (group_leader->group_caps & PERF_EV_CAP_SOFTWARE)) {
+			/*
+			 * In case the group is a pure software group, and we
+			 * try to add a hardware event, move the whole group to
+			 * the hardware context.
+			 */
+			*move_group = 1;
+		}
+
+		/* Don't allow group of multiple hw events from different pmus */
+		if (!in_software_context(group_leader) &&
+		    group_leader->pmu_ctx->pmu != *pmu)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 /**
  * sys_perf_event_open - open a performance event, associate it to a task/cpu
  *
@@ -12507,71 +12582,9 @@ SYSCALL_DEFINE5(perf_event_open,
 		}
 	}
 
-	if (group_leader) {
-		err = -EINVAL;
-
-		/*
-		 * Do not allow a recursive hierarchy (this new sibling
-		 * becoming part of another group-sibling):
-		 */
-		if (group_leader->group_leader != group_leader)
-			goto err_locked;
-
-		/* All events in a group should have the same clock */
-		if (group_leader->clock != event->clock)
-			goto err_locked;
-
-		/*
-		 * Make sure we're both events for the same CPU;
-		 * grouping events for different CPUs is broken; since
-		 * you can never concurrently schedule them anyhow.
-		 */
-		if (group_leader->cpu != event->cpu)
-			goto err_locked;
-
-		/*
-		 * Make sure we're both on the same context; either task or cpu.
-		 */
-		if (group_leader->ctx != ctx)
-			goto err_locked;
-
-		/*
-		 * Only a group leader can be exclusive or pinned
-		 */
-		if (attr.exclusive || attr.pinned)
-			goto err_locked;
-
-		if (is_software_event(event) &&
-		    !in_software_context(group_leader)) {
-			/*
-			 * If the event is a sw event, but the group_leader
-			 * is on hw context.
-			 *
-			 * Allow the addition of software events to hw
-			 * groups, this is safe because software events
-			 * never fail to schedule.
-			 *
-			 * Note the comment that goes with struct
-			 * perf_event_pmu_context.
-			 */
-			pmu = group_leader->pmu_ctx->pmu;
-		} else if (!is_software_event(event)) {
-			if (is_software_event(group_leader) &&
-			    (group_leader->group_caps & PERF_EV_CAP_SOFTWARE)) {
-				/*
-				 * In case the group is a pure software group, and we
-				 * try to add a hardware event, move the whole group to
-				 * the hardware context.
-				 */
-				move_group = 1;
-			}
-
-			/* Don't allow group of multiple hw events from different pmus */
-			if (!in_software_context(group_leader) &&
-			    group_leader->pmu_ctx->pmu != pmu)
-				goto err_locked;
-		}
-	}
+	err = perf_event_group_leader_check(group_leader, event, &attr, ctx, &pmu, &move_group);
+	if (err)
+		goto err_locked;
 
 	/*
 	 * Now that we're certain of the pmu; find the pmu_ctx.
-- 
2.34.1

