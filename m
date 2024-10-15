Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CEB189BA7;
	Tue, 15 Oct 2024 07:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978824; cv=none; b=pnWH0yV29Mc5mNUvVQ4Q1JHcwNu90AKzG98WWzB6DUdJ//DRKfKLVHo1GJA6beZDlJIBJVBDDFk/dLs8I74Mk5aca85K0VtvMnusZIhcLz0R0VShMDJLVy0ZEHpVCQ8lxL0YqiLza5/54EEZdD3JvNzER1GzjSaX8/rQIvyg/Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978824; c=relaxed/simple;
	bh=N10GtP79W0SQR6wTu+fzxDJSpZ/fzVfhJC0zpyVlcsI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=oYr87HxSddGnhAIwqDKvCs/rA8KbHCB1LfB61GQK6fHpzQ/ycyn4tinoTH+1jdtLGo3vn98XTvG1hqu/bCT7eYmNz023mGzif6ZSjBUtvKGmGsdIoFSnWZZtQaTXXrP/EHlldQ6Ue5Y8HlJk1wJo4lmS7LUL60nR0GmkqBpRlw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=i5wzU23O; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="i5wzU23O"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728978814; h=From:To:Subject:Date:Message-Id;
	bh=iOQC40k/fMHf8VAUXityLW99zk2gANc5PBCPfsApcU4=;
	b=i5wzU23OQzbSTl+F2NckQX1fuVwijuTur7VmdKaIEZjFzwKIBzlfALvm1ykM35ALtblAdi9jbEckav9i8TsSdU2ai2EVunuoqk2XPQNBA2BaqVoY0YLDgT39FuNQABBwehkvz8r4B+XYUbBY7JXNreZDaETIg7B02v/Eq0jkXAU=
Received: from srmbuffer011165236051.sqa.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0WHCfYCS_1728978808 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Oct 2024 15:53:34 +0800
From: Jing Zhang <renyu.zj@linux.alibaba.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: xueshuai@linux.alibaba.com,
	zhuo.song@linux.alibaba.com
Subject: [PATCH] perf/tests: fix record+probe_libc_inet_pton test on aarch64
Date: Tue, 15 Oct 2024 15:53:27 +0800
Message-Id: <1728978807-81116-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Since commit 1f85d016768f ("perf test record+probe_libc_inet_pton: Fix
call chain match on x86_64") remove function getaddrinfo() on expected
file, the test failed on aarch64. On aarch64, function getaddrinfo()
show up in the call chain.

$perf script -i /tmp/perf.data.1PV
ping 2588319 [125] 500119.122843: probe_libc:inet_pton: (ffff9a4f7410)
            ffff9a4f7410 __GI___inet_pton+0x0 (/usr/lib64/libc-2.32.so)
            ffff9a4c5f7c getaddrinfo+0xec (/usr/lib64/libc-2.32.so)
            aaaad6d32b38 [unknown] (/usr/bin/ping)

So just remove getaddrinfo() on x86_64.

Fixes: 1f85d016768f ("perf test record+probe_libc_inet_pton: Fix call chain match on x86_64")
Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
---
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 47a26f2..09d7b0b 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -52,8 +52,12 @@ trace_libc_inet_pton_backtrace() {
 		echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
 		echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
 		;;
+	x86_64)
+		eventattr='max-stack=3'
+		echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
 	*)
 		eventattr='max-stack=3'
+		echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
 		echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
 		;;
 	esac
-- 
1.8.3.1

