Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DA042A9F;
	Mon,  5 Aug 2024 22:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722897760; cv=none; b=NDXY5VhCGKxfGKYmWqqANJkf9nux9qHyz76dvR5dmR14aMlerN8txmIAAFus7bBZN3OAUhVPjeAmc9fTU6k65tvCw6xb8bvH3KTJ336Je99rm8lNHARO0y65e4GB1JLQrUl5s/Rcyep7qSKO4DZGYX8SvD1/LN3FFsO/mgRzNIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722897760; c=relaxed/simple;
	bh=UlNlwux5bbm5jdLR9eAScBokM7bq8M3fbpod5PSm4+M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OnXvoqmqYXr1u+hpgD9H8MXLRwf0ecx7USM0haxuGmW8orhEeCTX7a5uo/j7SQ+OCz9tqPiFSeXb013Q52Bcv2ayZVrTcckO1vLtno3JdzIC69SJZq1HD71kvxgrSpsAU9OU6d/aPsjZrv5ab0HgK4/PELmM9yM7SIR0mLHht0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJpMrI3i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJpMrI3i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F857C32782;
	Mon,  5 Aug 2024 22:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722897759;
	bh=UlNlwux5bbm5jdLR9eAScBokM7bq8M3fbpod5PSm4+M=;
	h=Date:From:To:Cc:Subject:From;
	b=JJpMrI3iZJ9coi/+jUJHg40x+aTlnme3KKvogrhw2vKIknWBYNJq/O9QCej/usshr
	 kbbxlgzk5D+AUt8+6Mjm3AUYsXLFRX+R4SftYwKp8GhMCsPgD8DYhlbkK1Kawargci
	 jSv8cyw79GhZiFFWLWrXvr8K900vhnL6FDRBTEJjAltUVD+Wms1tU1XFyrMCH4G/KR
	 Pk/U2dYpHlnM1jafL6ryadO51Y5wHzljPtN7Suv6IIU3EkAMfRW/7N/pGwDoJW+C4X
	 lx8ZYYXHX5qUwjCaH8tQd6JckqpZUq5RaapU5e3KOcZpMk/7V1xbG0RFz3kXJ0+Ukg
	 i5jv41t+lAEGQ==
Date: Mon, 5 Aug 2024 16:42:35 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] perf: Avoid -Wflex-array-member-not-at-end warnings
Message-ID: <ZrFVW+6OOJ2tX23N@cute>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

So, in order to avoid ending up with a flexible-array member in the
middle of multiple other structs, we use the `struct_group_tagged()`
helper to create a new tagged `struct perf_branch_stack_hdr`.
This structure groups together all the members of the flexible
`struct perf_branch_stack` except the flexible array.

As a result, the array is effectively separated from the rest of the
members without modifying the memory layout of the flexible structure.
We then change the type of the middle struct members currently causing
trouble from `struct perf_branch_stack` to `struct perf_branch_stack_hdr`.

We also want to ensure that when new members need to be added to the
flexible structure, they are always included within the newly created
tagged struct. For this, we use `static_assert()`. This ensures that the
memory layout for both the flexible structure and the new tagged struct
is the same after any changes.

This approach avoids having to implement `struct perf_branch_stack_hdr`
as a completely separate structure, thus preventing having to maintain
two independent but basically identical structures, closing the door
to potential bugs in the future.

We also use `container_of()` whenever we need to retrieve a pointer to
the flexible structure, through which the flexible-array member can be
accessed, if necessary.

So, with these changes, fix the following warnings:
arch/x86/events/amd/../perf_event.h:289:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
arch/x86/events/intel/../perf_event.h:289:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
arch/x86/events/perf_event.h:289:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
arch/x86/events/zhaoxin/../perf_event.h:289:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
./arch/x86/include/generated/../../events/perf_event.h:289:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
arch/x86/xen/../events/perf_event.h:289:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 arch/x86/events/amd/core.c   | 4 +++-
 arch/x86/events/core.c       | 4 +++-
 arch/x86/events/intel/ds.c   | 4 +++-
 arch/x86/events/intel/lbr.c  | 8 ++++++--
 arch/x86/events/perf_event.h | 2 +-
 include/linux/perf_event.h   | 9 +++++++--
 6 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 920e3a640cad..37adf2fcf508 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1001,7 +1001,9 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 			continue;
 
 		if (has_branch_stack(event))
-			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
+			perf_sample_save_brstack(&data, event,
+				container_of(&cpuc->lbr_stack, struct perf_branch_stack, hdr),
+				NULL);
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 12f2a0c14d33..e7faf7eedfc4 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1704,7 +1704,9 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
 		perf_sample_data_init(&data, 0, event->hw.last_period);
 
 		if (has_branch_stack(event))
-			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
+			perf_sample_save_brstack(&data, event,
+				container_of(&cpuc->lbr_stack, struct perf_branch_stack, hdr),
+				NULL);
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index fa5ea65de0d0..d5c86edbeaa9 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1869,7 +1869,9 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 		setup_pebs_time(event, data, pebs->tsc);
 
 	if (has_branch_stack(event))
-		perf_sample_save_brstack(data, event, &cpuc->lbr_stack, NULL);
+		perf_sample_save_brstack(data, event,
+			container_of(&cpuc->lbr_stack, struct perf_branch_stack, hdr),
+			NULL);
 }
 
 static void adaptive_pebs_save_regs(struct pt_regs *regs,
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index dc641b50814e..79ca1a2d6ff4 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -974,11 +974,15 @@ void intel_pmu_lbr_save_brstack(struct perf_sample_data *data,
 {
 	if (is_branch_counters_group(event)) {
 		intel_pmu_lbr_counters_reorder(cpuc, event);
-		perf_sample_save_brstack(data, event, &cpuc->lbr_stack, cpuc->lbr_counters);
+		perf_sample_save_brstack(data, event,
+			container_of(&cpuc->lbr_stack, struct perf_branch_stack, hdr),
+			cpuc->lbr_counters);
 		return;
 	}
 
-	perf_sample_save_brstack(data, event, &cpuc->lbr_stack, NULL);
+	perf_sample_save_brstack(data, event,
+		container_of(&cpuc->lbr_stack, struct perf_branch_stack, hdr),
+		NULL);
 }
 
 static void intel_pmu_arch_lbr_read(struct cpu_hw_events *cpuc)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index ac1182141bf6..bf05cdc3f22f 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -286,7 +286,7 @@ struct cpu_hw_events {
 	 */
 	int				lbr_users;
 	int				lbr_pebs_users;
-	struct perf_branch_stack	lbr_stack;
+	struct perf_branch_stack_hdr	lbr_stack;
 	struct perf_branch_entry	lbr_entries[MAX_LBR_ENTRIES];
 	u64				lbr_counters[MAX_LBR_ENTRIES]; /* branch stack extra */
 	union {
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 1a8942277dda..eb4413917b39 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -121,10 +121,15 @@ static __always_inline bool perf_raw_frag_last(const struct perf_raw_frag *frag)
  * already stored in age order, the hw_idx should be 0.
  */
 struct perf_branch_stack {
-	__u64				nr;
-	__u64				hw_idx;
+	/* New members MUST be added within the struct_group() macro below. */
+	struct_group_tagged(perf_branch_stack_hdr, hdr,
+		__u64				nr;
+		__u64				hw_idx;
+	);
 	struct perf_branch_entry	entries[];
 };
+static_assert(offsetof(struct perf_branch_stack, entries) == sizeof(struct perf_branch_stack_hdr),
+	      "struct member likely outside of struct_group_tagged()");
 
 struct task_struct;
 
-- 
2.34.1

