Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7D13DCD9F
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 07:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360808; cv=none; b=gndsyxpN2ZNoWduhflnykUybV/urcSxfd9QW/XCKPsZzIGQUeyrh8payKUjCobjVjTr7hSMqvM1EIfR/aDpBf6G4udc4DuYJvJGdZ06YMQpwOFlNC1+sC5NxVzuMFp/ad/EhOoo9z8GGGRmawLEDY0tZ84ZatFDk1yHnHVaNfpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360808; c=relaxed/simple;
	bh=QiFIbgAs9hH4vFZpTy1iQiMx4BtLAVtLXQUTOjfmcRY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OtUSjudnS1vaSgwek1LOEyoCJhSnB/wb4Laurv7cXsxPkgnkGpFMCB+FIFY26cKRO+2TCkriiFHO+L1eePlh8zwM/dvLbCyRDeanEVCbMbMGy1pga0Ue2OjZXfbi3ui/F+TtVHsqUNFvKCEHgt92WRjWg4ANNeWfl3riCNVe3c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mvah9oOw; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mvah9oOw"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdf6fe90a9so17675007eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 00:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777360806; x=1777965606; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FvZ6XnZhDqeAbUzg1oigROcVSwy0qm3+WBD99Jn9WsU=;
        b=Mvah9oOwm8eLJumbHdRqCv1pHk8O60LFn3YF8x0WiewPta30Zp9phpBoPu9DO02tY7
         qUWyajv7Q5FuhtniWhMv9ZuPZN9evcKAKyPp7GFG4FrsHClfzBuVugEpRKmN9IJJuciN
         dRSCsQ2AEF0DiImrE5C+bp/XamRWKFkusCNcQaoipj5ALV4w5PDTVkDi3cWwgS39hvZO
         mqSndonxn9YDzz1vI14cIae8oND73ffn6zeMS2pDJ0et5Y5hu7/pzuMn4b4fWZn6SeQp
         nV/+k8t8pw+xCMPQBvu/RijWcOa8n0k5gY7925qlzgS31kCh8C6GqzGZcRC9otHrArLH
         t7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360806; x=1777965606;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FvZ6XnZhDqeAbUzg1oigROcVSwy0qm3+WBD99Jn9WsU=;
        b=CPCB9aYUDy9DYfgtbIPL+n05W2Y5lJ5Ibadi2M1QcETfaKMRvyRBM8w4MzoktHnRDa
         PmSoGcpwb7OCIUDGvMGbSAL+rDJFQrGSUsZCRYheBQXPlMsgWbQvu96yWqOhOXGqSFLo
         4tJXQ331odP7D4YWwRnz3wh5+Qmkqf04sIw2rcoEEp2YHyT58i6Y9DBf/8K7nse5N1Kf
         sE13QZvumVX+k5Cfv4Dyuhp4jJu8eymbrEQlr/8FZRoLWAuA0yDMXltrMJGVwX1rUtpl
         KWUHbbiTEZuhY+bH2TYZ4sYW6PHvGlac2jVBgJq++rkovs6FXXUENkDBLBMEVg5xD1Ar
         HT3w==
X-Forwarded-Encrypted: i=1; AFNElJ/F8C3ZKmHv6304nnRz6hyvEBaANKryU+gRPJTTTHNO1De+137HvZZjy2/oxe4axmN8hFJbEYIG+EUTJM4710HC@vger.kernel.org
X-Gm-Message-State: AOJu0YwgCshiTwU1/4NtVlzgHVhbHV+TW9lL1AukZGukubxI33gS5R6C
	bD7DQOCiWK006VbKcPGBSIj6oVs+BRys/3/tWR9udtgYQH/wREaZWjWc9QZcXvgXx4GBJTc4XUx
	FgexpAWar/w==
X-Received: from dlbut2.prod.google.com ([2002:a05:7022:7e02:b0:12c:8ccc:748c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ea2c:b0:11d:c22e:a131
 with SMTP id a92af1059eb24-12ddd961f1amr1047382c88.3.1777360805824; Tue, 28
 Apr 2026 00:20:05 -0700 (PDT)
Date: Tue, 28 Apr 2026 00:18:29 -0700
In-Reply-To: <20260428071903.1886173-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425224951.174663-1-irogers@google.com> <20260428071903.1886173-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428071903.1886173-25-irogers@google.com>
Subject: [PATCH v8 24/58] perf python: Move exported-sql-viewer.py and
 parallel-perf.py to tools/perf/python/
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com, Ian Rogers <irogers@google.com>
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

