Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA723126C6;
	Wed, 15 Oct 2025 06:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760510783; cv=none; b=k/kZ28JiYCcXoy/jXi7jb5+cgjE48ANxoor2QrmPRNUQI6px02MaSxg2whxwxF1x7AWrjwVgi2xEKm5tRiOQ4fNlsXDQHJ4aUj2cGuzB4W7yhoRzMz8I/mztCZ8dtccgd67vwcn8fvfSF5Aa8CO84TEuYKk/5X8TssKEGzD2Y/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760510783; c=relaxed/simple;
	bh=ZglxdEiMhwZbOJ7YeIwThviIiLv7/83iyeKDAIzrU7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mz8guGl/Syiqe5QML7B1DAQihQ7Xn6lUIGy3xnEot3z2+H4PzQlbGmxt4ayOfZnNZCcjsBwamwICyAStysdY9/X/xSqGfoNsbS6oelE3l8/V5OwDCugV/tSTbLe9vDc4nQJcIdW1wXCOQAGzPsqiACrXprs4qlwa5k8jo0wwjUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YQl8Bo3U; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YQl8Bo3U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760510782; x=1792046782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZglxdEiMhwZbOJ7YeIwThviIiLv7/83iyeKDAIzrU7s=;
  b=YQl8Bo3UrEprdopV1rAn0RgWvlDWkcZLxwHB3yE78Ko7PQ6Kw8rqTJLb
   6NhjGi/ADUKhHESxcsXybFANKqLA79iuOX41/U9h9Op9E0PdxEp7lIR8A
   Q2Y18f/RCqIwmB8gRD0dEhOSGb9ZetR6IEDv2CAbQm9S/kw3TL/XEZmb7
   /RPkhkfOd0lWMfDJlKZHzZ0P4aqQJmaWRL5wdr/t2zgN5x8EmRtNTaH8d
   pL0LpmZhWU9Ut7fehSv9uAKf6gk4wJbGu9jyQd9zQewsGqMTgl+Fz4cGF
   NBF2SmSDx8TO8KxYRHvbr18v3Uc8ncgGeUaYMlak3pzocZvo7OoLVvqcw
   w==;
X-CSE-ConnectionGUID: 1Ii4BbgbRtKJy+O2p1HapA==
X-CSE-MsgGUID: obJea19ITKea1Oame5JSZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="50242462"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="50242462"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 23:46:21 -0700
X-CSE-ConnectionGUID: cggbbg8dQhamb7MgoRdDWw==
X-CSE-MsgGUID: X20u4cIZTHSPiknJJLesHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="182029906"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa006.fm.intel.com with ESMTP; 14 Oct 2025 23:46:18 -0700
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v8 03/12] perf/x86/intel: Replace x86_pmu.drain_pebs calling with static call
Date: Wed, 15 Oct 2025 14:44:13 +0800
Message-Id: <20251015064422.47437-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251015064422.47437-1-dapeng1.mi@linux.intel.com>
References: <20251015064422.47437-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use x86_pmu_drain_pebs static call to replace calling x86_pmu.drain_pebs
function pointer.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 28f5468a6ea3..46a000eb0bb3 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3269,7 +3269,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		 * The PEBS buffer has to be drained before handling the A-PMI
 		 */
 		if (is_pebs_counter_event_group(event))
-			x86_pmu.drain_pebs(regs, &data);
+			static_call(x86_pmu_drain_pebs)(regs, &data);
 
 		last_period = event->hw.last_period;
 
-- 
2.34.1

