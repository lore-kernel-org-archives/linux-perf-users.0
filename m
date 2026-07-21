Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9AA41DEEF;
	Tue, 21 Jul 2026 07:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784619238; cv=none; b=d/GPbRFzzSQOSiA+OpM5FdyY5RvYqtvqr8E8d9a9MikPEO8fqxpDLsSe9BlaSDMjqap44RC2QaPJKh7D4EUmJ9dX5AscLJBD25eA37QtsreYZeHgco1SIVPoyT+gBn3+NkqEq0LZ4QgFjhGq3HnKRTBNFqMM65gnE8IYtxpFdfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784619238; c=relaxed/simple;
	bh=cOpsfzLn3T2DF7wR1zj4s6ED/JWZ16GplY+0F1D+pg0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L6S2bZlqSiYDyl0K/t0W6CazBupUSNbaAE8HJ13Vd8/F30aBuRwXo65ME07qPaJ1YIV5tLgCTHD0IrWwGxEXnK/JWuY4fPgxCQsuAPN9og1TC/sRVEvTnuc+glaZN5eIhriTNExQGmY3E8CydRhP5fTmvUePjMqwYszBgLFmGrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IkucT7wX; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IkucT7wX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784619237; x=1816155237;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cOpsfzLn3T2DF7wR1zj4s6ED/JWZ16GplY+0F1D+pg0=;
  b=IkucT7wXmoa7iPj7cM+jgfsjMyiukaT4PV4DwmJDbUHZS/IqzEjfwizN
   OuenX1VytvYPZHfLEQRyq462TtKijmKf53RyHSQAaYqae3CUz4Ure9omO
   AAGqKsRpp6jbfZY+0ZoUqdfkVbP5UL95n4bWYayitoBZJmJoMkTnvh7dJ
   FY54oKB+bpSH9vA3MNCvuAupkDodus7rzHKvO1MbOqjKxVAkYDWhrXG/A
   VTAhZj0YenwlYpPIV6WuqEkQ3KzrioasGabLJ8JiSwTqZwV1wOx+bTG8a
   qOW7E9KmiNLbIp379KzEWj+Csk5+N8NsOEGezvGcO1V2/8EqVRP+/uOsl
   w==;
X-CSE-ConnectionGUID: YFxiq190RRe9RWl28y64cw==
X-CSE-MsgGUID: zxQEj+b6TEC3/Ad+5qTerA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="84190118"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="84190118"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 00:33:56 -0700
X-CSE-ConnectionGUID: 0+18CbQrQleQUqjt4jlDJg==
X-CSE-MsgGUID: bUe0lTHeR2e9sJPYjzVzOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="256484464"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa010.jf.intel.com with ESMTP; 21 Jul 2026 00:33:54 -0700
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
Subject: [Patch v10 03/10] tools headers: Sync x86 headers with kernel sources
Date: Tue, 21 Jul 2026 15:27:00 +0800
Message-Id: <20260721072707.3787848-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260721072707.3787848-1-dapeng1.mi@linux.intel.com>
References: <20260721072707.3787848-1-dapeng1.mi@linux.intel.com>
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

