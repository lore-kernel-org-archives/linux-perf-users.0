Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B8D145A1A
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Aug 2024 21:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722547821; cv=none; b=WVOoAHrBnSuqGAsSRdwk8vgPUmkOwkm3eCtQPfYXxKXr+eMONODnrbmUxrqsOu6QP1FUwBWNA6PqmESj3Zbx/1PvxiiXZKgXVUfzxDbYpUHlw9taDWyMxRXulW62QCT++nGkpSUOuv2zFGaLQSv03J0aNbE7jC4UANoSQwQq+eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722547821; c=relaxed/simple;
	bh=g1OlhmAy73Mp9feG3NskfFydzuTb6Icd413Fv9iydHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X5vy/dFwERdC1v0Nhi1vlBFZh0fnNmLmtVY/WAONah8R7qmQxDE1NtPvXzVD39gAC/1+S2gn9xlHJ12SK9+qQeDYHf8G4IO9XUQNZGAYt+O2ulY9e6LtrREn1GkPu8sg0vVhWVzhRzvQQVtTCpvI/4ObmMD6IvDyqrIaQAtDMKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BU6rtoPZ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BU6rtoPZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722547820; x=1754083820;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=g1OlhmAy73Mp9feG3NskfFydzuTb6Icd413Fv9iydHU=;
  b=BU6rtoPZpcLxocZMMr0HEAOy2AwjxG3k+dGOojDJAmT/3OBDM9+w2a8E
   C7j7GcXD3wgDMFK7JsDqH/BtRrMVfA4RUGF/z9a5izytDMsx002en/cE4
   mS3vSfct8FoVtPlTYjBfBsbqWcY1XhtJvLKvb3L79hmJUBgfPydxFM5J/
   +ykGJG5X1j3+QGwXvmR9x9xDa7FQoAFF9gl8JJgkcbMi50ISvEV8YDlnc
   b+xgata6ln0qA8hqhTyPlb4Neev+dMSebZkPVsl4nQz+V3inTisXhpPoC
   BcApqEQN+1UGwbthbaTtSXFu0T4IQuTTQzLykFd6FDZ7+E2OapmclxSQ+
   g==;
X-CSE-ConnectionGUID: EYWfzMk6T0uyxJOsdhn7OQ==
X-CSE-MsgGUID: H/tdtwesQLCO2pwuNX8vYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="24309524"
X-IronPort-AV: E=Sophos;i="6.09,255,1716274800"; 
   d="scan'208";a="24309524"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 14:28:55 -0700
X-CSE-ConnectionGUID: UndXHui6QHWBQM//Jb6iMA==
X-CSE-MsgGUID: 6C8FvWrMRLWGh4uzqm54zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,255,1716274800"; 
   d="scan'208";a="55414347"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 14:28:55 -0700
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: namhyung@kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v8 1/4] Create source symlink in perf object dir
Date: Thu,  1 Aug 2024 14:28:41 -0700
Message-ID: <20240801212844.677895-1-ak@linux.intel.com>
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

