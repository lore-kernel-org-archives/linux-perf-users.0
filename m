Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04456258CFC
	for <linux-perf-users@vger.kernel.org>; Mon, 12 May 2025 22:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747087649; cv=none; b=noBLW5tIkntRDSxxxye/7jeFCY0SFz2z+VJ0Wk7sm/EVZ1fCus4xyo6APKNDpKVidIv3LREMktb9QaP5mxZ08Cf4lUc7Ygtc9feupD6KdvQCVsVANd6wxFXPz+WZNtMyZgTGgrzgarA5D/iwBj/F5Ehl1HA0bcARlKxVJINB0Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747087649; c=relaxed/simple;
	bh=59VlnNQcrQbF9VoPWx9rTK6gSiYi9D6flZRl8TqbiJY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XrX5KLc/htIcq6V+1rp1WNcZrqjVCOKNmoeqGpOd3PXa4SM3YEmjFzfkqe+dfEgKtuuC2sttFctd3xYNnU75PlgaykGoFeV6hhchYAiuSNRzDYa5iBcMeRfAQ2ro7cfBe6E7hHYqkbP2Bn3q7YQ64EbWTo7zyp/9xxWTAyJLhkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CZO49yyg; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CZO49yyg"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30a96aca21eso4978019a91.2
        for <linux-perf-users@vger.kernel.org>; Mon, 12 May 2025 15:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747087647; x=1747692447; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wxh9BxVjJTo5yVA2IRbpjDRptGFFtiq3WHv5MWVzf+Y=;
        b=CZO49yyg1mcF0ro6Otiq7ZY2WLtZAgloq6dH0u1KrxaJGSPNfcD2NXLXw3vPsF/1FJ
         Y/8V05I2PmfgmjPsi+KvqGiAELGkJtr+7mAKld0fpu8ABVn98s854yZUZK9W80neSvuj
         Hq/oYYVmzWPiJyLxFj8esNu62CFnxQG+4FJFuHq2v84zVNaoT6BtQXFjK/kFr24DdVeg
         XFkow+iECF/ffv+2pnVQHpo8HbO/gUq6ZjbU+JKyLuXej24Rwhd7NyVknjraBKSsGQmA
         D9PDmxtLUyrYNOzfENtJbHpDRtm1+jnj1pdlIKogGGp3INaPJO52+8j5n8ZHv8sLMzyf
         A3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747087647; x=1747692447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wxh9BxVjJTo5yVA2IRbpjDRptGFFtiq3WHv5MWVzf+Y=;
        b=Kh7LK6DoZGX5mvq8LQD1v3/mHST3gYhygTcK9W5MG+N6OYQCZ0n2utbGp9N9ON5yHC
         1t56BqZO+td5spDAXG+YS7GYXjEEoQUS+hu/Egb162zw1YFqYxfg6a1lSiodrA2H8xzY
         wku7Knc2FkqKy2m22Ui+STw4GL5m8sbvGb1fc9R2I5R0aeAiI61ovzDSN/+gk0BNs846
         dZ+y6VjThJ9ot6PU3FxouNsopiXq0gtoSYAs7hOlBbVCbp8zUSpzeno47DeWvdBokruk
         5438EJD2scKiTXSWZ+Vo2elC9fcVOAYoD6e3/avuRivUZzKIGu+C1agWDo/+WHHh65w5
         kGYQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9CNtBdxc9iYthCxSHlseNGXCffEOLkIO7P+rCqmTZ8djhe7n/xwiVRb20jAYXXnCY9xRAPHjgIMZZEcyxB3h5@vger.kernel.org
X-Gm-Message-State: AOJu0YyvXIE+PDnWs626scezChQNxyalx6m6Jap3QbWSNUEEenN3Dair
	tk3vxmrpxIYsQws0Uc9ezsiAQlpFPHCTP2ObQLdwrBjf48t6HIpKd200yzmL1wh1c0EyGTyr5ba
	3yw==
