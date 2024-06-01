Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B713150992
	for <linux-perf-users@vger.kernel.org>; Sat,  1 Jun 2024 13:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717246827; cv=none; b=gXBuA/Iuz3QCFzEdGWs6DUSwPFVmtHHEBdnO/Rb+kUOdcGCWvHA/GIKYLlwal5hlWIZAa3oqIHHGm7oWSV6BBq2NDqHeVxM4CItYA6hCNOPTiPKVvwtboXePKAGnOxkrekusIGB8+1aXIg2fF1IcN1Ny1GNG93bLAsfBq2KmhxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717246827; c=relaxed/simple;
	bh=tm27VihtpkzgqplqCnNbeyzriWljsQ0IfPsU91B9twg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DpBi/p86TvejAR1bLMfvgzAC2623gj+hB14wRD4x30/pkTpLrymy+D8CEYEwMguMGlKY3ulwpsfzvnYGdClQSR+9lxI4p0CiGZjR6YmqR5ZTAC3hLtQTsDPbCnonC6VhBX67cfx+UJMFyraolf7dv+PLY9m74qyNXpFmt24zcZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F47C13D5;
	Sat,  1 Jun 2024 06:00:50 -0700 (PDT)
Received: from a079740.arm.com (unknown [10.163.70.164])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 690503F792;
	Sat,  1 Jun 2024 06:00:24 -0700 (PDT)
From: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>
To: linux-perf-users@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	james.clark@arm.com,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>
Subject: [PATCH V3 10/10] perf test: Check output of the probe ... --funcs command
Date: Sat,  1 Jun 2024 18:29:46 +0530
Message-Id: <20240601125946.1741414-11-ChaitanyaS.Prakash@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240601125946.1741414-1-ChaitanyaS.Prakash@arm.com>
References: <20240601125946.1741414-1-ChaitanyaS.Prakash@arm.com>
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

The script first makes use of --funcs option with the perf probe command
to check if the function "foo" exists in the testfile before adding a
probe to it in the next command. The output of probe...--funcs command
is redirected to stdout, therefore, add '| grep "foo"' to validate the
result.

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

