Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B220C1AB6CB;
	Fri, 13 Sep 2024 05:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726204887; cv=none; b=EcrB6my/8l6JGtt7xjrPuA8N6Bo3nQUO3O+XFLvV9W8k3C4uzIHCm7LjiYG6RX1uBYQf6Bn1uQ6G/H31FEg8c1S+P1NjlRCiznlkOpC2IPjKRjwrvxCvnt246I85a65feyKVvobWv3duFsop2VNNwKmQWN6AFr4qDxVRTAQVasU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726204887; c=relaxed/simple;
	bh=C2ZvJpwCXSNILnFYconCFl+Fj+d2lFtFpfu8vJOxExY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ImoT4LwU7bnoXtHNx90poynvKEybJkHK6u3On+wqyCquEjYZAHqs6qinAWtCMFrRrwG91Ej7lgwR0waaU4mOMH3EUxZVt92HAG1f/bunyX/9XPEvRpI/0AxlkDk7MzMt1PWyKZ017TSZRXm3MVNLTpGrntuL9Vd+wIc/EuhfKaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IjM7k1kR; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IjM7k1kR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726204885; x=1757740885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C2ZvJpwCXSNILnFYconCFl+Fj+d2lFtFpfu8vJOxExY=;
  b=IjM7k1kRc+IhwfA0q1h5H9YGiSGKzQ6k9iQMZQZMKPwNTa+VtN/qoORY
   YOxhAQXEB6Mqj//F8XCb8BsxuJfvXAlH1JtkmK8eV+mESV919McLREDiQ
   kCen6WdOvC5CcOABXli4xivFSpvFLnY2gKI6k8QQB+gayhF+J4wIN2LIg
   hj4kGFA2zW+WHoRmHZNpd4yXmV89W+viuz8Afba77/LKz9iqDiT8tQmi2
   UIa7Mi+ksj5JGwaM/z1IdSONQA5KQOJPw4PYiw81Cz8feKRCBh6ymFjFT
   spVyu8i5KUGV1lbwQtejBIqYamxSUbmMjrHnkZkR6Xyl2P/uyKJ7cqE2M
   w==;
X-CSE-ConnectionGUID: A6LOyVA+Q02dOs6f595iaw==
X-CSE-MsgGUID: 4dh02ZziR1qFIPlZJbYpcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24967794"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="24967794"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 22:21:25 -0700
X-CSE-ConnectionGUID: ujdnykkeQeOSnSe+OkYNUw==
X-CSE-MsgGUID: 4Pm5oCasQX2V/OJvsSyXkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="67900636"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa009.fm.intel.com with ESMTP; 12 Sep 2024 22:21:22 -0700
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
Subject: [Patch v5 5/6] perf tests: Add topdown events counting and sampling tests
Date: Fri, 13 Sep 2024 08:47:11 +0000
Message-Id: <20240913084712.13861-6-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240913084712.13861-1-dapeng1.mi@linux.intel.com>
References: <20240913084712.13861-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add counting and leader sampling tests to verify topdown events including
raw format can be reordered correctly.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/tests/shell/record.sh | 17 +++++++++++++++++
 tools/perf/tests/shell/stat.sh   |  6 ++++++
 2 files changed, 23 insertions(+)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 45baf7910640..8d6366d96883 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -255,6 +255,22 @@ test_leader_sampling() {
   echo "Basic leader sampling test [Success]"
 }
 
+test_topdown_leader_sampling() {
+  echo "Topdown leader sampling test"
+  if ! perf stat -e "{slots,topdown-retiring}" true 2> /dev/null
+  then
+    echo "Topdown leader sampling [Skipped event parsing failed]"
+    return
+  fi
+  if ! perf record -o "${perfdata}" -e "{instructions,slots,topdown-retiring}:S" true 2> /dev/null
+  then
+    echo "Topdown leader sampling [Failed topdown events not reordered correctly]"
+    err=1
+    return
+  fi
+  echo "Topdown leader sampling test [Success]"
+}
+
 # raise the limit of file descriptors to minimum
 if [[ $default_fd_limit -lt $min_fd_limit ]]; then
        ulimit -Sn $min_fd_limit
@@ -267,6 +283,7 @@ test_workload
 test_branch_counter
 test_cgroup
 test_leader_sampling
+test_topdown_leader_sampling
 
 # restore the default value
 ulimit -Sn $default_fd_limit
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

