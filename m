Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DC9311C2D;
	Tue,  8 Sep 2026 15:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788880880; cv=none; b=M1a0SCIpBHZT2etUBkpRaxYKz/crb6nhceOskqLFTl3rn3ac0CaLD22wDYvqZZPb1+UP+B29K2RIjWUcY/XdNY6NyuKtKWwZYGd42WgVh1cNPKMCCWzaRRdG/SUfHYeprorbyjRAByC1T0BPxnZV/Eq2FPfXrjmrGohQEo935Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788880880; c=relaxed/simple;
	bh=W4334SuzahnU1++N24thvZV9Vdj0KvisRMqA85OggxE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OJ8/bh1f+5mnHMyP/6xLvciwGSMalih5Cgof1jJySPtyhVcI3F462dNKTHJ7sXcdNc9j4vGkCjX8vzESnIlbc614YPb0f+bpFaFi9mt9h8DgVvBRxjgeSasGJFie/Dj2RxmbFpmqova0Q2mJ3WaTScyAJQvuip+uYXfKjl1FoJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g1ENglvz; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g1ENglvz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788880868; x=1820416868;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=W4334SuzahnU1++N24thvZV9Vdj0KvisRMqA85OggxE=;
  b=g1ENglvz5DmMNu6E478+vGJTmwaWbFsG26pIWhxDdhIydVup7yXCm+eq
   X1CqoO3v8i+0tb7/HiJ7Z8WQcOx5wktSUCqBzb5rKslp/gZXz7hwp28q/
   4UkQcGacBuRiY3kA9fz66berCy/n+30EoKXSP2gvp63o6ob888LOn8l96
   VW8r9Fvl+zDE5AgAmUWSf0UzD0oNLzSSpu8q+PoGfNeDuT4+Rjl668zCb
   MydNATFTid9WfDM74viKLMDLjnVpxJp/rIDjQrxtgr/Q7tM7Kf9WFMxG4
   0q7u/NO/G8dRSGz1rPisA1emik1X5BDfnjSnVPT+0Bl1+SziclAWJJkLA
   g==;
X-CSE-ConnectionGUID: SazQIxk/TVO/kWNRgecyxw==
X-CSE-MsgGUID: 2hMUjN8RRiydxRtiIhlDcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="106803261"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="106803261"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 08:21:03 -0700
X-CSE-ConnectionGUID: ftnRedlfQW+Y9nB8GonF3g==
X-CSE-MsgGUID: YxKle19RRwOSwN/a6kGh8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="294535638"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.244.90])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 08:21:01 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf test: waiting.sh: Replace timestamp polling with sleep
Date: Tue,  8 Sep 2026 18:20:53 +0300
Message-ID: <20260908152053.192830-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

The waiting helpers implement timeouts using:

  date +%s%1N

This relies on GNU coreutils date truncating %N to the specified width,
so %1N yields tenths of a second.

Rust coreutils (uutils) interprets the width differently and does not
truncate the nanoseconds field.  Consequently "date +%1N" returns all
nine nanosecond digits, causing the elapsed-time calculation to be done
in nanoseconds while timeout values remain in tenths of a second.

As a result, timeout comparisons succeed immediately and the waiting
helpers time out on their first iteration.  This causes
test_intel_pt.sh to fail on systems using uutils "date".

Avoid implementation-specific date formatting entirely.  Instead, wait
for 100 ms on each iteration and count the timeout down.  Besides fixing
the portability issue, this removes the busy-waiting behaviour in
wait_for_perf_to_start(), which could otherwise consume CPU while
waiting for perf record to start.

