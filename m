Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4144B250EC
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Aug 2024 23:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723072714; cv=none; b=YgG0YWFpBZ+UcrF11UITN/RB0bDL/o9jNITRyEuQ0avguiQa+X4ghStDeRu9ZpbSAnfPYkLrjwXWvGHUqwJFuo/IQBYukycN5p5GygwCeLDaqSzMexYlhP9XYJUAGpiGvrZKnUKL1eWBd/3x89R7XBAwZ+vY1z8UJ/dMKFI1cOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723072714; c=relaxed/simple;
	bh=g1OlhmAy73Mp9feG3NskfFydzuTb6Icd413Fv9iydHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gEMEpVUX0zPlf/nNvAAO/zEd1uowEZo9y0V+21/L+2+zOsMOEqP7IFNorP115MCxIkY49SmLTLWrhsUFBUbBmVQYuQtexJC/mEzChzFrnaNU+WVzy9Az2W4tmDGeVKrAntfqopvorMMPLkKUmGl+HdMrXUY0PudSACm98sD/zPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cPcgDUsF; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cPcgDUsF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723072713; x=1754608713;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=g1OlhmAy73Mp9feG3NskfFydzuTb6Icd413Fv9iydHU=;
  b=cPcgDUsFGtEUPMsJPdzxaU4GdJaHTwTW/AZAdx0CyFpp4OOmp+oEG/Z/
   ta2qpp8kPWnT1WUSfafiSqxovke6c2DmoGLd4RujMb+YJgz5VGujoJweW
   VQQcQYqzO2zWTLeMHYEfAuvrR/3BALZIzfPz21xjClRyqKlgm+QVbceaO
   zpVEvHH/D3J+KN3xoa5sbYGYq3zjH33aRwxon/o42Bi4jfZKedSD3Xc8l
   rN99H8x3U626ZdakEmRd2lB9Swe/wTqcCp+sZIsZfP4p6nnF7Gyf3Ld7s
   C4iUprXyJ9tMtibTla71usq+JMXJXvrYDLdL+w9DOgCLMs+hkq+hbFUca
   Q==;
X-CSE-ConnectionGUID: 5/O4IV8/QveELB7hk6MkAg==
X-CSE-MsgGUID: Qz/MGx3zQIyipPG3k7z9cw==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="32577979"
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="32577979"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 16:18:33 -0700
X-CSE-ConnectionGUID: buKa41peT02oGSBLpczx5A==
X-CSE-MsgGUID: Anzxx+VySe24Kdm/VyqMMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="87935091"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 16:18:32 -0700
From: Andi Kleen <ak@linux.intel.com>
To: namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v9 1/4] Create source symlink in perf object dir
Date: Wed,  7 Aug 2024 16:18:20 -0700
Message-ID: <20240807231823.898979-1-ak@linux.intel.com>
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

