Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FD828CF4A;
	Wed, 29 Apr 2026 19:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777490962; cv=none; b=GrehU/bi/pyIQ1U6jwGW8+SHFsE/imf+xNZ5ofuamG66XDlQWtWVCgblcygyqCjJnbMsZYIz2jDECOAC/Ak+u9jiiVERlUKV5T72G+Tl0gif9N3s1iTwEO9xGJa/4yG+KZi2EpkZnknC7SkUuQ+ZhJiHezCu33JL0/FXZ3mk0Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777490962; c=relaxed/simple;
	bh=xzGYn9yMy0wBlr+VQuKnXblpIAZvJTgc99Tv5tkEerQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SynDVlwp495yhznv79p3UFrMAPxN4HiNO48pJlHNCeuKSqWHZBqCENtVuv6nrj02I7FL53HvwYSVNxRhDGuy+vwmJU9nFMdjDgunzkCjGx1RVKFGoy3mHQbPP4yOwronXpUepL/XnF7AjlxQ2sBMpj3+7/7d1PjA4i2pLfjShGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPDMHOU1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPDMHOU1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9DBC19425;
	Wed, 29 Apr 2026 19:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777490962;
	bh=xzGYn9yMy0wBlr+VQuKnXblpIAZvJTgc99Tv5tkEerQ=;
	h=Date:From:To:Cc:Subject:From;
	b=nPDMHOU1x+9iKyaVo/LXj7IHH7Yy9qpqGZQqHjj894OlXWCcpLkizu3Ke8116cDx3
	 lmlVH3874Sv3dpa/vT/5LSKoQFd3GV7cMwRRtkCbbFHMukPSHC82U/gbsf9eaEqMl9
	 CUYRQuZoO6R4Wk3791UFaEpaljt8X+2ZNJBPyK0IX3ggsiRGrPCEmyV/ZJr5Vl4pRh
	 sWhd86D8Pv0jrSbq+V9lMn1/3leo1UKWTscfZbacSR9KkyDifDLmieTAeiloAoNpXu
	 sdnAnXwjebptONqHv4O1Uc9v0PI38fdaXkDfyky4MJf89qCZRfxu2eh7XX9zRa7zCQ
	 p8z3UNuu+vr4A==
Date: Wed, 29 Apr 2026 13:29:18 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] perf/x86: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Message-ID: <afJcDg1I5ZU5ZkXf@kspp>
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

Use the TRAILING_OVERLAP() helper to fix the following warnings:

14 arch/x86/events/intel/../perf_event.h:326:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
6 arch/x86/events/amd/../perf_event.h:326:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
3 arch/x86/events/perf_event.h:326:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
1 arch/x86/xen/../events/perf_event.h:326:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
1 arch/x86/events/zhaoxin/../perf_event.h:326:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
1 ./arch/x86/include/generated/../../events/perf_event.h:326:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

This helper creates a union between a flexible-array member (FAM)
and a set of members that would otherwise follow it. This overlays
the trailing members onto the FAM while preserving the original
memory layout.

Lastly, the static_assert() ensures the alignment between the FAM
and struct perf_branch_entry lbr_entries[MAX_LBR_ENTRIES]; is not
inadvertently changed, and it's intentionally placed inmediately
after the related structure (that is, no blank line in between).

It's also worth mentioning that the entire Intel LBR bits block
is moved just to avoid splitting it.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 arch/x86/events/perf_event.h | 41 ++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index fad87d3c8b2c..9641b888cbee 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -318,24 +318,6 @@ struct cpu_hw_events {
 	/* Cached CFG_C values */
 	u64			cfg_c_val[X86_PMC_IDX_MAX];
 
-	/*
-	 * Intel LBR bits
-	 */
-	int				lbr_users;
-	int				lbr_pebs_users;
-	struct perf_branch_stack	lbr_stack;
-	struct perf_branch_entry	lbr_entries[MAX_LBR_ENTRIES];
-	u64				lbr_counters[MAX_LBR_ENTRIES]; /* branch stack extra */
-	union {
-		struct er_account		*lbr_sel;
-		struct er_account		*lbr_ctl;
-	};
-	u64				br_sel;
-	void				*last_task_ctx;
-	int				last_log_id;
-	int				lbr_select;
-	void				*lbr_xsave;
-
 	/*
 	 * Intel host/guest exclude bits
 	 */
@@ -384,7 +366,30 @@ struct cpu_hw_events {
 	void				*kfree_on_online[X86_PERF_KFREE_MAX];
 
 	struct pmu			*pmu;
+
+	/*
+	 * Intel LBR bits
+	 */
+	int				lbr_users;
+	int				lbr_pebs_users;
+	union {
+		struct er_account		*lbr_sel;
+		struct er_account		*lbr_ctl;
+	};
+	u64				br_sel;
+	void				*last_task_ctx;
+	int				last_log_id;
+	int				lbr_select;
+	void				*lbr_xsave;
+
+	/* Must be last as it ends in a flexible-array member. */
+	TRAILING_OVERLAP(struct perf_branch_stack, lbr_stack, entries,
+		struct perf_branch_entry	lbr_entries[MAX_LBR_ENTRIES];
+		u64				lbr_counters[MAX_LBR_ENTRIES]; /* branch stack extra */
+	);
 };
+static_assert(offsetof(struct cpu_hw_events, lbr_stack.entries) ==
+	      offsetof(struct cpu_hw_events, lbr_entries));
 
 #define __EVENT_CONSTRAINT_RANGE(c, e, n, m, w, o, f) {	\
 	{ .idxmsk64 = (n) },		\
-- 
2.51.0

