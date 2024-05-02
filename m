Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BA257C94
	for <linux-perf-users@vger.kernel.org>; Thu,  2 May 2024 22:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714689111; cv=none; b=Dq530Ur4UKrrZpiZGmQ9F1u3osR6lcP76XamXLTlNWwuFdieqc1d5/AHEl7m9D5qFNMt8p6LmZAbKZrOtiukNdbAmGPoIOo4wiION16jShocJ5kZqjWoOInhcNhSncnLUfzte4Z0CKuSYweUti8/2oJzUx7XesdFLdy+j6HDEdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714689111; c=relaxed/simple;
	bh=mVhefkMKYAgbzew8H9zwdvpcck6nt+d0ii0oo+fk8MY=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=U3Rezs9PX9gljj/mBBGpRRGktb1NoZh7Os3k7idVoGdcrZr7IRQ3F/ceDWk6QKb0QC2/IlSCUwS/nJt9Fx1k0j5paE4Oqs9L2JxwP+9Ndky7JH82eBEY8+mEH5ywm4pMA3XTDGR6EQPzGfwSxD3ugha10cgA6Oeiew6Ll/68lqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zco1UODU; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zco1UODU"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61510f72bb3so174204227b3.0
        for <linux-perf-users@vger.kernel.org>; Thu, 02 May 2024 15:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714689109; x=1715293909; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D9BlVLjpP7oToPEloTg+EP74LvtZdSlc3EOCbIFaf28=;
        b=Zco1UODUtmQjINKK1ayFk5w/Lz6/sySujiFOSzaSGo5O/GNlzjoFEshkRtoxrm8T9b
         fFq2M+6a3Iw2CVuGmcjrdil/RNq8XueAPc0wthWV949fDEDTfhin12XPejRiASPPXqL0
         VSgs7YyNun1/0SMYwzspfDhXEUnzECfW7b1KCWiPo+LMQH7T14yfXZNg2K94afGsvY/8
         Nd/w/vmadayaEbuk2GIKOJDTnZJJdb/HHVmbikq0Q357C7EKKVWLbCO8O9nn6Q4+5TEN
         CsxqKhrBVOvULerUJ/hAqIcmmWKCm6OVZTjJy98RtLFHqun9Dxw2EZnAHEZuemxazg8j
         1xqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714689109; x=1715293909;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D9BlVLjpP7oToPEloTg+EP74LvtZdSlc3EOCbIFaf28=;
        b=Uhs3llBPMJUhWBtb149oOT6m329wHgtahdlkaKw1uYlwnIu/DK/s8XyCakX9MUWJQK
         EU76F3ioQZcFysrH3lPVsSw8hrcPrhhcOP5eKcCj6uL/XRUfwZ/wy4s2o9bmx3PBMjCq
         3IiEJGTIwAKzWszJOftgngnhFeVSsyk9ishJjQuIaCjY3c39F5RGgXojB0/isijOLSWH
         JwcGT7N9ca6gEArWQJ7byCo9mubwU6ZH8DqHf8GkPWhYFYdUSXkN+QWC+5BBcFPyYech
         5TRABMjGj4I8CamgOS3ZxJUdab8yruuLW/y0A9Bt8eyQ/0sqbdzuchfzwgYUNbkLOs4b
         BM+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVa66r0+3FUjSvryODomHc/dWj/Q1l5TMbNbCFw10EXMx64qQkYes2YXu7V/w+2790fBVjF8aClsVO7UhHyp8GlF/ejRKMC6xcKZATRHikYUQ==
X-Gm-Message-State: AOJu0YwawelHaERW4buPVEvKKTIzmfJVNCiXK7rVu1JqQvm5XepYNVzW
	qRK+CkZ/Ud0K5QKiYv1QTfnX0MeoddEQaE+mmotjgmKJeFkT96Zn/Z5M36V72FCYBDml+zNGz3H
	8enr8bQ==
X-Google-Smtp-Source: AGHT+IF4e2VbqkN2jjNWKDDm3Gcln7ovSliebeDlmk9dm6IpKVCKWNcrpc6+GmqKSfIrd1hZK2lR4tHdmIyq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:deba:378d:2d3a:2641])
 (user=irogers job=sendgmr) by 2002:a0d:d78b:0:b0:61b:e15c:2b84 with SMTP id
 z133-20020a0dd78b000000b0061be15c2b84mr187197ywd.6.1714689109242; Thu, 02 May
 2024 15:31:49 -0700 (PDT)
Date: Thu,  2 May 2024 15:31:15 -0700
Message-Id: <20240502223115.2357499-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v2] perf test: Be more tolerant of metricgroup failures
From: Ian Rogers <irogers@google.com>
To: Veronika Molnarova <vmolnaro@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Previously "set -e" meant any non-zero exit code from perf stat would
cause a test failure. As a non-zero exit happens when there aren't
sufficient permissions, check for this case and make the exit code
2/skip for it.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2. Add skip if event mode isn't valid in per-thread mode. Suggested
    by Veronika Molnarova <vmolnaro@redhat.com>.
---
 .../perf/tests/shell/stat_all_metricgroups.sh | 36 +++++++++++++++----
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/shell/stat_all_metricgroups.sh b/tools/perf/tests/shell/stat_all_metricgroups.sh
index 55ef9c9ded2d..c6d61a4ac3e7 100755
--- a/tools/perf/tests/shell/stat_all_metricgroups.sh
+++ b/tools/perf/tests/shell/stat_all_metricgroups.sh
@@ -1,9 +1,7 @@
-#!/bin/sh
+#!/bin/bash
 # perf all metricgroups test
 # SPDX-License-Identifier: GPL-2.0
 
-set -e
-
 ParanoidAndNotRoot()
 {
   [ "$(id -u)" != 0 ] && [ "$(cat /proc/sys/kernel/perf_event_paranoid)" -gt $1 ]
@@ -14,11 +12,37 @@ if ParanoidAndNotRoot 0
 then
   system_wide_flag=""
 fi
-
+err=0
 for m in $(perf list --raw-dump metricgroups)
 do
   echo "Testing $m"
-  perf stat -M "$m" $system_wide_flag sleep 0.01
+  result=$(perf stat -M "$m" $system_wide_flag sleep 0.01 2>&1)
+  result_err=$?
+  if [[ $result_err -gt 0 ]]
+  then
+    if [[ "$result" =~ \
+          "Access to performance monitoring and observability operations is limited" ]]
+    then
+      echo "Permission failure"
+      echo $result
+      if [[ $err -eq 0 ]]
+      then
+        err=2 # Skip
+      fi
+    elif [[ "$result" =~ "in per-thread mode, enable system wide" ]]
+    then
+      echo "Permissions - need system wide mode"
+      echo $result
+      if [[ $err -eq 0 ]]
+      then
+        err=2 # Skip
+      fi
+    else
+      echo "Metric group $m failed"
+      echo $result
+      err=1 # Fail
+    fi
+  fi
 done
 
-exit 0
+exit $err
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

