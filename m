Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18831A38C8;
	Tue, 13 Aug 2024 16:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564905; cv=none; b=BlI5d60nLwlXdu1zSXWU9xXRmvjssvHPCovJGslrriZomkN8twVGHBKdagyNGhnCmAtFTYhV1rgZb/m0NJ2WxLcrkrgElLRGhhZc7Gija3kqt/xIgcwuVh8QX6W3xAew4DEIqJXoqq0qIyrhQIcw8v3byAtWBM0x9zLUiXLbNiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564905; c=relaxed/simple;
	bh=iDcHhBjklszsHCFlB1I+Epu/zTkyEf/8+o8VvG5QsHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V5CXfET0wWDKWDXZctyut/kA7x1PwN/5aYpNja0E9g9kMLO9Cmu89hHlEodNSYEPrTq/rG4mhGPBF4Wco9zfDgRaUIw3sC2NQXWMUAJtDsv9O07yYE0RhBsAiiQag8DxirJr/zRzhChjJe2yWUWJdFactu4U7jEMjRKcGxQZqYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UUqKfY8f; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UUqKfY8f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723564904; x=1755100904;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iDcHhBjklszsHCFlB1I+Epu/zTkyEf/8+o8VvG5QsHY=;
  b=UUqKfY8fUgjL5dinrRnCk/R5rz4JpTekt6zdbiJy3OUPNeYXb3TpEAVF
   nSEvOGJXvxvVQd2ScyVUqe2N2bEjEvIp46BB1g637AuflcnO/goThuv7c
   BbLMdBJ10PFhKFFpiDZWRjuYbMY0q/Bqytpynd8+cfkE3z+jDGTYeP+bm
   pffh27M09qDQV9YuuHXL910Znl0FBldrqFlMJtSvUshebQ7eH858Sd3gg
   rGjjGkRw7cAnvPXjmiD+s+2Tg0e24GGqUtzb8l5EEKOuIhnwSmvOyZUOw
   evkD7VZyF3ppdeBmVqjdUjS/KNofFPk9YuXWqHHY8HnO7YVSPiPsuD6HX
   g==;
X-CSE-ConnectionGUID: rUDSSvcGTImf6py9rMIU5A==
X-CSE-MsgGUID: vHr4eDkyTK6C678xjTU3SA==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21383230"
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="21383230"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 09:01:37 -0700
X-CSE-ConnectionGUID: lTzbP6CeSUCGpyZWHRARFg==
X-CSE-MsgGUID: 5V37HyPHQcO0+keY8/NkFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="59479762"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa008.jf.intel.com with ESMTP; 13 Aug 2024 09:01:37 -0700
From: kan.liang@linux.intel.com
To: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	peterz@infradead.org,
	mingo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: adrian.hunter@intel.com,
	ak@linux.intel.com,
	eranian@google.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 9/9] perf test: Add new test cases for the branch counter feature
Date: Tue, 13 Aug 2024 09:02:08 -0700
Message-Id: <20240813160208.2493643-10-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240813160208.2493643-1-kan.liang@linux.intel.com>
References: <20240813160208.2493643-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Enhance the test case for the branch counter feature.

Now, the test verifies
- The new filter can be successfully applied on the supported platforms.
- The counter value can be outputted via the perf report -D
- The counter value and the abbr name can be outputted via the
  perf script (New)

Acked-by: Namhyung Kim <namhyung@kernel.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/tests/shell/record.sh | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 3d1a7759a7b2..7964ebd9007d 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -21,6 +21,7 @@ testprog="perf test -w thloop"
 cpu_pmu_dir="/sys/bus/event_source/devices/cpu*"
 br_cntr_file="/caps/branch_counter_nr"
 br_cntr_output="branch stack counters"
+br_cntr_script_output="br_cntr: A"
 
 cleanup() {
   rm -rf "${perfdata}"
@@ -165,7 +166,7 @@ test_workload() {
 }
 
 test_branch_counter() {
-  echo "Basic branch counter test"
+  echo "Branch counter test"
   # Check if the branch counter feature is supported
   for dir in $cpu_pmu_dir
   do
@@ -175,19 +176,25 @@ test_branch_counter() {
       return
     fi
   done
-  if ! perf record -o "${perfdata}" -j any,counter ${testprog} 2> /dev/null
+  if ! perf record -o "${perfdata}" -e "{branches:p,instructions}" -j any,counter ${testprog} 2> /dev/null
   then
-    echo "Basic branch counter test [Failed record]"
+    echo "Branch counter record test [Failed record]"
     err=1
     return
   fi
   if ! perf report -i "${perfdata}" -D -q | grep -q "$br_cntr_output"
   then
-    echo "Basic branch record test [Failed missing output]"
+    echo "Branch counter report test [Failed missing output]"
     err=1
     return
   fi
-  echo "Basic branch counter test [Success]"
+  if ! perf script -i "${perfdata}" -F +brstackinsn,+brcntr | grep -q "$br_cntr_script_output"
+  then
+    echo " Branch counter script test [Failed missing output]"
+    err=1
+    return
+  fi
+  echo "Branch counter test [Success]"
 }
 
 test_per_thread
-- 
2.38.1

