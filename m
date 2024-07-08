Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24AD3D3BF;
	Mon,  8 Jul 2024 07:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424455; cv=none; b=cTb6GjGEido3OMeufTm551mT9n5NglpUP7JB6K8w7lKQ+S22LYz4LqOVCEyLkFNRWd4hW+t0dPmXioLn7FgzeP5VSVQPwuy3Zi5NzH7ln4de9KPy7sAWPuvd3S/j7g12jgLouYfq8jbc9LKjFbFVP0FjH4rS8vVtZKgFhzPg410=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424455; c=relaxed/simple;
	bh=hbv/ONaTcOcSxcVI9/dmZbgKJj6Jaqy5OC6pe95FOVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fUd8U76gpRjtW1sleHuzt7jMwniXu8rf6B2YJEcWnFI4zuq/PhmDagDHmNLqqj4BUHkc8cDJDhZdl95oodnPGFuO4shs0haZiKGBZHDIh8uGlBSDXQRluhsUTby6g3gYCGvKrS66TvwxdIQZwZvmxvAUF3YO+hjOOKVSmnkzEg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eXxLr60/; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eXxLr60/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720424454; x=1751960454;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hbv/ONaTcOcSxcVI9/dmZbgKJj6Jaqy5OC6pe95FOVQ=;
  b=eXxLr60/NhbyMURlN/DMSvNNJCnhj9FHawDnffxBf4P1rjDarlme7z5V
   SMb6Hwd3Va+bxSpXhJDgehXqpyKqLrjo46EaWjBNHM8jjeF6rnvWKx6zK
   aDPQmIEcsSFK5n/aEhFP1ix1EUOEFCD7hpWUzYfHvbpZG+CjjleompS45
   INEMko2YMWlen9QXnmIljNrNBZT9Qk8CASvF/Vi4E2MNkS2xEe8ukSf+J
   9rcrOxMNBN7KDr1SgGaEg09ZHBgirE1UmMol5tcyzp2WCzmHSyJNuLwaI
   FYp9BeCuEsDpg7C3K2HQLTJtVgo6/RO8uh0MiaBeFeKXQtERzET/dhKja
   Q==;
X-CSE-ConnectionGUID: j8ZoPeUiQcecWwsMSCtQWA==
X-CSE-MsgGUID: RQzgarQdRziNHwVHLFSH4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11126"; a="17819256"
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="17819256"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 00:40:54 -0700
X-CSE-ConnectionGUID: YtzkbKIVTvC4PgJUQdKEPQ==
X-CSE-MsgGUID: P7xyYtMVSuawUwqYqfwQFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="51774161"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa003.fm.intel.com with ESMTP; 08 Jul 2024 00:40:50 -0700
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
Subject: [Patch v2 5/5] perf tests: Add topdown events counting and sampling tests
Date: Mon,  8 Jul 2024 14:42:04 +0000
Message-Id: <20240708144204.839486-6-dapeng1.mi@linux.intel.com>
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

Add counting and leader sampling tests to verify topdown events including
raw format can be reordered correctly.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/tests/shell/record.sh | 6 ++++++
 tools/perf/tests/shell/stat.sh   | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 8e3e66780fed..164f0cf9648e 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -214,6 +214,12 @@ test_leader_sampling() {
     index=$(($index+1))
     prev_branches=$branches
   done < $script_output
+  if ! perf record -o "${perfdata}" -e "{instructions,slots,topdown-retiring}:S" true 2> /dev/null
+  then
+    echo "Leader sampling [Failed topdown events not reordered correctly]"
+    err=1
+    return
+  fi
   echo "Basic leader sampling test [Success]"
 }
 
diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 3f1e67795490..092a7a2abcf8 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -79,6 +79,12 @@ test_topdown_groups() {
     err=1
     return
   fi
+  if perf stat -e '{instructions,r400,r8000}' true 2>&1 | grep -E -q "<not supported>"
+  then
+    echo "Topdown event group test [Failed raw format slots not reordered first]"
+    err=1
+    return
+  fi
   echo "Topdown event group test [Success]"
 }
 
-- 
2.40.1

