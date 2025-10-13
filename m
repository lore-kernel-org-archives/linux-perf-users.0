Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CE027FD52
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Oct 2025 17:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377690; cv=none; b=U1t79aNaANkIEn5PbCtMNChpjXVX5nGUpVQ+H5uyWKH3j1OSp/a7t0a+Q5OL/M79cHz6oDgCTjLVVLs/1phzwQ/f2hCuyB29eEinvI64DU7ZGFGJhUesYHq/d/3ak03hYhnPPxyPmm3O5ZMZGmFod8lErguXunvaj0aglXvdu1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377690; c=relaxed/simple;
	bh=Fz2Z0NVg/DpxS1jweNIyZgePAu4cm4J9w/NK89KwvTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PRRWTICq29A6VVEX5u9zC09BQJ3G2mAKvv+uzM2Ggx9F9rd5+GyB/fpCIBHN9i9rOVX+AOr9faWgXQDE8b8rjkX12ktm9G2Q4sQl3un+Kkr5XPVyqc4qjYJyXtk3Di2vQMj9vnO/xSf1/V2ZqUHI34aZjfk0Q9ZGK7pwBF3E+dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VxzJxKIC; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VxzJxKIC"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760377675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dQog++Z4DABPXGobwnLJdN42FYEo1zhiAYhURAKlFOI=;
	b=VxzJxKICuu2V++rKVk+ZLlHlcziBjDWagVThwUkaCtfBN/Y7aJ0ivBFRXpZz05k6xpy8c5
	xR4H4gPdQuOcUUiTsAeWifhnn4AV1wthnL304+12V5T7qzviNz329dKXh4BjsI7Q4e5pZd
	keogQh+6AEcYloTIOsY1Y3ZrscMkOnk=
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
Subject: [PATCH bpf-next RFC 0/2] Pass external callchain entry to get_perf_callchain
Date: Tue, 14 Oct 2025 01:47:19 +0800
Message-ID: <20251013174721.2681091-1-chen.dylane@linux.dev>
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

Tao Chen (2):
  perf: Use extern perf_callchain_entry for get_perf_callchain
  bpf: Pass external callchain entry to get_perf_callchain

 include/linux/perf_event.h |  5 +++--
 kernel/bpf/stackmap.c      | 19 +++++++++++--------
 kernel/events/callchain.c  | 18 ++++++++++++------
 kernel/events/core.c       |  2 +-
 4 files changed, 27 insertions(+), 17 deletions(-)

-- 
2.48.1

