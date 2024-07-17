Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B54617F39B
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721235445; cv=none; b=RyJdEf/aFXah9wM8+hEhlsL1H/9E24oUFZUWoRqQOWECsQTH+wlWTAsFd3L4dCXsq7TmsZp8dpsFkA1EPbiMOz6aaOXiO6ZHkQ502Ixbt5j7wiq0l+V2ikWw1mWxcMdGLwcCF9SlSkN/4sS02gWXkJzCZyAQG9o3xyNLiNmGGuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721235445; c=relaxed/simple;
	bh=IjnllwTj767aPbfDi2WwSP9XCxnUk34lvzDcQA7zglk=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=WMBmQTXFUwTvMVIG0TQJnQkIpJn5H7VCJBfOU55WlYlbf8fbs0iqNEmS4Ta/YROG0A+Um3Fhe8ZnvEdjsuT3Sf1k2AaOpwFA3nWfhaqUYWNkVkcy0dkrTXdIc2Y5EXxLwld7d2SEhDUVtR3e52vND2Z0eY1XNt/H6dOQNQwaG0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gWA1X5DC; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gWA1X5DC"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e03623b24ddso13377863276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 09:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721235442; x=1721840242; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DJ+JBXLMzrE81p6C5ULaiiqNPy0RFhQ8n+zN5dr/9rc=;
        b=gWA1X5DCPYdEWJGafPRid8sTFAfQ6RAtsp0BAAr4kgtz4hP607u/LpPe5jN6YHpcyU
         hquZkp3qfQmB+lYEc7x+Gzx8shcSziez+YJyQ2veUJzmIrv3MVthMC+dQgSj07g8PB51
         kSn1ewk3cM3f5ax/YrAO4awcRczRKqWFL3jtH5uW0mLnt+H88FlxoOs0afChj2/0qp8k
         ecfr7AXumTecDIeM+2OtBrOGz4B9tCRBhS9k7KEPzzig8L4Rk6747lReXgE4M5bKk/Tq
         n8RYzdr9l75WN6D0AI3vPQrSygD9nMLZiu+6ODmWhKyLygFQHIDaqXsWXM/Y91je/aC0
         gk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721235442; x=1721840242;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DJ+JBXLMzrE81p6C5ULaiiqNPy0RFhQ8n+zN5dr/9rc=;
        b=rR+6Dc9wjhTltA05yjijU42TcyS7WOSW6BJPtJ76JsqYAc+kdcVa7TszUqw4kJ+YSU
         HHRWuuVG6RWhWi29xeEdPhccrSEbLsmolftFHNbqqM9NI2DmTj7ZDyU5OQdJCDKkse8S
         nelrgE8t7cFSC1wo5B/OCR4NWsEAR0VB9Lc0i255MH8cVjNNDOwBLfJVfxLP1Lc55yeW
         aOi8lB+zwvVkK3ro9Ypp/54GK/u6QKnoRv5Lbzy/eox80ZptU3er5CVpCnYNK1S1bSh+
         gQuuqzaxphzPaW1XnLfnbrjF5pza0MkcfeKRWedeTFwK128ra42tOLbPoAta7RcjzXGB
         L0Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVST+4gY4jxXYQzoSapMjqS/1SepAooezz68bxD6Z2qXvyonRyRgWmspj7l7OPFPEM21f5fzRqifkoWJrdDa9SDTePSR148Ei6g8Nh6/YmX2A==
X-Gm-Message-State: AOJu0Yxg9QnGRV/VWXUjViS5K2lvRqyBh5dJJ+6l/EkCuzRPnuEe3JbW
	w4CraS3UKb21V5taZ/jzh5+QIXIk/cPgFuQVUzFaBhkUlg21Y0z+bq+bLRVwrIbP1e3+yqPvduD
	+QmD9umuLsE14X+AyUdTuvSs0gApD5/omxWsDoBlsYEA4MlUU1sSqoPMJqB0txCpiKSPVjWf8+w
	X3
X-Google-Smtp-Source: AGHT+IELfoH0lhNyomfyiOKTJNhGzwlAxnFqZE1C+vHb5ScwoK1xAVW/9IkW2X76qVCOGanFrhv6E8NVYqRI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:c04c:fe63:5ff9:e346])
 (user=irogers job=sendgmr) by 2002:a05:6902:248b:b0:dfa:6ea5:c8d5 with SMTP
 id 3f1490d57ef6-e05ed7c4790mr6815276.10.1721235442238; Wed, 17 Jul 2024
 09:57:22 -0700 (PDT)
Date: Wed, 17 Jul 2024 09:57:17 -0700
Message-Id: <20240717165717.1315003-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v1] perf test: Avoid python leak sanitizer test failures
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-ccpol: medium

Leak sanitizer will report memory leaks from python and the leak
sanitizer output causes tests to fail. For example:

