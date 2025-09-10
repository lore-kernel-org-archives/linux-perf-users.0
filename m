Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E4F32BF46
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Sep 2025 15:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757519808; cv=none; b=dToUmqIxQnS4dPaZnVbyk4/CC7hRYQ1tGO+YMokHousg478lM4bNzodKBOtpAnGbtfoz/HTpu8DqNPpOLWAe/6UcRw1yuv7NVbCoWqZ603yDWVjBR5+uoN8XYY7ZJn9MDZa6x4S+V3UdEhv7rvAdw1OIBpSBFuwvp4tZGcQ630w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757519808; c=relaxed/simple;
	bh=N+YTr8YJ8tq7DvxpZf5zcvz6cd8fQ2EbBmkTADdjMIo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=ADqAENSS52g/FeFmLvRCn1eh763c2yWp1LwQ0JTDhhpji+ixXjwx4daC3wYtWwC+4EdNhKnu7UpPId1ZJurChU6GhDmopHpON8MffU1e61fDkGlZJrAIs9nJ2ovbt+qKDYc6NYo4BdBoXkZyAKDBKNUSV4GA6vI7yoQsDQ8eBCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HXbXtNBy; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HXbXtNBy"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24c9304b7bcso76856235ad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Sep 2025 08:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757519806; x=1758124606; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DYBsvUTSiy3eilreEVnNRX3JIkQuLOtjlS/T3FePQHA=;
        b=HXbXtNByd0+junstHlhl1APj5lMrOkojJ/+PD1gluS2D4Utduz6osc+6pBb/GMACI1
         yIJyIYVz2wqZ8CN36/zDuJSnqk0xc/ZZwPsMQM/9GRrAt6LrzvznF8nXx+Q5gL/iP+7I
         89Yvn5mg0u7sZr2mOWuVsjBdu9J0hjyhbnkRrRXYX5rSk/n9fLldQxBgLBBwKrxlIem4
         akhPm3yCLt4gw+/3OYu9YYaiGC1rV05fdmf0kfENNmjprE1ZFh8Zp2MpxatrHstfiphV
         8JChuy4wvHIE3S4uaW0sZZK58r8KubZQ1thA39/VPPibPutMcHg5JVrhvq7vhXi6Ibsw
         Clfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757519806; x=1758124606;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DYBsvUTSiy3eilreEVnNRX3JIkQuLOtjlS/T3FePQHA=;
        b=IOmDnGl34wAgJ7u10Ayh7Hp5NNyeJ53sVomnxF0sjHHfek6QCMmeLGwMcQd8GqrmPt
         Jbp8RsSeBGFRAHzVfvH7iguRQXYaAGpJE6RqEnOIA1eyOjjFHgREExYkrqr5+Qb7MkAw
         nLH6+nxXxtMbG5ag5GrueXNn1gNK4bZhLNIt2SdlEo+HVTYT2IeWFM4xLqB0wkT0Zyeq
         6mMUHYclUgtTeBn36Dwm7SrSMssmlvDO8KlNZ2EX5tdMrfPKLzR01Fxd89cGI02Oqkxm
         gK04ZKmmKQw3SdY3BBITBcJv531XYpmY4ljESLfDsibaRSVl4VzH6t4VIagqlwyhcShE
         8Qcw==
X-Forwarded-Encrypted: i=1; AJvYcCVEKQw+YxoNIuITBCuOMI+nyvkZXyXqTNxHcPku+B/cGlgEI+WHGGoCe/X1qJiHU4nFba86QRoJAMog5+n6QstT@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk9VRMmEBzIGcdjd47tv6XHK8Gcbc5B1/epmaOLt0JSgC4UxX8
	G69rmOE8Z+AsUNt4RB+kUvKXSYzdSDK6K41kYt+lJsPJLw3ktVVj6Wh8v8/TYXX/2qKst65lDQ2
	MwbWTpKz/Lw==
X-Google-Smtp-Source: AGHT+IEHn9UIszRp1p4kyU8H/MCgwjIZ3oWz+AKXfF9qUTgYBq7A/AhNz8ZA6KV5OlExMcNLHcZAkGFIcIoa
X-Received: from plbbh5.prod.google.com ([2002:a17:902:a985:b0:24c:b370:db43])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:dac6:b0:250:de70:cf9c
 with SMTP id d9443c01a7336-25174ff62d3mr228709665ad.47.1757519806353; Wed, 10
 Sep 2025 08:56:46 -0700 (PDT)