X-Google-Smtp-Source: AGHT+IFV0Xs8KsMWHv241dXgYHn+UHe74XFCdqWoZQtKEzUjIVnWTSM5t/SWhVxKUs6uPis7bipKFz5djTs=
X-Received: from pjbpv5.prod.google.com ([2002:a17:90b:3c85:b0:2fc:2f33:e07d])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d406:b0:30a:883a:ea5b
 with SMTP id 98e67ed59e1d1-30c3d3d9925mr27620041a91.17.1747087647297; Mon, 12
 May 2025 15:07:27 -0700 (PDT)
Date: Mon, 12 May 2025 14:50:32 -0700
In-Reply-To: <20250512215929.2098240-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250512215929.2098240-1-ctshao@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250512215929.2098240-4-ctshao@google.com>
Subject: [PATCH v3 3/3] perf test: Add stat uniquifying test
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, james.clark@linaro.org, 
	howardchu95@gmail.com, yeoreum.yun@arm.com, linux@treblig.org, 
	weilin.wang@intel.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The `stat+uniquify.sh` test retrieves all uniquified `clockticks` events
from `perf list -v clockticks` and check if `perf stat -e clockticks -A`
contains all of them.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 .../tests/shell/stat+event_uniquifying.sh     | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100755 tools/perf/tests/shell/stat+event_uniquifying.sh

diff --git a/tools/perf/tests/shell/stat+event_uniquifying.sh b/tools/perf/tests/shell/stat+event_uniquifying.sh
new file mode 100755
index 000000000000..5ec35c52b7d9
--- /dev/null
+++ b/tools/perf/tests/shell/stat+event_uniquifying.sh
@@ -0,0 +1,69 @@
+#!/bin/bash
+# perf stat events uniquifying
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+stat_output=$(mktemp /tmp/__perf_test.stat_output.XXXXX)
+perf_tool=perf
+err=0
+
+test_event_uniquifying() {
+  # We use `clockticks` to verify the uniquify behavior.
+  event="clockticks"
+
+  # If the `-A` option is added, the event should be uniquified.
+  #
+  # $perf list -v clockticks
+  #
+  # List of pre-defined events (to be used in -e or -M):
+  #
+  #   uncore_imc_0/clockticks/                           [Kernel PMU event]
+  #   uncore_imc_1/clockticks/                           [Kernel PMU event]
+  #   uncore_imc_2/clockticks/                           [Kernel PMU event]
+  #   uncore_imc_3/clockticks/                           [Kernel PMU event]
+  #   uncore_imc_4/clockticks/                           [Kernel PMU event]
+  #   uncore_imc_5/clockticks/                           [Kernel PMU event]
+  #
+  #   ...
+  #
+  # $perf stat -e clockticks -A -- true
+  #
+  #  Performance counter stats for 'system wide':
+  #
+  # CPU0            3,773,018      uncore_imc_0/clockticks/
+  # CPU0            3,609,025      uncore_imc_1/clockticks/
+  # CPU0                    0      uncore_imc_2/clockticks/
+  # CPU0            3,230,009      uncore_imc_3/clockticks/
+  # CPU0            3,049,897      uncore_imc_4/clockticks/
+  # CPU0                    0      uncore_imc_5/clockticks/
+  #
+  #        0.002029828 seconds time elapsed
+
+  echo "stat event uniquifying test"
+  uniquified_event_array=()
+
+  # Check how many uniquified events.
+  while IFS= read -r line; do
+    uniquified_event=$(echo "$line" | awk '{print $1}')
+    uniquified_event_array+=("${uniquified_event}")
+  done < <(${perf_tool} list -v ${event} | grep "\[Kernel PMU event\]")
+
+  perf_command="${perf_tool} stat -e $event -A -o ${stat_output} -- true"
+  $perf_command
+
+  # Check the output contains all uniquified events.
+  for uniquified_event in "${uniquified_event_array[@]}"; do
+    if ! cat "${stat_output}" | grep -q "${uniquified_event}"; then
+      echo "Event is not uniquified [Failed]"
+      echo "${perf_command}"
+      cat "${stat_output}"
+      err=1
+      break
+    fi
+  done
+}
+
+test_event_uniquifying
+rm -f "${stat_output}"
+exit $err
-- 
2.49.0.1045.g170613ef41-goog

