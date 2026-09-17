Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990B11CAA78;
	Thu, 17 Sep 2026 01:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610393; cv=none; b=ioSM66N5J3QYCRdkeZoD/zMxg7l56XLEKASFQ1YRg+w8TCsGolgCjbzeGWJt+NW0hlfTVXepZCO/aKwCkfIedV0r84NkfV0baXMeSmNtZrA1u1KsyTbyMQNDXLcoeENBBR0ZqJUYaqB2zhhFUaKpYrPZcgH84lrerSldUBzcYUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610393; c=relaxed/simple;
	bh=HEumJlMG1mTj3up2KJdWdyiaJMiR4wrOD5RfUrJd2yE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MpmiZzwSD81+bOt+cBpV6d044nxuBNrw+vX2MvtCCKB9LIyETT/0UH1vgiwTLk24zIFDF5bH0bl66vH8Ald0QHcHBJCHYCTZ7DGskeCfmIOTy8ldJ3LIbO0y2HHkNpL9PfjtZDkJsDVtzhMnf6yu9/Mf4gooMPDesoWedFSN3sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kGE8hpoY; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kGE8hpoY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789610391; x=1821146391;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HEumJlMG1mTj3up2KJdWdyiaJMiR4wrOD5RfUrJd2yE=;
  b=kGE8hpoYLixFB6/+u05zH5FSw8nOpeae1DqmOaD6kGztNA+PElixNI8g
   JuQE2zRQtwJE3YX7ZOZ5OZ+HvG2aKlVR0NpsD9vJS8qRvNV+/MhsWPj8K
   WDvWkChO/D+6K38oiQ0bB+nyGnaTxFvBuG76a6/1B7GUDOEGs+2Rtj5vt
   5Xn2MJFjmoHrw/l3AI5OmU+oIbTvjbPePHKUDO5SKgtNBFu2pNc4iBRsK
   /k7KEVwiJg7kU8Lj0OIvAFvWs6pP5o/VvD1zGP8WldoangrvIFDKtqBrr
   2aK3TPnrNts5lpAdrWLSQLMa5f1mRlSOTcO6Nm6SyXlvo5RPLXRB7Kd/z
   Q==;
X-CSE-ConnectionGUID: AKQdcR6bTKqoj0UGLerGkQ==
X-CSE-MsgGUID: 8LOLRRYPTeuZdALVCnwdmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="107498546"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="107498546"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 18:59:51 -0700
X-CSE-ConnectionGUID: Ch5miffARRaAfzfxsMhVTw==
X-CSE-MsgGUID: T6Q7j2zoSoCpOKioQVdhuw==
X-ExtLoop1: 1
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa003.fm.intel.com with ESMTP; 16 Sep 2026 18:59:48 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 04/12] perf/x86/intel: Update arw_latency_data() mem-op direction handling
Date: Thu, 17 Sep 2026 09:52:26 +0800
Message-Id: <20260917015234.981153-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917015234.981153-1-dapeng1.mi@linux.intel.com>
References: <20260917015234.981153-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Align arw_latency_data() with other *_latency_data() helpers by
explicitly decoding LOAD/STORE event flags when setting the sampled
memory operation direction.

This keeps the latency data path behavior consistent across platforms
and avoids relying on implicit direction inference.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/ds.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 95b3ed3097ab..a189a68f5e85 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -538,7 +538,11 @@ static u64 arw_latency_data(struct perf_event *event, u64 status)
 		val |= P(BLK, NA);
 
 	src.val = val;
-	if (event->hw.flags & PERF_X86_EVENT_PEBS_ST_HSW)
+	if (event->hw.flags &
+	    (PERF_X86_EVENT_PEBS_LDLAT | PERF_X86_EVENT_PEBS_LD_HSW))
+		src.mem_op = P(OP, LOAD);
+	if (event->hw.flags &
+	    (PERF_X86_EVENT_PEBS_STLAT | PERF_X86_EVENT_PEBS_ST_HSW))
 		src.mem_op = P(OP, STORE);
 
 	return src.val;
-- 
2.34.1

