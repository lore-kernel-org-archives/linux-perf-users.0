Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA2D14C596
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Apr 2024 16:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712162904; cv=none; b=Y8QYk9RAnryWcgVEQXn+ZOO0BUMStVuVUGiNwP8dupW7E/GYEZ8cyTMGS7xlTnsSG1wDaT8NJ7W/DSnCni6oD/UAxzd+pzevm7aba3+tBqgC7WEp6YJbIXZMXkw5QrGX6ig7IbELXv3JFSvKzyF7o7uwHosFnMjJyWqmQ9lJttY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712162904; c=relaxed/simple;
	bh=7QcSyFABd+QKWDdwayDT4uwPwseqttv+HfSpTZlxz/E=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=BpkTXhQ3C+ce5LWXKGmSl/quTytEie264LgUgE1Lscyx7vjj/ko/fpO/ICIj1LkOXQePrgi3x4fn0fqK+Jgsb24O4qogGqvDxPZWc0UTXOuAGIBLgz3ZdTr5Xho0Ab0CcsGtEofmgjES4bnVaXC3SiNUEffNbzW8CE2MBzts8r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q6I3+8sb; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q6I3+8sb"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dd933a044baso1436655276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Apr 2024 09:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712162902; x=1712767702; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P25cDF5GUi/3IkAO8xY65FCuv4W8Vj7opMco2ZjDiJc=;
        b=q6I3+8sb5NwwL7W/b0nxkZ+QCtKVpNwBEyrqyKYu2BoV/VomnyMwvOxw+RAgeLMil3
         FH0KEOJXj4PImyO/hsbvbhnievL9/QoFzK3eMWHKM1/F/ZxDJzJuvpzLnAGPILcN9wB/
         MCbk6iL58c/3ACG7JVyw8EBuWDp31c/f8mbCpTFttY5qQQmIYhwtWxF4WBzRNbR9jaL/
         44KG03n0MM+nRvOqgG0e2Pd3SZXKyXlEGFcob6bD79nFQQ4VmjXNIQiFqyXD6uacWUsW
         KT31j8Y2miZqa++7HUbFDvcZcaMQDbjUuBIlhHcfwDquOqsfiRxGN+hjyc9IcC/uWQdk
         cH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712162902; x=1712767702;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P25cDF5GUi/3IkAO8xY65FCuv4W8Vj7opMco2ZjDiJc=;
        b=D9qWnQrewf81Gg+XONidfF/DulUwOZZl8JZBTBkFFEXzUrnVQOWpaWFOXqnfxVlbaV
         pD3jUuznMg3RcJp9PIrHoe6DtsUuS8kGf9F2IdM4NdE+lNTuuIyveIXt1xOFzwBkRIa1
         1ndY8aPLb9Vyf3ytQFEokz/Qj0igEJiF9U5gfr+x4JgV9ZOH9MVXJbjF6nF5xwBYLfSg
         k8OtIrGHivjfh8hevLjKGlcuY9p533TuDFfHoItgLlf4B6wq4HCPLWGdtwEsOfIZYz6b
         cioo0TrRNliFToNS+pdH/9uHxH+87T9igFKYs6b0Ce8XVGNHBWjmbzOgv/L8oGpaMm+M
         1dLw==
X-Forwarded-Encrypted: i=1; AJvYcCVtsWW20Trgg9Orkk1fGvxGRKXWMONgD0eNtcnR5QP8IIHQ9+kR2iRjkyfSoOUtqXTmaQ2D0zB1q+DTpOv27Ku9oP2OTJiJqf5vks8uqHHPww==
X-Gm-Message-State: AOJu0YwPuWUTv2jSqi3nbPGnfjnaX3tgD+e6ttSkWXglyGoV3vJb212J
	B0o7f07Q4HXS24rMHpw8zsykMT9Y02G/PTNX3/paMDz5kKHLz8vF7lQtPQ66eqIMpbenilm9pSi
	+6DNWUA==
X-Google-Smtp-Source: AGHT+IFvvWzP5ZlSPn2lIs5Om5+YV8aHagBDhzCc44p+4uKgLXV0tVEw0Zlqvj1qC+urG0HmrDYVE/8d6VXf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:12e:26c0:7a24:6d64])
 (user=irogers job=sendgmr) by 2002:a05:6902:18c6:b0:dbe:d0a9:2be3 with SMTP
 id ck6-20020a05690218c600b00dbed0a92be3mr42781ybb.3.1712162902250; Wed, 03
 Apr 2024 09:48:22 -0700 (PDT)
Date: Wed,  3 Apr 2024 09:48:18 -0700
Message-Id: <20240403164818.3431325-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Subject: [PATCH v1] perf test: Be more tolerant of metricgroup failures
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Previously "set -e" meant any non-zero exit code from perf stat would
cause a test failure. As a non-zero exit happens when there aren't
sufficient permissions, check for this case and make the exit code
2/skip for it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../perf/tests/shell/stat_all_metricgroups.sh | 28 +++++++++++++++----
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/shell/stat_all_metricgroups.sh b/tools/perf/tests/shell/stat_all_metricgroups.sh
index 55ef9c9ded2d..d6db192b9f18 100755
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
@@ -14,11 +12,29 @@ if ParanoidAndNotRoot 0
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
2.44.0.478.gd926399ef9-goog

