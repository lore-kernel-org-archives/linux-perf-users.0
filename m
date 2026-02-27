Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D3836BCC5;
	Fri, 27 Feb 2026 12:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772194379; cv=none; b=PhhSbFBCoXgWYUVaP5ZSjyQF5fcJpY6gjbccPPx8lbJ/PBTRQQaaoE7EZ5VC6AcVgghap9bOXWD7NQtVsvQ4uE8npvY5+qMdFQAoelquJY1CVDcbylTC4fB2biklHay6lt94PdCvwsSXOlnGMnfVFIaPuPfj4NwolfHr80GWYfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772194379; c=relaxed/simple;
	bh=1b12QwrTFuaFMK65iudi0TD6xfpVQk6e2QGzUgCaomE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OLSaWuEY1twHaBruyY6ltLZUDuupNIElBklRfbzLKCMwbPRJZqW6cn/Pm2JQ8L09OamRLJB4qmwRgiNQTZKp3gr0JYf8M34ehwP89meGuQDYRM01Eybf86fWkkV/05Tx7q6uKAFCzVE1I6Irw6t2/u021Ajcv/3UFrzzdvdU93E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g82clZ8n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g82clZ8n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE181C19423;
	Fri, 27 Feb 2026 12:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772194378;
	bh=1b12QwrTFuaFMK65iudi0TD6xfpVQk6e2QGzUgCaomE=;
	h=Date:From:To:Cc:Subject:From;
	b=g82clZ8nyW8ZBS18pbN4mtMtEuS8gjhpPmlc3CZyGDxu+3JmFUF6Ii3cR5kyPP1za
	 1WOhZReBWLgZsYrNowPt8XsjxpN0KdJbCXjszLy/KlNMMnuPiuI3RJYRXi3M3rYU5o
	 enhxRv8CoYQ01L4JGrpxS3FOiVwbIQWRPSbe0sRuSlWMBmoJlQMkICzfP3Y89PbACk
	 0KxxK5XmIq4A9TacnMA6XaDrnskcDy8spYsPZ7UaFYBLITyrCdfpvRiSz0im6hWsFK
	 v0livD5qqBMRlaLQWXD5P1V+SLxLx5NhJU6YQUOirQjheYwc+dzn24KD9LNaS77ZL4
	 y6e7rMorEerTQ==
Date: Fri, 27 Feb 2026 09:12:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Deepak Gupta <debug@rivosinc.com>, Paul Walmsley <pjw@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1 fyi] tools headers: Sync uapi/linux/prctl.h with the
 kernel source
Message-ID: <aaGKRtZzQxXJ6ltD@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tldr; Just FYI, I'm carrying this on the perf tools tree.

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

See further details at:

 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/include/uapi/README

To pick up the changes in these csets:

  5ca243f6e3c30b97 ("prctl: add arch-agnostic prctl()s for indirect branch tracking")
  28621ec2d46c6adf ("rseq: Add prctl() to enable time slice extensions")

