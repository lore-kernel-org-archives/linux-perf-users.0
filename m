Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65C665E20
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jul 2024 19:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721847709; cv=none; b=KcSEm0cPFfBC5ubpDoDyOZguJ0TyJT/hFyMaofEV5disnZoya+in+ux9iSAxTHh3cvswAreSv0Ts9/V6B3SPLBv9ynbYZ4NxzGkAg77bRL0vSWpkNQVK6Qs1SmvI+FrSmPb09P5L0fYGxnd6v9RdF+yS2bq7dbkjocX++B/OBvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721847709; c=relaxed/simple;
	bh=g1OlhmAy73Mp9feG3NskfFydzuTb6Icd413Fv9iydHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AFKd5Zm3lbsUBiMSIy9KpB+3QlselbUKfQ4w0qwun94uMUtpuP4g82eprignOezMhfVbg67nAY4DOzO05maNBwagFu04Mp+rdiofZwfbHOvHc0YticXZqsa0/DbKZMp6loNErTiaL/1oP4hCt9OW6bswFI81uc3R4b9SJDsQnjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d5QLfwfG; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d5QLfwfG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721847708; x=1753383708;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=g1OlhmAy73Mp9feG3NskfFydzuTb6Icd413Fv9iydHU=;
  b=d5QLfwfGOfwEPxiktCx8aJ+ojlBzgB6sAiHHqQobq5+mS+jhxU5g0AwK
   P45JH/T/eo71lhjGz4roHGgb9g+BCMdS9hBiJx9RgthVHG+FHRvAC/WYk
   5yK52a68mXma9MTHna1MaVzGAL0iRJWYjrQ+aXROpQKb1iq2ZfaXFuf1G
   OTyQP0Kl68okEZ1InNNI7HNCK7bKb/Ci4Yyj6Z1kKm6wdonHeREtHqA0R
   RzyHulHG1c4h7+rYRlJa6wBj15FCnK97+C0jeujcl0CuOqr4AetzKBJy0
   xrqKTVVdWglXG9OuwwSwwcRpVrg9m+WSwxait1n2ZN9zTAFQWx93Vu5o+
   g==;
X-CSE-ConnectionGUID: 6AgBlhdBScyD5aCiL/d/9g==
X-CSE-MsgGUID: RWe3OPVfTL+7wQpcQ3Qkmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="19685235"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="19685235"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 12:01:45 -0700
X-CSE-ConnectionGUID: r1UzdZZkQOCfY8FF9gUfjg==
X-CSE-MsgGUID: vEEVwc4iTIODh6SLeoDXoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="52907010"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 12:01:44 -0700
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v7 1/4] Create source symlink in perf object dir
Date: Wed, 24 Jul 2024 12:01:34 -0700
Message-ID: <20240724190137.3810429-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a source symlink to the original source in the objdir.
This is similar to what the main kernel build script does.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/Makefile.perf | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 175e4c7898f0..d46892d8223b 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -163,6 +163,8 @@ ifneq ($(OUTPUT),)
 # for flex/bison parsers.
 VPATH += $(OUTPUT)
 export VPATH
+# create symlink to the original source
+SOURCE := $(shell ln -sf $(srctree)/tools/perf $(OUTPUT)/source)
 endif
 
 ifeq ($(V),1)
-- 
2.45.2

