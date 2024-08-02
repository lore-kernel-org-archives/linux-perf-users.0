Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E831ABEB8
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Aug 2024 21:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722633340; cv=none; b=VZIuPAd2CYv9RDxtgd7zx2QeRNn05GQwcVYkIRoDcH7R2QSAkuVXWojFJ+iTmVpGEELFIECvaIXUsgBVpFxpp4tdSBkRSBTHUDSrF2mHd1lrPaBwmNGm4wWy1JLflWExK0H2ecYbVT6C7lUKc4k7ytQdH/Ztjsv5IUQcZNgg4Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722633340; c=relaxed/simple;
	bh=VOHRm/vxUsTMGvDEi3PQq3EOa6tgvekNCjR7LOrMpdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DWYiTlbhfGRkQ01qYINT/ytZ+DtKB4CfZsjxBJ+FPF6ntNvVt6jC2syV/yxJl5GluCd4silSmlXmaUjICLOcEm30Gfnvnr4jrrvWbM1lQoO7xybvEq4YaUx9kT8kh8K3pvnssq+9Jo8vQK9ihFqjXkps1ROkorKR7Ecvvyh7rIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UorGTE0W; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UorGTE0W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722633339; x=1754169339;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VOHRm/vxUsTMGvDEi3PQq3EOa6tgvekNCjR7LOrMpdA=;
  b=UorGTE0W6qHyk6w7RS9bcDxVc6GGQWi15yeQY5nwgDyfqynrMg+Wrf5v
   vw08XNXQXFwdbLvL1RaV29k2sxVdn+CMppa4zM9bQKmArlBDWzxpdggwQ
   kVz8FE4Td1AF66XbVGozIloQaJ7Um/NyP1iVDPCeSs0kEPQbOvotTRYWL
   75gI2Ai7pVwGCR0X/fkL8Axmk2WVMxyxYf1yonmBQeZAGIdrT4GnEQ3JV
   hYZNuuZ7m8Rb/07Kqbbe5Y/IXP5osgf8jgyLTLAagk+U1hf9qYAGAYtVH
   LLY7gaKY724WHwR5LEUjqt1Ol5AZRDsEExOUqaoze78lLhsS5mRr1PREC
   w==;
X-CSE-ConnectionGUID: Tg3NfGz+Sg2FtfAcee2kyQ==
X-CSE-MsgGUID: Lk41KD5kRNWFY6m6OnueNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="31246283"
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="31246283"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 14:15:36 -0700
X-CSE-ConnectionGUID: bPd04SCwQtqoDw1T0bDoBQ==
X-CSE-MsgGUID: TG5UMEJZToydAJR32luABw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="56282264"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 14:15:35 -0700
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 1/2] perf script: Add summary to brstackinsn / brstackdisasm
Date: Fri,  2 Aug 2024 14:14:17 -0700
Message-ID: <20240802211530.776055-2-ak@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802211530.776055-1-ak@linux.intel.com>
References: <20240802211530.776055-1-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Print the total average IPC and total instructions for the last LBR entry.
This can be useful to quickly estimate if a sample shows problematic
code or not.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/builtin-script.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index c16224b1fef3..d8646366ac74 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1195,7 +1195,8 @@ static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
 			    struct perf_insn *x, u8 *inbuf, int len,
 			    int insn, FILE *fp, int *total_cycles,
 			    struct perf_event_attr *attr,
-			    struct thread *thread)
+			    struct thread *thread,
+			    int total_insn, bool end)
 {
 	int ilen = 0;
 	int printed = fprintf(fp, "\t%016" PRIx64 "\t", ip);
@@ -1227,6 +1228,11 @@ static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
 		if (insn)
 			printed += fprintf(fp, " %.2f IPC", (float)insn / en->flags.cycles);
 	}
+	if (end) { 
+		printed += fprintf(fp, " %.2f total-IPC %d total-insns",
+				(float)total_insn / *total_cycles,
+				total_insn);
+	}
 
 	return printed + fprintf(fp, "\n");
 }
@@ -1285,6 +1291,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 	unsigned off;
 	struct symbol *lastsym = NULL;
 	int total_cycles = 0;
+	int total_insn = 0;
 
 	if (!(br && br->nr))
 		return 0;
@@ -1307,7 +1314,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 					   x.cpumode, x.cpu, &lastsym, attr, fp);
 		printed += ip__fprintf_jump(entries[nr - 1].from, &entries[nr - 1],
 					    &x, buffer, len, 0, fp, &total_cycles,
-					    attr, thread);
+					    attr, thread, 0, false);
 		if (PRINT_FIELD(SRCCODE))
 			printed += print_srccode(thread, x.cpumode, entries[nr - 1].from);
 	}
@@ -1338,7 +1345,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 			printed += ip__fprintf_sym(ip, thread, x.cpumode, x.cpu, &lastsym, attr, fp);
 			if (ip == end) {
 				printed += ip__fprintf_jump(ip, &entries[i], &x, buffer + off, len - off, ++insn, fp,
-							    &total_cycles, attr, thread);
+							    &total_cycles, attr, thread, total_insn, i == 0);
 				if (PRINT_FIELD(SRCCODE))
 					printed += print_srccode(thread, x.cpumode, ip);
 				break;
@@ -1346,6 +1353,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 				ilen = 0;
 				printed += fprintf(fp, "\t%016" PRIx64 "\t", ip);
 				printed += any_dump_insn(attr, &x, ip, buffer + off, len - off, &ilen, fp);
+				total_insn++;
 				if (PRINT_FIELD(BRSTACKINSNLEN))
 					printed += fprintf(fp, "\tilen: %d", ilen);
 				printed += fprintf(fp, "\n");
-- 
2.45.2

