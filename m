Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372E23AD516
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 14:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016041; cv=none; b=X6bjkwUhs5oUIRd9jMYwkrpUet2J1F1jOcgc63B1/m1S9SnuI48DW27OsNjkWNLwudO06AQbBLJtdHN9KUSxCybAyYgQQRXbuv/x5kKmmM5z6E/qBPymuzg/zwQN9ZspCSvgeSFZVQWDZs+nz7nm2Xh+9DLGueOr4MQ7pY6FS08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016041; c=relaxed/simple;
	bh=JYW1wo5ab8agRdVZbjqrOWWaceuU0TjELaoVo7f/di4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mlNc0mtqwwiuydHQWsy8XUPmMZG+fkqME3XfQrNlJ7GJ4awSynxlPlxyER9zJ0BqE+lWBnjSAKPTjvuvp0Z49YCIWZ714B2yXndiNPr0Gro9D2SpQUbfiwj1VRKOkIldXCrXtWobZX07lv6jYii5DrMqJWViU9o7fLWV4+83My8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZVT4y7FP; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZVT4y7FP"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso44571455e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 07:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781016038; x=1781620838; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AWKqHsTkFl2zrGvjPzv1+aBtZDDjn0PHucQTDAlzntI=;
        b=ZVT4y7FPfDHwcPESuP3hgJquwGnxAiqX4Dt1NV9palWHOnWE21q88nYR3E+oOONyNw
         foHePUNCGGdsbeyrsUCEURfcJ7vEbeoIv7GTeTFiNbOgMoS2HuaYVSPCZEn79shoF8Gh
         NCcILF/OhrvpreZ1atWEYIRE7vz4BvXe2x5YhCNkxJWj5BMgcbdGyjHJ1BqPJTJozwoH
         73DXDRW/eQ2KLHM/4CpnVVOEVLWQkxE+UfzL2JnWz4LUqh6kxvP1/Xnnub29wmZFctwT
         vHZEkwA25U07RCU9Hm74ZxO2H3vAw6T7Yab2GCp7rUaTLn7SWHNg34joUhGzfT0UBiAZ
         /smw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781016038; x=1781620838;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AWKqHsTkFl2zrGvjPzv1+aBtZDDjn0PHucQTDAlzntI=;
        b=B+OJUTd35MHIM6zcEXdPkstu+1XWAekqWlI1kYt1WV6i6JiPyfJgH6cro2ZMRpn/L4
         7XvMfz1K0K7rool3XeL0CYpnJ9rYnLi7aS4QB8zeaUFInhh8u6BjhlOpQ10hLeL/HILs
         +l9fGJ0sy704bBB7CP1RpKCHSHMPAH27vDZ7WO+rgC668doTRdjVT6nD3nu+FYl2/RJQ
         retXpqCX+4K1kEeRGmflqGG4U96x/Vn5zjHNAlEb+vG9mRuBapCLZ6tI27zva+LKI1x/
         H+qou4hATeg0HEZ1ALeoJIxmhgIReNB4Jh5dAw36x1nL/JSaJerL/TNPjtkA+zGiu3v3
         7vIQ==
X-Forwarded-Encrypted: i=1; AFNElJ87DOKq3LfAYWzem9RPfgFNxxZS7VWFHAJ0c+Ztvk/s0g/uBAknFk97Em1XOHZbBpqNXy39rKa96MBgK5UpjY6f@vger.kernel.org
X-Gm-Message-State: AOJu0Yw83xRpIsShBh+oSJK4uoEyL5IKMUgpu/mokQNlUzWAc5eBb2oS
	RJ2R3sVZlsqkC5+6oXK6Ge5gvso7nGO+ZR9VftXiveaURst3iIx8BuqORod8XDIVf3A=
X-Gm-Gg: Acq92OEs0XTxRriC5ReLRPlefI+wBeugg6iC0UyOPSxUc09FcXLjkQTQlC2Ht2HtPwT
	kfJ5D3CgcNMK5cZ0N6Vn6J2iOMmH7nMRGtVzRcdvM6s50wfq8ODDnmi1e65GQGj9d8YY+3UjLKQ
	+L+G7AazWJKQ2584PHko+8cEnKYo80yXSkOX6I+1sIKvoc3yPIvzJ/bqyKak8miGQ6yWtl2m24F
	/lTDiPLQwVH5WC4dxktxl8hoXjqg5mySFVDqgEb0Cp2lvg7DRK1MpUURU41DrpxNN2wX8NaKMaB
	DbOFgZp1BKBKUpG4vBXCTH9yOID3li6eco/SFjfVU5LpVQ4wDE6F5Kj8NuctKHqGb8LlXV8v7dq
	wOsoDXbRMg151gtTjitBMU1GD7YECK2m04LxMCgakR1lW/EtWxpNDp2dUw3BzJnynkTAeo41VYg
	nY8H3rOoEsGPlTRWYU2myChsLMJthiKeJU46jsNCLK5EI=
X-Received: by 2002:a05:600c:3588:b0:490:4b89:5372 with SMTP id 5b1f17b1804b1-490c2cf5433mr301467195e9.11.1781016037671;
        Tue, 09 Jun 2026 07:40:37 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3c1149sm428411935e9.4.2026.06.09.07.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:40:37 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 09 Jun 2026 15:40:15 +0100
