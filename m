Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FAB2F8EBB;
	Mon, 14 Sep 2026 01:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789350465; cv=none; b=HgeMoU3HAy5Zjl/hoo8OEbUgZzmn/la+DyBGj3Y0h7rNh95Jy1yuRZuETDAf6PXi8RaOIFVgIWKuWhO+hLaFov/97ijfABfJcbn6JQIzHlPdaWB9ppFTaSeEdm26AuaUwW2/NPbBCwi5My3Os8DYGxrdxb5Z9pvYSb1kM+ZFXNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789350465; c=relaxed/simple;
	bh=pm80ylUB24EdaTcYvUk2T9VT/BgRn8PM4tYeHi+311M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=idWPGUpuSOi2+t6GKF5NqA2EOczsL69SUOHzeTloNck7izLhHJD8zbxDZIpQdOjmt6/mRk9DPIPixA4DSaFIpN4nK4xVOFvXMd3ZnmHFQa7cggwspOhY9MEeZFhrTi90kOTpYHuSnLbe87kp7BxfAMfxAKX3HgYrvZsaNzG22Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HlHxa0vE; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HlHxa0vE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789350464; x=1820886464;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pm80ylUB24EdaTcYvUk2T9VT/BgRn8PM4tYeHi+311M=;
  b=HlHxa0vEBbyQYyXehY3/em69ZRzK5ov+OpthC9R+fiWyPBq5vzD7cCaU
   WsAO8BkafXZ4W0mZlugODWybPprKseFEg/8JRbXHj1HVJIe8mQopwTKNA
   cqf+hZRMgqvSb3KJjQRaeJTfRGtwVicEEq/yBIA73wNLHiQJS7pYxD5pT
   whJoYobxtXGJhzalvSwSGCKEtSUZKkXr0y1WZG/MGrjitb56p++ivS22b
   oipojzp0YjXLqMW7ToG2NX18+xMjsHRJXVA0RJVqR8KNRAb28A5ohQJc1
   4BtZbN5nQcUHgXO2QOf9reFozURwOKodNA7f5m5K9PuwOEi+jgEKvYMFQ
   w==;
X-CSE-ConnectionGUID: 9V+WcYwRRc+Seg5/O98YMA==
X-CSE-MsgGUID: xdfMnIoHRyW0l4seAxp7NA==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="93530607"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="93530607"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 18:47:42 -0700
X-CSE-ConnectionGUID: fDuKeHvjT3GU05AtqwEzWg==
X-CSE-MsgGUID: 2fy07q8mT0mRGrUb/T1uaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="276664158"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa005.jf.intel.com with ESMTP; 13 Sep 2026 18:47:40 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v11 02/10] perf util: Add missed fields in _attr__fprintf() and __attr_swap()
Date: Mon, 14 Sep 2026 09:40:41 +0800
Message-Id: <20260914014049.2061519-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914014049.2061519-1-dapeng1.mi@linux.intel.com>
References: <20260914014049.2061519-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some new introduced perf_event_attr fields, like config3 and config4,
are forgotten to add into perf_event_attr__fprintf() and
perf_event__attr_swap() helpers. Add these missed fields into these 2
helpers.

The aux_action is an exception. aux_action aliases bitfields
(e.g. aux_start_paused) in a union. Bitfields and plain u32 fields
follow different endian rules, so both views cannot be swapped
correctly at the same time. Leave aux_action unswapped until the ABI
is represented in a byte-order-safe form.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/util/perf_event_attr_fprintf.c |  4 ++++
 tools/perf/util/session.c                 | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 3933639d76c5..cc817294ad3d 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -405,6 +405,10 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 		PRINT_ATTRf_bf(aux_pause, p_unsigned);
 		PRINT_ATTRf_bf(aux_resume, p_unsigned);
 	}
+	if (attr_size >= offsetof(struct perf_event_attr, config4))
+		PRINT_ATTRf(config3, p_hex);
+	if (attr_size > offsetof(struct perf_event_attr, config4))
+		PRINT_ATTRf(config4, p_hex);
 
 	return ret;
 }
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 3237870a1a34..212506aa8baa 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -629,6 +629,16 @@ do { 						\
 	bswap_field_32(aux_watermark);
 	bswap_field_16(sample_max_stack);
 	bswap_field_32(aux_sample_size);
+	/*
+	 * aux_action aliases bitfields (e.g. aux_start_paused) in a union.
+	 * Bitfields and plain u32 fields follow different endian rules, so
+	 * both views cannot be swapped correctly at the same time.
+	 * Leave aux_action unswapped until the ABI is represented in a
+	 * byte-order-safe form.
+	 */
+	bswap_field_64(sig_data);
+	bswap_field_64(config3);
+	bswap_field_64(config4);
 
 	/*
 	 * After read_format are bitfields. Check read_format because
-- 
2.34.1

