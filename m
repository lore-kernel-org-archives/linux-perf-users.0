Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37A239527C
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777156943; cv=none; b=aqSraoUFwaEe12Z9mD8vxShANhK5qtk2PvjUfBuHLpaMiIjaGHMN2OKsShPY41s67CQvkyKlLffGoAbQp4EpcJQqHquh2qJlf0F4QhIGa7Ub5WZfajMmGVh89gg9dD5TOM5CsYk4oZRgqrJj6TpGAI33beOVe/0Fg9anwn+8yRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777156943; c=relaxed/simple;
	bh=QiFIbgAs9hH4vFZpTy1iQiMx4BtLAVtLXQUTOjfmcRY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rxgKqyZ4Xqmdw+xnBxXAtBIRbKzRFvf8UYoH+6IklSKKB6RVLI5lB1N1Gz8/wW8U5ubru2tfxyg4m/26pUo5diTD9WiLlHV4FUNqgQPs02jyzSEJszXpYMAH4fWcwL/k9dEXiFs7lC8Sv49G5UGkFW9pECfTu+uXfRdgdb1pk98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uwUTSh2x; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uwUTSh2x"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdf6fe90a9so13686664eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777156941; x=1777761741; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FvZ6XnZhDqeAbUzg1oigROcVSwy0qm3+WBD99Jn9WsU=;
        b=uwUTSh2xf1zvVs9uDMH8n8B/3y+xxC1NxuR2GeghNKmBP//ttckFwKVexDWdXKdIWF
         0bC23lvorWRXsiVEfssEe2zHKOjlN+YdQ7v279AiMJgJ5LsN4rFBsoybghgUig5ptgVf
         O3BSp+0EnxqHEETJTVjzRob4C3zTQyTf9jPfxMY5QPYjtLbyWkSpYUaJVo6IbpIHTMUi
         CyGrUOPqeltwS7p/0h5yKu29J4b/mU9G0xjRguyFCoC7GkCeiO+Y6W1FV6LpLsL6HYxu
         XtJz2eHsxcAXUHBqnIkX2IQFqZcr82yuceGHJXhD9aVsqIW/v1YZSxefoYoEFTSjJviG
         awAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777156941; x=1777761741;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FvZ6XnZhDqeAbUzg1oigROcVSwy0qm3+WBD99Jn9WsU=;
        b=pP4sbQQ9J5fW0L3ow0OHMeDtQrirN3GbXFgoB3U6Qqm6N7KN3fEZrDQBGlQyh1T3AT
         rgIJZAOMUckB9L488me6Z4BBwrxkAQbHbbSgNcOI+2c0dfhILlsQGLuIO7Qf81wjTcmi
         cQVLCT/h4KNxu7fXReWuRt+xM0ZklDzStmnYvaDZaySv70mcqRhf4JCCe32DvoVT09Pi
         bnqHLc4bySUJ+nR7HsrvSpeU6ClQ1wKx58ltUFSk5v2gAgrWzxQqsCimoypUh9zH7Zo+
         JbfVG31oeFLsOYpU8k49OcP9QKnETFW8ynKJIvh2lQRoA+VxuGsOPwts0BqoqqAO6uNP
         kGPg==
X-Forwarded-Encrypted: i=1; AFNElJ+KhdS8zN9KtZTBVDEthDe1+Pea1zZ1SKxx/lLlosNa78o0csKegm5ESh6f2vdI/JA7mfueT6nWFZ/7Qn2ryN6N@vger.kernel.org
X-Gm-Message-State: AOJu0YzvcLf0HU5Q8Bkwe+ZhpAdeq1ihQ5H33CpgwieZw8ttn+gKVahm
	IBHhFoVnQx2flatHge/tV6zxI+aNCbMvseenWO7Rruj4KMARTPA4FBuFRmtnK7K8HNwvcWkSpb8
	wxQEZoyzxYg==
X-Received: from dycpv7.prod.google.com ([2002:a05:7300:de07:b0:2da:4712:5fcf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:10c:b0:12c:61fe:fb49
 with SMTP id a92af1059eb24-12c73f6ded9mr20214163c88.6.1777156940749; Sat, 25
 Apr 2026 15:42:20 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:40:49 -0700
In-Reply-To: <20260425224125.160890-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224125.160890-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224125.160890-25-irogers@google.com>
Subject: [PATCH v7 24/59] perf python: Move exported-sql-viewer.py and
 parallel-perf.py to tools/perf/python/
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
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

v5:
1. Fix Test 105 Failure: Added a shebang line and marked the generated
   `db_test.py` script as executable in `script.sh`, preventing
   permission denied errors during standalone execution.
---
 tools/perf/{scripts => }/python/exported-sql-viewer.py | 4 ++--
 tools/perf/{scripts => }/python/parallel-perf.py       | 0
 tools/perf/tests/shell/script.sh                       | 4 +++-
 3 files changed, 5 insertions(+), 3 deletions(-)
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
index 7007f1cdf761..f983b80e77b7 100755
--- a/tools/perf/tests/shell/script.sh
+++ b/tools/perf/tests/shell/script.sh
@@ -43,6 +43,7 @@ test_db()
 	fi
 
 	cat << "_end_of_file_" > "${db_test}"
+#!/usr/bin/env python3
 perf_db_export_mode = True
 perf_db_export_calls = False
 perf_db_export_callchains = True
@@ -53,6 +54,7 @@ def sample_table(*args):
 def call_path_table(*args):
     print(f'call_path_table({args}')
 _end_of_file_
+	chmod +x "${db_test}"
 	case $(uname -m)
 	in s390x)
 		cmd_flags="--call-graph dwarf -e cpu-clock";;
@@ -76,7 +78,7 @@ test_parallel_perf()
 		err=2
 		return
 	fi
-	pp=$(dirname "$0")/../../scripts/python/parallel-perf.py
+	pp=$(dirname "$0")/../../python/parallel-perf.py
 	if [ ! -f "${pp}" ] ; then
 		echo "SKIP: parallel-perf.py script not found "
 		err=2
-- 
2.54.0.545.g6539524ca2-goog

