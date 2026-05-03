Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0173A7826;
	Sun,  3 May 2026 19:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777836708; cv=none; b=bb4+4TI8CZX/3QKK4CmEFyoVucVgdI2Y1M3p9Zk2kn36iYE8rSWVexvkgfnwoEHceJS6rS+X+XpEo8lpBpRlEOJ1YHsmijhlc/PT5Ps/9HB5z1SW96FRmdw8yu9BI1lPnSCXfbrNmlhpT2XSmauEHb9YdZFpQF1kxoJDAt93Hj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777836708; c=relaxed/simple;
	bh=GV3Fx7ZQMA338Q0paG9OPf46qNRFaHQ/XB0rX7K28MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BM7DSFvMENuMqRO0rykr4mzx/JjfzA62WWRw8HorTiiKlLBdLgzvWaWkenWd1dlqCXIyeo+ikDsNzoaVsBieSo5mnn/fLFdjAb0b0dmhpsPOlku6ZaEXxcTUxeRTtHbernTjTQY4Hq6+LIvBOVooM1Z9RWW5bW6VcIntWfyWpIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jw1E7xr2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jw1E7xr2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761F7C2BCB8;
	Sun,  3 May 2026 19:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777836707;
	bh=GV3Fx7ZQMA338Q0paG9OPf46qNRFaHQ/XB0rX7K28MM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jw1E7xr2Dns7L1clCr0nYEFM3n5eWRb6P+jH5H2EI2e3gjIfeZ9AB1bbF+Lt0zD0S
	 kxIxXgtby4LEjYkpDP9FehaKoSbCpgPWgD/aw4+CmMkXCaQh2Q7Oy0fb/lKRdysoHA
	 bEmtwNnad4/ohtJe2d1FXdWjyyF4qhbeDqgXycZM57bp6x1BTPjxFcQbHL6U/olbXF
	 0v5Bq+eC31WTiKWJv9G09Eg5qrDsZzSNWvLxnPTDus6c1lXytX971/NGjO1fbI4f/S
	 63im6y1No5zFPeetL1hodGzTGScUddQO2+dQRzqAmpLCStXOPDfNLDVEd+1lP0W9ff
	 G3j2mvVhGxnFA==
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
Subject: [PATCH 4/5] perf trace: Sync uapi/linux/sched.h with the kernel source
Date: Sun,  3 May 2026 12:31:36 -0700
Message-ID: <20260503193137.27465-5-namhyung@kernel.org>
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

 9d4e752a24f740b3 ("namespace: allow creating empty mount namespaces")
 c8134b5f13ae959d ("pidfd: add CLONE_PIDFD_AUTOKILL")
 24baca56fafc33d4 ("clone: add CLONE_NNP")
 12ae2c81b21cfaa1 ("clone: add CLONE_AUTOREAP")
 2e7af192697ef2a7 ("sched/deadline: Add reporting of runtime left & ...")

This would be used to beautify scheduler syscall arguments and not to
affect builds of other tools (e.g. objtool).

Please see tools/include/uapi/README.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 .../trace/beauty/include/uapi/linux/sched.h     | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/perf/trace/beauty/include/uapi/linux/sched.h b/tools/perf/trace/beauty/include/uapi/linux/sched.h
index 359a14cc76a4038a..33a4624285cd4179 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/sched.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/sched.h
@@ -34,8 +34,12 @@
 #define CLONE_IO		0x80000000	/* Clone io context */
 
 /* Flags for the clone3() syscall. */
-#define CLONE_CLEAR_SIGHAND 0x100000000ULL /* Clear any signal handler and reset to SIG_DFL. */
-#define CLONE_INTO_CGROUP 0x200000000ULL /* Clone into a specific cgroup given the right permissions. */
+#define CLONE_CLEAR_SIGHAND	(1ULL << 32) /* Clear any signal handler and reset to SIG_DFL. */
+#define CLONE_INTO_CGROUP	(1ULL << 33) /* Clone into a specific cgroup given the right permissions. */
+#define CLONE_AUTOREAP		(1ULL << 34) /* Auto-reap child on exit. */
+#define CLONE_NNP		(1ULL << 35) /* Set no_new_privs on child. */
+#define CLONE_PIDFD_AUTOKILL	(1ULL << 36) /* Kill child when clone pidfd closes. */
+#define CLONE_EMPTY_MNTNS	(1ULL << 37) /* Create an empty mount namespace. */
 
 /*
  * cloning flags intersect with CSIGNAL so can be used with unshare and clone3
@@ -43,6 +47,12 @@
  */
 #define CLONE_NEWTIME	0x00000080	/* New time namespace */
 
+/*
+ * unshare flags share the bit space with clone flags but only apply to the
+ * unshare syscall:
+ */
+#define UNSHARE_EMPTY_MNTNS 0x00100000 /* Unshare an empty mount namespace. */
+
 #ifndef __ASSEMBLY__
 /**
  * struct clone_args - arguments for the clone3 syscall
@@ -146,4 +156,7 @@ struct clone_args {
 			 SCHED_FLAG_KEEP_ALL		| \
 			 SCHED_FLAG_UTIL_CLAMP)
 
+/* Only for sched_getattr() own flag param, if task is SCHED_DEADLINE */
+#define SCHED_GETATTR_FLAG_DL_DYNAMIC	0x01
+
 #endif /* _UAPI_LINUX_SCHED_H */
-- 
2.53.0

