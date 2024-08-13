Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9468613AA4E
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 21:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723585020; cv=none; b=LnK+O8mygKVQrijCtNHjNsNobXKn4VNTDvtTuh+gqZABdUooyHpsFnkubISpUWJNQXsX9N/SuiLvZs6DYGTx4CyBmltS8SYwYAVVgyjJ2q7d7TPIz0grPQvsMK4p92HUpdOrV+ciZuijYztQ1a3qf8OI4efXpEFy6Wv8yHLcQFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723585020; c=relaxed/simple;
	bh=5hzNSDBdzhPEVAX5HlIciYKTHELm71rJhxGNAgr+Pfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=doVcyERP1RZ59ynSBEMBKvnERtYq0kFhSbg/JsQHnIfT/q/yIEBZpB7tYEIKboPOREl68QBSWiW0bbc4Geo1qoeFTB1BiGjGD8IlFWCtdP3cdoQKJekZSGITxBrTR2daqGzQ3KLzy3MRTNMlE2vlLnbzVO4579zN54XUMLIUJoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eD46695s; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eD46695s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723585018; x=1755121018;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5hzNSDBdzhPEVAX5HlIciYKTHELm71rJhxGNAgr+Pfc=;
  b=eD46695s5BN61RZ0iojwQYLPfsMJN7IOlibvKjd+3D80VLABqyQMyBzV
   GY9Xg87vIeo2Tw90Qp85MTq/cYq/f/f4zWpfZ2ofPK4D6fy3x6QjqZvl5
   /mtCpDIYcdrqg/ZEMSH+/WMYorH6xf0rGSf+mDLYVzqPzpgYF+fd2V9E5
   4j92EhqaK7bKlDMnxOgyxjlmSHUFNDCHoOgPQm4X0xm3qL3J7rBZdjxqB
   HYFiziVzLbddRDvG/3p5d3mU1gBOBwxCxVbYwLi9lLQAMKnoPG71+kh4J
   2yS1LRDe/3MO7oq7VEJQ+jGr0todTg9rnlJJXq5fqyijJL/SGCxCGk2fB
   Q==;
X-CSE-ConnectionGUID: UXVhT3uORdyf2g9Wpy+BQA==
X-CSE-MsgGUID: 92P0hHivQ5uDrcoQXqVP7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21746621"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="21746621"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 14:36:58 -0700
X-CSE-ConnectionGUID: xI4VMDngS/io8/9Xnpha5w==
X-CSE-MsgGUID: fO760yPNRterum280EUY5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="63734354"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 14:36:58 -0700
From: Andi Kleen <ak@linux.intel.com>
To: acme@kernel.org
Cc: linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v10 1/4] Create source symlink in perf object dir
Date: Tue, 13 Aug 2024 14:36:48 -0700
Message-ID: <20240813213651.1057362-1-ak@linux.intel.com>
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
Acked-by: Namhyung Kim <namhyung@kernel.org>
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

