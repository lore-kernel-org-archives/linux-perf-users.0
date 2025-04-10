Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F42136658;
	Thu, 10 Apr 2025 00:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744243891; cv=none; b=hKPodSpwXKlVxN9n8Ctm0YjGnsG2EhJFPs7NR9KwwiuqB/xefaHMOFDYx42pR29q7NQW1ovv1NE5BE9ZthgqDS47vlpwQ3CwLvc7LGVP50iH6nFS43VXwnMZgA28sNJe6T4lH4Mo2yKZMH0aypI0fKJQ4zFwUuaF64s8vl0/n84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744243891; c=relaxed/simple;
	bh=5gNrapU9m0iEfF2ywuXgY1f4VK/XQNsOp/LMBJem0Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XmSGiuZXEAWw44b9NYXriW9Lwvfefk/SFZWF5vVBRyGj8or5uAzJwxjr05mkNQQ/YBghAC9hnHst6eX8yKxHm+29xFTAsdTPupNR3cowJf1d3eg+auub0gTR6/tDT9LBlxnZaQWN/4cOWw5pbR/VAII37CcSOmR+SIS4IuvG7bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XX3GQccz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XX3GQccz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ADF9C4CEE2;
	Thu, 10 Apr 2025 00:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744243890;
	bh=5gNrapU9m0iEfF2ywuXgY1f4VK/XQNsOp/LMBJem0Iw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XX3GQcczyy1utyiuIzeZCtY0hcxNZPBR9HAr96TrmFfdP8VUQ9VKBFAx9U0ZaFXC5
	 scFZDu9R0Bf+ypKriK2Gs5FuJD0j4ojHDWnsKSblSHmfchH8dtqJqlbNzUDMfwnpq2
	 a/BRdzj4UgJ/Lng8jJA8nsuPpp7lmmxH6MfmA2U1zIytnS86J0GjLbLXJExr4bBRJp
	 8N+mXWgjuRhtuO/HhYBNYV1ZImSj1CAog7RFfssch4BGCbX388uILulqQd2NEXbZ1u
	 88w/7QFVzyUjSX7MbwMX1Ol2xlYkGD74aoATRXWd02DrcfD8Syh8wU29Zw8qclAs/X
	 LWppNk2bnEe8w==
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
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 06/10] tools headers: Update the uapi/linux/prctl.h copy with the kernel sources
Date: Wed,  9 Apr 2025 17:11:21 -0700
Message-ID: <20250410001125.391820-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
In-Reply-To: <20250410001125.391820-1-namhyung@kernel.org>
References: <20250410001125.391820-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up the changes in:

  ec2d0c04624b3c8a posix-timers: Provide a mechanism to allocate a given timer ID

Addressing this perf tools build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/perf/trace/beauty/include/uapi/linux/prctl.h include/uapi/linux/prctl.h

Please see tools/include/uapi/README for further details.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/trace/beauty/include/uapi/linux/prctl.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/trace/beauty/include/uapi/linux/prctl.h b/tools/perf/trace/beauty/include/uapi/linux/prctl.h
index 5c6080680cb27b19..15c18ef4eb11a013 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/prctl.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/prctl.h
@@ -353,4 +353,15 @@ struct prctl_mm_map {
  */
 #define PR_LOCK_SHADOW_STACK_STATUS      76
 
+/*
+ * Controls the mode of timer_create() for CRIU restore operations.
+ * Enabling this allows CRIU to restore timers with explicit IDs.
+ *
+ * Don't use for normal operations as the result might be undefined.
+ */
+#define PR_TIMER_CREATE_RESTORE_IDS		77
+# define PR_TIMER_CREATE_RESTORE_IDS_OFF	0
+# define PR_TIMER_CREATE_RESTORE_IDS_ON		1
+# define PR_TIMER_CREATE_RESTORE_IDS_GET	2
+
 #endif /* _LINUX_PRCTL_H */
-- 
2.49.0.504.g3bcea36a83-goog

