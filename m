Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67144A35;
	Tue, 22 Sep 2026 01:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040120; cv=none; b=YpPEMQ24GggHaUBWEGa/4kWX+JJrOKqkn9o/H0jq3jw/90xTpeTbJ71cqI8gZJ0DzAIOkD0DoeNUbXAxRrDYeRZQnFn+f6wgwMEtdAw0eF2WctP6y6Y5voWjnIsW6AnRfVZ103biJe58htzdHmcL7iRdHZGWi9yM9HmVOCNC8Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040120; c=relaxed/simple;
	bh=y7JtFjZ5ENIlnOSW2F25UHXUxG3+r6gAQXDhvtj//Gk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UPUQ9WgvkfRvXvfm50FWD90iE0hpHoU9atBzt41ISWIEg0O2Z2SGtoSOu8jAMbObpZosp0cYRkoMdVYbsPGeDcUWwQQsIyCkEH8mPv63bvZK7uFt2oiDBw887Vzu83jBx44VRWUZq8J2WpIbOSf8fdfXRAhn/6hiu0XUspM+eWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huSQIRnB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huSQIRnB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CA45C2BCF6;
	Tue, 22 Sep 2026 01:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790040120;
	bh=y7JtFjZ5ENIlnOSW2F25UHXUxG3+r6gAQXDhvtj//Gk=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=huSQIRnB49quXBKPfhkfJp78tHMlSxrGGOF0BlsH+03JvnWwnk1F+HpEkIiEViKMb
	 atDyqx+Bow29N1el0jvdH8r+6JPP/3+yUQHoDjCNyqficcmborEmqjyVAApp1c8EQl
	 YphA6CMjLIAXdWcdK8Iaaj1MyVNFM5dFQEqstK2yYit42HtS9koWh3YPB9FeaTQQB+
	 38kfLCHO4caxdi4BJRacUTxRAJ/+0MIxW+qCGemzt4tuRt3DgCX6JYr6Vyb3fq5XXI
	 tBR3VXUdiSghnm1nTZJgHPGkDtjWm81XdFHXgOIbODfeniB0grC2bW3CkzK+gkLz6f
	 ZuNrHdOEmsNkQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69384C982E6;
	Tue, 22 Sep 2026 01:22:00 +0000 (UTC)
From: Jaidev Shastri via B4 Relay <devnull+jaidevshastri.vt.edu@kernel.org>
Date: Mon, 21 Sep 2026 21:21:59 -0400
Subject: [PATCH] perf/hw_breakpoint: publish constraints_initialized with
 release semantics
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-mb-hw-breakpoint-v1-1-59aa06e1acf9@vt.edu>
X-B4-Tracking: v=1; b=H4sIADbYsWoC/yXM0Q7CIAyF4VdZem0NQx3BVzFeAKtSjWyhc5ose
 3dhXn5Nz7+AUGYSODcLZJpZeEgF7a6BEF26E3JfDFrpTlnd4stj/KDP5J7jwGlCY3tPqjtp4yy
 U2Zjpxt8tebn+LW//oDDVTv3wTqgUXAqxnjbOZn/AHI6wrj8ITyg3lAAAAA==
X-Change-ID: 20260921-mb-hw-breakpoint-79dbe06527a9
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jaidev Shastri <jaidevshastri@vt.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790040119; l=1906;
 i=jaidevshastri@vt.edu; s=20260921; h=from:subject:message-id;
 bh=ZTittwT4zsRNTqrg94X6kSrWHkSFjRamZEdBKAP1Vdk=;
 b=79RBPT8VnBlXr45ayEwTi+Ic3H1TPdwDJDto1NDeYNDLfc58YVk+ARoEkFDNLZZep6Elae7+x
 vwgbLBs2k6gClkTEr8HFg+z5IYaPVT6S4l1la7dnOf29Gc+W1kVW8Ah
X-Developer-Key: i=jaidevshastri@vt.edu; a=ed25519;
 pk=J7+xYJRlTPds+pv5hbqFFRqGCpDeJDzmZT1ggRwj7/0=
X-Endpoint-Received: by B4 Relay for jaidevshastri@vt.edu/20260921 with
 auth_id=1044
X-Original-From: Jaidev Shastri <jaidevshastri@vt.edu>
Reply-To: jaidevshastri@vt.edu

From: Jaidev Shastri <jaidevshastri@vt.edu>

init_breakpoint_slots() fills __nr_bp_slots[], cpu_pinned and
tsk_pinned_all and then sets constraints_initialized with a plain store.
__reserve_bp_slot() and hw_breakpoint_is_used() test the flag with a
plain load before they use those tables.

Set the flag with smp_store_release() and read it with
smp_load_acquire().

Found with MBCheck, a static herd7-based memory consistency checker.

Signed-off-by: Jaidev Shastri <jaidevshastri@vt.edu>
---
 kernel/events/hw_breakpoint.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 789add0c1..8532c8a35 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -577,7 +577,8 @@ static int __reserve_bp_slot(struct perf_event *bp, u64 bp_type)
 	int weight;
 
 	/* We couldn't initialize breakpoint constraints on boot */
-	if (!constraints_initialized)
+	/* Pairs with the smp_store_release() in init_breakpoint_slots(). */
+	if (!smp_load_acquire(&constraints_initialized))
 		return -ENOMEM;
 
 	/* Basic checks */
@@ -897,7 +898,8 @@ bool hw_breakpoint_is_used(void)
 {
 	int cpu;
 
-	if (!constraints_initialized)
+	/* Pairs with the smp_store_release() in init_breakpoint_slots(). */
+	if (!smp_load_acquire(&constraints_initialized))
 		return false;
 
 	for_each_possible_cpu(cpu) {
@@ -1017,7 +1019,8 @@ int __init init_hw_breakpoint(void)
 	if (ret)
 		return ret;
 
-	constraints_initialized = true;
+	/* Pairs with the smp_load_acquire() in the slot reservation paths. */
+	smp_store_release(&constraints_initialized, true);
 
 	perf_pmu_register(&perf_breakpoint, "breakpoint", PERF_TYPE_BREAKPOINT);
 

---
base-commit: 93f51579e7df248780214094418f205253383cc5
change-id: 20260921-mb-hw-breakpoint-79dbe06527a9

Best regards,
--  
Jaidev Shastri <jaidevshastri@vt.edu>


