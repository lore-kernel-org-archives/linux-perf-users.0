Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D303A7820
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960660; cv=none; b=t+qj9cfECy5xZKFFvwRtfStFjeND/3KlTj0Hcj9sBJgu3n5K1LFqre6OYw7bLuraOPt1fUyRTVT53MbLhI9VsmaBXsb7kU8fA16pRwOTDz5K1O1gEj7p1A3DS6/9cRmesjBgoP8cBeYMdHyMxMheyXACpx/77mGanUEzMpn9eNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960660; c=relaxed/simple;
	bh=9WQTtZJ6BOs2jlbQ/thEMBdqWJFDW7uWagIcEBbxnk8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mIZePzpeXe7UMAPzwZLF2LYTKffG+a++rKX8xZ40tO4AjpJgCxGhhNlCE3nBZ33s6zCFvM5msCy664aiA4KfTVdhgTJjyLYNdw3TphIwXo59HwI19h/oYySW9v1+5qmHn/s6z6ER8/mtaSUEy1pMyp2kLgEMszmeB3QFHTMvPHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HRS2JaaD; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HRS2JaaD"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so7364246eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776960658; x=1777565458; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X5V+95Q5Ie0huXAoonJqgxmxTdwrZQqVv/lbi4uyNBU=;
        b=HRS2JaaDVJtJa+8pTFWIGvCL99Q35GlpCUAzSTg6WO3mo6o2KYIqpYf1A7+ph5MjkU
         2lv+6cN87d+/wOajVvLDf4RjuUKlpU6zFSqzikogaNvfAoNO77Y4RYBSNNJeFpmBo8Ik
         dk6FcSnMhsR4p85C7v/aI2HB36b6o5BFJLKGZV54Ln6tahdvUEXdBIeB/TejLnsO0vg9
         8nOr1S6yps6MfeNcznI9aWfBjJq9lj3z77p1jeFxE4Pt0GdaMe6iE0bt1LZhE8XPd56m
         9DMp6ITJBOFQXSPMNH1TfgWCRhajXe3hAFUEkdQQzUMqxFZFfLWzq6Nds0/VLU+ZkqbA
         BW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776960658; x=1777565458;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X5V+95Q5Ie0huXAoonJqgxmxTdwrZQqVv/lbi4uyNBU=;
        b=Mv2Wtr4KVvaixmBKnfBM8kdy6dQzw7cH0bt45rq4YmTW6KL+D2I5EgeLA9Tl/YQvLV
         upAs6GZ3Lw08xNxokqFHeJcQZCLDqhggQ0oh009IpA8h167AC5AIfq/YMvyC5bwzeawy
         LduucFb055iNc+Px1sBtVfDNisVNAlH0+blMCCFm3+rhs98xiOoz53iGbXOrb1JBYbo5
         ufIAeLev1jpox/9Z2ao4vDIwQi+ER9UDi8mZ8qRn0iITQH50h2S2Td5vV3cjmL3mS/4f
         fS+HHGHymEZzidI8ym7UJ9Ih4AId8lc63GCBBnV8mzuvzlBXh4CKHT2CICyOLKtaXCXW
         Co5Q==
X-Forwarded-Encrypted: i=1; AFNElJ+LtbQrIDFlnIsjj0xFMYji2MDDY701vCc4b9f+vS3hXPSN+sLXTg0TVrFSdlwb+hm9V+ufDkVQ6XKERzpZb9O3@vger.kernel.org
X-Gm-Message-State: AOJu0YzA6e4akcUdAIVFjDIZ8L33qtUk7CFu+QFNCyCFZ+kJYFSU+4EL
	2Bq0pFYyv4KNf1CC3E6H8nEU/dn557F+HmFXp7Sw1zpRwt1S5diwMacAxJD48+Y2YG66W8LzKI5
	32QcWcmCyKg==
X-Received: from dycal20.prod.google.com ([2002:a05:7301:1c94:b0:2d7:ab9e:d123])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:4311:b0:2e2:185b:87d9
 with SMTP id 5a478bee46e88-2e478a31a3dmr16339418eec.20.1776960656862; Thu, 23
 Apr 2026 09:10:56 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:09:30 -0700
In-Reply-To: <20260423161006.1762700-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423035526.1537178-1-irogers@google.com> <20260423161006.1762700-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423161006.1762700-24-irogers@google.com>
Subject: [PATCH v3 23/58] perf python: Move exported-sql-viewer.py and
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

