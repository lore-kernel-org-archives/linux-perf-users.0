Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4493710E4
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Aug 2024 03:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723001437; cv=none; b=Vtzh6xA+7y+P4O8AlJdBrqsTgE6LGxn+J33jJKUquQNUlHcRWT8imFFguOME4WltZLRJ9Q6mmO4Np4UgvM/kdaozXGanEDtXpJ5Rp0yhtucG4uCA7TEcKiLNJjNSXXfLsfBrGJKr1/Zs/yFSA5hItz7awtuPepyvTxkMaN50DIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723001437; c=relaxed/simple;
	bh=g1OlhmAy73Mp9feG3NskfFydzuTb6Icd413Fv9iydHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HUHE+GtAd7LV/e4A509fqwCWRs8syO5Ejch6Hme/QFd5cePn6Av2qeFLdZIt3Ur+T3M1KyuSYnVxAMfz4wh51nwl8ouFlu/tT/v7phrJzH6097fsSaSFzmX8z0negnhlFI7/wIrfcm3jNUDSLWwP6q/ClcWCrh7hTS2vGZ14fdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JV673+DB; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JV673+DB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723001436; x=1754537436;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=g1OlhmAy73Mp9feG3NskfFydzuTb6Icd413Fv9iydHU=;
  b=JV673+DBHu9ql/VLJSG/w7D2JPrcZARayf0DwTGex3+/WNtOPwUeLZNc
   CQdXNMNvcvhCifj8wNu1PM0QYz2SHFrfUBx7wfT8inMmPVe1b0/VpsGF9
   H9JhjmXqNsmd1QMl7wrTKCv2wE06zTGsMkNIQn2lshSiHY4RBD2D7A5n7
   p/bg3R5OsIkqEu6xlct7gNhlJ2XxgR2AOxD+o5sb7wD5OCoS95XgvWF+9
   LFaFIi8+FwDw9UqDn2bQxngdTf4mhFrdW/EmStie709EjED//PpPSEoRG
   kVk0llVU+7uleH+ktj4V9CPI5PUiYmZoVkPk1to0LC7CJ2ZvS6CWBPNV/
   g==;
X-CSE-ConnectionGUID: +qmwbXrgQDCKk2Gu3TNTjg==
X-CSE-MsgGUID: 0C0vxYhPTc6eMP9P8ywxbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="32200032"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="32200032"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 20:30:33 -0700
X-CSE-ConnectionGUID: 7bMaYcaeTbCRafYNV4UKWQ==
X-CSE-MsgGUID: ucs/tBJ8RDyQ0pniFZj1sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="57399489"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 20:30:33 -0700
From: Andi Kleen <ak@linux.intel.com>
To: namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v8 1/4] Create source symlink in perf object dir
Date: Tue,  6 Aug 2024 20:30:22 -0700
Message-ID: <20240807033025.894167-1-ak@linux.intel.com>
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

