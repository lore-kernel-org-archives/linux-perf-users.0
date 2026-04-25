Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B8339F184
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157465; cv=none; b=XFE2/OIwVCfj1A/68aM5RvJordelOQJNRQW2paudGsRdnOkTg9V1D0W2szzPwjAj676u4DDcrznjyEoueABsCNtmFM6teSMco587dqgqmdQj01gUbPMCFuXfCVmsmT39F7loINiIY/aI6SoCArnIU/u8aX10kbpDWo6KIKsJG3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157465; c=relaxed/simple;
	bh=QiFIbgAs9hH4vFZpTy1iQiMx4BtLAVtLXQUTOjfmcRY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HIO1pBcERFvJ+3Md63XKbobDuToRurkjJLzHmlnL7dD7n6OpZ9gbUOdWfU26/mu5lVUD9JGpIknzv4EBM/6W9jxgP/+D9rXkvoLVNJjVqwSWMom1N3dzdqUDcQAJlpvu5XWJ+4dE3hzvqHzaQxvlbRClxgHOqAHYBSY+Z+zZwCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ikri6p3h; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ikri6p3h"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c87ba0890so30473628c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777157463; x=1777762263; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FvZ6XnZhDqeAbUzg1oigROcVSwy0qm3+WBD99Jn9WsU=;
        b=Ikri6p3hNkV+WKobE7wXjy3xFHdWttlLKCucVQqTYJhphseiueL3NGH/wAkcviOJ3C
         0mE/KfJJfyEmUVFuReR1qQJ9wZSz9iDPpXrhP7bYdj8hiy3bo9JQJECnCCsefgpOTHOB
         76wFTScmOoJ3UJaUp8wHyvCx8dggDMKWfKclVD9WPLC+ap7EPIcXmp9C/rdgtGPvcpmB
         vBPpVZrsfAB3rAg08c1Hbx8lH+iW1Bnu1zG+k9uqh75obzEJrQQcl44IoLOXWY89kx4y
         ijB2+kCoawnhQzt4yStAh3gJWA6d/AXRHNtuxB+/kMfuzQCJdPhhSWm1vULn/veNe6PT
         Y40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157463; x=1777762263;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FvZ6XnZhDqeAbUzg1oigROcVSwy0qm3+WBD99Jn9WsU=;
        b=MHXQM3p7Pq4lUGcDHp4Ok5hOrBa22wlnaJX8I56++7VfhgdaMvZIdvDnBFRqdl9lkQ
         tfNF8+6vGDQMnLEuAHgecDoZ3wNj7z5B4wL0WytBrFTLyLX9VlAGMkhgLyd+79oOAk6D
         Z+IfZ9wJthWGZQZQZR+HKni3D6Q4zeOVT0volRWFgN/B3YMxISA4XxAt5Ms7xNdtOVCQ
         Zzv/K88ddgbjT+AQkIYG6971uP+868d47pgBqVn6TER+QccGwTLtGgmIviPWTSFkGe1r
         Irp4MUPppf6YWLBs4v1EwAFP2MdxANAhQ1HxVMSDR6vv4X+pRkn1Ao45AdqaZZ+pJmvx
         KedQ==
X-Forwarded-Encrypted: i=1; AFNElJ9wml5bTfZN3r4zbwf4dY0wrW2fA6xh4j0SXLFrcQcpPCCu9t3nqzAWefvPc/Veu/8bJXWaRQj50JZzPQpUOp29@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2JxXUmoCQ/PbmIPyHNf7QHBBYAIWFvQZa+mWjdVy0DIgjxgaS
	vmnzOh4Z4ai/RSzLmqmM0CgHnD5mpJCVh7m5gV7famwgow79GLw3nyRXoy8jEsHDBv/IvSLf3Gk
	63H16aqg1xw==
X-Received: from dyb19.prod.google.com ([2002:a05:693c:6313:b0:2d9:db60:7492])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f40b:b0:12d:ce36:8930
 with SMTP id a92af1059eb24-12dce369210mr1680182c88.3.1777157462870; Sat, 25
 Apr 2026 15:51:02 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:49:16 -0700
In-Reply-To: <20260425224951.174663-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224951.174663-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224951.174663-25-irogers@google.com>
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

