Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04352DEA75
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 07:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769413480; cv=none; b=rl2XDinwhG0Iaqu75x6suff+bCGaEDIB0JzXZlbcXWNDsfL6LpJxB6btDC3o64qUG/u0bQPsRJMAA+yStG0dk3K2hXx5B+DJX6c5HITwATmlVs1WPM05IPgX8GDUXxbnyg3z4tBpdbTjkutV943ItmU0n9zRQOuol6V+fAEdBVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769413480; c=relaxed/simple;
	bh=ii48tRw2ZR9B6/7Txp86uIm0OfcNEuYrC/eBBOAxMN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OVQy7ZUXNfjJxpI8V9McsMLU9NB6Ay+WfBKFQDXZQxTwaqrtrPXnZSmz3CAV6vdVfC2ddyK9i9UoaH7L48w5J1NsrOcz/zjp155CAJJGe4d0qqH6Imv9wysCU4ixZa0mK4rHj+Xsh7mzgB/QBqF754c0bih04d4rAndT/26jpmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G7V5280r; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G7V5280r"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769413476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=li9UX981rBOVQZW+/MvOTdHHTmm4jFDDc2r8HqCxVNs=;
	b=G7V5280rbfbLGwWj6tiiT/0K3B9LFnCHA321Vh8b5KqaoXIAkTOrOB2YCq1Gd6XrrF9jGm
	/0UJXqjXw+yl/FYOknW5DWdi+xkfaFkhxLqOtHWSxq34uYj0THYaB9m2+8a1NJmWgnTYxi
	lhCspFAn19fAlZz/YdYBu+9P4GBT3NA=
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
Subject: [PATCH bpf-next v8 0/3] Pass external callchain entry to get_perf_callchain
Date: Mon, 26 Jan 2026 15:43:28 +0800
Message-ID: <20260126074331.815684-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Background
==========
Alexei noted we should use preempt_disable to protect get_perf_callchain
in bpf stackmap.
https://lore.kernel.org/bpf/CAADnVQ+s8B7-fvR1TNO-bniSyKv57cH_ihRszmZV7pQDyV=VDQ@mail.gmail.com

A previous patch was submitted to attempt fixing this issue. And Andrii
suggested teach get_perf_callchain to let us pass that buffer directly to
avoid that unnecessary copy.
https://lore.kernel.org/bpf/20250926153952.1661146-1-chen.dylane@linux.dev

Proposed Solution
=================
Add external perf_callchain_entry parameter for get_perf_callchain to
allow us to use external buffer from BPF side. The biggest advantage is
that it can reduce unnecessary copies.

Todo
====
But I'm not sure if this modification is appropriate. After all, the
implementation of get_callchain_entry in the perf subsystem seems much more
complex than directly using an external buffer.

Comments and suggestions are always welcome.

Change list:
 - v1 -> v2
   From Jiri
   - rebase code, fix conflict
 - v1: https://lore.kernel.org/bpf/20251013174721.2681091-1-chen.dylane@linux.dev

 - v2 -> v3:
   From Andrii
   - entries per CPU used in a stack-like fashion
 - v2: https://lore.kernel.org/bpf/20251014100128.2721104-1-chen.dylane@linux.dev

 - v3 -> v4:
   From Peter
   - refactor get_perf_callchain and add three new APIs to use perf
     callchain easily.
   From Andrii
   - reuse the perf callchain management.

   - rename patch1 and patch2.
 - v3: https://lore.kernel.org/bpf/20251019170118.2955346-1-chen.dylane@linux.dev

 - v4 -> v5:
   From Yonghong
   - keep add_mark false in stackmap when refactor get_perf_callchain in
     patch1.
   - add atomic operation in get_recursion_context in patch2.
   - rename bpf_put_callchain_entry with bpf_put_perf_callchain in
     patch3.
   - rebase bpf-next master.
 - v4: https://lore.kernel.org/bpf/20251028162502.3418817-1-chen.dylane@linux.dev

 - v5 -> v6:
   From Peter
   - disable preemption from BPF side in patch2.
   From AI
   - use ctx->entry->nr instead of ctx->nr in patch1.
 - v5: https://lore.kernel.org/bpf/20251109163559.4102849-1-chen.dylane@linux.dev

 - v6 -> v7:
   From yonghong
   - Add ack in patch2
   From AI
   - resolve conflict
 - v6: https://lore.kernel.org/bpf/20251112163148.100949-1-chen.dylane@linux.dev

 - v7 -> v8:
  From Andrii
   - Record rctx in perf_callchain_entry in patch1
   - Export __get_perf_callchain in patch2
 - v7: https://lore.kernel.org/bpf/20251217093326.1745307-1-chen.dylane@linux.dev

Tao Chen (3):
  perf: Add rctx in perf_callchain_entry
  perf: Refactor get_perf_callchain
  bpf: Hold ther perf callchain entry until used completely

 include/linux/perf_event.h | 10 +++++--
 kernel/bpf/stackmap.c      | 58 ++++++++++++++++++++++++++++++-------
 kernel/events/callchain.c  | 59 ++++++++++++++++++++++++--------------
 3 files changed, 93 insertions(+), 34 deletions(-)

-- 
2.48.1

