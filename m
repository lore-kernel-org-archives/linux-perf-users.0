Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E06E139CEE;
	Thu, 13 Jun 2024 06:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718259514; cv=none; b=rUPqlaS8G+9dcF7d+E7fCVAcuuc0xlhjf6NgZTbVj0iLZnZ22eYzIsn0OYR8H7kU87bIboFpvfpfCTG+jsu2gt7tt5mfukXruFLnMVVXbp7DfwTgmXbUb0nmVJ5UXaV3P/uXJohGhz7u6DGqm9OTHxQ+oszmjYYkaM21+uq8Ybw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718259514; c=relaxed/simple;
	bh=U6BxwWWsO2hrcxqX3UheDtH44VcZe/y/iBmW6rm7qVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mEPrX+JOWW1M8t4gLt5bv8v0sBwusivrxvGRqqVjoDP50W5ve9QbWgF970fA4I1rGDkd3/NVaXW8eBz24izE4My4CXktqjYQn6Ed43XmZhzHHz992+y+jVjHxEfrp6nmn25rrV1cfTD078cFyNQLr+nveAFTYpzBlzHnh58i598=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 936E11063;
	Wed, 12 Jun 2024 23:18:56 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.44.128])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1CB1F3F5A1;
	Wed, 12 Jun 2024 23:18:25 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	will@kernel.org,
	catalin.marinas@arm.com,
	mark.rutland@arm.com
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Mark Brown <broonie@kernel.org>,
	James Clark <james.clark@arm.com>,
	Rob Herring <robh@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Suzuki Poulose <suzuki.poulose@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V18 7/9] perf: test: Speed up running brstack test on an Arm model
Date: Thu, 13 Jun 2024 11:47:29 +0530
Message-Id: <20240613061731.3109448-8-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240613061731.3109448-1-anshuman.khandual@arm.com>
References: <20240613061731.3109448-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Clark <james.clark@arm.com>

The test runs quite slowly in the model, so replace "xargs -n1" with
"tr ' ' '\n'" which does the same thing but in single digit minutes
instead of double digit minutes.

Also reduce the number of loops in the test application. Unfortunately
this causes intermittent failures on x86, presumably because the
sampling interval is too big to pickup any loops, so keep it the same
there.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: James Clark <james.clark@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 tools/perf/tests/shell/test_brstack.sh | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
index 5f14d0cb013f..5ea64d0c4a6f 100755
--- a/tools/perf/tests/shell/test_brstack.sh
+++ b/tools/perf/tests/shell/test_brstack.sh
@@ -18,7 +18,6 @@ fi
 skip_test_missing_symbol brstack_bench
 
 TMPDIR=$(mktemp -d /tmp/__perf_test.program.XXXXX)
-TESTPROG="perf test -w brstack"
 
 cleanup() {
 	rm -rf $TMPDIR
@@ -26,11 +25,21 @@ cleanup() {
 
 trap cleanup EXIT TERM INT
 
+is_arm64() {
+	uname -m | grep -q aarch64
+}
+
+if is_arm64; then
+	TESTPROG="perf test -w brstack 5000"
+else
+	TESTPROG="perf test -w brstack"
+fi
+
 test_user_branches() {
 	echo "Testing user branch stack sampling"
 
 	perf record -o $TMPDIR/perf.data --branch-filter any,save_type,u -- ${TESTPROG} > /dev/null 2>&1
-	perf script -i $TMPDIR/perf.data --fields brstacksym | xargs -n1 > $TMPDIR/perf.script
+	perf script -i $TMPDIR/perf.data --fields brstacksym | tr ' ' '\n' > $TMPDIR/perf.script
 
 	# example of branch entries:
 	# 	brstack_foo+0x14/brstack_bar+0x40/P/-/-/0/CALL
@@ -59,7 +68,7 @@ test_filter() {
 	echo "Testing branch stack filtering permutation ($test_filter_filter,$test_filter_expect)"
 
 	perf record -o $TMPDIR/perf.data --branch-filter $test_filter_filter,save_type,u -- ${TESTPROG} > /dev/null 2>&1
-	perf script -i $TMPDIR/perf.data --fields brstack | xargs -n1 > $TMPDIR/perf.script
+	perf script -i $TMPDIR/perf.data --fields brstack | tr ' ' '\n' > $TMPDIR/perf.script
 
 	# fail if we find any branch type that doesn't match any of the expected ones
 	# also consider UNKNOWN branch types (-)
-- 
2.25.1

