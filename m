Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F32811E2;
	Tue, 23 Jan 2024 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027961; cv=none; b=JZOIdzk5i12qERiZG5ymHKFb4XexuJrQq9NcFCAmQ1etRo6IpyD6jWaS0G795gBjfl1oYlBp/nUpLmfWZPV0ApsNpcVThoeWFFuuDefeL9g2kHhUTWlmHgCxhAd3sDBUTZZ8Q5FF9Afky0Yg1JmcEJNAdvqfJgJPpxLVh0uCTiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027961; c=relaxed/simple;
	bh=gXfhJCgLJhn8evK5zGZ/NOEXFQLLLjnuSt5Xs2hv2sg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=giX+dM011lhimwojUhF2jq5mKdLdlDaDvwn5n0DJ6mc/j7tXgFHDhAXPEIV0kniVQXlnefpe0ku6pQqFBLHzo4MZA1cn/72c1KgXEiCoOqw1n2KjV8ChRMiafVryUi1QcRrgKv8v/DJxheX4wv/yR7EBNWqZk75ybYfn1FwLNb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9641106F;
	Tue, 23 Jan 2024 08:40:03 -0800 (PST)
Received: from e127643.broadband (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 70BEF3F5A1;
	Tue, 23 Jan 2024 08:39:16 -0800 (PST)
From: James Clark <james.clark@arm.com>
To: linux-perf-users@vger.kernel.org,
	irogers@google.com
Cc: James Clark <james.clark@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Spoorthy S <spoorts2@in.ibm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] perf test: Skip test_arm_callgraph_fp.sh if unwinding isn't built in
Date: Tue, 23 Jan 2024 16:39:02 +0000
Message-Id: <20240123163903.350306-3-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123163903.350306-1-james.clark@arm.com>
References: <20240123163903.350306-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even though this is a frame pointer unwind test, it's testing that a
frame pointer stack can be augmented correctly with a partial
Dwarf unwind. So add a feature check so that this test skips instead of
fails if Dwarf unwinding isn't present.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/tests/shell/test_arm_callgraph_fp.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/tests/shell/test_arm_callgraph_fp.sh b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
index e342e6c8aa50..83b53591b1ea 100755
--- a/tools/perf/tests/shell/test_arm_callgraph_fp.sh
+++ b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
@@ -8,6 +8,12 @@ shelldir=$(dirname "$0")
 
 lscpu | grep -q "aarch64" || exit 2
 
+if perf version --build-options | grep HAVE_DWARF_UNWIND_SUPPORT | grep -q OFF
+then
+  echo "Skipping, no dwarf unwind support"
+  exit 2
+fi
+
 skip_test_missing_symbol leafloop
 
 PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
-- 
2.34.1

