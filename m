Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794972279;
	b=C2WtH9yxqb/b7mMJX9K9IZAB4i/+ZaTD5sPbg6Kn2/QRNZGnErEokjn/M9YvZKBWVB6T
	 /NC34Nua1Fixkr4k2XIvDsuYpQLkJcuedSkhY30lEJyYt3KuEU21o8KcLX75+tgajU2Sh
	 WSgCUcNapW35p1r78KvzyuiBnGgydBduYuTHP+y0qLJmiJBx0V5wawjE6VLzxgJQChDd1
	 EQtEaQadpFweEwREdTOVeBTSDx63oRBwOMVSB13OTLi5Xl8nqpkAj+WoZAFBP12NDO8D+
	 LdGd7aYcGXEjfPg7e1bfviFHGqur9uAmb+mHhxIsmycfeVktwsW3EEZU4t/xoEPryWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794972279;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rL6L8y1zrpK7esXdTjhPIB0PUAKdunj7De32hbYk/Jk=;
	b=ZHBQEZ6q1VR/Ejs219J8I9xBHmhx1JGbfoGaeImN1Cs39h6c2+jpDSQ0M45+uH2UnIvp
	 uUZMrlKc/7s/rxu/IVTUoUsXZcVEljNs5DImYW4zhfNUUG1R0Qu/+gVgu4+XelainGuLP
	 hx2BHUsDKZ4WNzcNdcNhBEitpltXLDtUejWfQlYjRbw6bnja2wtqV+ewqbEoyiXewl2bm
	 17FV97GQpPcceezKRCAZ/vNgYfBMdhyXx+1cIIit0RZ24C+xffDhe1fBd2KIsL1gOzFrw
	 aoopBi8RnPKQSwJ1TqK3hBHTGLf0aU+gur8XTAbZWX0EuNlimgmQkVKWjXpgx6AEaFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IaqpW+Lp;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023C1606A32F;
	Wed, 18 Nov 2026 03:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 023C1606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IaqpW+Lp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794972280; x=1826508280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fD4T+p+Cfd6aQCEOqE6uCFNJMlR/I8y/8hhudmZUxFM=;
  b=IaqpW+Lpp9n143E6ghwTyL0LGnUDadhb3XwaxW7l37kt2GF51F3EHJbB
   VqEExncI2YhN2rF9AZXU/YH2swyqQ0ry2jB6xWPwBx8E4Pupmttjbl229
   ebd2o5g7dkq1rT5CX2NgXmBfEIvLYXESoKJWOCoxDrD1U3W1FHh8Dpsa0
   15UkwfN4EE0NErydw+s7/SCsjBaIbyGwNPhRIcqBI2lc617YtGEKk/ZJj
   C1FHfG4x4kUyrcoh4AXPB1+vd2KdLYSLsfL1KkLL4uHynmuRNM1WIwkgB
   g8NgwRs9JXWDl1IGYk9wY2c5P1/k3a5g0GEZu1OomnP4rqvHef2iLWCct
   w==;
X-CSE-ConnectionGUID: 0m8URZC+QaaB8xkHpz6wWg==
X-CSE-MsgGUID: 4rWR7qgsTciJQsq0bjEyHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3630070"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3630070"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 19:24:39 -0800
X-CSE-ConnectionGUID: qvuYME5VSUWlJRXDlk7/6w==
X-CSE-MsgGUID: og+qwVkAQR+ulngClJqX1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9894435"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa004.jf.intel.com with ESMTP; 17 Nov 2026 19:24:33 -0800
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Sashiko <sashiko-bot@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Daniel Xu <dxu@dxuuu.xyz>
Subject: [Patch v7 23/24] perf/core: Don't mutate shared branch stack depth
Date: Wed, 18 Nov 2026 11:14:52 +0800
Message-Id: <20261118031453.1353625-24-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf_sample_save_brstack() clamps the branch stack depth by directly
overwriting brs->nr with min(event->attr.sample_max_stack, brs->nr).
This is unsafe because the branch stack buffer is shared by all branch
events in the same PMI: once one event with a small sample_max_stack
truncates brs->nr, every subsequent event processed in that PMI sees
the shrunken depth and silently loses branch records it asked for.

Add perf_event_brstack_depth(), which computes the per-event depth
without modifying the shared branch stack. Use it in the relevant callers
so each event is limited only by its own sample_max_stack, without
clobbering the shared LBR state.

bpf_read_branch_records() also relied on the clamped brs->nr, so switch
it to perf_event_brstack_depth() to preserve the same per-event limit for
records returned to BPF programs.

