Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119507992F
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Jan 2024 18:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706640998; cv=none; b=FYKka642LxYe3NEF5qQL03qbYvAVF+UGBZ0XsRnJVSD851sRSe8OryIVfG+vyBzxO7+xWktFe2K2biTOyi2vhmWYOhhUY7BGGcKaCpuwfS0aWCRqYRGFlbBgQWBodDv7zCb1xk0AFl6GXDYbz4Vroi+CN53yQtnW6EJy0qesk1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706640998; c=relaxed/simple;
	bh=jVRNnz3Dfrv1Uy5xN+gG5XI++T3PKGV0ZAgwJDtgB0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KSV40UfBLojtfiv8o9Bo3HjGgWMAuWbXiCrJOkFO8kEJAsL6d1yxo+99Ju0/Us8SJykrQRE9oy+CvTPdHHup8ZDw9nfFsH4QrTHDOrzOO/oj2JcnimSeu2HP+UVb73k5ZfH4hxWjJ4j8VaPa28C5FUUV8euGIAC5fdY0cEzDewM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lJcwMYbe; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lJcwMYbe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706640997; x=1738176997;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jVRNnz3Dfrv1Uy5xN+gG5XI++T3PKGV0ZAgwJDtgB0k=;
  b=lJcwMYbeBbWQAjBk1JwCTFFjF21vjxBPExj627shtW4SuaWxOTn3/V7p
   19sRsEZKitFtRR9dOUI60yblzZTYP9uYk1gE4nR0h/NwSZrkYdjC7rhhH
   ytAuVF3QpowfHfNUOM7bDyZLpVNx/zaVGsMZLrtQn+UIgssphLoQV+1rm
   RTmbIAZ+3OfMwmgbH3F00nqi0O2D5D2uHMIif4fg7fJiyAaG+Kj4Bs4PZ
   5xm47c48Ikmo43xgtvaY1m0RggKXh/uxYq+Kj3L/sTY4ayuCFMDcLhJWo
   5zDu+wztBcHoTy9GiSE69rFqm/z/mvk1duKKUiQIfrai6otX4KrlKQydS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3245234"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="3245234"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 10:56:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="22503970"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 10:56:35 -0800
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] perf Documentation: Add some more hints to tips.txt
Date: Tue, 30 Jan 2024 10:56:26 -0800
Message-ID: <20240130185626.150679-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add some (hopefully useful) hints to tips.txt
Also some minor corrections.

Would probably good to make it a reviewer rule that if generally useful
options are added the patch must add an example to tips.txt
---
 tools/perf/Documentation/tips.txt | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/tips.txt b/tools/perf/Documentation/tips.txt
index 825745a645c1..e85d2bd4f6b2 100644
--- a/tools/perf/Documentation/tips.txt
+++ b/tools/perf/Documentation/tips.txt
@@ -2,6 +2,7 @@ For a higher level overview, try: perf report --sort comm,dso
 Sample related events with: perf record -e '{cycles,instructions}:S'
 Compare performance results with: perf diff [<old file> <new file>]
 Boolean options have negative forms, e.g.: perf report --no-children
+To not accumulate CPU time of children symbols add --no-children
 Customize output of perf script with: perf script -F event,ip,sym
 Generate a script for your data: perf script -g <lang>
 Save output of perf stat using: perf stat record <target workload>
@@ -12,32 +13,52 @@ List events using substring match: perf list <keyword>
 To see list of saved events and attributes: perf evlist -v
 Use --symfs <dir> if your symbol files are in non-standard locations
 To see callchains in a more compact form: perf report -g folded
+To see call chains by final symbol taking CPU time (bottom up) use perf report -G
 Show individual samples with: perf script
 Limit to show entries above 5% only: perf report --percent-limit 5
 Profiling branch (mis)predictions with: perf record -b / perf report
-To show assembler sample contexts use perf record -b / perf script -F +brstackinsn --xed
-Treat branches as callchains: perf report --branch-history
-To count events in every 1000 msec: perf stat -I 1000
-Print event counts in CSV format with: perf stat -x,
+To show assembler sample context control flow use perf record -b / perf report --samples 10 and then browse context
+To adjust path to source files to local file system use perf report --prefix=... --prefix-strip=...
+Treat branches as callchains: perf record -b ... ; perf report --branch-history
+Show estimate cycles per function and IPC in annotate use perf record -b ... ; perf report --total-cycles
+To count events every 1000 msec: perf stat -I 1000
+Print event counts in machine readable CSV format with: perf stat -x\;
 If you have debuginfo enabled, try: perf report -s sym,srcline
 For memory address profiling, try: perf mem record / perf mem report
 For tracepoint events, try: perf report -s trace_fields
 To record callchains for each sample: perf record -g
+If call chains don't work try perf record --call-graph dwarf or --call-graph lbr
 To record every process run by a user: perf record -u <user>
+To show inline functions in call traces add --inline to perf report
+To not record events from perf itself add --exclude-perf
 Skip collecting build-id when recording: perf record -B
 To change sampling frequency to 100 Hz: perf record -F 100
+To show information about system the samples were collected on use perf report --header
+To only collect call graph on one event use perf record -e cpu/cpu-cycles,callgraph=1/,branches ; perf report --show-ref-call-graph
+To set sampling period of individual events use perf record -e cpu/cpu-cycles,period=100001/,cpu/branches,period=10001/ ...
+To group events which need to be collected together for accuracy use {}: perf record -e {cycles,branches}' ...
+To compute metrics for samples use perf record -e '{cycles,instructions}' ... ; perf script -F +metric
 See assembly instructions with percentage: perf annotate <symbol>
 If you prefer Intel style assembly, try: perf annotate -M intel
+When collecting LBR backtraces use --stitch-lbr to handle more than 32 deep entries: perf record --call-graph lbr ; perf report --stitch-lbr
 For hierarchical output, try: perf report --hierarchy
 Order by the overhead of source file name and line number: perf report -s srcline
 System-wide collection from all CPUs: perf record -a
 Show current config key-value pairs: perf config --list
+To collect Processor Trace with samples use perf record -e '{intel_pt//,cycles}' ; perf script --call-trace or --insn-trace --xed -F +ipc (remove --xed if no xed)
+To trace calls using Processor Trace use perf record -e intel_pt// ... ; perf script --call-trace. Then use perf script --time A-B --insn-trace to look at region of interest.
+To measure approximate function latency with Processor Trace use perf record -e intel_pt// ... ; perf script --call-ret-trace
+To trace only single function with Processor Trace use perf record --filter 'filter func @ program' -e intel_pt//u ./program ; perf script --insn-trace
 Show user configuration overrides: perf config --user --list
 To add Node.js USDT(User-Level Statically Defined Tracing): perf buildid-cache --add `which node`
-To report cacheline events from previous recording: perf c2c report
+To analyze cache line scalability issues use perf c2c record ... ; perf c2c report
 To browse sample contexts use perf report --sample 10 and select in context menu
 To separate samples by time use perf report --sort time,overhead,sym
+To filter subset of samples with report or script add --time X-Y or --cpu A,B,C or --socket-filter ...
 To set sample time separation other than 100ms with --sort time use --time-quantum
 Add -I to perf record to sample register values, which will be visible in perf report sample context.
 To show IPC for sampling periods use perf record -e '{cycles,instructions}:S' and then browse context
 To show context switches in perf report sample context add --switch-events to perf record.
+To show time in nanoseconds in record/report add --ns
+To compare hot regions in two workloads use perf record -b -o file ... ; perf diff --streams file1 file2
+To compare scalability of two workload samples use perf cmp -c ratio file1 file2
-- 
2.43.0

