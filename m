Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EC11D555
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Jun 2025 00:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750292760; cv=none; b=httBUooKh9z6i1aQxce8/PgpX+pB9uhStgynFup0Nyg5pf/SONRP5AGIaRiZdX2nRZ2z1GUZl1Z7tZhasXtaUXV8JYcxszajsSeBOr+3ksUF246ryf8Gr3OgxUslbCWAy0GvFhaOfNwud7INpC2IfEvzUYsC5p/HaDGNmDQ+miA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750292760; c=relaxed/simple;
	bh=HU1E8aM3TVhNI0cCzg9X63hUgWeXgl9SyxMRZww9RJs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=XP26ei6XFQA4t96w3yyzwypWK0KsaVmtPghLMkOGahmpFmGWo/Sf4mocnKAGqymGDO0BAZLyWcfOCz4k1xzpbmOt0Woppo4PeNJU+KeQAblxoPqDsRwDq/aiFpQkU/hfglc/iisXu5VmCgsx/TLM2mofG0OQhiXSWUgFUPUoO1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XuUgUnsd; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XuUgUnsd"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2eb60594e8so166037a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Jun 2025 17:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750292758; x=1750897558; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bz9sQ1jYIkFwDy+0Jm9AH/eJ9D8RS+YeR4yr3JjwJe0=;
        b=XuUgUnsd5uS9PWxcrJvHqGMDm75cy4amenZPC4wZE0vUy4P5QjERiJ9SQJ9OCEwmZh
         vSP9iUtr1C+K++2wQtAwhnpNKwSWj4NpkWfzlLzWVrUkZGhgx5wsKvxolV9oxvi9g+9q
         GUgJxTqKXtDN2wuMSu9Ai0coufaLPzoPMLqjj2xiH8DTlhfcAMFfHK4iMhDM+J6/Br5i
         GNb9FVGMUFRrcai3lJz9GgU8emXoMay5IJNLP0AH4bxzjn4fRjrymiEnmGGXs+NAiFlN
         FKo8wvLoK/cBb3d66xGVEP3W+UdU0t7/aENT+XCx12OM0zLUoEF2hRKMCKDms1Lc7Td/
         J8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750292758; x=1750897558;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bz9sQ1jYIkFwDy+0Jm9AH/eJ9D8RS+YeR4yr3JjwJe0=;
        b=sHkVNSX7MCNv3HxmQrCahwlChZKmLBN4WgaSGHpmd7JRqX5oGSDmmPi38WFfpb0UK8
         xH7Nd9VcEFD4o1770XBfeOmPt83YcGHa9InjnoBJkDeGEs8oQLVKNBHVnvxnfP31olVW
         DlYBP+XThtEvIjqapeTPXRCWu63+t9ZrDZW1bcoIil0wL9BVOUuj1pNwMTHlwrD1VXop
         ASmcfATYAnFxP07fBauUDoyvw3b+v9pbbhhquoxxPNBzBsY0g/wg646uXKnELFKPOaly
         S2i9iSwdi4VpR4Fekiac7rdqD+7mZcpZ6e+r64AVoedyCICwcdVkxImqocZyQNt9kmgg
         M+LA==
X-Forwarded-Encrypted: i=1; AJvYcCW00zIcqomdaj10opBSrlyr4/VACSJVyZyNEms67ZscMekQgHUWMqX3gF975MFLV4pcpDzI0nCOmfxo4uSB94ZT@vger.kernel.org
X-Gm-Message-State: AOJu0YyDpJL+pVGhHI3MDnM2S6+yAY+YGhIP6BEf/6C/Clj7RgdFfq4I
	DrG2Rb+WFL9XB/bfghYZzsc+gqfqdJl9yntfZqdNHv9bOtffQ41Yi4il7yVAwxiabhYoac6weZU
	VNVEvq2shgw==
X-Google-Smtp-Source: AGHT+IEyPukKZOVUfM8A6d07f+coolTaxEhOh98UNY0RPJ2hfefaBNkrDs16/EbZqdai7uqY6nO4GSftqohC
X-Received: from pfblj6.prod.google.com ([2002:a05:6a00:71c6:b0:746:24d7:a6aa])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:8cc6:b0:20f:94bd:eecf
 with SMTP id adf61e73a8af0-21fbd7ffb6bmr28154130637.42.1750292758445; Wed, 18
 Jun 2025 17:25:58 -0700 (PDT)
Date: Wed, 18 Jun 2025 17:25:55 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250619002555.100896-1-irogers@google.com>
Subject: [PATCH v1] perf test: Add header shell test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a shell test that sanity checks perf data and pipe mode produce
expected header fields.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/header.sh | 74 ++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100755 tools/perf/tests/shell/header.sh

diff --git a/tools/perf/tests/shell/header.sh b/tools/perf/tests/shell/header.sh
new file mode 100755
index 000000000000..813831cff0bd
--- /dev/null
+++ b/tools/perf/tests/shell/header.sh
@@ -0,0 +1,74 @@
+#!/bin/bash
+# perf header tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+err=0
+perfdata=$(mktemp /tmp/__perf_test_header.perf.data.XXXXX)
+script_output=$(mktemp /tmp/__perf_test_header.perf.data.XXXXX.script)
+
+cleanup() {
+  rm -f "${perfdata}"
+  rm -f "${perfdata}".old
+  rm -f "${script_output}"
+
+  trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+  echo "Unexpected signal in ${FUNCNAME[1]}"
+  cleanup
+  exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+check_header_output() {
+  declare -a fields=(
+    "captured"
+    "hostname"
+    "os release"
+    "arch"
+    "cpuid"
+    "nrcpus"
+    "event"
+    "cmdline"
+    "perf version"
+    "sibling (cores|dies|threads)"
+    "sibling threads"
+    "total memory"
+  )
+  for i in "${fields[@]}"
+  do
+    if ! grep -q -E "$i" "${script_output}"
+    then
+      echo "Failed to find expect $i in output"
+      err=1
+    fi
+  done
+}
+
+test_file() {
+  echo "Test perf header file"
+
+  perf record -o "${perfdata}" -g -- perf test -w noploop
+  perf report --header-only -I -i "${perfdata}" > "${script_output}"
+  check_header_output
+
+  echo "Test perf header file [Done]"
+}
+
+test_pipe() {
+  echo "Test perf header pipe"
+
+  perf record -o - -g -- perf test -w noploop | perf report --header-only -I -i - > "${script_output}"
+  check_header_output
+
+  echo "Test perf header pipe [Done]"
+}
+
+test_file
+test_pipe
+
+cleanup
+exit $err
-- 
2.50.0.rc2.701.gf1e915cc24-goog

