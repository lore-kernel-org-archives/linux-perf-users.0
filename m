Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCC42C21FE
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Dec 2025 19:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764961300; cv=none; b=qxlkqTcx6bYPPbZR3EoEaa7lnuY2X2OJZ4Hquwt8VNyy/E92ejGlZAfbpPDrjoldNedRLTNtjTLdVTBZIFwvJYDtsm8DQ/YW91pNzYetAh99z0ebXYVitIqjgvcLYyE0sRmcXi3yn8fsDfNsRDGvyrnoRgpAf5AnpLRhdEOWYSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764961300; c=relaxed/simple;
	bh=amsAwL5w9MNHSYO+OGFxaf0YooP5dzdJKvp04DC1gUU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=DzyBOZYogaHNYomTojCnrI8MmJ0ZiP6KXKWYeM7oXYgwKABXCrzcUdFyZQbEYJbAVJ+gq5IPX5levKjhI1IhO7dCCZHdREqzUgaYK5VeBMRtyLAH/GRUWlJR21pxouUTq8yr5X2FrW5bOWzkf8EBPoXF66yAc4Jpj52o4COzXjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l7gtHMW9; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l7gtHMW9"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b99f6516262so6090039a12.3
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Dec 2025 11:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764961298; x=1765566098; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kYpx/l3bU8ukPs+imjE6160MxxtpXkOoIX/DFjnca68=;
        b=l7gtHMW9qp0nZ/b1mgn4Ryfzel2W+dXSqYOGTxZNsQdMbfJ2gDG+XldCjsjou29l1j
         LnAkwgKhxjRKNGZCq1IcONAzR7sLyk8WdZhRKDapylb7CZeLvN9BZURxPxRMt+Z0/3Aq
         sJ+jXA8WqgVSEv0Dd1H5bMYMrP6967av3kwE9ZqSvgpa3WpBzmKY548cH4IxMlgxxBCn
         a/z7Vss22Xf86tPUwv3BI+DtY/5o06u9QORqHuRi8QLgcjWSOsSxWQboMufqoaIaBd13
         Nx+4UsUcbmDjYwv6wek6SZzLH0AbH9Ywx0QyO19pwrvbYEJbFkWCK6KeNZqjO1XsP7rs
         nhdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764961298; x=1765566098;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kYpx/l3bU8ukPs+imjE6160MxxtpXkOoIX/DFjnca68=;
        b=quZwN0xrH8KYWjxwZCniMvfqd6YmXm948rlABw4ib/fUJnYiOspUc/aTBclE2l2oiw
         QPa/1bTOwAR0ni4GVYyexSaEI+qwrEssx0nn8vobpW4zR2tSoz8zqPTTsjqA1gj3QHtQ
         xZ16ibtu1Q7wNrL0PknFRWgr6T7QXY8zXwqpvzQO+YFnoRP5Y6YjTQ68+dIXpX32Cwpu
         TZEX4fVuxAL8iXqutLBwRq9Gly7707lq0y/AZPRxXSh/Nb3ABqp0VIVMI+H7MS+fxpRe
         mGb0VKqMb5a+/L9l08OBkVX5UJ1K/JCOrTJ+tOkgKDAjFnwVBWS7RzmFUWh6ggRlG7Wm
         wxRw==
X-Forwarded-Encrypted: i=1; AJvYcCVOBXj308YCIsM3d/TCr3xlQ9B5ZhbbNBhS6jvO9fgNFO+JvHu6qScYuTXJaWwbyFt24o3h98zm7+HTmuIf2AGW@vger.kernel.org
X-Gm-Message-State: AOJu0YzMfIZjKOsBRaGzLXnBWiQnXmpbXRo/v2XPGYE9lCrNLYCbDks1
	Rl6exOqUiLPTEUZ2mqu17xHD/lQ6/e6s3jqsEV58MQ0IGM18BsSXE103Z7ssLDlszVXa/HE85cU
	6ynyN73/xPA==
X-Google-Smtp-Source: AGHT+IFGB1mytV29BrBO2JxGbc3cvdf0PCchNpU0ER2nex9w2mTzPMZFB2AZo9VEllVNd5/jWM0CA+zoPPx2
X-Received: from dyjl25.prod.google.com ([2002:a05:7300:2699:b0:2a9:83e7:2680])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:7d11:b0:2a4:3592:cf60
 with SMTP id 5a478bee46e88-2abc70f78ffmr143960eec.4.1764961298140; Fri, 05
 Dec 2025 11:01:38 -0800 (PST)
Date: Fri,  5 Dec 2025 11:01:35 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251205190135.210864-1-irogers@google.com>
Subject: [PATCH v1] perf test java symbol: Additional libperf-jvmti.so path check
From: Ian Rogers <irogers@google.com>
To: Leo Yan <leo.yan@arm.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If perf is built into an output directory then so is
libperf-jvmti.so. If `perf test` is run from that directory then PWD
needn't also be that directory meaning libperf-jvmti.so won't be found
and the test skipped. Add an additional check for libperf-jvmti.so in
the same directory as the perf binary for this case, this avoids the
test skipping.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/test_java_symbol.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/tests/shell/test_java_symbol.sh b/tools/perf/tests/shell/test_java_symbol.sh
index 499539d1c479..63a2cc9bf13f 100755
--- a/tools/perf/tests/shell/test_java_symbol.sh
+++ b/tools/perf/tests/shell/test_java_symbol.sh
@@ -22,10 +22,13 @@ cleanup_files()
 
 trap cleanup_files exit term int
 
+PERF_DIR=$(dirname "$(which perf)")
 if [ -e "$PWD/tools/perf/libperf-jvmti.so" ]; then
 	LIBJVMTI=$PWD/tools/perf/libperf-jvmti.so
 elif [ -e "$PWD/libperf-jvmti.so" ]; then
 	LIBJVMTI=$PWD/libperf-jvmti.so
+elif [ -e "$PERF_DIR/libperf-jvmti.so" ]; then
+	LIBJVMTI=$PERF_DIR/libperf-jvmti.so
 elif [ -e "$PREFIX/lib64/libperf-jvmti.so" ]; then
 	LIBJVMTI=$PREFIX/lib64/libperf-jvmti.so
 elif [ -e "$PREFIX/lib/libperf-jvmti.so" ]; then
@@ -34,6 +37,7 @@ elif [ -e "/usr/lib/linux-tools-$(uname -a | awk '{ print $3 }' | sed -r 's/-gen
 	LIBJVMTI=/usr/lib/linux-tools-$(uname -a | awk '{ print $3 }' | sed -r 's/-generic//')/libperf-jvmti.so
 else
 	echo "Fail to find libperf-jvmti.so"
+
 	# JVMTI is a build option, skip the test if fail to find lib
 	exit 2
 fi
-- 
2.52.0.223.gf5cc29aaa4-goog

