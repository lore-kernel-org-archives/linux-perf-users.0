Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF6C1A08D3;
	Mon, 24 Jun 2024 20:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719259891; cv=none; b=Rsr6T0aEVqPC8f4XqpJwCMe+k3Y/sk2k3gHWdDk9gujgl64TlF603ZEb0dzZqazcVHdYuiW3/5RARrRKU9SGhPn1ly+tBch2eHfBnyY8uX+F3h3rxKCkxbZjFolHdoB7Hx2htD4NVLVrXhzHkpUMXuPmBdwDJA3O8y5ATeTXQgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719259891; c=relaxed/simple;
	bh=AaPqESWEDPGESWfQKqUKas1AhKUHkg15T7RLbHL0kio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qXasd2N/ol3OuExluXHGqx2zsrdogBZ5INMgj62o/04PiZdxpWNf8OPX73HF3ckLEaBlm3bHSDpzM7jr2rHtst6U7rk01Qj7c195rh0doM0Mn5ksapY/uhzGp0xa6lpckqYhzv2it1JHgecPx2yhSVHr/7uPbrkFa97mqh876MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O0joplfw; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O0joplfw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719259890; x=1750795890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AaPqESWEDPGESWfQKqUKas1AhKUHkg15T7RLbHL0kio=;
  b=O0joplfwVcFnx0AIPzSRrjsfezKxkoc5GQ8+7eT/w5U0/fNMITn79lnH
   WBQ7Xt3ZG9OLM+2w6S5fb+oJoKkupSB7Mi/Qae3jKsZ3st3X1HL5Bed/j
   qeh0j6WIpNVbDhT2uS0EvppTaPDqXlcoOcvcRZYMV69Q54nhXtKt4mYxS
   tojSSFJYpOoNDZeiyLXLuw/WyI9N94lvY/5Kl288M8cunxm3po3KxfIuy
   q5Q6e31zvEd0GuXzeKasQZ966UvZGErEPrdIFlUlNxCqCD8md9Ia3DZ31
   Zv8DjUADVMRToKo+yeBSpni5k7aoUlOUO5+3gQXmE8qAewpMXoOPrpxuk
   A==;
X-CSE-ConnectionGUID: RC3bjA8YSqePs1CVs2duWw==
X-CSE-MsgGUID: BRldsNkDSCuWmMC3zRfrQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16128027"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="16128027"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 13:11:29 -0700
X-CSE-ConnectionGUID: goBri26jSGiGwaeCiuSLGw==
X-CSE-MsgGUID: ZVmXp0VURW2uvVbd8jduLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="43387290"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.94.249.84])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 13:11:26 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	H Peter Anvin <hpa@zytor.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Marco Cavenati <cavenati.marco@gmail.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 3/7] perf/x86/intel/pt: Fix pt_topa_entry_for_page() address calculation
Date: Mon, 24 Jun 2024 23:10:57 +0300
Message-Id: <20240624201101.60186-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624201101.60186-1-adrian.hunter@intel.com>
References: <20240624201101.60186-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Currently, perf allocates an array of page pointers which is limited in
size by MAX_PAGE_ORDER. That in turn limits the maximum Intel PT buffer
size to 2GiB. Should that limitation be lifted, the Intel PT driver can
support larger sizes, except for one calculation in
pt_topa_entry_for_page(), which is limited to 32-bits.

Fix pt_topa_entry_for_page() address calculation by adding a cast.

Fixes: 39152ee51b77 ("perf/x86/intel/pt: Get rid of reverse lookup table for ToPA")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 arch/x86/events/intel/pt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 047a2cd5b3fe..b4aa8daa4773 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -990,7 +990,7 @@ pt_topa_entry_for_page(struct pt_buffer *buf, unsigned int pg)
 	 * order allocations, there shouldn't be many of these.
 	 */
 	list_for_each_entry(topa, &buf->tables, list) {
-		if (topa->offset + topa->size > pg << PAGE_SHIFT)
+		if (topa->offset + topa->size > (unsigned long)pg << PAGE_SHIFT)
 			goto found;
 	}
 
-- 
2.34.1

