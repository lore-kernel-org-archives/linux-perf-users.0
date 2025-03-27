Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9C718309C
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 23:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743116463; cv=none; b=jy8lrMvQSplVcp6Hgz/fghEFeJJT9vn4a9kyEnQof5Ql3TGGZ5Hca62QhxL7uYKQENpiax3HrDKTrFyYG0y3VZSzdHIkPTOFBtyx0Oz0Uq5wEA5AEBAJHa4qOlCAeHIcti+1YQxaOv5XcJDm7Cqa+eq0JxUFVu3gwtz4NUK5C6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743116463; c=relaxed/simple;
	bh=waogitL51eHuaNon/BmGUZu6ef5FFSSmiVwnjx/u5lk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vACYMU/Osx+E1nXAJL1aReLH+GgpvzpnWxp3HQhL35I2LU+rT8q0+BM56tQiy9HS4d5jfFruptbUVXyMOkNU2WAqaFZys+HSiSENpwhlGnZKWMTKfJVne5Iza8W0PUEryIWki48QB75bwqo0Go7l0RIF2fU2oc9ypgU//7qxGd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pEXkDcWU; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pEXkDcWU"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff58318acaso4079916a91.0
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 16:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743116461; x=1743721261; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VwjNlJIwQzHOvZ74oRYXcY0TykbuQC3F2uOP0mvJUZA=;
        b=pEXkDcWUdKL1UMYgpgwSalp6OjL+HG/tfC/HxuzDHMwbnfiGVczvTscwLlyYLDzNgL
         RzDFhBCC0zmrlPZpwLm5I8XdJHrj27oJu0uhpjS6TV6INXiCB/I9hJCdtAIuoD0elZNh
         plgbAeQqbXiUP44HiGxx457bIDvvKQ/clxJhisGBOKHNv3x1oS5+YYp0R46Vc4W/3qWR
         qB+Yy7fbCvSylCHqvA+hVhaZ7jSpqQvXLUUqKkPuz0mSGAhyl6FrD3N8b6zJP9O40gXW
         FhLM4SObfxDEddsfV/MyQp/PY64la1enRRWpS95e7yd1odQxgBa4NGSBqs6j4CcsieHL
         0/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743116461; x=1743721261;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VwjNlJIwQzHOvZ74oRYXcY0TykbuQC3F2uOP0mvJUZA=;
        b=wCYu//ELj0XAuXoDPvhkmn3mF+ftHOB74BNCOCdLAxO+VAtJJMMkFxxdabvIgANG9/
         TKm1KfPKFrVomAZQ56w+pJanywmXaP8DMFvNqP9EbyKdSSMhVqyOHq4U+pbGy7BmHedM
         hZssEy/q66zxpopcscmmvoAKiLNObgWnene1uT8CHTWN4Cxb4Nw0/7HVOl0zccVPwBnj
         DwacAtwtypxFu4RgTbTeN6EIZcPCQSnISIfHBXlha5uqtpI8yDZZJH34x9E5QJhfs4K5
         bmSp1dyzDDfGpcCKMBYfWszdxOSlST6ZuLkXoZJKGDkzN7gSYSF17FDnoDJSPTB1t6zH
         RUIQ==
X-Forwarded-Encrypted: i=1; AJvYcCURXFvQwjOU2NQegUps1+Rec95l1epm/bWZceUVFHrK2mHYriuvR0nVj04uuEiQmy/iRoFC5HuzJE0SQNZbJQYw@vger.kernel.org
X-Gm-Message-State: AOJu0YzRGBjdvy5o/cNoNxX+4MqZEiNxb6q11VciKP+oyQU36yxan3Nf
	ZosQcdyjTEzh5nIVUcIafJ8CQC9rFC/lcRHxdHAVlzMLeP9sni0+Vq10wfpVouwk1cc0YmStmBC
	gQg==
X-Google-Smtp-Source: AGHT+IEJImFJpf2gC6jGlLVpvY94WlXVA/jYO/cstjWAnHq9R2xWY4MKdztDxgrVGWB7rKXNaWXsyLHhodk=
X-Received: from pjur15.prod.google.com ([2002:a17:90a:d40f:b0:301:b354:8d63])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d43:b0:2ee:fa0c:cebc
 with SMTP id 98e67ed59e1d1-303a8159f06mr7273786a91.20.1743116461541; Thu, 27
 Mar 2025 16:01:01 -0700 (PDT)
Date: Thu, 27 Mar 2025 15:48:18 -0700
In-Reply-To: <20250327225651.642965-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250327225651.642965-1-ctshao@google.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250327225651.642965-4-ctshao@google.com>
Subject: [PATCH v2 3/3] perf test: Add stat uniquifying test
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, ak@linux.intel.com, 
	howardchu95@gmail.com, linux@treblig.org, yeoreum.yun@arm.com, 
	james.clark@linaro.org, weilin.wang@intel.com, asmadeus@codewreck.org, 
	linux-perf-users@vger.kernel.org
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
2.49.0.472.ge94155a9ec-goog

