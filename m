Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1BC3BB25;
	Mon,  8 Jul 2024 07:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424451; cv=none; b=Y3GR9rjIAwiBAHEoAEttj0JurMJgCeIEXgNtdz6Ay6dNCSXk6N4f2W51inR3inc63aRLx4cwx4O7yKG83peWI2KGsi5aqShv9bdrwn+5Kjzm1G68BR1GtfTlc0jkkgXLFOvLG/IqkKyYyL0buNcV/Tz6jN1Z9F7rR7DzR3CUqMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424451; c=relaxed/simple;
	bh=7NPeKnDoJ/P82slpVaSMciOgj75XI6ViCTDAXn0KGrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NPYt/RXKY02yMTelZ4YU9Cm6GNI2Ub2BZ1eLmtADhaTFICiRLZt/kCgiw9kfpdf2LvUWmPAoTuAnlxLj7IlhAKzAppqqQ/rCkYnKW9lOpzpXMgdN+gmFR2YGuGd6ICs9ECfWnyRWsI3uh9AufhkyJfNI8BPWQwJoKmOWqJylG28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RHv3cWqG; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RHv3cWqG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720424450; x=1751960450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7NPeKnDoJ/P82slpVaSMciOgj75XI6ViCTDAXn0KGrA=;
  b=RHv3cWqGoEHusCyk4k0OTGuD+F9lNtvh1CdOyO9SrS+vOEtBjLvHid8v
   R2tgfO3yXb1TFZsnTmx/cij6yo4DW2hwH5xkhB/oxgOD0kerGGSdmcfNh
   TVtEdBotg9RZw3oLalAVY0Ck7Rsuqh9zc/o3vQepIGych9U4ikBokYJzW
   1k9GQT7NlmHcOtLC1OlHB4DgezKJqlAtAEZ3HD0m8kmb/BgCQG88IrOyP
   NfGZz2cRV2x3GbuafUPIeOTrWFD2Ju3AJwCXtA8TIBsHnUwVo6zvKhytV
   5pCYg19IqKD08o1B5gT4xozTe+FjZANYAZX8IsZRIfo4K0/A9b/R5SBJG
   g==;
X-CSE-ConnectionGUID: DauF/CNbQfWPkCpX3LKgMA==
X-CSE-MsgGUID: eQWYIAeUR92pC5Q+XHXRzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11126"; a="17819248"
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="17819248"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 00:40:50 -0700
X-CSE-ConnectionGUID: /3+jJtQOQKCheWkMuqRNzQ==
X-CSE-MsgGUID: kXVs+frKRk+/aqgYqACsGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="51774155"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa003.fm.intel.com with ESMTP; 08 Jul 2024 00:40:47 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yongwei Ma <yongwei.ma@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v2 4/5] perf tests: Add leader sampling test in record tests
Date: Mon,  8 Jul 2024 14:42:03 +0000
Message-Id: <20240708144204.839486-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240708144204.839486-1-dapeng1.mi@linux.intel.com>
References: <20240708144204.839486-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add leader sampling test to validate event counts are captured into
record and the count value is consistent.

Suggested-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/tests/shell/record.sh | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 3d1a7759a7b2..8e3e66780fed 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -17,6 +17,7 @@ skip_test_missing_symbol ${testsym}
 
 err=0
 perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+script_output=$(mktemp /tmp/__perf_test.perf.data.XXXXX.script)
 testprog="perf test -w thloop"
 cpu_pmu_dir="/sys/bus/event_source/devices/cpu*"
 br_cntr_file="/caps/branch_counter_nr"
@@ -190,11 +191,38 @@ test_branch_counter() {
   echo "Basic branch counter test [Success]"
 }
 
+test_leader_sampling() {
+  echo "Basic leader sampling test"
+  if ! perf record -o "${perfdata}" -e "{branches,branches}:Su" perf test -w brstack 2> /dev/null
+  then
+    echo "Leader sampling [Failed record]"
+    err=1
+    return
+  fi
+  index=0
+  perf script -i "${perfdata}" > $script_output
+  while IFS= read -r line
+  do
+    # Check if the two branches counts are equal in each record
+    branches=$(echo $line | awk '{for(i=1;i<=NF;i++) if($i=="branches:") print $(i-1)}')
+    if [ $(($index%2)) -ne 0 ] && [ ${branches}x != ${prev_branches}x ]
+    then
+      echo "Leader sampling [Failed inconsistent branches count]"
+      err=1
+      return
+    fi
+    index=$(($index+1))
+    prev_branches=$branches
+  done < $script_output
+  echo "Basic leader sampling test [Success]"
+}
+
 test_per_thread
 test_register_capture
 test_system_wide
 test_workload
 test_branch_counter
+test_leader_sampling
 
 cleanup
 exit $err
-- 
2.40.1

