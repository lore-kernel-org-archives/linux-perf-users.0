Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61974AEEA
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 16:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709223516; cv=none; b=qA49gJLMCWXaCY5ALHDtSckUGGpOqKuF7h0OMKUM6ThLknjNMdC8eMYX/oGVl94cd0CpH6jo3eHPuzXD2yFqPHhZKdvx33thgIpIWfsDWGG2dDD4wxxM1PpBV075Dc2QvM+YZhmjUhkbfSpfJsxWnof/UT8kosJHMZTNcKN498E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709223516; c=relaxed/simple;
	bh=uzhky99Nzh8wR1VdYTvNU7ITI/6WYSUIglrF7+xQoZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oDppZ3W5+d/fjfkvgRciI+ASsv6Gw8Z49UwC2QzBkd1tRmTd+dw8sqHvB2JT79iloqzDFxDBhDKV9c6FzHodMtZ6TseeS3P3r7an0UdF5GuHhPQj8p4mFVVGV7pSXCeh0H5C3dLCEhGvage91hpkGnp5uEZtqQkC1JNiJO+kX+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pf5j+3qQ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pf5j+3qQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709223514; x=1740759514;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uzhky99Nzh8wR1VdYTvNU7ITI/6WYSUIglrF7+xQoZA=;
  b=Pf5j+3qQa1M9Sgweh1CMvEWXJlIEleZvWct7oDH0aG3fcj6RTLRh7mwt
   5wQb3YHB5FV7s/coAyfLg7xPVNT0AaaHQIE2cmvIJ82LyBBE7UNOO/Dpp
   fdYc6G+vAGAY0m2DG2ayHDm235VKGN8NQ5sy9FUJyob4/KyhkAcpAXg+8
   WoB4pJwqDe4zEWBTq2LZAEvXsE0SHQ20gC/gxQHQ+WSW/dsoss54MnmRF
   isDmvNYs79R3UxFX9x/5e5GdE6RAAHNrQPr/zH2473JQ1DZlkhuBq1h6i
   SSYvys2khUkWdZvAv+810em6TjLt9DieL6TO82WRmJgEzRDjcw+dy8uOa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="4283688"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="4283688"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 08:18:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="7806193"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 08:18:33 -0800
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: adrian.hunter@intel.com,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v2] perf, script: Minimize "not reaching sample" for brstackinsn
Date: Thu, 29 Feb 2024 08:18:28 -0800
Message-ID: <20240229161828.386397-1-ak@linux.intel.com>
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

--

v2: Adjust comment (Adrian Hunter)
---
 tools/perf/builtin-script.c                              | 6 ++++--
 tools/perf/util/dump-insn.c                              | 2 +-
 tools/perf/util/dump-insn.h                              | 2 +-
 tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c | 5 +++--
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 37088cc0ff1b..b97f810ad00e 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1343,7 +1343,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 	 * Due to pipeline delays the LBRs might be missing a branch
 	 * or two, which can result in very large or negative blocks
 	 * between final branch and sample. When this happens just
-	 * continue walking after the last TO until we hit a branch.
+	 * continue walking after the last TO.
 	 */
 	start = entries[0].to;
 	end = sample->ip;
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

