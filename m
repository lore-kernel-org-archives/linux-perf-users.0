Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71ECE8827
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Apr 2024 06:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712557445; cv=none; b=Z2EMLHN5yiKKy0nct9akihtHWcyzxmm4R78rQqiWQ3mvW1san6twH/ffTnvxZLsu74S2JrMHWCC7Xraaqwxu9Xtxb2PibVAbPdRQwqKMnfSuyyrramWbgJWsdt/yiT7qoGQNWcE1XcFqLqk3UNX5JhWAGJ7YRNcQiM7odUppFdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712557445; c=relaxed/simple;
	bh=Mi/XI91dR5qauTBqQxqMCXlRxEPhh82SOvn6OuivInU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NQR4c6p6YtcHol2DGNHrLk+QPoNVVhtra3Xi59Ptg1qSMit6GEmQP8TD8qwW+Fv7S5ILdov4Dbg0nzq1Ar2c4moIlbEV2rgQ2Mxcc6jda0ieZh2Qoo2/tDyRgAnwGQOkuyrPo0ya7PfmoF21aTkddYRjRQ1PYtiKbVgiLHu4uoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 979E612FC;
	Sun,  7 Apr 2024 23:24:34 -0700 (PDT)
Received: from a079740.arm.com (unknown [10.163.54.109])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EC0FD3F6C4;
	Sun,  7 Apr 2024 23:23:59 -0700 (PDT)
From: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>
To: linux-perf-users@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	james.clark@arm.com,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>
Subject: [PATCH V2 8/8] perf test: Check output of the probe ... --funcs command
Date: Mon,  8 Apr 2024 11:52:30 +0530
Message-Id: <20240408062230.1949882-9-ChaitanyaS.Prakash@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408062230.1949882-1-ChaitanyaS.Prakash@arm.com>
References: <20240408062230.1949882-1-ChaitanyaS.Prakash@arm.com>
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
2.30.2