Date: Wed, 10 Sep 2025 08:56:35 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250910155635.46187-1-irogers@google.com>
Subject: [PATCH v2] perf test: AMD IBS swfilt skip kernel tests if paranoia is >1
From: Ian Rogers <irogers@google.com>
To: Ravi Bangoria <ravi.bangoria@amd.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Collin Funk <collin.funk1@gmail.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If not root and the perf_event_paranoid is set >1 swfilt will fail to
open the event failing the test. Add check to skip the test in that
case.

Signed-off-by: Ian Rogers <irogers@google.com>
---
Remove incorrect sample count corrections
---
 tools/perf/tests/shell/amd-ibs-swfilt.sh | 51 ++++++++++++++++++------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/tools/perf/tests/shell/amd-ibs-swfilt.sh b/tools/perf/tests/shell/amd-ibs-swfilt.sh
index 7045ec72ba4c..ebe1fedb897b 100755
--- a/tools/perf/tests/shell/amd-ibs-swfilt.sh
+++ b/tools/perf/tests/shell/amd-ibs-swfilt.sh
@@ -1,6 +1,10 @@
 #!/bin/bash
 # AMD IBS software filtering
 
+ParanoidAndNotRoot() {
+  [ "$(id -u)" != 0 ] && [ "$(cat /proc/sys/kernel/perf_event_paranoid)" -gt $1 ]
+}
+
 echo "check availability of IBS swfilt"
 
 # check if IBS PMU is available
@@ -16,6 +20,7 @@ if [ ! -f /sys/bus/event_source/devices/ibs_op/format/swfilt ]; then
 fi
 
 echo "run perf record with modifier and swfilt"
+err=0
 
 # setting any modifiers should fail
 perf record -B -e ibs_op//u -o /dev/null true 2> /dev/null
@@ -31,11 +36,17 @@ if [ $? -ne 0 ]; then
     exit 1
 fi
 
-# setting it with swfilt=1 should be fine
-perf record -B -e ibs_op/swfilt=1/k -o /dev/null true
-if [ $? -ne 0 ]; then
-    echo "[FAIL] IBS op PMU cannot handle swfilt for exclude_user"
-    exit 1
+if ! ParanoidAndNotRoot 1
+then
+    # setting it with swfilt=1 should be fine
+    perf record -B -e ibs_op/swfilt=1/k -o /dev/null true
+    if [ $? -ne 0 ]; then
+        echo "[FAIL] IBS op PMU cannot handle swfilt for exclude_user"
+        exit 1
+    fi
+else
+    echo "[SKIP] not root and perf_event_paranoid too high for exclude_user"
+    err=2
 fi
 
 # check ibs_fetch PMU as well
@@ -46,10 +57,16 @@ if [ $? -ne 0 ]; then
 fi
 
 # check system wide recording
-perf record -aB --synth=no -e ibs_op/swfilt/k -o /dev/null true
-if [ $? -ne 0 ]; then
-    echo "[FAIL] IBS op PMU cannot handle swfilt in system-wide mode"
-    exit 1
+if ! ParanoidAndNotRoot 1
+then
+    perf record -aB --synth=no -e ibs_op/swfilt/k -o /dev/null true
+    if [ $? -ne 0 ]; then
+        echo "[FAIL] IBS op PMU cannot handle swfilt in system-wide mode"
+        exit 1
+    fi
+else
+    echo "[SKIP] not root and perf_event_paranoid too high for exclude_user"
+    err=2
 fi
 
 echo "check number of samples with swfilt"
@@ -60,8 +77,16 @@ if [ ${kernel_sample} -ne 0 ]; then
     exit 1
 fi
 
-user_sample=$(perf record -e ibs_fetch/swfilt/k -o- true | perf script -i- -F misc | grep -c ^U)
-if [ ${user_sample} -ne 0 ]; then
-    echo "[FAIL] unexpected user samples: " ${user_sample}
-    exit 1
+if ! ParanoidAndNotRoot 1
+then
+    user_sample=$(perf record -e ibs_fetch/swfilt/k -o- true | perf script -i- -F misc | grep -c ^U)
+    if [ ${user_sample} -ne 0 ]; then
+        echo "[FAIL] unexpected user samples: " ${user_sample}
+        exit 1
+    fi
+else
+    echo "[SKIP] not root and perf_event_paranoid too high for exclude_user"
+    err=2
 fi
+
+exit $err
-- 
2.51.0.384.g4c02a37b29-goog

