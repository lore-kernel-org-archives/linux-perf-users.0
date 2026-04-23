Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47113AC0D9
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776962111; cv=none; b=Pk2ME94yDU7NDA+H8vqzFSBNtJnSFy9m0KXVNoVwX/FmkulqG5+Fm+xYe8u2eTLpU47VhouRFl9vpi3TShsB9nR69UMAo9fRh8BC/hKg2AZalatGNqGAn3/xunHKteydBhbeR6hEYHwVE59IR8kGOSBQ2p+UUIszAZhuByvtis0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776962111; c=relaxed/simple;
	bh=9WQTtZJ6BOs2jlbQ/thEMBdqWJFDW7uWagIcEBbxnk8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hBl/ZpNz7xWwMMcaDXTC5AhwqMKtGA+rwpAsotNBmhKSa0l3Z0AhFB/Tqbl0X0seX+Q4s5RqYXFWxY0iuVUamYcE9ANnbj9RNBHGgro4CN6wgafq0ZjXYD0QT0/W8DrpElFvD4YN1Vo5a3GHIwKbectEdiCcwSqcBCuj5asgapo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FrNbB1Xs; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FrNbB1Xs"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2d93379001eso12086038eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776962109; x=1777566909; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X5V+95Q5Ie0huXAoonJqgxmxTdwrZQqVv/lbi4uyNBU=;
        b=FrNbB1Xs6Ymvthay1H0+G10I2A4ujgyCIIta4rgijdsj5rjlmFbHVpuo3h6dLzyg/v
         nJ9O9dzwWDemu4ZTOU0C/21Zw8rXb9LRdypeA7r0svgTAJfgan4GSNAQ+3gF5+5gzV9G
         Te9z+CCaTm+VGgCDbnuHQxh1YQNwvkksY1Mxinr/3HuAPXFHVjdmNfQbwcFQ78z6+cAs
         Xv07yJcpeSj6tKhcfvE/pNQkpC/ZxqAYvjn8EnL/D16RSXvrQU8jh2WIfeDQxCD9i0Qp
         TOLlDKZAYTLK9vZrnkQJbBBJRm6sVPxVbL+ToYvmQmv139nMf3DMQX0s97TwFRTwBdCv
         PkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776962109; x=1777566909;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X5V+95Q5Ie0huXAoonJqgxmxTdwrZQqVv/lbi4uyNBU=;
        b=qc+mPf2bkteCK8QnX0DLJXHm5QcrvWCsSCP3+jxE7yYIvoHSrUM0XKAJXCcsnjKP1c
         IgIoPMpTj9zSO24YS2hgrhdBKe4EtIrGQjiUKfUGRFAgAW7tKIgKTWUDRGibWa8jL2eF
         SYC/DXXs5hVMM9txPtYEP0TtmKCkoN9d89Uk4ONMThLfRlLaL3rOicQG7ePnpg29F0ZI
         13ii9gyhL1z81XTuBdVq2lbG7/thWWATOhbAIlA9EjAiB1+PIDkSUCNHy2Ooa98H/nal
         i8FdH5P/nmy2pjpLH6UEPqoUDDPl5ItEmjBiGiLdPh2sRMA899BfndTm2RO3i5Dc0spy
         yaAA==
X-Forwarded-Encrypted: i=1; AFNElJ+XrODTUeobvqEHEkw4D2YnmJUMdMpFHhHaD3CPeg5WiGy0wQ2IITCU1AIuJjN7y4i4VLYUGiznY7Zi4ayHkgDu@vger.kernel.org
X-Gm-Message-State: AOJu0YzBVh8nH7ImA7KI/UcfzDI49WKIG/9NBEGn44Hvep8tK/4gl308
	g1+x0U7mb3H0Xv+wJ/TiO8R/izUW7AlzCYcbWRwnfj7sv5Io27fLXewf+hV95XvvsK08zx4YPXh
	TrV878D06iQ==
