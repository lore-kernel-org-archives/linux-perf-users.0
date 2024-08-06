Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D90171E6A;
	Tue,  6 Aug 2024 22:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722984617; cv=none; b=u0mNJMuL5CdAEQLQgALFHzxFT7RDif0LBmq803oN54hO/UTSEwKi4lXY1+vWHs7eSjtQPY0kLMuj3KmHb1IWudsWV/g119LJwN8jbqYUsYcFntb5uUDTARw/lnJf4/o0//DWuRouXEruV8TyTcbVBEjKLbEFUoK3MOgJ3TzZY2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722984617; c=relaxed/simple;
	bh=v9hl09YwvwDKQBR548tw28KoGQkagQPG3RxEMj+UYWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kOU+PKoVK+NebbovyhbO9rUkRVCmUAA1sZa7bmNvtXwMu8RLg9o2kY2NE4kd2XraHZyBEb0EknCg5FzighQJU7wnGpOc0AMJSKBui2Zccv4EUA8lk1Al4wS6/WMu0LOtO1VicB9ZNkdj8CRIAxF8mET+i9CH5oi4+WUzTQkhHno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRniAGc3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRniAGc3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85D6C4AF0F;
	Tue,  6 Aug 2024 22:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722984617;
	bh=v9hl09YwvwDKQBR548tw28KoGQkagQPG3RxEMj+UYWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GRniAGc3EUDRyWbSi8tOBgjJzI6EGSEdgzzTGSqZi93j41itqSLfTQueDJA2SyNX/
	 IlJteL79HgDMwv6GOr5l8zkbRi4WyDDgn5Qk9VHih01O68CfS1niIJRXwN8Yl+3yCO
	 FtYYoh5ZTaHk/Ic6A/zeJ6liMlFNlkrcW9nDzF2NQnHbg9umboVEmvmgma8ymtsMEu
	 wW1YLeWRtAmP7PNK5sg6/jZ3HvYClFWMQbn6GSioK+WVljlwhEjW1lOOkab/w9iuob
	 TV0Y5SfcYOG56f1U4tCcKgo/pMGhIO11IyNJ75GDn1WfXWW+H4WPL+rIj0BRLg13hE
	 Q/7w7Q8UwwArA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jani Nikula <jani.nikula@linux.intel.com>
Subject: [PATCH 01/10] perf tools: Add tools/include/uapi/README
Date: Tue,  6 Aug 2024 15:50:04 -0700
Message-ID: <20240806225013.126130-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
In-Reply-To: <20240806225013.126130-1-namhyung@kernel.org>
References: <20240806225013.126130-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Write down the reason why we keep a copy of headers to the README file
instead of adding it to every commit messages.

Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
Original-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Original-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/include/uapi/README | 73 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 tools/include/uapi/README

diff --git a/tools/include/uapi/README b/tools/include/uapi/README
new file mode 100644
index 000000000000..7147b1b2cb28
--- /dev/null
+++ b/tools/include/uapi/README
@@ -0,0 +1,73 @@
+Why we want a copy of kernel headers in tools?
+==============================================
+
+There used to be no copies, with tools/ code using kernel headers
+directly. From time to time tools/perf/ broke due to legitimate kernel
+hacking. At some point Linus complained about such direct usage. Then we
+adopted the current model.
+
+The way these headers are used in perf are not restricted to just
+including them to compile something.
+
+There are sometimes used in scripts that convert defines into string
+tables, etc, so some change may break one of these scripts, or new MSRs
+may use some different #define pattern, etc.
+
+E.g.:
+
+  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
+  tools/perf/trace/beauty/arch_errno_names.sh
+  tools/perf/trace/beauty/drm_ioctl.sh
+  tools/perf/trace/beauty/fadvise.sh
+  tools/perf/trace/beauty/fsconfig.sh
+  tools/perf/trace/beauty/fsmount.sh
+  $
+  $ tools/perf/trace/beauty/fadvise.sh
+  static const char *fadvise_advices[] = {
+        [0] = "NORMAL",
+        [1] = "RANDOM",
+        [2] = "SEQUENTIAL",
+        [3] = "WILLNEED",
+        [4] = "DONTNEED",
+        [5] = "NOREUSE",
+  };
+  $
+
+The tools/perf/check-headers.sh script, part of the tools/ build
+process, points out changes in the original files.
+
+So its important not to touch the copies in tools/ when doing changes in
+the original kernel headers, that will be done later, when
+check-headers.sh inform about the change to the perf tools hackers.
+
+Another explanation from Ingo Molnar:
+It's better than all the alternatives we tried so far:
+
+ - Symbolic links and direct #includes: this was the original approach but
+   was pushed back on from the kernel side, when tooling modified the
+   headers and broke them accidentally for kernel builds.
+
+ - Duplicate self-defined ABI headers like glibc: double the maintenance
+   burden, double the chance for mistakes, plus there's no tech-driven
+   notification mechanism to look at new kernel side changes.
+
+What we are doing now is a third option:
+
+ - A software-enforced copy-on-write mechanism of kernel headers to
+   tooling, driven by non-fatal warnings on the tooling side build when
+   kernel headers get modified:
+
+    Warning: Kernel ABI header differences:
+      diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h
+      diff -u tools/include/uapi/linux/fs.h include/uapi/linux/fs.h
+      diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
+      ...
+
+   The tooling policy is to always pick up the kernel side headers as-is,
+   and integate them into the tooling build. The warnings above serve as a
+   notification to tooling maintainers that there's changes on the kernel
+   side.
+
+We've been using this for many years now, and it might seem hacky, but
+works surprisingly well.
+
-- 
2.46.0.rc2.264.g509ed76dc8-goog

