Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF25633C513;
	Thu, 26 Feb 2026 01:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772070598; cv=none; b=oAVuxPCj3MhqBJQLlETb3UhgABRdlV50wsfQaWm9H8NendDF/kM8sopVeuGutcj9t4/BR6ZHYRBhGxEpqTVt9b6SPQGDFxJeg+grP4yynGhoe41UezjrMZGICGqDwUfny9EFJxzA5cR8Jc7yFLFXec4zevNVoCYDw44KYgHAwSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772070598; c=relaxed/simple;
	bh=090HP7e2pVEeHOHgtSokHePn6/kBbzFR3kfoeGd59q8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KTEsvt1FKhg6neDe8lBl2eHN/Snoz104NBe+gATl73heILCyME1o/CoMYZyjeOSU9XqdOCklwzxQNbIOrPGSoHGRe6sjgGT1MJk/E2zAjo0cc/yLTQ9un7Nti0hyuMbsdJV1YDzuZOwrWIs9+IVHD8ucCLB4fCgwlKnsK/yKtCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFk8tyeR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFk8tyeR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3679C116D0;
	Thu, 26 Feb 2026 01:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772070597;
	bh=090HP7e2pVEeHOHgtSokHePn6/kBbzFR3kfoeGd59q8=;
	h=From:To:Cc:Subject:Date:From;
	b=qFk8tyeRn0mRx90MVGlvqfGpkOsGZgn3SB9DGHhTZAxNYPEUsMpAX8Ns6uNWl2KUe
	 G0a5MQBcwC1/ec/THpDjRxF1AWE6vrYrwl6/ewEFBmZa6PJ0cXgeuVHjPnrk0V7AVG
	 FQ1npifmM3w7HW7ABdjcI9fRy+Q88iL+lwziPHJ2WbmtMVerF/uRcOnqfkV+m/Wq2E
	 Gfruu08II4Enk9fmtxWUwF9bl5NtzmDsmX4amd3FLCNKuMkCO11QQUnVxqNJ6xI0TA
	 MylIGhN4t3RnzdZFCB2fpTObchaW2Clq8UWeje9ixyOWyCiDDrsyQQQKNg63caBA+f
	 qX2+aYXlpr3Bg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH] perf trace: Handle task exit in BPF syscall summary
Date: Wed, 25 Feb 2026 17:49:55 -0800
Message-ID: <20260226014955.801293-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some system calls never return because it'd terminate the calling
thread.  Let's hook the task exit path and update the duration of the
last syscall.

Before:
  $ sudo perf trace -as --bpf-summary -- true |& grep exit
  (nothing)

After:
  $ sudo perf trace -as --bpf-summary -- true |& grep exit
     exit_group             1      0     0.004     0.004     0.004     0.004      0.00%

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_skel/syscall_summary.bpf.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/bpf_skel/syscall_summary.bpf.c b/tools/perf/util/bpf_skel/syscall_summary.bpf.c
index 1bcd066a5199a476..4172f3c9fc483955 100644
--- a/tools/perf/util/bpf_skel/syscall_summary.bpf.c
+++ b/tools/perf/util/bpf_skel/syscall_summary.bpf.c
@@ -118,13 +118,11 @@ int sys_enter(u64 *ctx)
 	return 0;
 }
 
-SEC("tp_btf/sys_exit")
-int sys_exit(u64 *ctx)
+static int do_exit(long ret)
 {
 	int tid;
 	int key = 0;
 	u64 cgroup = 0;
-	long ret = ctx[1]; /* return value of the syscall */
 	struct syscall_trace *st;
 	s64 delta;
 
@@ -150,4 +148,18 @@ int sys_exit(u64 *ctx)
 	return 0;
 }
 
+SEC("tp_btf/sys_exit")
+int sys_exit(u64 *ctx)
+{
+	long ret = ctx[1]; /* return value of the syscall */
+
+	return do_exit(ret);
+}
+
+SEC("tp_btf/sched_process_exit")
+int process_exit(u64 *ctx)
+{
+	return do_exit(0);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.53.0.414.gf7e9f6c205-goog

