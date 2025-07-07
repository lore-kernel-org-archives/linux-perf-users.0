Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7FE21B9CE;
	Mon,  7 Jul 2025 20:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751919527; cv=none; b=WCRs52NgNwH+sCvH5eBBZmrVnGlWAKXc8imkZqN+2kLuFPf3FKNw6E3SJo9mwKPWOpPQVz7j/MHOZeuPAIWc2I/Z6oSqnrftovp2j4lM/soVfoy4HdPdA1hlq1aEAg2P6vJu5S73Nj9RvzcXoaJKJ396c6BklPyLRFIgug1f4f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751919527; c=relaxed/simple;
	bh=qCKKiua53eeqKfpaWpnRVrcPOFeNixA3t0yrCwhFbAE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O57ga19nyxEOvNITwXMMosZkuZV7yul36bcBssM4+OIgJDzQE/BdDcUMOVPckGPA+0xTnW+KVs9XCPXUVjhaqATpT4RLd/2bXJxgbO+9AKwsv6+HW+GIzXU4yhscLq8kuf2wPAT4StT5zgq/ueDuKseq5BgEDwIZC4CS/rm9dS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=caHPQ03S; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="caHPQ03S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751919526; x=1783455526;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qCKKiua53eeqKfpaWpnRVrcPOFeNixA3t0yrCwhFbAE=;
  b=caHPQ03SG4TyqYyZl5b6QnaoTDTr/EsIDPHKOgfoIM3yuwQYVJL0uv2T
   f3C0VUQT6R3xVp8uTTUn9YmBucK0RMwa64Qk5o1jW0J1MtbzAy2I6P45a
   kn9HaVm9IqRKqfJlXWLa+9Ez50EZh145L2/x6HfImojf0bNN30YFYf2uj
   5+OaNWQzCSm0C2NkX5QA+W9V0OlekaLb/QCN6oewKQ/juznnNEYzH6Qzc
   pjRi8OXoGsoXpgFgPBOmuXWbg4Q2HcZx1uvaY7YjdjwPIWUp+N6PeHHyI
   XSSe2SREWDDCrINa4MEVV6mi3H+9Y8OMqZFjFnP66+a8rdORZplaclrF3
   Q==;
X-CSE-ConnectionGUID: ZJbkJUf0SZajn7mcAk/zIg==
X-CSE-MsgGUID: //VJkwSCT+y/So56QVfQOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53362316"
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="53362316"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 13:18:44 -0700
X-CSE-ConnectionGUID: 5fKc7Mh5RHS9xZ5x8hXDWw==
X-CSE-MsgGUID: aytSuCu8R4+SgKP9I1/nvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="159343673"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa003.fm.intel.com with ESMTP; 07 Jul 2025 13:18:44 -0700
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
Subject: [PATCH V4 2/4] perf/x86/intel/uncore: Support customized MMIO map size
Date: Mon,  7 Jul 2025 13:17:48 -0700
Message-Id: <20250707201750.616527-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250707201750.616527-1-kan.liang@linux.intel.com>
References: <20250707201750.616527-1-kan.liang@linux.intel.com>
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

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
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

