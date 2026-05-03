Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3DC2D7BF;
	Sun,  3 May 2026 19:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777836706; cv=none; b=tEsDoh8iNKnXq6vdACJPXrR+mEZwKWKXi1u+ryh6u9bADFTONpR80gbqhAStiHwNdW0pkyQxwxhWtxtU/g9/7Q8S3FVVn0ibkwcphFQ6x3diWGmjW2QKTIRK6dBMkoe3eSj8C/R2KSpgWCH+rjA2syGjxsGVduzD6cZIE0hbYho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777836706; c=relaxed/simple;
	bh=vZqA9cAhuBFLO+64bSaU4f5yvGMLGVVYFVQOut7Yf/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V158TegC8aLZIDmPfufn7VXeepkOkFGTJLbkqlPAhlqo6LIVNPMXE8umfVc+jeAu4q2ecd2Dtf9YGt7Gwjlops44Fx2FjKAd3Lsy59ErC5kqjnDM8+1jvVEnpvzHvyf47Xue3he0E9NzG5Uxlj9tjbN6gQDEufTwei1t2QdXvaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USbSkpeK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USbSkpeK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8881FC2BCB8;
	Sun,  3 May 2026 19:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777836706;
	bh=vZqA9cAhuBFLO+64bSaU4f5yvGMLGVVYFVQOut7Yf/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=USbSkpeKLZt9ui/k6+fq6eUBM/R7AbBWg6EGK2mziAVhDXFKSEaPWik9LB/2DkDRk
	 oVuIr3lZpLy1GwRSuBhS24+e2Xq0fy/RCnUsqjqkfp1tWXBMldsSxTnvtckeJHSfkx
	 1BiuaDrvKRMH9bq2A2qE3/zrHYc0WvYABJG/KYkwcVAjncqpmHKfaRkH1mf1EifpCH
	 9qh7wQU+SK68Ua36EiqPrN5138403zxofXXmfuH0p5RplwHB09mwwWyZdrNa7ahd6O
	 5bAyIroethn1W0HaZXTpWrfLDMzidnHuhThf9OIBY3112AdVL/Drk8QKtbSuBB8fG2
	 FfqEa0BNm0JfA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	netdev@vger.kernel.org
Subject: [PATCH 1/5] perf trace: Sync linux/socket.h with the kernel source
Date: Sun,  3 May 2026 12:31:33 -0700
Message-ID: <20260503193137.27465-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260503193137.27465-1-namhyung@kernel.org>
References: <20260503193137.27465-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up changes from:

 c66e0f453d1afa82 ("net: use ktime_t in struct scm_timestamping_internal")

This would be used to beautify networking syscall arguments and not to
affect builds of other tools (e.g. objtool).

Please see tools/include/uapi/README.

Cc: netdev@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/trace/beauty/include/linux/socket.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/include/linux/socket.h b/tools/perf/trace/beauty/include/linux/socket.h
index ec715ad4bf25f5f7..ec4a0a0257939a53 100644
--- a/tools/perf/trace/beauty/include/linux/socket.h
+++ b/tools/perf/trace/beauty/include/linux/socket.h
@@ -415,7 +415,7 @@ struct __kernel_timespec;
 struct old_timespec32;
 
 struct scm_timestamping_internal {
-	struct timespec64 ts[3];
+	ktime_t ts[3];
 };
 
 extern void put_cmsg_scm_timestamping64(struct msghdr *msg, struct scm_timestamping_internal *tss);
-- 
2.53.0