That don't introduced these new prctls:

  $ tools/perf/trace/beauty/prctl_option.sh > before.txt
  $ cp include/uapi/linux/prctl.h tools/perf/trace/beauty/include/uapi/linux/prctl.h
  $ tools/perf/trace/beauty/prctl_option.sh > after.txt
  $ diff -u before.txt after.txt
  --- before.txt	2026-02-27 09:07:16.435611457 -0300
  +++ after.txt	2026-02-27 09:07:28.189816531 -0300
  @@ -73,6 +73,10 @@
   	[76] = "LOCK_SHADOW_STACK_STATUS",
   	[77] = "TIMER_CREATE_RESTORE_IDS",
   	[78] = "FUTEX_HASH",
  +	[79] = "RSEQ_SLICE_EXTENSION",
  +	[80] = "GET_INDIR_BR_LP_STATUS",
  +	[81] = "SET_INDIR_BR_LP_STATUS",
  +	[82] = "LOCK_INDIR_BR_LP_STATUS",
   };
   static const char *prctl_set_mm_options[] = {
   	[1] = "START_CODE",
  $

That now will be used to decode the syscall option and also to compose
filters, for instance:

  [root@five ~]# perf trace -e syscalls:sys_enter_prctl --filter option==SET_NAME
       0.000 Isolated Servi/3474327 syscalls:sys_enter_prctl(option: SET_NAME, arg2: 0x7f23f13b7aee)
       0.032 DOM Worker/3474327 syscalls:sys_enter_prctl(option: SET_NAME, arg2: 0x7f23deb25670)
       7.920 :3474328/3474328 syscalls:sys_enter_prctl(option: SET_NAME, arg2: 0x7f23e24fbb10)
       7.935 StreamT~s #374/3474328 syscalls:sys_enter_prctl(option: SET_NAME, arg2: 0x7f23e24fb970)
       8.400 Isolated Servi/3474329 syscalls:sys_enter_prctl(option: SET_NAME, arg2: 0x7f23e24bab10)
       8.418 StreamT~s #374/3474329 syscalls:sys_enter_prctl(option: SET_NAME, arg2: 0x7f23e24ba970)
  ^C[root@five ~]#

This addresses these perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/perf/trace/beauty/include/uapi/linux/prctl.h include/uapi/linux/prctl.h

Please see tools/include/uapi/README for further details.

Cc: Deepak Gupta <debug@rivosinc.com>
Cc: Paul Walmsley <pjw@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../trace/beauty/include/uapi/linux/prctl.h   | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/perf/trace/beauty/include/uapi/linux/prctl.h b/tools/perf/trace/beauty/include/uapi/linux/prctl.h
index 51c4e8c82b1e9889..55b0446fff9d95ab 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/prctl.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/prctl.h
@@ -386,4 +386,41 @@ struct prctl_mm_map {
 # define PR_FUTEX_HASH_SET_SLOTS	1
 # define PR_FUTEX_HASH_GET_SLOTS	2
 
+/* RSEQ time slice extensions */
+#define PR_RSEQ_SLICE_EXTENSION			79
+# define PR_RSEQ_SLICE_EXTENSION_GET		1
+# define PR_RSEQ_SLICE_EXTENSION_SET		2
+/*
+ * Bits for RSEQ_SLICE_EXTENSION_GET/SET
+ * PR_RSEQ_SLICE_EXT_ENABLE:	Enable
+ */
+# define PR_RSEQ_SLICE_EXT_ENABLE		0x01
+
+/*
+ * Get the current indirect branch tracking configuration for the current
+ * thread, this will be the value configured via PR_SET_INDIR_BR_LP_STATUS.
+ */
+#define PR_GET_INDIR_BR_LP_STATUS      80
+
+/*
+ * Set the indirect branch tracking configuration. PR_INDIR_BR_LP_ENABLE will
+ * enable cpu feature for user thread, to track all indirect branches and ensure
+ * they land on arch defined landing pad instruction.
+ * x86 - If enabled, an indirect branch must land on an ENDBRANCH instruction.
+ * arch64 - If enabled, an indirect branch must land on a BTI instruction.
+ * riscv - If enabled, an indirect branch must land on an lpad instruction.
+ * PR_INDIR_BR_LP_DISABLE will disable feature for user thread and indirect
+ * branches will no more be tracked by cpu to land on arch defined landing pad
+ * instruction.
+ */
+#define PR_SET_INDIR_BR_LP_STATUS      81
+# define PR_INDIR_BR_LP_ENABLE		   (1UL << 0)
+
+/*
+ * Prevent further changes to the specified indirect branch tracking
+ * configuration.  All bits may be locked via this call, including
+ * undefined bits.
+ */
+#define PR_LOCK_INDIR_BR_LP_STATUS      82
+
 #endif /* _LINUX_PRCTL_H */
-- 
2.53.0

