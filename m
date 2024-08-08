Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A94C15B986;
	Thu,  8 Aug 2024 19:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723145579; cv=none; b=i0UQm6nGf5/NyN/oDxUwHnfcG3aObwUaSHksy+fsiGthLfkYvLZTtCKzAcmMWOF4zL06DnLj4XT76EGyLlLFaxWakcB+DMPjbY7cpBE2o5ZBJXOowWOs0HgOMudyH1xXvtmzh1ZDvihFkcH/+dzZa3mMoe+jWt2ehg6NITqZ23s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723145579; c=relaxed/simple;
	bh=eRSy0qosXqU6Hszy6JkiW6BncOZYM9c0YyE7hCnYkgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tnfyFtSvZ9gxoOHlfDApmAAzsUYy4bexnXo8lceMIu/a39fhioZMOfmvpVF+mB0GP92z7otwvcuzI1sJmrjia4k3id0/YhPEmXO8rfiWhiO2wVXNO4+2sWx5EvSouKf+HHDXQUrkDjcDZFpz9JxPj0VjV+pBhShAfSlMPlHoQrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b85OF0wA; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b85OF0wA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723145578; x=1754681578;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eRSy0qosXqU6Hszy6JkiW6BncOZYM9c0YyE7hCnYkgM=;
  b=b85OF0wA68HeifVB+vqhVhVh718IZJW73T6CAXErrXWTikwaoQxAMdXg
   VwkJSqeP15TlTNjtnVSD0Y7tpS50MxITtvRFh2tN+1qAJyVM768sWQsiS
   Olh1Sqz8XgBcm1zOOl5vzgX3Izuzoc8CcLeZkP5nnFAIwIDmIvG23vzAr
   +O00+dcDWxaM/jy7/lfdXNieMJZTYmPWydk3Br99GGXl1OFt2O2w+Q9LC
   22UF6M3tWHd/COXtZ2gPzNwaDvu8MzHfg64f+iF9Z7JIsmRkdAydNoYcN
   pBNvaMPmnKA6WYaMXewRfwUVI5v9DhDZgaAB97K77OWtFYpxwChiBhGWt
   A==;
X-CSE-ConnectionGUID: KVPFH18qT7yg0hNCpjSaSg==
X-CSE-MsgGUID: xOgD5xJaQ3+zfWgvFEsWKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="25091730"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="25091730"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 12:32:53 -0700
X-CSE-ConnectionGUID: 7aa5ssSXTvKAi/5GMRzVIw==
X-CSE-MsgGUID: t09XSuMsSO6hRoacedCXtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="57402607"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa010.fm.intel.com with ESMTP; 08 Aug 2024 12:32:53 -0700
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
Subject: [PATCH V2 9/9] perf test: Add new test cases for the branch counter feature
Date: Thu,  8 Aug 2024 12:33:24 -0700
Message-Id: <20240808193324.2027665-10-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240808193324.2027665-1-kan.liang@linux.intel.com>
References: <20240808193324.2027665-1-kan.liang@linux.intel.com>
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

