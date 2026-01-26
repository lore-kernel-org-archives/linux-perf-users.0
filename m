Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98578310651
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 07:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769413552; cv=none; b=HyF8C3OrE1TK6PWB6wNc26cyhNE8WAuNV889giCy6LSrq0eMvGAVc0X3Tud7N/nV4IUjuCBCkp6mdQk4ATfQ5eH+BvwG3gXraxxGRc+66pMFArhG/kEP6EYy3Wgu1g54AeSaENM52wXqt6wzVeIqbSpVqi4/gC17OEiwMavikWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769413552; c=relaxed/simple;
	bh=7FoC3r3AxO5ou9V4Xi9JtHx0tBIve9Uq6sQHQgXG9rM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLwKK7oTm20rh/f1NI5riGcrx/MAhazw7KPPp7NWKBDfRgZJ8VD6toWjUYuXDSFPaurRtk0T1Fbu7Plxt5AWeTaOR0TQeM35SN+2FWbsHac1cMRAZe8E/dFY+4scnYtb1/NabZH0pUzkEnHkAomtXxwvkPN9Li2Wx7lXXzhCnAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y1Z9UXC3; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y1Z9UXC3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769413538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mo0+KCVD+P6cqk7ZzlvxjYRyhs7XL0k+jGz9ASrm76g=;
	b=Y1Z9UXC3tidrUHrbE6ucF9M/RYTZ+FfVvsbiuo5zONdFlnKpI0mEn0Aj0tK2vmW2+0E6Or
	6C+fI4Ym4H/E49OkCz60y9qy1SdR3LOrcu0z4wgsP/xXIYaOGeJubuE0VeI6aHg1IWFCYd
	EnmUlQxvD5IpUDqUCltbNYx7zKQEiqg=
From: Tao Chen <chen.dylane@linux.dev>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	song@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v8 2/3] perf: Refactor get_perf_callchain
Date: Mon, 26 Jan 2026 15:43:30 +0800
Message-ID: <20260126074331.815684-3-chen.dylane@linux.dev>
In-Reply-To: <20260126074331.815684-1-chen.dylane@linux.dev>
References: <20260126074331.815684-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From BPF stack map, we want to ensure that the callchain buffer
will not be overwritten by other preemptive tasks and we also aim
to reduce the preempt disable interval, Based on the suggestions from Peter
and Andrrii, export new API __get_perf_callchain and the usage scenarios
are as follows from BPF side:

preempt_disable()
entry = get_callchain_entry()
preempt_enable()
__get_perf_callchain(entry)
put_callchain_entry(entry)

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 include/linux/perf_event.h |  5 +++++
 kernel/events/callchain.c  | 34 ++++++++++++++++++++++------------
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index f0489843ebc..7132fa97bb1 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1722,6 +1722,11 @@ extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct
 extern struct perf_callchain_entry *
 get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 		   u32 max_stack, bool crosstask, bool add_mark, u64 defer_cookie);
+
+extern int __get_perf_callchain(struct perf_callchain_entry *entry, struct pt_regs *regs,
+				bool kernel, bool user, u32 max_stack, bool crosstask, bool add_mark,
+				u64 defer_cookie);
+
 extern int get_callchain_buffers(int max_stack);
 extern void put_callchain_buffers(void);
 extern struct perf_callchain_entry *get_callchain_entry(void);
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 6cdbc5937b1..f9789d10fa4 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -221,21 +221,15 @@ static void fixup_uretprobe_trampoline_entries(struct perf_callchain_entry *entr
 #endif
 }
 
-struct perf_callchain_entry *
-get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
-		   u32 max_stack, bool crosstask, bool add_mark, u64 defer_cookie)
+int __get_perf_callchain(struct perf_callchain_entry *entry, struct pt_regs *regs, bool kernel,
+			 bool user, u32 max_stack, bool crosstask, bool add_mark, u64 defer_cookie)
 {
-	struct perf_callchain_entry *entry;
 	struct perf_callchain_entry_ctx ctx;
 	int start_entry_idx;
 
 	/* crosstask is not supported for user stacks */
 	if (crosstask && user && !kernel)
-		return NULL;
-
-	entry = get_callchain_entry();
-	if (!entry)
-		return NULL;
+		return -EINVAL;
 
 	ctx.entry		= entry;
 	ctx.max_stack		= max_stack;
@@ -252,7 +246,7 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 	if (user && !crosstask) {
 		if (!user_mode(regs)) {
 			if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
-				goto exit_put;
+				return 0;
 			regs = task_pt_regs(current);
 		}
 
@@ -265,7 +259,7 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 			 */
 			perf_callchain_store_context(&ctx, PERF_CONTEXT_USER_DEFERRED);
 			perf_callchain_store_context(&ctx, defer_cookie);
-			goto exit_put;
+			return 0;
 		}
 
 		if (add_mark)
@@ -275,9 +269,25 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 		perf_callchain_user(&ctx, regs);
 		fixup_uretprobe_trampoline_entries(entry, start_entry_idx);
 	}
+	return 0;
+}
+
+struct perf_callchain_entry *
+get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
+		   u32 max_stack, bool crosstask, bool add_mark, u64 defer_cookie)
+{
+	struct perf_callchain_entry *entry;
+	int ret;
+
+	entry = get_callchain_entry();
+	if (!entry)
+		return NULL;
 
-exit_put:
+	ret = __get_perf_callchain(entry, regs, kernel, user, max_stack, crosstask, add_mark,
+				   defer_cookie);
 	put_callchain_entry(entry);
+	if (ret)
+		entry = NULL;
 
 	return entry;
 }
-- 
2.48.1