X-Received: from dycnh13.prod.google.com ([2002:a05:7300:ce8d:b0:2dd:3fe1:f5b2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:a194:b0:2ea:83a0:502e
 with SMTP id 5a478bee46e88-2ea83a053efmr8255212eec.25.1776962108643; Thu, 23
 Apr 2026 09:35:08 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:33:32 -0700
In-Reply-To: <20260423163406.1779809-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423161006.1762700-1-irogers@google.com> <20260423163406.1779809-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260423163406.1779809-25-irogers@google.com>
Subject: [PATCH v4 24/58] perf python: Move exported-sql-viewer.py and
 parallel-perf.py to tools/perf/python/
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: 9erthalion6@gmail.com, adityab1@linux.ibm.com, 
	alexandre.chartre@oracle.com, alice.mei.rogers@gmail.com, 
	ankur.a.arora@oracle.com, ashelat@redhat.com, atrajeev@linux.ibm.com, 
	blakejones@google.com, changbin.du@huawei.com, chuck.lever@oracle.com, 
	collin.funk1@gmail.com, coresight@lists.linaro.org, ctshao@google.com, 
	dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, dsterba@suse.com, 
	gautam@linux.ibm.com, howardchu95@gmail.com, john.g.garry@oracle.com, 
	jolsa@kernel.org, jonathan.cameron@huawei.com, justinstitt@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mike.leach@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nichen@iscas.ac.cn, 
	nick.desaulniers+lkml@gmail.com, pan.deng@intel.com, peterz@infradead.org, 
	ravi.bangoria@amd.com, ricky.ringler@proton.me, stephen.s.brennan@oracle.com, 
	sun.jian.kdev@gmail.com, suzuki.poulose@arm.com, swapnil.sapkal@amd.com, 
	tanze@kylinos.cn, terrelln@fb.com, thomas.falcon@intel.com, 
	tianyou.li@intel.com, tycho@kernel.org, wangyang.guo@intel.com, 
	xiaqinxin@huawei.com, yang.lee@linux.alibaba.com, yuzhuo@google.com, 
	zhiguo.zhou@intel.com, zli94@ncsu.edu
Content-Type: text/plain; charset="UTF-8"

These scripts are standalone and not using the `perf script` libpython
support. Move to tools/perf/python in an effort to deprecate the
tools/perf/scripts/python support.

Signed-off-by: Ian Rogers <irogers@google.com>
---
v2:

1. Updated exported-sql-viewer.py : I updated the comments at the top
   of the script to use the new path
   tools/perf/python/exported-sql-viewer.py in the usage examples.

2. Fixed Test Path in script.sh : I updated the path in
   tools/perf/tests/shell/script.sh to point to the new location of
   parallel-perf.py at ../../python/parallel-perf.py .
---
 tools/perf/{scripts => }/python/exported-sql-viewer.py | 4 ++--
 tools/perf/{scripts => }/python/parallel-perf.py       | 0
 tools/perf/tests/shell/script.sh                       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
 rename tools/perf/{scripts => }/python/exported-sql-viewer.py (99%)
 rename tools/perf/{scripts => }/python/parallel-perf.py (100%)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/python/exported-sql-viewer.py
similarity index 99%
rename from tools/perf/scripts/python/exported-sql-viewer.py
rename to tools/perf/python/exported-sql-viewer.py
index e0b2e7268ef6..f3ac96ada1f5 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/python/exported-sql-viewer.py
@@ -10,12 +10,12 @@
 # Following on from the example in the export scripts, a
 # call-graph can be displayed for the pt_example database like this:
 #
-#	python tools/perf/scripts/python/exported-sql-viewer.py pt_example
+#	python tools/perf/python/exported-sql-viewer.py pt_example
 #
 # Note that for PostgreSQL, this script supports connecting to remote databases
 # by setting hostname, port, username, password, and dbname e.g.
 #
-#	python tools/perf/scripts/python/exported-sql-viewer.py "hostname=myhost username=myuser password=mypassword dbname=pt_example"
+#	python tools/perf/python/exported-sql-viewer.py "hostname=myhost username=myuser password=mypassword dbname=pt_example"
 #
 # The result is a GUI window with a tree representing a context-sensitive
 # call-graph.  Expanding a couple of levels of the tree and adjusting column
diff --git a/tools/perf/scripts/python/parallel-perf.py b/tools/perf/python/parallel-perf.py
similarity index 100%
rename from tools/perf/scripts/python/parallel-perf.py
rename to tools/perf/python/parallel-perf.py
diff --git a/tools/perf/tests/shell/script.sh b/tools/perf/tests/shell/script.sh
index 7007f1cdf761..2051c6e05569 100755
--- a/tools/perf/tests/shell/script.sh
+++ b/tools/perf/tests/shell/script.sh
@@ -76,7 +76,7 @@ test_parallel_perf()
 		err=2
 		return
 	fi
-	pp=$(dirname "$0")/../../scripts/python/parallel-perf.py
+	pp=$(dirname "$0")/../../python/parallel-perf.py
 	if [ ! -f "${pp}" ] ; then
 		echo "SKIP: parallel-perf.py script not found "
 		err=2
-- 
2.54.0.rc2.533.g4f5dca5207-goog

