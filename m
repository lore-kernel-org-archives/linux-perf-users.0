Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035FB258CF1;
	Thu,  3 Jul 2025 16:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751561822; cv=none; b=tlItnVMV+VGDZKGs6MZkF0ynt7c5eO7ah7FuRio3dIflR9ZK03v8RFHhX/CsATKHmn1KtG/EOi0awpMfFRC9kv3NGxzQFbMW91NLmxL88TQsz9GixbSKuA2FvHz2rI2Gx7eRmqI6V/UX9V+3OtW5sMTdn+tnrEo3NaxeCcspkeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751561822; c=relaxed/simple;
	bh=0gNRnHp0lYcF48lsVadyWaPO5wqh2fr3pWkBS9xX3i4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=llgS1DosGU9841bhUUCyJuLmHo2h27xaSZJukQbWmq4B2d0x3KhoYavotRnxilbp9Ec0OCyoUGkK1z+N4imnAB3ia/+LFI7nNEGRPAotZ65fCSUv60wTNY3v1trW5jOhPoGs4pAp3XCpZAFwzGdkAs4IEFGti5zsygpkuLnkxBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DeXGHAXh; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DeXGHAXh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751561821; x=1783097821;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0gNRnHp0lYcF48lsVadyWaPO5wqh2fr3pWkBS9xX3i4=;
  b=DeXGHAXhvKCECVk1XAUGbEbEoxlzsvfhsBJ6vkXxgCR7YOMOOE16DImZ
   XXrlf8wyW0g4BZ8fsMqZEBSFbHgcQ9C1B5n4CSvHMoMFyhUb/uzmCL/7k
   kAH7/DxKCkFbq6S/+bLG+uQoZ7EvOY8NhbbEdAwZ9mIBKBZNq26nu+kV5
   zOk5M2+87N5sB4nTVhkW451d5x71DZM1BxMkXj1y6FRTXdquTeL4UY7D9
   Ae1uUyU+ouHGglawJD3WqliPXnWDtDkxjFeWh8wOdGurYijBTJENzhxrV
   S35eB9qxxksv+NO6ghfxUlQrFk56LZ6TkBdIf6Dl70LKIh16ONDG+4thF
   w==;
X-CSE-ConnectionGUID: vNV8CHUKQvmDf1cidN2opA==
X-CSE-MsgGUID: aNN2OfjqRQqZIH2/OHleKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53992517"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="53992517"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 09:56:54 -0700
X-CSE-ConnectionGUID: e6jn6gNZTquTIpHXvdM/gA==
X-CSE-MsgGUID: K6pqvlZNS0itNtLCuLhSbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="154554262"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa007.jf.intel.com with ESMTP; 03 Jul 2025 09:56:53 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: dapeng1.mi@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 2/4] perf/x86/intel/uncore: Support customized MMIO map size
Date: Thu,  3 Jul 2025 09:56:12 -0700
Message-Id: <20250703165614.606446-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250703165614.606446-1-kan.liang@linux.intel.com>
References: <20250703165614.606446-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

For a server platform, the MMIO map size is always 0x4000. However, a
client platform may have a smaller map size.

Make the map size customizable.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_discovery.c | 2 +-
 arch/x86/events/intel/uncore_snbep.c     | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 8680f66c3e34..142cf714bfe2 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -650,7 +650,7 @@ void intel_generic_uncore_mmio_init_box(struct intel_uncore_box *box)
 	}
 
 	addr = unit->addr;
-	box->io_addr = ioremap(addr, UNCORE_GENERIC_MMIO_SIZE);
+	box->io_addr = ioremap(addr, type->mmio_map_size);
 	if (!box->io_addr) {
 		pr_warn("Uncore type %d box %d: ioremap error for 0x%llx.\n",
 			type->type_id, unit->id, (unsigned long long)addr);
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 76d96df1475a..2f5c2eb1ce0c 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6408,6 +6408,8 @@ static void uncore_type_customized_copy(struct intel_uncore_type *to_type,
 		to_type->get_topology = from_type->get_topology;
 	if (from_type->cleanup_mapping)
 		to_type->cleanup_mapping = from_type->cleanup_mapping;
+	if (from_type->mmio_map_size)
+		to_type->mmio_map_size = from_type->mmio_map_size;
 }
 
 static struct intel_uncore_type **
-- 
2.38.1

