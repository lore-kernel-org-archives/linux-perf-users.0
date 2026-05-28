Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814CA3F7ABE;
	Thu, 28 May 2026 15:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779982637; cv=none; b=kOzuoNclPPVQ0lDF4g592y9OtdDlhuNuTQmJJr5n88auinsld/lAynq4PPgUaFnpdGP+7ns5A1p84IW0yI9Bmk/slcvYVGxCeZxxAnJQTH1WCzXdf6JXfeIvR6AH6jrCCcldQxYwOjZOGQfq/FMfPVVGftus5XlY9xcGZIzxHVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779982637; c=relaxed/simple;
	bh=P0vwPUGmhTVVwGE8Q38vjEouuttL6DxHAI3dQg9RsnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltHJmVBEtcRLNnhn5J2XHDmPJ42Cft1pMjaYF33Qjdhl5GPWPabym+u4+LJZ2QrOA3/72FDNbmiZAkn+Kx3HoIBZLEQveHVdFuHem+LWjw/HA5Fu6gRCMA3xZnJ2z+czK/M2b5bP1lv/pmY33Db1mXwoKr3UBXPANCpKE5sFi9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JeX/xvZo; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JeX/xvZo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779982638; x=1811518638;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P0vwPUGmhTVVwGE8Q38vjEouuttL6DxHAI3dQg9RsnM=;
  b=JeX/xvZotivePGlbojl40vk3+dvAB+7NQ/LnFYWvG7dzJszzyNRU604e
   FGf+jwfTzMrWp/JyI5U+LZk6im5wgRHbBBZp+Gt5r3sCzX/IIchkOfuQ2
   c5SvyFAbEY8GwPLW26C/RScSm1k5apg9/+xyfcWLtnJxI27akMhXAFHfk
   ca1z0AFOJzXFoTP+OPDPDI0Z9+ofbv/FnGwL1m0nP1dtGeVAeBNGgoFAb
   ES6PxzYA6hfPDwe/xsYuVh/zlySJBy+c4knmkOwI1dQEaGTqn+rdSk4Dn
   oGXIHXqNA5ahSNnNbNmpfMrMIJVnD42fTwvl26MaTACM0KEaUnuq5qmg9
   w==;
X-CSE-ConnectionGUID: RI33Ww3eSy+ztUV+zorzJA==
X-CSE-MsgGUID: 4HVQMfcbTxu1EGbwYmz3vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="91396804"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="91396804"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 08:37:16 -0700
X-CSE-ConnectionGUID: W8O9eEx3S5GCU3ZKP2/oZg==
X-CSE-MsgGUID: RRAsuJn4RDiosCiiz9+zgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="236226862"
Received: from rodrigoa-mobl1.amr.corp.intel.com (HELO tfalcon-desk.intel.com) ([10.124.220.237])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 08:37:15 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH v3 1/2] perf script: Fix missing '+' indicator when branch counter reaches upper limit
Date: Thu, 28 May 2026 10:36:36 -0500
Message-ID: <20260528153637.300213-2-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528153637.300213-1-thomas.falcon@intel.com>
References: <20260528153637.300213-1-thomas.falcon@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

When displaying branch counter (br_cntr) information, a "+"
suffix represents that event occurrences may have been lost
due to branch counter saturation. However, this indicator was
missing in perf script. Add it back.

Before:

 # Branch counter abbr list:
 # cpu_core/event=0xc4,umask=0x20/ppp = A
 # cpu_core/instructions/ = B
 # cpu_core/MEM_INST_RETIRED.ALL_LOADS/ = C
 # cpu_core/MEM_LOAD_RETIRED.L2_MISS/ = D
 # '-' No event occurs
 # '+' Event occurrences may be lost due to branch counter saturated
...
        datasym+190:
        00005567f9951676        jz 0x5567f995162dr_cntr: BBBC   # PRED 1 cycles [1]
...
After:
...
        datasym+190:
        00005567f9951676        jz 0x5567f995162dr_cntr: BBB+C  # PRED 1 cycles [1]
...

Acked-by: Ian Rogers <irogers@google.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/builtin-script.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index c0918006e0ab..7d78adb7995a 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1288,8 +1288,12 @@ static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
 			if (!verbose) {
 				for (j = 0; j < num; j++)
 					printed += fprintf(fp, "%s", pos->abbr_name);
-			} else
-				printed += fprintf(fp, "%s %d ", pos->name, num);
+				if (mask && (num == mask))
+					printed += fprintf(fp, "+");
+			} else {
+				printed += fprintf(fp, "%s %d%s", pos->name,
+						   num, mask && (num == mask) ? "+ " : " ");
+			}
 		}
 		if (numprinted == 0 && !verbose)
 			printed += fprintf(fp, "-");
-- 
2.43.0

