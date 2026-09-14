Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D273E2FBE1F;
	Mon, 14 Sep 2026 01:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789350471; cv=none; b=jOl+IA4T3vN/0CAg7gPJ2iNJ0IIR9Nur3nfTbPFU7vfQMj5gZcB6VXxQPKidyXziWPhJOwlwz40UXkhwAtjAamaEgQfUu+mmKoJy/IpCYOEw+aeQWkHbRlNuZ+/TpC9G2yvdXQT1AecYwmNs6uU6qCFDMA01csP2YFcpEvPB3iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789350471; c=relaxed/simple;
	bh=JxdDKKQoEYlD07ctA6+8G6E4Sntr+YHJGG6X3XqqSvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=knt3DdTRBmtok2sbejK1NpG9l1FSJBPL953BnH/7gh1AoNo7kR+Q391uZvOwqX+ajbcKoTxnHs37HThix4bHlBALYAmY6a8vHK+RXImPPB76qjdi5fXJillmQCZhhts+YhF8RJjvPos2ucJpHsanExXPpKicSklaf00Yv4M1QcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=STXXiH5D; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="STXXiH5D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789350466; x=1820886466;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JxdDKKQoEYlD07ctA6+8G6E4Sntr+YHJGG6X3XqqSvc=;
  b=STXXiH5Dcy6BgWjHrI4jJLmGvzA+nCB16s+D/9bhDsEAp0ed4GVYSjfE
   wmJCD//GLFG24H0Q4simIy0jFPT8KFEGRb6x45YwHguRSjN0vA2XX2iQE
   fL5NhCkoapYicSHcjN+NKea//6LkzHO5yJt48of3yjH1il/KpGMYQzFNy
   oqjCQtGgDcjbOg51oQuIp9piZi1daIkzWsXWUeQG8+QhqX6IiyXD3j7GD
   zb7Rq7+l/kuuPURNl2FRnY8cqxzUxrAOKcKOh6reLHLmz1nzJO8cClA/8
   kJRVB8UKK972sbamIcmV5KmcsxTPPbAqoSsOK41Vn+j4zypgHdDTk3Kfp
   A==;
X-CSE-ConnectionGUID: JKOjP82SSNiXtFIDevh6Dg==
X-CSE-MsgGUID: 8f/RUPrkS+yORHtQBM5qXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="93530621"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="93530621"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 18:47:45 -0700
X-CSE-ConnectionGUID: RNcIiQv7Q4KknlYU9rCbAA==
X-CSE-MsgGUID: 3FFBqL5pS2GPSxXjs1pqTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="276664164"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa005.jf.intel.com with ESMTP; 13 Sep 2026 18:47:43 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v11 03/10] tools headers: Sync x86 headers with kernel sources
Date: Mon, 14 Sep 2026 09:40:42 +0800
Message-Id: <20260914014049.2061519-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914014049.2061519-1-dapeng1.mi@linux.intel.com>
References: <20260914014049.2061519-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sync newly introduced ARCH_PEBS_VECR_xxx macros from kernel.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/arch/x86/include/asm/msr-index.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 18c4be75e927..9c26d4075c5f 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -350,6 +350,13 @@
 #define ARCH_PEBS_LBR_SHIFT		40
 #define ARCH_PEBS_LBR			(0x3ull << ARCH_PEBS_LBR_SHIFT)
 #define ARCH_PEBS_VECR_XMM		BIT_ULL(49)
+#define ARCH_PEBS_VECR_YMMH		BIT_ULL(50)
+#define ARCH_PEBS_VECR_EGPRS		BIT_ULL(51)
+#define ARCH_PEBS_VECR_OPMASK		BIT_ULL(53)
+#define ARCH_PEBS_VECR_ZMMH		BIT_ULL(54)
+#define ARCH_PEBS_VECR_H16ZMM		BIT_ULL(55)
+#define ARCH_PEBS_VECR_EXT_SHIFT	49
+#define ARCH_PEBS_VECR_EXT		(0x7full << ARCH_PEBS_VECR_EXT_SHIFT)
 #define ARCH_PEBS_GPR			BIT_ULL(61)
 #define ARCH_PEBS_AUX			BIT_ULL(62)
 #define ARCH_PEBS_EN			BIT_ULL(63)
-- 
2.34.1

