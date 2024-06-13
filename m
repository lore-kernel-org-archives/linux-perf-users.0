Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386971369BC;
	Thu, 13 Jun 2024 06:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718259519; cv=none; b=CNEJWGNoC24BPZ+rmzggGlkvJddsdrIwAT7Dyqxg5iydUJ7wweBwdak9hsgT2lgXnzmHRdtAmetVF2SvsdEaelqi5YCOfmxoGS3InPlh33ge681XsIEnMGerN4fimEhGqg7hyRZQXxIfPXCsRXjP9hJgfJOdGm6fG+kviLbL5AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718259519; c=relaxed/simple;
	bh=qOOH+9Hm9oB6Pl9slmBg92oE0d/kfGAl6EWMtpIF2+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Shv7skIxDSlV16go82C9Mpu13CGlfboNq/CqjDX30ZuhX5wlt1N+WIEhi3s0FItU85wPPzNfs9JyY4TMKFFDkV1POYMdM4m/904PscGemUSnjLXxLqmAY+7LGkkB4j+0NhuKCifTGGg9nVqOqGAwR6qyqtQyxW90ETFiyPoVYBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 741211063;
	Wed, 12 Jun 2024 23:19:02 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.44.128])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9F8DB3F5A1;
	Wed, 12 Jun 2024 23:18:32 -0700 (PDT)
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
Subject: [PATCH V18 8/9] perf: test: Remove empty lines from branch filter test output
Date: Thu, 13 Jun 2024 11:47:30 +0530
Message-Id: <20240613061731.3109448-9-anshuman.khandual@arm.com>
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

In the perf script command, spaces are turned into newlines. But when
there is a double space this results in empty lines which fail the
following inverse grep test, so strip the empty lines.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: James Clark <james.clark@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 tools/perf/tests/shell/test_brstack.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
index 5ea64d0c4a6f..928790f35747 100755
--- a/tools/perf/tests/shell/test_brstack.sh
+++ b/tools/perf/tests/shell/test_brstack.sh
@@ -68,7 +68,7 @@ test_filter() {
 	echo "Testing branch stack filtering permutation ($test_filter_filter,$test_filter_expect)"
 
 	perf record -o $TMPDIR/perf.data --branch-filter $test_filter_filter,save_type,u -- ${TESTPROG} > /dev/null 2>&1
-	perf script -i $TMPDIR/perf.data --fields brstack | tr ' ' '\n' > $TMPDIR/perf.script
+	perf script -i $TMPDIR/perf.data --fields brstack | tr ' ' '\n' | sed '/^[[:space:]]*$/d' > $TMPDIR/perf.script
 
 	# fail if we find any branch type that doesn't match any of the expected ones
 	# also consider UNKNOWN branch types (-)
-- 
2.25.1

