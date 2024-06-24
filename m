Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C431A01B7;
	Mon, 24 Jun 2024 20:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719259905; cv=none; b=QBCbD8nN8RPpZ/agTEDWWkF8dsYtRUN2SyQlMlNBfAbWqqZEly7ZxmJEpuYCK9CMTUtO5tIDjVYCLroPAkANY97eKRrAM9AwkNFEvyiwZX4Fj73bm/1+nJwP54GjFT/BdLsO0jjj7keQpi4w6Dp7+JaXuoDrNPBcPUo6qC9zLiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719259905; c=relaxed/simple;
	bh=m5PT6H2l37YjBjjExK32x0SNpbjV59tsYSpAz13GBxg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MP8UPH1FV8iz4uqR4W23XDVD5WlWVznVnWJcNT5anOoN3v3NY763kpIc+SvkpXdbS5r57r5W9JLIjvcKCZlxTVxi5FeLFnW9KmLNz0viSFiBcXG1NJCdhIMHxci7XKXq9DKZPSPuTCOeNYhh/jBS/RORfAAm38hifNA3UW7AGrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F4iXtyUj; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F4iXtyUj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719259903; x=1750795903;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m5PT6H2l37YjBjjExK32x0SNpbjV59tsYSpAz13GBxg=;
  b=F4iXtyUjnknieFxUvuugdGY+5G4zmJIbSy8y1/HfkfGS1bAClgynYzZG
   JyyxBmzZGo+JlTSdYVJycMoUqLidgIQqpZ9ys0SVEBFBInKqzLHjsKPl0
   Qlvq5/ZDGmGHmWfFRsQM8a2C/CC3ZJWeNIqV0oCizSfl807fdUjqYf0yu
   u5zWmpqaXWotECgwp4xqZO6o3rxzzlDXSCM3hd5N4TxjmocytmXErEygq
   1nwWOP1CC2sb1CLe3R73Xezg4NLciE7CizIhDU3WBQARMPGJ5EKsPkD3E
   TGtW1z1E4V3I3CipMPUY61nDk2ucOxYlPukzBU6CGuZOn8K4iq2q0Z1Dg
   g==;
X-CSE-ConnectionGUID: guhszJeKTmKzjioLGWdKQw==
X-CSE-MsgGUID: FKtnOeD9ThqjtgvAHPh2Qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16128074"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="16128074"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 13:11:43 -0700
X-CSE-ConnectionGUID: 7/vlFVA8RzGOjaL5w8igKA==
X-CSE-MsgGUID: 7AkNTkkCQUOucFxR3g8nLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="43387314"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.94.249.84])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 13:11:39 -0700
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
Subject: [PATCH 6/7] perf: Fix default aux_watermark calculation
Date: Mon, 24 Jun 2024 23:11:00 +0300
Message-Id: <20240624201101.60186-7-adrian.hunter@intel.com>
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

The default aux_watermark is half the AUX area buffer size. In general,
on a 64-bit architecture, the AUX area buffer size could be a bigger than
fits in a 32-bit type, but the calculation does not allow for that
possibility.

However the aux_watermark value is recorded in a u32, so should not be
more than U32_MAX either.

Fix by doing the calculation in a correctly sized type, and limiting the
result to U32_MAX.

Fixes: d68e6799a5c8 ("perf: Cap allocation order at aux_watermark")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 kernel/events/ring_buffer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 4013408ce012..485cf0a66631 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -688,7 +688,9 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
 		 * max_order, to aid PMU drivers in double buffering.
 		 */
 		if (!watermark)
-			watermark = nr_pages << (PAGE_SHIFT - 1);
+			watermark = min_t(unsigned long,
+					  U32_MAX,
+					  (unsigned long)nr_pages << (PAGE_SHIFT - 1));
 
 		/*
 		 * Use aux_watermark as the basis for chunking to
-- 
2.34.1