```
$ perf test 98 -v
 98: perf script tests:
--- start ---
test child forked, pid 1272962
DB test
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.046 MB /tmp/perf-test-script.x0EktdCel8/perf.data (8 samples) ]
call_path_table((1, 0, 0, 0)
call_path_table((2, 1, 0, 140339508617447)
call_path_table((3, 2, 2, 0)
call_path_table((4, 3, 3, 0)
call_path_table((5, 4, 4, 0)
call_path_table((6, 5, 5, 0)
call_path_table((7, 6, 6, 0)
call_path_table((8, 7, 7, 0)
call_path_table((9, 8, 8, 0)
call_path_table((10, 9, 9, 0)
call_path_table((11, 10, 10, 0)
call_path_table((12, 11, 11, 0)
call_path_table((13, 12, 1, 0)
sample_table((1, 1, 1, 1, 1, 1, 1, 8, -2058824120, 588306954119000, -1, 0, 0, 0, 0, 1, 0, 0, 128933429281, 0, 0, 13, 0, 0, 0, -1, -1))
sample_table((2, 1, 1, 1, 1, 1, 1, 8, -2058824120, 588306954137053, -1, 0, 0, 0, 0, 1, 0, 0, 128933429281, 0, 0, 13, 0, 0, 0, -1, -1))
sample_table((3, 1, 1, 1, 1, 1, 1, 8, -2058824120, 588306954140089, -1, 0, 0, 0, 0, 9, 0, 0, 128933429281, 0, 0, 13, 0, 0, 0, -1, -1))
sample_table((4, 1, 1, 1, 1, 1, 1, 8, -2058824120, 588306954142376, -1, 0, 0, 0, 0, 155, 0, 0, 128933429281, 0, 0, 13, 0, 0, 0, -1, -1))
sample_table((5, 1, 1, 1, 1, 1, 1, 8, -2058824120, 588306954144045, -1, 0, 0, 0, 0, 2493, 0, 0, 128933429281, 0, 0, 13, 0, 0, 0, -1, -1))
sample_table((6, 1, 1, 1, 1, 1, 12, 77, -2046828595, 588306954145722, -1, 0, 0, 0, 0, 47555, 0, 0, 128933429281, 0, 0, 13, 0, 0, 0, -1, -1))
call_path_table((14, 9, 14, 0)
call_path_table((15, 14, 15, 0)
call_path_table((16, 15, 0, -1040969624)
call_path_table((17, 16, 16, 0)
call_path_table((18, 17, 17, 0)
call_path_table((19, 18, 18, 0)
call_path_table((20, 19, 19, 0)
call_path_table((21, 20, 13, 0)
sample_table((7, 1, 1, 1, 2, 1, 13, 46, -2053700898, 588306954157436, -1, 0, 0, 0, 0, 964078, 0, 0, 128933429281, 0, 0, 21, 0, 0, 0, -1, -1))
call_path_table((22, 1, 21, 0)
call_path_table((23, 22, 22, 0)
call_path_table((24, 23, 23, 0)
call_path_table((25, 24, 24, 0)
call_path_table((26, 25, 25, 0)
call_path_table((27, 26, 26, 0)
call_path_table((28, 27, 27, 0)
call_path_table((29, 28, 28, 0)
call_path_table((30, 29, 29, 0)
call_path_table((31, 30, 30, 0)
call_path_table((32, 31, 31, 0)
call_path_table((33, 32, 32, 0)
call_path_table((34, 33, 33, 0)
call_path_table((35, 34, 20, 0)
sample_table((8, 1, 1, 1, 2, 1, 20, 49, -2046878127, 588306954378624, -1, 0, 0, 0, 0, 2534317, 0, 0, 128933429281, 0, 0, 35, 0, 0, 0, -1, -1))

=================================================================
==1272975==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 13628 byte(s) in 6 object(s) allocated from:
    #0 0x56354f60c092 in malloc (/tmp/perf/perf+0x29c092)
    #1 0x7ff25c7d02e7 in _PyObject_Malloc /build/python3.11/../Objects/obmalloc.c:2003:11
    #2 0x7ff25c7d02e7 in _PyObject_Malloc /build/python3.11/../Objects/obmalloc.c:1996:1

SUMMARY: AddressSanitizer: 13628 byte(s) leaked in 6 allocation(s).
--- Cleaning up ---
---- end(-1) ----
 98: perf script tests                                               : FAILED!
```

Disable leak sanitizer when running specific perf+python tests to
avoid this. This causes the tests to pass when run with leak
sanitizer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/script.sh             | 3 +++
 tools/perf/tests/shell/test_task_analyzer.sh | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/tools/perf/tests/shell/script.sh b/tools/perf/tests/shell/script.sh
index c1a603653662..d3e2958d2242 100755
--- a/tools/perf/tests/shell/script.sh
+++ b/tools/perf/tests/shell/script.sh
@@ -61,7 +61,10 @@ _end_of_file_
 	esac
 
 	perf record $cmd_flags -o "${perfdatafile}" true
+	# Disable lsan to avoid warnings about python memory leaks.
+	export ASAN_OPTIONS=detect_leaks=0
 	perf script -i "${perfdatafile}" -s "${db_test}"
+	export ASAN_OPTIONS=
 	echo "DB test [Success]"
 }
 
diff --git a/tools/perf/tests/shell/test_task_analyzer.sh b/tools/perf/tests/shell/test_task_analyzer.sh
index 92d15154ba79..cb02bf23e6a5 100755
--- a/tools/perf/tests/shell/test_task_analyzer.sh
+++ b/tools/perf/tests/shell/test_task_analyzer.sh
@@ -11,6 +11,9 @@ if [ -e "$perfdir/scripts/python/Perf-Trace-Util" ]; then
   export PERF_EXEC_PATH=$perfdir
 fi
 
+# Disable lsan to avoid warnings about python memory leaks.
+export ASAN_OPTIONS=detect_leaks=0
+
 cleanup() {
   rm -f perf.data
   rm -f perf.data.old
-- 
2.45.2.1089.g2a221341d9-goog

