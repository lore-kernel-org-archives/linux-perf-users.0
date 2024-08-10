Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A504552F88;
	Sat, 10 Aug 2024 19:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723317426; cv=none; b=nVAWMqRtfHm3uuCDg0fSvNGdpvIKpBGj9hlbCjZgI4uqAbSms4d+87ZCqUMNbR1Med0lSaMKqzcE9UqCowSucCpCwDKXjaeQFrx/KzwNYvXPTu98VKV2miK0f6E2KdARyNXTcWnoPetvsCwuNp4c/cen9x66k38xd/Qx5CrFkAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723317426; c=relaxed/simple;
	bh=DrfiZ87KnciqJiOypxyxPHEBjB8boZVAzVZhPjg0CVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HrhIb/UTOiZI/R6BZBx4Ca+mcEiWwKvoDzlIrvPrA7C9LlzowQHkbAfKWITMzHm8si4w1I/vTm+cot0e1uE+ydIAkrvgXBGH3G9iWrpC3+dHoR3iAt1SxD6RQOq6EWjr3idTCyM8cJQT1/lbky7tdBKhG7MTPoG5EJUGsj+y9UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8UOI6gP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8UOI6gP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB516C4AF0C;
	Sat, 10 Aug 2024 19:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723317426;
	bh=DrfiZ87KnciqJiOypxyxPHEBjB8boZVAzVZhPjg0CVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N8UOI6gPfmNMLRrfRiDnCeomw+rJtd3X///YwfGyMtqUUpK/Gppu38Q4AvoX1u/8H
	 bZGKOUjBV+jtSQVPawZA09vb8b8teNuarP4+K/b+EaiL7Zlda9apUaMKxlx7HDUzxG
	 x6L3IkTn4DHxFs61VheKoFTega4q5RqFk9zx2vV34PdetF0O0kv7nd+98tBLikwhuV
	 SjYm0rDekpVPsVDwVg83NGXNIJNUioG464aa8lTFevS89e+QkK65bMIF4UGXxmNWVH
	 ZrkjyeM+8UtzYp+CH3RuYH0cSyuQOk8qGTrsB5C70XKl7W8dSY0RMoceUvLxYmTjHE
	 yLLSmDotiUxxw==
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
Subject: [PATCH] perf lock contention: Change stack_id type to s32
Date: Sat, 10 Aug 2024 12:17:04 -0700
Message-ID: <20240810191704.1948365-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
In-Reply-To: <909abbc8-efca-40df-9876-8c36b6942a83@stanley.mountain>
References: <909abbc8-efca-40df-9876-8c36b6942a83@stanley.mountain>
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
 tools/perf/util/bpf_skel/lock_data.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
-- 
2.46.0.76.ge559c4bf1a-goog

