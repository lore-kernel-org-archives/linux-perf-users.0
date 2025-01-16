Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E001ADC81
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 23:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737068863; cv=none; b=ov/trtUBXZTXRqw9pJn0csdZ2ABqNKT+bdkf20CfFN68wFT3AcHesEoK0ysxri9Xh3f10pX+nAp9uyPVCcK0fuJhREowCnRHBOZXzTgfXc1i9uV8eQcGbKw89nISisvJMvdjQISVU156okr/Uye1ZoLY1aP/VG+Ti5uXmMZKbS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737068863; c=relaxed/simple;
	bh=uAEpU2K02sNQ8ZGhjJ+Kr6EIIuyqU2W6NIkawtiuPrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=keMwr/7koZR+T4PMkIeUJJFeL8L2du1UAMt2nhLQ0bftUOBCl70G6EYuGkt8+ikMJs73L4T93gdckoBBDud5BhgoU7MxeuTtBRoPE4Rc2TPfIKLVFnSqaraiZK0jMDVjATtGht/SpgmUOLtP4E/f0r0IXjBQ2wO9x2bpbhjkUJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CiYNGQR5; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CiYNGQR5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737068862; x=1768604862;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uAEpU2K02sNQ8ZGhjJ+Kr6EIIuyqU2W6NIkawtiuPrY=;
  b=CiYNGQR58M3hyBtPD8yD8R30EbhYr7qBpnQOL0q4tuF3bmJjMBFL/ChA
   Pl8lgyEqXbJO5EDaumXiyEebzXz14SXMRqbFloU9Ujf6zcU2h/mDE5bcV
   1MkhUOxdg3gRy6oDQhHDSpjSjC/aVqvG1gDYfzP+C4G7Ak4Ar2JooNYbS
   HZamUu17mFz3DMuEyDt63t72oYE7R22nIhhzdPv7wXF9FUfSO7g1d2qGP
   tm6E0hcvaWPkZI0UzBsfBlx26pIY77bM/6ILG0NantNLnbBkHy9wlfVTo
   UfhwWFutl1dXSo4XnueLKptRUIIz4x/O8Xvw753xwsp2obcCZSbq14cHO
   Q==;
X-CSE-ConnectionGUID: S5GOlCAuTJatFU+q2BA7tg==
X-CSE-MsgGUID: GzSKEKv5RguNZTWuNYdqwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="37364115"
X-IronPort-AV: E=Sophos;i="6.13,210,1732608000"; 
   d="scan'208";a="37364115"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 15:07:41 -0800
X-CSE-ConnectionGUID: x2rEFRgnQTSoNub245nK6A==
X-CSE-MsgGUID: LvK5eZEmRIySvK27MXLVFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,210,1732608000"; 
   d="scan'208";a="136474345"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 15:07:41 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <intel-xe@lists.freedesktop.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH v13 1/7] perf/core: Add PMU_EVENT_ATTR_ID_STRING
Date: Thu, 16 Jan 2025 15:07:12 -0800
Message-ID: <20250116230718.82460-2-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250116230718.82460-1-lucas.demarchi@intel.com>
References: <20250116230718.82460-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct perf_pmu_events_attr has both id and event_str however zeroes
the id and only set event_str. Add another macro that allows to set both
so drivers can make use of them. The id is useful for determining the
visibility of the attributes without resorting to creating separate
groups passed via update_attr, while the event_str is still useful for
attributes like *.unit or *.scale.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 include/linux/perf_event.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index cb99ec8c9e96f..423f21b51cb0f 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1923,13 +1923,16 @@ static struct perf_pmu_events_attr _var = {				\
 	.id   =  _id,							\
 };
 
-#define PMU_EVENT_ATTR_STRING(_name, _var, _str)			    \
+#define PMU_EVENT_ATTR_ID_STRING(_name, _var, _id, _str)		    \
 static struct perf_pmu_events_attr _var = {				    \
 	.attr		= __ATTR(_name, 0444, perf_event_sysfs_show, NULL), \
-	.id		= 0,						    \
+	.id		= _id,						    \
 	.event_str	= _str,						    \
 };
 
+#define PMU_EVENT_ATTR_STRING(_name, _var, _str)			\
+	PMU_EVENT_ATTR_ID_STRING(_name, _var, 0, _str)
+
 #define PMU_EVENT_ATTR_ID(_name, _show, _id)				\
 	(&((struct perf_pmu_events_attr[]) {				\
 		{ .attr = __ATTR(_name, 0444, _show, NULL),		\
-- 
2.48.0

