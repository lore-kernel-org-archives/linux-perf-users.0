Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981FD3A7585;
	Sun,  3 May 2026 19:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777836707; cv=none; b=eVjmqnPWMgJDozX0LaEoGbpcgcVHPgxqKQEW7oexInRr/0q559pvoL6T62hOkT16KJF+k4Z3NG/vMJageZ94ij+fYDx6qKcUvh6a+8VwFb8ziq6fsnz7U3cZjJAxPWKNOOmdSdaFl/xexXIX2m56AKL8lZi4agg1hVDYk053odQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777836707; c=relaxed/simple;
	bh=+uNzf2qgr4C3sW8Ogf+nC1N8Nw6K51IIbYOW1sv3qkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EI0QKDoEqmXH6YM0bd5q7oZTCJyha6n3OKH0OfOSBlQr0W+W8GZPMQw8WzEJSrsLF8hxihfj7PskJ2MN4WOCNdAz38RuhFMH24A4qiwmfo7hR9CpqupJ2ZtQiAbHRnA2cNB/3m/LGt1kGCkyi4rFxe1E71yCEAmdxskvwuTZl78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUCW42+O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUCW42+O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE18C2BCB4;
	Sun,  3 May 2026 19:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777836707;
	bh=+uNzf2qgr4C3sW8Ogf+nC1N8Nw6K51IIbYOW1sv3qkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kUCW42+O/cT+OfSjUOUzrHoycRJ46kIafYBKGloYMDxcD3o6K8QSSdaPo1ODcGmpR
	 iQWtzJDDZptU826A/snuZbrQpp48+1DlpwbVNX7Q/6TUxdeLYCUexkAq9UIAjFi8f+
	 iA/L8Yf0hmLHS1ZkSNYfh6yBjs0dGS5GaPl8N/dTxj5SrKGYAkacqDCw/ON8ltQCmk
	 /RbxkNdJ1EWox8P88Nub032DaDYEf1b/II4cJzrfPauB7uAccFnFhqNBXd5cKSednt
	 v9iGC1A2USkXH2lO+Iw+g2akvvLA/eJZFHzQ5QFn8tAD7+utqRSPsj80IVq4YJV1Y/
	 PKt6eQQxHsa6g==
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
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/5] perf trace: Sync uapi/linux/mount.h with the kernel source
Date: Sun,  3 May 2026 12:31:35 -0700
Message-ID: <20260503193137.27465-4-namhyung@kernel.org>
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

 5e8969bd19271241 ("mount: add FSMOUNT_NAMESPACE")

This would be used to beautify mount syscall arguments and not to
affect builds of other tools (e.g. objtool).

Please see tools/include/uapi/README.

Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/trace/beauty/include/uapi/linux/mount.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/trace/beauty/include/uapi/linux/mount.h b/tools/perf/trace/beauty/include/uapi/linux/mount.h
index d9d86598d100cb32..2204708dbf7a583a 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/mount.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/mount.h
@@ -110,6 +110,7 @@ enum fsconfig_command {
  * fsmount() flags.
  */
 #define FSMOUNT_CLOEXEC		0x00000001
+#define FSMOUNT_NAMESPACE	0x00000002	/* Create the mount in a new mount namespace */
 
 /*
  * Mount attributes.
-- 
2.53.0

