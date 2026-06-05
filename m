Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DF829AAFA;
	Fri,  5 Jun 2026 01:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622248; cv=none; b=qmKAzozOi+Fu3egL8LVbUrOpbKqPbZYjWlCL3MEQT52HhU8b0Hf/nkyvhO1OQBXh2qAscfd55DFcXpPs61WneoEBjOAX6OxBnJBixqXcaPn971CH50dkLAcqbe3Z2P43Q3jx3mxfjoGjNY9n9SJXi9NfsoNbEZu8tuUmCyuOECw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622248; c=relaxed/simple;
	bh=9X8yih0lHJ0Q4enducM9KHyJS3Y1kIDRkX+4U85O9RE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p8Liyvp8UcNCJegfobFcK9eut4YmHnsqMdsup15wILI+HpdODuUbh8c0s4BivdSCe8C6JahYgHkF12wVVFyLJJvN9MdCV9EVsHn4pD+khRpwdqvIPH5LS/iJP9ji0S98Bmk7wo487XVJusxT8Vy+yP3WnkEMB2yGyamxU2si4Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GlzBDxaz; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GlzBDxaz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780622241; x=1812158241;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9X8yih0lHJ0Q4enducM9KHyJS3Y1kIDRkX+4U85O9RE=;
  b=GlzBDxazpqv7wQ1W1bLSD4axCQcKTsvijEkFI0jg+SCtTKSSbuP6hVuH
   nh67OExjhfsqCkJadSHgM+6JvzAO4xYRHd8Uz/b9iNopBfdBhuzeJfaUx
   WSbtRJstgbEsAQIVgkgB8C+6VFtZfO9eFFoPScj49f6wLyaZay+7wx/rn
   mJy6bqcAQdcgMAauEXvX98DWUKBFlTq6yY8qFsu33GK5VvOg0wrhTlEGP
   tYdrKRaTu0nEsM3389HUM1eAstgzfkwlmmWqhBuhYh5geS7vJtFWqWtN6
   mcVhrdbl6zLc4UcKpf3xsHQhNQLBu9QMpLHGkIASbAEJf+RnGIftcPwnH
   Q==;
X-CSE-ConnectionGUID: Yerv4Po+SWGFQCR5pnrRqw==
X-CSE-MsgGUID: 7gK96AJhTiubBG1gGdxyJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="91772221"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="91772221"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 18:17:21 -0700
X-CSE-ConnectionGUID: HPUjgi7DSQSOtaSYVqd4qg==
X-CSE-MsgGUID: QyXBovdlRAqdVOrVUaQUvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="244817167"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa007.jf.intel.com with ESMTP; 04 Jun 2026 18:17:18 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 8/8] perf/core: Fix kernel register info leak via hardware skid
Date: Fri,  5 Jun 2026 09:11:36 +0800
Message-Id: <20260605011136.2043393-9-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605011136.2043393-1-dapeng1.mi@linux.intel.com>
References: <20260605011136.2043393-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An unprivileged hardware perf event using exclude_kernel=1 can leak kernel
register data to user space via PERF_SAMPLE_REGS_INTR. Due to hardware
skid, a PMI may trigger after the CPU has already entered kernel space
(Ring 0), bypassing the perf_allow_kernel() privilege barrier.

This security vulnerability is severely exacerbated by upcoming support
for SIMD register sampling via XSAVES, which could expose sensitive kernel
FPU states (such as active cryptographic keys).

Fix this by ensuring that sampled register data is dropped if the event's
exclude_kernel attribute is set but the PMI catches the CPU in kernel mode.

Link: https://lore.kernel.org/all/20260529085613.CCAFB1F00893@smtp.kernel.org/
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 kernel/events/core.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7935d5663944..b7326bc3acd0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7800,10 +7800,21 @@ static void perf_sample_regs_user(struct perf_regs *regs_user,
 }
 
 static void perf_sample_regs_intr(struct perf_regs *regs_intr,
-				  struct pt_regs *regs)
+				  struct pt_regs *regs,
+				  bool exclude_kernel)
 {
-	regs_intr->regs = regs;
-	regs_intr->abi  = perf_reg_abi(current);
+	/*
+	 * Hardware skid can lead to PMI is delivered after
+	 * the CPU has already entered kernel mode. In that case,
+	 * user-space sampling must not expose kernel register state.
+	 */
+	if (exclude_kernel && !user_mode(regs)) {
+		regs_intr->abi = PERF_SAMPLE_REGS_ABI_NONE;
+		regs_intr->regs = NULL;
+	} else {
+		regs_intr->regs = regs;
+		regs_intr->abi = perf_reg_abi(current);
+	}
 }
 
 
@@ -8694,7 +8705,8 @@ void perf_prepare_sample(struct perf_sample_data *data,
 		/* regs dump ABI info */
 		int size = sizeof(u64);
 
-		perf_sample_regs_intr(&data->regs_intr, regs);
+		perf_sample_regs_intr(&data->regs_intr, regs,
+				      event->attr.exclude_kernel);
 
 		if (data->regs_intr.regs) {
 			u64 mask = event->attr.sample_regs_intr;
-- 
2.34.1

