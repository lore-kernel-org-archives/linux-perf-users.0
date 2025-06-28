Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491411EF092
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Jun 2025 01:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751075919; cv=none; b=sHEHEc3AibzMY8/qihO82Y5/3nri6RibOa3kmKTLcOEqrCfTov7APqee+tvYmiz83fx+XPtqa0Mmx990sNLWMgwrQhiODcUVdLfhVsX6M3xBLzjR0R5JmvTnZDoRnPjZhpSUli1Cqv2Nb9IMa85uLAT4AJvDrWTPhX0eoVRjeFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751075919; c=relaxed/simple;
	bh=Ax6PVjysvVmkdZpiGPf+FNf8BQln7B9S7Vembicd0Lw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=i4eLydu0IZZttJ2cwdiCU9T822JMrOU2sFP2shJRlAqcLn+ikhjAwZPsV/IX3Z2uEFow9fjVE5SCidJvAml8xMHTEPiPOeBXRGubFMvCfeCpyqFugvT8a3ub6qAhiE6LnSMOsbofOM8ARoMS8OFH7N2LREwLzfoaSZFQ93ZdAgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mTBTfSE/; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mTBTfSE/"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23536f7c2d7so2962575ad.2
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 18:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751075917; x=1751680717; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z4qJuZ+MbBlsjD8+LJUsz09T91b2pylsklhkgd6DbHw=;
        b=mTBTfSE/0mbhYB3Y4+5at6vDCWO8DMCck2WwE9qHh2YEdRzKI6PhGPMhgzYqQD+pKm
         2Pi7l/ysG9vdwQ1xVD2UdgDmhFr+dHVTY87ouayRQ+pLfZak80w1j39qV35oQEd2TnU/
         26OM4ySJNM72RB5eJg7k63bskutNuM7trTMffulvLZmb68xmNNJeL5YXLmw1jKD0RIcn
         DMw2WTkwBO5P5lN/wPeb3j9iRgqrBGjCvOZTrAHqEzMyEtq/EwWYUiMZp5gWrl4i2HDM
         eqeXMdnWsa4cifVwpxFp2vbAwMlWu7yQg3BmDKVfRxCNoyfHTqULTHe8xAN1OVFUE41E
         WDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751075918; x=1751680718;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z4qJuZ+MbBlsjD8+LJUsz09T91b2pylsklhkgd6DbHw=;
        b=A4/zurHkHVo0WaPgZV5CogHCYdJwiTQ+PmPiOL4oqDwgaZ2xgVr9jLHXpE9/R0XHcp
         Fuu4rSOtyJN65JegIlhOJjP0kdUqydehUw0MNAIcZz2AoWS4v+yRrW8c01z2LxG8sAii
         Mh4joU12yotTqdvAxWnjE26PyyAsVV5cOTV3GP7g9r3oh8vxXauDTK+/gwa5q5VFnQ38
         sxT2+fnban4hUYy/QJIOIHePQMqmGxkGWr3OURBYj4CG95bYHxx8UqViGVOXQ6PhL2VA
         yJkYcbx48NmfhOZ0k3CHhS+q7L4vGggf1eqeIfBk2aOmI4KFzygC7UjGyDUIFy4ts4QC
         s+uw==
X-Forwarded-Encrypted: i=1; AJvYcCVOiQi7up15nE8t75ZgCH3N3i+NkK42wCHjwTUGiaSxjJNZj0dh5af8ITDiqHJ8LExY2mcdmKPsLJXkaDwLtX9m@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4D7r3NGmBgYZaH8FeCfBzFWpDtq1+KguvMyoG3L1s5QXSL8fk
	KfAWEt853SUh3vCNw3sGUPl6jiD2Bu82D4CpnZ8sHSX/iROfdchZQdSAlaKpl3YUU2RwUe77T5V
	e2hD3O6HABA==
