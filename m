Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FDF33F597;
	Sun, 10 May 2026 20:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778444636; cv=none; b=Wpptu+ls91m5oUfxVqVRIxzgJJMNfo0+um0PUNcRRm2iyyYxshLvA1ysNcN9LsWwb0PtVqquEeMsH2ngZcuYOfowBadWuOlur9OBVve2v6Fz2Z72DEdRUZDYu0mZMr8jf/7B0RWdBLwHlDzvPZT1dm3lBGzbqbyRuBb6nNuqZhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778444636; c=relaxed/simple;
	bh=7U7Sa8RXkBuqtZzyl4O0KvHvcBdgBsln7oeWWoKC49A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHabep58i7J9aaaTrElFFSpgkVRWVt0u/qi3sRe83Zt1NjiBFg8DdOKzZEQxF4s249VSRVU32f8aadbrr6zZ2jImFUm3sV74Ds1jjNp0fvCnaJD3jLm0KLBNWdMGhgj7MwgALDQ/USx3wHSZxfkDfNdgUy4t4BJrxxLwol31xgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SD4zNfyp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SD4zNfyp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF51C2BCF7;
	Sun, 10 May 2026 20:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778444636;
	bh=7U7Sa8RXkBuqtZzyl4O0KvHvcBdgBsln7oeWWoKC49A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SD4zNfypQ8lTe7J8hymnTGJUUdWpg9b+iXajMRWzheCPyFx4MWFMyaHlGAlDx7atM
	 d+Vx3fKyG3cBru0ILZqoPEOKzQV3J161U+O/ZO3CQuNClgKMeKqzgbfWqrC/U4SXpe
	 oO//CFuf2oPSS+j/DwyE6u3U/KSLfNfDBaVSbVG3ZrxtVYvtUjc/xfRdrURxypQiEm
	 4Iwvu2UmARSVx5mvxaMfcwINaVzd/mcxI8zhTHw5XO6mR89FfRzDAT9Fw4dRGgnXuC
	 +7je7b/ydaiQwaGjINJDKimseJZfbd3+EYFy2+rohI3m7acgfJCl+5moxlTR3dHJSL
	 10sesowK1cEVw==
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
Subject: [PATCH v3 4/7] perf trace: Sync uapi/linux/sched.h with the kernel source
Date: Sun, 10 May 2026 13:23:43 -0700
Message-ID: <20260510202346.49853-5-namhyung@kernel.org>
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
2.54.0

