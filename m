Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B9A1EEA5F
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Oct 2025 10:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436123; cv=none; b=Ffu6tjdSLWbMkjHlwqdMimZxGhIJWbXFRVHI5cwYRgoD5Pn2oKtb5hgdA075OA5CMLyaYWWlWuSsSglGz6pm/nX85Y++kXapSaJkjm32biV4ajRu185cwPGfg2EVjCFJUh6hb+N9zw/GfgnSK9Ony6exLPqtvBU1LN5RKUG5rKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436123; c=relaxed/simple;
	bh=//nKyMjQT/XUVl4ap1KlpQMlW3dQCozDjSt4HbI99YU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=trjSKrpY+yp0KWDmVYvlukKLg1S+c/mFxUKP8fWBAgfB8Tt8C88RkYDa0c9VuUl9otcgpvaRdwBZCkLaCEuzgqYTDuJ/KyW09UZqPzxE02hdLCS8YjptQqLio71sSl9VymF61f+2+M2bde2lGLaZtcHOWw3CjBIJMaVm7IZlt8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vF3gWFMA; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vF3gWFMA"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760436109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sbDoAjrS2xAf/gutlRdmjLlBlDoaX2SKsgUsS0O9aH0=;
	b=vF3gWFMAiQfPe6tldLH2jPEuTzyo9XPBip1DGJPnV0xLBgGR3vXUggKZTeYpUzfNx1jFlH
	GfqzaR0EqenXw1C66Jdnwrb2v1dPgrcUfU6co1XGPKJbRkcMGrOjBduFCmrzA49vIQa5As
	EX1tBTO3LR8UoqsLAQdQYX+3d7lzOds=
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
Subject: [RFC PATCH bpf-next v2 0/2] Pass external callchain entry to get_perf_callchain
Date: Tue, 14 Oct 2025 18:01:26 +0800
Message-ID: <20251014100128.2721104-1-chen.dylane@linux.dev>
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
If the above changes are reasonable, it seems that get_callchain_entry_for_task
could also use an external perf_callchain_entry.

But I'm not sure if this modification is appropriate. After all, the
implementation of get_callchain_entry in the perf subsystem seems much more
complex than directly using an external buffer.

Comments and suggestions are always welcome.

Change list:
 - v1 -> v2
   From Jiri
   - rebase code, fix confict
 - v1: https://lore.kernel.org/bpf/20251013174721.2681091-1-chen.dylane@linux.dev

Tao Chen (2):
  perf: Use extern perf_callchain_entry for get_perf_callchain
  bpf: Pass external callchain entry to get_perf_callchain

 include/linux/perf_event.h |  4 ++--
 kernel/bpf/stackmap.c      | 19 +++++++++++--------
 kernel/events/callchain.c  | 13 +++++++++----
 kernel/events/core.c       |  2 +-
 4 files changed, 23 insertions(+), 15 deletions(-)

-- 
2.48.1

