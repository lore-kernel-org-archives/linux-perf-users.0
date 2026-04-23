Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93773D3487
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 03:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776916590; cv=none; b=h7wobHJ2O1AD4wOkdbZrgzIYtdg4WFKo008cWmIpUgWqD5WJ3TKRd5riv7WzRttQXHwYUAlUYlnVgQE9UlTXcudSIqwulsX17ODe8oGlCQSZh6pu4nzahbqVO3K/e7zJBTEPFQX4O+QsieL9rh6t/7pv6hkeKjrPxwzBlvqB+9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776916590; c=relaxed/simple;
	bh=9WQTtZJ6BOs2jlbQ/thEMBdqWJFDW7uWagIcEBbxnk8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=onUgQGII3AZHGFIDzCNp+XDRuS2+xtCJ4qIeezrzla0ZWKoHefmke0t/geoe0hQyJIrEQZhe6uWQ0h8XP3B+fE6lKp1uBBVARZ+d0R8VwbwME58rh1q8Ap8RktxQlrvDE/i4S4MsiIpYaG6yjs2sYwfKi7jiWi351DHi96PdZsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CygTHvvP; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CygTHvvP"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c91ef7009so10462680c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Apr 2026 20:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776916588; x=1777521388; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X5V+95Q5Ie0huXAoonJqgxmxTdwrZQqVv/lbi4uyNBU=;
        b=CygTHvvPGcRMyBYHvDiCIGEA5RQzdZ5r4q3OaWQF34Fx4tZoAG3e4aA3IYzmO4vGic
         SLJEgdXNYdlqaKw+KgbfYQ2BunOwrgGF9Rcm5sRf8e0GvA6SikHi+MYTLhOTahVT27VS
         i1KeQYl5e+4qs2l7W+P9kcMOqYSwzwbFYS2rHS9EKXxEb0dsJPqx8om/GFeLR+ZPjXcY
         rLFFxp7SNKEgoJO6ZbS0CTW4VHcky8eFOANhUJKAmwkf3mLDYSwIrT82UDTKeNyQGVts
         Je8c+bhyzOl0Y0UYeCIBUeSN0WiDBeoiiAFiheEC6P6isyk0NyRSoI8hZ/boxNpmcSrt
         98uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776916588; x=1777521388;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X5V+95Q5Ie0huXAoonJqgxmxTdwrZQqVv/lbi4uyNBU=;
        b=aelUe1yLj1cSCx4bHErv9UH5kyrfMTmQpg1bdPfn5OY8MyHxQ9xhu8HMpYOPVI1HmA
         74pafW6IY+20lHwCoWa8XlAZk6cpUwCo61NrN9o+8vuczr0XB7t46Jbiu7PpemiW/uv1
         +MRsPRHbnNpkVk6YGC6c7Gt+lCulZPTbYWDDFQe5T2KLicVn15beS6OLZ2M8qG821nay
         m5wbKf/EnTtEYX886B30nsk10WGOUYfXiCJAJnzFY5rP32yAZfIoECfFHha+WpCZoNoI
         Ckj4B9g3ebz7OEIIVY5HdFwetQyCy6+b54KctQh/KVxNYVAq1adPOWFH66Z4iGU4B5F7
         BcxQ==
X-Forwarded-Encrypted: i=1; AFNElJ99aCBPKk6moPJrAC1+7qKpqbfHumJy9fKortu4byfwHms0fbCiw9sHYabKTdLBsGbsfgyzp0zttLxPV74tt38d@vger.kernel.org
X-Gm-Message-State: AOJu0YxefW1C/0g20d4tsLw/g6dCV7yvwIBn0NKcFm0nkunw1gadBlnU
	q0cvb6qmC/QG16eFKLNnDxtYF4Qv6P2pV8Wae68kN8ciYw7l+hyRGmfYtiDEzX7ktWf4gyeczL0
	cCyPXSQwQ9A==
X-Received: from dlbsn12.prod.google.com ([2002:a05:7022:b90c:b0:12d:b26a:1571])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:23a0:b0:11e:163:be60
 with SMTP id a92af1059eb24-12c73fadd10mr13985996c88.31.1776916587524; Wed, 22
 Apr 2026 20:56:27 -0700 (PDT)
Date: Wed, 22 Apr 2026 20:54:51 -0700
In-Reply-To: <20260423035526.1537178-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-27-irogers@google.com> <20260423035526.1537178-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423035526.1537178-25-irogers@google.com>
Subject: [PATCH v2 24/58] perf python: Move exported-sql-viewer.py and
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

