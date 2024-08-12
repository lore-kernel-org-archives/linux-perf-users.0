Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDBD1804F;
	Mon, 12 Aug 2024 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723483535; cv=none; b=O2J8XhNmnxRkald4f3HUDO6p7xLVq4Qq5jQiVUPN3QSahf5k1ItdZrBlbCXN0/9Lah8q9Su/1hSEgLnlRTWIF54oSJz9JJkfMQCo5+TcLRYrIg1kngUeradMFjmshb3je8PiYu6YoC97bcCdIJhLqqMXPfIh8zQoE0+cJXuHcEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723483535; c=relaxed/simple;
	bh=4QgLVYNSEIKhcZgTiNhe32pMH7y8AEFi57gzonoOC5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ncWPSTNcBjEoWf3FEqc0OZhEEFks5sHmHQT2KYiVUKlNwYLIXCLU3lt4Z9Xm3Ex3gbOOwwp8NZC8kHEuBGNsnK4hTI7owERCMgpHSj/XeCeoTPikv+8j7dVH8Say42X9L4wpqm/mBsGZ9Z8ydyEoaVoMIiun1sf3LKfEHKq95jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMU+oZ9M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMU+oZ9M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE8AC32782;
	Mon, 12 Aug 2024 17:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723483535;
	bh=4QgLVYNSEIKhcZgTiNhe32pMH7y8AEFi57gzonoOC5E=;
	h=From:To:Cc:Subject:Date:From;
	b=MMU+oZ9MWxywldvMUt06X5SFaccEP6VVYPvuntlt5KDd8qhPvXdYPyy2/FhlRV75F
	 TyOXQx1ASZbNZQTLi2HcJftpjYRF/68NGWwZ98qRhFdYCyfe1CnB0kt/zaDPgBUNl8
	 j8YVayJUkd1s4RfvlBQEbMpfOXENO7srXKPlOV/3l97a1iswTjEv0CPSa46BgadNqq
	 eNHkSK7J7ligVlv1O/UM3ZhHM8gutsg4oVYB+wrhHz7B6oVh2tSAQSGzg9uXMig2qw
	 /zDh+CZr1AMfrH9h7VRW18f1HliM1m6XQO5CWVy0SJwNF6suwcGtag5FqZTtwMTYUl
	 5pZ0zEUfMQyBQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v2] perf lock contention: Change stack_id type to s32
Date: Mon, 12 Aug 2024 10:25:33 -0700
Message-ID: <20240812172533.2015291-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bpf_get_stackid() helper returns a signed type to check whether it
failed to get a stacktrace or not.  But it saved the result in u32 and
checked if the value is negative.

      376         if (needs_callstack) {
      377                 pelem->stack_id = bpf_get_stackid(ctx, &stacks,
      378                                                   BPF_F_FAST_STACK_CMP | stack_skip);
  --> 379                 if (pelem->stack_id < 0)

  ./tools/perf/util/bpf_skel/lock_contention.bpf.c:379 contention_begin()
  warn: unsigned 'pelem->stack_id' is never less than zero.

Let's change the type to s32 instead.

Fixes: 6d499a6b3d90 ("perf lock: Print the number of lost entries for BPF")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
v2) fix build error for s32

 tools/perf/util/bpf_skel/lock_data.h       | 4 ++--
 tools/perf/util/bpf_skel/vmlinux/vmlinux.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_skel/lock_data.h
index 36af11faad03..de12892f992f 100644
--- a/tools/perf/util/bpf_skel/lock_data.h
+++ b/tools/perf/util/bpf_skel/lock_data.h
@@ -7,11 +7,11 @@ struct tstamp_data {
 	u64 timestamp;
 	u64 lock;
 	u32 flags;
-	u32 stack_id;
+	s32 stack_id;
 };
 
 struct contention_key {
-	u32 stack_id;
+	s32 stack_id;
 	u32 pid;
 	u64 lock_addr_or_cgroup;
 };
diff --git a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
index e9028235d771..d818e30c5457 100644
--- a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
+++ b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
@@ -15,6 +15,7 @@
 
 typedef __u8 u8;
 typedef __u32 u32;
+typedef __s32 s32;
 typedef __u64 u64;
 typedef __s64 s64;
 
-- 
2.46.0.76.ge559c4bf1a-goog

