Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40960430CF4;
	Tue, 21 Jul 2026 07:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784617419; cv=none; b=eYtxGwguEYSUud9wORa5pNrrMWZ2hZrmBiQ7WyQGCuC2UpMKBbcx9S1oEufQOhXxL18OlEsYWTj/PEv4ATsaSq6EeYFMHN8IVkLcd8o8e8Q2/K8Lr4fq2JLs7xL18xrQ7NMv7Agc39EUP4XZ6bUTZNGGEYD4CYlG0gdKbDlVwaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784617419; c=relaxed/simple;
	bh=fZSLRntAQAsNigCKOb/JIqWmsCXowWJHNP/OxZpHdlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5zN4D85fv6ZTxOAxAeeOMVnml+OHhURUM2XGZjWcRKDXZMYWT+UzUNlPBwlW1Dup9CNs1vARHELxzYve1oinEPE8QJLEa0F8jb3KM/z+sTFfOljaGhqZ7S2heanSu5RC3dtB7F/jqc9vHqZD6Bkxr5hGR5ojlbUl9X6dDik1jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rk4/YOXh; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rk4/YOXh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784617416; x=1816153416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fZSLRntAQAsNigCKOb/JIqWmsCXowWJHNP/OxZpHdlo=;
  b=Rk4/YOXhml/sMa1xP8rUM8SiSoHYFr0VWiGRySOIAzjbbqrbJLFnH/eX
   Boq+IS49LOLNdTSQQbKhotGIxFWWxu0WhSreq2cG/OoeXm03iohWjzpWo
   CSWxCP/lkfKy3JQWWHr85Pf0SAYHhQCexrIL9YMm29PL56ux0ruxv4ZNC
   enXXEwB262H1tAcHgVLo5JF/Bh6jfIUq38+fCKBvb3gbs86sj0HPQ8s63
   +3QwtjKtng3Fs+HpGkXOetJfqArVyk2GL1uWZaA/kUVf7QVtmN9XFqoWw
   1btJuyojg8aEznJTjdZd7qYKJCngdUPoo77wH0MFfX36OfJS4Uut4MwHB
   A==;
X-CSE-ConnectionGUID: 4/5ekZZiRImVhZN4DJScqw==
X-CSE-MsgGUID: Cj8jySmASCK+pJzi05R6kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="96717615"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="96717615"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 00:03:32 -0700
X-CSE-ConnectionGUID: A57DBL9PRN+LVssYH00t8w==
X-CSE-MsgGUID: mPQjLjKJS6aIxP1GrvgUcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="255036639"
Received: from abityuts-desk.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.245.17])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 00:03:12 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/3] perf/x86/intel/pt: Factor out pt_config_enable()
Date: Tue, 21 Jul 2026 10:02:52 +0300
Message-ID: <20260721070254.13557-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721070254.13557-1-adrian.hunter@intel.com>
References: <20260721070254.13557-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

pt_config() enables tracing by allowing NMIs and pause/resume, issuing
the necessary barriers, and calling pt_config_start().  A later change
needs to re-enable tracing on a (re-)start path without repeating the
full pt_config() setup (filters, RTIT_CTL, buffer configuration).

Factor that enabling sequence out into a new helper, pt_config_enable(),
so it can be called on its own.

No functional change intended.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 arch/x86/events/intel/pt.c | 41 ++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index b5726b50e77d..dc1be7f6e04b 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -502,6 +502,29 @@ static u64 pt_config_filters(struct perf_event *event)
 	return rtit_ctl;
 }
 
+static void pt_config_enable(struct perf_event *event)
+{
+	struct pt *pt = this_cpu_ptr(&pt_ctx);
+
+	/*
+	 * Allow resume before starting so as not to overwrite a value set by a
+	 * PMI.
+	 */
+	barrier();
+	WRITE_ONCE(pt->resume_allowed, 1);
+	/* Configuration is complete, it is now OK to handle an NMI */
+	barrier();
+	WRITE_ONCE(pt->handle_nmi, 1);
+	barrier();
+	pt_config_start(event);
+	barrier();
+	/*
+	 * Allow pause after starting so its pt_config_stop() doesn't race with
+	 * pt_config_start().
+	 */
+	WRITE_ONCE(pt->pause_allowed, 1);
+}
+
 static void pt_config(struct perf_event *event)
 {
 	struct pt *pt = this_cpu_ptr(&pt_ctx);
@@ -541,23 +564,7 @@ static void pt_config(struct perf_event *event)
 
 	event->hw.aux_config = reg;
 
-	/*
-	 * Allow resume before starting so as not to overwrite a value set by a
-	 * PMI.
-	 */
-	barrier();
-	WRITE_ONCE(pt->resume_allowed, 1);
-	/* Configuration is complete, it is now OK to handle an NMI */
-	barrier();
-	WRITE_ONCE(pt->handle_nmi, 1);
-	barrier();
-	pt_config_start(event);
-	barrier();
-	/*
-	 * Allow pause after starting so its pt_config_stop() doesn't race with
-	 * pt_config_start().
-	 */
-	WRITE_ONCE(pt->pause_allowed, 1);
+	pt_config_enable(event);
 }
 
 static void pt_config_stop(struct perf_event *event)
-- 
2.53.0

