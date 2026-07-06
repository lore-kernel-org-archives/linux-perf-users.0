Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C35C3AA4E8;
	Mon,  6 Jul 2026 02:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783305657; cv=none; b=hTXhTbZh83TW9v4MHeEkzZxwgYA6V8QPpjYV+/q3Iwn4sZpF9etQL4+6HgFeJc+mKnutcPCzkyN567rb3lS3g7BGIqnly0jg0kkm3WL1J3plLsTBmHxhkl18j5q7UxkGpVDHuNlSA8qgpHQNMMWc0JqlgnVlYTTVZ/L8hyn92XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783305657; c=relaxed/simple;
	bh=cOpsfzLn3T2DF7wR1zj4s6ED/JWZ16GplY+0F1D+pg0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s5Y2BCPS/kdoneXBA2xSeWCSUBL2Ws5M5Q/SqQLz/jm2eA3ShyzqUE3Wo/KnB38KW1PPPO5AlVt7YfemSv0dFLcQWaX3tGW3aJqvJDwiTGM/o+DthZUgWwC6eEQLyRTZoXDeG54gxV7n4jwzttJAFyqDtD4gca9EBg3DcpsTO94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZP08VHMt; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZP08VHMt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783305656; x=1814841656;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cOpsfzLn3T2DF7wR1zj4s6ED/JWZ16GplY+0F1D+pg0=;
  b=ZP08VHMtOk2rXWBSMwWMGKjb4ETpHXASlQQUZZLzCPkdXoStF4ctSaAc
   sCX8O0Gvl2gtSX8gDqQOdVkKUtXnuwPHpn/2kmfoPkYnknHj22djNrjiU
   yTxi+bQ8k2yIrzawJ16PyBRJHr7IbH3KrH/9WwhwFr0VIbxvpQ3tJRXXj
   c4EGEfVI1wQ4r4gvNmcVIGddQ8JYoVzkAifgYmaDr4S/Ir373Z7fZfqOv
   qkO5i6ezNYTa3FXddrHEbmN4YcVmDM5fQLXplpY+Bftur2zSG0HZFm/XA
   CxVhNat1dw4Io0rL5jThropAAFvDi6LEGQUrtiep6sn94u/00i4f4nfhb
   g==;
X-CSE-ConnectionGUID: xnj9jrrxQpqAdHFwq1JyFw==
X-CSE-MsgGUID: DlfkvfilRxm3Kr2M/o599g==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="87614039"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="87614039"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 19:40:56 -0700
X-CSE-ConnectionGUID: OGTIR1QdQ/eQTo86JONQHg==
X-CSE-MsgGUID: 9dfx6nRoQNa0D/IZZIuhwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="253716703"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa007.jf.intel.com with ESMTP; 05 Jul 2026 19:40:53 -0700
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
Subject: [Patch v9 03/10] tools headers: Sync x86 headers with kernel sources
Date: Mon,  6 Jul 2026 10:34:37 +0800
Message-Id: <20260706023444.3067660-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706023444.3067660-1-dapeng1.mi@linux.intel.com>
References: <20260706023444.3067660-1-dapeng1.mi@linux.intel.com>
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
index eff29645719b..8cbc4c499706 100644
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