Subject: [PATCH v5 10/19] perf test cs-etm: Test decoding for concurrent
 threads test
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-james-cs-context-tracking-fix-v5-10-d53a7d096a19@linaro.org>
References: <20260609-james-cs-context-tracking-fix-v5-0-d53a7d096a19@linaro.org>
In-Reply-To: <20260609-james-cs-context-tracking-fix-v5-0-d53a7d096a19@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Amir Ayupov <aaupov@meta.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Paschalis Mpeis <Paschalis.Mpeis@arm.com>
Cc: coresight@lists.linaro.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-doc@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

The thread_loop test only looks for context IDs in the raw trace.
There's a lot more that can go wrong when decoding these, so replace it
with a test that looks at the final output for matching thread names and
symbols.

In the future we might use timestamps and context switch events to track
threads, so looking at context IDs in the raw trace wouldn't always
work.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 .../tests/shell/coresight/concurrent_threads.sh    | 45 ++++++++++++++++++++++
 .../shell/coresight/thread_loop_check_tid_10.sh    | 23 -----------
 .../shell/coresight/thread_loop_check_tid_2.sh     | 23 -----------
 3 files changed, 45 insertions(+), 46 deletions(-)

diff --git a/tools/perf/tests/shell/coresight/concurrent_threads.sh b/tools/perf/tests/shell/coresight/concurrent_threads.sh
new file mode 100755
index 000000000000..3349fff8c767
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/concurrent_threads.sh
@@ -0,0 +1,45 @@
+#!/bin/bash -e
+# CoreSight concurrent threads (exclusive)
+
+# SPDX-License-Identifier: GPL-2.0
+
+# If CoreSight is not available, skip the test
+perf list pmu | grep -q cs_etm || exit 2
+
+tmpdir=$(mktemp -d /tmp/__perf_test.coresight_concurrent_threads.XXXXX)
+
+cleanup() {
+	rm -rf "${tmpdir}"
+	trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+	cleanup
+	exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+cf="$tmpdir/ctl"
+af="$tmpdir/ack"
+mkfifo "$cf" "$af"
+
+nthreads=10
+
+# Timestamps off to reduce trace size, start disabled and use the control FIFO
+# to only record the workload and not startup.
+perf record -o "$tmpdir/data" -e cs_etm/timestamp=0/u -D -1 --control fifo:"$cf","$af" \
+	-- perf test --record-ctl fifo:"$cf","$af" -w named_threads $nthreads 1 > /dev/null 2>&1
+
+perf script -i "$tmpdir/data" > "$tmpdir/script" 2>/dev/null
+
+# Check all threads were traced and they have the correct thread name and symbol
+for i in $(seq 1 $nthreads); do
+	if ! grep -q "thread${i} .* named_threads_thread${i}" "$tmpdir/script"; then
+		echo "Error: thread${i} missing" >&2
+		cleanup
+		exit 1
+	fi
+done
+
+cleanup
+exit 0
diff --git a/tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh b/tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh
deleted file mode 100755
index 7f43a93a2ac2..000000000000
--- a/tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh
+++ /dev/null
@@ -1,23 +0,0 @@
-#!/bin/bash -e
-# CoreSight / Thread Loop 10 Threads - Check TID (exclusive)
-
-# SPDX-License-Identifier: GPL-2.0
-# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
-
-TEST="thread_loop"
-
-# shellcheck source=../lib/coresight.sh
-. "$(dirname $0)"/../lib/coresight.sh
-
-ARGS="10 1"
-DATV="check-tid-10th"
-# shellcheck disable=SC2153
-DATA="$DATD/perf-$TEST-$DATV.data"
-STDO="$DATD/perf-$TEST-$DATV.stdout"
-
-SHOW_TID=1 perf record -s $PERFRECOPT -o "$DATA" "$BIN" $ARGS > $STDO
-
-perf_dump_aux_tid_verify "$DATA" "$STDO"
-
-err=$?
-exit $err
diff --git a/tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh b/tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh
deleted file mode 100755
index a94d2079ed06..000000000000
--- a/tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh
+++ /dev/null
@@ -1,23 +0,0 @@
-#!/bin/bash -e
-# CoreSight / Thread Loop 2 Threads - Check TID (exclusive)
-
-# SPDX-License-Identifier: GPL-2.0
-# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
-
-TEST="thread_loop"
-
-# shellcheck source=../lib/coresight.sh
-. "$(dirname $0)"/../lib/coresight.sh
-
-ARGS="2 20"
-DATV="check-tid-2th"
-# shellcheck disable=SC2153
-DATA="$DATD/perf-$TEST-$DATV.data"
-STDO="$DATD/perf-$TEST-$DATV.stdout"
-
-SHOW_TID=1 perf record -s $PERFRECOPT -o "$DATA" "$BIN" $ARGS > $STDO
-
-perf_dump_aux_tid_verify "$DATA" "$STDO"
-
-err=$?
-exit $err

-- 
2.34.1

