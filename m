Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801B856B9C
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Feb 2024 04:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708403428; cv=none; b=t6vIX6Yr9QrtuW6QX53CFv1pAvP4VFQjXbm/UV4rCwcntwAWr1GHiJPlnZixtwkOAbK1ZtrCKMBm87hY3/xn8JQc7uhoLPYX/zqNJ2FWK38Mg0INKZFMgHIQBKtoKPBnScyME++kBCbM+hQebmuvm7MUWfBaL8RWvqth4jE1uwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708403428; c=relaxed/simple;
	bh=/DrutLPIy6ysranDwrIGupb1lheEgN4w13JiqS3LftM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ayFb6dTnXVh/2ZIrBkZJK08yP0cgoe21cIvwHzHLePGISfWgxPsaCLy3ZbblEBYKIDYYjzCvhTqA0vrEx7Gl/jgd+8ObIoiPyEnr8IW2GcpHARs+DTInOMCsPb2fc7MdrFvNIC+lNjWf0N0uVuZEZQZ0LoD7tmwUBcklegABgi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAA5D1007;
	Mon, 19 Feb 2024 20:31:04 -0800 (PST)
Received: from a079740.blr.arm.com (a079740.arm.com [10.162.43.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6935A3F762;
	Mon, 19 Feb 2024 20:30:24 -0800 (PST)
From: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>
To: linux-perf-users@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>
Subject: [PATCH 3/3] perf test: Check output of the probe ... --funcs command
Date: Tue, 20 Feb 2024 09:59:57 +0530
Message-Id: <20240220042957.2022391-4-ChaitanyaS.Prakash@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220042957.2022391-1-ChaitanyaS.Prakash@arm.com>
References: <20240220042957.2022391-1-ChaitanyaS.Prakash@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chaitanya S Prakash <chaitanyas.prakash@arm.com>

Test "perf probe of function from different CU" only checks if the perf
command has failed and doesn't test the --funcs output. In the issue
reported in the previous commit, the garbage output of the --funcs
command was being ignored by the test when it could have been caught.

An additional check to grep for "foo" has been added to test the --funcs
output.

Signed-off-by: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
---
 tools/perf/tests/shell/test_uprobe_from_different_cu.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
index 319f36ebb9a4..82bc774a078a 100755
--- a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
+++ b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
@@ -77,7 +77,7 @@ gcc -g -Og -flto -c ${temp_dir}/testfile-foo.c -o ${temp_dir}/testfile-foo.o
 gcc -g -Og -c ${temp_dir}/testfile-main.c -o ${temp_dir}/testfile-main.o
 gcc -g -Og -o ${temp_dir}/testfile ${temp_dir}/testfile-foo.o ${temp_dir}/testfile-main.o
 
-perf probe -x ${temp_dir}/testfile --funcs foo
+perf probe -x ${temp_dir}/testfile --funcs foo | grep "foo"
 perf probe -x ${temp_dir}/testfile foo
 
 cleanup
-- 
2.34.1

