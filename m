Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AA64A2D
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Feb 2024 18:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709059162; cv=none; b=ILjeF+J8MKUFPe+iO5fPlSiuRUnamaqwjLATg9P/QqM7gz3+geAuIzHIpHrWuu155P3CwrEd0AzXJquTQnCPxJNSs5p5JiWyXmYoQaPFe+yCAQGAr9RP1P90dQduHfwVfjBFdZ6MzRUcmU2PKIUTBohFRSJ4up6IqxddlqZUyF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709059162; c=relaxed/simple;
	bh=nFY6P1xRIBjiu4AA/goQz67sgBFkaRM/S5YF547VUMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hEDX6NzIgOHbvf58nmoyA/ngjFImBHTEzrtJ9+PBLWp4XRzKGBCXAOIm4sO0YpxwxMhacV/S/YZF1UufQiWlbv5k8u5TTSoGdem82B1jxD6rKoPgmYD32THf5fwEcVFOedXb2tV8v6uFBTOMvPHPK0QeskYzLbxh33easgi1FDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hjY25HoW; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hjY25HoW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709059162; x=1740595162;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nFY6P1xRIBjiu4AA/goQz67sgBFkaRM/S5YF547VUMc=;
  b=hjY25HoWa8zaXN2aKZMsVxh/TLxkGFy/Xd53UjUXbhYeKBFnD1pvObHj
   eP/2RcGwfOCz4ScFbrqcRFZW47ZqCW65mOsZLLpq+AMLDMTI+i/jMEaL4
   bnN3PZf5jqVR5bfoiDW2H3QNrly4nqvixJOZn0lD9RLNqXt57bPGI4FRO
   FVBqYrmF0wA1xSLUAtZbC0n5r/fIWgiVXQnK86MeOT0WQ9n15oYrWZoSN
   E9GPwhG8z+NaQLcUEv9ky5ZfN6Sw9nCGZtBKXg1YArAC2/+1jcJSOnQ89
   6ArA0icQdl/lEGEpd87S33/9hIFuOKf/tuatK/5LEune4WdSv6uL9MU4z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3542381"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="3542381"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 10:39:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="11716373"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 10:39:20 -0800
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: adrian.hunter@intel.com,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] perf, script: Minimize "not reaching sample" for brstackinsn
Date: Tue, 27 Feb 2024 10:39:10 -0800
Message-ID: <20240227183910.55824-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some situations perf script -F +brstackinsn sees a lot of
"not reaching sample" messages. This happens when the last LBR block
before the sample contains a branch that is not in the LBR,
and the instruction dumping stops.

$ perf record -b  emacs -Q --batch '()'
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.396 MB perf.data (443 samples) ]
$ perf script -F +brstackinsn
...
        00007f0ab2d171a4        insn: 41 0f 94 c0
        00007f0ab2d171a8        insn: 83 fa 01
        00007f0ab2d171ab        insn: 74 d3                     # PRED 6 cycles [313] 1.00 IPC
        00007f0ab2d17180        insn: 45 84 c0
        00007f0ab2d17183        insn: 74 28
        ... not reaching sample ...

$ perf script -F +brstackinsn | grep -c reach
136

This is a problem for further analysis that wants to see the full
code upto the sample.

There are two common cases where the message is bogus:
- The LBR only logs taken branches, but the branch might be a
conditional branch that is not taken (that is the most common
case actually)
- The LBR sampling uses a filter ignoring some branches,
but the perf script check checks for all branches.

This patch fixes these two conditions, by only checking
for conditional branches, as well as checking the perf_event_attr's
branch filter attributes.

For the test case above it fixes all the messages:

$ ./perf script -F +brstackinsn | grep -c reach
0

Note that there are still conditions when the message is hit --
sometimes there can be a unconditional branch that misses the LBR
update before the sample -- but they are much more rare now.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/builtin-script.c                              | 4 +++-
 tools/perf/util/dump-insn.c                              | 2 +-
 tools/perf/util/dump-insn.h                              | 2 +-
 tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c | 5 +++--
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 37088cc0ff1b..df2555fdb18f 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1378,7 +1378,9 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 		printed += fprintf(fp, "\n");
 		if (ilen == 0)
 			break;
-		if (arch_is_branch(buffer + off, len - off, x.is64bit) && start + off != sample->ip) {
+		if ((attr->branch_sample_type == 0 || attr->branch_sample_type & PERF_SAMPLE_BRANCH_ANY)
+				&& arch_is_uncond_branch(buffer + off, len - off, x.is64bit)
+				&& start + off != sample->ip) {
 			/*
 			 * Hit a missing branch. Just stop.
 			 */
diff --git a/tools/perf/util/dump-insn.c b/tools/perf/util/dump-insn.c
index 2bd8585db93c..c1cc0ade48d0 100644
--- a/tools/perf/util/dump-insn.c
+++ b/tools/perf/util/dump-insn.c
@@ -15,7 +15,7 @@ const char *dump_insn(struct perf_insn *x __maybe_unused,
 }
 
 __weak
-int arch_is_branch(const unsigned char *buf __maybe_unused,
+int arch_is_uncond_branch(const unsigned char *buf __maybe_unused,
 		   size_t len __maybe_unused,
 		   int x86_64 __maybe_unused)
 {
diff --git a/tools/perf/util/dump-insn.h b/tools/perf/util/dump-insn.h
index 650125061530..a5de239679d7 100644
--- a/tools/perf/util/dump-insn.h
+++ b/tools/perf/util/dump-insn.h
@@ -20,6 +20,6 @@ struct perf_insn {
 
 const char *dump_insn(struct perf_insn *x, u64 ip,
 		      u8 *inbuf, int inlen, int *lenp);
-int arch_is_branch(const unsigned char *buf, size_t len, int x86_64);
+int arch_is_uncond_branch(const unsigned char *buf, size_t len, int x86_64);
 
 #endif
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
index c5d57027ec23..292027a984a9 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
@@ -200,12 +200,13 @@ int intel_pt_get_insn(const unsigned char *buf, size_t len, int x86_64,
 	return 0;
 }
 
-int arch_is_branch(const unsigned char *buf, size_t len, int x86_64)
+int arch_is_uncond_branch(const unsigned char *buf, size_t len, int x86_64)
 {
 	struct intel_pt_insn in;
 	if (intel_pt_get_insn(buf, len, x86_64, &in) < 0)
 		return -1;
-	return in.branch != INTEL_PT_BR_NO_BRANCH;
+	return in.branch == INTEL_PT_BR_UNCONDITIONAL ||
+	       in.branch == INTEL_PT_BR_INDIRECT;
 }
 
 const char *dump_insn(struct perf_insn *x, uint64_t ip __maybe_unused,
-- 
2.43.0

