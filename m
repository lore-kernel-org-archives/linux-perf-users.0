Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959F73793CC
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 17:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777139391; cv=none; b=j8L09Q5Ua7D55VO2VQNf0eDC7nG12qnXSt0h/dCjIhGMeigjhRMD7w0I5cLJ7Rw/yJBRlMrIh0H/lMkizgr/DNcAz+3amz2VIiv2NVplj1f4POlPBxhQeGdoCiXn2fnvdGcN49f8CLApfBxuqvKgqicbg1Mkf994O+m8HCDTMJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777139391; c=relaxed/simple;
	bh=QiFIbgAs9hH4vFZpTy1iQiMx4BtLAVtLXQUTOjfmcRY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OoYlZRKp0DGUc80Xx+PjzPFGicRtIBiSmbjK6U55pfs7QQVj2y9kr2vBTPjErZs+YgLzQmGSq3gvEG0Mj9q0ft6YLjpXTl99hsAYxT9qcmkkFq99z4aet0NgcDJuc19Z7pDBEERdFLXDOk/1wD4JaUWjWvXX6/89H/oFEhPvqXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iEZcSkT8; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iEZcSkT8"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2d93379001eso19589197eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 10:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777139389; x=1777744189; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FvZ6XnZhDqeAbUzg1oigROcVSwy0qm3+WBD99Jn9WsU=;
        b=iEZcSkT8mQkhgmMRY8MO+iwYYthNoIoW48htWXgyigOH8fPFBdHNjvWTImxiHDJLfG
         ipwXyf+EK4gIIs1tu/9JOCaJ0ko7Lhu8lVY1yTFIV5O7PVotaVw2G/mDd3HYhyn9H5C8
         xvNWWMlZkg22vLBRWAxd+/Q3cug8j6WhexIVFx0239RiLhuQEiNTTig5GTs8hxvsvkry
         TMQLbPqu9olANpTLPYhBD4U56lbwJZxl8UWL5SW/6XQwNW1JyptBRPwEwpwhkLWsLEGy
         cbxjuPMfD4iEYmjKGsVMI/GuQpWtbyLBR8Ag+KO5zodW3RrsoRZyH1d6WhGUXeNoTzo7
         oqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777139389; x=1777744189;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FvZ6XnZhDqeAbUzg1oigROcVSwy0qm3+WBD99Jn9WsU=;
        b=XnjG2WUKAZqYX7wnk03fFUbMABSsvYuZNrg8+zNAmf9dFoJ0tZxBXA55zIx+/Tl0ZS
         E1DCnIz1gxAtqJoyxE+oaYg14HDTBFTLAXap7KvkFU0gFJPj72l9yzjhCH+omeCwmhnq
         rG2x8fSB8rFKyQ2E9PwVf9zt5hB7PRh1fFtHXlJdOrS0jVaCh+trHWnEKGutu3Rbusll
         QEnHJQTaxiviEJsph9+jr9o4P0V76kkY5V9La+WXwyWllgrUydsQxVPiko8KTjnoGALk
         B/YoNqA62AwU/hbklCEogEkFeO343kpvnnvb6KASTM1sP5czy/QmLwxSqM7VkKQNH/ui
         qvqw==
X-Forwarded-Encrypted: i=1; AFNElJ/TdkygaYyW4PbfkYw14C3jQ1R7b1Cg4GegsGRE+1pIvNexm/WZIsISThYsbYlOSiBFZ1osykMdtxGG4K5dYXQ0@vger.kernel.org
X-Gm-Message-State: AOJu0YyMi/ybb5DTC6t49Rf+r/Qh1X0BRjeo7et70Jl8CnRSrSRRbLRi
	hM/NzAVuYUJjPevyGz+hj7do1BYTrtut7Gm3xg+jayZKANEV41ygfKf16W2+PZX8MZz8hYUSvw8
	rkD6NrGl51w==
X-Received: from dycmx3.prod.google.com ([2002:a05:693c:2883:b0:2d9:a817:812d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:310b:b0:2c7:ea98:d94
 with SMTP id 5a478bee46e88-2e464ea8a4cmr18105116eec.2.1777139388488; Sat, 25
 Apr 2026 10:49:48 -0700 (PDT)
Date: Sat, 25 Apr 2026 10:48:22 -0700
In-Reply-To: <20260425174858.3922152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260424164721.2229025-1-irogers@google.com> <20260425174858.3922152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425174858.3922152-25-irogers@google.com>
Subject: [PATCH v6 24/59] perf python: Move exported-sql-viewer.py and
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

