Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94106305E24;
	Mon, 25 Aug 2025 21:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756159152; cv=none; b=PznqKSOq36/CcnIWMR981D/dNRIy6Ub4/de0j4XD7frovFslrmQhFk8zx2KmDMDCVShq4CPFz1DnjYuPZyR1gGMMJvEr2OAYz5A9qOJZ6954XmtkveTfPE4PY/HfPnOxBieVAfURj8tq3cokR8XOLnWz8KnHWBwsk+DdL/nyhFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756159152; c=relaxed/simple;
	bh=BylEFT7xAr00ob7Nl2FVnVd/6nD83KmV1M+p9haUowI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oW97tjAncJ5oA+gWH4xFV3jRHLa+J+OPUWBno35osjb7Q1rX561D5d3g8lED2GshZaR2gL0BXk/+y16SJNkKgqvwbTx6wiBDTklBITHB/glrrBmwUSiR+PIYfARIvFNLizBY+jVxgf8lJWYgDxMNOwm1EFkgYOX6i29YqSHfGOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qtvU/m4r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtvU/m4r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D329C4CEED;
	Mon, 25 Aug 2025 21:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756159152;
	bh=BylEFT7xAr00ob7Nl2FVnVd/6nD83KmV1M+p9haUowI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qtvU/m4ryGX/ao/nnuMOVG+tpYsK1t4tMO3pI8GXIzJ887gPElyaoV4Ohb5++Sav1
	 X2vnbogJ+MqLdNuk1wGF64r5CXr4XXRwB++8fqBmd/R77D3uYWJ8Yldi4QBxPMrQ7E
	 a7sUUccxFwTJL//nqcHqLRtldcjg0RizomP4i0mayuPYhMbVramlwZbimH3j+YFWZp
	 6zr+nuKYWfUsJ0imPr/GMLcQX1OY62+9DV6fTxuFc4vYkD5hr+ADJCWKSVODIvi8c+
	 YZee5/TYk74d8vnpMNOt5CeqLsrs7cFCmHbr4SffWMivRhWpvoedbTuoLIpTlSXb06
	 0G8OcFb1wOl5Q==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 10/11] tools headers: Sync uapi/linux/prctl.h with the kernel source
Date: Mon, 25 Aug 2025 14:59:02 -0700
Message-ID: <20250825215904.2594216-11-namhyung@kernel.org>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
In-Reply-To: <20250825215904.2594216-1-namhyung@kernel.org>
References: <20250825215904.2594216-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up the changes in this cset:

  b1fabef37bd504f3 prctl: Introduce PR_MTE_STORE_ONLY
  a2fc422ed75748ee syscall_user_dispatch: Add PR_SYS_DISPATCH_INCLUSIVE_ON

This addresses these perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/perf/trace/beauty/include/uapi/linux/prctl.h include/uapi/linux/prctl.h

Please see tools/include/uapi/README for further details.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/trace/beauty/include/uapi/linux/prctl.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/include/uapi/linux/prctl.h b/tools/perf/trace/beauty/include/uapi/linux/prctl.h
index 3b93fb906e3c51a9..ed3aed264aeb2881 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/prctl.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/prctl.h
@@ -244,6 +244,8 @@ struct prctl_mm_map {
 # define PR_MTE_TAG_MASK		(0xffffUL << PR_MTE_TAG_SHIFT)
 /* Unused; kept only for source compatibility */
 # define PR_MTE_TCF_SHIFT		1
+/* MTE tag check store only */
+# define PR_MTE_STORE_ONLY		(1UL << 19)
 /* RISC-V pointer masking tag length */
 # define PR_PMLEN_SHIFT			24
 # define PR_PMLEN_MASK			(0x7fUL << PR_PMLEN_SHIFT)
@@ -255,7 +257,12 @@ struct prctl_mm_map {
 /* Dispatch syscalls to a userspace handler */
 #define PR_SET_SYSCALL_USER_DISPATCH	59
 # define PR_SYS_DISPATCH_OFF		0
-# define PR_SYS_DISPATCH_ON		1
+/* Enable dispatch except for the specified range */
+# define PR_SYS_DISPATCH_EXCLUSIVE_ON	1
+/* Enable dispatch for the specified range */
+# define PR_SYS_DISPATCH_INCLUSIVE_ON	2
+/* Legacy name for backwards compatibility */
+# define PR_SYS_DISPATCH_ON		PR_SYS_DISPATCH_EXCLUSIVE_ON
 /* The control values for the user space selector when dispatch is enabled */
 # define SYSCALL_DISPATCH_FILTER_ALLOW	0
 # define SYSCALL_DISPATCH_FILTER_BLOCK	1
-- 
2.51.0.261.g7ce5a0a67e-goog

