Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E78E1C233A;
	Wed, 16 Oct 2024 06:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729059848; cv=none; b=lFU/VGR2qSSXKVjzBNtwHoLQayXdxOYMrXObqFAnSlBeKC99r0MdAtO+3fHL+d/xFrt95xgVuJSZYRKqU5DJ9UesXwqyPHagrHfedWPUDbV15BBO30mTJo6v2Gcidn6LETkVRXfwWobJSqkl+wNAwiJ+L6LV7dqQFGRzKOUzHpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729059848; c=relaxed/simple;
	bh=OEMIX3Py57TTYZipJctDBI2XnKZ9J1B9wCuvXhKmHuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zjo2nJ4eG+MxhwCVTEosX3pKKC1pGNIsg3/vr4OCYAO81JrJJVM7XNKiCLCzsMB+250wjQ0rdt5wkHnJYQOqwlJIZXpgWVQezQSDg7iGZfC1h9qNPOnbKEpV9PoqZSL5ks7S/BWWYSrGA3I33+VmzY87kKYCEtwaxH1C6Eg7iCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAWZmH8j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAWZmH8j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33846C4AF0E;
	Wed, 16 Oct 2024 06:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729059847;
	bh=OEMIX3Py57TTYZipJctDBI2XnKZ9J1B9wCuvXhKmHuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hAWZmH8jjihHsVx/4phlnScWheuIoYmDZi/Gp6pXjgpcll8V8i4k5JwL6l6fqdmMW
	 qkjXlqWI56Ezk5Y1sM3IiHmfwpNzKMSsD3DgzytwW+pBu9Y2hbUvP5eW2HqumvuG0f
	 JGp3lUw1vJjziWEpKfu36ytZziNnlBi0wJKT2A5H5tqDWWpK5Y+jNRj4Vlc6IGwak/
	 AWQmPH221Ck1XYLedMBbMLHw4VkT5kHOw4f0VPxdGDg9m6rNe9Urv96QZ576yVsi2B
	 0klvJFxdba5W3sZkZU8QgD2w8tB5/8uhRJko1qBL+3/vIl4CV7XJyY2gRKJj/m6NkA
	 4hG01j+7q2pPA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@arm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mingwei Zhang <mizhang@google.com>
Subject: [PATCH v5 9/9] perf test: Add precise_max subtest to the perf record shell test
Date: Tue, 15 Oct 2024 23:23:59 -0700
Message-ID: <20241016062359.264929-10-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
In-Reply-To: <20241016062359.264929-1-namhyung@kernel.org>
References: <20241016062359.264929-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's a very simply test just to run with cycles:P and instructions:P
events.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/record.sh | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 8d6366d96883edb3..b23e83a099f84a65 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -271,6 +271,30 @@ test_topdown_leader_sampling() {
   echo "Topdown leader sampling test [Success]"
 }
 
+test_precise_max() {
+  echo "precise_max attribute test"
+  if ! perf stat -e "cycles,instructions" true 2> /dev/null
+  then
+    echo "precise_max attribute [Skipped no hardware events]"
+    return
+  fi
+  # Just to make sure it doesn't fail
+  if ! perf record -o "${perfdata}" -e "cycles:P" true 2> /dev/null
+  then
+    echo "precise_max attribute [Failed cycles:P event]"
+    err=1
+    return
+  fi
+  # On AMD, cycles and instructions events are treated differently
+  if ! perf record -o "${perfdata}" -e "instructions:P" true 2> /dev/null
+  then
+    echo "precise_max attribute [Failed instructions:P event]"
+    err=1
+    return
+  fi
+  echo "precise_max attribute test [Success]"
+}
+
 # raise the limit of file descriptors to minimum
 if [[ $default_fd_limit -lt $min_fd_limit ]]; then
        ulimit -Sn $min_fd_limit
@@ -284,6 +308,7 @@ test_branch_counter
 test_cgroup
 test_leader_sampling
 test_topdown_leader_sampling
+test_precise_max
 
 # restore the default value
 ulimit -Sn $default_fd_limit
-- 
2.47.0.rc1.288.g06298d1525-goog