Fixes: c53e14f1ea4a ("perf: Extend per event callchain limit to branch stack")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Matt Bobrowski <matt@bobrowski.net>
Cc: Song Liu <song@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Daniel Xu <dxu@dxuuu.xyz>
---
 include/linux/perf_event.h | 13 ++++++++++---
 kernel/events/core.c       |  8 ++++----
 kernel/trace/bpf_trace.c   |  6 ++++--
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 19de3f1cbd6e..35d3cc4cc07e 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1424,12 +1424,19 @@ static inline bool has_branch_stack(struct perf_event *event)
 	return event->attr.sample_type & PERF_SAMPLE_BRANCH_STACK;
 }
 
+static inline u64 perf_event_brstack_depth(struct perf_event *event,
+					   struct perf_branch_stack *brs)
+{
+	return min_t(u16, event->attr.sample_max_stack, brs->nr);
+}
+
 static inline void perf_sample_save_brstack(struct perf_sample_data *data,
 					    struct perf_event *event,
 					    struct perf_branch_stack *brs,
 					    u64 *brs_cntr)
 {
 	int size = sizeof(u64); /* nr */
+	u64 nr;
 
 	if (!has_branch_stack(event))
 		return;
@@ -1439,9 +1446,9 @@ static inline void perf_sample_save_brstack(struct perf_sample_data *data,
 	if (branch_sample_hw_index(event))
 		size += sizeof(u64);
 
-	brs->nr = min_t(u16, event->attr.sample_max_stack, brs->nr);
+	nr = perf_event_brstack_depth(event, brs);
 
-	size += brs->nr * sizeof(struct perf_branch_entry);
+	size += nr * sizeof(struct perf_branch_entry);
 
 	/*
 	 * The extension space for counters is appended after the
@@ -1449,7 +1456,7 @@ static inline void perf_sample_save_brstack(struct perf_sample_data *data,
 	 * of events of each branch.
 	 */
 	if (brs_cntr)
-		size += brs->nr * sizeof(u64);
+		size += nr * sizeof(u64);
 
 	data->br_stack = brs;
 	data->br_stack_cntr = brs_cntr;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 457d75ea7142..8b80ca788523 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8462,12 +8462,12 @@ void perf_output_sample(struct perf_output_handle *handle,
 
 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
 		if (data->br_stack) {
+			u64 nr = perf_event_brstack_depth(event, data->br_stack);
 			size_t size;
 
-			size = data->br_stack->nr
-			     * sizeof(struct perf_branch_entry);
+			size = nr * sizeof(struct perf_branch_entry);
 
-			perf_output_put(handle, data->br_stack->nr);
+			perf_output_put(handle, nr);
 			if (branch_sample_hw_index(event))
 				perf_output_put(handle, data->br_stack->hw_idx);
 			perf_output_copy(handle, data->br_stack->entries, size);
@@ -8476,7 +8476,7 @@ void perf_output_sample(struct perf_output_handle *handle,
 			 * right after the struct perf_branch_stack.
 			 */
 			if (data->br_stack_cntr) {
-				size = data->br_stack->nr * sizeof(u64);
+				size = nr * sizeof(u64);
 				perf_output_copy(handle, data->br_stack_cntr, size);
 			}
 		} else {
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 2aec56d7f3d3..7c42bbf05c2f 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1549,6 +1549,7 @@ BPF_CALL_4(bpf_read_branch_records, struct bpf_perf_event_data_kern *, ctx,
 	static const u32 br_entry_size = sizeof(struct perf_branch_entry);
 	struct perf_branch_stack *br_stack = ctx->data->br_stack;
 	u32 to_copy;
+	u64 nr;
 
 	if (unlikely(flags & ~BPF_F_GET_BRANCH_RECORDS_SIZE))
 		return -EINVAL;
@@ -1559,13 +1560,14 @@ BPF_CALL_4(bpf_read_branch_records, struct bpf_perf_event_data_kern *, ctx,
 	if (unlikely(!br_stack))
 		return -ENOENT;
 
+	nr = perf_event_brstack_depth(ctx->event, br_stack);
 	if (flags & BPF_F_GET_BRANCH_RECORDS_SIZE)
-		return br_stack->nr * br_entry_size;
+		return nr * br_entry_size;
 
 	if (!buf || (size % br_entry_size != 0))
 		return -EINVAL;
 
-	to_copy = min_t(u32, br_stack->nr * br_entry_size, size);
+	to_copy = min_t(u32, nr * br_entry_size, size);
 	memcpy(buf, br_stack->entries, to_copy);
 
 	return to_copy;
-- 
2.34.1

