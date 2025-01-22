Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92EF1B424F
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 06:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737527054; cv=none; b=ZWZbscR9WSEthcGqPnwkToNVkLI5MQCusNbgkhO5gKLkv5UtxRuX7T0j/IhFdYBTVDWpturuqcH5rXOg5uJTsavd2gChBrBvzsFdMHVxr/mtNN/kBB/aU3gMJ9ouEW4lfMRk9QA1bhUFrR9x4mBHBbxyUj8L65sEo3hh/COcUjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737527054; c=relaxed/simple;
	bh=uAEpU2K02sNQ8ZGhjJ+Kr6EIIuyqU2W6NIkawtiuPrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f5O4vAKooCJRTAlT+DKsarltDySQcTTKKT3ejnBxks/duzNYKxJkxKYoUkqobcejGCr65WB9Mwq7ft96dP1H94I0DGX/JKpMebWzI3vFBlwgEiQv+Zx+39JD9njRllj0bDfa6kEWTcbCXJ3/pufkKfvC0PgHpMR3rwAxeyloFko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gv09mg26; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gv09mg26"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737527053; x=1769063053;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uAEpU2K02sNQ8ZGhjJ+Kr6EIIuyqU2W6NIkawtiuPrY=;
  b=Gv09mg26Ox9UrnRSkoAX/K5ijDb22kWOoiPq8YIN/Lf2tr+ezyMQnIew
   uK4RGympmXMhwhi626Rc+HuB6hGBDD1V7s1yyt3ZQ7JBbFUPDk6URQ9u6
   NmTJdkmi+5nD333yoaZrBwdtAFeYXy9IY6y8c1JPw6WzZ9+xcNMLSHdRO
   u2Qrx20sUvddmDWh2ba/Dj29iP2r7PMyKvyYG2vYNzp/+CNJYAItk9Cxs
   P3mLRunyjSN2M5Q+5209k/Nego/3CW8lFAfVrOTTT46+z/4kokRpdNmJ7
   i4K4oXxV8eVwxfeau3SI9tp+GVbUlXix2La8nPnW2SdPPbqfF3htpLkHa
   g==;
X-CSE-ConnectionGUID: 92hQmVJFRcqBJwz953ejxw==
X-CSE-MsgGUID: drhgRNo3Qq+ST0QsBTposw==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="41643292"
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; 
   d="scan'208";a="41643292"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 22:24:12 -0800
X-CSE-ConnectionGUID: fQG21xvjRbKdGH7RVzg2cg==
X-CSE-MsgGUID: K1KM0QHXQyapbGoZc5FLVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="112015652"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 22:24:11 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <intel-xe@lists.freedesktop.org>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
	Riana Tauro <riana.tauro@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH v14 1/7] perf/core: Add PMU_EVENT_ATTR_ID_STRING
Date: Tue, 21 Jan 2025 22:23:35 -0800
Message-ID: <20250122062341.1100173-2-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250122062341.1100173-1-lucas.demarchi@intel.com>
References: <20250122062341.1100173-1-lucas.demarchi@intel.com>
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

