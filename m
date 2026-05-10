Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A75733260D;
	Sun, 10 May 2026 20:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778444638; cv=none; b=cCLVCBKrQZn1gLUKArLzZKExcnr5RWcBSVLweyORANdtBxAQ1pPRyCzs34JzELACNmNYndHcbhZHc99FW3T5I3RGLNKAAQtLS98f6XYaWYut1txzhJIq0GZ096kSQXHZmvm2jp4JbiVSl6U8HqDijuK+185SQYF3eLNoOD1kPrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778444638; c=relaxed/simple;
	bh=EzcH4zCfibIGQA+MAp7Y4fTdv3Qb8y8GVLWP4zVVZno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HYZsa6V3Muy7+hqeW6+ZUYQIAh3bX5d02Jji5A14yN3lzitLjAfMLeINDr0n4sGk8hhzTnfzJjIbqCozdITkV/1s9F6Yk2K5oCyMbQn4GQDd6o3git1jjSZsuEzYRImQiO6Al+u24SQcFHENsLme2Uatqz6jtB4fgxLJYTbKaQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=totb0w7K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="totb0w7K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A11C2BCFB;
	Sun, 10 May 2026 20:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778444638;
	bh=EzcH4zCfibIGQA+MAp7Y4fTdv3Qb8y8GVLWP4zVVZno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=totb0w7KTjCN9h2tYa2se0gMR1VOYjCNbYcfyKCGiNAXI779xGSe0pcSs8xoCPvEL
	 TxmnRFYMHpppC0iEBSy1vOGk0kP0MB5/qy9frGgmAPHylBMXZMy1kKTLnfx1ucXitZ
	 e7wPfyydHmWLq+N4wtdebl0V/NgwydssbZSlOPbrToFXuSNvaVFnU7pIO0r4MOBDmG
	 K7E77Utefe6nIIGauQwdf+jHzZ5QZ3RomqNKjKw3clWjskx/kNDPZnqY6zR7nOM1oG
	 gLESHO08W60cTJz7yXTT71Nkq3DKZm6pTwdi97WYcKCJzkWU2OXVnXHqldPqqgSJIv
	 +Qw7jKtgI9Ztg==
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
	Ravi Bangoria <ravi.bangoria@amd.com>
Subject: [PATCH v3 7/7] perf trace: Update beautifier script for clone flags
Date: Sun, 10 May 2026 13:23:46 -0700
Message-ID: <20260510202346.49853-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510202346.49853-1-namhyung@kernel.org>
References: <20260510202346.49853-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the change in the sched.h, update the script to generate
the flags array like below.  Note that '+1' is needed to detect bitmask
pattern at index 0.

  $ cat tools/perf/trace/beauty/generated/clone_flags_array.c
  static const char *clone_flags[] = {
  	[ilog2(0x00000100) + 1] = "VM",
  	[ilog2(0x00000200) + 1] = "FS",
  	[ilog2(0x00000400) + 1] = "FILES",
  	[ilog2(0x00000800) + 1] = "SIGHAND",
  	[ilog2(0x00001000) + 1] = "PIDFD",
  	[ilog2(0x00002000) + 1] = "PTRACE",
  	[ilog2(0x00004000) + 1] = "VFORK",
  	[ilog2(0x00008000) + 1] = "PARENT",
  	[ilog2(0x00010000) + 1] = "THREAD",
  	[ilog2(0x00020000) + 1] = "NEWNS",
  	[ilog2(0x00040000) + 1] = "SYSVSEM",
  	[ilog2(0x00080000) + 1] = "SETTLS",
  	[ilog2(0x00100000) + 1] = "PARENT_SETTID",
  	[ilog2(0x00200000) + 1] = "CHILD_CLEARTID",
  	[ilog2(0x00400000) + 1] = "DETACHED",
  	[ilog2(0x00800000) + 1] = "UNTRACED",
  	[ilog2(0x01000000) + 1] = "CHILD_SETTID",
  	[ilog2(0x02000000) + 1] = "NEWCGROUP",
  	[ilog2(0x04000000) + 1] = "NEWUTS",
  	[ilog2(0x08000000) + 1] = "NEWIPC",
  	[ilog2(0x10000000) + 1] = "NEWUSER",
  	[ilog2(0x20000000) + 1] = "NEWPID",
  	[ilog2(0x40000000) + 1] = "NEWNET",
  	[ilog2(0x80000000) + 1] = "IO",
  	[ilog2(0x00000080) + 1] = "NEWTIME",
  	[32 + 1] = "CLEAR_SIGHAND",
  	[33 + 1] = "INTO_CGROUP",
  	[34 + 1] = "AUTOREAP",
  	[35 + 1] = "NNP",
  	[36 + 1] = "PIDFD_AUTOKILL",
  	[37 + 1] = "EMPTY_MNTNS",
  };

This was found by Sashiko during review.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/trace/beauty/clone.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/trace/beauty/clone.sh b/tools/perf/trace/beauty/clone.sh
index 18b6c0d75693721d..98cb1f8d4a6ffd62 100755
--- a/tools/perf/trace/beauty/clone.sh
+++ b/tools/perf/trace/beauty/clone.sh
@@ -14,4 +14,8 @@ regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+CLONE_([^_]+[[:alnum:]_]+)[[:
 grep -E $regex ${linux_sched} | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n"
+regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+CLONE_([^_]+[[:alnum:]_]+)[[:space:]]+\(1ULL[[:space:]]*<<[[:space:]]*([[:digit:]]+)\)[[:space:]]*.*'
+grep -E $regex ${linux_sched} | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	xargs printf "\t[%s + 1] = \"%s\",\n"
 printf "};\n"
-- 
2.54.0