X-Google-Smtp-Source: AGHT+IGGX2i9/sB5hygu9P9bHsykzcDxhWCr90CHC0OLfMZKPAKCwX2cBOpOB0xzb5YRb+RXYw28+QsuFBf6
X-Received: from plbmu16.prod.google.com ([2002:a17:903:b50:b0:234:f137:75cf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4c5:b0:234:c549:da10
 with SMTP id d9443c01a7336-23ac487f607mr82121215ad.47.1751075917662; Fri, 27
 Jun 2025 18:58:37 -0700 (PDT)
Date: Fri, 27 Jun 2025 18:58:32 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250628015832.1271229-1-irogers@google.com>
Subject: [PATCH v1] perf test annotate: Use --percent-limit rather than head
 to reduce output
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The annotate test was sped up by Thomas Richter
<tmricht@linux.ibm.com> in commit
658a8805cb60 ("perf test: Speed up test case 70 annotate basic tests")
by reducing the annotate output using head. This causes flakes on
hybrid machines where the first event dumped may not have the samples
for the test within it. Rather than reduce the output using `head`
switch to `--percent-limit 10` which will stop annotate dumping
functions that have an overhead of less than 10%, the noploop program
should be using more.

Add the missing objdump option for the pipe mode version of the
objdump with a command test.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/annotate.sh | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/perf/tests/shell/annotate.sh b/tools/perf/tests/shell/annotate.sh
index 16a1ccd06089..689de58e9238 100755
--- a/tools/perf/tests/shell/annotate.sh
+++ b/tools/perf/tests/shell/annotate.sh
@@ -53,21 +53,22 @@ test_basic() {
   # Generate the annotated output file
   if [ "x${mode}" == "xBasic" ]
   then
-    perf annotate --no-demangle -i "${perfdata}" --stdio 2> /dev/null > "${perfout}"
+    perf annotate --no-demangle -i "${perfdata}" --stdio --percent-limit 10 2> /dev/null > "${perfout}"
   else
-    perf annotate --no-demangle -i - --stdio 2> /dev/null < "${perfdata}" > "${perfout}"
+    perf annotate --no-demangle -i - --stdio 2> /dev/null --percent-limit 10 < "${perfdata}" > "${perfout}"
   fi
 
   # check if it has the target symbol
-  if ! head -250 "${perfout}" | grep -q "${testsym}"
+  if ! grep -q "${testsym}" "${perfout}"
   then
     echo "${mode} annotate [Failed: missing target symbol]"
+    cat "${perfout}"
     err=1
     return
   fi
 
   # check if it has the disassembly lines
-  if ! head -250 "${perfout}" | grep -q "${disasm_regex}"
+  if ! grep -q "${disasm_regex}" "${perfout}"
   then
     echo "${mode} annotate [Failed: missing disasm output from default disassembler]"
     err=1
@@ -92,11 +93,11 @@ test_basic() {
   # check one more with external objdump tool (forced by --objdump option)
   if [ "x${mode}" == "xBasic" ]
   then
-    perf annotate --no-demangle -i "${perfdata}" --objdump=objdump 2> /dev/null > "${perfout}"
+    perf annotate --no-demangle -i "${perfdata}" --percent-limit 10 --objdump=objdump 2> /dev/null > "${perfout}"
   else
-    perf annotate --no-demangle -i - "${testsym}" 2> /dev/null < "${perfdata}" > "${perfout}"
+    perf annotate --no-demangle -i - "${testsym}" --percent-limit 10 --objdump=objdump 2> /dev/null < "${perfdata}" > "${perfout}"
   fi
-  if ! head -250 "${perfout}" | grep -q -m 3 "${disasm_regex}"
+  if ! grep -q -m 3 "${disasm_regex}" "${perfout}"
   then
     echo "${mode} annotate [Failed: missing disasm output from non default disassembler (using --objdump)]"
     err=1
-- 
2.50.0.727.gbf7dc18ff4-goog

