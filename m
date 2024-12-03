Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE101CDA17;
	Tue,  3 Dec 2024 03:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733198038; cv=none; b=I/Deo+bIQmYiu+YVaj0Iic2Zpc6VP4j1EAw2F3bRISUJAH37Ek0Akj6sCeBaAWGKUyV3GcXzqFk8qZd31Nm5TgTqUK9nko4DB229NFFWXXJNFFPUZLVdX+tbcxvPdJ95XoS7gqDOT8dOVMgMdB7YwaYSEpJ+7X7A4hyvTKxarGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733198038; c=relaxed/simple;
	bh=Hp2sHHC+kfgp9mI9q7a62u7eBY07I61uBeBGfgVyxrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLMabvPShT4lo2S8xZwQ+R90ZDt69DcJTeAHmNipN/CGLeg5+WV81+xm5p9TkWGsv/ksh9qesnMCYvilKHuYNLMOoqZzWg0X28mDk+P6PacH900rzhq4SRyOqlxPgMpTWpH4k5sUvWCNH7CflWt2xsirmYIySRkc+qVdgZJq7Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lq4aEAo+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lq4aEAo+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99275C4CECF;
	Tue,  3 Dec 2024 03:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733198037;
	bh=Hp2sHHC+kfgp9mI9q7a62u7eBY07I61uBeBGfgVyxrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lq4aEAo+Npw1/SeWM28OzPiCalmHDJ3K0y35NryWNaFrIXZ3qF+AQTfXCJG5CPViL
	 3Aq7xLpmS4qH6Sv0zZjYhSDnSf6Lp8bJ4aRqjyy4DeuVRusDXvvReGS6M+kxClP+Ex
	 zaGkvQmu1OWiliV0w854CYMkzqkvvU58YMj2lf+I92fdHOSHez7QWmurbvyxHZ2vR+
	 2FOOLe42CnCD50Ig3Rn8+T8vR0yba+bpYaXGCdJy5qXWCNvA4wlOukBXcD+cem5Bbj
	 y5bT3j/r7J4Z2fkS2hWgOC/4HwcC0ZgPwmS9w0M09enTs78QCgUetWz38OCkW9PVT3
	 Y4Zsbf3pKheeA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH 10/11] tools headers: Sync uapi/linux/prctl.h with the kernel sources
Date: Mon,  2 Dec 2024 19:53:48 -0800
Message-ID: <20241203035349.1901262-11-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241203035349.1901262-1-namhyung@kernel.org>
References: <20241203035349.1901262-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up the changes in this cset:

  09d6775f503b393d riscv: Add support for userspace pointer masking
  91e102e79740ae43 prctl: arch-agnostic prctl for shadow stack

This addresses these perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/perf/trace/beauty/include/uapi/linux/prctl.h include/uapi/linux/prctl.h

Please see tools/include/uapi/README for further details.

Cc: Mark Brown <broonie@kernel.org>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 .../trace/beauty/include/uapi/linux/prctl.h   | 27 ++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/include/uapi/linux/prctl.h b/tools/perf/trace/beauty/include/uapi/linux/prctl.h
index 35791791a879b288..5c6080680cb27b19 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/prctl.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/prctl.h
@@ -230,7 +230,7 @@ struct prctl_mm_map {
 # define PR_PAC_APDBKEY			(1UL << 3)
 # define PR_PAC_APGAKEY			(1UL << 4)
 
-/* Tagged user address controls for arm64 */
+/* Tagged user address controls for arm64 and RISC-V */
 #define PR_SET_TAGGED_ADDR_CTRL		55
 #define PR_GET_TAGGED_ADDR_CTRL		56
 # define PR_TAGGED_ADDR_ENABLE		(1UL << 0)
@@ -244,6 +244,9 @@ struct prctl_mm_map {
 # define PR_MTE_TAG_MASK		(0xffffUL << PR_MTE_TAG_SHIFT)
 /* Unused; kept only for source compatibility */
 # define PR_MTE_TCF_SHIFT		1
+/* RISC-V pointer masking tag length */
+# define PR_PMLEN_SHIFT			24
+# define PR_PMLEN_MASK			(0x7fUL << PR_PMLEN_SHIFT)
 
 /* Control reclaim behavior when allocating memory */
 #define PR_SET_IO_FLUSHER		57
@@ -328,4 +331,26 @@ struct prctl_mm_map {
 # define PR_PPC_DEXCR_CTRL_CLEAR_ONEXEC	0x10 /* Clear the aspect on exec */
 # define PR_PPC_DEXCR_CTRL_MASK		0x1f
 
+/*
+ * Get the current shadow stack configuration for the current thread,
+ * this will be the value configured via PR_SET_SHADOW_STACK_STATUS.
+ */
+#define PR_GET_SHADOW_STACK_STATUS      74
+
+/*
+ * Set the current shadow stack configuration.  Enabling the shadow
+ * stack will cause a shadow stack to be allocated for the thread.
+ */
+#define PR_SET_SHADOW_STACK_STATUS      75
+# define PR_SHADOW_STACK_ENABLE         (1UL << 0)
+# define PR_SHADOW_STACK_WRITE		(1UL << 1)
+# define PR_SHADOW_STACK_PUSH		(1UL << 2)
+
+/*
+ * Prevent further changes to the specified shadow stack
+ * configuration.  All bits may be locked via this call, including
+ * undefined bits.
+ */
+#define PR_LOCK_SHADOW_STACK_STATUS      76
+
 #endif /* _LINUX_PRCTL_H */
-- 
2.47.0.338.g60cca15819-goog