Since the timeout is now based on repeated sleeps, it is only
approximate.  Update the comments accordingly.  Also make is_running()
wait for exactly the documented number of tenths by changing its timeout
test from -gt to the new logic, and quote tm_out in the modified code.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/tests/shell/lib/waiting.sh | 34 +++++++++++++--------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/tools/perf/tests/shell/lib/waiting.sh b/tools/perf/tests/shell/lib/waiting.sh
index 3a152892e077..43f4322dbe9e 100644
--- a/tools/perf/tests/shell/lib/waiting.sh
+++ b/tools/perf/tests/shell/lib/waiting.sh
@@ -1,77 +1,75 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-tenths=date\ +%s%1N
-
 # Wait for PID $1 to have $2 number of threads started
-# Time out after $3 tenths of a second or 5 seconds if $3 is ""
+# Time out after approx. $3 tenths of a second or 5 seconds if $3 is ""
 wait_for_threads()
 {
 	tm_out=$3 ; [ -n "${tm_out}" ] || tm_out=50
-	start_time=$($tenths)
 	while [ -e "/proc/$1/task" ] ; do
 		th_cnt=$(find "/proc/$1/task" -mindepth 1 -maxdepth 1 -printf x | wc -c)
 		if [ "${th_cnt}" -ge "$2" ] ; then
 			return 0
 		fi
-		# Wait at most tm_out tenths of a second
-		if [ $(($($tenths) - start_time)) -ge $tm_out ] ; then
+		if [ "${tm_out}" -le 0 ] ; then
 			echo "PID $1 does not have $2 threads"
 			return 1
 		fi
+		sleep 0.1
+		tm_out=$((tm_out - 1))
 	done
 	return 1
 }
 
 # Wait for perf record -vvv 2>$2 with PID $1 to start by looking at file $2
 # It depends on capturing perf record debug message "perf record has started"
-# Time out after $3 tenths of a second or 5 seconds if $3 is ""
+# Time out after approx. $3 tenths of a second or 5 seconds if $3 is ""
 wait_for_perf_to_start()
 {
 	tm_out=$3 ; [ -n "${tm_out}" ] || tm_out=50
 	echo "Waiting for \"perf record has started\" message"
-	start_time=$($tenths)
 	while [ -e "/proc/$1" ] ; do
 		if grep -q "perf record has started" "$2" ; then
 			echo OK
 			break
 		fi
-		# Wait at most tm_out tenths of a second
-		if [ $(($($tenths) - start_time)) -ge $tm_out ] ; then
+		if [ "${tm_out}" -le 0 ] ; then
 			echo "perf recording did not start"
 			return 1
 		fi
+		sleep 0.1
+		tm_out=$((tm_out - 1))
 	done
 	return 0
 }
 
 # Wait for process PID %1 to exit
-# Time out after $2 tenths of a second or 5 seconds if $2 is ""
+# Time out after approx. $2 tenths of a second or 5 seconds if $2 is ""
 wait_for_process_to_exit()
 {
 	tm_out=$2 ; [ -n "${tm_out}" ] || tm_out=50
-	start_time=$($tenths)
 	while [ -e "/proc/$1" ] ; do
-		# Wait at most tm_out tenths of a second
-		if [ $(($($tenths) - start_time)) -ge $tm_out ] ; then
+		if [ "${tm_out}" -le 0 ] ; then
 			echo "PID $1 did not exit as expected"
 			return 1
 		fi
+		sleep 0.1
+		tm_out=$((tm_out - 1))
 	done
 	return 0
 }
 
-# Check if PID $1 is still running after $2 tenths of a second
+# Check if PID $1 is still running after approx. $2 tenths of a second
 # or 0.3 seconds if $2 is ""
 is_running()
 {
 	tm_out=$2 ; [ -n "${tm_out}" ] || tm_out=3
-	start_time=$($tenths)
 	while [ -e "/proc/$1" ] ; do
-		# Check for at least tm_out tenths of a second
-		if [ $(($($tenths) - start_time)) -gt $tm_out ] ; then
+		if [ "${tm_out}" -le 0 ] ; then
 			return 0
 		fi
+		sleep 0.1
+		tm_out=$((tm_out - 1))
 	done
 	echo "PID $1 exited prematurely"
 	return 1
-- 
2.53.0

