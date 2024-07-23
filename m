Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6070200A3
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jul 2024 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721767728; cv=none; b=HBN/5sVOjY9TtC9Ox++l0evCFZ9TpBbSnqwU8m5lNu574NgCOrY1wP6UYrNNGNfzgiuc7ogZCUY7TVDQIVYHRvq7BjFYeUj6ZmDyWqLeZ5JmDw/IW9x22mMfliMXS4Xp+YupjsRhseGF2b5PrkzCnKYmGrTTtAgcIShuFMf70Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721767728; c=relaxed/simple;
	bh=g1OlhmAy73Mp9feG3NskfFydzuTb6Icd413Fv9iydHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dT3tQnRx6S9PqWaKZ7e3Z1U9YsHIpMQV+E1KdGkyrFpL63Hz+FtVrhNCGL9z7kfVu8mLczgHmPrSLN+hJoZaGGISfMkWycxDOwWZW1xNQRe/a2anZu2daXjWE/OybazRPMNrgtuWxwiHRO1xG4C27R/W0TF+8wy//tYslQQqRAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C42VklcI; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C42VklcI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721767727; x=1753303727;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=g1OlhmAy73Mp9feG3NskfFydzuTb6Icd413Fv9iydHU=;
  b=C42VklcI7sEH76RAGQAl5XOGxiOUo8mUjC5Z9O9UvSw3ijWCFs5WElN7
   vf3/LwGYRwo1aMYDuzNs6uVmvhkOkc/atNQ5w2uQ3uimaLVtXuw8K6XdB
   PZZmeBM+n6OXpkR29k9m35zvCTOy0A5TizKs/Z8Wzo+/W8yhSzwqPwWmX
   cmcpINbx77wu/1rAombQhHFgAeHQtsRiJX6X8Nicn2vfs+7j2ncOFnSW6
   zAfOydjttaNd4hMqAO5t9C6i95ADP0udWGwYnjyCnvKfoF8ph6k7tMt2O
   Yged2pBtlQVaycgWp7Nfi/GSbEzXGJzw6nIyZLLo7uUUCifiQFDepF23s
   Q==;
X-CSE-ConnectionGUID: dU9sY/czQEW5c70r6mts7g==
X-CSE-MsgGUID: 5JRrMkJJQzyIkRo+lSkDIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="19564600"
X-IronPort-AV: E=Sophos;i="6.09,231,1716274800"; 
   d="scan'208";a="19564600"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 13:48:46 -0700
X-CSE-ConnectionGUID: JGPyQN4QT5CxAPGfzTuPBQ==
X-CSE-MsgGUID: m15n7GCrSLatMZQELKz6PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,231,1716274800"; 
   d="scan'208";a="56654792"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 13:48:46 -0700
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v6 1/4] Create source symlink in perf object dir
Date: Tue, 23 Jul 2024 13:48:31 -0700
Message-ID: <20240723204834.3617647-1-ak@linux.intel.com>
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

