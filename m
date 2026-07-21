Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C020442BEA8;
	Tue, 21 Jul 2026 07:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784619235; cv=none; b=apgKO9bNIqQkJV+ZGOOOllXcI5WhE/XiHjjrGNjeUBZ+Rw/PnGdkuRfPoDoRNDLzgDEZWo8kb4ajAsT2xpPBM+tnPRTDMuTkO+l1+VCyuPJHHngyGWSWktoa5TaFvMm/fSOhRuypocZUllnMXmmieDJ+j/VZqac5y05MQ9bBs7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784619235; c=relaxed/simple;
	bh=pm80ylUB24EdaTcYvUk2T9VT/BgRn8PM4tYeHi+311M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hYirGkfCyKKrEb+RrFw3eTKSe+HFrOGlUPXUTH0ffVEp1syMVuPlZqg2gSJcuKXHFqJc/DrsAr1ZzSEH9als895F/qwTswoZxoiMwvS2swCr1YRtseBksDxZjzUMpxHmQHuuMI3qIYzRkSCvGFCMeaoUY7jwbU91QehBZTIlrcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zo1pg18p; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zo1pg18p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784619233; x=1816155233;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pm80ylUB24EdaTcYvUk2T9VT/BgRn8PM4tYeHi+311M=;
  b=Zo1pg18ptftYI4kz1RLfVltHcRJsN5eexIhHJaOlKndafYCBQrrIME0m
   5Ym6Dn5Gh9XbAZ8EC+Sd3c3WiM4gBnPqUUATXcY/V5sPbw8Xo4H0zfRxJ
   R/3Atumdo4kS8b9DEZybrC2HEvcdqTJxDQEgRUY/qSBgsqP4Uk348xWwA
   hQkUVoCO5G4KqCSyIX0xHFn5TtFOBCcJyr1m699O1v0rugI4hDofF/9gk
   oL1dgnmARITzuqXzYuDqQvQ3OYZC3Kk5XymG+KqGjfr4xpNt+dNeaoYrz
   hAX4p4ZDSqF9RZ4T5lemCEqo2gWbn0ItOTuqYV+i/vEe42FvTsYwUmXXb
   Q==;
X-CSE-ConnectionGUID: ZDbRH2u2THWxd8cHNgGDdw==
X-CSE-MsgGUID: YTJ3b/CQQzmQh0n4+Mi0CQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="84190110"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="84190110"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 00:33:53 -0700
X-CSE-ConnectionGUID: JD3s5NR3QdWCpBJhtn6DPw==
X-CSE-MsgGUID: ZoMV67JTTfCBWmm4p0yzbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="256484451"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa010.jf.intel.com with ESMTP; 21 Jul 2026 00:33:50 -0700
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
Subject: [Patch v10 02/10] perf util: Add missed fields in _attr__fprintf() and __attr_swap()
Date: Tue, 21 Jul 2026 15:26:59 +0800
Message-Id: <20260721072707.3787848-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260721072707.3787848-1-dapeng1.mi@linux.intel.com>
References: <20260721072707.3787848-1-dapeng1.mi@linux.intel.com>
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

