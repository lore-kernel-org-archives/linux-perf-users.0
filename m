Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82403AA1A8;
	Mon,  6 Jul 2026 02:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783305654; cv=none; b=TE6C44gwRcxq9SSD1iToQDwTzEcn6vJkFNre2K4OOrio1D890POU0Tb+UcXlf6ciS//rMtXLN1apNNV+bFX9Fs7+uF01EYdaFesBiLCJ6QC23FCoc0QxA9uHpAZ31WF0fbCXAHRoTl6oi7geyRXzUXm/ppW+7qADLNs24aaKsaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783305654; c=relaxed/simple;
	bh=pm80ylUB24EdaTcYvUk2T9VT/BgRn8PM4tYeHi+311M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L8HAPjOEyLMnvDbKufjcSgnVx8tpH5z0fz5rqzbAQGc6epj10qtJoM5hhAJ3TBZ00wUqsJwrIuUV1i1HPaRE6MzytwB08Zsap4z74WEJzbiGl+FSnnF4c0swwPNphtZhLj5aOXUTo/gy3X9e69Ze7U7VyFWMMe4E2dkgtua/bZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C0klg8v5; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C0klg8v5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783305653; x=1814841653;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pm80ylUB24EdaTcYvUk2T9VT/BgRn8PM4tYeHi+311M=;
  b=C0klg8v5JpvgRjkqgvxvLiXNULa5M75L8gmkCMIpn6P7k7mkVwSOvDbP
   L/pnTqP5IlOhpaJt5Q2xKT67DO9hd/en4QwEoLWdXWJvdREKR+Gs5qTwH
   Ve4oLfdTefPkgGrQKj2t1Ud1BzecacaJ/0w2WbUGxWuh4iag8ZiFv7mAN
   iqh9vl/FIGkF7WMmW956Y1MPAShNnT8Q3x/pB4WpoLpJncoJre7BQHg9z
   QSpjqlrNlzjd3ylaVC6n9usA2PpH+B05g0o6z1lxbb0VoL10uZZdL+7Gn
   eKFCnEm/NMAYh7xWaiTnNUzZyQ2wHqU5ifNjL53mQhP+5/x/BH61gOWx9
   Q==;
X-CSE-ConnectionGUID: VItCbbOxQteJfnQmxssuyQ==
X-CSE-MsgGUID: 68+l5MsARYmTLCSZiaimcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="87614034"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="87614034"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 19:40:53 -0700
X-CSE-ConnectionGUID: cpZlkex1TmGq8DTIrG/s0g==
X-CSE-MsgGUID: s4684uVhSnmcBek9ZbIY+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="253716697"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa007.jf.intel.com with ESMTP; 05 Jul 2026 19:40:49 -0700
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
Subject: [Patch v9 02/10] perf util: Add missed fields in _attr__fprintf() and __attr_swap()
Date: Mon,  6 Jul 2026 10:34:36 +0800
Message-Id: <20260706023444.3067660-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706023444.3067660-1-dapeng1.mi@linux.intel.com>
References: <20260706023444.3067660-1-dapeng1.mi@linux.intel.com>
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

